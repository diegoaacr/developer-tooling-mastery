# Terminal and Shell

Antes de comenzar a utilizar herramientas como Git, Node.js, npm, pnpm, Docker o Nx, necesitamos comprender uno de los mecanismos fundamentales de nuestro entorno de desarrollo: **la interacción con el sistema operativo mediante una interfaz de línea de comandos**.

Cada vez que ejecutamos un comando, navegamos por directorios, iniciamos un servidor o automatizamos una tarea, estamos utilizando diferentes componentes que trabajan conjuntamente.

Entre ellos encontramos:

- Terminal.
- Shell.
- Commands.
- Executables.
- Processes.
- File System.
- Environment Variables.
- Standard Streams.

Aunque utilizamos estos conceptos diariamente, no todos representan lo mismo.

Este módulo construye los fundamentos necesarios para comprender y dominar **Terminal and Shell**, desde las operaciones más básicas hasta la creación de pequeños Scripts y flujos de trabajo profesionales.

Nuestro objetivo no será memorizar cientos de comandos.

**Queremos comprender cómo funciona la línea de comandos, cómo se relaciona con el sistema operativo y cómo utilizarla para resolver problemas reales de ingeniería de software.**

---

## 🎯 Objetivo

Al finalizar este módulo deberías poder explicar y demostrar:

- Qué es una Command-Line Interface (CLI).
- Qué diferencia existe entre Terminal, Shell y Command.
- Qué sucede cuando escribimos y ejecutamos un comando.
- Qué son los Shells y por qué existen diferentes implementaciones.
- Qué diferencias principales existen entre Bash, Zsh y PowerShell.
- Cómo navegar por el File System desde la línea de comandos.
- Qué son las rutas absolutas y relativas.
- Cómo crear, inspeccionar, copiar, mover y eliminar archivos de forma segura.
- Cómo funcionan los argumentos y las opciones de un comando.
- Cómo descubrir la ayuda y documentación de una herramienta.
- Qué son Standard Input, Standard Output y Standard Error.
- Cómo funcionan Pipes y Redirections.
- Qué son las variables del Shell y las Environment Variables.
- Cómo funciona `PATH` en la resolución de ejecutables.
- Qué son los procesos y cómo inspeccionarlos.
- Qué representan los Exit Codes.
- Qué son los permisos y cómo afectan la ejecución de archivos.
- Cómo combinar comandos para construir flujos de trabajo.
- Qué es Shell Scripting y cuándo resulta útil.
- Cómo escribir Scripts básicos y comprensibles.
- Cómo diagnosticar problemas habituales de Terminal y Shell.
- Qué prácticas ayudan a trabajar de manera segura, eficiente y reproducible.

El objetivo final será desarrollar **autonomía técnica en la línea de comandos**, tanto para el desarrollo cotidiano como para los módulos posteriores de nuestro Mastery.

---

## 🧠 ¿Por qué estudiar Terminal and Shell?

Imagina que acabamos de clonar un proyecto JavaScript.

La documentación indica:

```bash
pnpm install
pnpm dev
```

Ejecutamos el segundo comando y aparece:

```text
Error: Port 3000 is already in use
```

¿Qué significa?

Podríamos intentar reiniciar la computadora, cambiar el puerto o volver a instalar dependencias.

Pero ninguna de esas acciones identifica necesariamente el problema.

Un desarrollador que comprende Terminal and Shell puede comenzar investigando:

1. Qué proceso está utilizando el puerto.
2. Qué aplicación inició ese proceso.
3. Si el proceso sigue siendo necesario.
4. Si corresponde detenerlo o modificar la configuración.
5. Cómo comprobar que el problema se ha resuelto.

Otro ejemplo:

```text
Permission denied
```

Este error podría estar relacionado con permisos del archivo, permisos de los directorios, un ejecutable no autorizado o restricciones del sistema.

La solución no debería ser ejecutar cualquier comando con privilegios de administrador.

Necesitamos comprender qué está ocurriendo.

### Nuestro enfoque

