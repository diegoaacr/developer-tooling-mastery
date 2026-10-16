# Development Environment

Antes de comenzar a instalar Runtimes, Package Managers, configurar proyectos o automatizar procesos, necesitamos comprender **cómo funciona el entorno donde desarrollamos software**.

Cada vez que abrimos un editor, ejecutamos un comando, instalamos una herramienta o iniciamos una aplicación, estamos interactuando con diferentes componentes de nuestro sistema.

Estos componentes forman parte de nuestro **Development Environment**.

Este módulo construye los fundamentos necesarios para comprender, preparar y mantener un entorno de desarrollo moderno dentro de **Developer Tooling Mastery 2026**.

---

## 🎯 Objetivo

Al finalizar este módulo deberías poder explicar con tus propias palabras:

- Qué es un Development Environment.
- Qué componentes forman parte de un entorno de desarrollo.
- Qué diferencia existe entre configuraciones locales, de usuario y de proyecto.
- Cómo se relacionan las configuraciones personales con los estándares de un equipo.
- Qué significa tener un entorno reproducible.
- Qué capas intervienen en un entorno de desarrollo.
- Qué particularidades presentan macOS, Windows y Linux.
- Qué papel cumplen las herramientas de línea de comandos.
- Cómo se instalan y localizan herramientas en diferentes sistemas operativos.
- Qué son las variables de entorno y cómo influye `PATH` en la ejecución de comandos.
- Cómo reconocer problemas habituales de configuración.
- Qué buenas prácticas permiten mantener un entorno limpio, seguro y documentado.

El objetivo no será memorizar comandos de cada sistema operativo.

👉 Queremos comprender cómo está construido nuestro entorno y cómo diagnosticarlo cuando algo no funciona.

---

## 🧠 ¿Por qué estudiar el Development Environment?

Imagina que comenzamos a trabajar en un proyecto JavaScript.

La documentación indica que debemos ejecutar:

```bash
pnpm install
pnpm dev
```

Pero al ejecutar el primer comando obtenemos un error:

```text
pnpm: command not found
```

¿Qué significa realmente?

Podrían existir diferentes causas:

- pnpm no está instalado.
- El ejecutable no está disponible en el `PATH`.
- Estamos utilizando un entorno diferente al esperado.
- Existe un problema con la configuración del Shell.
- La herramienta está instalada, pero no está correctamente habilitada o accesible.

Si solamente memorizamos comandos, posiblemente intentaremos reinstalar herramientas sin comprender el problema.

En cambio, si conocemos nuestro Development Environment, podremos investigar de manera ordenada.

```text
Command
    ↓
Shell
    ↓
Executable Resolution
    ↓
Operating System
    ↓
Process Execution
```

Este modelo es simplificado, pero nos ayuda a comprender que ejecutar un comando involucra más que escribir instrucciones en una terminal.

---

## 🧩 Primero el entorno, después las herramientas

Durante este Mastery seguiremos nuestro principio fundamental:

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
```

Por ejemplo, antes de instalar un Runtime como Node.js, necesitamos comprender:

```text
Operating System
        ↓
Development Environment
        ↓
Tool Installation
        ↓
Executable Location
        ↓
PATH
        ↓
Runtime Execution
```

No significa que debamos convertirnos en administradores de sistemas antes de programar.

Significa que debemos comprender los mecanismos fundamentales que afectan nuestro trabajo diario.

---

## 🏗️ ¿Qué forma parte de un Development Environment?

Un entorno de desarrollo moderno puede incluir diferentes componentes.

Conceptualmente:

```text
Development Environment
│
├── Operating System
│   ├── macOS
│   ├── Windows
│   └── Linux
│
├── File System
│
├── Terminal and Shell
│
├── Environment Variables
│   └── PATH
│
├── Development Tools
│   ├── Git
│   ├── Runtime
│   ├── Package Manager
│   └── Build Tools
│
├── Code Editor
│
├── Project Configuration
│
└── Team Standards
```

No todos estos componentes serán estudiados en profundidad dentro de este módulo.

Aquí comprenderemos cómo encajan en el entorno general.

Posteriormente dedicaremos módulos específicos a Terminal, Shell, Editor, Runtime Management y Package Managers.

---

## 🖥️ El sistema operativo como base

Nuestro entorno de desarrollo funciona sobre un sistema operativo.

Por ejemplo:

```text
macOS
Windows
Linux
```

Cada sistema tiene características propias relacionadas con:

- Organización de archivos.
- Rutas y directorios.
- Permisos.
- Instalación de herramientas.
- Variables de entorno.
- Shells disponibles.
- Configuración del usuario.
- Administración de procesos.

Aunque muchos conceptos son compartidos, su implementación puede variar.

Por ejemplo, las rutas pueden representarse de manera diferente.

En sistemas Unix-like:

```text
/home/developer/projects
```

En Windows:

```text
C:\Users\Developer\Projects
```

Estas diferencias importan cuando configuramos herramientas o ejecutamos comandos.

---

## ⚙️ Configuración local, de usuario y de proyecto

No todas las configuraciones tienen el mismo alcance.

Podemos encontrar configuraciones asociadas a:

```text
Machine
    ↓
