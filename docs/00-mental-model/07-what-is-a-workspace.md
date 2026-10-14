# What Is a Workspace?

En el documento anterior aprendimos que un **Package** es una unidad de software que puede identificarse y administrarse dentro de un ecosistema.

También descubrimos que una Application puede depender de diferentes Packages.

Pero ahora imaginemos un escenario más complejo.

¿Qué sucede cuando desarrollamos varias aplicaciones y librerías relacionadas que queremos administrar de manera conjunta?

Aquí aparece el concepto de **Workspace**.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué es un Workspace.
- Qué problema resuelve.
- Qué significa administrar múltiples Packages conjuntamente.
- Qué diferencia existe entre Package y Workspace.
- Cómo se relacionan Applications, Libraries y Workspaces.
- Qué significa tener Internal Dependencies.
- Qué papel cumplen los Package Managers dentro de un Workspace.
- Qué diferencia existe entre Workspace y Monorepo.
- Por qué utilizaremos pnpm Workspaces en nuestro repositorio.

Todavía no configuraremos un Workspace.

Primero construiremos su modelo mental.

---

# 🧠 Empecemos con el problema

Imagina que una empresa desarrolla dos aplicaciones:

```text
customer-portal/
admin-portal/
```

Ambas necesitan funcionalidades compartidas.

Por ejemplo:

```text
UI Components
Validation
Date Utilities
```

Inicialmente podríamos tener:

```text
customer-portal/
├── src/
└── package.json

admin-portal/
├── src/
└── package.json

shared-ui/
├── src/
└── package.json

shared-validation/
├── src/
└── package.json
```

Cada unidad puede administrarse por separado.

Pero aparecen nuevas preguntas:

- ¿Cómo relacionamos estas unidades?
- ¿Cómo administramos sus dependencias?
- ¿Cómo ejecutamos tareas sobre varios Packages?
- ¿Cómo compartimos configuraciones?
- ¿Cómo trabajamos con todas estas unidades desde un mismo entorno?

Necesitamos una forma de administrarlas conjuntamente.

---

# 🏗️ ¿Qué es un Workspace?

En el contexto de Developer Tooling y Package Managers, un **Workspace** es un entorno que permite administrar múltiples Packages relacionados como parte de un conjunto.

Conceptualmente:

```text
Workspace
│
├── Package A
├── Package B
├── Package C
└── Package D
```

En lugar de tratar cada Package como una unidad completamente aislada, podemos establecer relaciones y operaciones compartidas.

Por ejemplo:

```text
Workspace
    ↓
manages
    ↓
Multiple Packages
```

Este será nuestro modelo mental inicial.

---

# 📦 Package vs Workspace

Recordemos:

```text
Package
    ↓
Individual software unit
```

Mientras que:

```text
Workspace
    ↓
Environment for managing related packages
```

Por ejemplo:

```text
Workspace
│
├── Web Application
├── Admin Application
├── UI Library
└── Validation Library
```

Cada unidad puede tener su propio `package.json`.

El Workspace permite administrarlas de forma conjunta.

---

# 🧩 Un Workspace no reemplaza los Packages

Este punto es importante.

Un Workspace no convierte automáticamente todos los Packages en un único Package.

Seguimos teniendo unidades independientes:

```text
@company/web
@company/admin
@company/ui
@company/validation
```

Cada una puede tener:

```text
Identity
Dependencies
Scripts
Configuration
```

Pero ahora forman parte de un entorno compartido.

Conceptualmente:

```text
Workspace
│
├── Package A
│   └── package.json
│
├── Package B
│   └── package.json
│
└── Package C
    └── package.json
```

---

# 🔗 Internal Dependencies

Uno de los beneficios más importantes de un Workspace es facilitar las relaciones entre Packages internos.

Imagina:

```text
Web Application
        ↓
uses
        ↓
UI Library
```

Ambos pertenecen al mismo Workspace.

Podemos representar la relación:

```text
Workspace
│
├── Web Application
│       │
│       └──────→ UI Library
│
└── UI Library
```

La UI Library se convierte en una dependencia interna de la Web Application.

---

# 🧠 ¿Qué significa Internal Dependency?

Una **Internal Dependency** es una dependencia entre unidades que pertenecen al entorno que estamos administrando.

Por ejemplo:

```text
@company/web
    ↓
depends on
    ↓
@company/ui
```

Ambos Packages pueden estar dentro del mismo Workspace.

Esto permite desarrollar aplicaciones y funcionalidades compartidas de manera coordinada.

---

# 🌍 External vs Internal Dependencies

