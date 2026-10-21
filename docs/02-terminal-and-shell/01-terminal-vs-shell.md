# Terminal vs Shell

> **Developer Tooling Mastery 2026 — Module 02**
>
> **Topic 01:** Terminal vs Shell  
> **Level:** Beginner → Professional Foundations  
> **Prerequisites:** `01-development-environment`

---

## 1. Introducción

Cuando comenzamos a aprender programación, es habitual que nos indiquen ejecutar comandos como:

```bash
node --version
```

```bash
git status
```

```bash
npm install
```

Normalmente abrimos una aplicación, escribimos el comando y presionamos Enter.

Pero ¿qué sucede realmente?

¿La aplicación que tenemos abierta ejecuta el comando?

¿Es el sistema operativo quien lo interpreta?

¿Qué es Bash?

¿Qué es Zsh?

¿Por qué Windows utiliza PowerShell?

¿Y qué diferencia existe entre Terminal, Shell y CLI?

Estas preguntas son importantes porque estamos utilizando varios componentes diferentes que, aunque trabajan juntos, cumplen responsabilidades distintas.

En este documento construiremos el modelo mental necesario para comprenderlos.

**Nuestro objetivo no será memorizar comandos, sino entender qué ocurre desde que escribimos una instrucción hasta que obtenemos un resultado.**

---

## 2. Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Explicar qué es una interfaz de usuario.
2. Diferenciar GUI y CLI.
3. Comprender qué es un Terminal.
4. Explicar qué es un Terminal Emulator.
5. Comprender qué es un Shell.
6. Diferenciar Terminal y Shell.
7. Identificar los principales tipos de Shell.
8. Comprender qué es un comando.
9. Diferenciar comandos internos y programas externos.
10. Explicar qué es un ejecutable.
11. Comprender qué es un proceso.
12. Identificar qué sucede cuando ejecutamos un comando.
13. Comprender el papel del sistema operativo.
14. Reconocer Terminal y Shell en macOS, Windows y Linux.
15. Identificar el Shell que estás utilizando.
16. Comprender qué es el Terminal integrado de VS Code.
17. Reconocer errores conceptuales frecuentes.
18. Construir un modelo mental que utilizaremos durante todo el Mastery.

---

# 3. Primero: ¿cómo interactuamos con una computadora?

Una computadora ejecuta programas y administra recursos mediante un sistema operativo.

Pero los usuarios necesitamos una manera de solicitar operaciones.

Por ejemplo:

- Abrir una carpeta.
- Consultar un archivo.
- Ejecutar una aplicación.
- Crear un directorio.
- Iniciar un servidor.
- Detener un proceso.

Para realizar estas operaciones utilizamos interfaces.

## 3.1 ¿Qué es una User Interface?

Una **User Interface (UI)** es el mecanismo mediante el cual una persona interactúa con un sistema.

Existen diferentes tipos de interfaces.

Dos de las más conocidas son:

- Graphical User Interface (GUI).
- Command-Line Interface (CLI).

## 3.2 Graphical User Interface (GUI)

Una GUI permite interactuar mediante elementos gráficos.

Por ejemplo:

- Ventanas.
- Botones.
- Menús.
- Iconos.
- Formularios.
- Exploradores de archivos.

Cuando abrimos Finder en macOS o File Explorer en Windows, utilizamos una interfaz gráfica.

<box/>

Ejemplo conceptual:

```text
Developer
    │
    ▼
Graphical Interface
    │
    ▼
User Action
    │
    ▼
Application / Operating System
```

## 3.3 Command-Line Interface (CLI)

Una CLI permite interactuar mediante comandos escritos.

Por ejemplo:

```bash
git status
```

En lugar de presionar un botón para consultar el estado de un repositorio, escribimos una instrucción.

Modelo:

```text
Developer
    │
    ▼
Command-Line Interface
    │
    ▼
Written Command
    │
    ▼
Program / Operating System
```

## 3.4 ¿CLI es mejor que GUI?

No necesariamente.

Cada interfaz tiene ventajas.

| Característica | GUI | CLI |
|---|---|---|
| Interacción | Elementos gráficos | Comandos |
| Descubrimiento visual | Generalmente sencillo | Requiere conocer sintaxis o ayuda |
| Automatización | Depende de la aplicación | Habitualmente más directa |
| Repetición de tareas | Manual o automatizada | Fácil de incorporar en Scripts |
| Trabajo remoto | Posible | Muy habitual |
| Desarrollo profesional | Muy utilizada | Muy utilizada |

Por ejemplo:

Podemos administrar archivos desde Finder o mediante comandos.

También podemos trabajar con Git utilizando una interfaz gráfica o su CLI.

**Un ingeniero profesional no necesita elegir exclusivamente una interfaz: debe comprender cuál resulta apropiada para cada tarea.**

---

# 4. ¿Qué es un Terminal?

Un **Terminal** es una interfaz utilizada para interactuar con sistemas y programas mediante texto.

