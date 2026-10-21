# Windows Development Setup

Windows es uno de los sistemas operativos más utilizados para desarrollar software, tanto en computadoras personales como en entornos corporativos.

Permite trabajar con tecnologías como JavaScript, TypeScript, Node.js, React, .NET, Python, Docker y muchas otras.

Sin embargo, preparar un entorno de desarrollo profesional en Windows requiere comprender ciertas características propias del sistema operativo.

A diferencia de macOS, donde normalmente utilizamos herramientas de tradición Unix, Windows dispone de diferentes entornos de línea de comandos, mecanismos de instalación y modelos de integración.

En este documento aprenderemos a identificar esos componentes, comprender sus responsabilidades y preparar una estrategia ordenada para trabajar profesionalmente en Windows.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué características de Windows son importantes para desarrollar software.
- Qué diferencias existen entre Windows, macOS y Linux.
- Qué es un Development Environment nativo de Windows.
- Qué son Windows Terminal, PowerShell y CMD.
- Qué responsabilidad cumple Git Bash.
- Qué es WSL y por qué existe.
- Qué son los ejecutables `.exe`, `.cmd` y `.ps1`.
- Cómo funcionan las rutas de archivos en Windows.
- Qué son las Environment Variables.
- Qué responsabilidad cumple `PATH`.
- Qué son Windows Package Managers.
- Qué relación existe entre Windows, Node.js y los gestores de versiones.
- Qué debemos considerar en equipos corporativos.
- Cómo inspeccionar nuestro entorno sin modificarlo.
- Cómo establecer una estrategia profesional de configuración.

---

## 🧠 1. El problema: desarrollar software en Windows

Imagina que acabamos de recibir una computadora Windows.

Queremos desarrollar una aplicación utilizando:

```text
React
TypeScript
Node.js
pnpm
Git
VS Code
```

Podríamos empezar descargando herramientas inmediatamente.

Pero antes debemos responder algunas preguntas:

- ¿Qué versión de Windows tenemos?
- ¿Qué arquitectura utiliza nuestra computadora?
- ¿Qué Terminal utilizaremos?
- ¿Qué Shell ejecutará nuestros comandos?
- ¿Cómo administraremos las versiones de Node.js?
- ¿Dónde guardaremos nuestros proyectos?
- ¿Necesitamos WSL?
- ¿Qué herramientas están instaladas?
- ¿Qué configuraciones dependen de nuestra cuenta de usuario?
- ¿Qué restricciones tiene nuestra computadora?

Estas preguntas nos ayudan a comprender nuestro entorno antes de modificarlo.

### Modelo conceptual

```text
Windows Development Environment
            │
            ├── Operating System
            │
            ├── File System
            │
            ├── Terminal Application
            │
            ├── Shell
            │
            ├── Development Tools
            │
            ├── Runtime
            │
            ├── Package Managers
            │
            └── Project Configuration
```

No todos los proyectos necesitan exactamente las mismas herramientas.

**El objetivo es construir un entorno compatible con nuestros proyectos, no instalar todo el software disponible.**

---

## 🪟 2. Windows como sistema operativo de desarrollo

Windows proporciona servicios y componentes fundamentales para ejecutar aplicaciones.

Entre ellos encontramos:

- Administración de procesos.
- Sistema de archivos.
- Gestión de usuarios.
- Permisos.
- Variables de entorno.
- Redes.
- Administración de memoria.
- Interfaces gráficas.
- Herramientas de línea de comandos.

Para nuestro aprendizaje, debemos distinguir entre:

**Operating System**

El sistema operativo que administra los recursos de la computadora.

**Development Environment**

El conjunto de herramientas y configuraciones que utilizamos para desarrollar software.

### Ejemplo

```text
Windows
   ↓
PowerShell
   ↓
Node.js
   ↓
pnpm
   ↓
React Project
```

Este esquema representa una posible configuración.

También podemos utilizar otras combinaciones.

Por ejemplo:

```text
Windows
   ↓
WSL
   ↓
Linux Shell
   ↓
Node.js
   ↓
React Project
```

Ambas alternativas pueden ser válidas.

La elección depende de los requisitos del proyecto.

---

## 🔍 3. Identificar nuestra versión de Windows

Antes de instalar herramientas, debemos conocer nuestro sistema operativo.

### Desde la interfaz gráfica

Podemos consultar:

**Settings → System → About**

Allí encontraremos información como:

