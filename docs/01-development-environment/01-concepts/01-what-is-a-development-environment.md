# What Is a Development Environment?

Cuando comenzamos a aprender programación, normalmente nos concentramos en escribir código.

Abrimos un editor, creamos un archivo y ejecutamos nuestro primer programa.

Pero detrás de estas acciones intervienen diferentes componentes que permiten desarrollar, ejecutar y comprobar software.

Por ejemplo:

- Un sistema operativo.
- Un sistema de archivos.
- Un editor de código.
- Una terminal y un Shell.
- Herramientas de desarrollo.
- Runtimes.
- Configuraciones.
- Dependencias del proyecto.

El conjunto de componentes que utilizamos para desarrollar software se conoce como **Development Environment**.

Antes de instalar y configurar herramientas, necesitamos comprender cómo se relacionan estas piezas y qué responsabilidad cumple cada una.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué es un Development Environment.
- Por qué un entorno de desarrollo es más que un editor de código.
- Cuáles son sus componentes principales.
- Qué responsabilidad cumple el sistema operativo.
- Cómo se relacionan Terminal, Shell, Runtime y herramientas de desarrollo.
- Qué diferencia existe entre Development Environment y Project Environment.
- Por qué dos desarrolladores pueden obtener resultados diferentes utilizando el mismo código.
- Qué significa preparar un entorno de desarrollo.
- Cómo identificar los componentes de tu propio entorno.

---

## 🧠 1. ¿Qué es un Development Environment?

Un **Development Environment** es el conjunto de sistemas, herramientas, configuraciones y recursos que permiten a un desarrollador construir, ejecutar, comprobar y mantener software.

Conceptualmente:

```text
Development Environment
│
├── Operating System
├── File System
├── Terminal and Shell
├── Code Editor
├── Development Tools
├── Runtimes
├── Configuration
└── Project Dependencies
```

No todos los entornos necesitan exactamente los mismos componentes.

Por ejemplo, un desarrollador frontend puede utilizar herramientas diferentes a las de alguien que desarrolla aplicaciones móviles o sistemas embebidos.

Sin embargo, ambos necesitan un entorno adecuado para realizar su trabajo.

**Idea fundamental:** el Development Environment no es una aplicación específica. Es el conjunto de elementos que hacen posible nuestro trabajo de desarrollo.

---

## 🏗️ 2. ¿Por qué necesitamos un Development Environment?

Imagina que escribimos este programa:

```js
function greet(name) {
  return `Hello, ${name}!`;
}

console.log(greet("Developer"));
```

El código contiene instrucciones JavaScript.

Pero escribirlas en un archivo no significa que automáticamente se ejecutarán.

Necesitamos un entorno capaz de interpretarlas o ejecutarlas mediante las herramientas correspondientes.

Por ejemplo, si utilizamos Node.js:

```text
JavaScript Source Code
         ↓
Node.js Runtime
         ↓
Operating System
         ↓
Program Execution
```

Este diagrama es una simplificación conceptual.

El Runtime utiliza servicios del sistema operativo y recursos de la computadora para ejecutar el programa.

El editor nos ayuda a escribir el código, pero no es necesariamente quien lo ejecuta.

Aquí comenzamos a distinguir responsabilidades.

---

## 🖥️ 3. Operating System

El **Operating System (OS)** es el software que administra los recursos fundamentales de una computadora y proporciona servicios para ejecutar aplicaciones.

Algunos ejemplos son:

```text
macOS
Windows
Linux
```

El sistema operativo administra aspectos como:

- Procesos.
- Memoria.
- Archivos y directorios.
- Permisos.
- Dispositivos.
- Comunicación con otros sistemas.

Nuestro Development Environment funciona sobre esta base.

Por ejemplo:

```text
Development Tools
        ↓
Operating System
        ↓
Hardware
```

Esto no significa que cada herramienta interactúe directamente con el Hardware.

El sistema operativo proporciona mecanismos y abstracciones que permiten utilizar los recursos disponibles.

### ¿Por qué importa para un desarrollador?

Porque el sistema operativo influye en cómo:

