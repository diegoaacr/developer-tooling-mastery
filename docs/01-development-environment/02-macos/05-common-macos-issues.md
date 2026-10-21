# Common macOS Issues

Configurar un entorno de desarrollo en macOS no significa que nunca encontraremos errores.

Incluso los desarrolladores experimentados pueden enfrentarse a problemas relacionados con instalaciones, permisos, versiones de herramientas, variables de entorno y diferencias entre arquitecturas.

La diferencia está en cómo investigamos esos problemas.

Un desarrollador puede intentar reinstalar herramientas hasta conseguir que algo funcione.

Un ingeniero con un buen modelo mental identifica primero qué componente está fallando, formula hipótesis, recopila evidencias y aplica una solución controlada.

En este documento aprenderemos a diagnosticar los problemas más habituales de un Development Environment en macOS.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder:

- Identificar las categorías más frecuentes de errores en macOS.
- Diferenciar síntomas, causas y soluciones.
- Diagnosticar problemas de resolución de comandos.
- Investigar errores de `PATH` y configuración de Zsh.
- Detectar conflictos entre instalaciones de herramientas.
- Reconocer problemas relacionados con Apple Silicon, Intel y Rosetta.
- Diagnosticar problemas con Command Line Tools y Homebrew.
- Comprender errores de permisos y cuándo no utilizar `sudo`.
- Investigar diferencias entre Terminal.app y VS Code.
- Identificar problemas relacionados con procesos y puertos.
- Aplicar un procedimiento sistemático de Troubleshooting.
- Documentar problemas y soluciones para facilitar su reproducción.

---

## 🧠 1. Troubleshooting: una habilidad de ingeniería

**Troubleshooting** es el proceso de investigar, identificar y resolver problemas en un sistema.

No consiste simplemente en probar soluciones.

Consiste en comprender qué está sucediendo.

Imagina que ejecutamos:

```bash
node --version
```

Y recibimos:

```text
zsh: command not found: node
```

Podríamos intentar instalar Node.js inmediatamente.

Pero antes debemos preguntarnos:

- ¿Node.js está instalado?
- ¿El Shell puede localizarlo?
- ¿Estamos utilizando el Shell esperado?
- ¿Existe un gestor de versiones?
- ¿Funciona en otra Terminal?
- ¿Cambió recientemente alguna configuración?

Estas preguntas nos permiten construir hipótesis.

### Síntoma vs causa

Un **síntoma** es el comportamiento observable.

Una **causa** es la condición que produce ese comportamiento.

Por ejemplo:

| Síntoma | Posible causa |
|---|---|
| `command not found` | Ejecutable no disponible en la búsqueda |
| `permission denied` | Permisos insuficientes |
| Versión inesperada | Otra instalación tiene prioridad |
| Fallo al compilar | Toolchain o dependencia incompatible |
| Puerto ocupado | Otro proceso utiliza la dirección solicitada |

Un mismo síntoma puede tener varias causas.

Por eso nunca debemos asumir que un mensaje de error identifica automáticamente su origen.

---

## 🔬 2. Nuestro método de diagnóstico

Utilizaremos un procedimiento común para investigar problemas.

```text
Problem
   ↓
1. Observe
   ↓
2. Reproduce
   ↓
3. Identify the Layer
   ↓
4. Form Hypotheses
   ↓
5. Collect Evidence
   ↓
6. Apply Minimal Fix
   ↓
7. Verify
   ↓
8. Document
```

### Step 1 — Observe

Identifica qué está fallando.

Por ejemplo:

```text
node: command not found
```

Registra el mensaje exacto.

### Step 2 — Reproduce

Comprueba si el error ocurre nuevamente bajo las mismas condiciones.

Un problema intermitente puede necesitar una estrategia diferente de investigación.

### Step 3 — Identify the Layer

Relaciona el error con nuestro modelo de Development Environment.