- Edición de Windows.
- Versión.
- Arquitectura.
- Características del dispositivo.

### Utilizando winver

Podemos abrir el cuadro de ejecución mediante:

```text
Win + R
```

Después escribimos:

```text
winver
```

Windows mostrará información sobre la versión instalada.

### Desde PowerShell

Podemos ejecutar:

```powershell
Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsBuildNumber
```

Este comando consulta información del sistema.

### ¿Por qué importa?

Porque algunas herramientas requieren versiones específicas de Windows.

Por ejemplo:

- WSL.
- Docker Desktop.
- Determinadas versiones de Node.js.
- Herramientas de virtualización.
- Aplicaciones corporativas.

**Nunca debemos asumir que todas las versiones de Windows ofrecen exactamente las mismas capacidades.**

---

## 🧠 4. Arquitectura: x64 y ARM64

En Windows podemos encontrar diferentes arquitecturas de procesador.

Entre las más relevantes están:

| Arquitectura | Descripción |
|---|---|
| x64 | Arquitectura de 64 bits utilizada habitualmente por procesadores Intel y AMD |
| ARM64 | Arquitectura utilizada por determinados equipos Windows basados en ARM |

### ¿Por qué importa?

Porque algunas herramientas distribuyen ejecutables diferentes según la arquitectura.

Por ejemplo:

```text
Tool Download
      │
      ├── Windows x64
      │
      └── Windows ARM64
```

La compatibilidad también puede depender de mecanismos de emulación o de la disponibilidad de dependencias nativas.

### Comprobar arquitectura

Desde PowerShell:

```powershell
[System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture
```

Podríamos obtener:

```text
X64
```

O:

```text
Arm64
```

### Importante

Debemos distinguir la arquitectura del sistema operativo de la arquitectura de un proceso concreto.

En determinadas situaciones, una aplicación puede ejecutarse mediante mecanismos de compatibilidad.

Por eso debemos comprobar los requisitos específicos de cada herramienta.

---

## 💻 5. Windows Terminal, PowerShell y CMD

Esta es una de las distinciones más importantes de Windows.

Muchos desarrolladores utilizan estos términos como si fueran equivalentes.

Pero cumplen responsabilidades diferentes.

### Windows Terminal

**Windows Terminal** es una aplicación de Terminal.

Proporciona una interfaz para trabajar con diferentes entornos de línea de comandos.

Puede alojar sesiones de:

- PowerShell.
- Command Prompt.
- Distribuciones WSL.
- Otros perfiles configurados.

### PowerShell

**PowerShell** es un Shell y un entorno de automatización.

Permite ejecutar comandos, trabajar con objetos y escribir Scripts.

### CMD

**Command Prompt**, habitualmente asociado a `cmd.exe`, es el intérprete tradicional de comandos de Windows.

### Modelo conceptual

```text
Developer
    ↓
Windows Terminal
    ↓
Selected Shell
    ├── PowerShell
    ├── CMD
    └── WSL Shell
```

### Comparación

| Herramienta | Categoría | Responsabilidad |
|---|---|---|
| Windows Terminal | Terminal Emulator | Proporcionar una interfaz para sesiones de línea de comandos |
| PowerShell | Shell / Scripting Environment | Interpretar comandos y automatizar tareas |
| CMD | Command Interpreter | Ejecutar comandos tradicionales de Windows |

### ¿Cuál recomendamos?

Para un entorno moderno de desarrollo nativo en Windows, **PowerShell es una excelente opción como Shell principal**.

Windows Terminal proporciona una interfaz práctica para utilizarlo.

Sin embargo, la elección debe considerar los requisitos del proyecto y las políticas de la organización.

Estudiaremos Windows Terminal y PowerShell en sus propios documentos.

---

## 🐚 6. Git Bash

**Git Bash** proporciona un entorno de Shell basado en Bash y herramientas compatibles con numerosas convenciones Unix dentro de Windows.

Habitualmente se instala como parte de Git for Windows.

### ¿Por qué existe?

Porque muchos desarrolladores están familiarizados con comandos como:

```bash
ls
pwd
grep
```

Git Bash permite utilizar numerosos comandos de estilo Unix en Windows.

### Ejemplo

```text
Windows
   ↓
Git Bash
   ↓
Bash
   ↓
Git / Unix-like Utilities
```

### ¿Git Bash es Linux?

No.

Git Bash no convierte Windows en Linux.

