# Learning Path

**Developer Tooling Mastery 2026** sigue una ruta de aprendizaje progresiva.

Las herramientas no aparecen de manera aislada.

Cada etapa introduce conceptos necesarios para comprender la siguiente.

La idea principal es avanzar desde:

```text
Computer
    ↓
Development Environment
    ↓
Software Project
    ↓
Project Tooling
    ↓
Automation
    ↓
Repository Architecture
    ↓
Monorepo
    ↓
Professional Workspace
```

---

## 🎯 Objetivo

Al finalizar este documento deberías entender:

- Por qué el Mastery está organizado en un orden específico.
- Cómo se relacionan las diferentes capas de Developer Tooling.
- Por qué no comenzamos directamente instalando herramientas.
- Cómo evolucionará nuestro entorno de desarrollo.
- Cómo evolucionará el propio repositorio.
- En qué momento aparecerán conceptos como pnpm Workspaces, Monorepos y Nx.

El objetivo no es memorizar el Roadmap.

👉 El objetivo es comprender la progresión.

---

# 🧠 El problema de aprender herramientas aisladas

Es común aprender Developer Tooling de esta manera:

```text
Learn ESLint
Learn Prettier
Learn Vite
Learn pnpm
Learn Docker
Learn Nx
```

El problema es que esta aproximación puede convertir las herramientas en piezas aisladas.

Sabemos utilizarlas, pero no necesariamente sabemos:

```text
Why does this tool exist?

What problem does it solve?

Where does it belong?

What does it depend on?

What depends on it?

How does it interact with other tools?
```

Durante este Mastery construiremos primero el contexto.

---

# 🧱 Aprender por capas

Nuestro aprendizaje seguirá una idea sencilla:

```text
Layer 1
    ↓
Layer 2
    ↓
Layer 3
    ↓
Layer 4
```

Cada capa utiliza conocimientos anteriores.

Por ejemplo, antes de comprender correctamente:

```text
pnpm Workspaces
```

necesitamos comprender:

```text
Package Manager
Package
Dependency
package.json
Workspace
Repository
```

Y antes de comprender correctamente:

```text
Nx
```

necesitamos comprender:

```text
Monorepo
Workspace
Projects
Packages
Dependencies
Tasks
Build
Testing
Linting
```

Por eso el orden importa.

---

# 🗺️ Nuestra ruta completa

Conceptualmente, el Mastery avanzará así:

```text
Mental Model
      ↓
Development Environment
      ↓
Terminal & Shell
      ↓
Editor & Workspace
      ↓
Runtime
      ↓
Package Manager
      ↓
Project Metadata
      ↓
Project Files
      ↓
Formatting
      ↓
Linting
      ↓
TypeScript Tooling
      ↓
Build Tools
      ↓
Environment Configuration
      ↓
Git Hooks & Commit Quality
      ↓
CI & Automation
      ↓
Dependency Management
      ↓
Repository Architectures
      ↓
Monorepo Tooling
      ↓
Nx
      ↓
Project Standards
      ↓
Professional Workspace
```

No necesitas comprender todavía cada término.

Ese conocimiento aparecerá progresivamente.

---

# 0️⃣ Mental Model

Primero necesitamos entender el mapa.

Antes de instalar herramientas estudiaremos conceptos como:

```text
Software Project
Application
Library
Package
Workspace
Repository
Monorepo
Polyrepo
Developer Tooling
```

Esto nos permitirá ubicar correctamente las herramientas que aparecerán posteriormente.

La pregunta principal de esta etapa es:

> ¿Qué piezas existen alrededor de un proyecto de software moderno?

---

# 1️⃣ Development Environment

Después prepararemos el entorno donde desarrollamos software.

Un proyecto no existe aislado.

Se ejecuta dentro de una máquina que contiene:

```text
Operating System
Terminal
Shell
Editor
Runtime
Package Manager
Tools
```

Aquí comenzaremos a comprender también la diferencia entre:

```text
Machine Configuration

vs

Project Configuration
```

y por qué los entornos reproducibles son importantes.

---

# 2️⃣ Terminal & Shell

Muchas herramientas de desarrollo se utilizan mediante CLI.

Por eso necesitamos comprender:

```text
Terminal
Shell
Commands
Paths
Environment Variables
```

Antes de ejecutar cientos de comandos, queremos entender **dónde se están ejecutando y quién los interpreta**.

---

# 3️⃣ Editor & Workspace

Después configuraremos nuestro entorno de edición.

Estudiaremos conceptos como:

```text
Editor
IDE
User Settings
Workspace Settings
Extensions
Project Settings
```

Esto nos permitirá comenzar a diferenciar:

```text
My personal configuration
```

de:

```text
Team project configuration
```

---

# 4️⃣ Runtime

Ahora necesitaremos ejecutar herramientas y programas.

Aquí aparece:

```text
Node.js
```

Pero antes de instalarlo necesitamos comprender:

```text
What is a Runtime?

JavaScript vs Node.js

Runtime Versioning

Global vs Project Version
```

Después podremos comprender por qué controlar versiones de Node.js es importante para un equipo.

---

# 5️⃣ Package Manager

