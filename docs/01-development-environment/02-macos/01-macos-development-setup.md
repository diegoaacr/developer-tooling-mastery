# macOS Development Setup

macOS es uno de los sistemas operativos utilizados profesionalmente para desarrollar aplicaciones web, móviles, de escritorio y herramientas de infraestructura.

Sin embargo, utilizar macOS no significa que nuestra computadora esté automáticamente preparada para cualquier proyecto de software.

Antes de instalar Runtimes, Package Managers o herramientas específicas, necesitamos comprender cómo está organizado el entorno de desarrollo en macOS.

En este documento aprenderemos a identificar sus componentes principales, comprobar las herramientas disponibles y definir una estrategia ordenada para preparar nuestra computadora.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué características de macOS son relevantes para desarrollar software.
- Qué relación existe entre macOS y Unix.
- Qué herramientas proporciona macOS y cuáles debemos instalar por separado.
- Qué diferencia existe entre Terminal.app y Zsh.
- Qué son las Command Line Tools de Apple.
- Qué responsabilidad cumple Homebrew.
- Cómo identificar la versión y arquitectura de macOS.
- Cómo comprobar si Git y otras herramientas están disponibles.
- Qué papel cumplen `PATH` y las variables de entorno.
- Cómo organizar nuestros proyectos locales.
- Qué buenas prácticas seguir antes de instalar herramientas.

El objetivo no será instalar todo inmediatamente.

**Primero identificaremos el estado de nuestro entorno y después incorporaremos únicamente las herramientas necesarias.**

---

## 🧠 1. ¿Por qué preparar un Development Environment en macOS?

Imagina que acabamos de adquirir una Mac.

Podemos navegar por Internet, instalar aplicaciones y crear archivos.

Pero queremos desarrollar una aplicación JavaScript.

Probablemente necesitaremos herramientas como:

```text
Git
Node.js
Package Manager
Code Editor
```

También necesitaremos comprender cómo interactuar con ellas desde la Terminal.

Nuestro entorno podría evolucionar así:

```text
macOS
  ↓
Terminal and Shell
  ↓
Command Line Tools
  ↓
Development Tools
  ↓
Runtime
  ↓
Project Dependencies
  ↓
Application Development
```

Este esquema representa una progresión de preparación, no una cadena técnica obligatoria.

Por ejemplo, algunas herramientas pueden instalarse mediante diferentes mecanismos y no todas dependen de Homebrew.

La pregunta fundamental será:

**¿Qué componentes necesito para trabajar con mis proyectos y cómo puedo verificar que funcionan?**

---

## 🍎 2. macOS y su relación con Unix

macOS es un sistema operativo de Apple construido sobre tecnologías que incluyen Darwin y componentes de tradición Unix.

Para nuestro aprendizaje, esto significa que macOS proporciona un entorno compatible con numerosas herramientas y convenciones utilizadas en sistemas Unix-like.

Por ejemplo, encontraremos:

- Directorios como `/usr` y `/etc`.
- Permisos de archivos.
- Procesos.
- Shells como Zsh.
- Herramientas de línea de comandos.
- Rutas que utilizan `/` como separador.

### Ejemplo de una ruta

```text
/Users/developer/projects/my-app
```

Esta ruta representa una posible ubicación de un proyecto.

Podemos distinguir:

```text
/
└── Users/
    └── developer/
        └── projects/
            └── my-app/
```

El directorio personal real dependerá de la cuenta configurada en macOS.

### ¿Por qué importa?

Porque muchas herramientas de desarrollo utilizan convenciones Unix-like.

Por ejemplo:

```bash
pwd
ls
cd
```

Estos comandos nos permiten interactuar con el sistema de archivos.

Los estudiaremos con mayor profundidad en `02-terminal-and-shell`.

---

## 🖥️ 3. Componentes de nuestro entorno macOS

Podemos organizar nuestro entorno de la siguiente manera:

```text
macOS Development Environment
│
├── Operating System
│   └── macOS
│
├── File System
│   └── APFS (habitual en instalaciones modernas)
│
├── Terminal
│   └── Terminal.app
│
├── Shell
│   └── Zsh (predeterminado habitualmente)
│
├── Apple Developer Tools
│   └── Command Line Tools
│
├── System Package Manager
│   └── Homebrew (opcional)
│
├── Development Tools
│   ├── Git
│   └── Other Tools
│
├── Runtime
│   └── Node.js (si el proyecto lo necesita)
│
└── Code Editor
    └── VS Code / Other Editor
```