Proporciona un entorno de compatibilidad y herramientas sobre Windows.

### ¿Cuándo puede resultar útil?

- Trabajar con Git.
- Ejecutar determinados Scripts Bash.
- Utilizar herramientas familiares de entornos Unix.
- Seguir instrucciones compatibles con Git Bash.

### Limitación importante

No todos los Scripts diseñados para Linux funcionarán correctamente en Git Bash.

Algunos dependen de capacidades específicas del Kernel Linux o de utilidades que no están disponibles.

---

## 🐧 7. Windows Subsystem for Linux (WSL)

**WSL** significa **Windows Subsystem for Linux**.

Permite utilizar distribuciones Linux dentro de Windows mediante una integración proporcionada por Microsoft.

En WSL 2, el entorno utiliza un Kernel Linux real dentro de una arquitectura de virtualización ligera.

### ¿Por qué existe?

Porque algunas herramientas y flujos de desarrollo están diseñados principalmente para Linux.

Por ejemplo:

```text
Linux Shell
Linux Package Managers
Linux Development Tools
Linux Runtime Environment
```

WSL permite trabajar con estos componentes sin sustituir Windows como sistema operativo principal.

### Modelo conceptual

```text
Windows
   ↓
WSL 2
   ↓
Linux Distribution
   ↓
Linux Shell
   ↓
Development Tools
```

### ¿WSL es obligatorio?

No.

Podemos desarrollar aplicaciones React y Node.js directamente en Windows.

WSL resulta especialmente útil cuando:

- Necesitamos un entorno Linux.
- El proyecto utiliza Scripts específicos de Linux.
- Trabajamos con herramientas que esperan comportamiento Linux.
- Queremos aproximar determinadas características del entorno de desarrollo a un despliegue Linux.

### Diferencia con Git Bash

| Característica | Git Bash | WSL 2 |
|---|---|---|
| Entorno Bash | Sí | Sí, si la distribución lo incluye |
| Kernel Linux real | No | Sí |
| Gestor de paquetes Linux | No como entorno Linux completo | Sí, según distribución |
| Ejecución de herramientas Linux | Limitada por compatibilidad | Sí, según distribución |
| Integración con Windows | Sí | Sí |

Estudiaremos WSL con mayor profundidad en `05-wsl.md`.

---

## 🗂️ 8. File System en Windows

Windows utiliza habitualmente rutas con letras de unidad.

Por ejemplo:

```text
C:\Users\developer\Projects\my-app
```

Podemos representarlo así:

```text
C:\
└── Users\
    └── developer\
        └── Projects\
            └── my-app\
```

### Diferencia con macOS

En macOS podríamos encontrar:

```text
/Users/developer/Projects/my-app
```

En Windows:

```text
C:\Users\developer\Projects\my-app
```

### Path Separators

Windows utiliza tradicionalmente:

```text
\
```

Como separador de directorios.

En entornos Unix-like se utiliza:

```text
/
```

### Importante

Muchas herramientas modernas admiten diferentes representaciones de rutas.

Pero no debemos asumir que cualquier Script funciona de manera idéntica entre sistemas operativos.

### Ejemplo

Un Script Bash que utiliza rutas Unix puede necesitar adaptación para PowerShell.

Esto no significa que uno de los sistemas sea incorrecto.

Significa que utilizan convenciones y herramientas diferentes.

---

## 📁 9. ¿Dónde guardar nuestros proyectos?

Una organización sencilla podría ser:

```text
C:\Users\developer\Projects\
│
├── learning\
├── personal\
└── work\
```

También podemos utilizar:

```text
C:\Dev\
```

Siempre que tengamos permisos adecuados y sea una ubicación permitida.

### Recomendaciones

- Utiliza directorios fáciles de identificar.
- Evita guardar proyectos personales en directorios protegidos del sistema.
- No trabajes innecesariamente con privilegios de administrador.
- Considera las políticas corporativas.
- Evita rutas excesivamente complejas cuando sea posible.

### ¿Y si utilizamos WSL?

En WSL, para proyectos que ejecutaremos principalmente mediante herramientas Linux, normalmente conviene trabajar dentro del sistema de archivos Linux.

Por ejemplo:

```text
/home/developer/projects/my-app
```

Esto puede evitar determinadas penalizaciones de rendimiento y diferencias de comportamiento al utilizar herramientas Linux sobre archivos almacenados en Windows.