- Instalamos herramientas.
- Escribimos rutas.
- Administramos permisos.
- Configuramos variables de entorno.
- Ejecutamos programas.
- Trabajamos con procesos.

Más adelante estudiaremos las particularidades de macOS, Windows y Linux.

---

## 📁 4. File System

El **File System** permite organizar y acceder a archivos y directorios.

Cuando creamos un proyecto, necesitamos almacenar elementos como:

```text
my-project/
├── src/
│   └── index.js
├── package.json
└── README.md
```

Estos elementos existen dentro de un sistema de archivos.

Un directorio puede contener otros directorios y archivos.

### Paths

Un **Path** identifica una ubicación dentro del sistema de archivos.

Por ejemplo, en macOS:

```text
/Users/developer/projects/my-project
```

En Linux:

```text
/home/developer/projects/my-project
```

En Windows:

```text
C:\Users\Developer\Projects\my-project
```

Las rutas pueden variar según el sistema operativo y su configuración.

### Absolute vs Relative Paths

Un **Absolute Path** identifica una ubicación desde una raíz del sistema de archivos.

Por ejemplo:

```text
/Users/developer/projects/my-project
```

Un **Relative Path** se interpreta respecto de una ubicación de referencia, como el directorio de trabajo actual.

Por ejemplo:

```text
./src/index.js
```

Comprender las rutas será importante cuando trabajemos con configuraciones, comandos y herramientas.

Profundizaremos en su utilización práctica dentro de `02-terminal-and-shell`.

---

## 💻 5. Terminal and Shell

Estos dos conceptos suelen confundirse.

Pero no significan lo mismo.

### Terminal

Una **Terminal** es una interfaz que permite interactuar con un entorno de línea de comandos.

Ejemplos:

```text
Windows Terminal
Terminal.app
iTerm2
```

### Shell

Un **Shell** es un programa que interpreta instrucciones y permite ejecutar comandos.

Ejemplos:

```text
PowerShell
Bash
Zsh
```

Conceptualmente:

```text
Developer
    ↓
Terminal
    ↓
Shell
    ↓
Command Execution
```

Por ejemplo, cuando escribimos:

```bash
git --version
```

el Shell interpreta el comando y busca cómo ejecutarlo.

La Terminal muestra la interacción.

**Importante:** Terminal y Shell son componentes relacionados, pero tienen responsabilidades diferentes.

En el módulo `02-terminal-and-shell` aprenderemos cómo funcionan los comandos, argumentos, redirecciones y otros mecanismos.

---

## ⚙️ 6. Development Tools

Las **Development Tools** son herramientas que ayudan a realizar tareas relacionadas con la construcción y mantenimiento de software.

Por ejemplo:

| Herramienta | Responsabilidad principal |
|---|---|
| Git | Control de versiones |
| Node.js | Runtime de JavaScript |
| pnpm | Administración de Packages |
| TypeScript | Sistema de tipos y herramientas de compilación |
| ESLint | Análisis estático mediante reglas |
| Prettier | Formato de código |
| Vite | Servidor de desarrollo y herramientas de Build |
| Nx | Orquestación de proyectos y tareas |

Estas herramientas no son equivalentes.

Cada una cubre responsabilidades diferentes.

Además, algunas pueden integrarse entre sí.

Por ejemplo:

```text
Project
   ↓
Package Manager
   ↓
Project Dependencies
   ↓
Development Tools
   ↓
Build / Validation
```

No necesitamos instalar todas estas herramientas para comenzar.

Las incorporaremos progresivamente cuando lleguemos a los módulos correspondientes.

---

## ▶️ 7. Runtime

Un **Runtime** proporciona un entorno de ejecución para determinados programas.

Por ejemplo, Node.js permite ejecutar JavaScript fuera del navegador.

Podemos tener:

```text
JavaScript File
      ↓
Node.js
      ↓
Execution
```

Sin embargo, JavaScript también puede ejecutarse en navegadores, que proporcionan sus propios entornos de ejecución.

Por tanto:

**JavaScript no depende exclusivamente de Node.js.**

El Runtime que necesitamos dependerá del tipo de aplicación y del entorno donde debe ejecutarse.