```text
Problem
   ↓
Understand the Error
   ↓
Identify the Responsible Component
   ↓
Inspect the Environment
   ↓
Choose a Safe Action
   ↓
Validate the Result
```

La terminal no es solamente un lugar donde copiamos comandos.

Es una interfaz que nos permite **observar, controlar y automatizar operaciones del sistema**.

---

## 🧩 Primero los conceptos, después los comandos

Mantendremos el principio fundamental de nuestro Developer Tooling Mastery:

```text
Problem
   ↓
Concept
   ↓
Responsibility
   ↓
Tool
   ↓
Configuration
   ↓
Practice
   ↓
Integration
   ↓
Standardization
```

Por ejemplo, antes de aprender:

```bash
ls -la
```

Necesitamos comprender:

- Qué es un directorio.
- Qué significa listar archivos.
- Qué son los archivos ocultos.
- Qué información representan los permisos.
- Qué responsabilidad tiene el comando `ls`.

Antes de aprender:

```bash
command-a | command-b
```

Necesitamos comprender:

- Qué es un proceso.
- Qué es Standard Output.
- Qué es Standard Input.
- Cómo funciona un Pipe.
- Por qué algunos comandos pueden combinarse.

Y antes de crear un Script, necesitamos entender:

- Qué comandos ejecutará.
- En qué orden.
- Qué entradas necesita.
- Qué modificaciones realizará.
- Cómo comunicará los errores.

**No aprenderemos comandos aislados. Aprenderemos los mecanismos que permiten utilizarlos correctamente.**

---

## 🏗️ ¿Qué sucede cuando ejecutamos un comando?

Consideremos una operación sencilla:

```bash
git --version
```

Desde nuestra perspectiva, escribimos un comando y obtenemos una respuesta.

Pero intervienen diferentes componentes.

```text
Developer
    │
    ▼
Terminal Emulator
    │
    ▼
Shell
    │
    ├── Parse Command
    │
    ├── Resolve Command
    │
    └── Prepare Execution
    │
    ▼
Operating System
    │
    ▼
Executable / Process
    │
    ▼
Output and Exit Status
    │
    ▼
Terminal Display
```

Este es un modelo conceptual simplificado.

No todos los comandos necesitan iniciar un ejecutable externo: algunos son funciones, alias o comandos internos del Shell.

Durante el módulo estudiaremos estas diferencias.

### Conceptos fundamentales

**Terminal Emulator**

Aplicación que proporciona una interfaz para interactuar con programas de línea de comandos.

**Shell**

Programa que interpreta instrucciones y permite ejecutar comandos.

**Command**

Instrucción que solicitamos ejecutar.

**Executable**

Programa que puede ser ejecutado por el sistema.

**Process**

Instancia de un programa en ejecución.

**Output**

Información producida por un comando o proceso.

**Exit Status**

Valor que comunica cómo terminó una operación.

Comprender estas responsabilidades nos ayudará a diagnosticar errores con mayor precisión.

---

## 💻 Command-Line Interface (CLI)

Una **Command-Line Interface** es una interfaz que permite interactuar con software mediante instrucciones escritas.

Por ejemplo:

```bash
git status
```

En lugar de navegar por una interfaz gráfica, solicitamos una operación mediante texto.

### CLI vs GUI

| Característica | CLI | GUI |
|---|---|---|
| Interacción | Comandos | Elementos gráficos |
| Automatización | Habitualmente sencilla de integrar en Scripts | Depende de la aplicación |
| Repetibilidad | Alta cuando los comandos están bien definidos | Depende del flujo |
| Descubrimiento visual | Menor | Generalmente mayor |
| Trabajo remoto | Muy habitual | También posible |
| Uso profesional | Desarrollo, servidores, automatización | Desarrollo, diseño, administración |

No debemos considerar que CLI es siempre superior a GUI.

Ambas interfaces tienen responsabilidades y ventajas diferentes.

Un ingeniero profesional debe comprender cuándo utilizar cada una.

---

## 🖥️ Terminal vs Shell

Esta será una de las primeras distinciones que estudiaremos.

Aunque solemos utilizar ambos términos como si fueran equivalentes, representan conceptos diferentes.