En los entornos modernos, cuando hablamos de abrir una terminal normalmente nos referimos a una aplicación que proporciona esa interfaz.

Ejemplos:

- Terminal.app.
- iTerm2.
- Windows Terminal.
- GNOME Terminal.
- Konsole.
- Terminal integrado de VS Code.

## 4.1 ¿Qué responsabilidad tiene?

Una aplicación de Terminal suele encargarse de:

- Mostrar texto.
- Recibir entradas del teclado.
- Presentar resultados.
- Gestionar la visualización de sesiones.
- Permitir copiar y pegar.
- Gestionar colores y fuentes.
- Facilitar el desplazamiento por la salida.
- Proporcionar pestañas o paneles, según la aplicación.

Pero hay algo fundamental:

**El Terminal no es necesariamente el programa que interpreta los comandos que escribimos.**

Esa responsabilidad suele corresponder al Shell.

## 4.2 Ejemplo

Imagina que abres Terminal.app en macOS.

Ves una ventana donde puedes escribir:

```bash
pwd
```

La aplicación muestra la sesión y permite introducir el comando.

El Shell interpreta la instrucción y ejecuta la operación correspondiente.

El resultado aparece en la ventana del Terminal.

## 4.3 Modelo conceptual

```text
┌───────────────────────────────┐
│        Terminal App           │
│                               │
│  $ pwd                        │
│  /Users/developer             │
│                               │
└───────────────────────────────┘
               │
               ▼
         Shell Session
               │
               ▼
        Command Execution
```

La aplicación de Terminal y el Shell trabajan conjuntamente.

Pero no son el mismo componente.

---

# 5. ¿Qué es un Terminal Emulator?

Para comprender el término **Terminal Emulator**, necesitamos conocer brevemente el origen de los terminales.

## 5.1 Terminales históricos

Antes de las computadoras personales modernas, era habitual utilizar grandes sistemas compartidos.

Los usuarios interactuaban con ellos mediante terminales físicos.

Estos dispositivos podían incluir:

- Teclado.
- Pantalla.
- Circuitos de comunicación.

El terminal permitía enviar información al sistema y mostrar sus respuestas.

## 5.2 Evolución

Con la llegada de las computadoras personales y los sistemas gráficos, surgieron programas capaces de reproducir el comportamiento de aquellos terminales.

De ahí proviene el término:

**Terminal Emulator.**

## 5.3 Terminal Emulator moderno

Un Terminal Emulator es una aplicación que implementa una interfaz de terminal mediante software.

Ejemplos:

| Sistema | Terminal Emulator |
|---|---|
| macOS | Terminal.app |
| macOS | iTerm2 |
| Windows | Windows Terminal |
| Linux | GNOME Terminal |
| Linux | Konsole |
| Multiplataforma | Terminal integrado de VS Code |

## 5.4 ¿Por qué seguimos llamándolo Terminal?

Porque en el lenguaje cotidiano ambos términos suelen utilizarse indistintamente.

Cuando alguien dice:

> Abre la terminal.

Normalmente quiere decir:

> Abre una aplicación de Terminal Emulator y utiliza una sesión de línea de comandos.

## 5.5 Terminal Emulator vs Terminal físico

```text
Historical Environment
│
├── Physical Terminal
│   ├── Keyboard
│   └── Display
│
└── Shared Computer
```

```text
Modern Environment
│
├── Terminal Emulator
│   ├── Application Window
│   └── Keyboard / Display
│
└── Local or Remote System
```

### Idea clave

**Un Terminal Emulator proporciona la interfaz de texto; el Shell y los programas ejecutados determinan qué operaciones se realizan.**

---

# 6. ¿Qué es un Shell?

Un **Shell** es un programa que proporciona una interfaz para interactuar con el sistema operativo y ejecutar instrucciones.

En este módulo nos enfocaremos en los **Command-Line Shells**.

Un Shell puede:

- Leer comandos.
- Interpretar su sintaxis.
- Ejecutar comandos internos.
- Localizar programas externos.
- Preparar la ejecución de procesos.
- Administrar variables.
- Manejar redirecciones.
- Conectar comandos mediante Pipes.
- Ejecutar Scripts.
- Proporcionar funcionalidades interactivas.

## 6.1 Ejemplo

Abrimos una terminal y escribimos:

```bash
echo "Hello World"
```

En Bash o Zsh, `echo` normalmente está disponible como comando interno.

El Shell interpreta la instrucción y produce el resultado:

```text
Hello World
```

## 6.2 Otro ejemplo

Escribimos:

```bash
git --version
```

En una instalación habitual, `git` es un programa externo.

El Shell debe identificar qué ejecutable corresponde a `git` y preparar su ejecución.

## 6.3 Modelo

```text
Developer
    │
    ▼
Shell
    │
    ├── Built-in Command
    │
    ├── Shell Function
    │
    ├── Alias
    │
    └── External Executable
```

