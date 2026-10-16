# Development Environment Layers

En los documentos anteriores aprendimos qué es un Development Environment, cómo se organizan sus configuraciones y por qué necesitamos entornos reproducibles.

Ahora debemos conectar estos conceptos mediante un modelo que nos permita comprender **cómo se relacionan las diferentes capas de nuestro entorno de desarrollo**.

Cuando escribimos código, ejecutamos un comando o iniciamos una aplicación, intervienen distintos componentes.

Cada uno tiene una responsabilidad específica.

Comprender estas responsabilidades nos permitirá identificar problemas con mayor precisión y evitar confundir herramientas que cumplen funciones diferentes.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué significa organizar un Development Environment en capas.
- Cuáles son las capas principales de nuestro modelo conceptual.
- Qué responsabilidad cumplen Hardware y Operating System.
- Cómo se relacionan File System, Processes y Environment Variables.
- Qué diferencia existe entre Terminal y Shell.
- Cómo se localiza y ejecuta un comando.
- Qué responsabilidad tiene un Runtime.
- Cómo intervienen los Package Managers y las Development Tools.
- Qué relación existe entre el entorno general y la configuración de un proyecto.
- Por qué un error puede originarse en una capa diferente de aquella donde se manifiesta.
- Cómo utilizar este modelo para diagnosticar problemas.

---

## 🧠 1. ¿Por qué necesitamos un modelo por capas?

Imagina que estamos trabajando en un proyecto JavaScript.

Abrimos nuestra Terminal y ejecutamos:

```bash
node --version
```

El sistema responde:

```text
command not found
```

¿Qué ha sucedido?

Podríamos pensar inmediatamente que Node.js no está instalado.

Sin embargo, también existen otras posibilidades:

- Node.js está instalado, pero su ejecutable no está disponible en la búsqueda de comandos.
- Estamos utilizando un Shell con una configuración diferente.
- Un gestor de versiones no ha activado la versión esperada.
- Existe un problema con las rutas o permisos.
- Estamos ejecutando el comando dentro de un entorno diferente al habitual.

El mensaje aparece en la Terminal, pero el origen del problema puede encontrarse en otro componente.

Por eso necesitamos un modelo que nos ayude a identificar responsabilidades.

---

## 🏗️ 2. Nuestro modelo conceptual de capas

Podemos representar el entorno mediante el siguiente esquema:

```text
Developer
    │
    ▼
┌──────────────────────────┐
│ Editor / Terminal        │
├──────────────────────────┤
│ Shell / Commands         │
├──────────────────────────┤
│ Development Tools        │
├──────────────────────────┤
│ Runtime / Processes      │
├──────────────────────────┤
│ Operating System         │
├──────────────────────────┤
│ Hardware                 │
└──────────────────────────┘
```

Este esquema es una herramienta de aprendizaje.

**No representa una arquitectura técnica rígida ni una secuencia obligatoria de ejecución.**

Por ejemplo, un editor puede iniciar procesos directamente, un Runtime utiliza servicios del sistema operativo y un programa puede ejecutarse sin que intervenga un Shell interactivo.

Además, componentes como File System, Environment Variables y Project Configuration atraviesan varias de estas capas.

El propósito del modelo es comprender responsabilidades, no memorizar una jerarquía artificial.

---

## 🧱 3. Layer 1 — Hardware

El **Hardware** representa los componentes físicos de una computadora.

Por ejemplo:

```text
Hardware
│
├── CPU
├── RAM
├── Storage
└── Network Interfaces
```

Estos componentes proporcionan los recursos necesarios para ejecutar software.

### CPU

Ejecuta instrucciones y participa en el procesamiento de los programas.

### RAM

Almacena temporalmente información utilizada por los procesos en ejecución.

### Storage

Permite conservar archivos, aplicaciones y otros datos.

### Network Interfaces

Permiten la comunicación con otros dispositivos y servicios.

### ¿Por qué importa para un desarrollador?

Porque determinadas herramientas y aplicaciones pueden tener requisitos relacionados con:

- Arquitectura del procesador.
- Memoria disponible.
- Espacio de almacenamiento.
- Conectividad.
- Compatibilidad de binarios.

Por ejemplo, una herramienta compilada para una arquitectura específica puede no ejecutarse directamente en otra.

```text
Tool Binary
    +
CPU Architecture
    ↓
Compatibility Requirement
```

