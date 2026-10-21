# Common Terminal Issues

> **Developer Tooling Mastery 2026 — Module 02**
>
> **Topic 12:** Common Terminal Issues  
> **Level:** Beginner → Professional Foundations  
> **Prerequisites:** [11 — Cross-platform Commands](./11-cross-platform-commands.md)

---

# 1. Introduction

Durante el desarrollo de software es habitual encontrar errores como:

```text
command not found: node
```

```text
Permission denied
```

```text
EADDRINUSE: address already in use
```

```text
The system cannot find the path specified
```

También podemos encontrarnos con situaciones aparentemente inexplicables:

- Node.js funciona en una terminal, pero no en otra.
- Un comando funciona en macOS, pero falla en Windows.
- Instalamos una herramienta y el Shell no la reconoce.
- Un script funciona manualmente, pero falla en CI/CD.
- Una variable de entorno existe, pero la aplicación no la recibe.
- Un archivo existe, pero el comando indica que no puede encontrarlo.

Estos problemas no siempre están relacionados con el código de nuestra aplicación.

Pueden originarse en el sistema operativo, el Shell, el entorno de ejecución, los permisos, las rutas o la configuración del proyecto.

**El objetivo de un ingeniero no es memorizar soluciones aisladas, sino comprender cómo identificar la causa del problema.**

---

# 2. Learning Objectives

Al finalizar este documento podrás:

1. Aplicar un proceso sistemático de Troubleshooting.
2. Diferenciar síntomas, causas y soluciones.
3. Diagnosticar errores de Command Resolution.
4. Investigar problemas relacionados con PATH.
5. Identificar conflictos de versiones de herramientas.
6. Resolver errores habituales de rutas.
7. Comprender problemas de permisos.
8. Diagnosticar variables de entorno.
9. Investigar conflictos de procesos y puertos.
10. Reconocer diferencias entre Shells y plataformas.
11. Comprender errores relacionados con Scripts.
12. Aplicar buenas prácticas para solucionar problemas sin dañar el entorno.

---

# 3. The Professional Troubleshooting Mindset

Imaginemos que ejecutamos:

```bash
node --version
```

Y recibimos:

```text
command not found: node
```

Una reacción frecuente es reinstalar Node.js.

Sin embargo, ese error no demuestra necesariamente que Node.js no esté instalado.

Podría significar:

- Node.js no está instalado.
- Está instalado, pero no figura en PATH.
- El Shell no ha cargado la configuración esperada.
- Estamos utilizando otro entorno, como WSL.
- El gestor de versiones no está inicializado.
- Existe una instalación incompleta.

Reinstalar inmediatamente puede no resolver nada.

## 3.1 Troubleshooting Workflow

```text
Problem Detected
       │
       ▼
Observe the Error
       │
       ▼
Identify the Environment
       │
       ▼
Form a Hypothesis
       │
       ▼
Run a Diagnostic Check
       │
       ▼
Evaluate Evidence
       │
       ├── Hypothesis Incorrect
       │          │
       │          └── Try Another Hypothesis
       │
       ▼
Apply a Minimal Fix
       │
       ▼
Verify the Result
       │
       ▼
Document the Solution
```

## 3.2 Principio fundamental

Antes de modificar algo, debemos responder:

1. ¿Qué comando ejecuté?
2. ¿Dónde lo ejecuté?
3. ¿Qué esperaba que ocurriera?
4. ¿Qué ocurrió realmente?
5. ¿Qué información proporciona el error?

### Key Idea

**Troubleshooting es un proceso de investigación basado en evidencia, no una secuencia de intentos aleatorios.**

---

# 4. Identify Your Environment

El primer paso consiste en comprender dónde estamos ejecutando los comandos.

Debemos identificar:

- Operating System.
- Terminal Emulator.
- Shell.
- Current Working Directory.
- Runtime Version.
- Package Manager.
- Environment Variables.

## 4.1 Bash / Zsh

```bash
pwd
```

```bash
echo "$SHELL"
```

```bash
uname -s
```

La variable `SHELL` suele indicar el Shell configurado para el usuario, no necesariamente el proceso actual.

## 4.2 PowerShell

```powershell
Get-Location
```

```powershell
$PSVersionTable
```

```powershell
[System.Runtime.InteropServices.RuntimeInformation]::OSDescription
```

## 4.3 ¿Por qué importa?

Porque un mismo comando puede comportarse de manera diferente según el entorno.

### Key Idea

**No podemos diagnosticar correctamente un comando sin conocer el entorno donde se ejecuta.**

---

# 5. Issue 01 — Command Not Found

## Symptom

En Bash o Zsh:

```text
command not found: node
```

En PowerShell podemos encontrar:

```text
The term 'node' is not recognized...
```

## What Does It Mean?

El Shell no pudo resolver el nombre del comando mediante sus mecanismos habituales.

## Possible Causes

1. El programa no está instalado.
2. Su directorio no está incluido en PATH.
3. El nombre está mal escrito.
4. Estamos utilizando otro Shell.
5. El gestor de versiones no está inicializado.
6. El ejecutable no está disponible en el entorno actual.