```text
Operating System
File System
Terminal
Shell
PATH
Runtime
Development Tool
Project Configuration
```

### Step 4 — Form Hypotheses

Formula explicaciones posibles.

Por ejemplo:

```text
Hypothesis A: Node.js is not installed.

Hypothesis B: PATH does not include Node.js.

Hypothesis C: The version manager is not initialized.
```

### Step 5 — Collect Evidence

Utiliza comandos de inspección.

```bash
command -v node
```

```zsh
type -a node
```

```bash
echo "$PATH"
```

### Step 6 — Apply Minimal Fix

Corrige únicamente el componente responsable.

Evita realizar varias modificaciones simultáneas, porque después será difícil identificar cuál resolvió el problema.

### Step 7 — Verify

Repite la operación original.

```bash
node --version
```

### Step 8 — Document

Registra la causa y la solución cuando pueda resultar útil en el futuro.

**Nuestro principio será: diagnosticar primero, modificar después.**

---

## 🧩 3. Issue 01 — Command Not Found

### Síntoma

Ejecutamos:

```bash
git --version
```

Y obtenemos:

```text
zsh: command not found: git
```

### ¿Qué significa?

El Shell no pudo resolver el comando solicitado.

### Posibles causas

1. La herramienta no está instalada.
2. El ejecutable no está disponible en `PATH`.
3. Existe una configuración incorrecta del Shell.
4. Estamos utilizando un entorno distinto.
5. Un gestor de versiones no se inicializó correctamente.

### Diagnóstico

Primero:

```bash
command -v git
```

Después:

```zsh
type -a git
```

Consultamos `PATH`:

```zsh
print -l $path
```

Si sospechamos de las herramientas de Apple:

```bash
xcode-select -p
```

Y:

```bash
git --version
```

### Interpretación

Si `command -v git` no devuelve una resolución válida, debemos investigar la disponibilidad de Git.

Si existe una ruta, pero ejecutar Git falla, el problema podría encontrarse en el ejecutable o sus dependencias.

### Solución

Dependerá de la causa confirmada.

Podría requerir:

- Instalar la herramienta.
- Corregir la configuración del Shell.
- Reparar una instalación.
- Seleccionar el entorno correcto.

**No debemos instalar otra copia de Git sin investigar la instalación existente.**

---

## 🧭 4. Issue 02 — Incorrect PATH Configuration

### Síntoma

Después de editar `.zshrc`, algunos comandos dejan de funcionar.

Por ejemplo:

```text
zsh: command not found: git
```

O:

```text
zsh: command not found: brew
```

### Posible causa

Hemos reemplazado accidentalmente `PATH`.

Por ejemplo:

```zsh
export PATH="$HOME/tools/bin"
```

Esta instrucción elimina del valor anterior los directorios que no hayamos incluido explícitamente.

### Diagnóstico

```bash
echo "$PATH"
```

En Zsh:

```zsh
print -l $path
```

Después inspeccionamos los archivos de configuración relevantes.

```bash
ls -la ~/.zprofile ~/.zshrc ~/.zshenv
```

Los archivos pueden no existir, y eso no constituye necesariamente un error.

### Solución conceptual

Si queremos agregar un directorio sin eliminar los existentes:

```zsh
export PATH="$HOME/tools/bin:$PATH"
```

Sin embargo, debemos corregir la configuración persistente que produjo el problema.

No basta con reparar temporalmente la sesión si el error reaparece al abrir otra Terminal.

### Buena práctica

Antes de modificar un archivo de configuración:

1. Inspecciona su contenido.
2. Identifica la instrucción responsable.
3. Realiza una copia de seguridad.
4. Modifica únicamente lo necesario.
5. Abre una nueva sesión.
6. Verifica el resultado.

---

## 🍺 5. Issue 03 — Homebrew Command Not Found

### Síntoma

Ejecutamos:

```bash
brew --version
```

Y obtenemos:

```text
zsh: command not found: brew
```

