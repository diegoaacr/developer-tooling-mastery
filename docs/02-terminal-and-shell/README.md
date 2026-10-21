# Terminal and Shell

> **Developer Tooling Mastery 2026 — Module 02**
>
> Comprende cómo funciona la línea de comandos, aprende a interactuar con el sistema operativo y desarrolla las habilidades necesarias para trabajar profesionalmente con herramientas de desarrollo.

---

## 1. Introducción

La terminal es una de las herramientas más importantes en el trabajo cotidiano de un ingeniero de software.

La utilizamos constantemente para:

- Navegar por directorios.
- Consultar y modificar archivos.
- Ejecutar aplicaciones.
- Instalar dependencias.
- Trabajar con Git.
- Configurar herramientas.
- Iniciar servidores.
- Inspeccionar procesos.
- Diagnosticar errores.
- Automatizar tareas.

Sin embargo, ejecutar comandos no significa necesariamente comprender cómo funcionan.

Por ejemplo:

```bash
npm install
```

```bash
npm run dev
```

```bash
git status
```

Aunque estos comandos parecen sencillos, detrás de su ejecución intervienen diferentes conceptos:

- **Terminal:** interfaz donde interactuamos con programas de línea de comandos.
- **Shell:** programa que interpreta las instrucciones que escribimos.
- **CLI:** interfaz que permite controlar una herramienta mediante comandos.
- **Executable:** programa que puede ejecutar el sistema operativo.
- **Process:** instancia de un programa en ejecución.
- **Environment Variables:** valores de configuración disponibles para determinados procesos.
- **PATH:** variable que participa en la búsqueda de ejecutables.
- **Exit Code:** valor que indica cómo terminó una operación.

Nuestro objetivo será comprender estos conceptos y aprender a utilizarlos correctamente.

**No queremos memorizar comandos sin entenderlos. Queremos desarrollar autonomía para trabajar, investigar y resolver problemas desde la terminal.**

---

## 2. Objetivos de aprendizaje

Al finalizar este módulo deberías ser capaz de:

1. Diferenciar Terminal, Shell y CLI.
2. Comprender qué ocurre cuando ejecutamos un comando.
3. Identificar los principales Shells utilizados en desarrollo.
4. Navegar por el sistema de archivos.
5. Diferenciar rutas absolutas y relativas.
6. Crear, copiar, mover, inspeccionar y eliminar archivos de forma segura.
7. Comprender argumentos, opciones y comandos.
8. Consultar la ayuda de herramientas CLI.
9. Comprender las variables de entorno.
10. Explicar cómo funciona `PATH`.
11. Identificar los archivos de configuración del Shell.
12. Comprender qué son los Alias y para qué sirven.
13. Identificar procesos y puertos.
14. Comprender Pipes, Redirections y Command Chaining.
15. Reconocer diferencias entre macOS, Linux y Windows.
16. Diagnosticar problemas habituales de Terminal.
17. Utilizar la terminal con mayor seguridad y productividad.
18. Prepararte para trabajar con Node.js, gestores de paquetes y herramientas de desarrollo.

---

## 3. ¿Por qué es importante dominar Terminal and Shell?

Imagina que ejecutas:

```bash
pnpm dev
```

Y recibes el siguiente error:

```text
Error: Port 3000 is already in use
```

Un desarrollador que desconoce cómo funcionan los procesos podría intentar reinstalar las dependencias o reiniciar la computadora.

Sin embargo, el problema podría ser simplemente que otro proceso está utilizando ese puerto.

Para investigarlo necesitamos comprender:

- Qué es un proceso.
- Qué es un puerto.
- Cómo identificar procesos activos.
- Cómo determinar qué aplicación utiliza un puerto.
- Cuándo corresponde detener un proceso.

Otro ejemplo:

```text
command not found: node
```

Este error podría indicar que:

- Node.js no está instalado.
- El ejecutable no está disponible en `PATH`.
- El Shell no ha cargado la configuración esperada.
- Estamos utilizando un entorno diferente.
- Existe un problema con el gestor de versiones.

Sin comprender Terminal and Shell, podríamos aplicar soluciones incorrectas.

### Modelo de resolución

```text
Error
  │
  ▼
Understand the Message
  │
  ▼
Identify the Responsible Component
  │
  ▼
Inspect the Environment
  │
  ▼
Choose an Appropriate Solution
  │
  ▼
Validate the Result
```