### Terminal

Proporciona la interfaz donde interactuamos con programas de línea de comandos.

Ejemplos:

- Terminal.app.
- iTerm2.
- Windows Terminal.
- GNOME Terminal.
- Terminal integrado de VS Code.

### Shell

Interpreta comandos y proporciona funcionalidades para trabajar con el sistema.

Ejemplos:

- Bash.
- Zsh.
- PowerShell.
- Fish.

### Modelo

```text
Terminal Application
        │
        ▼
Shell Session
        │
        ▼
Commands
        │
        ▼
Operating System
```

Podemos utilizar diferentes Shells dentro de una misma aplicación de Terminal.

Y un mismo Shell puede ejecutarse desde diferentes aplicaciones.

**Terminal y Shell son componentes relacionados, pero no equivalentes.**

---

## 🐚 ¿Por qué existen diferentes Shells?

Los Shells evolucionaron para ofrecer distintas experiencias, funcionalidades y modelos de automatización.

Durante el módulo estudiaremos especialmente tres.

### Bash

Muy utilizado en sistemas Unix-like, servidores y automatización.

### Zsh

Shell habitual en macOS moderno, con funcionalidades interactivas y posibilidades de personalización.

### PowerShell

Shell y plataforma de automatización orientada a objetos, especialmente relevante en Windows y disponible también en otros sistemas.

### Comparación inicial

| Característica | Bash | Zsh | PowerShell |
|---|---|---|---|
| Uso habitual | Linux, servidores, Scripts | macOS, uso interactivo | Windows, administración, automatización |
| Pipeline principal | Texto/bytes | Texto/bytes | Objetos entre comandos PowerShell |
| Sintaxis | Familia Bourne | Familia Bourne | Sintaxis propia |
| Scripting | Sí | Sí | Sí |
| Multiplataforma | Sí | Sí | Sí, según disponibilidad |

No estudiaremos los tres con idéntica profundidad desde el primer día.

Aprenderemos primero los conceptos compartidos y después sus diferencias relevantes.

---

## 📂 File System Navigation

Una de las primeras habilidades prácticas será navegar por el sistema de archivos.

Necesitamos comprender conceptos como:

- File.
- Directory.
- Root Directory.
- Home Directory.
- Current Working Directory.
- Absolute Path.
- Relative Path.
- Parent Directory.
- Hidden Files.

### Ejemplo conceptual

```text
home/
└── developer/
    ├── projects/
    │   ├── frontend-app/
    │   └── backend-api/
    │
    └── documents/
```

Si estamos dentro de:

```text
/home/developer/projects/frontend-app
```

Podemos necesitar:

- Identificar nuestra ubicación.
- Regresar al directorio padre.
- Entrar en otro proyecto.
- Consultar archivos.
- Buscar una configuración.

Aprenderemos a hacerlo de forma consciente y segura.

También estudiaremos diferencias entre rutas Unix-like y Windows.

---

## 📄 File and Directory Operations

Una vez comprendamos cómo navegar, aprenderemos a trabajar con archivos y directorios.

Entre las operaciones fundamentales encontramos:

```text
File Operations
│
├── Create
├── Read
├── Inspect
├── Copy
├── Move
├── Rename
├── Search
└── Delete
```

No todas las operaciones tienen el mismo riesgo.

Consultar un archivo suele ser una operación de lectura.

Eliminarlo puede producir pérdida de información.

Por eso clasificaremos los comandos según su impacto.

### Niveles de riesgo

| Tipo | Ejemplo conceptual | Riesgo |
|---|---|---|
| Read-only | Consultar archivos | Bajo |
| Create | Crear un archivo | Generalmente bajo |
| Modify | Cambiar contenido | Variable |
| Move | Mover o renombrar | Variable |
| Delete | Eliminar | Potencialmente alto |
| Privileged | Modificar recursos protegidos | Alto |

Antes de ejecutar operaciones destructivas, aprenderemos a verificar rutas, alcance y consecuencias.

---

## ⌨️ Commands, Arguments and Options

Un comando puede estar compuesto por diferentes elementos.

Ejemplo:

