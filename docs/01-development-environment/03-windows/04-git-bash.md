# Git Bash

Git Bash es un entorno de línea de comandos que permite utilizar Bash y numerosas herramientas de estilo Unix dentro de Windows.

Habitualmente se distribuye como parte de **Git for Windows**, proporcionando una experiencia familiar para desarrolladores acostumbrados a trabajar con Terminales de Linux y macOS.

Sin embargo, Git Bash no es Linux, no reemplaza Windows y tampoco es equivalente a Windows Subsystem for Linux (WSL).

Para utilizarlo profesionalmente debemos comprender qué componentes lo forman, cómo interactúa con Windows, cómo maneja las rutas y cuáles son sus limitaciones.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder:

- Explicar qué es Git Bash y qué problema resuelve.
- Comprender su relación con Git for Windows.
- Diferenciar Git, Bash y Git Bash.
- Comprender qué papel cumple MSYS2.
- Diferenciar Git Bash, PowerShell, CMD y WSL.
- Comprender cómo Git Bash ejecuta comandos en Windows.
- Reconocer las diferencias entre rutas Windows y Unix-like.
- Identificar cómo funcionan `PATH` y las variables de entorno.
- Comprender qué son los Scripts `.sh`.
- Reconocer los problemas de compatibilidad más frecuentes.
- Comprender los riesgos de mezclar herramientas Windows y Unix-like.
- Evaluar cuándo utilizar Git Bash profesionalmente.
- Realizar una inspección segura de su entorno.

---

## 🧠 1. El problema: trabajar con herramientas Unix en Windows

Imagina que estamos siguiendo un tutorial de desarrollo web.

El instructor utiliza macOS y ejecuta:

```bash
pwd
ls
mkdir projects
cd projects
```

Después utiliza:

```bash
git status
```

Y ejecuta un Script:

```bash
./setup.sh
```

Sin embargo, nosotros estamos utilizando Windows.

Podemos realizar operaciones equivalentes desde PowerShell, pero algunos comandos y Scripts utilizan sintaxis específica de Bash.

Por ejemplo:

```bash
export NODE_ENV=development
```

En PowerShell, la sintaxis equivalente para configurar una variable de entorno en la sesión sería:

```powershell
$env:NODE_ENV = "development"
```

Aquí aparece una necesidad importante:

**Disponer de un entorno Bash dentro de Windows para trabajar con herramientas y Scripts compatibles con Bash.**

Git Bash ayuda a resolver esa necesidad.

### Modelo conceptual

```text
Developer
    ↓
Windows
    ↓
Git Bash
    ↓
Bash Commands
    ↓
Windows Processes / Compatible Utilities
```

No estamos cambiando de sistema operativo.

Estamos utilizando un entorno de compatibilidad que nos permite trabajar con muchas convenciones de Unix.

---

## 🧩 2. ¿Qué es Git Bash?

Git Bash es un entorno que combina principalmente:

- Bash como Shell.
- Herramientas de estilo Unix.
- Integración con Git for Windows.
- Una capa de compatibilidad para trabajar sobre Windows.

### ¿Qué significa Bash?

**Bash** significa *Bourne Again Shell*.

Es un Shell ampliamente utilizado en sistemas Unix-like.

Permite:

- Ejecutar comandos.
- Navegar por directorios.
- Trabajar con variables.
- Utilizar Pipes.
- Redirigir entradas y salidas.
- Ejecutar Scripts.
- Automatizar tareas.

### ¿Qué significa Git?

**Git** es un sistema de control de versiones distribuido.

Permite administrar el historial de cambios de un proyecto.

### ¿Qué significa Git Bash?

Es un entorno Bash distribuido junto con Git for Windows.

### Diferencia fundamental

```text
Git
 └── Version Control System

Bash
 └── Command Shell

Git Bash
 └── Bash Environment for Windows
```

Git y Bash cumplen responsabilidades diferentes.

**Git Bash no es una versión especial del sistema de control de versiones Git.**

---

## 🏗️ 3. ¿Qué es Git for Windows?

Git for Windows es una distribución de Git adaptada al entorno Windows.

Su objetivo es permitir utilizar Git de manera integrada con Windows.

Dependiendo de la instalación, proporciona componentes como:

- Git.
- Git Bash.
- Git GUI.
- Herramientas auxiliares.
- Integraciones con Windows.

### Modelo conceptual