Más adelante estudiaremos Node.js y la administración de versiones dentro de `04-runtime-management`.

---

## 🧰 8. Code Editor

Un **Code Editor** es una herramienta que facilita la escritura y modificación de código fuente.

Por ejemplo:

```text
Visual Studio Code
WebStorm
Neovim
```

Un editor puede proporcionar capacidades como:

- Syntax Highlighting.
- Autocompletion.
- Code Navigation.
- Integrated Terminal.
- Extensions.
- Debugging Integration.

Pero debemos distinguir:

```text
Code Editor
     ≠
Runtime
```

El editor permite trabajar con el código.

El Runtime permite ejecutar determinados programas.

Algunos editores integran herramientas que facilitan la ejecución, pero eso no significa que todas esas responsabilidades pertenezcan al editor.

Estudiaremos su configuración en `03-editor-and-workspace`.

---

## 🔧 9. Configuration

Un Development Environment también depende de configuraciones.

Por ejemplo:

```text
Environment Variables
PATH
Shell Configuration
Editor Preferences
Tool Versions
Project Configuration
```

Estas configuraciones pueden afectar cómo se comportan las herramientas.

Imagina que instalamos Git correctamente.

Sin embargo, al ejecutar:

```bash
git --version
```

el Shell no consigue encontrar el comando.

Una posible causa es que la ubicación del ejecutable no esté disponible mediante los mecanismos de búsqueda correspondientes.

Aquí aparece un concepto fundamental:

**PATH**.

---

## 🧭 10. Environment Variables y PATH

Una **Environment Variable** es un valor identificado mediante un nombre que puede formar parte del entorno de un proceso.

Por ejemplo:

```text
HOME
USER
PATH
```

Los nombres disponibles y su comportamiento pueden variar según el sistema operativo.

`PATH` es una variable especialmente importante para los desarrolladores.

Habitualmente contiene una lista de directorios utilizados para localizar ejecutables cuando escribimos comandos sin indicar su ruta completa.

Conceptualmente:

```text
Developer types:
git
     ↓
Shell searches for command
     ↓
Executable Resolution
     ↓
Git Executable
     ↓
Execution
```

La búsqueda real depende del Shell y del sistema operativo: pueden intervenir aliases, funciones, comandos integrados y otras reglas.

Por eso `PATH` es una parte importante de la resolución de comandos, pero no el único mecanismo.

### Ejemplo conceptual

Imagina que Git se encuentra en:

```text
/usr/bin/git
```

Si el entorno puede localizar ese ejecutable, podremos utilizar:

```bash
git --version
```

sin escribir su ruta completa.

No modificaremos `PATH` todavía.

Primero aprenderemos a identificarlo y comprender su funcionamiento.

---

## 🧩 11. Development Environment vs Project Environment

Estos conceptos están relacionados, pero conviene diferenciarlos.

### Development Environment

Representa el entorno general donde trabajamos como desarrolladores.

Por ejemplo:

```text
Developer Machine
│
├── Operating System
├── Terminal
├── Shell
├── Git
├── Code Editor
└── Installed Tools
```

### Project Environment

Podemos utilizar este término para referirnos a los requisitos y configuraciones que necesita un proyecto específico.

Por ejemplo:

```text
Project A
│
├── Node.js Version Requirement
├── Package Manager Requirement
├── Dependencies
└── Environment Configuration
```

Otro proyecto podría necesitar:

```text
Project B
│
├── Different Node.js Version
├── Different Dependencies
└── Different Configuration
```

**Project Environment** es aquí una distinción conceptual para nuestro aprendizaje; no representa un estándar universal con una única definición.

### Relación entre ambos

```text
Development Environment
        ↓
Supports
        ↓
Project A
Project B
Project C
```

Nuestro entorno general debe permitir trabajar con proyectos que pueden tener requisitos diferentes.

Esto explica por qué posteriormente estudiaremos gestores de versiones.

---

## 👥 12. ¿Por qué dos desarrolladores pueden obtener resultados diferentes?

Imagina que dos personas trabajan con el mismo Repository.