Dentro de un Workspace podemos encontrar dos tipos de relaciones.

## External Dependencies

Son Packages obtenidos de fuentes externas al Workspace.

Por ejemplo:

```text
@company/web
    ↓
depends on
    ↓
react
```

## Internal Dependencies

Son Packages que forman parte del propio Workspace.

Por ejemplo:

```text
@company/web
    ↓
depends on
    ↓
@company/ui
```

Conceptualmente:

```text
Workspace
│
├── Web Application
│       │
│       ├────→ React
│       │       External Dependency
│       │
│       └────→ UI Library
│               Internal Dependency
│
└── UI Library
```

---

# 🕸️ Workspace Dependency Graph

Cuando tenemos múltiples Packages aparecen relaciones entre ellos.

Por ejemplo:

```text
Workspace
│
├── Web Application
├── Admin Application
├── UI Library
├── Validation Library
└── Utils Library
```

Podríamos tener:

```text
Web Application ────────→ UI Library
       │                      │
       │                      ↓
       └────────────────→ Utils Library

Admin Application ──────→ UI Library
       │
       └────────────────→ Validation Library
```

Estas relaciones forman un **Dependency Graph**.

Este concepto será muy importante cuando estudiemos Monorepos y Nx.

---

# ⚙️ ¿Qué puede administrar un Workspace?

Dependiendo del Package Manager y de sus capacidades, un Workspace puede facilitar operaciones como:

```text
Dependency Installation
Internal Package Linking
Script Execution
Package Filtering
Shared Dependency Resolution
```

Por ejemplo, podríamos necesitar:

```text
Install dependencies
```

para todas las unidades.

O ejecutar:

```text
Build
```

solamente en determinados Packages.

La implementación concreta dependerá de la herramienta.

---

# 📥 Package Manager vs Workspace

Estos conceptos tampoco son equivalentes.

Un **Package Manager** administra Packages y dependencias.

Por ejemplo:

```text
npm
pnpm
Yarn
```

Un **Workspace** representa un entorno de administración conjunta de Packages.

Conceptualmente:

```text
Package Manager
        ↓
provides workspace capabilities
        ↓
Workspace
        ↓
contains
        ↓
Multiple Packages
```

Por eso podemos hablar de:

```text
npm Workspaces
pnpm Workspaces
Yarn Workspaces
```

Son implementaciones de capacidades de Workspace dentro de diferentes Package Managers.

---

# 📦 ¿Por qué utilizaremos pnpm Workspaces?

En Developer Tooling Mastery 2026 utilizaremos **pnpm** como Package Manager principal.

Más adelante aprovecharemos sus capacidades de Workspace para administrar múltiples Projects y Packages.

Conceptualmente:

```text
pnpm
    ↓
Package Management
    +
Workspace Management
```

Esto nos permitirá trabajar con:

```text
Applications
Libraries
Shared Configurations
Internal Dependencies
```

dentro de un entorno común.

No necesitamos introducir todavía Nx para tener un Workspace funcional.

---

# 🧩 Workspace vs Monorepo

Esta es una de las diferencias más importantes del documento.

Aunque suelen utilizarse juntos:

```text
Workspace
    ≠
Monorepo
```

Un **Workspace**, en el contexto que estamos estudiando, es un mecanismo para administrar múltiples Packages relacionados.

Un **Monorepo** es una estrategia de organización de código en la que múltiples proyectos se mantienen dentro de un mismo Repository.

Por tanto, responden a preguntas diferentes.

```text
Workspace
    ↓
How do we manage related packages?
```

Mientras que:

```text
Monorepo
    ↓
How do we organize multiple projects in repositories?
```

---

# 🗃️ Monorepo sin Package Manager Workspace

Es posible tener:

```text
repository/
├── project-a/
├── project-b/
└── project-c/
```

Los tres proyectos viven dentro de un mismo Repository.

Eso puede constituir un Monorepo.

Pero no significa que necesariamente utilicen:

```text
pnpm Workspaces
```

Un Monorepo puede organizarse utilizando diferentes tecnologías y estrategias.

---

# 🏗️ Workspace dentro de un Monorepo

También podemos tener:

```text
repository/
│
├── projects/
│   ├── web/
│   └── admin/
│
└── packages/
    ├── ui/
    └── validation/
```

Y administrar esos Packages mediante pnpm Workspaces.

Conceptualmente:

```text
Monorepo
    ↓
contains multiple projects
    ↓
pnpm Workspace
    ↓
manages related packages
```

Aquí ambos conceptos trabajan juntos.

---

# 🔑 Diferencia esencial