```bash
git log --oneline
```

Podemos distinguir:

```text
git log --oneline
│   │       │
│   │       └── Option
│   │
│   └────────── Subcommand
│
└────────────── Program
```

También encontraremos:

- Positional Arguments.
- Short Options.
- Long Options.
- Flags.
- Subcommands.

No todas las herramientas siguen exactamente las mismas convenciones.

Aprenderemos a consultar documentación y descubrir cómo se utiliza un comando sin depender exclusivamente de tutoriales.

---

## 🔎 Command Discovery and Help

Un desarrollador no necesita memorizar todos los comandos disponibles.

Necesita saber cómo descubrirlos.

Estudiaremos mecanismos como:

```bash
command --help
```

Y, cuando corresponda:

```bash
man command
```

También aprenderemos a distinguir:

- Comandos internos.
- Alias.
- Funciones.
- Ejecutables externos.

Y a investigar:

- Qué comando se ejecutará.
- Dónde está localizado.
- Qué argumentos acepta.
- Qué efectos puede producir.

La disponibilidad de estos mecanismos depende del Shell y del sistema operativo.

**Saber consultar documentación es más importante que memorizar una lista interminable de comandos.**

---

## 🔀 Standard Streams, Pipes and Redirections

Una de las capacidades más importantes de la línea de comandos es combinar programas.

Para comprenderla, primero necesitamos conocer los flujos estándar.

### Standard Streams

```text
              Process
             /   |   \
            /    |    \
           ▼     ▼     ▼
         stdin stdout stderr
```

Estos flujos representan canales de entrada y salida de los procesos.

Habitualmente se identifican como:

| Stream | Descriptor | Propósito |
|---|---|---|
| Standard Input | `0` | Entrada |
| Standard Output | `1` | Salida normal |
| Standard Error | `2` | Salida de errores |

Esta representación corresponde al modelo habitual de sistemas Unix-like; PowerShell también ofrece un sistema de flujos con características propias.

### Pipes

Permiten conectar la salida de una operación con la entrada de otra.

```text
Command A
    │
    ▼
  Output
    │
    ▼
   Pipe
    │
    ▼
Command B
```

### Redirections

Permiten controlar hacia dónde se dirige la entrada o salida.

Estudiaremos conceptos como:

- Output Redirection.
- Append.
- Input Redirection.
- Error Redirection.
- Pipes.

Comprenderemos también por qué Bash y PowerShell no manejan sus Pipelines exactamente de la misma manera.

---

## 🌍 Variables and Environment

En el módulo anterior conocimos el papel general de las Environment Variables.

Ahora estudiaremos cómo funcionan dentro de una sesión de Shell.

### Shell Variables

Valores administrados por el Shell.

### Environment Variables

Valores que forman parte del entorno de un proceso y pueden heredarse por procesos hijos.

### Ejemplo conceptual

```text
Shell Process
│
├── Shell Variables
│
├── Environment Variables
│
└── Child Process
    └── Inherited Environment
```

También profundizaremos en:

- Variable Assignment.
- Export.
- Variable Expansion.
- Quoting.
- Scope.
- PATH.
- Temporary Configuration.

Comprender estas diferencias será especialmente útil al trabajar con Node.js, Scripts y herramientas de desarrollo.

---

## ⚙️ Processes and Exit Codes

Cuando ejecutamos un programa externo, el sistema operativo puede crear un proceso para realizar la operación.

Necesitamos comprender:

- Process.
- Process ID (PID).
- Foreground.
- Background.
- Signals.
- Exit Status.
- Job Control.

### Ejemplo conceptual

```text
Shell
 │
 ├── Process A
 │
 ├── Process B
 │
 └── Process C
```

También aprenderemos a reconocer códigos de salida.

Por convención, en muchos entornos:

```text
Exit Code 0
    │
    └── Success
```

```text
Non-zero Exit Code
    │
    └── Failure or Special Status
```

El significado exacto de los códigos distintos de cero depende del programa.

Este conocimiento será fundamental cuando estudiemos automatización y CI.

---

## 🔐 Permissions and Safe Execution

