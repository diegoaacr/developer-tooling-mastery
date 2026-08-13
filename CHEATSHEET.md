# Cheatsheet

Referencia rápida de conceptos, comandos y configuraciones aprendidas durante **Developer Tooling Mastery 2026**.

Este documento está diseñado para consultar rápidamente información que ya fue estudiada previamente dentro del repositorio.

---

## 🎯 Purpose

El objetivo de este Cheatsheet es evitar tener que buscar constantemente información básica dentro de toda la documentación.

Aquí encontrarás referencias rápidas sobre:

- Comandos.
- Archivos de configuración.
- Estructuras.
- Convenciones.
- Herramientas.
- Flujos de trabajo.

Este documento **no reemplaza `docs/`**.

Si no comprendes un concepto, consulta primero su documentación correspondiente.

---

## 🧠 How to Use This Cheatsheet

Utiliza este archivo como referencia después de haber estudiado un concepto.

El flujo recomendado es:

```text
Learn
    ↓
Practice
    ↓
Understand
    ↓
Use Cheatsheet as Reference
```

No utilices el Cheatsheet para saltarte el aprendizaje.

---

## 🔄 Living Document

Este documento crecerá progresivamente durante el Mastery.

Cuando aprendamos una nueva herramienta o configuración importante:

```text
docs/
    ↓
labs/
    ↓
projects/
    ↓
CHEATSHEET.md
```

Solo agregaremos información que resulte útil como referencia rápida.

---

# 🖥️ Terminal

## Current Directory

Mostrar el directorio actual:

```bash
pwd
```

---

## List Files

Mostrar archivos y carpetas:

```bash
ls
```

Mostrar información adicional:

```bash
ls -la
```

---

## Change Directory

Entrar a una carpeta:

```bash
cd folder-name
```

Volver al directorio anterior:

```bash
cd ..
```

---

## Create Directory

```bash
mkdir project-name
```

---

## Create Nested Directories

```bash
mkdir -p parent/child
```

---

## Create File

Bash:

```bash
touch README.md
```

PowerShell:

```powershell
New-Item README.md -ItemType File
```

---

## Clear Terminal

Bash:

```bash
clear
```

PowerShell:

```powershell
Clear-Host
```

---

# 📂 Project Mental Model

Un proyecto profesional puede contener:

```text
project/
├── source-code/
├── configuration/
├── dependencies/
├── documentation/
└── tooling/
```

La aplicación no es únicamente su código fuente.

---

# 📦 Repository Models

## Single Project Repository

```text
repository/
└── application/
```

Un repositorio contiene principalmente un proyecto.

---

## Monorepo

```text
repository/
├── projects/
├── packages/
└── tools/
```

Un repositorio administra múltiples proyectos o paquetes relacionados.

---

## Polyrepo

```text
frontend-repository/

backend-repository/

shared-library-repository/
```

Cada proyecto o componente importante vive en un repositorio independiente.

---

# 🧩 Core Concepts

## Application

Software ejecutable destinado a usuarios, sistemas u otros servicios.

---

## Library

Código reutilizable utilizado por otras aplicaciones o paquetes.

---

## Package

Unidad de software que puede contener:

```text
Code
Configuration
Dependencies
Metadata
```

---

## Repository

Lugar donde se almacena y versiona uno o múltiples proyectos.

---

## Workspace

Entorno utilizado para administrar múltiples proyectos o paquetes relacionados.

---

## Runtime

Entorno encargado de ejecutar un programa.

Ejemplo:

```text
JavaScript → Language

Node.js → Runtime
```

---

## Terminal vs Shell

```text
Terminal
    ↓
provides interface to
    ↓
Shell
    ↓
interprets commands
    ↓
Operating System
```

Ejemplos de Shell:

```text
Bash
PowerShell
Zsh
```

---

# 📁 Important Project Files

Esta sección crecerá conforme avancemos por el Mastery.

```text
README.md
ROADMAP.md
STUDY-PLAN.md
CONTRIBUTING.md
CHANGELOG.md
LICENSE
GLOSSARY.md
CHEATSHEET.md
FAQ.md
```

### README.md

Presenta el propósito general del repositorio.

### ROADMAP.md

Define qué aprender y en qué orden.

### STUDY-PLAN.md

Define cómo estudiar el contenido.