No significa que sea imposible acceder a archivos Windows desde WSL.

Simplemente debemos escoger la ubicación apropiada para nuestro flujo de trabajo.

---

## ⚙️ 10. Ejecutables en Windows

En macOS y Linux estamos acostumbrados a ejecutar programas mediante comandos como:

```bash
git
node
```

En Windows existen diferentes tipos de archivos utilizados para ejecutar programas o Scripts.

Entre ellos:

| Extensión | Uso habitual |
|---|---|
| `.exe` | Aplicación ejecutable |
| `.cmd` | Script de comandos de Windows |
| `.bat` | Archivo Batch |
| `.ps1` | Script de PowerShell |

### Ejemplo

Una instalación de Node.js puede proporcionar:

```text
node.exe
```

También podemos encontrar archivos como:

```text
npm.cmd
```

Estos permiten integrar herramientas con el entorno de comandos de Windows.

### ¿Por qué importa?

Porque algunos comandos pueden resolverse mediante diferentes archivos dependiendo del Shell.

Por ejemplo, PowerShell y CMD no tienen exactamente las mismas reglas de resolución.

---

## 🌍 11. Environment Variables en Windows

Windows utiliza variables de entorno para proporcionar información a los procesos.

Entre las más conocidas encontramos:

```text
PATH
TEMP
USERPROFILE
APPDATA
```

### Consultar una variable en PowerShell

```powershell
$env:USERPROFILE
```

Podríamos obtener:

```text
C:\Users\developer
```

### Consultar PATH

```powershell
$env:Path
```

### Diferencia con macOS

En Zsh:

```bash
echo "$PATH"
```

En PowerShell:

```powershell
$env:Path
```

Ambos permiten consultar una variable de entorno, pero utilizan sintaxis diferente.

### ¿Por qué importa?

Porque copiar comandos de macOS directamente a PowerShell puede producir errores.

Debemos identificar para qué Shell fue escrito cada comando.

---

## 🧭 12. User vs System Environment Variables

Windows permite configurar variables de entorno en diferentes ámbitos.

Entre los más relevantes encontramos:

**User Environment Variables**

Configuraciones asociadas a una cuenta de usuario.

**System Environment Variables**

Configuraciones del sistema disponibles según las reglas correspondientes.

### Modelo conceptual

```text
Windows Environment
│
├── System Variables
│
└── User Variables
        ↓
    Process Environment
```

Cuando se inicia un proceso, recibe un entorno construido según las reglas aplicables.

### ¿Por qué importa?

Porque una herramienta puede estar configurada para un usuario y no para otro.

Esto es especialmente relevante en:

- Computadoras compartidas.
- Equipos corporativos.
- Máquinas virtuales.
- Procesos de automatización.
- Servicios ejecutados bajo cuentas diferentes.

---

## 🔎 13. PATH en Windows

`PATH` también existe en Windows.

Permite localizar ejecutables mediante los mecanismos de búsqueda correspondientes.

### Ejemplo conceptual

```text
C:\Program Files\nodejs\
C:\Program Files\Git\cmd\
C:\Windows\System32\
```

### Consultar PATH

En PowerShell:

```powershell
$env:Path
```

### Mostrar entradas individualmente

```powershell
$env:Path -split ';'
```

En Windows, las entradas de `PATH` suelen separarse mediante punto y coma (`;`).

### ¿Por qué importa?

Porque podemos tener diferentes instalaciones de una herramienta.

Por ejemplo:

```text
Node.js Installation A
Node.js Installation B
```

El resultado dependerá de la resolución de comandos y de la configuración del entorno.

### Importante

PowerShell también puede resolver comandos como Aliases, Functions y Cmdlets.

Por eso `PATH` no explica por sí solo toda la resolución de comandos.

---

## 🧰 14. Cómo identificar qué herramienta estamos ejecutando

En PowerShell podemos utilizar:

```powershell
Get-Command node
```

Si Node.js está disponible, obtendremos información sobre cómo se resuelve.

Para consultar todas las coincidencias disponibles:

```powershell
Get-Command node -All
```

### Ejemplo conceptual

```text
Command
   ↓
PowerShell Resolution
   ↓
Executable / Script / Function / Alias
```

### ¿Por qué es importante?

Porque un comando puede resolverse mediante distintos mecanismos.

No siempre basta con comprobar que una herramienta está instalada.

También debemos verificar qué versión estamos ejecutando.

```powershell
node --version
```