No necesitamos estudiar arquitectura de computadores en profundidad en este módulo.

Pero debemos comprender que el Hardware establece condiciones que pueden afectar al software.

---

## 🖥️ 4. Layer 2 — Operating System

El **Operating System** administra recursos y proporciona servicios para que los programas puedan ejecutarse.

Ejemplos:

```text
macOS
Windows
Linux
```

Entre sus responsabilidades encontramos:

```text
Operating System
│
├── Process Management
├── Memory Management
├── File System Access
├── Permissions
├── Device Management
└── Networking Services
```

El sistema operativo actúa como una base común para múltiples aplicaciones.

Por ejemplo:

```text
Node.js
Git
Code Editor
    │
    ▼
Operating System
    │
    ▼
Hardware
```

Cada aplicación utiliza diferentes servicios del sistema operativo.

### Ejemplo: permisos

Imagina que intentamos modificar un archivo.

El programa puede solicitar la operación, pero el sistema operativo participa en la comprobación y aplicación de los permisos correspondientes.

Si no tenemos autorización, la operación puede fallar.

Por tanto, un error al guardar un archivo no significa necesariamente que el editor esté defectuoso.

Podría tratarse de un problema de permisos.

---

## 📁 5. File System: una responsabilidad transversal

El File System permite organizar, almacenar y acceder a archivos y directorios.

Por ejemplo:

```text
projects/
└── my-app/
    ├── src/
    │   └── index.js
    ├── package.json
    └── README.md
```

Tanto nuestro editor como las herramientas de desarrollo necesitan acceder a estos archivos.

```text
Code Editor ───────┐
                   │
Git ───────────────┼──→ File System
                   │
Node.js ───────────┘
```

El acceso se realiza mediante mecanismos proporcionados por el sistema operativo y las bibliotecas correspondientes.

### Paths

Una ruta identifica una ubicación dentro del sistema de archivos.

Por ejemplo:

**macOS**

```text
/Users/developer/projects/my-app
```

**Linux**

```text
/home/developer/projects/my-app
```

**Windows**

```text
C:\Users\Developer\Projects\my-app
```

Las diferencias entre sistemas pueden afectar a Scripts y herramientas que manipulan rutas.

Por eso, cuando desarrollemos automatizaciones, debemos evitar asumir que todas las plataformas utilizan exactamente las mismas convenciones.

---

## ⚙️ 6. Processes: programas en ejecución

Un **Process** es una instancia de un programa en ejecución, administrada por el sistema operativo.

Por ejemplo, podemos tener procesos asociados a:

```text
Code Editor
Browser
Node.js Application
Git Command
Terminal Application
```

Cuando ejecutamos una aplicación Node.js, el sistema operativo crea o administra el proceso correspondiente.

Conceptualmente:

```text
Program
    ↓
Execution
    ↓
Process
    ↓
Operating System Resources
```

### Program vs Process

Un programa puede existir como un conjunto de archivos en nuestro almacenamiento.

Un proceso representa una ejecución de ese programa.

Por ejemplo:

```text
Node.js Executable
        ↓
Run Application
        ↓
Node.js Process
```

Podemos ejecutar varias instancias de un mismo programa y obtener diferentes procesos.

### ¿Por qué importa?

Porque durante el desarrollo encontraremos situaciones como:

- Un servidor que continúa ejecutándose.
- Un puerto ocupado.
- Un proceso que consume demasiada memoria.
- Una aplicación que debemos detener o reiniciar.

Estudiaremos comandos y herramientas para trabajar con procesos en módulos posteriores.

---

## 💻 7. Layer 3 — Terminal

Una **Terminal** es una aplicación o interfaz que nos permite interactuar con programas de línea de comandos.

Ejemplos:

```text
Windows Terminal
Terminal.app
iTerm2
```

Una Terminal puede mostrar:

- Texto.
- Resultados de comandos.
- Mensajes de error.
- Salida de procesos.
- Interfaces de línea de comandos interactivas.

Por ejemplo:

```text
Developer
    ↓
Terminal
    ↓
Command-line Interaction
```

Sin embargo, la Terminal no es necesariamente quien interpreta el significado de cada comando.

Esa responsabilidad suele pertenecer al Shell.

---

## 🐚 8. Layer 4 — Shell

Un **Shell** es un programa que proporciona una interfaz para ejecutar comandos y automatizar tareas.