```text
Developer A
    ↓
Same Repository
    ↓
Application Works
```

```text
Developer B
    ↓
Same Repository
    ↓
Application Fails
```

¿Cómo es posible?

Porque compartir el mismo código no significa necesariamente compartir el mismo entorno.

Podrían existir diferencias en:

| Componente | Developer A | Developer B |
|---|---|---|
| Operating System | macOS | Windows |
| Node.js | Version A | Version B |
| Package Manager | Configuración A | Configuración B |
| Environment Variables | Definidas | Incompletas |
| Dependencies | Instaladas | No instaladas |

Estos son ejemplos de posibles diferencias, no una afirmación de que los sistemas deban comportarse de forma distinta.

El problema aparece cuando el proyecto depende de condiciones que no están correctamente declaradas o documentadas.

---

## 🔁 13. Reproducible Development Environment

Un entorno reproducible busca que otras personas puedan preparar condiciones suficientemente equivalentes para trabajar correctamente con un proyecto.

Conceptualmente:

```text
Repository
    ↓
Documented Requirements
    ↓
Environment Setup
    ↓
Dependency Installation
    ↓
Validation
    ↓
Working Project
```

Para conseguirlo pueden ser importantes:

- Versiones de herramientas.
- Declaración de dependencias.
- Lockfiles.
- Configuraciones compartidas.
- Variables de entorno requeridas.
- Documentación de instalación.
- Comandos de verificación.

No todos estos elementos se configuran dentro de este módulo.

Los estudiaremos progresivamente.

La reproducibilidad será uno de los objetivos principales de nuestro Mastery.

---

## 🏢 14. Development Environment en equipos profesionales

En un equipo, cada desarrollador puede utilizar preferencias personales.

Por ejemplo:

```text
Developer A → VS Code
Developer B → WebStorm
Developer C → Neovim
```

Pero los proyectos pueden necesitar requisitos compartidos:

```text
Required Runtime
Package Manager
Dependencies
Formatting Rules
Linting Rules
Build Commands
```

Esto introduce una diferencia importante:

**Personal Preferences vs Project Requirements.**

No necesitamos imponer todas las preferencias individuales al equipo.

Pero sí necesitamos documentar y compartir los requisitos que afectan al funcionamiento del proyecto.

Estudiaremos esta distinción en los siguientes documentos:

- `02-local-vs-project-configuration.md`
- `03-user-vs-team-configuration.md`

---

## 🔍 15. ¿Qué significa preparar un Development Environment?

Preparar un entorno de desarrollo no consiste solamente en instalar herramientas.

También implica comprobar que podemos utilizarlas correctamente.

Podemos pensar en cinco actividades:

```text
Understand Requirements
        ↓
Prepare Environment
        ↓
Install Required Tools
        ↓
Configure
        ↓
Verify
```

### Understand Requirements

Identificar qué necesita nuestro proyecto.

### Prepare Environment

Comprobar que nuestro sistema cumple los requisitos básicos.

### Install Required Tools

Incorporar las herramientas necesarias.

### Configure

Establecer las configuraciones correspondientes.

### Verify

Comprobar que el entorno funciona según lo esperado.

Este último paso es fundamental.

Una instalación terminada no garantiza que la herramienta esté correctamente disponible o configurada.

---

## 🧪 16. Primera observación de nuestro entorno

Antes de modificar configuraciones, podemos observar algunos componentes de nuestra computadora.

El objetivo no será instalar nada.

Queremos identificar qué sistema estamos utilizando y qué herramientas tenemos disponibles.

### Step 1 — Identifica tu sistema operativo

Determina si trabajas con:

```text
macOS
Windows
Linux
```

También puedes consultar su versión mediante las opciones del sistema.

### Step 2 — Identifica tu Terminal y Shell

Por ejemplo:

```text
Terminal Application:
Terminal.app

Shell:
Zsh
```

O:

```text
Terminal Application:
Windows Terminal

Shell:
PowerShell
```

No debemos asumir que utilizar una Terminal específica implica utilizar siempre el mismo Shell.

### Step 3 — Comprueba Git

