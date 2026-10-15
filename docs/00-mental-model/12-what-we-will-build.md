# What We Will Build

Hasta ahora hemos construido los fundamentos conceptuales de Developer Tooling.

Comprendimos qué es un Software Project, cómo se relacionan Applications, Libraries y Packages, qué representa un Workspace, cómo funcionan los Repositories y por qué existen herramientas para automatizar y estandarizar el desarrollo.

Pero aprender conceptos no es suficiente.

**Necesitamos aplicar ese conocimiento construyendo software y entornos de desarrollo reales.**

En este documento definiremos qué construiremos durante Developer Tooling Mastery 2026, cómo organizaremos nuestros ejercicios y cómo evolucionará el Repository.

Nuestro objetivo es que cada herramienta estudiada tenga una aplicación práctica y forme parte de un sistema cada vez más completo.

---

## 🎯 Objetivo

Al finalizar este documento deberías comprender:

- Qué construiremos durante el Mastery.
- Qué función cumplen `docs/`, `labs/`, `projects/`, `packages/`, `templates/` y `tools/`.
- Cómo evolucionaremos desde un Repository documental hasta un Monorepo profesional.
- Qué diferencia existe entre un Lab y un Project.
- Cómo convertiremos configuraciones validadas en recursos reutilizables.
- Qué proyectos utilizaremos para integrar las herramientas estudiadas.
- Cuándo incorporaremos pnpm Workspaces y Nx.
- Qué resultados concretos esperamos obtener.
- Cómo sabremos si realmente estamos aprendiendo.

---

# 🧠 Nuestra filosofía: aprender construyendo

Este Mastery seguirá una metodología progresiva:

```text
Understand
    ↓
Experiment
    ↓
Implement
    ↓
Integrate
    ↓
Standardize
    ↓
Reuse
```

No instalaremos herramientas únicamente para conocer sus comandos.

Primero entenderemos el problema que resuelven.

Después realizaremos experimentos controlados.

Finalmente integraremos lo aprendido en proyectos reales.

Por ejemplo:

```text
Problem
Inconsistent formatting
        ↓
Concept
Code Formatting
        ↓
Tool
Prettier
        ↓
Lab
Compare unformatted and formatted code
        ↓
Project
Apply formatting to an application
        ↓
Standardization
Create consistent rules
        ↓
Reuse
Share validated configuration
```

Este proceso se repetirá a lo largo del Mastery.

---

# 🏗️ ¿Qué construiremos al finalizar?

Nuestro resultado principal será un Repository educativo y práctico que evolucionará hacia un **Professional Development Workspace**.

Conceptualmente:

```text
Developer Tooling Mastery
│
├── Documentation
├── Practical Labs
├── Functional Projects
├── Shared Packages
├── Reusable Templates
├── Automation Tools
└── Professional Monorepo
```

No serán elementos independientes sin relación.

Cada uno cumplirá una responsabilidad dentro de nuestro aprendizaje.

---

# 📚 1. Documentation — `docs/`

La carpeta `docs/` contendrá las explicaciones conceptuales y técnicas del Mastery.

Su objetivo será responder preguntas como:

```text
What is this concept?

Why does it exist?

What problem does it solve?

How does it work?

When should we use it?

What alternatives exist?
```

Por ejemplo:

```text
docs/
├── 00-mental-model/
├── 01-development-environment/
├── 02-terminal-and-shell/
├── 03-editor-and-workspace/
├── 04-runtime-management/
├── 05-package-managers/
└── ...
```

Los documentos estarán organizados por áreas de conocimiento.

## ¿Qué encontraremos?

Dependiendo del tema, podremos incluir:

- Explicaciones desde cero.
- Terminología profesional.
- Diagramas conceptuales.
- Ejemplos de configuración.
- Comparaciones entre herramientas.
- Buenas prácticas.
- Errores frecuentes.
- Referencias a Labs y Projects.

**Importante:** la documentación no reemplazará la práctica.

Nos permitirá comprender lo que posteriormente implementaremos.

---

# 🧪 2. Practical Labs — `labs/`

Los **Labs** serán experimentos pequeños y enfocados.

Su objetivo será aprender un concepto o herramienta sin introducir innecesariamente toda la complejidad de una aplicación profesional.

Por ejemplo, cuando estudiemos Package Managers, podríamos crear un Lab para comparar cómo se declaran e instalan dependencias.