La resolución exacta depende del Shell y de su configuración.

## 6.4 ¿El Shell es el sistema operativo?

No.

El Shell es un programa que se ejecuta sobre el sistema operativo.

Puede solicitar operaciones al sistema operativo, pero no es el propio sistema operativo.

## 6.5 ¿Todos los Shells son iguales?

No.

Existen diferentes implementaciones con características y sintaxis propias.

Por ejemplo:

- Bash.
- Zsh.
- PowerShell.
- Fish.
- Dash.

Cada uno puede ofrecer distintas funcionalidades interactivas y de automatización.

### Idea clave

**El Shell interpreta nuestras instrucciones y coordina su ejecución, utilizando funcionalidades propias y servicios del sistema operativo.**

---

# 7. Terminal vs Shell: la diferencia fundamental

Esta es la distinción más importante del documento.

| Concepto | Terminal | Shell |
|---|---|---|
| ¿Qué es? | Aplicación/interfaz de terminal | Programa intérprete de comandos |
| Responsabilidad | Entrada y presentación de texto | Interpretación y ejecución |
| Ejemplos | iTerm2, Windows Terminal | Bash, Zsh, PowerShell |
| ¿Interpreta sintaxis de Shell? | No, normalmente | Sí |
| ¿Gestiona variables del Shell? | No directamente | Sí |
| ¿Puede ejecutar Scripts? | No como intérprete | Sí |
| ¿Puede mostrar resultados? | Sí | Produce resultados que pueden mostrarse |

## 7.1 Analogía

Imagina una conversación.

El Terminal representa el medio que permite enviar y recibir mensajes.

El Shell representa el intérprete que comprende las instrucciones y decide cómo ejecutarlas.

No es una equivalencia técnica perfecta, pero ayuda a distinguir responsabilidades.

## 7.2 Ejemplo con macOS

```text
Terminal.app
     │
     ▼
    Zsh
     │
     ▼
git --version
     │
     ▼
Git Executable
```

## 7.3 Ejemplo con Windows

```text
Windows Terminal
       │
       ▼
   PowerShell
       │
       ▼
  git --version
       │
       ▼
  Git Executable
```

## 7.4 Ejemplo con Linux

```text
GNOME Terminal
       │
       ▼
      Bash
       │
       ▼
  git --version
       │
       ▼
  Git Executable
```

Estos ejemplos representan configuraciones posibles, no combinaciones obligatorias.

### Conclusión

**Podemos cambiar el Terminal sin cambiar el Shell y cambiar el Shell sin cambiar necesariamente el Terminal.**

---

# 8. ¿Qué es una Shell Session?

Cuando utilizamos un Shell interactivo, normalmente trabajamos dentro de una **Shell Session**.

Una sesión mantiene un contexto de ejecución.

Ese contexto puede incluir:

- Current Working Directory.
- Shell Variables.
- Environment Variables.
- Aliases.
- Functions.
- Historial.
- Configuración.
- Estado de procesos o trabajos.

## 8.1 Ejemplo

Abrimos una terminal.

El Shell inicia una sesión.

Dentro de ella ejecutamos:

```bash
pwd
```

Después:

```bash
cd ..
```

Y nuevamente:

```bash
pwd
```

La segunda consulta puede mostrar una ubicación diferente.

¿Por qué?

Porque el Shell mantiene el directorio de trabajo actual de su sesión.

## 8.2 Dos sesiones diferentes

Imagina que abrimos dos pestañas.

```text
Terminal
│
├── Tab A
│   └── Shell Session A
│       └── Working Directory A
│
└── Tab B
    └── Shell Session B
        └── Working Directory B
```

Cada sesión puede mantener su propio estado.

Cambiar el directorio de trabajo en una sesión no cambia automáticamente el directorio de la otra.

## 8.3 ¿Todas las sesiones tienen las mismas variables?

No necesariamente.

Depende de:

- Cómo se iniciaron.
- Qué configuración cargaron.
- Qué variables heredaron.
- Qué cambios se realizaron durante su ejecución.

### Idea clave

**Una Shell Session es un contexto de ejecución con estado propio.**

---

# 9. ¿Qué es un Command?

Un **Command** es una instrucción que solicitamos ejecutar.

Consideremos:

```bash
git status
```

Aquí encontramos:

```text
git status
 │    │
 │    └── Subcommand
 │
 └────── Program
```

En otros casos podemos tener opciones y argumentos.

Por ejemplo:

```bash
git log --oneline
```

```text
git log --oneline
 │   │       │
 │   │       └── Option
 │   │
 │   └────────── Subcommand
 │
 └────────────── Program
```

## 9.1 ¿Todos los comandos son programas externos?

No.

Un comando puede corresponder a:

- Built-in Command.
- Shell Function.
- Alias.
- External Executable.

## 9.2 Built-in Command

Es una operación implementada por el propio Shell.

Ejemplo habitual en Bash y Zsh:

```bash
cd ..
```

## 9.3 External Executable