---

## 📦 15. Package Managers en Windows

Windows dispone de diferentes mecanismos para instalar software.

Entre ellos podemos encontrar:

- Instaladores oficiales.
- Microsoft Store.
- Windows Package Manager (`winget`).
- Gestores de paquetes de terceros.

### ¿Qué es winget?

**winget** es la herramienta de línea de comandos de Windows Package Manager.

Permite buscar, instalar, actualizar y administrar software compatible.

### Ejemplo de consulta

```powershell
winget --version
```

### Buscar software

```powershell
winget search Git
```

### ¿Es equivalente a npm?

No.

`winget` administra software distribuido mediante su ecosistema de paquetes.

npm y pnpm administran dependencias del ecosistema JavaScript.

### Modelo conceptual

```text
Windows
   ↓
winget
   ↓
System Applications
```

```text
JavaScript Project
   ↓
pnpm
   ↓
Project Dependencies
```

### Recomendación

No debemos instalar una herramienta desde múltiples mecanismos sin una razón clara.

Primero debemos definir cómo administraremos cada componente.

---

## 🟢 16. Node.js en Windows

Node.js puede instalarse en Windows mediante diferentes mecanismos.

Por ejemplo:

- Instalador oficial.
- Gestor de versiones.
- Package Manager del sistema.

### ¿Qué estrategia recomendamos?

Cuando trabajamos con varios proyectos que requieren diferentes versiones de Node.js, resulta conveniente evaluar un gestor de versiones.

Por ejemplo:

```text
Project A → Node.js Version A

Project B → Node.js Version B
```

Un gestor de versiones permite administrar estas diferencias.

### Precaución

No todos los gestores de versiones funcionan igual en Windows y macOS.

Por ejemplo, **nvm-windows** y el proyecto **nvm utilizado habitualmente en macOS/Linux** son implementaciones diferentes.

Aunque comparten una finalidad similar, no debemos asumir que tienen exactamente las mismas características o mecanismos internos.

### ¿Instalaremos Node.js ahora?

No.

La instalación y administración profesional de Runtimes corresponde al módulo:

```text
04-runtime-management
```

Aquí solamente necesitamos comprender cómo encaja Node.js dentro del entorno Windows.

---

## 🧱 17. Windows Native vs WSL Development

Una decisión importante es dónde ejecutaremos nuestras herramientas.

### Opción A — Native Windows

```text
Windows
   ↓
PowerShell
   ↓
Node.js for Windows
   ↓
pnpm
   ↓
Project
```

### Opción B — WSL

```text
Windows
   ↓
WSL 2
   ↓
Linux Distribution
   ↓
Node.js for Linux
   ↓
pnpm
   ↓
Project
```

### Comparación

| Aspecto | Native Windows | WSL |
|---|---|---|
| Sistema de ejecución | Windows | Linux dentro de WSL |
| Shell habitual | PowerShell | Bash u otro Shell Linux |
| Rutas | Windows | Linux |
| Binarios Node.js | Windows | Linux |
| Package Managers del sistema | winget u otros | apt, dnf u otros según distribución |
| Scripts Linux | Compatibilidad variable | Entorno Linux |
| Integración con herramientas Windows | Directa | Mediante integración WSL |

### ¿Cuál deberíamos utilizar?

Depende del proyecto.

Para aplicaciones web modernas, ambas alternativas pueden funcionar correctamente.

WSL puede resultar especialmente conveniente cuando necesitamos un entorno Linux o herramientas diseñadas para él.

### Regla importante

Evita mezclar innecesariamente instalaciones y dependencias de Node.js entre Windows y Linux.

Aunque Windows y WSL pueden interoperar, los ejecutables y dependencias nativas pueden tener requisitos diferentes.

---

## 🔐 18. Permisos y privilegios en Windows

Windows utiliza mecanismos de seguridad y permisos para controlar el acceso a recursos.

Podemos encontrar:

- Cuentas de usuario.
- Grupos.
- Permisos NTFS.
- Procesos elevados.
- Restricciones corporativas.
- Políticas de ejecución.

### Administrator Privileges

Algunas operaciones requieren privilegios de administrador.

Pero esto no significa que debamos ejecutar todas nuestras herramientas de desarrollo como administrador.

### ¿Por qué evitarlo?

Porque puede:

- Introducir riesgos de seguridad.
- Modificar configuraciones globales innecesariamente.
- Ocultar problemas de permisos.
- Generar diferencias entre entornos.