## Diagnosis — Bash / Zsh

```bash
command -v node
```

```bash
type -a node
```

## Diagnosis — PowerShell

```powershell
Get-Command node -All
```

## Recommended Approach

Primero verificamos si el comando puede resolverse.

Después comprobamos la instalación y la configuración del entorno.

### Key Idea

**Command Not Found es un problema de resolución del comando; no demuestra por sí solo que el programa no exista en el equipo.**

---

# 6. Issue 02 — Incorrect PATH

## Symptom

Instalamos una herramienta, pero no podemos ejecutarla por su nombre.

## What Is Happening?

Recordemos:

`PATH` contiene directorios donde el entorno busca ejecutables.

## Diagnosis — Bash / Zsh

```bash
printf '%s\n' "$PATH"
```

Para visualizar las entradas individualmente:

```bash
printf '%s\n' "$PATH" | tr ':' '\n'
```

## Diagnosis — PowerShell

```powershell
$env:Path -split [IO.Path]::PathSeparator
```

## Possible Causes

- La instalación no configuró PATH.
- El Shell todavía utiliza un entorno anterior.
- Una configuración sobrescribió PATH.
- El gestor de versiones no está activo.
- Existe una ruta incorrecta.

## What Not to Do

No debemos copiar configuraciones de PATH desconocidas ni reemplazar todo su contenido sin comprender las consecuencias.

## Recommended Approach

1. Identificar dónde está instalado el programa.
2. Verificar cómo debería resolverse.
3. Revisar la configuración correspondiente.
4. Aplicar únicamente el cambio necesario.
5. Abrir una nueva sesión si corresponde.
6. Verificar nuevamente.

### Key Idea

**PATH debe diagnosticarse antes de modificarse.**

---

# 7. Issue 03 — Wrong Tool Version

## Symptom

Un proyecto requiere:

```text
Node.js 22.16.0
```

Pero ejecutamos:

```bash
node --version
```

Y obtenemos:

```text
v22.19.0
```

## What Does It Mean?

La versión activa de Node.js no coincide con la requerida.

## Possible Causes

- Existe otra instalación de Node.js.
- El gestor de versiones seleccionó otra versión.
- PATH prioriza un ejecutable diferente.
- El proyecto tiene requisitos específicos.
- La terminal no cargó la configuración esperada.

## Diagnosis

Bash/Zsh:

```bash
node --version
```

```bash
type -a node
```

PowerShell:

```powershell
node --version
```

```powershell
Get-Command node -All
```

## Professional Solution

Utilizar el gestor de versiones definido para el proyecto.

Por ejemplo:

- nvm.
- nvm-windows.
- Mise.
- Volta.

Cada herramienta tiene sus propias instrucciones y características.

### Key Idea

**Tener instalada una versión correcta no garantiza que sea la versión activa.**

---

# 8. Issue 04 — Works in One Terminal but Not Another

## Symptom

Node.js funciona en la terminal del sistema, pero no en VS Code.

O funciona en macOS, pero no dentro de una VM.

## Possible Causes

- Las terminales utilizan Shells diferentes.
- Cargan archivos de configuración distintos.
- Heredaron variables de entorno diferentes.
- VS Code estaba abierto antes de modificar PATH.
- Se ejecutan en sistemas operativos distintos.
- Una sesión utiliza un gestor de versiones diferente.

## Diagnosis

Comparar:

```bash
node --version
```

```bash
command -v node
```

```bash
echo "$PATH"
```

En PowerShell:

```powershell
node --version
```

```powershell
Get-Command node
```

```powershell
$env:Path
```

## Recommended Approach

Comparar las diferencias entre ambas sesiones antes de cambiar la configuración.

### Key Idea

**Dos ventanas de terminal no necesariamente comparten el mismo entorno de ejecución.**

---

# 9. Issue 05 — File or Directory Not Found

## Symptom

```text
No such file or directory
```

O:

```text
Cannot find path
```

## Possible Causes

- Ruta incorrecta.
- Directorio de trabajo diferente.
- Archivo inexistente.
- Error de mayúsculas y minúsculas.
- Espacios sin comillas.
- Separadores de rutas incorrectos.

## Diagnosis — Bash / Zsh

```bash
pwd
```

```bash
ls -la
```

```bash
ls -ld "./my-directory"
```

## Diagnosis — PowerShell

```powershell
Get-Location
```

```powershell
Get-ChildItem
```

```powershell
Test-Path "./my-directory"
```

## Example

Supongamos que tenemos:

```text
project/
└── src/
    └── index.js
```

Si estamos dentro de `project`, podemos ejecutar:

```bash
node src/index.js
```

Pero si estamos en otro directorio, la ruta relativa puede dejar de ser válida.

### Key Idea

**Una ruta relativa se interpreta desde un contexto; antes de corregirla debemos conocer el Current Working Directory.**

---

# 10. Issue 06 — Spaces and Special Characters in Paths

## Symptom

Un comando falla cuando una ruta contiene espacios.

Ejemplo:

```text
My Projects
```

## Incorrect Example — Bash / Zsh

```bash
cd My Projects
```