User
    ↓
Project
```

Este diagrama representa ámbitos de configuración, no una jerarquía universal de precedencia.

Por ejemplo:

**Machine Configuration**

Configuraciones que afectan al sistema o a varios usuarios.

**User Configuration**

Preferencias y herramientas asociadas a una cuenta de usuario.

**Project Configuration**

Configuraciones relacionadas con un proyecto específico.

La precedencia real depende de cada herramienta y sistema.

Comprender estas diferencias nos ayudará a evitar problemas de configuración y conflictos entre proyectos.

---

## 👥 Configuración personal vs estándares del equipo

Cada desarrollador puede tener preferencias diferentes.

Por ejemplo:

```text
Developer A
    ↓
VS Code
```

```text
Developer B
    ↓
Another Editor
```

Ambos podrían trabajar correctamente en el mismo proyecto.

Sin embargo, existen decisiones que conviene compartir.

Por ejemplo:

```text
Required Runtime Version
Package Manager Version
Project Scripts
Formatting Rules
Linting Rules
```

Estas decisiones contribuyen a mantener un comportamiento consistente entre desarrolladores.

El objetivo no es obligar a todos a utilizar una computadora idéntica.

Queremos distinguir qué aspectos pueden ser personales y cuáles deben estar definidos por el proyecto o equipo.

---

## 🔁 Reproducible Development Environments

Uno de los problemas más conocidos en desarrollo de software es:

> It works on my machine.

Esto sucede cuando un proyecto funciona en un entorno, pero presenta problemas en otro.

Por ejemplo:

```text
Developer A
    ↓
Project Works
```

```text
Developer B
    ↓
Project Fails
```

Las diferencias pueden estar relacionadas con:

```text
Operating System
Runtime Versions
Dependency Versions
Environment Variables
Installed Tools
Local Configuration
```

Un entorno reproducible busca controlar y documentar las condiciones necesarias para trabajar correctamente.

Conceptualmente:

```text
Declared Requirements
        ↓
Documented Setup
        ↓
Consistent Tool Versions
        ↓
Repeatable Commands
        ↓
More Predictable Results
```

La reproducibilidad no implica que todos los desarrolladores deban utilizar exactamente el mismo hardware o sistema operativo.

Tampoco garantiza que nunca existan diferencias.

Su objetivo es reducir variaciones innecesarias y facilitar la preparación y diagnóstico del entorno.

---

## 🧱 Las capas de nuestro entorno

Podemos estudiar nuestro Development Environment mediante diferentes capas.

```text
Developer
    ↓
Editor / Terminal
    ↓
Shell
    ↓
Development Tools
    ↓
Operating System
    ↓
Hardware
```

Este es un modelo conceptual simplificado, no una descripción literal de todas las rutas de ejecución.

Nos permitirá comprender preguntas como:

- ¿Qué responsabilidad tiene el sistema operativo?
- ¿Qué diferencia existe entre Terminal y Shell?
- ¿Cómo encuentra el sistema un ejecutable?
- ¿Dónde se almacenan las configuraciones?
- ¿Por qué un comando funciona en un entorno y no en otro?

Comprenderemos estas relaciones antes de profundizar en herramientas concretas.

---

## 🍎 Development Environment en macOS

macOS es un sistema operativo ampliamente utilizado para desarrollo de software.

Durante este módulo estudiaremos aspectos como:

```text
macOS
│
├── Development Setup
├── Command Line Tools
├── Homebrew
├── PATH Configuration
└── Common Issues
```

Aprenderemos qué papel cumplen las Command Line Tools y cómo Homebrew puede ayudarnos a administrar herramientas del sistema.

También estudiaremos cómo se relacionan las instalaciones con las rutas y variables de entorno.

No asumiremos que todas las herramientas deben instalarse mediante Homebrew.

Primero comprenderemos las alternativas y sus responsabilidades.

---

## 🪟 Development Environment en Windows

Windows dispone de diferentes herramientas y entornos para trabajar con desarrollo de software.

Por ejemplo:

```text
Windows
│
├── Windows Terminal
├── PowerShell
├── Git Bash
└── WSL
```

Estas herramientas no son equivalentes.

Windows Terminal es una aplicación de terminal.

PowerShell es un Shell y entorno de automatización.

Git Bash proporciona un entorno compatible con Bash y utilidades habituales de Unix para Windows.

WSL permite ejecutar entornos Linux integrados con Windows.

Estudiaremos sus diferencias y comprenderemos cuándo puede resultar útil cada uno.

---

## 🐧 Development Environment en Linux

Linux es una plataforma importante para desarrollo de software, servidores y entornos de infraestructura.

Durante este módulo estudiaremos:

```text
Linux
│
├── Development Setup
├── Package Managers
├── Shell Configuration
└── Common Issues
```

Aprenderemos cómo se administran herramientas mediante gestores de paquetes del sistema.

Por ejemplo:

```text
apt
dnf
pacman
```

Estos gestores no deben confundirse con Package Managers de JavaScript como npm, pnpm o Yarn.

Sus responsabilidades y ecosistemas son diferentes.

---

## 🧭 ¿Debemos dominar los tres sistemas operativos?

No necesariamente.

Nuestro objetivo es comprender los fundamentos comunes y aprender a trabajar correctamente en nuestro sistema principal.

La estrategia será:

```text
Common Concepts
       ↓