Si Git está disponible, ejecuta:

```bash
git --version
```

Podrías obtener un resultado similar a:

```text
git version 2.x.x
```

La versión exacta dependerá de tu instalación.

Si aparece un error, no significa necesariamente que tu computadora tenga un problema grave.

Podría indicar que Git no está instalado o que el Shell no consigue localizarlo.

### Step 4 — Comprueba Node.js

Si Node.js está disponible:

```bash
node --version
```

Ejemplo de resultado:

```text
v22.x.x
```

No necesitas instalar Node.js si todavía no lo tienes.

Lo estudiaremos en su módulo correspondiente.

### Step 5 — Registra tus observaciones

Puedes completar esta tabla:

| Component | Your Environment |
|---|---|
| Operating System | |
| OS Version | |
| Terminal | |
| Shell | |
| Code Editor | |
| Git Available | |
| Node.js Available | |

No necesitas publicar esta información en el Repository.

Es un ejercicio de observación de tu entorno personal.

---

## ⚠️ 17. Errores comunes

### 1. Confundir Development Environment con Code Editor

El editor es solamente uno de los componentes del entorno.

### 2. Confundir Terminal con Shell

La Terminal proporciona una interfaz; el Shell interpreta comandos y permite interactuar con el sistema.

### 3. Pensar que todos los desarrolladores necesitan herramientas idénticas

Algunas preferencias pueden variar, aunque los requisitos del proyecto deben mantenerse compatibles.

### 4. Pensar que instalar una herramienta garantiza que funcione

Después de instalarla debemos verificar que esté disponible y correctamente configurada.

### 5. Confundir Runtime con Package Manager

Node.js y pnpm cumplen responsabilidades diferentes.

### 6. Pensar que compartir código garantiza resultados idénticos

Las diferencias del entorno pueden afectar al comportamiento del proyecto.

### 7. Modificar PATH sin comprenderlo

Una modificación incorrecta puede dificultar la localización de herramientas.

Primero debemos aprender a inspeccionarlo.

### 8. Instalar todas las herramientas desde el principio

Incorporaremos herramientas cuando comprendamos su responsabilidad y tengamos una necesidad concreta.

---

## 🧠 18. Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es un Development Environment?
2. ¿Por qué un editor de código no representa todo el entorno?
3. ¿Qué responsabilidad tiene el Operating System?
4. ¿Qué es un File System?
5. ¿Qué diferencia existe entre Absolute Path y Relative Path?
6. ¿Qué diferencia existe entre Terminal y Shell?
7. ¿Qué es un Runtime?
8. ¿Qué papel cumplen las Development Tools?
9. ¿Qué es una Environment Variable?
10. ¿Para qué sirve `PATH`?
11. ¿Qué diferencia conceptual existe entre Development Environment y Project Environment?
12. ¿Por qué dos desarrolladores pueden obtener resultados diferentes con el mismo código?
13. ¿Qué significa preparar un entorno reproducible?
14. ¿Por qué debemos verificar una herramienta después de instalarla?
15. ¿Qué componentes puedes identificar actualmente en tu propio entorno?

---

## 💡 Idea clave

Un Development Environment es el conjunto de componentes que permite desarrollar software.

No debemos pensar únicamente en herramientas individuales.

Debemos comprender cómo se relacionan:

```text
Developer
    ↓
Editor / Terminal
    ↓
Shell / Development Tools
    ↓
Runtime / Processes
    ↓
Operating System
    ↓
Hardware
```

Este diagrama representa una visión conceptual: las interacciones reales pueden seguir diferentes caminos.

**Comprender nuestro Development Environment nos permite trabajar con mayor autonomía, preparar proyectos de manera consistente y diagnosticar problemas sin depender exclusivamente de instrucciones memorizadas.**

---

## 🚀 Siguiente paso

Ahora sabemos qué es un Development Environment y cuáles son sus componentes principales.

El siguiente paso será comprender dónde viven las configuraciones y por qué una configuración de nuestra computadora no es necesariamente una configuración del proyecto.

👉 [Local vs Project Configuration](./02-local-vs-project-configuration.md)  