El Shell interpreta normalmente dos argumentos.

## Correct Example

```bash
cd "My Projects"
```

También:

```bash
cd My\ Projects
```

## PowerShell

```powershell
Set-Location "My Projects"
```

## Additional Considerations

Caracteres como estos pueden tener significados especiales:

```text
$
*
?
&
|
;
```

Su interpretación depende del Shell.

### Key Idea

**Las comillas forman parte de la correcta interpretación de argumentos y rutas.**

---

# 11. Issue 07 — Permission Denied

## Symptom

```text
Permission denied
```

## Possible Causes

- Falta de permisos de lectura.
- Falta de permisos de escritura.
- Falta de permiso de ejecución.
- Restricciones del sistema operativo.
- Propiedad incorrecta de archivos.
- Políticas de seguridad.

## Diagnosis — Unix-like

```bash
ls -l script.sh
```

Podemos observar permisos similares a:

```text
-rw-r--r--
```

## Example

Un Script Bash puede no tener permiso de ejecución directa.

Cuando sea apropiado y tengamos autorización:

```bash
chmod +x script.sh
```

Después:

```bash
./script.sh
```

## Important Warning

No debemos utilizar automáticamente:

```bash
sudo
```

para solucionar cualquier problema de permisos.

Tampoco debemos aplicar permisos excesivamente amplios como solución general.

### Key Idea

**Un error de permisos requiere identificar qué operación está prohibida y por qué.**

---

# 12. Issue 08 — PowerShell Execution Policy

## Symptom

PowerShell puede mostrar un mensaje indicando que un Script no puede ejecutarse debido a restricciones de ejecución.

## What Is Happening?

Windows PowerShell y PowerShell disponen de mecanismos de Execution Policy en plataformas donde corresponde.

Estas políticas influyen en la ejecución de determinados Scripts.

No equivalen a una frontera de seguridad completa.

## Diagnosis

```powershell
Get-ExecutionPolicy -List
```

## What Not to Do

No debemos cambiar indiscriminadamente las políticas del sistema para ejecutar cualquier Script.

Especialmente en equipos corporativos.

## Recommended Approach

1. Identificar qué Script está bloqueado.
2. Verificar su procedencia.
3. Comprender la política aplicada.
4. Consultar la documentación oficial.
5. Respetar las restricciones de la organización.

### Key Idea

**Las políticas de ejecución deben comprenderse y respetarse, no deshabilitarse automáticamente.**

---

# 13. Issue 09 — Environment Variable Not Available

## Symptom

Una aplicación intenta consultar:

```javascript
process.env.API_URL
```

Pero recibe:

```javascript
undefined
```

## Possible Causes

- La variable no fue definida.
- Fue definida en otra sesión.
- No fue exportada al entorno del proceso.
- El programa se inició antes de definirla.
- El archivo `.env` no se cargó.
- El nombre está mal escrito.

## Diagnosis — Bash / Zsh

```bash
printenv API_URL
```

## Diagnosis — PowerShell

```powershell
$env:API_URL
```

## Example

En Bash/Zsh:

```bash
API_URL="http://localhost:3000"
```

Esto define una variable del Shell, pero no necesariamente la exporta a los procesos hijos.

Para exportarla:

```bash
export API_URL="http://localhost:3000"
```

## Security Consideration

No debemos imprimir valores secretos en Logs compartidos ni copiarlos en conversaciones públicas.

### Key Idea

**Una variable definida en el Shell no siempre está disponible en el entorno del proceso que ejecuta nuestra aplicación.**

---

# 14. Issue 10 — Shell Configuration Not Loaded

## Symptom

Agregamos una configuración a:

```text
~/.zshrc
```

Pero el comando sigue sin funcionar.

## Possible Causes

- Estamos utilizando otro Shell.
- El archivo no corresponde a esa sesión.
- La configuración contiene errores.
- La sesión todavía no se ha reiniciado.
- El archivo se carga solamente en determinadas condiciones.

## Diagnosis

En Zsh:

```bash
echo "$ZSH_VERSION"
```

En Bash:

```bash
echo "$BASH_VERSION"
```

## Recommended Approach

Verificar primero qué Shell se está ejecutando.

Después identificar qué archivos de configuración carga esa sesión.

## Important Consideration

Los archivos de inicio de Bash y Zsh no se cargan exactamente bajo las mismas reglas.

### Key Idea

**Modificar un archivo de configuración no garantiza que todas las sesiones lo carguen automáticamente.**

---

# 15. Issue 11 — Alias or Function Conflict

## Symptom

Ejecutamos un comando, pero su comportamiento no coincide con lo esperado.

## Possible Causes

- Existe un Alias.
- Existe una función con el mismo nombre.
- Se está ejecutando otro programa.
- PATH prioriza una instalación diferente.

## Diagnosis — Bash / Zsh

```bash
type git
```

```bash
type -a git
```

## Diagnosis — PowerShell

```powershell
Get-Command git -All
```

## Example

En PowerShell:

```powershell
Get-Command ls
```

Puede mostrar que `ls` es un Alias.

## Recommended Approach

Identificar primero qué comando se está resolviendo.