### Posibles causas

- Homebrew no está instalado.
- Homebrew está instalado, pero no está integrado con el Shell.
- Estamos utilizando una sesión con otra configuración.
- Existe un problema con la instalación.

### Diagnóstico

Primero:

```bash
command -v brew
```

Después podemos comprobar las ubicaciones habituales.

En Apple Silicon:

```bash
ls -l /opt/homebrew/bin/brew
```

En Intel:

```bash
ls -l /usr/local/bin/brew
```

Estas rutas son ubicaciones predeterminadas habituales, no universales.

### Caso A — Homebrew no existe

Debemos revisar los requisitos y el procedimiento oficial:

https://brew.sh/

### Caso B — Homebrew existe, pero no se encuentra

Podría faltar su inicialización en el Shell.

Por ejemplo, para una instalación estándar de Apple Silicon:

```zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Esta instrucción aplica la configuración producida por Homebrew en la sesión actual.

**No la ejecutes si no has confirmado que esa es la instalación correcta.**

### Solución persistente

Si corresponde, podemos configurar la inicialización en el archivo adecuado de Zsh.

Por ejemplo:

```text
~/.zprofile
```

La elección depende del tipo de sesión y de la configuración existente.

### Verificación

```bash
brew --version
```

```bash
brew --prefix
```

```bash
command -v brew
```

---

## 🔄 6. Issue 04 — Multiple Versions of the Same Tool

### Síntoma

Instalamos una versión nueva de Git, pero el comando continúa mostrando otra versión.

```bash
git --version
```

### Posible causa

Existen varias instalaciones.

Por ejemplo:

```text
/usr/bin/git

/opt/homebrew/bin/git
```

### Diagnóstico

```zsh
type -a git
```

Después:

```bash
command -v git
```

Y:

```bash
git --version
```

### ¿Qué debemos investigar?

- Qué ejecutable utiliza el Shell.
- Qué directorios aparecen en `PATH`.
- Qué instalación queremos utilizar.
- Si la versión actual cumple los requisitos del proyecto.

### Solución

Puede ser suficiente con corregir el orden de `PATH`.

Pero no debemos modificarlo hasta comprender qué instalación debe tener prioridad.

### Importante

Tener varias instalaciones no siempre es un problema.

El problema aparece cuando no sabemos cuál estamos utilizando o cuando seleccionamos una incompatible.

---

## 🍎 7. Issue 05 — Apple Silicon vs Intel Architecture

### Síntoma

Una herramienta no se ejecuta correctamente o utiliza un binario incompatible.

Podríamos encontrar mensajes relacionados con:

```text
Bad CPU type in executable
```

O errores específicos de compatibilidad de arquitectura.

### Contexto

En macOS podemos trabajar con:

```text
Apple Silicon → arm64

