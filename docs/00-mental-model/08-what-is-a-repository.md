# What Is a Repository?

En los documentos anteriores construimos varios conceptos fundamentales:

```text
Application
Library
Package
Workspace
```

Sabemos que una Application proporciona funcionalidades, que una Library puede ser consumida por otro software, que un Package representa una unidad administrable y que un Workspace permite gestionar múltiples Packages relacionados.

Pero todavía necesitamos comprender una pieza esencial:

**Repository**.

¿Dónde almacenamos nuestro trabajo? ¿Cómo conservamos su historial? ¿Cómo colaboramos con otros desarrolladores? ¿Y por qué un Repository puede contener uno o varios Projects?

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué es un Repository.
- Qué problema resuelve.
- Qué relación existe entre Repository y Git.
- Qué diferencia existe entre Local Repository y Remote Repository.
- Qué papel cumplen plataformas como GitHub.
- Qué diferencia existe entre Repository y Project.
- Cómo pueden convivir Applications, Libraries y Packages dentro de un Repository.
- Por qué Repository y Workspace no son sinónimos.
- Cómo se relaciona un Repository con las estrategias Monorepo y Polyrepo.

No estudiaremos Git desde cero ni sus comandos en profundidad. Nuestro objetivo es construir el modelo mental necesario para Developer Tooling.

---

# 🧠 Empecemos con el problema

Imagina que desarrollamos una aplicación.

```text
customer-portal/
├── src/
├── package.json
└── README.md
```

Trabajamos durante varias semanas.

Modificamos archivos, corregimos errores y agregamos funcionalidades.

Pero aparecen preguntas importantes:

- ¿Cómo sabemos qué cambió?
- ¿Cómo recuperamos una versión anterior?
- ¿Cómo trabajamos con otros desarrolladores?
- ¿Cómo revisamos cambios antes de integrarlos?
- ¿Cómo compartimos el proyecto?
- ¿Cómo mantenemos un historial del desarrollo?

Necesitamos algo más que una carpeta con archivos.

Necesitamos **Version Control**.

---

# 🕒 ¿Qué es Version Control?

**Version Control** es una práctica apoyada por herramientas que permiten registrar y administrar cambios realizados sobre archivos a lo largo del tiempo.

Conceptualmente:

```text
Project Files
     ↓
Changes
     ↓
Version Control System
     ↓
Recorded History
```

Esto permite comprender cómo evolucionó el trabajo.

Por ejemplo:

```text
Initial Project
      ↓
Add Authentication
      ↓
Add Dashboard
      ↓
Fix Login Bug
      ↓
Improve Validation
```

Cada cambio relevante puede registrarse en el historial.

---

# 🔧 ¿Qué es Git?

**Git** es un Distributed Version Control System.

Es una herramienta que permite administrar versiones del contenido de un Repository.

Entre sus capacidades encontramos:

```text
Track Changes
Create Commits
Create Branches
Merge Changes
Inspect History
Collaborate
```

Git es la tecnología de control de versiones que utilizaremos en nuestro repositorio.

Pero debemos distinguir:

```text
Git
    ≠
GitHub
```

Git es una herramienta de control de versiones.

GitHub es una plataforma que puede alojar repositorios Git y proporcionar funcionalidades adicionales de colaboración y automatización.

---

# 🗃️ ¿Qué es un Repository?

En el contexto de este Mastery, un **Repository** es una unidad de almacenamiento y control de versiones que contiene archivos y su historial administrado mediante Git.

Conceptualmente:

```text
Repository
│
├── Project Files
├── Documentation
├── Configuration
├── Source Code
└── Git History
```

Un Repository permite mantener una historia compartida de cómo evoluciona el trabajo.

No necesita contener exclusivamente código fuente.

También puede incluir documentación, scripts, configuraciones y otros recursos.

---

# 📁 Folder vs Repository

Una carpeta común puede contener archivos:

```text
my-project/
├── index.js
└── README.md
```

Pero eso no significa automáticamente que sea un Git Repository.

Cuando inicializamos Git:

```bash
git init
```

Git crea normalmente un directorio especial:

```text
.git/
```

Conceptualmente:

```text
my-project/
├── .git/
├── index.js
└── README.md
```

El directorio `.git/` contiene información interna necesaria para administrar el Repository, incluyendo su historial y referencias.

Por eso:

```text
Folder
    ≠
Git Repository
```

Una carpeta puede existir sin Git.

Un Git Repository utiliza estructuras y metadata específicas para administrar versiones.

---

# 🧠 ¿Qué guarda Git?

Git no se limita a guardar una lista de nombres de archivos modificados.

Su modelo utiliza objetos y referencias para representar contenido, árboles de archivos e historial.

Para nuestro modelo mental inicial podemos imaginar:

```text
Repository
    ↓
Commits
    ↓
Recorded Project States
```

Un Commit registra una versión del contenido seleccionado y la relaciona con el historial del Repository.

Esto permite reconstruir estados anteriores del proyecto.

No significa que Git guarde siempre una copia física completa e independiente de todos los archivos por cada Commit.

Su almacenamiento interno utiliza mecanismos más eficientes.

---

# 📸 ¿Qué es un Commit?

Un **Commit** representa un punto registrado en el historial del Repository.

Por ejemplo:

```text
Commit A
Initial project
    ↓
Commit B
Add login page
    ↓
Commit C
Add form validation
    ↓
Commit D
Fix authentication bug
```

Cada Commit puede contener información como:

```text
Author
Date
Message
Recorded Tree
Parent Commit(s)
```

El Commit Message ayuda a comunicar qué cambio se realizó.

En nuestro Mastery utilizaremos progresivamente buenas prácticas para escribir mensajes comprensibles.

Más adelante estudiaremos automatización relacionada con los Commits.

---

# 🌿 ¿Qué es una Branch?

Una **Branch** permite mantener una línea de desarrollo dentro del historial de Git.

Por ejemplo:

```text
main
  │
  A ─── B ─── C
         \
          D ─── E
              feature/login
```

Podemos desarrollar una funcionalidad en una Branch sin modificar inmediatamente la línea principal.

Después podremos integrar los cambios mediante los mecanismos correspondientes.

Las Branches permiten organizar el trabajo, pero no equivalen a Projects ni Packages independientes.

---

# 💻 Local Repository

Un **Local Repository** es el Repository Git disponible en nuestra computadora.

Por ejemplo:

```text
Developer Machine
└── developer-tooling-mastery-2026/
    ├── .git/
    ├── README.md
    └── docs/
```

Podemos trabajar con Git localmente sin necesitar una conexión permanente a internet.

Git administra el historial local.

---

# ☁️ Remote Repository

Un **Remote Repository** es otro Repository Git al que podemos conectarnos, frecuentemente alojado en un servidor o plataforma.

Por ejemplo:

```text
Developer Machine
       │
       │ push / fetch
       ↓
Remote Repository
```

Podemos utilizar servicios como:

```text
GitHub
GitLab
Bitbucket
```

Un Remote Repository permite intercambiar cambios y facilitar la colaboración.

Importante:

Un Repository no necesita tener un Remote para ser un Git Repository válido.

---

# 🔗 Git vs GitHub

Esta diferencia debe quedar completamente clara.

| Concept | Responsabilidad |
|---|---|
| Git | Administrar versiones e historial |
| GitHub | Alojar repositorios Git y facilitar colaboración |
| Local Repository | Repository disponible localmente |
| Remote Repository | Repository accesible mediante una conexión remota |

Por ejemplo:

```text
Git
    ↓
Version Control
```

Mientras que:

```text
GitHub
    ↓
Repository Hosting
    +
Collaboration
    +
Automation
```

GitHub puede proporcionar funcionalidades como Pull Requests, Issues y GitHub Actions.

Pero Git y GitHub no son la misma herramienta.

---

# 🔄 Flujo conceptual de colaboración

Imagina dos desarrolladores trabajando en el mismo Repository.

```text
Developer A
    │
    ├── Local Repository
    │
    └── Push Changes
             │
             ↓
       Remote Repository
             ↑
             │
    ┌────────┘
    │
Developer B
    │
    └── Fetch / Pull Changes
```