### Key Idea

**El nombre que escribimos no siempre corresponde directamente al ejecutable que imaginamos.**

---

# 16. Issue 12 — Port Already in Use

## Symptom

```text
EADDRINUSE: address already in use
```

## What Does It Mean?

La aplicación no pudo utilizar el endpoint de red solicitado porque ya estaba ocupado o no podía compartirse.

## Diagnosis — macOS

```bash
lsof -nP -iTCP:3000 -sTCP:LISTEN
```

## Diagnosis — Linux

```bash
ss -ltnp '( sport = :3000 )'
```

## Diagnosis — Windows PowerShell

```powershell
Get-NetTCPConnection -LocalPort 3000 -State Listen
```

## Recommended Approach

1. Identificar el puerto.
2. Identificar el proceso.
3. Comprobar si es nuestro.
4. Decidir si detenerlo o cambiar el puerto.
5. Verificar nuevamente.

## What Not to Do

No debemos finalizar procesos desconocidos únicamente porque utilizan el puerto que queremos.

### Key Idea

**Un conflicto de puerto se diagnostica identificando el endpoint y el proceso asociado.**

---

# 17. Issue 13 — Server Runs but Cannot Be Accessed

## Symptom

La terminal muestra:

```text
Server running on port 3000
```

Pero el navegador no puede conectarse.

## Possible Causes

- Dirección incorrecta.
- Puerto incorrecto.
- Protocolo incorrecto.
- Firewall.
- Binding incorrecto.
- Servidor detenido.
- Diferencia entre Host y VM.
- Diferencia entre Host y contenedor.
- Error interno de la aplicación.

## Diagnostic Questions

1. ¿El proceso sigue activo?
2. ¿El puerto está Listening?
3. ¿La aplicación utiliza HTTP o HTTPS?
4. ¿El navegador está en el mismo entorno?
5. ¿El servidor escucha en Loopback o en otra interfaz?
6. ¿Existe una restricción de red?

## Example

```text
127.0.0.1:3000
```

No equivale necesariamente a:

```text
0.0.0.0:3000
```

en términos de Binding.

### Key Idea

**Que el servidor esté ejecutándose no significa que sea accesible desde cualquier entorno de red.**

---

# 18. Issue 14 — Script Works on macOS but Fails on Windows

## Symptom

Un script declarado en `package.json` funciona en macOS, pero falla en Windows.

Ejemplo:

```json
{
  "scripts": {
    "clean": "rm -rf dist"
  }
}
```

## Possible Causes

- Dependencia de comandos Unix.
- Sintaxis de variables de entorno.
- Diferencias de rutas.
- Diferencias de Shell.
- Dependencias nativas.
- Permisos.
- Line Endings.

## Recommended Approach

Evaluar alternativas multiplataforma.

Por ejemplo, una operación de archivos mediante Node.js:

```javascript
import { rm } from "node:fs/promises";

await rm("dist", {
  recursive: true,
  force: true,
});
```

Este código debe ejecutarse únicamente cuando conocemos y controlamos la ruta que se eliminará.

### Key Idea

**La portabilidad de un proyecto también depende de sus scripts y herramientas de desarrollo.**

---

# 19. Issue 15 — Incorrect Line Endings

## Symptom

Un Script funciona en un sistema, pero presenta errores en otro.

## Possible Cause

El archivo utiliza finales de línea incompatibles con la herramienta que lo interpreta.

## Common Formats

```text
LF
```

```text
CRLF
```

## Recommended Approach

Definir una convención en el repositorio.

Ejemplo:

```ini
root = true

[*]
end_of_line = lf
insert_final_newline = true
```

Podemos utilizar EditorConfig para ayudar a mantenerla.

También debemos revisar la configuración de Git y del editor.

### Key Idea

**Los Line Endings pueden afectar la ejecución de scripts y la consistencia del repositorio.**

---

# 20. Issue 16 — Wrong Working Directory

## Symptom

Ejecutamos:

```bash
pnpm install
```

Pero la herramienta no encuentra el proyecto esperado.

## Possible Cause

Estamos en un directorio incorrecto.

## Diagnosis

Bash/Zsh:

```bash
pwd
```

PowerShell:

```powershell
Get-Location
```

## Example

Estructura:

```text
workspace/
└── my-project/
    ├── package.json
    └── src/
```

Si estamos dentro de:

```text
workspace/
```

puede que necesitemos:

```bash
cd my-project
```

antes de ejecutar el comando.

## Professional Consideration

En Monorepos, algunas herramientas permiten ejecutar operaciones desde la raíz o seleccionar proyectos mediante opciones específicas.

Estudiaremos esos mecanismos posteriormente.

### Key Idea

**El Current Working Directory forma parte del contexto de ejecución de muchos comandos.**

---

# 21. Issue 17 — Global vs Local Tool Conflicts

## Symptom

Ejecutamos una herramienta y obtenemos una versión diferente a la esperada.

## Example

Podemos tener una herramienta instalada globalmente y otra declarada como dependencia del proyecto.

```text
Global Tool
    │
    └── Version A

Project Dependency
    │
    └── Version B
```