Es un programa externo al Shell.

Ejemplo habitual:

```bash
git --version
```

## 9.4 Alias

Es un mecanismo del Shell para definir una sustitución o abreviatura de comandos.

Lo estudiaremos en:

[08 — Shell Aliases](./08-shell-aliases.md)

## 9.5 Shell Function

Es una función definida en el Shell que puede agrupar instrucciones.

No profundizaremos todavía en su sintaxis.

### Idea clave

**Escribir un comando no significa necesariamente iniciar un programa externo: el Shell puede resolverlo de diferentes maneras.**

---

# 10. ¿Qué es un Executable?

Un **Executable** es un programa o archivo que puede ejecutarse bajo determinadas condiciones.

Por ejemplo, cuando instalamos Git, normalmente obtenemos un ejecutable que permite utilizar su CLI.

## 10.1 Ejemplo

```bash
git --version
```

El Shell identifica el comando y puede localizar el ejecutable correspondiente.

## 10.2 ¿Cómo lo encuentra?

Habitualmente interviene la variable de entorno:

```text
PATH
```

`PATH` contiene ubicaciones utilizadas para buscar ejecutables.

## 10.3 Modelo

```text
Command: git
      │
      ▼
Shell Resolution
      │
      ▼
PATH Search
      │
      ▼
Git Executable
      │
      ▼
Execution
```

Este modelo se refiere al caso de un comando externo encontrado mediante `PATH`.

La resolución completa también puede incluir Alias, funciones, comandos internos y rutas explícitas.

## 10.4 ¿Por qué es importante?

Porque explica errores como:

```text
command not found
```

O situaciones donde se ejecuta una versión diferente de la esperada.

Profundizaremos en este tema en:

[06 — PATH Environment Variable](./06-path-environment-variable.md)

---

# 11. ¿Qué es un Process?

Un **Process** es una instancia de un programa en ejecución.

Cuando iniciamos una aplicación, el sistema operativo administra su ejecución mediante uno o varios procesos.

## 11.1 Ejemplo

Ejecutamos:

```bash
node --version
```

Si `node` corresponde a un ejecutable externo, el sistema crea o utiliza los mecanismos necesarios para ejecutar ese programa.

El proceso produce una respuesta y termina.

## 11.2 Otro ejemplo

Ejecutamos un servidor de desarrollo:

```bash
npm run dev
```

Si el proyecto tiene definido ese Script, se iniciarán las operaciones correspondientes.

El servidor puede permanecer activo esperando conexiones.

## 11.3 Modelo

```text
Shell
  │
  ▼
Start Program
  │
  ▼
Process
  │
  ├── Executes Instructions
  │
  ├── Uses Resources
  │
  └── Produces Output
```

## 11.4 ¿Qué es un PID?

**Process ID (PID)** es un identificador asignado a un proceso por el sistema operativo.

## 11.5 ¿Por qué importa?

Porque necesitaremos comprender procesos para diagnosticar:

- Aplicaciones que siguen ejecutándose.
- Servidores que no se detienen.
- Conflictos de puertos.
- Consumo de recursos.
- Procesos bloqueados.

Estudiaremos estos conceptos en:

[09 — Processes and Ports](./09-processes-and-ports.md)

### Idea clave

**Un programa es software que puede ejecutarse; un proceso es una instancia de ese programa en ejecución.**

---

# 12. ¿Qué sucede realmente cuando ejecutamos un comando?

Ahora podemos unir los conceptos.

Imagina que abres una terminal y ejecutas:

```bash
git --version
```

Vamos a analizarlo paso a paso.

## Step 1 — Abrimos el Terminal

Iniciamos una aplicación como Terminal.app o Windows Terminal.

## Step 2 — Iniciamos o utilizamos un Shell

La aplicación presenta una sesión de Shell.

Podría ser:

- Zsh.
- Bash.
- PowerShell.

## Step 3 — Escribimos el comando

```bash
git --version
```

El Terminal transmite nuestra entrada a la sesión.

## Step 4 — El Shell interpreta la instrucción

Identifica los elementos del comando.

En este ejemplo:

```text
Program: git
Option: --version
```

## Step 5 — El Shell resuelve el comando

Determina cómo ejecutar `git`.

En una configuración habitual, localizará un ejecutable externo.

## Step 6 — Se ejecuta el programa

El sistema operativo participa en la creación y administración del proceso correspondiente.

## Step 7 — El programa produce una salida

Git devuelve información sobre su versión.

## Step 8 — El Terminal muestra el resultado

La salida se presenta en la interfaz.

## Step 9 — El programa termina

El Shell puede recibir el estado de finalización y quedar preparado para aceptar otro comando.

## Modelo completo

```text
┌──────────────────────────────┐
│          Developer           │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│       Terminal Emulator      │
│                              │
│       git --version          │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│            Shell             │
│                              │
│  1. Parse Command            │
│  2. Resolve Command          │
│  3. Prepare Execution        │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│       Operating System       │
│                              │
│  Process Management          │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│       Git Executable         │
│                              │
│  Produces Version Output     │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│      Terminal Display        │
└──────────────────────────────┘
```