```text
Git for Windows
│
├── Git
│
├── Git Bash
│
├── Git GUI
│
└── Supporting Tools
```

### ¿Necesitamos Git Bash para utilizar Git?

No.

Podemos utilizar Git desde:

```text
PowerShell
CMD
Git Bash
VS Code Terminal
```

Siempre que Git esté correctamente instalado y disponible en el entorno correspondiente.

### Ejemplo

Desde PowerShell:

```powershell
git --version
```

Desde Git Bash:

```bash
git --version
```

Ambos comandos pueden utilizar una instalación de Git for Windows.

No necesitamos instalar una copia independiente de Git para cada Shell.

---

## ⚙️ 4. ¿Cómo funciona Git Bash internamente?

Para comprender Git Bash debemos introducir un componente importante: **MSYS2**.

Git for Windows utiliza componentes basados en MSYS2 para proporcionar un entorno compatible con numerosas herramientas Unix.

MSYS2, a su vez, utiliza una capa de compatibilidad que permite ejecutar determinados programas de estilo Unix sobre Windows.

### Modelo simplificado

```text
Windows
   ↓
Git for Windows
   ↓
MSYS2-based Environment
   ↓
Bash
   ↓
Unix-like Utilities
```

### ¿Qué aporta esta capa?

Permite que determinadas herramientas utilicen convenciones familiares de Unix, como:

```bash
ls
pwd
grep
sed
```

También facilita trabajar con rutas de estilo Unix.

### ¿Git Bash incluye todo MSYS2?

No.

Git for Windows distribuye los componentes que necesita para su propio entorno.

No debemos asumir que Git Bash incluye todas las herramientas, repositorios de paquetes o capacidades de una instalación independiente de MSYS2.

### ¿Git Bash es una máquina virtual?

No.

Git Bash no necesita ejecutar una máquina virtual Linux para proporcionar sus herramientas.

### ¿Git Bash utiliza un Kernel Linux?

No.

Los procesos se ejecutan sobre Windows mediante las herramientas y capas de compatibilidad correspondientes.

---

## 🆚 5. Git Bash vs PowerShell vs CMD vs WSL

Estas herramientas pueden utilizarse desde Windows, pero no representan lo mismo.

| Herramienta | Tipo | Característica principal |
|---|---|---|
| PowerShell | Shell y lenguaje de scripting | Automatización basada en objetos |
| CMD | Command Interpreter | Compatibilidad con comandos tradicionales de Windows |
| Git Bash | Entorno Bash para Windows | Herramientas y convenciones Unix-like |
| WSL | Entorno de ejecución Linux | Ejecuta distribuciones Linux mediante integración con Windows |

### PowerShell

```text
Windows
   ↓
PowerShell
   ↓
Windows Commands / Applications
```

### Git Bash

```text
Windows
   ↓
Git Bash
   ↓
Bash / Compatible Utilities
```

### WSL

```text
Windows
   ↓
WSL 2
   ↓
Linux Kernel
   ↓
Linux Distribution
   ↓
Linux Shell
```

### Pregunta importante

**¿Cuál es mejor?**

No existe una respuesta universal.

Depende de:

- Requisitos del proyecto.
- Sistema operativo de destino.
- Scripts disponibles.
- Herramientas utilizadas.
- Restricciones corporativas.
- Preferencias del equipo.

Por ejemplo, para automatizar configuraciones propias de Windows, PowerShell puede ser una excelente opción.

Para ejecutar Scripts Bash compatibles, Git Bash puede resultar conveniente.

Para utilizar herramientas que necesitan un entorno Linux real, WSL puede ser más adecuado.

---

## 💻 6. ¿Cómo abrir Git Bash?

Si Git for Windows está instalado con Git Bash, normalmente podemos abrirlo desde el menú de inicio.

También puede estar disponible mediante opciones del menú contextual del Explorador de archivos, dependiendo de la versión y configuración.

### ¿Cómo sabemos que estamos utilizando Bash?

Podemos ejecutar:

```bash
echo "$BASH_VERSION"
```

Si estamos utilizando Bash, normalmente obtendremos información sobre su versión.

También podemos consultar:

```bash
echo "$0"
```

Este comando muestra información relacionada con cómo se invocó el Shell.

Su resultado no siempre representa una ruta absoluta al ejecutable.

### Consultar el sistema

```bash
uname -s
```

En Git Bash podemos encontrar una identificación relacionada con MSYS o MINGW.

Por ejemplo:

```text
MINGW64_NT-...
```

La salida exacta depende de la versión y del entorno.

### Precaución

Que `uname` devuelva una identificación de tipo MINGW no significa que estemos ejecutando Linux.

---

## 📁 7. File System y rutas en Git Bash

Una de las diferencias más visibles aparece en las rutas.

En Windows podemos encontrar:

```text
C:\Users\developer\Projects
```

En Git Bash podemos acceder a esa ubicación mediante una representación como:

```bash
/c/Users/developer/Projects
```

### Comparación

| Windows | Git Bash |
|---|---|
| `C:\` | `/c/` |
| `C:\Users` | `/c/Users` |
| `C:\Users\developer` | `/c/Users/developer` |
| `D:\Projects` | `/d/Projects` |

### Ejemplo

```bash
cd /c/Users/developer/Projects
```

La ruta debe existir.

### ¿Por qué utiliza estas rutas?

Porque el entorno proporciona convenciones compatibles con herramientas Unix-like.

### ¿El sistema de archivos cambió?

No.

Seguimos trabajando sobre archivos de Windows.

```text
Windows File System
        ↑
        │
Git Bash Path Representation
```

### Diferencia con WSL

WSL dispone de su propio entorno de archivos Linux y también puede acceder a unidades de Windows mediante rutas montadas.

Por ejemplo:

```text
/mnt/c/Users/developer
```

Por tanto:

```text
Git Bash → /c/Users/...

WSL → /mnt/c/Users/...
```

Son convenciones diferentes.

---

## 🧭 8. Directorio de trabajo

Git Bash permite consultar nuestro directorio actual mediante:

```bash
pwd
```

### Ejemplo

```text
/c/Users/developer/Projects
```

### Listar archivos

```bash
ls
```

### Mostrar información adicional

```bash
ls -la
```

### Cambiar de directorio

```bash
cd /c/Users/developer
```

### Volver al directorio personal

```bash
cd ~
```

### ¿Qué representa `~`?

Es una expansión de Shell que normalmente representa el directorio personal del usuario.

### Importante

La ubicación exacta del directorio personal depende de la configuración del entorno.

No debemos asumir que todos los usuarios tienen exactamente la misma estructura de directorios.

---

## 🌍 9. Environment Variables en Git Bash

Git Bash utiliza sintaxis de Bash para trabajar con variables.

### Consultar PATH

```bash
echo "$PATH"
```

### Consultar HOME

```bash
echo "$HOME"
```

### Consultar una variable

```bash
echo "$NODE_ENV"
```

### Crear una variable de Shell

```bash
PROJECT_NAME="tooling-mastery"
```

### Consultarla

```bash
echo "$PROJECT_NAME"
```

### Exportarla al entorno de procesos hijos

```bash
export PROJECT_NAME="tooling-mastery"
```

### ¿Qué hace export?

Permite que la variable forme parte del entorno heredado por procesos hijos.

### Diferencia con PowerShell

En PowerShell:

```powershell
$env:PROJECT_NAME = "tooling-mastery"
```

En Git Bash:

```bash
export PROJECT_NAME="tooling-mastery"
```

Ambas operaciones pueden establecer variables para la sesión y sus procesos hijos, pero utilizan sintaxis diferente.

---

## 🔎 10. PATH y resolución de comandos

Git Bash también utiliza `PATH` para localizar ejecutables.

### Consultar PATH

```bash
echo "$PATH"
```

### Mostrar cada entrada por separado

```bash
printf '%s\n' "$PATH" | tr ':' '\n'
```

### Buscar Git

```bash
command -v git
```

### Buscar Node.js

```bash
command -v node
```

### Buscar todas las coincidencias relevantes

```bash
type -a git
```

### ¿Qué sucede cuando ejecutamos un comando?

De forma simplificada:

```text
Command
   ↓
Bash Resolution
   ↓
Alias / Function / Builtin / Executable
   ↓
Execution
```

### Ejemplo

```bash
git --version
```

Bash resuelve el comando y ejecuta la herramienta correspondiente.

### ¿Por qué importa?

Porque podemos tener varias instalaciones de una herramienta.

Por ejemplo:

```text
Git from Git for Windows