Podemos resumir:

| Concept | Responsabilidad |
|---|---|
| Package | Unidad identificable y administrable de software |
| Workspace | Administración conjunta de Packages relacionados |
| Repository | Almacenamiento y versionado del proyecto |
| Monorepo | Organización de múltiples proyectos en un Repository |
| Package Manager | Herramienta para administrar Packages y dependencias |

No debemos confundir la organización del código con las herramientas utilizadas para administrarlo.

---

# 🧱 Workspace Root

En un Workspace suele existir un directorio raíz desde el cual se organiza la configuración compartida.

Conceptualmente:

```text
workspace-root/
│
├── projects/
├── packages/
└── workspace-configuration
```

A esta ubicación podemos llamarla:

```text
Workspace Root
```

Dependiendo de la herramienta, allí pueden existir archivos que definen qué Packages pertenecen al Workspace.

---

# 📄 `pnpm-workspace.yaml`

Cuando utilicemos pnpm Workspaces encontraremos un archivo llamado:

```text
pnpm-workspace.yaml
```

Este archivo permite declarar, entre otras configuraciones, qué directorios contienen Packages del Workspace.

Por ejemplo, conceptualmente:

```text
projects/*
packages/*
```

Todavía no crearemos el archivo.

Su configuración real pertenece a:

```text
17-monorepo-tooling/
```

Por ahora recuerda:

```text
pnpm-workspace.yaml
    ↓
helps define
    ↓
pnpm Workspace
```

---

# 🔗 Workspace Protocol

Más adelante también encontraremos una notación como:

```text
workspace:*
```

En pnpm, el Workspace Protocol permite declarar dependencias que deben resolverse utilizando Packages locales del Workspace.

Por ejemplo, una Application podría declarar una dependencia interna:

```json
{
  "dependencies": {
    "@company/ui": "workspace:*"
  }
}
```

Esto expresa que `@company/ui` debe resolverse desde el Workspace.

No necesitamos dominar todavía esta configuración.

La estudiaremos cuando implementemos el Monorepo.

---

# 🔄 Desarrollo coordinado

Imagina que necesitamos modificar:

```text
@company/ui
```

y comprobar que sigue funcionando dentro de:

```text
@company/web
```

Cuando ambas unidades pertenecen al mismo Workspace, podemos desarrollar y validar sus cambios de manera coordinada.

Conceptualmente:

```text
Change UI Library
        ↓
Update Consumer
        ↓
Run Validation
        ↓
Review Integration
```

Esto puede facilitar el desarrollo de software compuesto por múltiples unidades relacionadas.

---

# 🏢 Ejemplo profesional

Imagina una empresa que desarrolla:

```text
Customer Portal
Admin Dashboard
Internal API
```

También mantiene:

```text
UI Components
Validation Utilities
Shared Types
```

Podríamos organizarlo así:

```text
company-workspace/
│
├── projects/
│   ├── customer-portal/
│   ├── admin-dashboard/
│   └── internal-api/
│
└── packages/
    ├── ui/
    ├── validation/
    └── shared-types/
```

Conceptualmente:

```text
Customer Portal ─────→ UI Package
        │
        └────────────→ Validation Package

Admin Dashboard ─────→ UI Package
        │
        └────────────→ Shared Types

Internal API ────────→ Shared Types
        │
        └────────────→ Validation Package
```

El Workspace nos ayudará a administrar estas unidades relacionadas.

---

# ⚠️ Un Workspace no elimina la complejidad

Trabajar con múltiples Packages también introduce nuevas responsabilidades.

Por ejemplo:

```text
Dependency Relationships
Package Boundaries
Shared Configuration
Task Coordination
Build Order
Version Compatibility
```

Un Workspace facilita ciertas operaciones, pero no resuelve automáticamente todos estos problemas.

Más adelante veremos herramientas especializadas que pueden complementar al Package Manager.

---

# 🧰 ¿Dónde aparece Nx?

Aquí debemos distinguir dos responsabilidades.

```text
pnpm Workspaces
    ↓
Package and Workspace Management
```

Mientras que:

```text
Nx
    ↓
Project and Task Orchestration
```

Nx puede aportar capacidades como:

```text
Project Graph
Task Graph
Caching
Affected Projects
Task Execution
```

Pero no reemplaza la responsabilidad principal de pnpm como Package Manager.

---

# 🔄 pnpm y Nx pueden trabajar juntos

En nuestro futuro Monorepo utilizaremos ambos de manera complementaria.

Conceptualmente:

```text
Professional Monorepo
│
├── pnpm
│   ├── Dependency Management
│   └── Workspace Management
│
└── Nx
    ├── Project Graph
    ├── Task Graph
    ├── Task Orchestration
    └── Caching
```

Primero aprenderemos a construir un Workspace funcional con pnpm.

Después incorporaremos Nx para estudiar los problemas adicionales que resuelve.

---

# 🧩 Nuestro futuro Workspace

El propio Developer Tooling Mastery 2026 evolucionará hacia una estructura parecida a:

```text
developer-tooling-mastery-2026/
│
├── docs/
├── labs/
├── projects/
│   ├── react-vite-app/
│   ├── react-rsbuild-app/
│   └── node-typescript-app/
│
├── packages/
│   ├── eslint-config/
│   ├── typescript-config/
│   └── shared-library/
│
├── templates/
├── tools/
├── package.json
└── pnpm-workspace.yaml
```

Esta es una representación de nuestro objetivo futuro, no de la estructura que debemos crear ahora.

Los Projects y Packages aparecerán progresivamente durante el aprendizaje.

---

# 📈 Evolución del repositorio

Nuestro recorrido será:

```text
Documentation Repository
        ↓
Single Project
        ↓
Multiple Projects
        ↓
Shared Packages
        ↓
pnpm Workspace
        ↓
Monorepo Tooling
        ↓
Nx
        ↓
Professional Workspace
```

No comenzaremos creando toda esta estructura desde el primer día.

La construiremos cuando comprendamos sus responsabilidades.

---

# 💼 Modelo profesional

Cuando encuentres un Workspace en un proyecto real, intenta responder:

```text
Which packages belong to the workspace?

Where is the workspace root?

How are packages discovered?

Which packages depend on each other?

How are internal dependencies declared?

How are dependencies installed?

How are scripts executed?

What does the package manager manage?

Is there additional monorepo tooling?
```

Estas preguntas ayudan a comprender cómo funciona el entorno.

---

# ⚠️ Errores comunes

## 1. Pensar que Workspace y Monorepo son sinónimos

No son exactamente lo mismo.

Uno describe capacidades de administración conjunta de Packages; el otro describe una estrategia de organización de repositorios.

## 2. Pensar que un Workspace es un único Package

Un Workspace puede contener múltiples Packages, cada uno con su propia identidad y dependencias.

## 3. Pensar que Nx es obligatorio

Podemos construir un Workspace funcional utilizando pnpm sin Nx.

## 4. Pensar que todas las dependencias son externas

Dentro de un Workspace también pueden existir dependencias entre Packages locales.

## 5. Pensar que un Workspace elimina todos los problemas

La coordinación de tareas, los límites entre Packages y las dependencias siguen necesitando decisiones de diseño.

## 6. Crear un Workspace sin necesitarlo

Un proyecto pequeño con una sola unidad puede funcionar perfectamente sin una estructura de múltiples Packages.

---

# 🧠 Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es un Workspace?
2. ¿Qué diferencia existe entre Package y Workspace?
3. ¿Qué significa administrar múltiples Packages conjuntamente?
4. ¿Qué es una Internal Dependency?
5. ¿Qué diferencia existe entre Internal y External Dependencies?
6. ¿Qué responsabilidad tiene un Package Manager?
7. ¿Workspace y Monorepo significan exactamente lo mismo?
8. ¿Puede existir un Monorepo sin pnpm Workspaces?
9. ¿Qué es el Workspace Root?
10. ¿Para qué sirve conceptualmente `pnpm-workspace.yaml`?
11. ¿Qué representa `workspace:*`?
12. ¿Por qué no necesitamos Nx para comenzar con pnpm Workspaces?
13. ¿Qué responsabilidades adicionales puede resolver Nx?

Si puedes explicar estas respuestas con tus propias palabras, ya tienes una base importante para comprender la organización de repositorios.

---

# 💡 Idea clave

Podemos resumir el modelo así:

```text
Package
    ↓
Individual software unit
```

```text
Workspace
    ↓
Manages related packages
```

```text
Monorepo
    ↓
Organizes multiple projects in one repository
```

Y en nuestro futuro proyecto:

```text
Monorepo
    +
pnpm Workspaces
    +
Nx
    ↓
Professional Workspace
```

Cada pieza tiene una responsabilidad diferente.

---

## 🚀 Siguiente paso

Ya sabemos qué es un Package y cómo podemos administrar múltiples Packages mediante un Workspace.

Ahora necesitamos comprender el contenedor donde almacenamos, versionamos y organizamos nuestro trabajo.

👉 [What Is a Repository?](./08-what-is-a-repository.md)