**Dominar la terminal significa comprender lo que estamos ejecutando y saber investigar cuando algo no funciona.**

---

## 4. Modelo mental: cómo funciona la terminal

Cuando escribimos un comando, intervienen diferentes componentes.

```text
Developer
    │
    ▼
Terminal
    │
    ▼
Shell
    │
    ├── Interpret Command
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
Output / Exit Status
    │
    ▼
Terminal
```

Este modelo es una simplificación.

Algunos comandos son internos del Shell y no necesitan iniciar un ejecutable externo.

Por ejemplo, `cd` suele ser un comando interno porque necesita modificar el directorio actual del propio Shell.

En cambio, herramientas como Git normalmente se ejecutan como programas externos.

Comprender estas diferencias nos permitirá entender mejor los errores y el comportamiento de nuestras herramientas.

---

## 5. Terminal vs Shell vs CLI

Aunque estos conceptos están relacionados, tienen responsabilidades distintas.

### Terminal

Es la aplicación o interfaz mediante la cual interactuamos con programas de línea de comandos.

Ejemplos:

- Terminal.app.
- iTerm2.
- Windows Terminal.
- GNOME Terminal.
- Terminal integrado de VS Code.

### Shell

Es el programa que interpreta nuestras instrucciones y proporciona funcionalidades para ejecutar comandos.

Ejemplos:

- Bash.
- Zsh.
- PowerShell.
- Fish.

### CLI

Es una interfaz de línea de comandos ofrecida por una herramienta.

Ejemplos:

```bash
git status
```

```bash
node --version
```

```bash
npm --version
```

### Relación

```text
Terminal Application
        │
        ▼
Shell Session
        │
        ▼
CLI Commands
        │
        ▼
Tools / Operating System
```

Una misma aplicación de Terminal puede utilizar diferentes Shells.

Asimismo, un Shell puede ejecutarse dentro de distintas aplicaciones de Terminal.

**Terminal, Shell y CLI no son sinónimos.**

---

## 6. ¿Qué Shell aprenderemos?

Nos enfocaremos principalmente en los Shells más relevantes para nuestro entorno profesional.

| Shell | Uso habitual | Característica principal |
|---|---|---|
| Bash | Linux, servidores, automatización | Scripting y comandos Unix-like |
| Zsh | macOS y entornos Unix-like | Experiencia interactiva y personalización |
| PowerShell | Windows y automatización multiplataforma | Pipeline de objetos y administración |
| Git Bash | Windows | Entorno Bash proporcionado por Git for Windows |

### Nuestra estrategia

Aprenderemos primero los conceptos compartidos.

Después identificaremos las diferencias necesarias entre plataformas.

Por ejemplo:

**Bash / Zsh:**

```bash
pwd
```

**PowerShell:**

```powershell
Get-Location
```

Ambos permiten consultar la ubicación actual, aunque pertenecen a entornos con características diferentes.

No necesitamos dominar todos los Shells simultáneamente.

El objetivo es comprender sus fundamentos y saber adaptarnos al entorno de trabajo.

---

## 7. Metodología de aprendizaje

Seguiremos el mismo enfoque utilizado en `01-development-environment`.

```text
Problem
   │
   ▼
Concept
   │
   ▼
Responsibility
   │
   ▼
Command / Tool
   │
   ▼
Practical Example
   │
   ▼
Validation
   │
   ▼
Professional Usage
```

### Ejemplo

Antes de aprender:

```bash
cd ..
```

Comprenderemos:

- Qué es el Current Working Directory.
- Qué representa un directorio padre.
- Qué es una ruta relativa.
- Por qué el Shell necesita mantener una ubicación actual.

Antes de aprender:

```bash
echo "Hello" > output.txt
```

Comprenderemos:

- Qué es Standard Output.
- Qué es una Redirection.
- Qué significa sobrescribir un archivo.
- Qué riesgos puede tener la operación.

Y antes de ejecutar:

```bash
kill <PID>
```

Comprenderemos:

- Qué es un Process ID.
- Qué proceso queremos detener.
- Qué señal se envía.
- Qué consecuencias puede tener la operación.

**Primero comprenderemos el mecanismo; después aprenderemos el comando.**

---