Git from another installation
```

Debemos identificar qué ejecutable estamos utilizando.

---

## 🧰 11. Comandos Unix-like disponibles

Git Bash incluye numerosas herramientas familiares de entornos Unix.

Por ejemplo:

| Comando | Uso habitual |
|---|---|
| `pwd` | Mostrar directorio actual |
| `ls` | Listar archivos |
| `cd` | Cambiar de directorio |
| `cat` | Mostrar contenido |
| `grep` | Buscar patrones |
| `find` | Buscar archivos |
| `sed` | Transformar texto |
| `awk` | Procesar texto |
| `mkdir` | Crear directorios |
| `touch` | Crear o actualizar marcas de tiempo |
| `rm` | Eliminar archivos |
| `cp` | Copiar archivos |
| `mv` | Mover o renombrar |

### Ejemplo

```bash
ls -la
```

### Buscar texto

```bash
grep "TODO" README.md
```

Este ejemplo requiere que `README.md` exista.

### Precaución

Algunos comandos pueden modificar o eliminar archivos.

Por ejemplo:

```bash
rm
```

No debemos ejecutar operaciones destructivas sin comprender sus argumentos y efectos.

El estudio profundo de comandos, Pipes y redirecciones corresponde al módulo `02-terminal-and-shell`.

---

## 🔗 12. Pipes y redirecciones

Bash permite conectar comandos mediante Pipes.

### Ejemplo

```bash
printf '%s\n' "Git" "Node.js" "pnpm" | grep "Node"
```

### Flujo conceptual

```text
Command A
    ↓
Text Stream
    ↓
Command B
```

También podemos redirigir la salida hacia archivos.

Por ejemplo:

```bash
echo "Hello" > example.txt
```

Este comando crea o sobrescribe el archivo `example.txt`.

### Diferencia importante

En Bash, los programas conectados mediante Pipes intercambian habitualmente flujos de bytes.

En PowerShell, los Cmdlets compatibles pueden intercambiar objetos .NET.

### ¿Qué significa para nosotros?

Que no debemos asumir que todos los Pipelines se comportan de la misma manera.

---

## 📜 13. Bash Scripts (.sh)

Bash permite ejecutar instrucciones almacenadas en archivos.

Habitualmente utilizamos la extensión:

```text
.sh
```

Por ejemplo:

```text
check-environment.sh
```

### Ejemplo de Script

```bash
#!/usr/bin/env bash

echo "Development Environment"

pwd

git --version

node --version
```

### ¿Qué es Shebang?

La primera línea:

```bash
#!/usr/bin/env bash
```

es conocida como **Shebang**.

En entornos compatibles, ayuda a indicar qué intérprete debe utilizarse para ejecutar el Script.

### Ejecutar el Script

Una opción es:

```bash
bash check-environment.sh
```

Este comando invoca Bash explícitamente.

Otra posibilidad, cuando los permisos y el entorno lo permiten, es:

```bash
./check-environment.sh
```

### ¿Por qué es útil?

Porque podemos automatizar tareas repetitivas.

Por ejemplo:

```text
Check Git
Check Node.js
Check Project Directory
Display Results
```

### Importante

Que un Script tenga extensión `.sh` no garantiza que funcione en Git Bash.

Podría depender de herramientas o características exclusivas de Linux.

---

## 🧩 14. ¿Qué significa compatibilidad con Bash?

Un Script puede utilizar únicamente características del lenguaje Bash.

Por ejemplo:

```bash
name="Developer"

echo "Hello, $name"
```

Este tipo de Script suele ser sencillo de ejecutar en diferentes entornos Bash.

Sin embargo, otros Scripts dependen de utilidades del sistema operativo.

Por ejemplo:

```bash
systemctl
```

Este comando está relacionado con systemd en determinados sistemas Linux.

No forma parte de las capacidades generales que debamos esperar de Git Bash.

### Modelo conceptual

```text
Bash Script
    │
    ├── Bash Language Features
    │
    └── Operating System Dependencies
```

### Pregunta importante

**¿El Script necesita Bash o necesita Linux?**

No es lo mismo.

Un Script puede ser compatible con Bash y, aun así, requerir herramientas que no existen en Git Bash.

---

## 🟢 15. Git Bash y Node.js

Git Bash puede utilizarse para ejecutar Node.js instalado en Windows.

Por ejemplo:

```bash
node --version
```

### ¿Qué Node.js estamos ejecutando?

Debemos comprobarlo.

```bash
command -v node
```

Después:

```bash
node --version
```

### Modelo conceptual

```text
Git Bash
   ↓
Bash
   ↓
Node.js for Windows
   ↓