Ambos pueden compartir una historia de desarrollo.

También pueden trabajar en Branches diferentes e integrar cambios mediante procesos de revisión.

Este es uno de los fundamentos del trabajo colaborativo moderno.

---

# 🧩 Repository vs Project

Ahora llegamos a una distinción fundamental.

Un **Project** representa una unidad organizada de trabajo y desarrollo de software.

Un **Repository** representa una unidad de almacenamiento y versionado.

Por tanto:

```text
Project
    ≠
Repository
```

Aunque en proyectos pequeños ambos conceptos suelen parecer equivalentes.

---

# 📦 Un Repository con un Project

Podemos tener:

```text
customer-portal-repository/
├── .git/
├── src/
├── package.json
└── README.md
```

Aquí existe una Application principal dentro de un Repository.

Conceptualmente:

```text
Repository
    ↓
contains
    ↓
One Project
```

Este es un escenario habitual.

---

# 🏗️ Un Repository con múltiples Projects

También podemos tener:

```text
company-repository/
│
├── .git/
│
├── projects/
│   ├── customer-portal/
│   ├── admin-portal/
│   └── internal-api/
│
└── packages/
    ├── ui/
    └── validation/
```

Conceptualmente:

```text
Repository
│
├── Project A
├── Project B
├── Project C
├── Shared Package A
└── Shared Package B
```

Un mismo Repository puede contener múltiples unidades de desarrollo.

Esto nos acerca al concepto de Monorepo.

---

# 📚 Un Repository puede contener principalmente documentación

Un Repository no necesita contener una Application ejecutable.

Por ejemplo, nuestro Developer Tooling Mastery comenzó principalmente como un repositorio de documentación.

```text
developer-tooling-mastery-2026/
├── README.md
├── ROADMAP.md
├── STUDY-PLAN.md
├── GLOSSARY.md
├── CHEATSHEET.md
└── docs/
```

Este Repository puede existir, evolucionar y mantener su historial aunque todavía no tengamos:

```text
package.json
pnpm-workspace.yaml
nx.json
```

Esto es completamente válido.

Un Repository y un Package son conceptos diferentes.

---

# 🧩 Repository vs Package

Un Package es una unidad de software administrable dentro de un ecosistema.

Un Repository es una unidad de control de versiones.

Por ejemplo:

```text
Repository
│
├── Package A
├── Package B
└── Package C
```

También podríamos tener:

```text
Repository A
└── Package A

Repository B
└── Package B
```

No existe una relación obligatoria de uno a uno.

Por tanto:

```text
Repository
    ≠
Package
```

---

# 🏠 Repository vs Workspace

Recordemos el documento anterior.

Un Workspace, en el contexto de Package Managers, permite administrar múltiples Packages relacionados.

Un Repository permite versionar archivos y su historial.

Conceptualmente:

```text
Repository
    ↓
Version Control Boundary
```

Mientras que:

```text
Workspace
    ↓
Package Management Boundary
```

Estas son responsabilidades diferentes.

---

# 🔗 Pueden trabajar juntos

Imagina:

```text
company-repository/
│
├── .git/
├── package.json
├── pnpm-workspace.yaml
│
├── projects/
│   ├── web/
│   └── admin/
│
└── packages/
    ├── ui/
    └── utils/
```

Aquí podemos identificar dos conceptos:

**Repository**

Git administra el historial del contenido.

**Workspace**

pnpm puede administrar los Packages incluidos en la configuración del Workspace.

Conceptualmente:

```text
Same Directory Tree
        │
        ├── Git
        │    └── Version Control
        │
        └── pnpm
             └── Package Management
```

Ambas herramientas operan sobre el mismo entorno, pero resuelven problemas diferentes.

---

# ⚠️ Un Repository no implica un Workspace

Podemos tener:

```text
repository/
├── .git/
├── src/
└── README.md
```

Sin utilizar Workspaces.

Y podemos tener un entorno local con múltiples Packages relacionados sin que necesariamente estén todos dentro de un único Git Repository.

Por eso no debemos considerar ambos conceptos equivalentes.