Ejemplos:

```text
Bash
Zsh
PowerShell
```

El Shell puede encargarse de:

- Interpretar comandos.
- Procesar argumentos.
- Gestionar variables.
- Ejecutar programas.
- Redirigir entrada y salida.
- Conectar procesos mediante Pipes.
- Ejecutar Scripts.

Por ejemplo:

```bash
git --version
```

En una sesión habitual:

```text
Developer
    ↓
Terminal
    ↓
Shell
    ↓
Git Executable
```

### Terminal vs Shell

| Componente | Responsabilidad |
|---|---|
| Terminal | Proporcionar la interfaz de interacción |
| Shell | Interpretar comandos y coordinar su ejecución |

Podemos utilizar diferentes Shells dentro de una misma aplicación de Terminal.

Por ejemplo, Windows Terminal puede abrir sesiones de PowerShell y otros entornos de línea de comandos.

**La Terminal y el Shell trabajan juntos, pero no son la misma herramienta.**

---

## 🧭 9. ¿Cómo encuentra el Shell un comando?

Imagina que escribimos:

```bash
git --version
```

El Shell necesita determinar qué significa `git` y cómo ejecutarlo.

De manera simplificada:

```text
Command Entered
      ↓
Shell Interpretation
      ↓
Command Resolution
      ↓
Executable Found
      ↓
Process Execution
      ↓
Output
```

La resolución puede involucrar:

- Aliases.
- Funciones.
- Comandos integrados.
- Ejecutables disponibles mediante `PATH`.
- Reglas particulares del Shell.

### PATH

`PATH` es una variable de entorno que habitualmente contiene directorios utilizados para localizar ejecutables.

Por ejemplo, en un entorno Unix-like podría contener:

```text
/usr/local/bin:/usr/bin:/bin
```

En Windows, los directorios suelen separarse mediante punto y coma.

Un ejemplo simplificado:

```text
C:\Windows\System32;C:\Tools
```

Estos valores son ilustrativos.

### Ejemplo

Supongamos que el ejecutable de Git está ubicado en:

```text
/usr/bin/git
```

Si el mecanismo de búsqueda puede localizarlo, podremos escribir:

```bash
git --version
```

sin especificar su ruta completa.

### ¿Qué sucede si no se encuentra?

Podríamos recibir un error similar a:

```text
command not found
```

Pero debemos evitar asumir una causa única.

Puede faltar la herramienta, existir una configuración incorrecta o estar utilizando un entorno distinto.

---

## 🌍 10. Environment Variables: contexto de los procesos

Las **Environment Variables** son valores identificados mediante nombres que forman parte del entorno de un proceso.

Por ejemplo:

```text
PATH
HOME
TEMP
NODE_ENV
```

No todas existen en todos los sistemas operativos.

Tampoco todas tienen el mismo significado.

### Relación con los procesos

Cuando un proceso inicia otro proceso, normalmente puede proporcionarle un conjunto de variables de entorno.

```text
Parent Process
      │
      ├── PATH
      ├── HOME
      └── OTHER_VARIABLES
      │
      ▼
Child Process
```

El proceso hijo recibe el entorno que se le proporciona al iniciarse.

Esto ayuda a explicar por qué modificar una variable en una sesión no implica que todas las aplicaciones que ya estaban ejecutándose reciban automáticamente ese cambio.

### Ejemplo conceptual

Una aplicación puede utilizar:

```text
API_BASE_URL
```

para conocer la dirección de un servicio.

Si esa variable no está disponible para el proceso, la aplicación puede fallar o utilizar un comportamiento alternativo, según su implementación.

**Las variables de entorno conectan la configuración del entorno con los procesos que ejecutamos.**

---

## ▶️ 11. Layer 5 — Runtime

Un **Runtime** proporciona las capacidades necesarias para ejecutar programas de un determinado ecosistema.

Por ejemplo:

```text
JavaScript Application
        ↓
Node.js Runtime
        ↓
Operating System
```

Node.js permite ejecutar JavaScript fuera del navegador y proporciona APIs para realizar operaciones como:

- Acceder a archivos.
- Trabajar con procesos.
- Comunicarse mediante redes.
- Ejecutar operaciones asíncronas.

### Ejemplo

Tenemos un archivo:

```text
hello.js
```

Con el siguiente contenido:

```js
console.log("Hello, Developer!");
```

Podemos ejecutarlo mediante:

```bash
node hello.js
```

Conceptualmente:

```text
Developer
    ↓
Shell
    ↓
Node.js Executable
    ↓
JavaScript Program
    ↓
Output
```

El Shell inicia el comando y Node.js ejecuta el programa JavaScript.

### Una distinción importante

```text
Shell ≠ Runtime
```

El Shell interpreta comandos y coordina su ejecución.

Node.js proporciona un entorno para ejecutar JavaScript.

Aunque ambos son programas que se ejecutan sobre el sistema operativo, sus responsabilidades son diferentes.

---

## 📦 12. Package Managers

Un **Package Manager** ayuda a administrar paquetes de software.

Pero existen diferentes tipos según el ecosistema.

### Operating System Package Managers

Permiten instalar y administrar software del sistema.

Ejemplos:

```text
Homebrew
apt
dnf
```

### JavaScript Package Managers

Permiten administrar dependencias y otras operaciones relacionadas con proyectos JavaScript.

Ejemplos:

```text
npm
pnpm
Yarn
```

No debemos confundirlos.

Por ejemplo:

```text
Operating System
      ↓
System Package Manager
      ↓
System Tools
```

Y:

```text
JavaScript Project
      ↓
JavaScript Package Manager
      ↓
Project Dependencies
```

Estas representaciones muestran responsabilidades diferentes, no una dependencia obligatoria entre ambos tipos de gestores.

### ¿Dónde encajan en nuestro modelo?

Los Package Managers son herramientas que utilizamos dentro del entorno de desarrollo.

No constituyen una capa de ejecución obligatoria entre el Shell y el Runtime.

Por ejemplo, podemos utilizar un Package Manager para instalar dependencias y posteriormente ejecutar una aplicación con Node.js.

Estudiaremos los Package Managers de JavaScript en `05-package-managers`.

---

## 🧰 13. Development Tools

Las Development Tools permiten realizar tareas específicas durante el desarrollo.

Por ejemplo:

| Herramienta | Responsabilidad |
|---|---|
| Git | Control de versiones |
| ESLint | Análisis estático |
| Prettier | Formato de código |
| TypeScript | Análisis de tipos y compilación |
| Vite | Desarrollo y Build |
| Nx | Orquestación de tareas y proyectos |

Estas herramientas pueden utilizar distintos mecanismos de ejecución.

Por ejemplo, muchas herramientas del ecosistema JavaScript se ejecutan utilizando Node.js.

Otras, como Git, disponen de sus propios ejecutables.

Por tanto:

```text
Development Tool
        ↓
Its Execution Requirements
        ↓
Operating System
```

No debemos asumir que todas las herramientas necesitan el mismo Runtime.

### Ejemplo

Podemos utilizar:

```bash
git status
```

para consultar el estado de un Repository.

Y:

```bash
node hello.js
```

para ejecutar un programa JavaScript.

Ambos comandos pueden iniciarse desde el mismo Shell, pero realizan tareas diferentes.

---

## 📝 14. Code Editor y sus integraciones

El Code Editor nos permite trabajar con archivos y herramientas de desarrollo.

Por ejemplo:

```text
VS Code
│
├── File Editing
├── Extensions
├── Integrated Terminal
├── Language Support
└── Debugging Integration
```

Un editor puede integrar una Terminal, ejecutar tareas o comunicarse con herramientas externas.

Pero debemos distinguir entre:

- La interfaz que utilizamos.
- La herramienta que realiza la operación.
- El proceso donde se ejecuta.
- La configuración que determina su comportamiento.

### Ejemplo

Cuando utilizamos una extensión de ESLint en el editor:

```text
Code Editor
     ↓
ESLint Integration
     ↓
ESLint Analysis
     ↓
Diagnostics
```

La extensión facilita la integración.

Las reglas de análisis corresponden a ESLint y a su configuración.

Esta separación será importante cuando estudiemos Editor, Formatting y Linting.

---

## 📁 15. Project Configuration: reglas sobre nuestras herramientas

Hasta ahora hemos estudiado componentes generales del entorno.

Pero cada proyecto puede establecer requisitos específicos.

Por ejemplo:

```text
my-project/
│
├── package.json
├── tsconfig.json
├── eslint.config.js
└── README.md
```