## Possible Causes

- PATH resuelve la versión global.
- El Package Manager utiliza la dependencia local.
- Existe una instalación duplicada.
- La terminal utiliza otro Runtime.

## Recommended Approach

Verificar:

1. Qué ejecutable se utiliza.
2. Qué versión está activa.
3. Qué versión requiere el proyecto.
4. Cómo debe ejecutarse la herramienta según su documentación.

## Example

En proyectos Node.js, los scripts de `package.json` pueden resolver ejecutables de dependencias locales.

Esto permite evitar depender de determinadas instalaciones globales.

### Key Idea

**La versión global de una herramienta no necesariamente es la versión utilizada dentro de un proyecto.**

---

# 22. Issue 18 — Package Manager Not Recognized

## Symptom

```text
pnpm: command not found
```

O un error equivalente.

## Possible Causes

- pnpm no está disponible.
- PATH no contiene el ejecutable correspondiente.
- Corepack no está preparado o habilitado según el entorno.
- La instalación de Node.js cambió.
- El gestor de versiones seleccionó otra instalación.

## Diagnosis

Bash/Zsh:

```bash
command -v pnpm
```

PowerShell:

```powershell
Get-Command pnpm -All
```

Si está disponible:

```bash
pnpm --version
```

## Recommended Approach

Consultar el mecanismo de instalación y gestión de versiones establecido por el proyecto.

No debemos instalar varias copias globales sin conocer cuál será utilizada.

### Key Idea

**Los Package Managers también dependen del entorno y de la resolución de ejecutables.**

---

# 23. Issue 19 — Command Hangs or Never Finishes

## Symptom

Ejecutamos un comando y la terminal parece no responder.

## Possible Causes

- Es un servidor de larga duración.
- Está esperando entrada.
- Está esperando una conexión.
- Está realizando una operación lenta.
- Está bloqueado.
- Está esperando un recurso.

## Example

```bash
pnpm dev
```

Normalmente inicia un servidor que debe permanecer activo.

Esto no significa que esté bloqueado.

## Diagnosis

Debemos identificar:

- Qué hace el programa.
- Si produce Logs.
- Si está esperando entrada.
- Si mantiene un proceso activo.
- Si dispone de un mecanismo de interrupción.

## Recommended Approach

No terminar inmediatamente un proceso sin comprender su propósito.

### Key Idea

**Un comando que permanece ejecutándose no necesariamente está fallando.**

---

# 24. Issue 20 — Unexpected Command Output

## Symptom

Un comando produce resultados diferentes a los esperados.

## Possible Causes

- Diferencia de versión.
- Alias.
- Variables de entorno.
- Configuración del proyecto.
- Diferencia de Shell.
- Directorio de trabajo.
- Opciones o argumentos incorrectos.

## Diagnosis

Consultar la ayuda:

```bash
command --help
```

Sustituye `command` por el ejecutable correspondiente.

En PowerShell, para Cmdlets:

```powershell
Get-Help Get-ChildItem
```

## Recommended Approach

Comparar la ejecución real con la documentación de la versión instalada.

### Key Idea

**Un resultado inesperado puede ser consecuencia de configuración o contexto, no necesariamente de un error del programa.**

---

# 25. Troubleshooting Decision Tree

Podemos construir un árbol de diagnóstico inicial.

```text
Command Failed
      │
      ▼
Does the Shell Recognize It?
      │
      ├── NO
      │    │
      │    ├── Check Installation
      │    ├── Check PATH
      │    ├── Check Version Manager
      │    └── Check Shell
      │
      └── YES
           │
           ▼
     Does It Start?
           │
           ├── NO
           │    │
           │    ├── Check Permissions
           │    ├── Check Arguments
           │    └── Check Platform
           │
           └── YES
                │
                ▼
         Does It Behave Correctly?
                │
                ├── NO
                │    │
                │    ├── Check CWD
                │    ├── Check Environment
                │    ├── Check Configuration
                │    ├── Check Versions
                │    └── Check Logs
                │
                └── YES
                     │
                     ▼
                Verify Result
```

Este árbol es una guía inicial, no un procedimiento que cubra todos los posibles errores.

---

# 26. Diagnostic Commands Cheat Sheet

| Objective | Bash / Zsh | PowerShell |
|---|---|---|
| Directorio actual | `pwd` | `Get-Location` |
| Archivos actuales | `ls -la` | `Get-ChildItem -Force` |
| PATH | `echo "$PATH"` | `$env:Path` |
| Buscar comando | `command -v node` | `Get-Command node` |
| Todas las resoluciones | `type -a node` | `Get-Command node -All` |
| Versión Node.js | `node --version` | `node --version` |
| Versión Git | `git --version` | `git --version` |
| Variable de entorno | `printenv NAME` | `$env:NAME` |
| Procesos | `ps aux` | `Get-Process` |
| Puerto TCP macOS | `lsof -nP -iTCP:3000 -sTCP:LISTEN` | — |
| Puerto TCP Linux | `ss -ltnp '( sport = :3000 )'` | — |
| Puerto TCP Windows | — | `Get-NetTCPConnection -LocalPort 3000 -State Listen` |
| Estado anterior | `$?` | `$?` / `$LASTEXITCODE` según corresponda |