No todos estos componentes vienen instalados de fábrica.

Tampoco necesitamos instalar cada uno para todos los tipos de proyecto.

**El entorno debe responder a las necesidades reales de nuestro trabajo.**

---

## 🔍 4. Identificar nuestra versión de macOS

Antes de instalar herramientas, debemos conocer nuestro sistema.

Podemos hacerlo desde la interfaz gráfica:

**Apple Menu → About This Mac**

Allí encontraremos información sobre el sistema operativo y el equipo.

También podemos utilizar la Terminal.

### Comprobar la versión

```bash
sw_vers
```

Ejemplo de salida:

```text
ProductName:        macOS
ProductVersion:     15.x
BuildVersion:       24xxxxx
```

Los valores son ilustrativos.

El resultado real dependerá de la versión instalada.

### ¿Por qué importa?

Porque algunas herramientas tienen requisitos mínimos de sistema operativo.

Antes de instalar una herramienta, debemos comprobar que nuestra versión de macOS sea compatible.

---

## 🧠 5. Apple Silicon vs Intel

No todas las Mac utilizan la misma arquitectura de procesador.

Podemos encontrar dos grandes familias:

**Apple Silicon**

Procesadores desarrollados por Apple, como las familias M1, M2, M3 y posteriores.

**Intel**

Procesadores utilizados en generaciones anteriores de Mac.

Esta diferencia puede influir en:

- Compatibilidad de ejecutables.
- Descargas de herramientas.
- Rutas de instalación.
- Dependencias nativas.
- Mecanismos de compatibilidad.

### Comprobar la arquitectura

Desde la Terminal:

```bash
uname -m
```

Resultados habituales:

```text
arm64
```

o:

```text
x86_64
```

En una sesión nativa, `arm64` suele indicar Apple Silicon y `x86_64` una arquitectura Intel.

**Precaución:** en una Mac con Apple Silicon, un proceso ejecutado mediante Rosetta puede informar `x86_64`. Por eso, este comando describe la arquitectura observada por el entorno de ejecución y no siempre identifica por sí solo el Hardware físico.

Para comprobar el tipo de chip de manera sencilla, también podemos utilizar **About This Mac**.

### ¿Por qué importa para Homebrew?

Las instalaciones predeterminadas de Homebrew suelen utilizar diferentes prefijos:

| Arquitectura | Prefijo habitual |
|---|---|
| Apple Silicon | `/opt/homebrew` |
| Intel | `/usr/local` |

Estos son valores predeterminados habituales, no rutas universales.

Más adelante estudiaremos cómo Homebrew utiliza estas ubicaciones.

---

## 💻 6. Terminal.app

macOS incluye una aplicación llamada **Terminal.app**.

Podemos encontrarla en:

```text
Applications
└── Utilities
    └── Terminal.app
```

También podemos buscarla mediante Spotlight.

La Terminal proporciona una interfaz para interactuar con programas de línea de comandos.

Por ejemplo:

```bash
pwd
```

Este comando muestra el directorio de trabajo actual.

Otro ejemplo:

```bash
ls
```

Permite listar entradas del directorio actual.

### Importante

Terminal.app no es lo mismo que el Shell.

```text
Developer
    ↓
Terminal.app
    ↓
Shell
    ↓
Commands
```

Terminal.app proporciona la interfaz.

El Shell interpreta los comandos y coordina su ejecución.

---

## 🐚 7. Zsh: el Shell habitual de macOS

En las instalaciones modernas de macOS, **Zsh** es el Shell predeterminado para nuevas cuentas de usuario.

Zsh significa **Z Shell**.

Es un programa que permite:

- Ejecutar comandos.
- Navegar por directorios.
- Utilizar variables.
- Crear aliases.
- Ejecutar Scripts.
- Configurar el entorno de trabajo.

### Comprobar nuestro Shell configurado

```bash
echo "$SHELL"
```

Podríamos obtener:

```text
/bin/zsh
```

Este valor suele representar el Shell configurado para nuestra cuenta.

Pero debemos distinguirlo del proceso que estamos utilizando en ese momento.

### Comprobar el Shell actual

Podemos consultar:

```bash
ps -p $$ -o comm=
```

En una sesión habitual de Zsh, podríamos obtener:

```text
zsh
```

Este comando inspecciona el proceso correspondiente al identificador `$$` del Shell.

La salida puede variar según el entorno.

### ¿Por qué necesitamos distinguirlos?

Porque podemos tener Zsh configurado como Shell predeterminado y abrir temporalmente otro Shell.