Primary Operating System
       ↓
Practical Configuration
       ↓
Troubleshooting
       ↓
Other Operating Systems as Reference
```

Esto nos permitirá avanzar sin estudiar configuraciones que todavía no necesitamos.

Sin embargo, conocer las diferencias principales entre macOS, Windows y Linux nos ayudará cuando trabajemos con equipos, servidores o entornos de CI.

---

## 🧰 Buenas prácticas de un entorno profesional

Un Development Environment debe ser comprensible y mantenible.

Por eso estudiaremos prácticas relacionadas con:

**Clean Development Machine**

Mantener herramientas y configuraciones organizadas, evitando instalaciones innecesarias.

**Avoid Global Pollution**

Reducir dependencias globales innecesarias y comprender cuándo una instalación global está justificada.

**Document Your Environment**

Registrar requisitos e instrucciones para preparar el entorno.

**Keep Your Tools Updated**

Mantener herramientas actualizadas de manera controlada, considerando compatibilidad y estabilidad.

Actualizar todo indiscriminadamente no siempre es una buena práctica.

Debemos comprender el impacto de los cambios de versión.

---

## 🗺️ El mapa que vamos a construir

Este módulo seguirá cinco áreas principales:

```text
Development Environment
│
├── Concepts
│   └── Understand the environment
│
├── macOS
│   └── Configure and diagnose macOS
│
├── Windows
│   └── Configure and diagnose Windows
│
├── Linux
│   └── Configure and diagnose Linux
│
└── Best Practices
    └── Maintain a professional environment
```

Primero estudiaremos los conceptos comunes.

Después podremos profundizar en nuestro sistema operativo principal.

Finalmente consolidaremos buenas prácticas aplicables a distintos entornos.

---

## 📚 Contenido del módulo

Esta será nuestra estructura de aprendizaje:

```text
01-development-environment/
│
├── README.md
│
├── 01-concepts/
│   ├── 01-what-is-a-development-environment.md
│   ├── 02-local-vs-project-configuration.md
│   ├── 03-user-vs-team-configuration.md
│   ├── 04-reproducible-environments.md
│   └── 05-development-environment-layers.md
│
├── 02-macos/
│   ├── 01-macos-development-setup.md
│   ├── 02-command-line-tools.md
│   ├── 03-homebrew.md
│   ├── 04-macos-path-configuration.md
│   └── 05-common-macos-issues.md
│
├── 03-windows/
│   ├── 01-windows-development-setup.md
│   ├── 02-windows-terminal.md
│   ├── 03-powershell.md
│   ├── 04-git-bash.md
│   ├── 05-wsl.md
│   └── 06-common-windows-issues.md
│
├── 04-linux/
│   ├── 01-linux-development-setup.md
│   ├── 02-package-managers.md
│   ├── 03-shell-configuration.md
│   └── 04-common-linux-issues.md
│
└── 05-best-practices/
    ├── 01-clean-development-machine.md
    ├── 02-avoid-global-pollution.md
    ├── 03-document-your-environment.md
    └── 04-keep-your-tools-updated.md
```

Cada documento tendrá una responsabilidad específica.

No necesitamos dominar todos los sistemas operativos con el mismo nivel de profundidad.

---

## 🔄 Progresión del módulo

Nuestro recorrido conceptual será:

```text
What Is a Development Environment?
              ↓