## 8. Estructura del módulo

Mantendremos una estructura sencilla de **12 documentos temáticos y un README principal**.

Todos los documentos estarán directamente dentro de `02-terminal-and-shell/`.

```text
docs/
└── 02-terminal-and-shell/
    ├── README.md
    ├── 01-terminal-vs-shell.md
    ├── 02-command-line-basics.md
    ├── 03-file-system-navigation.md
    ├── 04-absolute-vs-relative-paths.md
    ├── 05-environment-variables.md
    ├── 06-path-environment-variable.md
    ├── 07-shell-configuration-files.md
    ├── 08-shell-aliases.md
    ├── 09-processes-and-ports.md
    ├── 10-command-chaining-and-pipes.md
    ├── 11-cross-platform-commands.md
    └── 12-common-terminal-issues.md
```

No utilizaremos subcarpetas adicionales en este módulo.

Cada documento tendrá una responsabilidad concreta y se apoyará en los conocimientos anteriores.

---

## 9. Roadmap de contenidos

### 01 — [Terminal vs Shell](./01-terminal-vs-shell.md)

**Objetivo:** comprender la diferencia entre Terminal, Shell y CLI.

Estudiaremos:

- Qué es un Terminal.
- Qué es un Terminal Emulator.
- Qué es un Shell.
- Qué es una CLI.
- Cómo interactúan.
- Bash, Zsh y PowerShell.
- Qué ocurre cuando ejecutamos un comando.

**Resultado esperado:** poder explicar qué componentes intervienen al ejecutar una herramienta desde la terminal.

### 02 — [Command Line Basics](./02-command-line-basics.md)

**Objetivo:** comprender la estructura y ejecución de comandos.

Estudiaremos:

- Command.
- Executable.
- Built-in Commands.
- Arguments.
- Options.
- Flags.
- Subcommands.
- Command History.
- Autocompletion.
- Help.
- Manual Pages.
- Exit Codes básicos.

**Resultado esperado:** poder interpretar un comando y consultar su documentación.

### 03 — [File System Navigation](./03-file-system-navigation.md)

**Objetivo:** aprender a navegar e inspeccionar el sistema de archivos.

Estudiaremos:

- File System.
- Files.
- Directories.
- Root Directory.
- Home Directory.
- Current Working Directory.
- Navegación.
- Listado de archivos.
- Operaciones básicas sobre archivos y directorios.
- Inspección segura.

**Resultado esperado:** desplazarte por un proyecto y trabajar con sus archivos desde la terminal.

### 04 — [Absolute vs Relative Paths](./04-absolute-vs-relative-paths.md)

**Objetivo:** comprender cómo funcionan las rutas.

Estudiaremos:

- Absolute Paths.
- Relative Paths.
- Current Directory.
- Parent Directory.
- Home Directory.
- Separadores de rutas.
- Rutas en macOS y Linux.
- Rutas en Windows.
- Espacios y caracteres especiales.
- Errores frecuentes de rutas.

**Resultado esperado:** identificar correctamente la ubicación de archivos y evitar operaciones sobre rutas equivocadas.

### 05 — [Environment Variables](./05-environment-variables.md)

**Objetivo:** comprender cómo los procesos reciben configuración desde su entorno.

Estudiaremos:

- Variables.
- Shell Variables.
- Environment Variables.
- Scope.
- Export.
- Process Inheritance.
- Variables temporales.
- Variables persistentes.
- Seguridad y secretos.
- Diferencias entre Shells.

**Resultado esperado:** comprender cómo consultar, definir y utilizar variables sin exponer información sensible.

### 06 — [PATH Environment Variable](./06-path-environment-variable.md)

**Objetivo:** comprender cómo el Shell localiza los ejecutables.

Estudiaremos:

- Qué es `PATH`.
- Command Resolution.
- Orden de búsqueda.
- Ejecutables globales.
- Instalaciones duplicadas.
- Conflictos de versiones.
- `command -v`.
- `type`.
- `Get-Command`.
- Diagnóstico de `command not found`.

**Resultado esperado:** identificar qué ejecutable se está utilizando y por qué.

### 07 — [Shell Configuration Files](./07-shell-configuration-files.md)

**Objetivo:** comprender cómo se configura el comportamiento del Shell.

Estudiaremos:

- Shell Startup.
- Interactive Shell.
- Login Shell.
- `.bashrc`.
- `.bash_profile`.
- `.profile`.
- `.zshrc`.
- `.zprofile`.
- PowerShell Profiles.
- Configuración temporal y persistente.
- Buenas prácticas de modificación.

**Resultado esperado:** saber dónde se configura un Shell y evitar cambios innecesarios o conflictivos.

### 08 — [Shell Aliases](./08-shell-aliases.md)

**Objetivo:** aprender a simplificar operaciones frecuentes.

Estudiaremos:

- Qué es un Alias.
- Para qué sirve.
- Alias temporales.
- Alias persistentes.
- Alias vs Functions.
- Colisiones de nombres.
- Legibilidad.
- Portabilidad.
- Buenas prácticas.

**Resultado esperado:** utilizar Alias sin convertirlos en dependencias ocultas del proyecto.

### 09 — [Processes and Ports](./09-processes-and-ports.md)

**Objetivo:** comprender cómo se ejecutan programas y cómo investigar conflictos de procesos.

Estudiaremos:

- Process.
- PID.
- Parent Process.
- Foreground.
- Background.
- Exit Status.
- Signals.
- Puertos.
- Listening Processes.
- Inspección de procesos.
- Conflictos de puertos.
- Detención segura.

**Resultado esperado:** poder investigar situaciones como `Port already in use` sin detener procesos indiscriminadamente.

### 10 — [Command Chaining and Pipes](./10-command-chaining-and-pipes.md)

**Objetivo:** comprender cómo combinar comandos.

Estudiaremos:

- Standard Input.
- Standard Output.
- Standard Error.
- Pipes.
- Redirections.
- Command Chaining.
- `&&`.
- `||`.
- `;`.
- Diferencias entre Pipes de Bash y PowerShell.
- Composición de comandos.
- Riesgos de operaciones encadenadas.

**Resultado esperado:** construir operaciones sencillas combinando comandos de forma comprensible y segura.

### 11 — [Cross-Platform Commands](./11-cross-platform-commands.md)

**Objetivo:** aprender a trabajar en macOS, Linux y Windows.

Estudiaremos:

- Comandos Unix-like.
- Equivalentes de PowerShell.
- Diferencias de sintaxis.
- Diferencias de rutas.
- Variables de entorno.
- Ejecución de Scripts.
- Git Bash.
- WSL.
- Portabilidad.
- Buenas prácticas multiplataforma.

**Resultado esperado:** comprender cómo adaptar operaciones habituales al sistema operativo y Shell disponibles.

### 12 — [Common Terminal Issues](./12-common-terminal-issues.md)

**Objetivo:** desarrollar una metodología para diagnosticar problemas de Terminal y Shell.

Estudiaremos:

- Command not found.
- Permission denied.
- Incorrect PATH.
- Wrong Executable Version.
- Incorrect Working Directory.
- File not found.
- Shell Configuration Errors.
- Environment Variable Issues.
- Port Already in Use.
- Script Execution Errors.
- Windows vs WSL Conflicts.
- Troubleshooting Methodology.

**Resultado esperado:** investigar errores de forma sistemática antes de modificar configuraciones.

---

## 10. Cómo se relacionan los documentos

Nuestro aprendizaje seguirá esta progresión:

```text
01 — Terminal vs Shell
          │
          ▼
02 — Command Line Basics
          │
          ▼
03 — File System Navigation
          │
          ▼
04 — Absolute vs Relative Paths
          │
          ▼
05 — Environment Variables
          │
          ▼
06 — PATH Environment Variable
          │
          ▼
07 — Shell Configuration Files
          │
          ▼
08 — Shell Aliases
          │
          ▼
09 — Processes and Ports
          │
          ▼
10 — Command Chaining and Pipes
          │
          ▼
11 — Cross-Platform Commands
          │
          ▼
12 — Common Terminal Issues
```

Los primeros documentos construyen los fundamentos.

Los documentos intermedios explican el entorno de ejecución.

Los últimos permiten combinar operaciones y diagnosticar problemas.

Esta progresión nos prepara para utilizar herramientas de desarrollo más avanzadas.

---

## 11. Ejercicios prácticos

La práctica será parte de cada documento.

No crearemos archivos adicionales para los ejercicios dentro de este módulo.

### Nivel 1 — Observación