**Nota:** algunas herramientas pueden no estar instaladas por defecto. Los resultados y opciones también dependen del sistema.

---

# 27. A Professional Troubleshooting Checklist

Antes de modificar configuraciones:

- [ ] He leído el mensaje de error completo.
- [ ] Identifiqué el comando exacto.
- [ ] Sé en qué directorio estoy.
- [ ] Identifiqué el sistema operativo.
- [ ] Identifiqué el Shell.
- [ ] Verifiqué la versión de la herramienta.
- [ ] Comprobé qué ejecutable se está utilizando.
- [ ] Revisé las variables de entorno relevantes.
- [ ] Comprobé permisos cuando corresponde.
- [ ] Consulté Logs o información de diagnóstico.
- [ ] Formulé una hipótesis concreta.
- [ ] Evité cambios innecesarios.
- [ ] Verifiqué el resultado después de aplicar la solución.

### Key Idea

**Un buen diagnóstico minimiza cambios y maximiza información.**

---

# 28. Practice 01 — Diagnose a Missing Command

**Objective:** practicar la resolución de comandos.

## Bash / Zsh

Ejecuta un nombre de comando inventado:

```bash
mastery-command-that-does-not-exist
```

Después:

```bash
command -v mastery-command-that-does-not-exist
```

## PowerShell

```powershell
Get-Command mastery-command-that-does-not-exist
```

## Questions

1. ¿Qué mensaje aparece?
2. ¿Qué significa?
3. ¿Cómo comprobarías si un programa está instalado?
4. ¿Qué revisarías antes de instalarlo?

---

# 29. Practice 02 — Diagnose a Wrong Directory

Crea un directorio de práctica.

Bash/Zsh:

```bash
mkdir terminal-issues-practice
cd terminal-issues-practice
```

PowerShell:

```powershell
New-Item -ItemType Directory -Path terminal-issues-practice
Set-Location terminal-issues-practice
```

Ahora intenta consultar una ruta inexistente.

Bash/Zsh:

```bash
ls missing-folder
```

PowerShell:

```powershell
Get-ChildItem missing-folder
```

## Questions

1. ¿Qué error aparece?
2. ¿Cómo identificas el directorio actual?
3. ¿Cómo compruebas si existe la ruta?
4. ¿Por qué es importante distinguir rutas absolutas y relativas?

---

# 30. Practice 03 — Compare Command Resolution

Si tienes Node.js instalado:

## Bash / Zsh

```bash
node --version
```

```bash
command -v node
```

```bash
type -a node
```

## PowerShell

```powershell
node --version
```

```powershell
Get-Command node -All
```

## Questions

1. ¿Qué versión está activa?
2. ¿Desde qué ruta se ejecuta?
3. ¿Existen varias resoluciones?
4. ¿Qué ocurriría si cambiamos la versión con un Version Manager?

---

# 31. Practice 04 — Diagnose an Environment Variable

## Bash / Zsh

Define:

```bash
MASTERY_TEST=hello
```

Consulta:

```bash
echo "$MASTERY_TEST"
```

Si tienes Node.js instalado, ejecuta:

```bash
node -e 'console.log(process.env.MASTERY_TEST)'
```

Después exporta:

```bash
export MASTERY_TEST
```

Y repite:

```bash
node -e 'console.log(process.env.MASTERY_TEST)'
```

## PowerShell

```powershell
$env:MASTERY_TEST = "hello"
```

Después:

```powershell
node -e 'console.log(process.env.MASTERY_TEST)'
```

## Questions

1. ¿Qué diferencia observas en Bash/Zsh?
2. ¿Qué significa exportar una variable?
3. ¿Por qué una aplicación puede recibir `undefined`?
4. ¿Qué relación existe con los procesos hijos?

---

# 32. Practice 05 — Analyze Real Errors

Analiza cada situación y propone primero una comprobación, no una solución inmediata.

## Case A

```text
zsh: command not found: pnpm
```

**Question:** ¿qué revisarías primero?

## Case B

```text
Error: listen EADDRINUSE: address already in use
```

**Question:** ¿cómo identificarías el proceso relacionado?

## Case C

```text
Permission denied: ./script.sh
```

**Question:** ¿qué permisos comprobarías?

## Case D

```text
Cannot find module './src/index.js'
```

**Question:** ¿cómo verificarías la ruta y el directorio actual?

## Case E

```text
node --version
v22.19.0
```

Pero el proyecto requiere:

```text
v22.16.0
```

**Question:** ¿cómo comprobarías qué instalación está activa?

## Expected Learning

Para cada error debes poder expresar:

```text
Symptom
   ↓
Possible Cause
   ↓
Diagnostic Command
   ↓
Evidence
   ↓
Minimal Fix
   ↓
Verification
```

---

# 33. Common Troubleshooting Mistakes

### Mistake 1 — Reinstall Everything

Reinstalar sin diagnosticar puede ocultar el problema original.

### Mistake 2 — Copy Unknown Commands

No debemos ejecutar soluciones desconocidas sin comprender sus efectos.