Intel → x86_64
```

### Diagnóstico inicial

```bash
uname -m
```

Pero debemos recordar que una sesión ejecutada bajo Rosetta puede informar `x86_64` en una Mac Apple Silicon.

### Identificar el Hardware

Podemos consultar:

**Apple Menu → About This Mac**

### Inspeccionar un ejecutable

Si conocemos la ruta:

```bash
file /path/to/executable
```

Por ejemplo, si `node` está disponible:

```bash
file "$(command -v node)"
```

La salida puede identificar el tipo de archivo y sus arquitecturas.

**Precaución:** cuando una ruta corresponde a un Symlink o a un ejecutable intermediario, puede ser necesario investigar el destino real antes de interpretar el resultado.

### ¿Qué es Rosetta?

Rosetta 2 es una tecnología de Apple que permite ejecutar muchas aplicaciones diseñadas para Intel en computadoras Apple Silicon.

No garantiza compatibilidad universal con cualquier software.

### Posibles soluciones

Dependiendo del problema:

- Utilizar una versión compatible con Apple Silicon.
- Verificar la arquitectura del ejecutable.
- Revisar las dependencias nativas.
- Utilizar un mecanismo de compatibilidad cuando corresponda.

### Principio

**Antes de reinstalar una herramienta, debemos comprobar que el binario sea compatible con el entorno donde se ejecuta.**

---

## 🛠️ 8. Issue 06 — Command Line Tools Problems

### Síntoma

Una herramienta necesita compilar software, pero encuentra problemas relacionados con compiladores o SDKs.

Podríamos recibir errores sobre:

- Developer Tools.
- Compilers.
- SDKs.
- Active Developer Directory.

### Diagnóstico

```bash
xcode-select -p
```

Después:

```bash
clang --version
```

Y:

```bash
xcrun --sdk macosx --show-sdk-path
```

### Posibles causas

- Command Line Tools no instaladas.
- Instalación incompleta.
- Directorio de desarrollo inválido.
- Incompatibilidad entre versiones.
- Configuración que apunta a una instalación de Xcode inexistente.

### Solución

Si confirmamos que faltan las herramientas:

```bash
xcode-select --install
```

Este comando solicita el procedimiento oficial de instalación.

Si el problema está relacionado con la selección activa, debemos investigar esa configuración antes de modificarla.

### Precaución

No debemos eliminar manualmente:

```text
/Library/Developer/CommandLineTools
```

como primer intento de reparación.

Es un directorio administrado por mecanismos de instalación de Apple.

---

## 🔐 9. Issue 07 — Permission Denied

### Síntoma

Intentamos ejecutar una operación y recibimos:

```text
Permission denied
```

### ¿Qué significa?

El proceso no dispone de los permisos necesarios para completar una operación, o existe alguna restricción aplicable.

### Posibles causas

- Permisos insuficientes sobre un archivo.
- Permisos insuficientes sobre un directorio.
- Falta de permiso de ejecución.
- Restricciones de macOS.
- Ubicación protegida.
- Propiedad incorrecta de archivos.

### Diagnóstico

Podemos inspeccionar permisos mediante:

```bash
ls -l
```

Para un archivo concreto:

```bash
ls -l filename
```

Ejemplo:

```text
-rw-r--r--  1 developer staff  1200 Oct 20 10:00 filename
```

Esta salida es ilustrativa.

### Interpretación básica

En permisos Unix:

```text
r → Read
w → Write
x → Execute
```

Los permisos se organizan en categorías como propietario, grupo y otros usuarios.

### ¿Debemos utilizar sudo?

No automáticamente.

Por ejemplo:

```bash
sudo npm install
```

no debería convertirse en una solución general para problemas de permisos en proyectos JavaScript.

Podría introducir archivos propiedad de otro usuario y complicar el entorno.

### Solución

Debemos identificar:

1. Qué operación falló.
2. Qué archivo o directorio está involucrado.
3. Qué permisos se necesitan.
4. Qué usuario ejecuta el proceso.
5. Qué mecanismo de instalación o configuración produjo el problema.

Los permisos se estudiarán con mayor profundidad en `02-terminal-and-shell`.

---

## 📁 10. Issue 08 — File or Directory Not Found

### Síntoma

Ejecutamos:

```bash
cd my-project
```

Y recibimos:

```text
cd: no such file or directory: my-project
```

### Posibles causas

- Estamos en otro directorio.
- La ruta es incorrecta.
- El directorio no existe.
- Existe una diferencia entre mayúsculas y minúsculas.
- Estamos utilizando una ruta relativa incorrecta.

### Diagnóstico

```bash
pwd
```

Después:

```bash
ls
```

Podemos inspeccionar una ubicación específica:

```bash
ls -la ~/Projects
```

Si el directorio existe.

### Relative Path vs Absolute Path

Una ruta relativa depende del directorio actual.

```text
my-project/
```

Una ruta absoluta comienza desde la raíz del sistema de archivos.

```text
/Users/developer/Projects/my-project
```

### Precaución con mayúsculas y minúsculas

El comportamiento depende del sistema de archivos y de cómo esté configurado el volumen.

Muchas instalaciones habituales de macOS utilizan APFS sin distinción de mayúsculas y minúsculas para nombres de archivos.

Pero también existen volúmenes configurados con distinción.

Por eso no debemos asumir que todos los entornos se comportan exactamente igual.

---

## 🖥️ 11. Issue 09 — Terminal.app Works but VS Code Does Not

### Síntoma

En Terminal.app:

```bash
node --version
```

funciona.

Pero en la Terminal integrada de VS Code no.

### Posibles causas

- Diferente Shell.
- Diferente tipo de sesión.
- Diferente inicialización.
- Diferente `PATH`.
- Configuración de VS Code.
- Entorno heredado de la aplicación gráfica.

### Diagnóstico comparativo

En ambas Terminales:

```bash
echo "$SHELL"
```

```bash
echo "$PATH"
```

```bash
command -v node
```

```bash
node --version
```

Si utilizamos Zsh:

```zsh
print -l $path
```

### ¿Qué buscamos?

Diferencias entre:

```text
Terminal.app
    ↓