```text
labs/
└── package-manager-experiment/
    ├── package.json
    └── README.md
```

Este ejemplo representa un posible Lab futuro, no una carpeta que debamos crear ahora.

## ¿Qué debe responder un Lab?

Un Lab debería ayudarnos a comprender:

```text
What are we testing?

Why are we testing it?

What should happen?

What actually happened?

What did we learn?
```

## Ejemplo: Formatting Lab

Podríamos crear código intencionalmente desordenado:

```js
const user={name:'Ana',age:25}
```

Después aplicar un Formatter y observar el resultado:

```js
const user = { name: "Ana", age: 25 };
```

El objetivo no será únicamente ejecutar un comando.

Queremos entender qué cambió, por qué cambió y qué responsabilidad cumple la herramienta.

---

# 🔬 Labs como experimentos controlados

Un buen Lab debe mantener el alcance limitado.

Por ejemplo:

```text
Lab
Understand ESLint Rules
```

No necesitamos agregar simultáneamente:

```text
React
Routing
Authentication
Database
Deployment
```

si ninguno de esos elementos es necesario para estudiar ESLint.

Esto nos permitirá identificar con claridad el comportamiento de cada herramienta.

**Principio:** un Lab debe reducir la complejidad para facilitar el aprendizaje.

---

# 💻 3. Functional Projects — `projects/`

Los **Projects** serán aplicaciones funcionales donde integraremos diferentes herramientas.

A diferencia de los Labs, aquí trabajaremos con varias responsabilidades al mismo tiempo.

Por ejemplo:

```text
Application
│
├── Source Code
├── Dependencies
├── TypeScript
├── Formatting
├── Linting
├── Build
└── Scripts
```

Un Project nos permitirá comprobar cómo se relacionan herramientas que inicialmente estudiamos por separado.

---

# 🚀 Nuestros proyectos principales

Durante el Mastery construiremos progresivamente proyectos de referencia.

La siguiente estructura representa nuestro objetivo, no una implementación inmediata:

```text
projects/
├── react-vite-app/
├── react-rsbuild-app/
└── node-typescript-app/
```

Estos proyectos nos permitirán estudiar diferentes escenarios de Developer Tooling.

---

## Project 1 — React + Vite

Construiremos una aplicación frontend utilizando React, TypeScript y Vite.

Su objetivo principal será integrar herramientas habituales del desarrollo frontend.

Por ejemplo:

```text
React Application
│
├── TypeScript
├── Package Management
├── Formatting
├── Linting
├── Environment Configuration
├── Build
└── CI
```

No necesitamos construir una aplicación de negocio compleja.

La funcionalidad debe ser suficiente para practicar el Tooling.

### ¿Qué aprenderemos?

- Cómo se organiza un proyecto frontend.
- Cómo se administran sus dependencias.
- Cómo funcionan sus Scripts.
- Cómo integrar Formatting y Linting.
- Cómo utilizar TypeScript Tooling.
- Cómo generar un Build.
- Cómo automatizar verificaciones.

Este será uno de nuestros principales proyectos de integración.

---

## Project 2 — React + Rsbuild

Construiremos otro proyecto frontend utilizando React, TypeScript y Rsbuild.

El propósito será comparar herramientas de construcción.

Conceptualmente:

```text
React Application
        ↓
Build Tool
        ↓
Development and Production Workflows
```

Queremos comprender qué responsabilidades cubre un Build Tool y qué diferencias existen entre alternativas.

### ¿Qué compararemos?

- Experiencia de desarrollo.
- Configuración inicial.
- Integración con React.
- Integración con TypeScript.
- Generación de artefactos.
- Opciones de configuración.
- Comportamiento de Build.

No asumiremos que una herramienta es universalmente superior.

Evaluaremos sus características según el contexto.

---

## Project 3 — Node.js + TypeScript

Construiremos una aplicación sencilla utilizando Node.js y TypeScript.

El objetivo será estudiar Developer Tooling fuera del contexto de un navegador.

Por ejemplo:

```text
Node.js Application
│
├── Runtime
├── TypeScript
├── Dependencies
├── Environment Variables
├── Scripts
├── Linting
├── Testing
└── Build / Execution
```

Esto nos ayudará a distinguir responsabilidades del Runtime y de las herramientas de desarrollo.

También podremos comparar necesidades de proyectos frontend y backend.

---

# 🧩 Projects no significa productos comerciales

Los Projects de este Mastery serán principalmente **proyectos de aprendizaje e integración técnica**.