### Mistake 3 — Use sudo for Everything

Los permisos elevados no son una solución universal.

### Mistake 4 — Modify PATH Blindly

Podemos romper la resolución de otros programas.

### Mistake 5 — Ignore Tool Versions

Los proyectos pueden depender de versiones específicas.

### Mistake 6 — Ignore the Working Directory

Muchas herramientas utilizan rutas relativas.

### Mistake 7 — Confuse Shells

Una instrucción Bash puede no funcionar en PowerShell.

### Mistake 8 — Kill Unknown Processes

Podemos interrumpir servicios importantes.

### Mistake 9 — Hide Errors

Evitar mostrar errores no significa resolverlos.

### Mistake 10 — Change Multiple Things Simultaneously

Dificulta identificar qué cambio solucionó el problema.

### Mistake 11 — Share Secrets in Logs

Las variables de entorno pueden contener credenciales.

### Mistake 12 — Skip Verification

Una solución no está confirmada hasta comprobar el comportamiento esperado.

---

# 34. Knowledge Check

1. ¿Qué significa Troubleshooting?
2. ¿Cuál es la diferencia entre Symptom y Root Cause?
3. ¿Por qué no debemos reinstalar herramientas inmediatamente?
4. ¿Qué significa Command Not Found?
5. ¿Cómo investigamos PATH?
6. ¿Qué diferencia existe entre herramienta instalada y herramienta activa?
7. ¿Cómo identificamos la versión de Node.js?
8. ¿Por qué dos terminales pueden comportarse de manera diferente?
9. ¿Qué es el Current Working Directory?
10. ¿Cómo afectan las rutas relativas?
11. ¿Qué significa Permission Denied?
12. ¿Por qué debemos evitar permisos excesivos?
13. ¿Qué es Execution Policy?
14. ¿Por qué una variable de entorno puede no llegar a Node.js?
15. ¿Qué archivos de configuración utiliza Zsh?
16. ¿Qué es un Alias Conflict?
17. ¿Qué significa EADDRINUSE?
18. ¿Cómo investigamos un puerto ocupado?
19. ¿Por qué un servidor puede estar activo pero ser inaccesible?
20. ¿Por qué un Script puede fallar en Windows?
21. ¿Qué son LF y CRLF?
22. ¿Qué diferencias existen entre herramientas globales y locales?
23. ¿Por qué pnpm puede dejar de reconocerse después de cambiar Node.js?
24. ¿Qué significa que un comando permanezca ejecutándose?
25. ¿Por qué debemos verificar la solución después de aplicar cambios?

---

# 35. Learning Checklist

## Diagnostic Foundations

- [ ] Comprendo el proceso de Troubleshooting.
- [ ] Diferencio Symptom y Root Cause.
- [ ] Sé identificar el entorno.
- [ ] Puedo formular hipótesis.
- [ ] Verifico los resultados.

## Command Resolution

- [ ] Comprendo Command Not Found.
- [ ] Sé inspeccionar PATH.
- [ ] Sé identificar un ejecutable.
- [ ] Reconozco conflictos de versiones.
- [ ] Comprendo problemas de Alias.

## Filesystem and Permissions

- [ ] Sé verificar el directorio actual.
- [ ] Comprendo rutas relativas y absolutas.
- [ ] Reconozco problemas con espacios.
- [ ] Comprendo Permission Denied.
- [ ] Evito cambios de permisos innecesarios.

## Environment and Runtime

- [ ] Comprendo variables de entorno.
- [ ] Reconozco diferencias entre sesiones.
- [ ] Comprendo la configuración del Shell.
- [ ] Sé verificar la versión activa de Node.js.
- [ ] Reconozco conflictos de herramientas globales y locales.

## Processes and Networking

- [ ] Comprendo EADDRINUSE.
- [ ] Sé investigar puertos.
- [ ] Reconozco problemas de Binding.
- [ ] Comprendo por qué un servidor puede no ser accesible.

## Professional Practices

- [ ] No ejecuto comandos desconocidos.
- [ ] No modifico PATH sin diagnosticar.
- [ ] No termino procesos desconocidos.
- [ ] No comparto secretos en Logs.
- [ ] Realizo cambios mínimos.
- [ ] Documento soluciones importantes.

---

# 36. Final Mental Model

```text
Developer
    │
    ▼
Terminal
    │
    ▼
Shell
    │
    ▼
Command Resolution
    │
    ├── Alias
    ├── Function
    ├── Built-in
    └── Executable via PATH
             │
             ▼
          Process
             │
             ├── Environment Variables
             ├── Working Directory
             ├── Permissions
             ├── Runtime Version
             └── Resources
                     │
                     ▼
               Execution Result
                     │
                     ├── Success
                     └── Failure
                            │
                            ▼
                      Troubleshooting
                            │
                            ▼
                      Root Cause
                            │
                            ▼
                       Minimal Fix
                            │
                            ▼
                       Verification
```

Este modelo simplifica los mecanismos de resolución y ejecución, que pueden variar según el Shell y el sistema operativo.

Nuestro principio central es:

**Observe → Understand → Diagnose → Fix → Verify**

---

# 37. Key Takeaway

**Un desarrollador profesional no necesita conocer de memoria todas las soluciones de terminal, pero sí debe comprender cómo investigar los problemas.**

Los fundamentos estudiados en este módulo nos permiten identificar:

- Qué comando estamos ejecutando.
- Cómo lo interpreta el Shell.
- Cómo se resuelve un ejecutable.
- Qué variables recibe un proceso.
- Desde qué directorio trabaja.
- Qué permisos necesita.
- Qué recursos utiliza.
- Cómo interpretar sus errores.

Este conocimiento nos prepara para trabajar con herramientas cada vez más complejas.

---

# 38. Cierre del módulo: Terminal and Shell

Con este documento completamos el módulo:

**`02-terminal-and-shell`**

Durante este módulo hemos construido un modelo mental sobre:

### Foundations

- Diferencias entre Terminal y Shell.
- Cómo interpreta y ejecuta comandos el Shell.
- Estructura de comandos, argumentos y opciones.
- Standard Input, Standard Output y Standard Error.
- Exit Codes.
- Command Resolution.

### File System and Environment

- Navegación por el sistema de archivos.
- Rutas absolutas y relativas.
- Current Working Directory.
- Environment Variables.
- PATH.
- Shell Configuration Files.
- Aliases y Functions.

### Processes and Automation

- Program vs Process.
- PID y Parent Processes.
- Foreground y Background.
- Process Signals.
- Network Ports y Listening.
- Command Chaining.
- Pipes y Redirections.
- Command Substitution.

### Cross-platform Development

- Bash.
- Zsh.
- PowerShell.
- Git Bash.
- WSL.
- Diferencias entre macOS, Windows y Linux.
- Portabilidad de comandos y scripts.

### Best Practices

- Understand Before Executing.
- Avoid Unnecessary Global Configuration.
- Use Safe File Operations.
- Verify Command Results.
- Diagnose Before Reinstalling.
- Keep Scripts Portable.
- Protect Sensitive Environment Variables.
- Document Common Issues.

## ¿Qué deberíamos ser capaces de hacer ahora?

Explicar cómo funciona nuestra terminal y responder:

1. ¿Cuál es la diferencia entre Terminal y Shell?
2. ¿Cómo interpreta el Shell los comandos?
3. ¿Cómo encuentra el sistema un ejecutable?
4. ¿Qué diferencia existe entre una ruta absoluta y una relativa?
5. ¿Cómo funcionan las variables de entorno?
6. ¿Para qué sirve PATH?
7. ¿Qué archivos configuran nuestro Shell?
8. ¿Qué ocurre cuando ejecutamos un programa?
9. ¿Cómo identificamos y detenemos procesos?
10. ¿Qué significa que un servidor escuche en un puerto?
11. ¿Cómo conectamos comandos mediante Pipes?
12. ¿Cómo controlamos errores utilizando Exit Codes?
13. ¿Qué diferencias existen entre Bash, Zsh y PowerShell?
14. ¿Cómo escribimos comandos y scripts portables?
15. ¿Cómo diagnosticamos problemas sin modificar innecesariamente nuestro entorno?

## Modelo final

```text
Terminal and Shell
│
├── Terminal Emulator
│
├── Shell
│   ├── Bash
│   ├── Zsh
│   └── PowerShell
│
├── Command Execution
│   ├── Commands and Arguments
│   ├── Command Resolution
│   └── Exit Codes
│
├── File System
│   ├── Navigation
│   ├── Absolute and Relative Paths
│   └── Working Directory
│
├── Environment
│   ├── Environment Variables
│   ├── PATH
│   └── Shell Configuration
│
├── Processes and Ports
│   ├── PID
│   ├── Foreground and Background
│   └── Network Ports
│
├── Command Composition
│   ├── Chaining
│   ├── Pipes
│   └── Redirection
│
├── Cross-platform Compatibility
│
└── Troubleshooting
```

Este modelo nos acompañará durante todo **Developer Tooling Mastery 2026**.

---

# 🚀 Siguiente módulo

Ahora que comprendemos cómo funciona la terminal, cómo se ejecutan los comandos y cómo interactuamos con el sistema operativo, necesitamos dominar otra herramienta fundamental de nuestro entorno de desarrollo:

**Editor and Workspace.**

En el siguiente módulo profundizaremos en:

- VS Code y su arquitectura.
- Diferencias entre Code Editor e IDE.
- User Settings vs Workspace Settings.
- Configuración profesional del editor.
- Extensions y Extension Management.
- Integrated Terminal.
- IntelliSense y Language Servers.
- Debugging.
- Tasks y automatización.
- EditorConfig.
- Workspace Organization.
- Configuración compartida entre desarrolladores.
- Buenas prácticas de productividad y estandarización.

El objetivo será dejar de utilizar VS Code únicamente como una herramienta para escribir código y comenzar a comprender **cómo configurarlo, extenderlo e integrarlo con nuestro entorno para construir un espacio de trabajo profesional, productivo y reproducible**.

👉 [Editor and Workspace](../03-editor-and-workspace/README.md)