JavaScript Application
```

### ¿Git Bash instala Node.js?

No.

Git Bash proporciona un entorno desde el cual podemos ejecutar Node.js si está disponible.

### ¿Git Bash utiliza Node.js de Linux?

No automáticamente.

En una configuración nativa habitual, ejecutará una instalación de Node.js para Windows.

### ¿Por qué importa?

Porque algunas dependencias contienen binarios específicos del sistema operativo.

No debemos mezclar indiscriminadamente dependencias instaladas para Windows con las de un entorno Linux.

---

## 📦 16. Git Bash y Package Managers de JavaScript

Podemos ejecutar gestores de paquetes como:

```bash
npm --version
```

O:

```bash
pnpm --version
```

si están disponibles.

### Ejemplo conceptual

```text
Git Bash
   ↓
npm / pnpm
   ↓
JavaScript Project
   ↓
Project Dependencies
```

### ¿Git Bash reemplaza npm o pnpm?

No.

Cada herramienta cumple una responsabilidad diferente.

| Herramienta | Responsabilidad |
|---|---|
| Git Bash | Entorno de línea de comandos |
| Node.js | Runtime JavaScript |
| npm | Package Manager de JavaScript |
| pnpm | Package Manager de JavaScript |
| Git | Control de versiones |

### Importante

Algunos Scripts definidos en `package.json` pueden depender de sintaxis específica de Shell.

No debemos asumir que todos los Scripts se ejecutan mediante Bash solamente porque iniciamos el Package Manager desde Git Bash.

El Shell utilizado por un Package Manager para ejecutar Scripts puede depender de la plataforma y de su configuración.

Estudiaremos estas diferencias en `05-package-managers` y `06-project-metadata`.

---

## 🧱 17. Git Bash y herramientas nativas de Windows

Git Bash puede ejecutar numerosas aplicaciones nativas de Windows.

Por ejemplo:

```bash
git --version
```

```bash
node --version
```

También podemos utilizar herramientas como VS Code, si su comando está disponible:

```bash
code .
```

### ¿Qué ocurre internamente?

De manera simplificada:

```text
Git Bash
   ↓
Command Resolution
   ↓
Windows Executable
   ↓
Windows Process
```

### ¿Qué debemos considerar?

La interacción entre herramientas Unix-like y ejecutables nativos puede requerir conversiones de rutas o argumentos.

No todos los programas interpretan las rutas de la misma manera.

---

## 🛣️ 18. Path Conversion

Uno de los aspectos más importantes de Git Bash es la conversión de rutas.

Imagina que trabajamos con:

```bash
/c/Users/developer/Projects
```

Pero una aplicación nativa de Windows espera una ruta como:

```text
C:\Users\developer\Projects
```

La capa de compatibilidad puede realizar conversiones para determinados argumentos.

### ¿Por qué puede ser un problema?

Porque no todos los argumentos que parecen rutas deben convertirse.

Por ejemplo, algunas aplicaciones utilizan argumentos con `/` que tienen significados especiales.

### Ejemplo conceptual

```text
Bash Argument
      ↓
MSYS2 Argument Conversion
      ↓