### Principio

**Utiliza privilegios elevados solamente cuando una operación legítima los requiere y comprendes su impacto.**

---

## 🏢 19. Windows en entornos corporativos

Windows es especialmente habitual en organizaciones que utilizan:

- Active Directory o Microsoft Entra ID.
- Herramientas de administración de dispositivos.
- Redes corporativas.
- VPN.
- Proxies.
- Certificados empresariales.
- Máquinas virtuales.
- Políticas de seguridad.

### Ejemplo conceptual

```text
Corporate Windows Machine
│
├── Managed User Account
├── Security Policies
├── Network Configuration
├── Approved Software
├── Development Tools
└── Project Environment
```

### ¿Qué implica?

Que algunas configuraciones pueden estar controladas por la organización.

Por ejemplo:

- Instalación de software.
- Permisos administrativos.
- Acceso a repositorios.
- Certificados.
- Acceso a Package Registries.
- Conectividad mediante VPN.

### Recomendación

No debemos desactivar controles de seguridad para resolver problemas de instalación.

Debemos identificar si el error pertenece a:

```text
Local Configuration
Corporate Policy
Network Access
Package Registry
Project Requirements
```

Y seguir el procedimiento autorizado.

---

## 🧪 20. Práctica: Windows Environment Audit

Vamos a realizar una inspección inicial de nuestro entorno.

**Esta práctica no requiere instalar ni modificar herramientas.**

Utilizaremos PowerShell.

### Step 1 — Operating System

```powershell
Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsBuildNumber
```

### Step 2 — Architecture

```powershell
[System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture
```

### Step 3 — PowerShell Version

```powershell
$PSVersionTable.PSVersion
```

### Step 4 — Current Directory

```powershell
Get-Location
```

### Step 5 — User Directory

```powershell
$env:USERPROFILE
```

### Step 6 — PATH

```powershell
$env:Path -split ';'
```

### Step 7 — Git

```powershell
Get-Command git -ErrorAction SilentlyContinue
```

Si está disponible:

```powershell
git --version
```

### Step 8 — Node.js

```powershell
Get-Command node -ErrorAction SilentlyContinue
```

Si está disponible:

```powershell
node --version
```

### Step 9 — Windows Package Manager

```powershell
Get-Command winget -ErrorAction SilentlyContinue
```

Si está disponible:

```powershell
winget --version
```

### Step 10 — WSL

```powershell
Get-Command wsl -ErrorAction SilentlyContinue
```

Si está disponible, podemos consultar:

```powershell
wsl --status
```

La disponibilidad del comando no garantiza que WSL esté completamente configurado o que exista una distribución instalada.

### Step 11 — Document Results

| Component | Result |
|---|---|
| Windows Version | |
| OS Architecture | |
| PowerShell Version | |
| User Directory | |
| PATH Entries | |
| Git Available | |
| Node.js Available | |
| winget Available | |
| WSL Status | |
| Code Editor | |
| Projects Directory | |

### Reflexión

Responde:

1. ¿Qué versión de Windows utilizas?
2. ¿Qué arquitectura tiene tu sistema?
3. ¿Qué versión de PowerShell está disponible?
4. ¿Git está instalado?
5. ¿Node.js está instalado?
6. ¿Qué Package Manager del sistema está disponible?
7. ¿WSL está configurado?
8. ¿Qué herramientas necesita realmente tu proyecto?
9. ¿Qué configuraciones están controladas por tu organización?
10. ¿Qué cambios serían necesarios y cuáles no?

---

## 🧭 21. Estrategia recomendada para preparar Windows

Nuestro proceso será progresivo.

```text
Understand Windows
        ↓
Inspect Current Environment
        ↓
Understand Windows Terminal
        ↓
Understand PowerShell
        ↓
Understand Git Bash
        ↓
Understand WSL
        ↓
Diagnose Common Issues
        ↓
Apply Best Practices
```

No necesitamos instalar todas las herramientas.

Debemos comprender sus responsabilidades y seleccionar las que correspondan a nuestros proyectos.

### Ejemplo de entorno nativo

```text
Windows
   ↓
Windows Terminal
   ↓
PowerShell
   ↓
Git
   ↓
Node.js Version Manager
   ↓
Node.js
   ↓
pnpm
   ↓
VS Code
   ↓
React / Node.js Projects
```

### Ejemplo de entorno con WSL