Shell Configuration A
    ↓
PATH A
```

Y:

```text
VS Code
    ↓
Shell Configuration B
    ↓
PATH B
```

### Solución

Debemos corregir la configuración responsable.

No debemos reinstalar Node.js únicamente porque no funcione en una de las Terminales.

### Relación con los módulos posteriores

Estudiaremos este comportamiento con mayor profundidad en:

```text
02-terminal-and-shell
03-editor-and-workspace
04-runtime-management
```

---

## 📦 12. Issue 10 — Homebrew Installation Failure

### Síntoma

Ejecutamos:

```bash
brew install jq
```

Pero la instalación falla.

### Posibles causas

- Problemas de conectividad.
- Dependencias incompatibles.
- Versión de macOS no soportada.
- Problemas con Command Line Tools.
- Conflictos de archivos.
- Permisos incorrectos.
- Artefactos no disponibles.

### Diagnóstico inicial

```bash
brew --version
```

```bash
brew doctor
```

```bash
brew info jq
```

También debemos revisar el mensaje exacto de la instalación.

### ¿Qué no debemos hacer?

No debemos ejecutar indiscriminadamente:

```bash
sudo brew install jq
```

Homebrew no está diseñado para utilizarse de manera general mediante `sudo`.

### Solución

Dependerá del error concreto.

Por ejemplo, si el problema está relacionado con herramientas de compilación, debemos investigar las CLT.

Si está relacionado con conectividad, debemos comprobar la red.

Si existe un conflicto de archivos, debemos identificar qué instalación es responsable.

---

## 🌐 13. Issue 11 — Network and DNS Problems

### Síntoma

Una herramienta intenta descargar dependencias y falla.

Por ejemplo:

```text
Could not resolve host
```

O:

```text
Connection timed out
```

### Posibles causas

- Falta de conectividad.
- Problemas de DNS.
- Restricciones de red.
- Proxy corporativo.
- VPN.
- Servicio remoto no disponible.

### Diagnóstico inicial

Podemos comprobar si existe conectividad hacia un servicio conocido.

Por ejemplo:

```bash
curl -I https://brew.sh
```

Este comando realiza una solicitud HTTP de tipo HEAD.

La respuesta dependerá del servidor y de la conectividad.

### ¿Qué significa DNS?

DNS permite resolver nombres de dominio a información necesaria para establecer conexiones, como direcciones IP.

Lo estudiaremos en profundidad cuando abordemos Networking.

### Importante

Un error de descarga no implica necesariamente que Homebrew, npm o pnpm estén mal instalados.

Puede originarse en una capa de red.

### Entornos corporativos

En empresas podemos encontrar:

```text
Developer
    ↓
VPN / Proxy
    ↓
Corporate Network
    ↓