Consultar información sin modificar el sistema.

Ejemplos:

```bash
pwd
```

```bash
git --version
```

```bash
node --version
```

### Nivel 2 — Navegación

Desplazarnos entre directorios y reconocer rutas.

### Nivel 3 — Operaciones controladas

Crear, inspeccionar, copiar y mover archivos dentro de un directorio de práctica.

### Nivel 4 — Diagnóstico

Investigar:

- Ejecutables.
- Variables.
- Procesos.
- Puertos.
- Errores de configuración.

### Nivel 5 — Composición

Combinar comandos para resolver pequeñas tareas.

### Regla fundamental

Antes de ejecutar una operación que modifica el sistema, debemos conocer:

1. Qué hace.
2. Sobre qué recurso actúa.
3. Qué permisos requiere.
4. Qué riesgos presenta.
5. Cómo comprobar el resultado.

---

## 12. Buenas prácticas del módulo

Durante nuestro aprendizaje aplicaremos los siguientes principios.

**Understand Before Executing**

No copiar comandos desconocidos sin comprender sus efectos.

**Prefer Read-Only Diagnostics**

Investigar primero mediante operaciones de lectura.

**Use Least Privilege**

No utilizar privilegios de administrador sin necesidad.

**Verify Paths**

Comprobar rutas antes de modificar o eliminar archivos.

**Protect Secrets**

No publicar credenciales ni imprimir variables sensibles innecesariamente.

**Avoid Hidden Dependencies**

No depender de Alias o configuraciones personales para que un proyecto funcione.

**Prefer Explicit Commands**

Utilizar comandos claros y comprensibles.

**Validate Results**

Comprobar el resultado de las operaciones.

**Respect Platform Differences**

No asumir que Bash y PowerShell son equivalentes.

**Document Important Configuration**

Registrar los requisitos del proyecto cuando corresponda.

---

## 13. Qué no estudiaremos en profundidad

Para mantener el módulo enfocado, dejaremos los siguientes temas para otras áreas:

| Tema | Módulo correspondiente |
|---|---|
| Configuración avanzada del editor | `03-editor-and-workspace` |
| nvm, mise y gestión de Node.js | `04-runtime-management` |
| npm, pnpm y Yarn | `05-package-managers` |
| Configuración de TypeScript | `10-typescript-tooling` |
| Vite y Rsbuild | `11-build-tools` |
| Configuración de entornos de aplicación | `12-environment-configuration` |
| Git Hooks y calidad de commits | `13-git-hooks-and-commit-quality` |
| Automatización CI | `14-ci-and-automation` |
| Monorepos | `16-repository-architectures` y `17-monorepo-tooling` |
| Nx | `18-nx-basics` |

Tampoco profundizaremos en programación avanzada de Bash o PowerShell.

Aprenderemos las operaciones necesarias para comprender y utilizar profesionalmente las herramientas del ecosistema de desarrollo.

---

## 14. Criterios para completar el módulo

Consideraremos completado `02-terminal-and-shell` cuando puedas realizar las siguientes actividades.

### Fundamentos

- [ ] Explicar Terminal vs Shell.
- [ ] Diferenciar CLI y ejecutable.
- [ ] Interpretar argumentos y opciones.
- [ ] Consultar ayuda.

### Sistema de archivos

- [ ] Identificar el directorio actual.
- [ ] Navegar entre directorios.
- [ ] Diferenciar rutas absolutas y relativas.
- [ ] Inspeccionar archivos.
- [ ] Realizar operaciones controladas.

### Entorno del Shell

- [ ] Comprender variables de entorno.
- [ ] Explicar cómo funciona `PATH`.
- [ ] Identificar archivos de configuración.
- [ ] Comprender los Alias.

### Ejecución

- [ ] Identificar procesos.
- [ ] Comprender qué es un puerto.
- [ ] Interpretar Exit Codes básicos.
- [ ] Comprender Pipes y Redirections.
- [ ] Combinar comandos sencillos.

### Compatibilidad y diagnóstico

- [ ] Reconocer diferencias entre Bash y PowerShell.
- [ ] Diagnosticar `command not found`.
- [ ] Investigar un conflicto de puertos.
- [ ] Reconocer problemas de permisos.
- [ ] Aplicar una metodología de Troubleshooting.

---