Estos archivos pueden definir cómo deben comportarse determinadas herramientas dentro del proyecto.

Conceptualmente:

```text
Development Tool
        +
Project Configuration
        ↓
Project-specific Behavior
```

Por ejemplo:

```text
ESLint
    +
eslint.config.js
    ↓
Project Lint Rules
```

Esto conecta con los documentos anteriores:

- Local vs Project Configuration.
- User vs Team Configuration.
- Reproducible Environments.

Las herramientas existen en nuestro entorno, mientras que el proyecto puede declarar los requisitos y reglas que deben respetar.

---

## 🔄 16. Ejemplo completo: ejecutar una aplicación JavaScript

Vamos a conectar todos los componentes.

Imagina que tenemos:

```text
my-app/
└── hello.js
```

Y nuestro archivo contiene:

```js
const message = "Hello, Developer!";

console.log(message);
```

Abrimos la Terminal y ejecutamos:

```bash
node hello.js
```

### Step 1 — Developer Interaction

Escribimos el comando en una sesión de Terminal.

### Step 2 — Shell Interpretation

El Shell interpreta el comando y sus argumentos.

```text
Command: node
Argument: hello.js
```

### Step 3 — Command Resolution

El Shell determina qué ejecutable corresponde a `node`.

### Step 4 — Process Execution

El sistema operativo participa en la creación del proceso correspondiente.

### Step 5 — Runtime Execution

Node.js carga y ejecuta el archivo JavaScript.

### Step 6 — Operating System Services

Durante la ejecución, Node.js utiliza recursos y servicios del sistema operativo cuando los necesita.

### Step 7 — Output

El programa escribe:

```text
Hello, Developer!
```

La salida llega a nuestra sesión de Terminal.

### Diagrama completo

```text
Developer
    │
    │ node hello.js
    ▼
Terminal
    │
    ▼
Shell
    │
    │ Resolve command
    ▼
Node.js Executable
    │
    │ Start process
    ▼
Node.js Runtime
    │
    │ Execute JavaScript
    ▼
console.log()
    │
    │ Standard Output
    ▼
Terminal
    │
    ▼
Hello, Developer!
```

El Operating System interviene en la creación y ejecución del proceso, el acceso a archivos y la gestión de entrada y salida.

No aparece como un único paso aislado porque sus servicios participan en distintas partes del flujo.

---

## 🧩 17. Ejemplo completo: instalar dependencias

Ahora imaginemos un proyecto que utiliza pnpm.

Ejecutamos:

```bash
pnpm install
```

De manera conceptual:

```text
Developer
    ↓
Terminal
    ↓
Shell
    ↓
pnpm Command
    ↓
Project Metadata + Lockfile
    ↓
Dependency Resolution / Installation
    ↓
Project Dependencies Available
```

Durante esta operación pueden intervenir:

- El sistema de archivos.
- La conectividad de red.
- El Package Manager.
- La configuración del proyecto.
- La caché o almacenamiento del gestor.
- El Runtime o mecanismo de ejecución correspondiente.

La implementación concreta depende de la herramienta y su versión.

Lo importante es comprender que **instalar dependencias es una operación distinta de ejecutar nuestra aplicación**.

---

## 🔍 18. Troubleshooting: identificar la capa responsable

Nuestro modelo comienza a ser especialmente útil cuando aparece un problema.

### Caso A — Command Not Found

```text
node: command not found
```

Posibles áreas de investigación:

```text
Shell
PATH
Tool Installation
Runtime Version Manager
```

No debemos comenzar modificando el código de la aplicación.

### Caso B — Permission Denied

```text
Permission denied
```

Posibles áreas:

```text
Operating System
File Permissions
Executable Permissions
```

El significado concreto depende de la operación que produjo el error.

### Caso C — Missing Module

```text
Cannot find module
```

Posibles áreas:

```text
Project Dependencies
Module Resolution
Project Configuration
Runtime
```

No siempre significa que debamos reinstalar Node.js.

### Caso D — Port Already in Use

```text
Address already in use
```

Posibles áreas:

```text
Processes
Network Configuration
Application Configuration
```

Puede existir otro proceso utilizando la dirección y el puerto solicitados.

### Caso E — Different Results Between Developers

Posibles áreas:

```text
Runtime Versions
Dependencies
Environment Variables
Operating System
Project Configuration
```

Este caso conecta directamente con Reproducible Environments.