External Registry
```

Debemos seguir las políticas de red y seguridad del equipo.

No es recomendable desactivar verificaciones TLS o controles de seguridad como solución rápida.

---

## 🚦 14. Issue 12 — Port Already in Use

### Síntoma

Intentamos iniciar una aplicación y encontramos:

```text
EADDRINUSE
```

O:

```text
Address already in use
```

### ¿Qué significa?

La aplicación intenta utilizar una dirección y un puerto que no puede reservar porque ya están ocupados o existe un conflicto de enlace.

### Ejemplo

Una aplicación intenta escuchar en:

```text
localhost:3000
```

Pero otro proceso ya está utilizando ese puerto de una forma incompatible.

### Diagnóstico

En macOS podemos investigar:

```bash
lsof -nP -iTCP:3000 -sTCP:LISTEN
```

Este comando permite consultar procesos que tienen sockets TCP en estado LISTEN asociados al puerto 3000.

### ¿Qué debemos identificar?

- Proceso.
- PID.
- Usuario.
- Puerto.
- Aplicación responsable.

### ¿Debemos detener el proceso inmediatamente?

No.

Primero debemos comprobar qué proceso es y si podemos detenerlo de forma segura.

Podría pertenecer a otra aplicación que estamos utilizando.

### Posibles soluciones

- Detener correctamente el proceso anterior.
- Utilizar otro puerto permitido.
- Corregir la configuración de la aplicación.
- Revisar procesos que quedaron ejecutándose.

La gestión de procesos se estudiará con más detalle en el módulo de Terminal and Shell.

---

## 🧹 15. Issue 13 — Disk Space Problems

### Síntoma

Una instalación falla porque no existe suficiente espacio disponible.

Podríamos recibir:

```text
No space left on device
```

### Posibles causas

- Almacenamiento insuficiente.
- Cachés grandes.
- Archivos temporales.
- Dependencias de proyectos.
- Artefactos de Build.
- Archivos de aplicaciones.

### Diagnóstico

Podemos consultar el espacio disponible:

```bash
df -h
```

También podemos inspeccionar el tamaño de un directorio específico:

```bash
du -sh ~/Projects
```

Si ese directorio existe.

### Precaución

No debemos eliminar carpetas del sistema o dependencias de proyectos sin comprender su función.

Tampoco debemos ejecutar Scripts de limpieza desconocidos.

### Recomendación

Identifica primero qué consume espacio y qué puede eliminarse de manera segura.

---

## 🔄 16. Issue 14 — Problems After macOS Updates

### Síntoma

Una herramienta funcionaba antes de actualizar macOS, pero después presenta errores.

### Posibles causas

- Cambios de compatibilidad.
- Herramientas de desarrollo desactualizadas.
- Dependencias nativas incompatibles.
- Cambios en configuraciones.
- Aplicaciones que necesitan actualizaciones.

### Diagnóstico

Primero:

```bash
sw_vers
```

Después:

```bash
xcode-select -p
```

Y:

```bash
clang --version
```

Si utilizamos Homebrew:

```bash
brew doctor
```

### ¿Qué debemos investigar?

- Qué cambió.
- Qué versión de macOS utilizamos.
- Qué herramienta dejó de funcionar.
- Qué requisitos tiene esa herramienta.
- Si existe una actualización compatible.

### Principio

**No debemos reinstalar todo el Development Environment después de una actualización sin identificar primero el componente afectado.**

---

## 🧪 17. Práctica — macOS Troubleshooting Audit

Vamos a construir un diagnóstico básico de nuestro entorno.

Esta práctica utiliza comandos de inspección.

No requiere instalar, actualizar ni eliminar herramientas.

### Step 1 — Operating System

```bash
sw_vers
```

### Step 2 — Architecture

```bash
uname -m
```

### Step 3 — Shell

```bash
echo "$SHELL"
```

### Step 4 — Current Directory

```bash
pwd
```

### Step 5 — PATH

```bash
echo "$PATH"
```

### Step 6 — Git

```bash
command -v git
```

```bash
git --version
```

### Step 7 — Developer Tools

```bash
xcode-select -p
```

```bash
clang --version
```

### Step 8 — Homebrew

Si está disponible:

```bash
brew --version
```

```bash
brew --prefix
```

### Step 9 — Node.js

Si está disponible:

```bash
command -v node
```

```bash
node --version
```

### Step 10 — Disk Space

```bash
df -h
```

### Step 11 — Document Results

| Component | Result | Status |
|---|---|---|
| macOS Version | | |
| Architecture | | |
| Default Shell | | |
| PATH | | |
| Git Resolution | | |
| Git Version | | |
| Developer Tools | | |
| Clang | | |
| Homebrew | | |
| Node.js | | |
| Disk Space | | |

Utiliza estados como:

```text
Available
Not Installed
Not Required
Needs Investigation
```

No todo componente ausente representa un problema.

Por ejemplo, no necesitamos Node.js para cualquier tipo de desarrollo.

### Reflexión

Responde:

1. ¿Qué componentes están disponibles?
2. ¿Existe algún error real?
3. ¿Qué herramientas son necesarias para tus proyectos?
4. ¿Qué elementos requieren investigación?
5. ¿Qué cambios serían realmente necesarios?
6. ¿Cómo comprobarías que una solución funciona?

---

## 📝 18. Documentar problemas profesionalmente

Cuando encontramos un problema, resulta útil documentarlo.

No necesitamos escribir un informe extenso.

Basta con registrar información suficiente para comprenderlo y reproducirlo.

### Troubleshooting Report Template

```markdown
# Troubleshooting Report