Configuration Scope
              ↓
User vs Team Configuration
              ↓
Reproducible Environments
              ↓
Development Environment Layers
              ↓
Operating System Setup
              ↓
Environment Diagnostics
              ↓
Best Practices
```

Los documentos de macOS, Windows y Linux funcionarán como rutas específicas de aprendizaje y consulta.

---

## 🧪 Cómo practicaremos

A diferencia de `00-mental-model`, este módulo incorporará comprobaciones prácticas cuando ayuden a comprender los conceptos.

Por ejemplo:

- Identificar nuestro sistema operativo.
- Consultar variables de entorno.
- Comprobar dónde se encuentra un ejecutable.
- Verificar la disponibilidad de herramientas.
- Reconocer diferencias entre configuraciones.
- Investigar problemas comunes de instalación.

Cada práctica deberá tener un propósito.

No ejecutaremos comandos sin comprender qué hacen y qué resultados esperamos obtener.

Cuando un experimento requiera mayor profundidad, podremos desarrollarlo posteriormente dentro de `labs/`.

---

## 🔗 Relación con los siguientes módulos

Este módulo es la base para comprender las herramientas que estudiaremos después.

```text
01 — Development Environment
             ↓
02 — Terminal and Shell
             ↓
03 — Editor and Workspace
             ↓
04 — Runtime Management
             ↓
05 — Package Managers
```

En este módulo conoceremos el contexto general de estas herramientas.

En los siguientes profundizaremos en sus responsabilidades.

| Módulo | Qué estudiaremos |
|---|---|
| 01 — Development Environment | Entorno, sistemas operativos, configuración y buenas prácticas |
| 02 — Terminal and Shell | Terminales, Shells, comandos y automatización básica |
| 03 — Editor and Workspace | Editor, extensiones, preferencias y Workspace del editor |
| 04 — Runtime Management | Node.js y administración de versiones |
| 05 — Package Managers | npm, pnpm, Yarn y administración de dependencias |

Esta separación nos ayudará a evitar duplicaciones.

---

## ⚠️ Qué NO haremos todavía

En este módulo no profundizaremos en:

```text
Advanced Shell Scripting
Node.js Runtime Internals
nvm Configuration
pnpm Workspaces
JavaScript Dependency Resolution
ESLint Configuration
Prettier Configuration
TypeScript Tooling
Vite / Rsbuild
Git Hooks
CI Pipelines
Nx
```

Estas responsabilidades pertenecen a módulos posteriores.

Sí podremos mencionar herramientas y utilizar comandos sencillos cuando sea necesario para comprender el entorno.

Pero evitaremos adelantarnos a configuraciones que todavía no hemos estudiado.

---

## 🧠 Comprueba tu modelo mental

Al finalizar este módulo deberías poder responder:

1. ¿Qué es un Development Environment?
2. ¿Qué responsabilidad tiene el sistema operativo?
3. ¿Qué diferencia existe entre una configuración de usuario y una de proyecto?
4. ¿Qué configuraciones conviene compartir con el equipo?
5. ¿Qué significa que un entorno sea reproducible?
6. ¿Qué papel cumple `PATH`?
7. ¿Por qué un comando puede funcionar en una terminal y fallar en otra?
8. ¿Qué diferencias existen entre Windows Terminal, PowerShell, Git Bash y WSL?
9. ¿Qué responsabilidad tiene Homebrew en macOS?
10. ¿En qué se diferencian los gestores de paquetes del sistema y los de JavaScript?
11. ¿Por qué debemos evitar instalaciones globales innecesarias?
12. ¿Qué información deberíamos documentar sobre nuestro entorno?

No necesitamos memorizar todas las respuestas.

Queremos poder explicarlas y comprobarlas mediante ejemplos prácticos.

---

## 💡 Idea clave

Nuestro Development Environment es el conjunto de componentes, herramientas y configuraciones que utilizamos para construir software.

```text
Developer
    ↓
Development Environment
    ↓
Operating System
    +
Tools
    +
Configuration
    +
Project Requirements
```

Comprender este entorno nos permite trabajar con mayor autonomía, diagnosticar problemas y preparar proyectos de forma consistente.

**Un desarrollador profesional no solamente sabe ejecutar herramientas: comprende el entorno donde funcionan.**

---

## 🚀 Siguiente paso

Comenzaremos estudiando el concepto fundamental de este módulo.

Antes de configurar macOS, Windows o Linux, necesitamos responder:

**¿Qué es exactamente un Development Environment?**

👉 [What Is a Development Environment?](./01-concepts/01-what-is-a-development-environment.md)