La terminal puede permitirnos ejecutar operaciones que modifican archivos, procesos y configuraciones del sistema.

Por eso necesitamos comprender los permisos.

Estudiaremos:

- File Ownership.
- Users and Groups.
- Read Permission.
- Write Permission.
- Execute Permission.
- Privileged Execution.
- `sudo` y sus riesgos.
- Diferencias relevantes con Windows.

### Modelo conceptual

```text
User
  │
  ▼
Requested Operation
  │
  ▼
Permission Check
  │
  ├── Allowed
  │
  └── Denied
```

No aprenderemos a resolver errores de permisos utilizando privilegios elevados indiscriminadamente.

Primero identificaremos qué operación queremos realizar y qué permisos necesita.

---

## 🧾 Shell Scripting Fundamentals

Una vez dominemos los comandos individuales, comenzaremos a combinarlos.

Un **Shell Script** es un archivo que contiene instrucciones interpretadas por un Shell.

### Ejemplo sencillo en Bash

```bash
#!/usr/bin/env bash

echo "Starting validation..."

git --version

echo "Validation finished."
```

Este Script únicamente muestra mensajes y consulta una versión.

Posteriormente aprenderemos conceptos como:

- Shebang.
- Variables.
- Arguments.
- Conditions.
- Loops.
- Functions.
- Exit Codes.
- Error Handling.
- Quoting.
- Script Execution.

### ¿Por qué aprender Scripting?

Porque nos permite transformar operaciones repetitivas en procedimientos reutilizables.

```text
Manual Commands
       │
       ▼
Repeated Workflow
       │
       ▼
Shell Script
       │
       ▼
Repeatable Execution
```

Nuestro objetivo no será construir grandes aplicaciones en Bash o PowerShell.

Aprenderemos los fundamentos necesarios para crear automatizaciones pequeñas, seguras y mantenibles.

---

## 🛠️ Practical Developer Workflows

A lo largo del módulo relacionaremos los conceptos con tareas habituales de ingeniería.

Por ejemplo:

- Identificar el directorio de un proyecto.
- Buscar archivos de configuración.
- Consultar el estado de Git.
- Inspeccionar variables específicas.
- Verificar qué ejecutable se está utilizando.
- Detectar un proceso que ocupa un puerto.
- Leer registros de errores.
- Combinar comandos.
- Ejecutar comprobaciones repetitivas.
- Crear Scripts de diagnóstico.

### Modelo

```text
Developer Task
      │
      ▼
Identify Required Operations
      │
      ▼
Choose Commands
      │
      ▼
Understand Side Effects
      │
      ▼
Execute
      │
      ▼
Verify Results
```

La prioridad será comprender cada operación antes de automatizarla.

---

## 🧭 Diferencias entre sistemas operativos

Los conceptos fundamentales se aplican a diferentes plataformas, pero las herramientas concretas pueden variar.

### macOS

Trabajaremos principalmente con conceptos de Shells Unix-like, especialmente Zsh y Bash.

### Linux

Estudiaremos comandos habituales de entornos Unix-like, prestando atención a las diferencias entre distribuciones y herramientas disponibles.

### Windows

Analizaremos PowerShell y las diferencias con Bash, Git Bash y WSL.

### Nuestra estrategia

```text
Common Concepts
      │
      ▼
Unix-like Examples
      │
      ▼
PowerShell Equivalents
      │
      ▼
Platform Differences
      │
      ▼
Practical Validation
```

No asumiremos que un comando Bash funciona automáticamente en PowerShell.

Tampoco que todos los comandos Unix-like están disponibles en cualquier distribución.

---

## 🗺️ El mapa que vamos a construir

Organizaremos el módulo en siete áreas principales.

```text
Terminal and Shell
│
├── Concepts
│   └── Understand command-line execution
│
├── Navigation and Files
│   └── Work with the file system
│
├── Commands and Help
│   └── Understand and discover commands
│
├── Streams and Pipelines
│   └── Connect command-line operations
│
├── Shell Environment
│   └── Understand variables and execution context
│
├── Processes and Permissions
│   └── Control and inspect execution safely
│
└── Scripting and Best Practices
    └── Build repeatable workflows
```