## Problem

Describe the observable issue.

## Environment

- Operating System:
- Architecture:
- Shell:
- Tool:
- Tool Version:

## Expected Behavior

What should happen?

## Actual Behavior

What happened?

## Error Message

Paste the relevant error message.

## Reproduction Steps

1.
2.
3.

## Investigation

Commands executed and relevant results.

## Root Cause

Confirmed cause, if identified.

## Resolution

Changes applied.

## Verification

How the solution was validated.

## References

Relevant documentation or issue links.
```

### ¿Por qué es útil?

Porque nos permite:

- Compartir problemas con el equipo.
- Evitar investigaciones repetidas.
- Construir documentación.
- Registrar decisiones técnicas.
- Facilitar futuras configuraciones.

También debemos evitar incluir contraseñas, Tokens, claves privadas o información confidencial en estos informes.

---

## 🏢 19. Troubleshooting en equipos profesionales

Imagina que un desarrollador reporta:

> El proyecto no funciona en mi Mac.

Esta descripción es demasiado general.

Podemos mejorarla.

### Ejemplo 1

> La Terminal integrada de VS Code no encuentra `node`, pero Terminal.app sí. Ambas sesiones utilizan Zsh, aunque presentan valores diferentes de `PATH`.

### Ejemplo 2

> La instalación de una dependencia nativa falla durante la compilación. El compilador está disponible, pero la herramienta informa que no encuentra el SDK requerido.

### Ejemplo 3

> La aplicación no puede iniciar en el puerto 3000 porque existe otro proceso escuchando en ese puerto.

Estas descripciones identifican mejor el problema y permiten orientar la investigación.

### Modelo profesional

```text
Clear Problem Description
          ↓
Reproducible Steps
          ↓
Environment Information
          ↓
Evidence
          ↓
Root Cause Analysis
          ↓
Controlled Resolution
          ↓