## 15. Comprueba tu modelo mental

Antes de avanzar al siguiente módulo deberías poder responder:

1. ¿Qué diferencia existe entre Terminal y Shell?
2. ¿Qué es una CLI?
3. ¿Qué sucede cuando ejecutamos un comando?
4. ¿Qué diferencia existe entre un Built-in Command y un ejecutable externo?
5. ¿Qué es un Current Working Directory?
6. ¿Qué diferencia existe entre una ruta absoluta y una relativa?
7. ¿Qué representa `..`?
8. ¿Qué son las Environment Variables?
9. ¿Qué diferencia existe entre una Shell Variable y una Environment Variable?
10. ¿Qué es `PATH`?
11. ¿Cómo encuentra el Shell un ejecutable?
12. ¿Qué es `.zshrc`?
13. ¿Qué es `.bashrc`?
14. ¿Qué es un Alias?
15. ¿Qué es un Process?
16. ¿Qué es un PID?
17. ¿Qué es un puerto?
18. ¿Qué significa `Port already in use`?
19. ¿Qué es Standard Output?
20. ¿Qué es Standard Error?
21. ¿Qué es un Pipe?
22. ¿Qué es una Redirection?
23. ¿Qué diferencia existe entre `&&` y `||` en Bash?
24. ¿Por qué PowerShell y Bash no son completamente equivalentes?
25. ¿Cómo investigarías un error `command not found`?
26. ¿Por qué no debemos utilizar `sudo` indiscriminadamente?
27. ¿Cómo comprobarías qué versión de Node.js se está ejecutando?
28. ¿Cómo identificarías qué ejecutable corresponde a un comando?
29. ¿Por qué debemos verificar las rutas antes de eliminar archivos?
30. ¿Qué conocimientos de este módulo utilizaremos en Runtime Management?

---

## 16. Resultado esperado

Al completar este módulo, deberíamos pasar de:

```text
I Copy Commands
       │
       ▼
I Hope They Work
       │
       ▼
I Search for Random Solutions
```

A:

```text
I Understand the Command
       │
       ▼
I Understand the Environment
       │
       ▼
I Execute Safely
       │
       ▼
I Interpret the Result
       │
       ▼
I Diagnose Problems
```

La terminal dejará de ser una herramienta que utilizamos únicamente siguiendo instrucciones.

Se convertirá en una interfaz que comprendemos y podemos utilizar con autonomía.

---

## 17. Relación con Runtime Management

El siguiente módulo técnico especialmente importante será:

**`04-runtime-management`**

Allí aprenderemos:

- Qué es un Runtime.
- Qué es Node.js.
- Por qué existen diferentes versiones.
- Qué son los Runtime Version Managers.
- Cómo funcionan nvm y mise.
- Cómo seleccionar versiones por proyecto.
- Cómo evitar conflictos entre instalaciones.
- Cómo preparar entornos reproducibles.

Para estudiar esos temas necesitaremos comprender previamente:

```text
Terminal
   │
   ▼
Shell
   │
   ▼
Environment Variables
   │
   ▼
PATH
   │
   ▼
Executable Resolution
   │
   ▼
Runtime Version Management
```

Por eso este módulo es una base fundamental para nuestro aprendizaje posterior.

---

## 18. Idea clave

**Un ingeniero de software no necesita memorizar todos los comandos de una terminal. Necesita comprender cómo funcionan, saber descubrirlos, ejecutarlos de forma segura e interpretar sus resultados.**

Terminal and Shell es una habilidad transversal.

La utilizaremos continuamente en:

- Desarrollo Frontend.
- Desarrollo Backend.
- Git y GitHub.
- Node.js.
- Package Managers.
- Build Tools.
- Testing.
- DevOps.
- Cloud.
- CI/CD.
- Monorepos.

---

## 19. Siguiente paso

Comenzaremos con el primer documento:

### [01 — Terminal vs Shell](./01-terminal-vs-shell.md)

Aprenderemos desde cero:

- Qué es un Terminal.
- Qué es un Shell.
- Qué es una CLI.
- Por qué existen.
- Cómo se relacionan.
- Qué sucede cuando ejecutamos un comando.
- Qué diferencias encontramos entre macOS, Windows y Linux.

**Primero comprenderemos la interfaz. Después aprenderemos a utilizarla.**