Windows Native Program
```

### ¿Qué debemos aprender?

Que los errores de rutas pueden originarse en la interacción entre el Shell y un ejecutable externo.

### Herramienta útil

En entornos donde está disponible, `cygpath` permite convertir representaciones de rutas.

Por ejemplo:

```bash
cygpath -w /c/Users
```

Puede producir una ruta con formato Windows.

### Precaución

No debemos modificar globalmente el comportamiento de conversión de rutas para resolver un problema aislado.

Primero debemos identificar el comando y el argumento afectados.

---

## 📝 19. Line Endings: LF vs CRLF

Este es uno de los problemas más frecuentes al trabajar entre Windows y sistemas Unix-like.

Los archivos de texto pueden utilizar diferentes convenciones de fin de línea.

### LF

Line Feed:

```text
\n
```

### CRLF

Carriage Return + Line Feed:

```text
\r\n
```

### Comparación

| Convención | Representación | Uso habitual |
|---|---|---|
| LF | `\n` | Unix-like |
| CRLF | `\r\n` | Windows tradicional |

### ¿Por qué importa?

Porque determinados Scripts pueden fallar cuando contienen finales de línea inesperados.

Por ejemplo, un Script Bash con CRLF puede presentar errores relacionados con caracteres `\r`.

### ¿Git Bash resuelve automáticamente todos estos problemas?

No.

Debemos considerar:

- Configuración de Git.
- `.gitattributes`.
- Editor.
- Convenciones del proyecto.

### Buena práctica

Los proyectos deben definir reglas claras para los finales de línea cuando resulte necesario.

Por ejemplo, mediante `.gitattributes`.

Estudiaremos estos estándares en los módulos de Git, archivos de proyecto y configuración profesional.

---

## 🔐 20. Permisos y ejecución de Scripts

En sistemas Unix-like existe un modelo de permisos que incluye lectura, escritura y ejecución.

En Windows, el modelo de seguridad utiliza mecanismos diferentes, como permisos NTFS.

Git Bash presenta determinadas convenciones Unix-like sobre el sistema Windows.

### ¿Qué implica?

Que los permisos observados mediante:

```bash
ls -l
```

no deben interpretarse automáticamente como equivalentes a todos los mecanismos de permisos de un sistema Linux.

### Ejemplo

```bash
ls -l check-environment.sh
```

Podemos observar información sobre permisos.

### ¿Cómo ejecutar un Script?

Una opción explícita es:

```bash
bash check-environment.sh
```

Esto no depende de ejecutar directamente el archivo como programa.

### Precaución

No debemos aplicar cambios masivos de permisos sin comprender el sistema de archivos y las políticas del entorno.

---

## 🌐 21. Git Bash en entornos corporativos

En empresas podemos encontrar:

- Máquinas Windows administradas.
- Restricciones de instalación.
- VPN.
- Proxies.
- Certificados corporativos.
- Package Registries privados.
- Repositorios internos.
- Políticas de seguridad.

### Ejemplo conceptual

```text
Corporate Windows Machine
        ↓
Git Bash
        ↓
Git / Node.js / npm
        ↓
Corporate Network
        ↓