### Observación importante

Este es un modelo pedagógico.

La ejecución real depende del sistema operativo, del Shell, de los mecanismos de entrada/salida y de cómo se inicia el proceso.

No todos los comandos siguen exactamente este recorrido.

---

# 13. Bash, Zsh y PowerShell

Ahora que comprendemos qué es un Shell, podemos conocer las implementaciones más relevantes.

## 13.1 Bash

**Bash** significa *Bourne Again Shell*.

Es un Shell ampliamente utilizado en sistemas Unix-like.

Lo encontraremos en:

- Linux.
- Servidores.
- Entornos de automatización.
- Git Bash.
- Diferentes herramientas de desarrollo.

Ejemplo:

```bash
echo "Hello from Bash"
```

## 13.2 Zsh

**Zsh** es otro Shell de la familia Unix.

Es el Shell predeterminado para nuevas cuentas de usuario en versiones modernas de macOS.

Ofrece funcionalidades interactivas como:

- Autocompletado.
- Historial.
- Expansiones.
- Personalización.

Ejemplo:

```bash
echo "Hello from Zsh"
```

## 13.3 PowerShell

**PowerShell** es un Shell y una plataforma de automatización.

Una de sus características distintivas es el uso de objetos en sus Pipelines de comandos PowerShell.

Ejemplo:

```powershell
Write-Output "Hello from PowerShell"
```

## 13.4 Diferencia importante

Bash y Zsh suelen trabajar con flujos de texto y bytes al combinar programas externos.

PowerShell puede transmitir objetos estructurados entre sus Cmdlets.

Esto influye en cómo construimos comandos y Pipelines.

## 13.5 Comparación

| Característica | Bash | Zsh | PowerShell |
|---|---|---|---|
| Familia | Unix Shell | Unix Shell | PowerShell |
| Uso habitual | Linux y automatización | macOS e interacción | Windows y automatización |
| Variables | Sintaxis Unix Shell | Sintaxis Unix Shell | Sintaxis propia |
| Scripts | Sí | Sí | Sí |
| Pipes | Flujos de texto/bytes | Flujos de texto/bytes | Objetos y flujos de texto según comandos |
| Multiplataforma | Sí | Sí | Sí |

## 13.6 ¿Cuál deberíamos aprender?

Depende del entorno.

Si trabajas principalmente en macOS, Zsh será muy relevante.

Si trabajas en Linux o servidores, Bash será especialmente útil.

Si trabajas en Windows, PowerShell será fundamental.

Pero los conceptos que estamos aprendiendo se aplican a todos.

---

# 14. ¿Qué es Git Bash?

En Windows podemos encontrar **Git Bash**.

Git Bash proporciona un entorno Bash mediante Git for Windows y sus herramientas de compatibilidad.

## 14.1 ¿Para qué sirve?

Permite utilizar una experiencia de línea de comandos similar a la de sistemas Unix-like.

Por ejemplo:

```bash
pwd
```

```bash
ls
```

```bash
git status
```

## 14.2 ¿Git Bash es Linux?

No.

Git Bash se ejecuta sobre Windows.

Proporciona herramientas y mecanismos de compatibilidad, pero no equivale a ejecutar una distribución Linux completa.

## 14.3 ¿Git Bash es WSL?

Tampoco.

WSL permite ejecutar un entorno Linux integrado con Windows.

Son tecnologías diferentes.

## 14.4 Modelo

```text
Windows
│
├── PowerShell
│
├── Git Bash
│
└── WSL
    └── Linux Environment
```

### Idea clave

**Git Bash, PowerShell y WSL ofrecen formas distintas de trabajar desde la línea de comandos en Windows.**

---

# 15. ¿Qué es el Terminal integrado de VS Code?

Visual Studio Code incluye una funcionalidad llamada **Integrated Terminal**.

Permite trabajar con una terminal dentro del editor.

## 15.1 Ejemplo

```text
┌─────────────────────────────────┐
│            VS Code              │
│                                 │
│  ┌───────────────────────────┐  │
│  │        Editor             │  │
│  │                           │  │
│  │  src/index.ts             │  │
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │    Integrated Terminal    │  │
│  │                           │  │
│  │  $ git status             │  │
│  └───────────────────────────┘  │
└─────────────────────────────────┘
```

## 15.2 ¿VS Code es un Shell?

No.

VS Code es un editor que proporciona, entre otras funcionalidades, una terminal integrada.

Dentro de ella podemos utilizar diferentes Shells.

## 15.3 ¿Podemos utilizar Zsh dentro de VS Code?

Sí, cuando está disponible y configurado.

## 15.4 ¿Podemos utilizar PowerShell?

Sí, en los entornos donde esté disponible.

## 15.5 ¿Es igual al Terminal del sistema?