Cuando tenemos un Runtime, nuestro proyecto puede empezar a necesitar software externo.

Aquí aparecen:

```text
Dependencies
Dev Dependencies
node_modules
Lockfiles
Package Managers
```

Estudiaremos:

```text
npm
pnpm
Yarn
```

y profundizaremos especialmente en:

```text
pnpm
```

porque será el Package Manager principal del repositorio.

---

## ¿Por qué todavía no comenzamos con pnpm Workspaces?

Porque primero necesitamos comprender pnpm como Package Manager.

La progresión será:

```text
Package Manager
      ↓
pnpm
      ↓
Packages
      ↓
Dependencies
      ↓
Project Management
      ↓
Workspaces
```

Así, cuando lleguemos a Workspaces, no serán una configuración misteriosa.

---

# 6️⃣ Project Metadata

Cuando nuestro proyecto empieza a utilizar el ecosistema Node.js aparece uno de los archivos más importantes:

```text
package.json
```

Aquí aprenderemos conceptos como:

```text
name
version
private
scripts
dependencies
devDependencies
type
license
packageManager
engines
```

Nuestro repositorio empezará progresivamente a convertirse en un proyecto técnicamente configurable.

---

# 7️⃣ Project Files

Después incorporaremos archivos que permiten definir comportamiento y estándares del proyecto.

Por ejemplo:

```text
.editorconfig
.gitignore
.gitattributes
.env.example
```

La idea es comenzar a mover decisiones desde:

```text
Developer's Machine
```

hacia:

```text
Repository
```

para que puedan ser compartidas por el equipo.

---

# 8️⃣ Formatting

Ahora tendremos código y archivos compartidos entre desarrolladores.

Aparece un problema:

> ¿Cómo mantenemos un estilo consistente?

Aquí estudiaremos:

```text
EditorConfig
Prettier
Biome
```

Pero primero entenderemos:

```text
Formatting
```

como responsabilidad.

La herramienta viene después.

---

# 9️⃣ Linting

El siguiente problema será analizar nuestro código buscando problemas y reglas de calidad.

Aquí aparecerán:

```text
ESLint
Biome
Markdownlint
```

Y aprenderemos una distinción fundamental:

```text
Formatting
    ≠
Linting
    ≠
Type Checking
```

---

# 🔟 TypeScript Tooling

TypeScript aparecerá aquí desde la perspectiva de **Developer Tooling**.

No aprenderemos el lenguaje TypeScript completo.

Estudiaremos principalmente:

```text
tsconfig
Type Checking
Strict Mode
Path Aliases
Shared Configuration
```

El objetivo será comprender cómo TypeScript participa dentro del pipeline de calidad del proyecto.

---

# 1️⃣1️⃣ Build Tools

Una aplicación necesita ejecutarse durante desarrollo y eventualmente producir una versión preparada para distribución.

Aquí estudiaremos:

```text
Development Server
Build
Bundling
Build Tools
```

Y profundizaremos en:

```text
Vite
Rsbuild
```

No queremos únicamente saber crear un proyecto.

Queremos comprender qué responsabilidad tiene el Build Tool.

---

# 1️⃣2️⃣ Environment Configuration

Las aplicaciones necesitan comportarse de manera diferente dependiendo del entorno.

Aquí aparecen conceptos como:

```text
Environment Variables
Configuration
Secrets
Development
Testing
Staging
Production
```

Estudiaremos cómo administrar estas diferencias sin introducir secretos dentro del repositorio.

---

# 1️⃣3️⃣ Git Hooks & Commit Quality

Hasta este momento muchas verificaciones dependerán del desarrollador.

Por ejemplo:

```text
Remember to format
Remember to lint
Remember to check the commit message
```

Aquí aparece la automatización local.

Estudiaremos:

```text
Git Hooks
Husky
lint-staged
commitlint
Conventional Commits
```

El objetivo será transformar algunas buenas intenciones en verificaciones automáticas.

---

# 1️⃣4️⃣ CI & Automation

Los checks locales son útiles, pero no podemos depender únicamente de que cada desarrollador los ejecute.

Entonces movemos verificaciones también hacia:

```text
Continuous Integration
```

Estudiaremos:

```text
GitHub Actions
Quality Gates
Caching
Fail Fast
Monorepo CI
```

El proyecto empieza a validar automáticamente su calidad.

---

# 1️⃣5️⃣ Dependency Management

A medida que crece el proyecto también crece el número de dependencias.

Necesitaremos comprender:

```text
Semantic Versioning
Dependency Ranges
Updates
Security Updates
Renovate
Dependabot
```

Aquí aprenderemos que instalar una dependencia también implica **mantenerla durante el tiempo**.

---

# 1️⃣6️⃣ Repository Architectures

Hasta este punto podremos construir proyectos profesionales.

Ahora aparece otra pregunta:

> ¿Qué ocurre cuando tenemos múltiples aplicaciones, librerías y equipos?

Aquí profundizaremos en:

```text
Repository
Single Project Repository
Monorepo
Polyrepo
Workspace
```

Y estudiaremos los trade-offs de cada arquitectura.

---

# 1️⃣7️⃣ Monorepo Tooling