Por ejemplo:

```text
Default Shell → Zsh
Current Session → Bash
```

Esta diferencia puede afectar a los archivos de configuración y a la interpretación de comandos.

---

## 🛠️ 8. Apple Command Line Tools

Apple proporciona un conjunto de herramientas conocido como **Command Line Tools for Xcode**.

Incluye componentes utilizados para determinadas tareas de desarrollo.

Entre ellos pueden encontrarse:

- Git.
- Compiladores y herramientas relacionadas.
- Utilidades de desarrollo.
- SDKs y componentes necesarios para determinadas operaciones.

Estas herramientas pueden instalarse independientemente de la aplicación completa de Xcode.

### ¿Por qué son importantes?

Porque algunas herramientas o dependencias necesitan utilidades de compilación y otros componentes de desarrollo.

Por ejemplo, determinados Packages pueden requerir compilación de código nativo.

Conceptualmente:

```text
Development Task
       ↓
Requires Native Tooling
       ↓
Apple Command Line Tools
```

### Comprobar la ruta activa de herramientas de desarrollo

Podemos ejecutar:

```bash
xcode-select -p
```

Si existe una selección válida, podríamos obtener:

```text
/Library/Developer/CommandLineTools
```

O una ruta asociada a Xcode.

**Importante:** este comando informa sobre el directorio de desarrollo seleccionado. No garantiza por sí solo que todas las herramientas necesarias estén instaladas o funcionen correctamente.

### ¿Y si no están instaladas?

macOS permite solicitar la instalación mediante:

```bash
xcode-select --install
```

Este comando puede abrir el proceso de instalación correspondiente.

**No lo ejecutes automáticamente.** Primero verifica si tu entorno realmente necesita estas herramientas y si ya están disponibles.

En el siguiente documento estudiaremos las Command Line Tools con mayor profundidad.

---

## 📦 9. Homebrew

**Homebrew** es un Package Manager utilizado para instalar y administrar software en macOS y también disponible en Linux.

No forma parte de una instalación estándar de macOS.

Se instala por separado.

Por ejemplo, puede utilizarse para administrar herramientas como:

```text
Git
wget
jq
```

Y otras aplicaciones compatibles.

Conceptualmente:

```text
Developer
    ↓
Homebrew
    ↓
Package Installation
    ↓
Available Tool
```

### ¿Es obligatorio utilizar Homebrew?

No.

Existen diferentes mecanismos para instalar software:

- Instaladores oficiales.
- Herramientas proporcionadas por Apple.
- Homebrew.
- Gestores de versiones.
- Otros mecanismos específicos de cada ecosistema.

La elección depende de la herramienta y del contexto.

### Comprobar si Homebrew está disponible

```bash
brew --version
```

Si está instalado y accesible, mostrará su versión.

Si no está disponible, podemos recibir un mensaje indicando que el comando no se encuentra.

No necesitamos instalarlo todavía.

En `03-homebrew.md` estudiaremos su funcionamiento y su instalación mediante la documentación oficial.

---

## 🌍 10. PATH en macOS

Cuando escribimos:

```bash
git --version
```

el Shell necesita localizar el comando `git`.

Uno de los mecanismos utilizados es la variable de entorno `PATH`.

En sistemas Unix-like, `PATH` suele contener directorios separados mediante dos puntos.

Por ejemplo:

```text
/usr/local/bin:/usr/bin:/bin
```

Este valor es ilustrativo.

### Consultar PATH

```bash
echo "$PATH"
```

La salida dependerá de nuestra configuración.

### Consultar cómo se resuelve un comando

Podemos ejecutar:

```bash
command -v git
```

Si Git se resuelve como un ejecutable, podríamos obtener una ruta como:

```text
/usr/bin/git
```

Sin embargo, el resultado puede depender del Shell y de otros mecanismos de resolución.

### ¿Por qué importa?

Porque una herramienta puede estar instalada y aun así no encontrarse al escribir su nombre.

Por ejemplo:

```text
Tool Installed
      ↓
Executable Location
      ↓
PATH Configuration
      ↓
Command Resolution
```

Si la configuración no permite localizar el ejecutable, el comando puede fallar.

**No modificaremos `PATH` en este documento.**

Aprenderemos a configurarlo correctamente en `04-macos-path-configuration.md`.

---

## 🗂️ 11. ¿Dónde guardar nuestros proyectos?

Conviene mantener nuestros proyectos organizados en un directorio reconocible.

Por ejemplo:

```text
/Users/developer/
└── projects/
    ├── learning/
    ├── personal/
    └── work/
```

Esta estructura es solamente una sugerencia.

No existe una ubicación universal obligatoria para todos los proyectos.

También podemos utilizar:

```text
~/Developer/
```

o:

```text
~/Projects/
```

El símbolo `~` suele representar el directorio personal del usuario en Shells como Zsh y Bash.

### Recomendación

Utiliza una ubicación donde tengas permisos adecuados y puedas identificar fácilmente tus proyectos.

Evita modificar directorios protegidos del sistema para almacenar código personal.

Tampoco es necesario utilizar permisos de administrador para todas las operaciones de desarrollo.

---

## 🔐 12. Permisos y seguridad

macOS implementa mecanismos de permisos y protección del sistema.

Durante el desarrollo podemos encontrar situaciones como:

```text
Permission denied
```

Este mensaje puede aparecer por diferentes razones:

- Falta de permisos sobre un archivo.
- Restricciones de acceso a un directorio.
- Ausencia de permisos de ejecución.
- Protecciones del sistema.
- Restricciones específicas de una aplicación.

### ¿Debemos utilizar sudo para resolverlo?

No automáticamente.

`sudo` permite ejecutar determinados comandos con privilegios elevados, según la configuración del sistema.

Utilizarlo sin comprender la operación puede modificar archivos o configuraciones con permisos innecesarios.

Por ejemplo, no debemos convertir `sudo` en una solución general para errores de instalación.

### Principio

**Antes de elevar privilegios, debemos identificar qué recurso necesita acceso y por qué.**

---

## 🔍 13. Primera inspección de nuestro entorno macOS

Vamos a reunir las comprobaciones anteriores.

Todas las siguientes operaciones son de consulta y no están destinadas a modificar la configuración del sistema.

### Step 1 — Operating System

```bash
sw_vers
```

### Step 2 — Architecture

```bash
uname -m
```

### Step 3 — Default Shell

```bash
echo "$SHELL"
```

### Step 4 — Current Shell Process

```bash
ps -p $$ -o comm=
```

### Step 5 — Current Directory

```bash
pwd
```

### Step 6 — PATH

```bash
echo "$PATH"
```

### Step 7 — Git

```bash
git --version
```

Si Git no está disponible, registra el resultado.

No es necesario instalarlo todavía.

### Step 8 — Apple Developer Tools

```bash
xcode-select -p
```

### Step 9 — Homebrew

```bash
brew --version
```

Si Homebrew no está instalado, simplemente registra esa condición.

### Step 10 — Node.js (Optional)

```bash
node --version
```

Node.js no es un requisito para completar esta práctica.

Si no está instalado, lo estudiaremos en `04-runtime-management`.

---

## 📋 14. Environment Inventory

Ahora podemos registrar nuestro entorno.

| Component | Current State |
|---|---|
| macOS Version | |
| CPU Architecture | |
| Terminal Application | |
| Default Shell | |
| Current Shell | |
| Git Available | |
| Command Line Tools | |
| Homebrew Available | |
| Node.js Available | |
| Code Editor | |
| Projects Directory | |

No necesitamos publicar información personal ni rutas privadas.

El objetivo es tener una referencia de nuestro entorno antes de realizar modificaciones.

### ¿Por qué es útil?

Porque nos permite distinguir:

```text
Initial State
      ↓
Configuration Changes
      ↓
New State
```

Si posteriormente aparece un problema, conocer el estado inicial puede ayudarnos a investigar qué cambió.

---

## 🧭 15. Orden recomendado para preparar macOS

Nuestro proceso será progresivo.

```text
Understand macOS
       ↓
Inspect Current Environment
       ↓
Understand Command Line Tools
       ↓
Understand Homebrew
       ↓
Understand PATH
       ↓
Diagnose Common Issues
       ↓
Apply Best Practices
```

No instalaremos herramientas por costumbre.

Primero comprobaremos si ya están disponibles y si realmente las necesitamos.

### ¿Qué configuraremos más adelante?

En módulos posteriores estudiaremos:

```text
02 — Terminal and Shell
03 — Editor and Workspace
04 — Runtime Management
05 — Package Managers
```

Allí aprenderemos a configurar el Shell con mayor profundidad, preparar nuestro editor, administrar versiones de Node.js y trabajar con npm, pnpm o Yarn.

---

## 🏢 16. macOS en equipos profesionales

En una empresa, diferentes desarrolladores pueden utilizar macOS con distintas versiones, arquitecturas y preferencias personales.