Verification
```

El objetivo no es memorizar comandos.

Es desarrollar una metodología que podamos aplicar a cualquier herramienta.

---

## ⚠️ 20. Errores comunes durante Troubleshooting

### 1. Reinstalar inmediatamente

Podemos introducir nuevos problemas sin resolver la causa original.

### 2. Ejecutar comandos desconocidos de Internet

Una solución publicada para otro entorno puede no ser adecuada para el nuestro.

### 3. Utilizar sudo indiscriminadamente

Puede modificar archivos o permisos innecesariamente.

### 4. Cambiar varias configuraciones simultáneamente

Dificulta identificar qué cambio resolvió el problema.

### 5. Ignorar el mensaje exacto

Los detalles del error suelen contener información importante.

### 6. Confundir síntomas con causas

El componente que muestra el error no siempre es el responsable.

### 7. No verificar la solución

Que un comando termine sin error no garantiza que el problema original esté resuelto.

### 8. No considerar la arquitectura

Apple Silicon e Intel pueden tener requisitos distintos.

### 9. Ignorar diferencias entre Terminales

Las sesiones pueden utilizar configuraciones diferentes.

### 10. No documentar problemas recurrentes

El equipo puede terminar resolviendo el mismo problema repetidamente.

---

## 🧠 21. Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué significa Troubleshooting?
2. ¿Qué diferencia existe entre síntoma y causa?
3. ¿Por qué no debemos reinstalar una herramienta inmediatamente?
4. ¿Qué investigarías ante `command not found`?
5. ¿Qué investigarías si una herramienta muestra una versión inesperada?
6. ¿Qué papel cumple `PATH` en el diagnóstico?
7. ¿Qué diferencias pueden existir entre Terminal.app y VS Code?
8. ¿Qué significa `permission denied`?
9. ¿Por qué no debemos utilizar `sudo` indiscriminadamente?
10. ¿Cómo podemos comprobar la arquitectura del entorno?
11. ¿Qué es Rosetta?
12. ¿Qué investigarías ante un error de compilación?
13. ¿Qué permite comprobar `brew doctor`?
14. ¿Por qué una instalación puede fallar por problemas de red?
15. ¿Qué significa `EADDRINUSE`?
16. ¿Cómo investigarías un puerto ocupado?
17. ¿Qué comprobarías después de actualizar macOS?
18. ¿Por qué debemos aplicar cambios mínimos?
19. ¿Cómo verificamos que un problema está resuelto?
20. ¿Qué información incluirías en un Troubleshooting Report?

---

## 💡 Idea clave

Un buen Development Environment no es aquel que nunca presenta errores.

Es aquel cuyo funcionamiento comprendemos lo suficiente como para investigar sus problemas de manera sistemática.

```text
Observe
   ↓
Understand
   ↓
Investigate
   ↓
Identify Root Cause
   ↓
Apply Minimal Fix
   ↓
Verify
   ↓
Document
```

**La habilidad más importante no es conocer todos los comandos de macOS, sino comprender qué componente es responsable de cada operación y cómo obtener evidencias antes de modificarlo.**

---

## 🏁 Cierre de 02 — macOS

Con este documento completamos la sección `02-macos/`.

Hemos estudiado:

1. **macOS Development Setup** — Componentes principales y preparación del entorno.
2. **Command Line Tools** — Herramientas de desarrollo proporcionadas por Apple.
3. **Homebrew** — Administración de software mediante un Package Manager.
4. **macOS PATH Configuration** — Resolución de comandos y configuración de Zsh.
5. **Common macOS Issues** — Diagnóstico sistemático de problemas.

Ahora comprendemos cómo inspeccionar y preparar un entorno de desarrollo en macOS sin depender de instalaciones o configuraciones realizadas a ciegas.

---

## 🚀 Siguiente paso

Nuestro Repository continúa con la sección dedicada a Windows.

Estudiaremos sus particularidades, herramientas de línea de comandos, PowerShell, Git Bash y WSL.

Estas secciones son rutas específicas por sistema operativo. Si utilizas exclusivamente macOS, puedes consultarlas como material complementario y continuar posteriormente con las Best Practices.

👉 [Windows Development Setup](../03-windows/01-windows-development-setup.md)