Después de comprender la arquitectura, podremos implementarla.

Aquí profundizaremos en:

```text
pnpm Workspaces
workspace:
Filtering
Shared Scripts
Shared Configurations
Dependency Boundaries
```

En este momento nuestro repositorio evolucionará realmente hacia un **Monorepo funcional**.

La progresión habrá sido:

```text
Understand Monorepo
        ↓
Understand Packages
        ↓
Understand Package Managers
        ↓
Understand Workspaces
        ↓
Implement Monorepo
```

---

# 1️⃣8️⃣ Nx

Una vez que tengamos múltiples Projects y Packages podremos experimentar nuevos problemas:

```text
Which project depends on which?

Which tasks need to run?

What changed?

What can be cached?

What needs to rebuild?
```

Aquí aparecerá Nx.

Estudiaremos:

```text
Project Graph
Task Graph
Caching
Affected
Boundaries
```

Nx aparecerá porque **ya tendremos problemas que Nx puede ayudarnos a resolver**.

No porque simplemente queramos utilizar Nx.

---

# 1️⃣9️⃣ Project Standards

Cuando tenemos múltiples proyectos necesitamos consistencia.

Aquí consolidaremos estándares como:

```text
Naming
Folders
Scripts
Imports
README
Documentation
```

La idea será pasar de:

```text
Multiple Projects
```

a:

```text
Multiple Consistent Projects
```

---

# 2️⃣0️⃣ Professional Workspace

Finalmente integraremos todas las capas.

Conceptualmente llegaremos a algo parecido a:

```text
Professional Workspace
│
├── Projects
├── Packages
├── Shared Configurations
├── Templates
├── Tooling
├── Quality Gates
├── Git Hooks
├── CI
├── Dependency Management
├── Monorepo Tooling
└── Documentation
```

Aquí ya no estaremos estudiando herramientas aisladas.

Estaremos observando **un sistema completo de Developer Tooling**.

---

# 🏗️ El repositorio evolucionará con la ruta

Nuestro repositorio también seguirá esta progresión.

## Estado inicial

```text
Repository
    ↓
Documentation
```

---

## Primera evolución

```text
Repository
    ↓
Development Environment
    ↓
Node.js
    ↓
pnpm
```

---

## Proyecto configurado

```text
Repository
│
├── package.json
├── configuration
├── tooling
├── docs/
└── ...
```

---

## Múltiples proyectos

```text
Repository
│
├── projects/
├── packages/
├── docs/
└── tooling/
```

---

## Workspace

```text
Repository
        ↓
pnpm Workspace
        ↓
Projects + Packages
```

---

## Monorepo profesional

```text
pnpm Workspace
        +
Shared Packages
        +
Quality Tooling
        +
CI
        +
Nx
        ↓
Professional Monorepo
```

El resultado final no aparecerá mágicamente.

Lo construiremos capa por capa.

---

# 🧠 Dependencias de conocimiento

También podemos observar el Mastery como un pequeño Dependency Graph.

```text
Terminal
   ↓
Runtime
   ↓
Package Manager
   ↓
Project Metadata
   ↓
Project Tooling
   ↓
Automation
```

Y paralelamente:

```text
Project
   ↓
Package
   ↓
Workspace
   ↓
Repository Architecture
   ↓
Monorepo
   ↓
Nx
```

Finalmente ambas rutas convergen:

```text
Project Tooling
        +
Monorepo Architecture
        ↓
Professional Workspace
```

Esta es una de las razones por las que no queremos saltarnos las primeras etapas.

---

# ⚠️ No confundas el orden con una regla absoluta

En proyectos reales las herramientas no siempre se incorporan exactamente en este orden.

Un equipo puede comenzar un proyecto utilizando directamente:

```text
Node
pnpm
TypeScript
Vite
ESLint
CI
```

porque sus desarrolladores ya comprenden las capas inferiores.

Nuestro orden tiene una finalidad **pedagógica**.

Queremos construir conocimiento progresivamente.

---

# 🔄 Cuando ya domines el Mastery

Después de completar la ruta, no necesitarás recorrerla siempre desde cero.

Podrás utilizar el repositorio como referencia:

```text
Need to configure ESLint?
        ↓
Go to Linting

Need to understand Workspaces?
        ↓
Go to Monorepo Tooling

Need to configure Vite?
        ↓
Go to Build Tools

Need Nx caching?
        ↓
Go to Nx
```

Primero funciona como:

```text
Learning Path
```

Después funciona también como:

```text
Reference
```

---

# 💡 Idea clave

La ruta completa puede resumirse así:

```text
Understand the environment
        ↓
Understand the project
        ↓
Configure the project
        ↓
Automate the project
        ↓
Scale the repository
        ↓
Standardize the workspace
```

Las herramientas aparecerán cuando exista un problema que justifique utilizarlas.

---

## 🚀 Siguiente paso

Ya sabemos cómo utilizar el repositorio y por qué el aprendizaje sigue este orden.

Ahora necesitamos definir la unidad alrededor de la cual construiremos todo el Tooling:

👉 [What Is a Software Project?](./03-what-is-a-software-project.md)