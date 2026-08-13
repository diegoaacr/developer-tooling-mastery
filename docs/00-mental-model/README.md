# Mental Model

Antes de instalar herramientas, escribir configuraciones o crear proyectos, necesitamos entender **qué estamos construyendo y cómo encajan las diferentes piezas de un proyecto de software moderno**.

Este módulo construye el modelo mental que utilizaremos durante todo **Developer Tooling Mastery 2026**.

---

## 🎯 Objetivo

Al finalizar este módulo deberías poder explicar con tus propias palabras:

- Qué es un proyecto de software.
- Por qué un proyecto es más que su código fuente.
- Cómo se estructura conceptualmente un proyecto moderno.
- Qué diferencia existe entre una aplicación y una librería.
- Qué es un package.
- Qué es un workspace.
- Qué es un repository.
- Qué diferencia existe entre monorepo y polyrepo.
- Por qué existe Developer Tooling.
- Cómo trabajan los equipos modernos alrededor de estas herramientas.

El objetivo todavía no es configurar herramientas.

👉 Primero construiremos el mapa. Después aprenderemos a utilizar cada pieza.

---

## 🧠 ¿Por qué empezar por un Mental Model?

Cuando comenzamos en desarrollo de software es común aprender herramientas de manera aislada:

```text
Node.js
pnpm
ESLint
Prettier
TypeScript
Vite
Git
GitHub Actions
Nx
```

Podemos aprender comandos y configuraciones sin comprender realmente **por qué existen esas herramientas o qué responsabilidad tiene cada una**.

Eso genera una visión fragmentada.

Por ejemplo:

```text
pnpm install
pnpm dev
pnpm build
```

pueden convertirse simplemente en comandos que sabemos ejecutar.

Pero queremos entender qué ocurre alrededor de ellos.

---

## 🧩 Primero el problema, después la herramienta

Durante este Mastery seguiremos una regla fundamental:

```text
Problem
    ↓
Concept
    ↓
Tool
    ↓
Configuration
    ↓
Practice
    ↓
Integration
```

No empezaremos preguntando:

> ¿Qué herramienta debo instalar?

Primero preguntaremos:

> ¿Qué problema necesitamos resolver?

Después estudiaremos qué concepto existe detrás del problema y finalmente qué herramientas pueden ayudarnos.

---

## 🏗️ Un proyecto no es solamente código

Una aplicación sencilla puede parecer inicialmente algo como:

```text
project/
└── src/
```

Pero un proyecto profesional normalmente necesita muchas más piezas:

```text
project/
│
├── source-code/
├── tests/
├── dependencies/
├── configuration/
├── tooling/
├── documentation/
└── automation/
```

A lo largo del Mastery aprenderemos cómo aparecen estas piezas y qué responsabilidad tiene cada una.

No construiremos todo desde el principio.

El proyecto evolucionará junto con nuestro conocimiento.

---

## 🗺️ El mapa que vamos a construir

Durante este módulo comenzaremos a relacionar conceptos como:

```text
Developer
    ↓
Development Environment
    ↓
Repository
    ↓
Software Project
    ↓
Application / Library
    ↓
Package
    ↓
Dependencies
    ↓
Tooling
```

Más adelante este modelo crecerá hasta incluir:

```text
Runtime
Package Manager
Project Metadata
Formatting
Linting
Type Checking
Build Tools
Environment Configuration
Git Hooks
CI
Dependency Management
Workspaces
Monorepos
Nx
```

Todavía no necesitamos dominar estas herramientas.

Por ahora necesitamos entender **dónde encajarán cuando aparezcan**.

---

## 📦 Project, Package, Workspace y Repository

Durante el desarrollo moderno aparecen constantemente términos como:

```text
Project
Package
Workspace
Repository
Monorepo
Polyrepo
```

Aunque están relacionados, **no significan lo mismo**.

Este módulo establecerá una primera definición de cada uno para evitar confusiones posteriores.

Por ejemplo, empezaremos a comprender relaciones como:

```text
Repository
    ↓
can contain
    ↓
one or multiple projects
```

y:

```text
Workspace
    ↓
can manage
    ↓
multiple packages
```

Más adelante profundizaremos técnicamente en estas relaciones.

---

## 🏢 Cómo conecta esto con proyectos reales

En proyectos pequeños muchas decisiones pueden pasar desapercibidas.

Pero cuando aparecen:

```text
Multiple Developers
Multiple Applications
Shared Libraries
Different Environments
Continuous Integration
Automated Quality Checks
Multiple Packages
```

la organización del proyecto empieza a importar mucho más.

Developer Tooling ayuda a que ese entorno sea:

- Reproducible.
- Consistente.
- Automatizable.
- Mantenible.
- Escalable.
- Comprensible para el equipo.

Durante el Mastery construiremos progresivamente ese entorno.

---

## 🏗️ El repositorio también será nuestro proyecto

**Developer Tooling Mastery 2026** no será únicamente documentación.

El propio repositorio evolucionará conforme avancemos.

Actualmente comenzamos prácticamente con:

```text
developer-tooling-mastery-2026/
│
├── README.md
├── ROADMAP.md
├── STUDY-PLAN.md
├── docs/
└── ...
```

En este punto tenemos principalmente:

```text
Documentation
```

Más adelante incorporaremos progresivamente:

```text
Development Environment
        ↓
Runtime
        ↓
Package Manager
        ↓
Project Configuration
        ↓
Tooling
        ↓
Projects
        ↓
Packages
        ↓
Workspace
        ↓
Monorepo
        ↓
Nx
```

Esto significa que **el repositorio crecerá al mismo ritmo que nuestro conocimiento**.

---

## 🧱 Nuestro objetivo arquitectónico

Eventualmente trabajaremos con una estructura capaz de contener múltiples proyectos y packages relacionados.

Conceptualmente:

```text
developer-tooling-mastery-2026/
│
├── docs/
├── labs/
├── projects/
├── packages/
├── templates/
├── tools/
└── ...
```

La arquitectura final utilizará un enfoque de **Monorepo**.

Sin embargo, no lo configuraremos todavía.

Primero aprenderemos:

```text
What is a Project?
        ↓
What is a Package?
        ↓
What is a Workspace?
        ↓
What is a Repository?
        ↓
Monorepo vs Polyrepo
```

Cuando lleguemos a los módulos correspondientes, construiremos la implementación real.

---

## 📚 Contenido del módulo

Seguiremos este recorrido:

```text
00-mental-model/
│
├── README.md
├── 01-how-to-use-this-repo.md
├── 02-learning-path.md
├── 03-what-is-a-software-project.md
├── 04-modern-project-architecture.md
├── 05-application-vs-library.md
├── 06-what-is-a-package.md
├── 07-what-is-a-workspace.md
├── 08-what-is-a-repository.md
├── 09-monorepo-vs-polyrepo.md
├── 10-why-developer-tooling-matters.md
├── 11-how-modern-companies-build-software.md
├── 12-what-we-will-build.md
└── 13-tooling-mindset.md
```

Cada documento añadirá una pieza al modelo mental.

---

## 🔄 Progresión del módulo

La idea general será:

```text
How to Learn
      ↓
Learning Path
      ↓
Software Project
      ↓
Modern Project Architecture
      ↓
Application vs Library
      ↓
Package
      ↓
Workspace
      ↓
Repository
      ↓
Monorepo vs Polyrepo
      ↓
Developer Tooling
      ↓
Modern Software Teams
      ↓
What We Will Build
      ↓
Tooling Mindset
```

Al terminar deberíamos tener suficiente contexto para comenzar a estudiar el entorno de desarrollo sin tratar cada herramienta como una pieza aislada.

---

## ⚠️ Qué NO haremos todavía

En este módulo no vamos a configurar:

```text
Node.js
pnpm
package.json
pnpm-workspace.yaml
ESLint
Prettier
Biome
TypeScript
Vite
Rsbuild
Husky
GitHub Actions
Nx
```

Todas estas herramientas llegarán en su momento.

Cuando aparezcan, deberíamos poder responder primero:

> ¿Qué problema está resolviendo esta herramienta dentro de nuestro proyecto?

---

## 🧠 Idea clave

No queremos terminar este Mastery siendo desarrolladores que saben copiar configuraciones.

Queremos poder observar un proyecto y entender:

```text
What exists?
      ↓
Why does it exist?
      ↓
What problem does it solve?
      ↓
How does it interact with everything else?
```

Después podremos elegir y configurar herramientas con criterio.

---

## 🚀 Siguiente paso

Antes de estudiar los conceptos técnicos, entendamos cómo recorrer correctamente este repositorio.

👉 [How to Use This Repo](./01-how-to-use-this-repo.md)