### Principio fundamental

**El lugar donde aparece un error no siempre es el lugar donde se origina.**

Un diagnóstico profesional comienza identificando qué componente es responsable de la operación que falló.

---

## 🧪 19. Práctica: identifica las capas de tu entorno

Vamos a realizar una práctica sencilla y segura.

No necesitamos instalar ni modificar herramientas.

### Step 1 — Identify Your Operating System

Anota:

```text
Operating System:
Version:
```

### Step 2 — Identify Your Terminal and Shell

Por ejemplo:

```text
Terminal: Windows Terminal
Shell: PowerShell
```

O:

```text
Terminal: Terminal.app
Shell: Zsh
```

### Step 3 — Verify Git

Si Git está instalado:

```bash
git --version
```

Identifica:

- Qué comando escribiste.
- Qué Shell lo interpretó.
- Qué herramienta respondió.
- Qué sistema operativo permitió ejecutar el proceso.

### Step 4 — Locate an Executable

Puedes utilizar el comando correspondiente a tu Shell.

**PowerShell**

```powershell
Get-Command git
```

**Bash o Zsh**

```bash
command -v git
```

Estos comandos ayudan a investigar cómo se resuelve `git` en el entorno actual.

La salida puede variar: por ejemplo, puede mostrar un ejecutable, una función, un alias u otra información, dependiendo del Shell.

No modificaremos `PATH` todavía.

### Step 5 — Verify Node.js

Si Node.js está disponible:

```bash
node --version
```

Y, si deseas localizar el comando:

**PowerShell**

```powershell
Get-Command node
```

**Bash o Zsh**

```bash
command -v node
```

Si Node.js no está instalado, puedes omitir esta comprobación.

### Step 6 — Build Your Environment Map

Completa:

```text
My Development Environment
│
├── Hardware Architecture:
├── Operating System:
├── Terminal:
├── Shell:
├── Git:
├── Node.js:
├── Code Editor:
└── Main Projects Directory:
```

No necesitas compartir públicamente rutas personales ni otros datos sensibles.

### Step 7 — Explain the Execution Flow

Utilizando tu propio entorno, intenta explicar:

```text
Developer
    ↓
Terminal
    ↓
Shell
    ↓
Command
    ↓
Process
    ↓
Operating System
```

Responde:

1. ¿Qué componente interpreta el comando?
2. ¿Cómo se localiza el ejecutable?
3. ¿Qué componente administra el proceso?
4. ¿Dónde aparece la salida?
5. ¿Qué investigarías si el comando no se encuentra?

Si puedes explicar este recorrido, habrás construido una base importante para los siguientes módulos.

---

## 🏢 20. ¿Por qué importa este modelo en proyectos profesionales?

En proyectos reales, los problemas no siempre pertenecen exclusivamente al código fuente.

Podemos encontrar errores relacionados con:

```text
Development Environment
│
├── Tool Installation
├── Runtime Compatibility
├── Dependency Management
├── File Permissions
├── Environment Variables
├── Process Execution
└── Project Configuration
```

Comprender las responsabilidades permite investigar de manera más ordenada.

Por ejemplo:

```text
Problem
    ↓
Identify the Operation
    ↓
Identify Responsible Components
    ↓
Inspect Configuration
    ↓
Verify Assumptions
    ↓
Apply a Controlled Fix
    ↓
Validate the Result
```

Este enfoque evita realizar cambios aleatorios.

También facilita comunicar problemas a otros desarrolladores.

En lugar de decir:

> Mi proyecto no funciona.

Podremos describir:

> El Shell no consigue localizar el ejecutable de Node.js en esta sesión.

O:

> La aplicación inicia, pero falla porque falta una variable de entorno requerida.

Cuanto mejor comprendamos las responsabilidades, más precisos serán nuestros diagnósticos.

---

## ⚠️ Errores comunes

### 1. Pensar que las capas representan una secuencia rígida

Nuestro modelo es conceptual. Las herramientas pueden interactuar directamente con diferentes componentes.

### 2. Confundir Terminal con Shell

La Terminal proporciona la interfaz y el Shell interpreta comandos.

### 3. Confundir Shell con Runtime

Bash, Zsh y PowerShell no cumplen la misma responsabilidad que Node.js.

### 4. Pensar que todas las Development Tools necesitan Node.js

Cada herramienta tiene sus propios requisitos de ejecución.