### CONTRIBUTING.md

Define los estándares para contribuir al repositorio.

### CHANGELOG.md

Registra cambios relevantes entre versiones.

### GLOSSARY.md

Referencia rápida de términos y conceptos.

### CHEATSHEET.md

Referencia rápida de comandos, configuraciones y flujos ya aprendidos.

### FAQ.md

Responde preguntas frecuentes.

---

# 🧠 Mastery Learning Flow

La metodología principal es:

```text
Docs
    ↓
Labs
    ↓
Projects
    ↓
Templates
```

---

## Concept Learning Cycle

Para conceptos prácticos:

```text
Understand
    ↓
Configure
    ↓
Use
    ↓
Break
    ↓
Fix
    ↓
Integrate
```

---

## Knowledge Lifecycle

```text
Learn
    ↓
Practice
    ↓
Integrate
    ↓
Standardize
    ↓
Reuse
```

---

# 🏷️ Naming Conventions

## Folders

Utiliza:

```text
kebab-case
```

Ejemplo:

```text
package-managers/
runtime-management/
build-tools/
```

---

## Markdown Files

Utiliza nombres descriptivos:

```text
01-what-is-pnpm.md
02-pnpm-installation.md
03-pnpm-basic-commands.md
```

Cuando exista un orden pedagógico, utiliza prefijos numéricos.

---

## General Language Convention

```text
Folders          → English
Files            → English
Code             → English
Commands         → English
Technical terms  → English when appropriate
Explanations     → Spanish
```

---

# 📚 Documentation

La documentación principal vive en:

```text
docs/
```

La documentación explica:

```text
What?
Why?
How?
When?
When not?
Trade-offs?
```

---

# 🧪 Labs

Los Labs permiten experimentar con conceptos individuales.

```text
Concept
    ↓
Experiment
    ↓
Observe
    ↓
Break
    ↓
Fix
```

---

# 🚀 Projects

Los Projects integran múltiples conceptos.

Ejemplo conceptual:

```text
Runtime
    +
Package Manager
    +
Project Configuration
    +
Formatting
    +
Linting
    ↓
Professional Project
```

---

# 📦 Templates

Los Templates contienen configuraciones reutilizables que ya fueron comprendidas y validadas.

Regla:

```text
Understand first.

Template later.
```

---

# 🔧 Tooling Reference

Esta sección crecerá conforme las herramientas sean introducidas en el Mastery.

## Runtime

```text
Pending
```

## Package Managers

```text
Pending
```

## Formatting

```text
Pending
```

## Linting

```text
Pending
```

## Type Checking

```text
Pending
```

## Build Tools

```text
Pending
```

## Environment Configuration

```text
Pending
```

## Git Hooks

```text
Pending
```

## CI

```text
Pending
```

## Dependency Management

```text
Pending
```

## Monorepo Tooling

```text
Pending
```

## Nx

```text
Pending
```

---

# 💡 Quick Decision Rules

Estas reglas crecerán conforme estudiemos diferentes herramientas.

Por ahora:

```text
Understand before copying.

Prefer project configuration over unnecessary global configuration.

Do not install tools without understanding why they are needed.

Avoid unnecessary dependencies.

Do not introduce abstractions before understanding the underlying problem.

Prefer reproducible environments.

Automate repetitive quality checks.

Templates come after understanding.
```

---

# 🔄 Updating This Cheatsheet

Cuando aprendamos algo nuevo, no debemos copiar toda su documentación aquí.

Solo debemos agregar aquello que sea útil consultar rápidamente.

Por ejemplo:

Después de estudiar pnpm, podría agregarse:

```text
Install dependency

pnpm add <package>

Install dev dependency

pnpm add -D <package>

Run script

pnpm <script>
```

La explicación completa continuará viviendo en:

```text
docs/
```

---

## 🧠 Key Principle

El propósito del Cheatsheet es responder:

> ¿Cómo era ese comando, archivo, configuración o flujo que ya aprendí?

No:

> ¿Cómo funciona este concepto?

Para eso existe `docs/`.

---

## 🚀 Next Step

Continúa siguiendo [`ROADMAP.md`](./ROADMAP.md) y utiliza este documento como referencia rápida mientras avanzas.

El Cheatsheet crecerá progresivamente junto con **Developer Tooling Mastery 2026**.