No necesitamos construir desde el inicio:

```text
Complete E-commerce Platform
Enterprise Authentication System
Complex Microservices Architecture
```

Estos sistemas podrían distraernos del objetivo principal.

Nuestro foco es dominar Developer Tooling.

Por eso utilizaremos funcionalidades pequeñas, pero suficientemente reales para validar las herramientas.

---

# 📦 4. Shared Packages — `packages/`

Cuando tengamos varios Projects, aparecerán oportunidades para compartir código y configuraciones.

Por ejemplo:

```text
React Vite App
React Rsbuild App
Node TypeScript App
```

Podrían necesitar convenciones similares para:

```text
ESLint
TypeScript
```

En lugar de mantener configuraciones completamente duplicadas, podremos estudiar cómo extraerlas a Packages reutilizables.

---

# 🧱 Shared Configuration Packages

Podríamos crear:

```text
packages/
├── eslint-config/
└── typescript-config/
```

Conceptualmente:

```text
Shared ESLint Configuration
        ↓
Multiple Projects
```

Y:

```text
Shared TypeScript Configuration
        ↓
Multiple Projects
```

Esto nos permitirá aprender cómo se comparten estándares entre proyectos.

Sin embargo, no toda configuración debe centralizarse.

Primero necesitaremos comprender qué elementos son realmente comunes.

---

# 🔗 Shared Libraries

También podremos construir una pequeña Library compartida.

Por ejemplo:

```text
packages/
└── shared-library/
```

Esta Library podría proporcionar funcionalidades sencillas:

```ts
export function formatCurrency(
  value: number,
  currency: string
): string {
  return new Intl.NumberFormat("en-US", {
    style: "currency",
    currency,
  }).format(value);
}
```

Posteriormente podríamos consumirla desde una aplicación.

Conceptualmente:

```text
Application
    ↓
Internal Dependency
    ↓
Shared Library
```

Esto nos permitirá practicar relaciones entre Packages.

---

# ⚠️ Compartir no significa reutilizar todo

Un error frecuente es intentar convertir cualquier archivo en una Library compartida.

Por ejemplo, si dos aplicaciones tienen una función similar, no significa automáticamente que debamos extraerla.

Antes de compartir código debemos evaluar:

```text
Is the behavior genuinely shared?

Will consumers need the same contract?

Does sharing reduce duplication?

Does sharing introduce coupling?

Who maintains the shared package?
```

La reutilización debe resolver un problema real.

---

# 🧰 5. Reusable Templates — `templates/`

Los **Templates** serán puntos de partida reutilizables para crear nuevos proyectos.

Por ejemplo:

```text
templates/
└── typescript-project/
```

Un Template podría incluir:

```text
Project Structure
TypeScript Configuration
Linting Configuration
Formatting Configuration
Package Scripts
Documentation
```

Su objetivo será evitar repetir configuraciones que ya hemos comprendido y validado.

---

# 🧠 Configuración vs Template

Estos conceptos son diferentes.

Una configuración compartida define reglas o comportamientos reutilizables.

Un Template proporciona una estructura inicial para crear un proyecto.

Por ejemplo:

```text
Shared ESLint Package
        ↓
Reusable Configuration
```

Mientras que:

```text
Project Template
        ↓
Starting Point for New Projects
```

Un Template puede consumir Packages de configuración compartida.

Pero no son lo mismo.

---

# 🔄 ¿Cuándo crearemos Templates?

No comenzaremos creando Templates antes de experimentar.

Seguiremos este proceso:

```text
Understand Tool
      ↓
Configure in a Lab
      ↓
Validate in a Project
      ↓
Identify Reusable Decisions
      ↓
Extract Template
```

Esto evita copiar configuraciones sin comprenderlas.

---

# 🤖 6. Automation Tools — `tools/`

La carpeta `tools/` estará destinada a scripts y utilidades de automatización que desarrollaremos cuando exista una necesidad concreta.

Por ejemplo:

```text
tools/
└── scripts/
```

Podríamos crear automatizaciones para:

```text
Validate Project Structure
Check Required Files
Run Repeated Tasks
Generate Supporting Artifacts
```

No todas las automatizaciones necesitan convertirse en scripts propios.

En ocasiones será suficiente utilizar funcionalidades existentes de los Package Managers, Build Tools o plataformas de CI.

---

# 🔑 Scripts vs Tools

Un Script puede ser un comando definido en:

```text
package.json
```

Por ejemplo:

```json
{
  "scripts": {
    "lint": "eslint .",
    "typecheck": "tsc --noEmit"
  }
}
```

Estos Scripts permiten ejecutar herramientas de manera consistente.

Pero no necesitamos crear un archivo adicional en `tools/` para cada comando.

La carpeta `tools/` se utilizará cuando realmente necesitemos lógica o utilidades propias.

---

# 🗃️ 7. Repository Documentation

Además de `docs/`, nuestro Repository cuenta con documentación general.

Por ejemplo:

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

Cada archivo tiene una responsabilidad diferente.

| Archivo | Propósito |
|---|---|
| README.md | Presentar el Repository |
| ROADMAP.md | Mostrar el recorrido de aprendizaje |
| STUDY-PLAN.md | Organizar el estudio |
| CONTRIBUTING.md | Definir convenciones de contribución |
| CHANGELOG.md | Registrar cambios relevantes |
| LICENSE | Establecer condiciones de uso |
| GLOSSARY.md | Mantener definiciones importantes |
| CHEATSHEET.md | Consultar comandos y referencias rápidas |
| FAQ.md | Resolver preguntas frecuentes |

Estos documentos evolucionarán conforme avancemos.

No necesitamos actualizarlos todos después de cada Lab.

Los mantendremos alineados con el estado real del Repository.

---

# 🧭 8. Nuestra evolución por etapas

No construiremos todo el Workspace desde el primer día.

Seguiremos una evolución progresiva.

---

## Stage 1 — Mental Model

Primero comprenderemos:

```text
Project
Application
Library
Package
Workspace
Repository
Monorepo
Developer Tooling
```

Esta es nuestra etapa actual.

El resultado será una base conceptual sólida.

---

## Stage 2 — Development Environment

Prepararemos y comprenderemos nuestro entorno de trabajo.

Estudiaremos:

```text
Operating System
Terminal
Shell
Editor
Runtime
Package Manager
```

Aprenderemos a distinguir las responsabilidades de cada componente.

No se trata únicamente de instalar herramientas.

Queremos entender cómo se relacionan.

---

## Stage 3 — First Tooling Experiments

Comenzaremos a crear Labs enfocados.

Por ejemplo:

```text
Runtime Experiments
Package Manager Experiments
Project Metadata Experiments
Formatting Experiments
Linting Experiments
```

Cada Lab tendrá un objetivo específico.

---

## Stage 4 — First Integrated Project

Integraremos varias herramientas en una aplicación.

Conceptualmente:

```text
Application
│
├── Runtime
├── Package Manager
├── TypeScript
├── Formatter
├── Linter
└── Build Tool
```

Aquí empezaremos a observar cómo las herramientas se complementan.

---

## Stage 5 — Quality and Automation

Agregaremos progresivamente:

```text
Git Hooks
Commit Conventions
Automated Checks
CI
Dependency Maintenance
```

El objetivo será mejorar la consistencia del proceso de desarrollo.

---

## Stage 6 — Multiple Projects

Incorporaremos proyectos adicionales.

Por ejemplo:

```text
projects/
├── react-vite-app/
├── react-rsbuild-app/
└── node-typescript-app/
```

Aparecerán necesidades nuevas:

```text
Shared Dependencies
Repeated Configuration
Coordinated Scripts
```

Estas necesidades prepararán el camino hacia un Workspace.

---

## Stage 7 — Shared Packages

Identificaremos configuraciones y funcionalidades que conviene compartir.

Por ejemplo:

```text
packages/
├── eslint-config/
├── typescript-config/
└── shared-library/
```

Aprenderemos a definir y consumir Packages internos.

---

## Stage 8 — pnpm Workspaces

Cuando tengamos múltiples Packages relacionados, estudiaremos cómo administrarlos conjuntamente.

Incorporaremos conceptos como:

```text
Workspace Root
Workspace Packages
Internal Dependencies
workspace: Protocol
Filters
Catalogs
```

Aquí comenzaremos a construir formalmente nuestro Workspace.

---

## Stage 9 — Nx

Después estudiaremos necesidades adicionales:

```text
Project Graph
Task Graph
Task Dependencies
Affected Projects
Caching
Task Orchestration
```

Incorporaremos Nx para comprender cómo coordinar tareas dentro de un Monorepo.

No utilizaremos Nx simplemente porque sea una herramienta popular.