Pueden ejecutar el mismo Shell, pero no siempre tendrán exactamente el mismo contexto.

Pueden existir diferencias en:

- Variables heredadas.
- Directorio inicial.
- Configuración de perfiles.
- Entorno de ejecución.
- Forma de iniciar la sesión.

Profundizaremos en estas diferencias en:

[07 — Shell Configuration Files](./07-shell-configuration-files.md)

### Idea clave

**El Terminal integrado de VS Code no es un Shell diferente: es otra interfaz desde la que podemos iniciar o utilizar sesiones de Shell.**

---

# 16. ¿Podemos utilizar un Shell sin una ventana de Terminal?

Sí.

Un Shell no necesita ejecutarse siempre de forma interactiva dentro de una ventana gráfica.

Puede utilizarse para ejecutar instrucciones o Scripts en otros contextos.

Por ejemplo:

- Servidores remotos.
- Sistemas de automatización.
- Tareas programadas.
- Contenedores.
- CI/CD.

## 16.1 Modelo

```text
Shell
│
├── Interactive Session
│   └── Developer Types Commands
│
└── Non-Interactive Execution
    └── Commands or Scripts
```

## 16.2 Interactive Shell

Un Shell interactivo recibe instrucciones del usuario durante la sesión.

## 16.3 Non-Interactive Shell

Un Shell no interactivo puede ejecutar instrucciones proporcionadas mediante un Script o una operación automatizada.

## 16.4 ¿Por qué importa?

Porque algunas configuraciones se cargan únicamente en determinados tipos de sesión.

Esto puede explicar por qué una herramienta funciona en tu terminal, pero no en un Script automatizado.

### Idea clave

**El Shell es un programa de ejecución de comandos que puede utilizarse tanto de manera interactiva como automatizada.**

---

# 17. ¿Qué es el Prompt?

Cuando abrimos una sesión interactiva, normalmente aparece un **Prompt**.

Es la indicación visual de que el Shell está preparado para recibir una instrucción.

Ejemplo:

```text
developer@machine ~ %
```

O:

```text
$
```

En PowerShell podríamos ver:

```text
PS C:\Users\Developer>
```

## 17.1 ¿Qué información puede mostrar?

Dependiendo de la configuración:

- Usuario.
- Equipo.
- Directorio actual.
- Rama de Git.
- Estado del repositorio.
- Información del entorno.

## 17.2 ¿El Prompt es el comando?

No.

El Prompt es la indicación que aparece antes de escribir la instrucción.

Por ejemplo:

```text
$ git status
```

Aquí:

```text
$
```

Representa el Prompt.

Y:

```text
git status
```

Es el comando.

## 17.3 Precaución al copiar ejemplos

Cuando una documentación muestra:

```text
$ node --version
```

Normalmente debemos ejecutar solamente:

```bash
node --version
```

No copiar el símbolo `$` como parte del comando.

### Idea clave

**El Prompt representa el estado interactivo del Shell; no forma parte necesariamente de la instrucción que debemos ejecutar.**

---

# 18. Práctica 01 — Identificar nuestro Terminal

Comenzaremos con una práctica de observación.

No modificaremos configuraciones.

## Step 1 — Identifica la aplicación

Abre la aplicación de terminal que utilizas habitualmente.

Ejemplos:

- Terminal.app.
- iTerm2.
- Windows Terminal.
- Terminal integrado de VS Code.

## Step 2 — Responde

1. ¿Qué aplicación abriste?
2. ¿En qué sistema operativo estás?
3. ¿La aplicación es un Terminal Emulator?
4. ¿Sabes qué Shell utiliza?

## Resultado esperado

Distinguir la aplicación de Terminal del Shell que se ejecuta dentro de ella.

---

# 19. Práctica 02 — Identificar nuestro Shell

Vamos a utilizar comandos de solo lectura.

## 19.1 macOS / Linux — Bash o Zsh

Puedes consultar el nombre del proceso asociado al Shell actual mediante:

```bash
ps -p $$ -o comm=
```

En Bash y Zsh, `$$` permite identificar el PID del Shell en este contexto habitual.

También puedes consultar:

```bash
echo "$SHELL"
```

### Importante

`$SHELL` suele indicar el Shell configurado para el usuario, pero no garantiza que sea el Shell que está ejecutándose actualmente.

Por ejemplo, podrías tener Zsh como Shell predeterminado y haber iniciado Bash manualmente.

Por eso debemos distinguir:

- Default Shell.
- Current Shell.

## 19.2 Windows — PowerShell

En una sesión de PowerShell:

```powershell
$PSVersionTable
```

Este comando permite consultar información sobre PowerShell.

Para ver el proceso actual:

```powershell
Get-Process -Id $PID
```

## 19.3 Resultado esperado

Poder responder:

- Qué Terminal utilizas.
- Qué Shell estás ejecutando.
- Qué versión de PowerShell utilizas, si corresponde.
- Qué diferencia existe entre Shell actual y predeterminado.