```text
Windows
   ↓
Windows Terminal
   ↓
WSL 2
   ↓
Linux Distribution
   ↓
Linux Shell
   ↓
Git
   ↓
Node.js Version Manager
   ↓
Node.js
   ↓
pnpm
   ↓
VS Code Integration
   ↓
React / Node.js Projects
```

Ambos modelos pueden utilizarse profesionalmente.

---

## ⚠️ 22. Errores comunes

### 1. Confundir Windows Terminal con PowerShell

Windows Terminal es una aplicación de Terminal; PowerShell es un Shell.

### 2. Pensar que CMD y PowerShell son equivalentes

Tienen diferentes capacidades, sintaxis y mecanismos de ejecución.

### 3. Pensar que Git Bash es Linux

Git Bash proporciona un entorno compatible con numerosas herramientas Unix, pero no ejecuta un Kernel Linux.

### 4. Instalar WSL sin necesitarlo

WSL es útil, pero no obligatorio para todos los proyectos.

### 5. Mezclar dependencias nativas de Windows y Linux

Puede provocar incompatibilidades.

### 6. Copiar comandos de macOS directamente a PowerShell

La sintaxis puede ser diferente.

### 7. Instalar varias versiones de Node.js sin una estrategia

Podemos terminar ejecutando una versión distinta de la requerida.

### 8. Modificar PATH sin comprenderlo

Puede afectar la resolución de comandos.

### 9. Ejecutar todo como administrador

Introduce riesgos y configuraciones innecesarias.

### 10. Ignorar las políticas corporativas

Un entorno profesional debe respetar los requisitos de seguridad y administración.

### 11. Pensar que winget y pnpm cumplen la misma función

Administran software en ámbitos diferentes.

### 12. Suponer que todos los entornos Windows son iguales

Pueden variar según versión, arquitectura, permisos y políticas.

---

## 🧠 23. Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es un Development Environment en Windows?
2. ¿Qué diferencia existe entre Windows y el entorno de desarrollo?
3. ¿Qué es Windows Terminal?
4. ¿Qué es PowerShell?
5. ¿Qué es CMD?
6. ¿Qué es Git Bash?
7. ¿Git Bash es equivalente a Linux?
8. ¿Qué es WSL?
9. ¿Qué diferencia existe entre Git Bash y WSL?
10. ¿Qué significa x64?
11. ¿Qué significa ARM64?
12. ¿Cómo se representan habitualmente las rutas en Windows?
13. ¿Qué es una Environment Variable?
14. ¿Qué responsabilidad cumple `PATH`?
15. ¿Qué diferencia existe entre User y System Environment Variables?
16. ¿Qué permite investigar `Get-Command`?
17. ¿Qué es winget?
18. ¿Qué diferencia existe entre winget y pnpm?
19. ¿Por qué necesitamos administrar versiones de Node.js?
20. ¿Qué diferencia existe entre Node.js nativo y Node.js dentro de WSL?
21. ¿Por qué debemos evitar privilegios administrativos innecesarios?
22. ¿Qué restricciones pueden existir en un entorno corporativo?
23. ¿Qué revisarías antes de instalar nuevas herramientas?
24. ¿Cómo decidirías entre desarrollo nativo y WSL?
25. ¿Qué información documentarías sobre tu entorno Windows?

---

## 💡 Idea clave

Windows proporciona diferentes alternativas para construir un Development Environment profesional.

```text
Windows
   │
   ├── Native Development
   │      ├── Windows Terminal
   │      ├── PowerShell
   │      ├── Git
   │      └── Windows Runtimes
   │
   └── Linux Development
          ├── WSL
          ├── Linux Shell
          ├── Linux Tools
          └── Linux Runtimes
```

La decisión no consiste en identificar un entorno universalmente superior.

Consiste en seleccionar una configuración compatible con nuestros proyectos, comprensible para el equipo y sencilla de mantener.

**Un entorno profesional debe ser deliberado, verificable y reproducible en la medida que el proyecto lo requiera.**

---

## 🚀 Siguiente paso

Ahora conocemos los componentes principales de un Development Environment en Windows.

El siguiente paso será estudiar **Windows Terminal**.

Aprenderemos qué problema resuelve, cómo funciona, qué son los Profiles, cómo se relaciona con PowerShell, CMD y WSL, y cómo organizar nuestras sesiones de desarrollo.

👉 [Windows Terminal](./02-windows-terminal.md)