Private Registry
```

### ¿Qué debemos considerar?

Que un error de conexión no significa necesariamente que Git Bash esté mal configurado.

Podría deberse a:

```text
Network Configuration
VPN
Proxy
Certificates
Authentication
Registry Access
```

### Recomendación

No debemos desactivar verificaciones TLS, certificados ni mecanismos de autenticación como solución rápida.

Debemos identificar el componente responsable y seguir las políticas de la organización.

---

## 🧪 22. Práctica: Git Bash Environment Audit

Vamos a inspeccionar nuestro entorno sin instalar ni modificar herramientas.

### Step 1 — Identify Bash

```bash
echo "$BASH_VERSION"
```

### Step 2 — Identify Environment

```bash
uname -s
```

### Step 3 — Current Directory

```bash
pwd
```

### Step 4 — Home Directory

```bash
echo "$HOME"
```

### Step 5 — PATH

```bash
printf '%s\n' "$PATH" | tr ':' '\n'
```

### Step 6 — Git

```bash
command -v git
```

```bash
git --version
```

### Step 7 — Node.js

```bash
command -v node
```

Si está disponible:

```bash
node --version
```

### Step 8 — npm

```bash
command -v npm
```

Si está disponible:

```bash
npm --version
```

### Step 9 — Inspect Command Resolution

```bash
type -a git
```

### Step 10 — Path Conversion

Si `cygpath` está disponible:

```bash
cygpath -w "$HOME"
```

### Step 11 — Compare with PowerShell

Abre PowerShell y ejecuta:

```powershell
Get-Location
```

Después:

```powershell
Get-Command git -All
```

Y:

```powershell
$env:Path -split ';'
```

### Step 12 — Document Results

| Component | Git Bash | PowerShell |
|---|---|---|
| Shell | | |
| Current Directory | | |
| Home Directory | | |
| PATH Representation | | |
| Git Resolution | | |
| Git Version | | |
| Node.js Resolution | | |
| Node.js Version | | |

### Reflexión

Responde:

1. ¿Qué Shell estás utilizando?
2. ¿Qué entorno reporta `uname`?
3. ¿Cómo se representa tu directorio personal?
4. ¿Qué instalación de Git se utiliza?
5. ¿Node.js está disponible?
6. ¿Qué diferencias observas frente a PowerShell?
7. ¿Necesitas realmente Git Bash para tu proyecto?
8. ¿Existen Scripts Bash que debas ejecutar?

---

## 🛠️ 23. Troubleshooting: problemas frecuentes

### Problema A — Git Bash Not Available

No encontramos Git Bash.

**Posibles causas:**

- Git for Windows no está instalado.
- La instalación no incluye el componente esperado.
- Existen restricciones corporativas.
- La aplicación no aparece en el menú de inicio.

### Diagnóstico

Comprobar si Git for Windows está instalado.

También podemos verificar Git desde PowerShell:

```powershell
Get-Command git -ErrorAction SilentlyContinue
```

### Importante

Que Git funcione en PowerShell no garantiza que el acceso directo de Git Bash esté disponible.

---

### Problema B — Command Not Found

Ejecutamos:

```bash
node --version
```

Y obtenemos:

```text
bash: node: command not found
```

### Posibles causas

- Node.js no está instalado.
- No está disponible mediante `PATH`.
- Existe un conflicto de configuración.
- Un gestor de versiones no está inicializado.

### Diagnóstico

```bash
command -v node
```

```bash
echo "$PATH"
```

### Solución

Dependerá de la causa identificada.

No debemos reinstalar Node.js inmediatamente.

---

### Problema C — Script Works on Linux but Not Git Bash

Un Script funciona en Ubuntu, pero falla en Git Bash.

### Posibles causas

- Dependencia de herramientas Linux.
- Diferencias de rutas.
- Diferencias de permisos.
- Dependencias nativas.
- Suposiciones sobre el sistema operativo.

### Diagnóstico

Inspeccionar el Script.

Identificar:

```text
Bash Syntax
External Commands
File System Paths
Operating System Dependencies
```

### Solución

Podría requerir adaptar el Script o ejecutarlo en un entorno Linux real mediante WSL.

---

### Problema D — Incorrect Path

Un programa no encuentra un archivo.

### Posible causa

Estamos mezclando rutas Windows y Unix-like.

### Diagnóstico

```bash
pwd
```

```bash
ls -la
```

Si está disponible:

```bash
cygpath -w "$PWD"
```

### Solución

Utilizar la representación de ruta que espera el programa correspondiente.

---

### Problema E — Unexpected Argument Conversion

Un programa nativo de Windows interpreta incorrectamente un argumento.

### Posible causa

La conversión automática de argumentos de MSYS2.

### Diagnóstico

Identificar:

- El programa ejecutado.
- El argumento original.
- Si parece una ruta.
- Qué interpretación realiza el ejecutable.

### Solución

Consultar la documentación de Git for Windows o MSYS2 sobre conversión de argumentos.

No debemos desactivar globalmente conversiones sin comprender las consecuencias.

---

### Problema F — Script Contains CRLF

Un Script presenta errores relacionados con caracteres inesperados.

### Posible causa

Finales de línea CRLF en un Script que espera LF.

### Diagnóstico

Inspeccionar el formato del archivo desde el editor.

También podemos revisar la configuración de Git y `.gitattributes`.

### Solución

Normalizar los finales de línea según los estándares del proyecto.

---

## 🏢 24. ¿Cuándo utilizar Git Bash profesionalmente?

Git Bash puede resultar útil cuando:

- Trabajamos con Git en Windows.
- Preferimos Bash para operaciones interactivas.
- Necesitamos ejecutar Scripts Bash compatibles.
- Seguimos documentación que utiliza convenciones Unix.
- Queremos una experiencia familiar entre Windows y macOS.

### ¿Cuándo preferir PowerShell?

Cuando necesitamos:

- Automatización nativa de Windows.
- Cmdlets.
- Integración con objetos .NET.
- Administración de componentes Windows.
- Scripts corporativos de PowerShell.

### ¿Cuándo preferir WSL?

Cuando necesitamos:

- Herramientas Linux.
- Un Kernel Linux.
- Dependencias específicas de Linux.
- Un entorno de desarrollo cercano al utilizado en servidores Linux.
- Ejecutar Scripts que dependen de utilidades Linux no disponibles en Git Bash.

### Modelo de decisión

```text
What Does the Project Need?
            │
            ├── Windows Automation
            │       ↓
            │   PowerShell
            │
            ├── Bash-compatible Workflow
            │       ↓
            │   Git Bash
            │
            └── Linux Environment
                    ↓
                   WSL