Cada área tendrá una responsabilidad específica.

Primero comprenderemos los fundamentos.

Después aprenderemos operaciones individuales.

Finalmente combinaremos lo aprendido mediante ejercicios y pequeños Scripts.

---

## 📚 Contenido del módulo

Esta será nuestra estructura de aprendizaje:

```text
02-terminal-and-shell/
│
├── README.md
│
├── 01-concepts/
│   ├── 01-what-is-a-terminal.md
│   ├── 02-what-is-a-shell.md
│   ├── 03-cli-vs-gui.md
│   ├── 04-how-commands-work.md
│   └── 05-shell-types.md
│
├── 02-navigation-and-files/
│   ├── 01-file-system-navigation.md
│   ├── 02-paths-and-directories.md
│   ├── 03-file-and-directory-operations.md
│   ├── 04-reading-and-searching-files.md
│   └── 05-safe-file-operations.md
│
├── 03-commands-and-help/
│   ├── 01-command-anatomy.md
│   ├── 02-arguments-and-options.md
│   ├── 03-command-discovery.md
│   └── 04-help-and-man-pages.md
│
├── 04-streams-and-pipelines/
│   ├── 01-standard-streams.md
│   ├── 02-pipes.md
│   ├── 03-redirections.md
│   └── 04-command-composition.md
│
├── 05-shell-environment/
│   ├── 01-shell-variables.md
│   ├── 02-environment-variables.md
│   ├── 03-path-and-command-resolution.md
│   ├── 04-quoting-and-expansion.md
│   └── 05-shell-sessions.md
│
├── 06-processes-and-permissions/
│   ├── 01-processes-and-pids.md
│   ├── 02-foreground-and-background.md
│   ├── 03-exit-codes-and-signals.md
│   ├── 04-file-permissions.md
│   └── 05-safe-process-management.md
│
└── 07-scripting-and-best-practices/
    ├── 01-introduction-to-shell-scripting.md
    ├── 02-script-structure-and-execution.md
    ├── 03-variables-conditions-and-loops.md
    ├── 04-functions-and-error-handling.md
    ├── 05-practical-developer-scripts.md
    ├── 06-terminal-productivity.md
    └── 07-common-terminal-issues.md
```

Esta estructura contiene **35 documentos temáticos y un README principal**.

Los nombres de los archivos estarán en inglés y el contenido explicativo en español.

### ¿Por qué esta separación?

Porque necesitamos distinguir diferentes responsabilidades:

**Concepts**

Comprender qué estamos utilizando y cómo funciona.

**Navigation and Files**

Interactuar con el sistema de archivos.

**Commands and Help**

Comprender la estructura de los comandos y aprender a descubrir su documentación.

**Streams and Pipelines**

Combinar operaciones y gestionar entradas y salidas.

**Shell Environment**

Comprender variables, sesiones y resolución de ejecutables.

**Processes and Permissions**

Inspeccionar la ejecución y actuar con seguridad.

**Scripting and Best Practices**

Transformar operaciones conocidas en flujos reutilizables.

No necesitamos estudiar todas las áreas simultáneamente.

Seguiremos el orden establecido.

---

## 🔄 Progresión del módulo

Nuestro recorrido conceptual será:

```text
What Is a Terminal?
         ↓
What Is a Shell?
         ↓
CLI and Command Execution
         ↓
File System Navigation
         ↓
File Operations
         ↓
Command Anatomy
         ↓
Help and Discovery
         ↓
Standard Streams
         ↓
Pipes and Redirections
         ↓
Shell Variables and Environment
         ↓
Processes and Permissions
         ↓
Shell Scripting
         ↓
Practical Workflows
         ↓
Professional Best Practices
```

Esta progresión tiene una razón.

No tiene sentido comenzar creando Scripts complejos si todavía no comprendemos qué hacen los comandos que contienen.

Tampoco conviene aprender Pipes sin conocer previamente Standard Input y Standard Output.

**Cada etapa debe construir sobre los conocimientos anteriores.**

---

## 🧪 Cómo practicaremos