Por ejemplo:

```text
Developer A
    ↓
Apple Silicon
    ↓
macOS

Developer B
    ↓
Intel
    ↓
macOS
```

Ambos pueden colaborar en el mismo Repository, siempre que cumplan los requisitos de compatibilidad del proyecto.

Por eso es importante documentar:

- Versiones de macOS soportadas, cuando corresponda.
- Herramientas requeridas.
- Versiones compatibles.
- Dependencias del sistema.
- Instrucciones de preparación.
- Comandos de verificación.

### Ejemplo conceptual

```text
Shared Project Requirements
           ↓
Developer A Environment
Developer B Environment
           ↓
Common Validation
```

No necesitamos que todas las computadoras sean idénticas.

Necesitamos que sus entornos sean compatibles con el proyecto.

Esto conecta directamente con los conceptos de **User vs Team Configuration** y **Reproducible Environments**.

---

## ⚠️ 17. Errores comunes

### 1. Pensar que macOS incluye todas las herramientas de desarrollo

Algunas herramientas deben instalarse por separado.

### 2. Confundir Terminal.app con Zsh

Terminal.app proporciona la interfaz; Zsh es un Shell.

### 3. Instalar Homebrew sin comprender su responsabilidad

Homebrew es un Package Manager, no un requisito universal para desarrollar software.

### 4. Confundir Apple Command Line Tools con Homebrew

Las Command Line Tools proporcionan componentes de desarrollo de Apple. Homebrew administra instalaciones de software mediante su propio ecosistema.

### 5. Suponer que todas las Mac tienen la misma arquitectura

Apple Silicon e Intel pueden requerir diferentes binarios o rutas.

### 6. Modificar PATH sin inspeccionarlo

Una configuración incorrecta puede afectar la resolución de comandos.

### 7. Utilizar sudo para cualquier error de permisos

Debemos investigar el problema antes de elevar privilegios.

### 8. Instalar varias copias de una herramienta sin necesidad

Podemos terminar con diferentes ejecutables y versiones disponibles en distintas rutas.

### 9. Instalar Node.js sin definir una estrategia de versiones

Más adelante estudiaremos Runtime Management y cómo manejar diferentes requisitos entre proyectos.

### 10. Confundir tener una herramienta instalada con tener el entorno preparado

También debemos comprobar compatibilidad, configuración y funcionamiento.

---

## 🧠 18. Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Por qué necesitamos preparar un Development Environment en macOS?
2. ¿Qué relación existe entre macOS y Unix?
3. ¿Qué responsabilidad cumple Terminal.app?
4. ¿Qué es Zsh?
5. ¿Cómo podemos consultar la versión de macOS?
6. ¿Qué diferencia existe entre Apple Silicon e Intel?
7. ¿Para qué sirve `uname -m`?
8. ¿Qué son las Command Line Tools?
9. ¿Qué responsabilidad cumple Homebrew?
10. ¿Es obligatorio instalar Homebrew?
11. ¿Qué papel cumple `PATH`?
12. ¿Qué permite investigar `command -v`?
13. ¿Por qué debemos organizar nuestros proyectos?
14. ¿Por qué no conviene utilizar `sudo` indiscriminadamente?
15. ¿Qué comprobaciones realizarías antes de instalar nuevas herramientas?
16. ¿Por qué dos desarrolladores con macOS pueden tener entornos diferentes?
17. ¿Qué información debería documentar un equipo sobre sus requisitos de macOS?
18. ¿Por qué es importante verificar el entorno después de configurarlo?

---

## 💡 Idea clave

Preparar un Development Environment en macOS no consiste en instalar todas las herramientas disponibles.

Consiste en comprender qué proporciona el sistema, identificar qué necesita nuestro trabajo y configurar los componentes de manera controlada.

```text
macOS
  ↓
Environment Inspection
  ↓
Required Tools
  ↓
Correct Configuration
  ↓
Verification
  ↓
Reliable Development Environment
```

**Un entorno profesional debe ser comprensible, verificable y mantenible.**

Antes de instalar una herramienta, debemos saber qué problema resuelve, cómo se integra con el sistema y cómo comprobar que funciona.

---

## 🚀 Siguiente paso

Ahora conocemos los componentes principales de un Development Environment en macOS.

El siguiente paso será estudiar las **Apple Command Line Tools**.

Comprenderemos qué incluyen, cómo se relacionan con Xcode, cuándo son necesarias y cómo comprobar correctamente su instalación.

👉 [Command Line Tools](./02-command-line-tools.md)