### 5. Pensar que un Package Manager ejecuta necesariamente nuestra aplicación

Administrar dependencias y ejecutar aplicaciones son responsabilidades diferentes, aunque algunas herramientas proporcionen comandos para ambas tareas.

### 6. Suponer que todos los errores de comandos son problemas de instalación

También pueden intervenir rutas, permisos, configuraciones y mecanismos de resolución.

### 7. Confundir un programa con un proceso

El programa representa el software; el proceso es una instancia en ejecución.

### 8. Pensar que las Environment Variables pertenecen exclusivamente al proyecto

Pueden existir en diferentes ámbitos y ser utilizadas por distintos procesos.

### 9. Modificar configuraciones sin identificar el problema

Primero debemos investigar qué componente está fallando.

### 10. Creer que conocer una herramienta significa comprender todo el entorno

El desarrollo profesional requiere comprender cómo interactúan los diferentes componentes.

---

## 🧠 Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Por qué organizamos el Development Environment en capas?
2. ¿Por qué nuestro diagrama no representa una arquitectura rígida?
3. ¿Qué responsabilidad cumple el Hardware?
4. ¿Qué responsabilidad cumple el Operating System?
5. ¿Qué es un Process?
6. ¿Qué diferencia existe entre Program y Process?
7. ¿Qué responsabilidad cumple el File System?
8. ¿Qué diferencia existe entre Terminal y Shell?
9. ¿Cómo puede localizarse un ejecutable?
10. ¿Qué papel cumple `PATH`?
11. ¿Cómo se relacionan las Environment Variables con los procesos?
12. ¿Qué responsabilidad cumple un Runtime?
13. ¿Qué diferencia existe entre un Package Manager del sistema y uno de JavaScript?
14. ¿Qué responsabilidad tiene Project Configuration?
15. ¿Qué componentes intervienen cuando ejecutamos `node hello.js`?
16. ¿Qué componentes intervienen cuando instalamos dependencias?
17. ¿Por qué un error visible en la Terminal puede originarse en otro componente?
18. ¿Qué investigarías ante un error `command not found`?
19. ¿Qué investigarías ante un error `Permission denied`?
20. ¿Cómo utilizarías este modelo para diagnosticar un problema sin realizar cambios aleatorios?

---

## 💡 Idea clave

Un Development Environment no es una colección desordenada de herramientas.

Es un conjunto de componentes que colaboran para permitirnos desarrollar software.

```text
Developer
    │
    ▼
Editor / Terminal
    │
    ▼
Shell / Commands
    │
    ▼
Development Tools / Runtime
    │
    ▼
Processes
    │
    ▼
Operating System
    │
    ▼
Hardware
```

El File System, las Environment Variables y las configuraciones intervienen transversalmente.

**Cada componente tiene responsabilidades específicas, y comprenderlas nos permite identificar problemas, configurar herramientas correctamente y construir entornos más reproducibles.**

El objetivo no es memorizar el diagrama.

Es poder explicar qué ocurre cuando ejecutamos una herramienta y saber dónde investigar cuando algo falla.

---

## 🏁 Cierre de 01 — Concepts

Con este documento completamos los cinco fundamentos de `01-concepts/`:

1. **What Is a Development Environment?** — Comprendimos qué constituye nuestro entorno de desarrollo.
2. **Local vs Project Configuration** — Aprendimos a distinguir configuraciones locales de las compartidas por el proyecto.
3. **User vs Team Configuration** — Diferenciamos preferencias individuales y estándares del equipo.
4. **Reproducible Environments** — Comprendimos cómo reducir diferencias entre entornos.
5. **Development Environment Layers** — Conectamos los componentes y sus responsabilidades.

Ahora tenemos un modelo conceptual para estudiar la preparación de entornos en sistemas operativos concretos.

---

## 🚀 Siguiente paso

Hemos completado los fundamentos comunes.

A continuación estudiaremos cómo preparar y diagnosticar un Development Environment según el sistema operativo.

Nuestra estructura continúa con:

```text
02-macos/
03-windows/
04-linux/
05-best-practices/
```

Estas secciones funcionan como rutas específicas y materiales de referencia. No es necesario dominar los tres sistemas operativos antes de avanzar.

Comenzaremos siguiendo el orden del Repository.

👉 [macOS Development Setup](../02-macos/01-macos-development-setup.md)