Lo incorporaremos después de comprender qué problemas resuelve.

---

## Stage 10 — Professional Workspace

Finalmente integraremos lo aprendido.

Nuestro objetivo será disponer de:

```text
Professional Workspace
│
├── Multiple Applications
├── Shared Packages
├── Consistent Tooling
├── Automated Quality Checks
├── CI Workflows
├── Task Orchestration
├── Caching
└── Documentation
```

Este será nuestro resultado práctico principal.

---

# 🏗️ Vista conceptual del Repository final

La siguiente estructura representa un objetivo de referencia.

No es una lista de archivos que debamos crear inmediatamente.

```text
developer-tooling-mastery-2026/
│
├── .github/
│   └── workflows/
│
├── assets/
├── resources/
│
├── docs/
│   ├── 00-mental-model/
│   ├── 01-development-environment/
│   ├── 02-terminal-and-shell/
│   ├── 03-editor-and-workspace/
│   ├── 04-runtime-management/
│   ├── 05-package-managers/
│   ├── 06-project-metadata/
│   ├── 07-project-files/
│   ├── 08-formatting/
│   ├── 09-linting/
│   ├── 10-typescript-tooling/
│   ├── 11-build-tools/
│   ├── 12-environment-configuration/
│   ├── 13-git-hooks-and-commit-quality/
│   ├── 14-ci-and-automation/
│   ├── 15-dependency-management/
│   ├── 16-repository-architectures/
│   ├── 17-monorepo-tooling/
│   ├── 18-nx-basics/
│   ├── 19-project-standards/
│   └── 20-final-professional-workspace/
│
├── labs/
│
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
│
├── package.json
├── pnpm-workspace.yaml
├── nx.json
│
├── README.md
├── ROADMAP.md
├── STUDY-PLAN.md
├── CONTRIBUTING.md
├── CHANGELOG.md
├── LICENSE
├── GLOSSARY.md
├── CHEATSHEET.md
└── FAQ.md
```

La estructura evolucionará conforme aparezcan necesidades reales.

**No adelantaremos configuraciones ni crearemos carpetas vacías solamente para completar este árbol.**

---

# 🔄 Relación entre Docs, Labs y Projects

Estos elementos se complementan.

```text
Documentation
      ↓
Understand Concepts
      ↓
Lab
      ↓
Experiment
      ↓
Project
      ↓
Integrate
      ↓
Reusable Package / Template
```

Pero no necesitamos mantener una relación obligatoria de un documento por cada Lab.

Algunos conceptos requerirán varios experimentos.

Otros podrán comprenderse mediante explicaciones y ejemplos.

---

# 🧪 Ejemplo de aprendizaje completo: ESLint

Imagina que llegamos al módulo de Linting.

Seguiremos una progresión parecida a esta:

## Step 1 — Understand

Aprenderemos:

```text
What is Linting?

Why does it exist?

What problems does it detect?
```

## Step 2 — Experiment

Crearemos un Lab con código que contenga determinados problemas.

## Step 3 — Configure

Aprenderemos a definir reglas y comprender sus efectos.

## Step 4 — Integrate

Aplicaremos ESLint a un Project.

## Step 5 — Automate

Integraremos la verificación en Scripts y, posteriormente, CI.

## Step 6 — Standardize

Evaluaremos qué reglas deberían compartirse entre Projects.

## Step 7 — Reuse

Cuando tenga sentido, extraeremos una configuración compartida.

Esta será nuestra metodología de trabajo.

---

# 🎯 ¿Cómo sabremos que hemos aprendido?

No mediremos el progreso únicamente por la cantidad de documentos completados.

También evaluaremos nuestra capacidad para trabajar de manera independiente.

Por ejemplo:

```text
Can I explain the problem?

Can I explain the tool's responsibility?

Can I configure it from scratch?

Can I identify common errors?

Can I integrate it with another tool?

Can I justify my decisions?

Can I reproduce the result?
```

Si podemos responder estas preguntas y demostrarlo mediante práctica, estaremos desarrollando conocimiento aplicable.

---

# 🏆 Resultados esperados

Al finalizar Developer Tooling Mastery 2026 deberíamos poder:

1. Preparar un entorno de desarrollo moderno.
2. Administrar versiones de Node.js y herramientas relacionadas.
3. Comprender y utilizar Package Managers.
4. Interpretar y mantener la metadata de proyectos.
5. Configurar Formatting, Linting y TypeScript Tooling.
6. Comprender e integrar Build Tools.
7. Administrar configuraciones de entorno.
8. Automatizar verificaciones mediante Git Hooks y CI.
9. Mantener dependencias de manera responsable.
10. Comparar estrategias de organización de repositorios.
11. Crear y administrar un Workspace con pnpm.
12. Comprender e integrar capacidades fundamentales de Nx.
13. Construir configuraciones y Templates reutilizables.
14. Mantener un entorno de desarrollo documentado y reproducible.

Estos resultados representan las capacidades que queremos desarrollar, no una garantía automática por completar los documentos.

---

# ⚠️ Qué no construiremos inicialmente

Para mantener el enfoque, evitaremos introducir prematuramente:

```text
Complex Business Applications
Microservices Infrastructure
Kubernetes Clusters
Advanced Cloud Architecture
Enterprise Authentication Platforms
Large Production Databases
```

Estas áreas pueden ser importantes en otros recorridos de aprendizaje.

Pero nuestro objetivo actual es dominar Developer Tooling.

Cuando necesitemos una funcionalidad de aplicación para demostrar una herramienta, utilizaremos el ejemplo más pequeño que permita comprenderla correctamente.

---

# 💼 Nuestro criterio profesional

Antes de crear un nuevo Lab, Project, Package, Template o Script, nos preguntaremos:

```text
What problem are we solving?

Why does this artifact need to exist?

What will we learn from it?

Does it duplicate existing work?

Can we maintain it?

How does it contribute to the Mastery?
```

No queremos un Repository grande únicamente por su cantidad de archivos.

Queremos un Repository donde cada elemento tenga una responsabilidad comprensible.

---

# ⚠️ Errores comunes

## 1. Crear toda la estructura desde el primer día

La estructura debe evolucionar junto con nuestro aprendizaje.

## 2. Confundir Labs con Projects

Un Lab estudia un problema específico.

Un Project integra múltiples responsabilidades.

## 3. Crear Packages compartidos demasiado pronto

Primero debemos identificar una necesidad real de reutilización.

## 4. Copiar configuraciones sin comprenderlas

Una configuración copiada puede funcionar, pero no garantiza aprendizaje.

## 5. Introducir Nx antes de comprender Workspaces

Primero estudiaremos administración de Packages y después orquestación de tareas.

## 6. Construir aplicaciones demasiado complejas

La complejidad funcional no debe ocultar el objetivo del Mastery.

## 7. Medir el progreso solamente por documentos terminados

También debemos poder experimentar, configurar, integrar y explicar.

---

# 🧠 Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué construiremos durante Developer Tooling Mastery?
2. ¿Qué responsabilidad tiene `docs/`?
3. ¿Qué diferencia existe entre un Lab y un Project?
4. ¿Por qué utilizaremos aplicaciones pequeñas pero funcionales?
5. ¿Qué aprenderemos con React + Vite?
6. ¿Por qué estudiaremos también React + Rsbuild?
7. ¿Qué aporta un Project con Node.js y TypeScript?
8. ¿Cuándo tiene sentido crear un Shared Package?
9. ¿Qué diferencia existe entre un Shared Configuration Package y un Template?
10. ¿Para qué utilizaremos `tools/`?
11. ¿Por qué no crearemos todas las configuraciones desde el inicio?
12. ¿Cuándo incorporaremos pnpm Workspaces?
13. ¿Qué problemas estudiaremos con Nx?
14. ¿Cómo evaluaremos si realmente estamos aprendiendo?
15. ¿Cuál es el resultado final esperado del Mastery?

---

# 💡 Idea clave

Nuestro objetivo no es acumular herramientas ni documentación.

Queremos construir progresivamente un entorno profesional que podamos comprender, mantener y reutilizar.

```text
Concepts
    ↓
Labs
    ↓
Projects
    ↓
Shared Packages
    ↓
Templates and Automation
    ↓
pnpm Workspaces
    ↓
Nx
    ↓
Professional Development Workspace
```

Cada etapa tendrá una razón de existir.

**Primero comprendemos. Después experimentamos. Finalmente integramos y estandarizamos.**

---

## 🚀 Siguiente paso

Ya sabemos qué construiremos durante Developer Tooling Mastery 2026 y cómo evolucionará nuestro Repository.

Ahora necesitamos consolidar la mentalidad que guiará todas nuestras decisiones técnicas.

👉 [Tooling Mindset](./13-tooling-mindset.md)