---

# 20. Práctica 03 — Identificar un comando interno y uno externo

Esta práctica está orientada a Bash y Zsh.

## Step 1 — Inspeccionar `cd`

```bash
type cd
```

El resultado debería indicar que `cd` es un comando interno del Shell.

La forma exacta del mensaje depende del Shell.

## Step 2 — Inspeccionar `git`

Si Git está instalado:

```bash
type git
```

Normalmente mostrará la ubicación del ejecutable o información equivalente.

## Step 3 — Comparar

| Command | Tipo esperado |
|---|---|
| `cd` | Built-in |
| `git` | External Executable, normalmente |

## Step 4 — PowerShell

En PowerShell podemos consultar:

```powershell
Get-Command Set-Location
```

Y:

```powershell
Get-Command git
```

`Set-Location` es un Cmdlet de PowerShell.

`git`, cuando está instalado y disponible, normalmente corresponde a una aplicación externa.

## Reflexión

¿Qué diferencias observas entre la resolución de comandos internos y externos?

### Aprendizaje

**El Shell no trata todos los comandos de la misma manera.**

---

# 21. Práctica 04 — Comprender el flujo de ejecución

Imagina que ejecutamos:

```bash
git --version
```

Completa mentalmente el siguiente flujo:

```text
Developer
    │
    ▼
__________
    │
    ▼
__________
    │
    ▼
Command Resolution
    │
    ▼
__________
    │
    ▼
Output
```

## Respuesta

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
    ▼
Executable / Process
    │
    ▼