Este módulo será más práctico que `01-development-environment`.

Trabajaremos con ejercicios pequeños y progresivos.

### Nivel 1 — Observation

Aprenderemos a consultar información sin modificar el sistema.

Ejemplos:

- Identificar el directorio actual.
- Listar archivos.
- Consultar versiones.
- Identificar ejecutables.
- Leer ayuda.

### Nivel 2 — Controlled Operations

Realizaremos operaciones dentro de directorios de práctica.

Ejemplos:

- Crear archivos.
- Crear directorios.
- Copiar archivos.
- Mover archivos.
- Renombrar archivos.

### Nivel 3 — Command Composition

Combinaremos operaciones.

Ejemplos:

- Filtrar información.
- Redirigir resultados.
- Buscar archivos.
- Procesar salidas.

### Nivel 4 — Scripting

Construiremos Scripts pequeños.

Ejemplos:

- Verificar herramientas.
- Validar directorios.
- Consultar información del entorno.
- Ejecutar comprobaciones repetitivas.

### Nivel 5 — Troubleshooting

Resolveremos problemas simulados o controlados.

Ejemplos:

- Command not found.
- Permission denied.
- Incorrect path.
- Unexpected exit code.
- Port already in use.
- Script execution failure.

### Regla de seguridad

Antes de utilizar un comando que modifica o elimina información, debemos comprender:

1. Qué operación realizará.
2. Sobre qué archivos o procesos actuará.
3. Qué permisos necesita.
4. Qué efectos secundarios puede producir.
5. Cómo verificaremos el resultado.

Los experimentos que necesiten mayor profundidad podrán desarrollarse posteriormente dentro de `labs/`, sin alterar la estructura de este módulo.

---

## 🧰 Herramientas que utilizaremos

No necesitaremos instalar todas las herramientas desde el primer documento.

Trabajaremos con las disponibles en nuestro sistema y aprenderemos a identificar cuándo necesitamos una adicional.

### macOS / Linux

Podremos encontrar utilidades como:

```text
pwd
ls
cd
mkdir
cp
mv
cat
grep
find
ps
```

### Windows / PowerShell

Podremos encontrar comandos como:

```text
Get-Location
Get-ChildItem
Set-Location
New-Item
Copy-Item
Move-Item
Get-Content
Get-Process
```

Estas listas son ejemplos iniciales.

Cada comando tendrá su explicación dentro del documento correspondiente.

**No instalaremos herramientas únicamente por aparecer mencionadas en el README.**

---

## 🔗 Relación con los siguientes módulos

Terminal and Shell es una base transversal para todo nuestro Developer Tooling Mastery.

```text
02 — Terminal and Shell
           │
           ├── 03 — Editor and Workspace
           │
           ├── 04 — Runtime Management
           │
           ├── 05 — Package Managers
           │
           ├── 11 — Build Tools
           │
           ├── 13 — Git Hooks
           │
           ├── 14 — CI and Automation
           │
           └── 17 — Monorepo Tooling
```

Por ejemplo:

| Módulo | Cómo utilizaremos Terminal and Shell |
|---|---|
| 03 — Editor and Workspace | Terminal integrado y comandos desde el editor |
| 04 — Runtime Management | Verificar y seleccionar versiones |
| 05 — Package Managers | Instalar dependencias y ejecutar Scripts |
| 11 — Build Tools | Ejecutar compilaciones |
| 13 — Git Hooks | Comprender Scripts y procesos automatizados |
| 14 — CI and Automation | Ejecutar operaciones reproducibles |
| 17 — Monorepo Tooling | Ejecutar comandos sobre múltiples proyectos |
| 18 — Nx Basics | Inspeccionar y ejecutar tareas del Workspace |

Comprender la línea de comandos facilitará enormemente el aprendizaje de estas herramientas.

---

## ⚠️ Qué NO haremos todavía

Para mantener una progresión coherente, este módulo no profundizará en:

```text
Node.js Runtime Internals
nvm / mise Configuration
npm / pnpm / Yarn Internals
JavaScript Dependency Resolution
TypeScript Compiler Configuration
Vite / Rsbuild Configuration
Advanced Bash Programming
Advanced PowerShell Administration
Linux System Administration
Docker Orchestration
GitHub Actions Pipelines
Nx Task Orchestration
Infrastructure as Code
```

Estos temas pertenecen a otros módulos o áreas de especialización.

Sí podremos utilizar herramientas como Git o Node.js en ejemplos sencillos cuando ayuden a comprender un concepto.

Pero evitaremos convertir este módulo en un curso completo de administración de sistemas o DevOps.

---

## 🧠 Comprueba tu modelo mental

Al finalizar este módulo deberías poder responder:

1. ¿Qué diferencia existe entre Terminal y Shell?
2. ¿Qué es una CLI?
3. ¿Qué ocurre cuando ejecutamos un comando?
4. ¿Qué diferencias existen entre Bash, Zsh y PowerShell?
5. ¿Qué es el Current Working Directory?
6. ¿Qué diferencia existe entre una ruta absoluta y una relativa?
7. ¿Qué significa `.` y qué significa `..` en una ruta?
8. ¿Cómo podemos inspeccionar un archivo sin modificarlo?
9. ¿Qué diferencia existe entre un argumento y una opción?
10. ¿Cómo descubrimos qué hace un comando?
11. ¿Qué son Standard Input, Standard Output y Standard Error?
12. ¿Qué es un Pipe?
13. ¿Qué es una Redirection?
14. ¿Qué diferencia existe entre una Shell Variable y una Environment Variable?
15. ¿Cómo influye `PATH` en la resolución de ejecutables?
16. ¿Qué es un Process?
17. ¿Qué es un PID?
18. ¿Qué representa un Exit Code?
19. ¿Qué diferencia existe entre ejecutar un proceso en Foreground y Background?
20. ¿Qué son los permisos de lectura, escritura y ejecución?
21. ¿Por qué no debemos utilizar privilegios elevados indiscriminadamente?
22. ¿Qué es un Shell Script?
23. ¿Por qué son importantes Quoting y Variable Expansion?
24. ¿Cómo podemos combinar comandos de forma segura?
25. ¿Qué debemos comprobar antes de ejecutar una operación destructiva?
26. ¿Cómo investigaríamos un error `command not found`?
27. ¿Cómo identificaríamos un proceso que utiliza un puerto?
28. ¿Cómo construiríamos un Script sencillo de diagnóstico?
29. ¿Qué diferencias debemos considerar entre Bash y PowerShell?
30. ¿Cómo podemos convertir una operación manual en un procedimiento reproducible?

No necesitamos memorizar todas las respuestas.

Queremos comprender los conceptos y ser capaces de demostrarlos mediante ejemplos prácticos.

---

## 💡 Idea clave

Terminal and Shell representan una interfaz fundamental entre el desarrollador y el sistema operativo.

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
Commands
    │
    ▼
Programs and Processes
    │
    ▼
Operating System
```

Dominar esta interfaz nos permitirá:

- Trabajar con mayor autonomía.
- Comprender errores.
- Investigar el comportamiento de herramientas.
- Manipular archivos de forma segura.
- Combinar operaciones.
- Automatizar tareas.
- Prepararnos para herramientas más avanzadas.

**Un desarrollador profesional no solamente sabe qué comando ejecutar: comprende qué hace, por qué funciona y cómo verificar su resultado.**

---

## 🚀 Siguiente paso

Comenzaremos por el primer concepto fundamental:

**¿Qué es exactamente un Terminal?**

Antes de estudiar Bash, Zsh, PowerShell o aprender comandos, necesitamos comprender qué papel tiene el Terminal dentro de nuestro entorno de desarrollo.

En el siguiente documento aprenderemos:

- Qué es un Terminal.
- Por qué existe.
- Qué diferencia existe entre un Terminal tradicional y un Terminal Emulator.
- Qué responsabilidad tiene.
- Qué relación mantiene con el Shell.
- Qué ejemplos encontramos en macOS, Windows y Linux.

👉 [What Is a Terminal?](./01-concepts/01-what-is-a-terminal.md)