---

# 🌐 Repository vs Monorepo

Un **Monorepo** es una estrategia de organización donde múltiples Projects se mantienen dentro de un mismo Repository.

Por ejemplo:

```text
company-monorepo/
│
├── projects/
│   ├── web/
│   ├── admin/
│   └── api/
│
└── packages/
    ├── ui/
    └── shared-utils/
```

Conceptualmente:

```text
One Repository
        ↓
Multiple Projects
        ↓
Monorepo
```

No significa que necesariamente debamos utilizar Nx, pnpm Workspaces u otra herramienta específica.

---

# 🗂️ Repository vs Polyrepo

Otra estrategia consiste en mantener Projects separados en diferentes Repositories.

Por ejemplo:

```text
web-repository/
admin-repository/
api-repository/
ui-library-repository/
```

Conceptualmente:

```text
Multiple Repositories
        ↓
Separate Projects
        ↓
Polyrepo
```

Esta estrategia también puede ser válida.

La elección dependerá de las necesidades de la organización.

Profundizaremos en la comparación en el siguiente documento.

---

# 🧱 El Repository como frontera de colaboración

Un Repository suele establecer una frontera importante para actividades como:

```text
Version Control
Code Review
Branch Management
Access Permissions
Contribution Workflow
Automation
```

Por ejemplo, en GitHub podemos tener:

```text
Repository
│
├── Branches
├── Pull Requests
├── Issues
├── Actions
└── Settings
```

Estas funcionalidades ayudan a organizar el trabajo colaborativo.

Sin embargo, no todas pertenecen a Git directamente.

Algunas son capacidades adicionales de la plataforma de alojamiento.

---

# 🤖 Repository y Automation

Cuando un Repository está alojado en una plataforma como GitHub, podemos configurar automatizaciones relacionadas con eventos.

Por ejemplo:

```text
Developer
    ↓
Push
    ↓
GitHub Repository
    ↓
GitHub Actions
    ↓
Lint
    ↓
Test
    ↓
Build
```

Esto conecta Version Control con Continuous Integration.

Más adelante estudiaremos estos conceptos en:

```text
14-ci-and-automation/
```

Por ahora basta comprender que un Repository puede servir como punto de integración para herramientas de automatización.

---

# 🔐 Public vs Private Repository

Un Repository alojado en una plataforma puede tener diferentes niveles de acceso.

Por ejemplo:

```text
Public Repository
```

puede permitir que otras personas consulten su contenido.

Mientras que:

```text
Private Repository
```

restringe el acceso a usuarios autorizados.

Importante:

```text
Private Repository
    ≠
Private Package
```

Un Repository privado y un Package privado representan decisiones de acceso y distribución en niveles diferentes.

---

# ⚠️ Repository no significa Backup completo

Aunque un Remote Repository proporciona una copia adicional del contenido versionado, no debemos asumir que Git guarda absolutamente todo.

Por ejemplo, pueden existir archivos ignorados mediante:

```text
.gitignore
```

También pueden existir:

```text
Local Environment Files
Secrets
Generated Files
Large Binary Assets
```

que no se incluyen en el historial.

Git es principalmente un sistema de control de versiones.

No sustituye automáticamente una estrategia completa de Backup.

---

# 📈 Nuestro repositorio evolucionará

Recordemos nuestro recorrido.

## Stage 1 — Documentation Repository

```text
developer-tooling-mastery-2026/
├── README.md
├── ROADMAP.md
└── docs/
```

## Stage 2 — Development Environment

Incorporaremos prácticas y configuraciones relacionadas con nuestro entorno.

## Stage 3 — Single Project

Comenzaremos a trabajar con Runtime, Package Manager y metadata.

## Stage 4 — Multiple Projects

Incorporaremos diferentes unidades de desarrollo.

## Stage 5 — Shared Packages

Crearemos funcionalidades y configuraciones reutilizables.

## Stage 6 — Workspace

Administraremos Packages relacionados mediante pnpm Workspaces.

## Stage 7 — Monorepo Tooling

Estudiaremos herramientas que ayudan a coordinar múltiples Projects.