```

### Recomendación

Para desarrollo web nativo en Windows, **PowerShell y Git Bash pueden coexistir perfectamente**.

No necesitamos elegir uno de manera exclusiva.

Lo importante es comprender qué entorno utiliza cada comando y evitar configuraciones innecesariamente complejas.

---

## ⚠️ 25. Errores comunes

### 1. Confundir Git Bash con Git

Git es un sistema de control de versiones; Git Bash es un entorno de Shell.

### 2. Pensar que Git Bash es Linux

No proporciona un Kernel Linux.

### 3. Pensar que Git Bash es equivalente a WSL

Utilizan arquitecturas y mecanismos diferentes.

### 4. Suponer que Git Bash incluye todas las herramientas Unix

Incluye un conjunto de herramientas, no necesariamente todas.

### 5. Pensar que Git Bash instala Node.js

Node.js debe estar disponible mediante una instalación independiente.

### 6. Mezclar rutas Windows y Unix-like sin comprenderlas

Puede producir errores de resolución.

### 7. Ignorar la conversión de argumentos

Algunos ejecutables nativos pueden recibir argumentos transformados.

### 8. Suponer que cualquier Script `.sh` funcionará

Puede depender de capacidades específicas de Linux.

### 9. Ignorar LF y CRLF

Puede afectar a Scripts y herramientas.

### 10. Confundir permisos Unix con permisos NTFS

No son modelos idénticos.

### 11. Instalar herramientas duplicadas sin una estrategia

Puede generar conflictos de versiones y resolución de comandos.

### 12. Pensar que ejecutar npm desde Git Bash garantiza que los Scripts de npm utilicen Bash

El Shell utilizado para ejecutar Scripts depende de la configuración y de la plataforma.

---

## 🧠 26. Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es Git Bash?
2. ¿Qué problema resuelve?
3. ¿Qué es Git for Windows?
4. ¿Qué diferencia existe entre Git y Bash?
5. ¿Qué papel cumple MSYS2?
6. ¿Git Bash utiliza un Kernel Linux?
7. ¿Qué diferencia existe entre Git Bash y PowerShell?
8. ¿Qué diferencia existe entre Git Bash y WSL?
9. ¿Cómo se representa `C:\Users` en Git Bash?
10. ¿Cómo se representa normalmente esa unidad dentro de WSL?
11. ¿Qué hace `pwd`?
12. ¿Qué representa `~`?
13. ¿Qué hace `export`?
14. ¿Qué responsabilidad cumple `PATH`?
15. ¿Cómo identificamos qué ejecutable se utiliza?
16. ¿Qué es un Bash Script?
17. ¿Qué es un Shebang?
18. ¿Por qué un Script Bash puede fallar en Git Bash?
19. ¿Qué es Path Conversion?
20. ¿Para qué sirve `cygpath`?
21. ¿Qué diferencia existe entre LF y CRLF?
22. ¿Git Bash administra versiones de Node.js?
23. ¿Qué debemos considerar al ejecutar npm desde Git Bash?
24. ¿Cuándo utilizarías PowerShell?
25. ¿Cuándo utilizarías Git Bash?
26. ¿Cuándo utilizarías WSL?
27. ¿Qué problemas puede generar mezclar herramientas Windows y Linux?
28. ¿Cómo inspeccionarías tu entorno antes de modificarlo?

---

## 💡 Idea clave

Git Bash permite utilizar Bash y numerosas herramientas Unix-like sobre Windows.

```text
Windows
   ↓
Git for Windows
   ↓
Git Bash
   ↓
Bash
   ↓
Unix-like Commands
```

Pero no reemplaza el sistema operativo ni proporciona un entorno Linux completo.

Su utilidad consiste en facilitar determinados flujos de trabajo compatibles con Bash, especialmente cuando trabajamos con Git y proyectos multiplataforma.

**La decisión profesional no es utilizar siempre Git Bash, PowerShell o WSL, sino comprender qué capacidades requiere nuestro proyecto y seleccionar el entorno adecuado.**

---

## 🚀 Siguiente paso

Ahora comprendemos qué es Git Bash, cómo funciona y cuáles son sus limitaciones.

El siguiente documento estará dedicado a **Windows Subsystem for Linux (WSL)**.

Estudiaremos:

- Qué problema resuelve WSL.
- Diferencias entre WSL 1 y WSL 2.
- Cómo funciona la integración Windows–Linux.
- Qué son las distribuciones Linux.
- Cómo organizar los sistemas de archivos.
- Cómo administrar herramientas y Runtimes.
- Cuándo utilizar WSL frente al desarrollo nativo.
- Buenas prácticas y problemas frecuentes.

👉 [WSL](./05-wsl.md)