Output
```

## Preguntas

1. ¿Qué componente recibe nuestra entrada?
2. ¿Qué componente interpreta la sintaxis?
3. ¿Qué componente localiza el ejecutable?
4. ¿Qué papel tiene el sistema operativo?
5. ¿Dónde observamos el resultado?

### Aprendizaje

**Comprender el flujo es más importante que memorizar una definición aislada.**

---

# 22. Casos reales de ingeniería

## Caso 1 — Git funciona en una terminal, pero no en otra

### Situación

Git funciona en Terminal.app, pero no en el Terminal integrado de VS Code.

### ¿El problema necesariamente es Git?

No.

Podría estar relacionado con:

- Diferencias de `PATH`.
- Variables heredadas.
- Configuración del Shell.
- Sesiones iniciadas de forma diferente.

### Concepto aprendido

Terminal y Shell son componentes distintos, y cada sesión puede tener su propio entorno.

---

## Caso 2 — Un comando funciona en Bash, pero falla en PowerShell

### Situación

Copiamos un comando Bash en PowerShell y recibimos un error.

### Posible causa

Los Shells utilizan sintaxis y mecanismos diferentes.

### Concepto aprendido

Los comandos y operadores no son necesariamente portables entre Shells.

---

## Caso 3 — Cerramos la terminal y el servidor se detiene

### Situación

Iniciamos un servidor desde una sesión de Shell.

Después cerramos la ventana y el servidor deja de funcionar.

### ¿Por qué puede suceder?

Porque el proceso puede estar asociado a la sesión y recibir señales o perder recursos necesarios al cerrarse.

No todos los procesos se comportan igual.

### Concepto aprendido

La relación entre Terminal, Shell y Process influye en la ejecución de aplicaciones.

---

## Caso 4 — Un Script funciona manualmente, pero falla en CI

### Situación

Un comando funciona en nuestra sesión interactiva, pero falla en un entorno automatizado.

### Posibles causas

- Variables ausentes.
- Diferente Shell.
- Configuración no cargada.
- `PATH` diferente.
- Directorio de trabajo distinto.

### Concepto aprendido

Un Shell interactivo y uno no interactivo pueden tener contextos diferentes.

---

# 23. Errores conceptuales frecuentes

### Error 1 — Pensar que Terminal y Shell son lo mismo

Son componentes relacionados con responsabilidades distintas.

### Error 2 — Pensar que Bash es una aplicación de Terminal

Bash es un Shell.

### Error 3 — Pensar que Windows Terminal es PowerShell

Windows Terminal es una aplicación de Terminal; PowerShell es un Shell.

### Error 4 — Pensar que VS Code tiene un Shell completamente propio

Su Terminal integrado puede utilizar Shells disponibles en el entorno.

### Error 5 — Pensar que todos los comandos son ejecutables externos

Algunos son internos, Alias o funciones.

### Error 6 — Pensar que `PATH` es una herramienta

`PATH` es una variable de entorno utilizada en la resolución de ejecutables.

### Error 7 — Pensar que `$SHELL` siempre identifica el Shell actual

Normalmente indica el Shell configurado, que puede diferir del proceso actual.

### Error 8 — Pensar que Git Bash es una distribución Linux

Git Bash funciona sobre Windows y proporciona un entorno de compatibilidad.

### Error 9 — Pensar que un Shell necesita una ventana gráfica

También puede ejecutarse en contextos no interactivos o remotos.

### Error 10 — Confundir programa y proceso

Un programa es software ejecutable; un proceso es una instancia en ejecución.

### Error 11 — Copiar el símbolo del Prompt

El Prompt no suele formar parte del comando.

### Error 12 — Pensar que todos los Shells interpretan la misma sintaxis

Bash, Zsh y PowerShell tienen diferencias importantes.

---

# 24. Comprueba tu modelo mental

Responde con tus propias palabras.

1. ¿Qué es una User Interface?
2. ¿Qué diferencia existe entre GUI y CLI?
3. ¿Qué es un Terminal?
4. ¿Qué es un Terminal Emulator?
5. ¿Por qué se utiliza la palabra Emulator?
6. ¿Qué es un Shell?
7. ¿Cuál es la responsabilidad principal de un Shell?
8. ¿El Shell es el sistema operativo?
9. ¿Qué diferencia existe entre Terminal y Shell?
10. ¿Podemos utilizar diferentes Shells dentro de un mismo Terminal?
11. ¿Qué es una Shell Session?
12. ¿Qué información puede mantener una sesión?
13. ¿Qué es un Command?
14. ¿Qué es un Built-in Command?
15. ¿Qué es un External Executable?
16. ¿Qué es un Alias?
17. ¿Qué es una Shell Function?
18. ¿Qué es un Executable?
19. ¿Qué es un Process?
20. ¿Qué es un PID?
21. ¿Qué sucede cuando ejecutamos `git --version`?
22. ¿Qué papel tiene `PATH`?
23. ¿Qué es Bash?
24. ¿Qué es Zsh?
25. ¿Qué es PowerShell?
26. ¿Qué es Git Bash?
27. ¿Git Bash es equivalente a WSL?
28. ¿Qué es el Terminal integrado de VS Code?
29. ¿Qué diferencia existe entre un Shell interactivo y uno no interactivo?
30. ¿Qué es un Prompt?
31. ¿Qué diferencia existe entre Default Shell y Current Shell?
32. ¿Por qué dos sesiones pueden tener variables diferentes?
33. ¿Por qué un comando puede funcionar en una terminal y fallar en otra?
34. ¿Por qué un Script puede funcionar localmente y fallar en CI?
35. ¿Por qué es importante comprender estas diferencias antes de estudiar Node.js?

---

# 25. Checklist de aprendizaje

- [ ] Comprendo qué es una interfaz de usuario.
- [ ] Distingo GUI y CLI.
- [ ] Sé explicar qué es un Terminal.
- [ ] Comprendo qué es un Terminal Emulator.
- [ ] Sé explicar qué es un Shell.
- [ ] Distingo Terminal y Shell.
- [ ] Conozco Bash, Zsh y PowerShell.
- [ ] Comprendo qué es una Shell Session.
- [ ] Comprendo qué es un Command.
- [ ] Distingo comandos internos y externos.
- [ ] Comprendo qué es un Executable.
- [ ] Comprendo qué es un Process.
- [ ] Comprendo qué es un PID.
- [ ] Sé explicar el flujo básico de ejecución.
- [ ] Comprendo el papel del sistema operativo.
- [ ] Sé qué es Git Bash.
- [ ] Sé qué es el Terminal integrado de VS Code.
- [ ] Distingo Shell interactivo y no interactivo.
- [ ] Comprendo qué es un Prompt.
- [ ] Puedo identificar mi Shell actual.
- [ ] Puedo identificar qué tipo de comando estoy ejecutando.
- [ ] Reconozco los principales errores conceptuales.

---

# 26. Idea clave

Cuando ejecutamos un comando, no estamos interactuando directamente con una única herramienta.

Intervienen diferentes componentes.

```text
Developer
    │
    ▼
Terminal Emulator
    │
    ▼
Shell
    │
    ▼
Command
    │
    ▼
Executable / Built-in
    │
    ▼
Operating System Resources
    │
    ▼
Result
```

Cada componente tiene una responsabilidad.

**Terminal proporciona la interfaz. Shell interpreta las instrucciones. Los programas realizan operaciones y el sistema operativo administra los recursos necesarios.**

Comprender esta separación nos permitirá investigar errores y trabajar con herramientas de desarrollo de manera mucho más profesional.

---

# 27. Siguiente paso

Ahora que comprendemos la diferencia entre Terminal, Shell y CLI, podemos comenzar a trabajar con comandos.

En el siguiente documento aprenderemos:

- Cómo se estructura un comando.
- Qué son los argumentos.
- Qué son las opciones y Flags.
- Qué son los Subcommands.
- Cómo consultar ayuda.
- Cómo utilizar el historial.
- Qué es Autocompletion.
- Cómo interpretar resultados y Exit Codes básicos.

👉 [02 — Command Line Basics](./02-command-line-basics.md)

**Primero comprendimos quién ejecuta los comandos. Ahora aprenderemos cómo se construyen y utilizan.**