## Stage 8 — Nx

Incorporaremos capacidades de Project Graph, Task Orchestration y Caching.

La evolución será progresiva.

No configuraremos todas estas piezas antes de comprenderlas.

---

# 🗺️ Nuestro modelo mental completo hasta ahora

Ahora podemos conectar los conceptos estudiados.

```text
Repository
│
├── Project A
│   └── Application
│
├── Project B
│   └── Application
│
└── Project C
    └── Library
```

Estas unidades también pueden organizarse como Packages:

```text
Repository
│
├── Application Package
├── Application Package
└── Library Package
```

Y podemos utilizar un Workspace para administrarlas conjuntamente:

```text
Git Repository
│
└── pnpm Workspace
    │
    ├── Web Application
    ├── Admin Application
    ├── UI Package
    └── Validation Package
```

Este último diagrama representa una organización habitual, no una regla universal.

---

# 💼 Modelo profesional

Cuando abras un proyecto desconocido, intenta responder:

```text
Where is the Git Repository root?

Is there a Remote Repository?

Which projects does it contain?

Is it a single-project repository?

Is it a Monorepo?

Does it contain internal packages?

Is there a Package Manager Workspace?

How are changes reviewed?

What automation is connected to the repository?
```

Estas preguntas te ayudarán a comprender cómo se organiza y mantiene el trabajo.

---

# ⚠️ Errores comunes

## 1. Pensar que Git y GitHub son lo mismo

Git administra versiones.

GitHub aloja repositorios Git y proporciona funcionalidades adicionales.

## 2. Pensar que cualquier carpeta es un Repository

Una carpeta común no necesariamente contiene un Repository Git.

## 3. Pensar que Repository y Project son sinónimos

Un Repository puede contener uno o múltiples Projects.

## 4. Pensar que cada Package necesita su propio Repository

Múltiples Packages pueden convivir dentro de un mismo Repository.

## 5. Pensar que Repository y Workspace son lo mismo

Git administra versiones; un Package Manager Workspace administra Packages relacionados.

## 6. Pensar que Monorepo requiere Nx

Un Monorepo es una estrategia de organización, no una herramienta específica.

## 7. Pensar que todo Repository necesita una Application

Un Repository puede contener principalmente documentación, configuraciones u otros recursos.

---

# 🧠 Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es un Repository?
2. ¿Qué problema resuelve Version Control?
3. ¿Qué diferencia existe entre Git y GitHub?
4. ¿Qué diferencia existe entre una carpeta común y un Git Repository?
5. ¿Qué es un Commit?
6. ¿Qué es una Branch?
7. ¿Qué diferencia existe entre Local Repository y Remote Repository?
8. ¿Repository y Project significan exactamente lo mismo?
9. ¿Un Repository puede contener múltiples Packages?
10. ¿Qué diferencia existe entre Repository y Workspace?
11. ¿Qué es un Monorepo?
12. ¿Qué es un Polyrepo?
13. ¿Un Repository necesita utilizar pnpm o Nx?
14. ¿Un Repository puede contener solamente documentación?
15. ¿Git reemplaza automáticamente una estrategia de Backup?

Si puedes responder estas preguntas con tus propias palabras, ya tienes una base sólida para estudiar las estrategias de organización de repositorios.

---

# 💡 Idea clave

Podemos resumir:

```text
Project
    ↓
What are we developing?
```

```text
Package
    ↓
What software unit are we managing?
```

```text
Workspace
    ↓
How do we manage related packages?
```

```text
Repository
    ↓
Where do we version our work?
```

Y posteriormente:

```text
Monorepo / Polyrepo
    ↓
How do we organize projects across repositories?
```

Cada concepto responde a una pregunta diferente.

Comprender esas diferencias nos permitirá tomar decisiones técnicas con mayor claridad.

---

## 🚀 Siguiente paso

Ya comprendemos qué es un Repository y cómo puede contener uno o varios Projects.

Ahora estudiaremos las dos estrategias más conocidas para organizar múltiples proyectos dentro de una organización.

👉 [Monorepo vs Polyrepo](./09-monorepo-vs-polyrepo.md)