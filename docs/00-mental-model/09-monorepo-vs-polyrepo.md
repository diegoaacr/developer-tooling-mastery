# Monorepo vs Polyrepo

En el documento anterior aprendimos que un **Repository** es una unidad de almacenamiento y control de versiones.

También comprendimos que un Repository puede contener un único Project o múltiples Projects.

Esto nos lleva a una decisión importante:

**¿Cómo deberíamos organizar varios proyectos relacionados?**

Podemos mantenerlos dentro de un mismo Repository o distribuirlos entre varios Repositories.

Estas dos estrategias se conocen habitualmente como:

```text
Monorepo
Polyrepo
```

Ambas pueden utilizarse profesionalmente.

La elección dependerá de las necesidades del equipo, las relaciones entre proyectos y los procesos de desarrollo.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué es un Monorepo.
- Qué es un Polyrepo.
- Qué problema intenta resolver cada estrategia.
- Cómo se organizan Applications y Libraries en ambos modelos.
- Qué ventajas y desventajas presenta cada enfoque.
- Cómo influyen las dependencias compartidas y la colaboración.
- Qué significa realizar cambios coordinados entre proyectos.
- Por qué Monorepo no significa necesariamente Nx.
- Cuándo podría convenir cada estrategia.
- Por qué nuestro Mastery evolucionará hacia un Monorepo.

No configuraremos todavía pnpm Workspaces ni Nx.

Primero queremos comprender las decisiones arquitectónicas.

---

# 🧠 Empecemos con un escenario real

Imagina que una empresa desarrolla tres productos:

```text
Customer Portal
Admin Dashboard
Backend API
```

También mantiene funcionalidades compartidas:

```text
UI Components
Validation
Shared Types
```

Tenemos varias unidades de software que necesitan desarrollarse y mantenerse.

La pregunta es:

> ¿Deberíamos guardar todo en un único Repository o crear un Repository independiente para cada unidad?

Esta decisión no cambia necesariamente lo que hace el software.

Cambia principalmente **cómo organizamos su código, su historial y parte de nuestros procesos de colaboración**.

---

# 🏗️ ¿Qué es un Monorepo?

Un **Monorepo** es una estrategia de organización en la que múltiples proyectos se mantienen dentro de un mismo Repository.

Conceptualmente:

```text
Company Repository
│
├── Customer Portal
├── Admin Dashboard
├── Backend API
├── UI Library
└── Validation Library
```

Todos estos proyectos comparten un Repository y, por tanto, una historia de control de versiones común.

Por ejemplo:

```text
company-monorepo/
│
├── projects/
│   ├── customer-portal/
│   ├── admin-dashboard/
│   └── backend-api/
│
└── packages/
    ├── ui/
    ├── validation/
    └── shared-types/
```

Los nombres `projects/` y `packages/` son decisiones de organización.

No son requisitos universales de un Monorepo.

---

# 🗂️ ¿Qué es un Polyrepo?

Un **Polyrepo** es una estrategia en la que los proyectos se mantienen en múltiples Repositories.

Por ejemplo:

```text
customer-portal-repository/
admin-dashboard-repository/
backend-api-repository/
ui-library-repository/
validation-library-repository/
```

Cada Repository puede tener su propio:

```text
Git History
Branches
Pull Requests
Permissions
CI Configuration
Release Process
```

Conceptualmente:

```text
Company
│
├── Repository A → Customer Portal
├── Repository B → Admin Dashboard
├── Repository C → Backend API
├── Repository D → UI Library
└── Repository E → Validation Library
```

Esto permite administrar los proyectos mediante fronteras de Repository independientes.

---

# 🔑 Diferencia fundamental

La distinción principal es:

```text
Monorepo
    ↓
Multiple Projects
    ↓
One Repository
```

Mientras que:

```text
Polyrepo
    ↓
Multiple Projects
    ↓
Multiple Repositories
```

No debemos confundir esta decisión con la elección de un Framework, Package Manager o Build Tool.

Monorepo y Polyrepo son **estrategias de organización de repositorios**.

---

# 🧩 Mismo software, diferente organización

Imagina las siguientes relaciones:

```text
Customer Portal ─────→ UI Library
       │
       └─────────────→ Validation Library

Admin Dashboard ─────→ UI Library

Backend API ─────────→ Validation Library
```

Estas relaciones pueden existir tanto en Monorepo como en Polyrepo.

Lo que cambia es cómo organizamos y administramos las unidades.

## En Monorepo

```text
company/
├── projects/
│   ├── customer-portal/
│   ├── admin-dashboard/
│   └── backend-api/
└── packages/
    ├── ui/
    └── validation/
```

## En Polyrepo

```text
customer-portal-repo/
admin-dashboard-repo/
backend-api-repo/
ui-library-repo/
validation-library-repo/
```

Las aplicaciones siguen necesitando sus dependencias.

La organización del Repository no elimina esas relaciones.

---

# 🔗 Dependencias compartidas

Uno de los factores más importantes al elegir una estrategia es la cantidad de código compartido.

Imagina que tenemos:

```text
Customer Portal
Admin Dashboard
```

y ambos consumen:

```text
@company/ui
```

En un Monorepo, podríamos mantener los tres proyectos juntos.

```text
Monorepo
│
├── Customer Portal
├── Admin Dashboard
└── UI Package
```

En un Polyrepo, la UI Library podría vivir en un Repository independiente y distribuirse mediante un Package Registry.

```text
UI Repository
      ↓
Package Registry
      ↓
Customer Portal / Admin Dashboard
```

Sin embargo, un Polyrepo no está obligado a utilizar un Registry, y un Monorepo tampoco está obligado a evitarlo.

Son posibilidades de implementación, no reglas absolutas.

---

# 🔄 Cambios coordinados

Imagina que necesitamos modificar una función de nuestra Library.

Antes:

```ts
export function formatPrice(value: number): string {
  return String(value);
}
```

Después queremos introducir una opción para la moneda:

```ts
export function formatPrice(
  value: number,
  currency: string
): string {
  return `${value} ${currency}`;
}
```

Este cambio puede afectar a varias aplicaciones.

Ahora necesitamos actualizar:

```text
UI Library
Customer Portal
Admin Dashboard
```

## En Monorepo

Podríamos realizar los cambios dentro de una misma Branch y revisarlos conjuntamente.

```text
One Repository
      ↓
Update Library
      ↓
Update Consumers
      ↓
Run Validation
      ↓
One Pull Request
```

Esto facilita ciertos cambios coordinados.

## En Polyrepo

Podríamos necesitar actualizar primero la Library, publicar o distribuir una versión compatible y después actualizar los consumidores.

```text
Library Repository
      ↓
Release / Distribution
      ↓
Customer Portal Repository
      ↓
Admin Dashboard Repository
```

También es posible coordinar cambios entre repositorios utilizando herramientas y automatizaciones.

La diferencia es que el proceso puede involucrar más fronteras de integración.

---

# 📦 Versionado de Packages

Una confusión frecuente es pensar:

```text
Monorepo = One Version
```

Esto no es necesariamente correcto.

Dentro de un Monorepo podemos utilizar diferentes estrategias.

Por ejemplo:

```text
@company/ui          2.1.0
@company/validation  1.4.0
@company/utils       3.0.0
```

Cada Package podría mantener su propia versión.

También existen estrategias donde varios Packages comparten una política de versionado.

El modelo elegido depende de las necesidades del proyecto.

Por tanto:

> Un Monorepo no obliga a que todos los Packages tengan la misma versión ni se publiquen simultáneamente.

---

# 🚀 Deployment independiente

Otra confusión frecuente:

```text
Monorepo = Deploy Everything Together
```

Esto tampoco es obligatorio.

Imagina:

```text
Monorepo
│
├── Web Application
├── Admin Application
└── Backend API
```

Podemos diseñar pipelines que desplieguen cada aplicación de forma independiente.

Por ejemplo:

```text
Change Web Application
        ↓
Validate Web
        ↓
Deploy Web
```

Sin necesidad de desplegar automáticamente el Backend API.

Para lograrlo necesitamos una estrategia adecuada de CI/CD y detección de cambios.

El Monorepo no proporciona por sí solo esa automatización.

---

# 🧪 Testing en Monorepo

Cuando varios proyectos comparten dependencias, un cambio puede afectar a diferentes consumidores.

Por ejemplo:

```text
UI Library
    ↓
Customer Portal
    ↓
Admin Dashboard
```

Si modificamos la UI Library, podría ser necesario ejecutar verificaciones sobre ambos consumidores.

Una estrategia sencilla sería:

```text
Run All Tests
```

Pero en un Monorepo grande esto puede resultar costoso.

Entonces aparece una nueva necesidad:

```text
Run Only Relevant Tests
```

Aquí empiezan a tener sentido herramientas capaces de comprender relaciones entre proyectos.

---

# 🕸️ Dependency Graph

Un Dependency Graph representa relaciones de dependencia entre unidades de software.

Por ejemplo:

```text
Customer Portal ─────→ UI Library
       │                    │
       ↓                    ↓
Validation Library ───→ Utils Library

Admin Dashboard ─────→ UI Library
```

Si cambia:

```text
Utils Library
```

podríamos necesitar validar los proyectos afectados directa o indirectamente.

Conceptualmente:

```text
Change
    ↓
Dependency Graph
    ↓
Affected Projects
    ↓
Relevant Tasks
```

Esta idea será importante cuando estudiemos Nx.

---

# ⚙️ Monorepo no significa Nx

Podemos tener un Monorepo sencillo:

```text
repository/
├── project-a/
└── project-b/
```

Sin utilizar Nx.

También podemos utilizar pnpm Workspaces para administrar Packages internos sin introducir Nx.

Conceptualmente:

```text
Monorepo
    ↓
Repository Strategy
```

```text
pnpm Workspaces
    ↓
Package Workspace Management
```

```text
Nx
    ↓
Project and Task Orchestration
```

Cada pieza resuelve una responsabilidad diferente.

---

# 🧰 ¿Por qué existen herramientas de Monorepo?

Cuando el número de proyectos aumenta, aparecen necesidades como:

```text
Task Coordination
Dependency Relationships
Build Order
Caching
Affected Projects
Shared Configuration
CI Optimization
```

Un Monorepo puede existir sin herramientas especializadas.

Pero administrarlo eficientemente puede requerir capacidades adicionales.

Por ejemplo:

```text
Monorepo
    ↓
Many Projects
    ↓
Many Related Tasks
    ↓
Need for Orchestration
```

Ahí pueden resultar útiles herramientas como Nx.

---

# ⚡ Ventajas potenciales de Monorepo

## 1. Visibilidad compartida

Los desarrolladores pueden explorar diferentes proyectos desde un mismo Repository.

Esto puede facilitar comprender las relaciones entre Applications y Libraries.

## 2. Cambios coordinados

Podemos modificar código compartido y consumidores dentro de una misma propuesta de cambio.

## 3. Estándares compartidos

Es posible centralizar configuraciones de:

```text
Formatting
Linting
TypeScript
Testing
CI
```

Aunque compartir un Repository no garantiza automáticamente que todos los proyectos utilicen los mismos estándares.

## 4. Reutilización de código

Puede facilitar el desarrollo conjunto de Libraries y aplicaciones consumidoras.

## 5. Automatización integrada

Podemos diseñar procesos que consideren relaciones entre proyectos.

## 6. Mejor visibilidad del impacto

Con herramientas apropiadas podemos identificar qué proyectos podrían verse afectados por un cambio.

---

# ⚠️ Desventajas potenciales de Monorepo

## 1. Complejidad de Tooling

Cuando crece el Repository, pueden necesitarse herramientas de coordinación adicionales.

## 2. CI más complejo

Una estrategia ingenua podría ejecutar todas las verificaciones ante cualquier cambio.

Esto puede generar tiempos y costes innecesarios.

## 3. Fronteras de acceso

Si distintos equipos necesitan permisos muy diferentes, un Repository compartido puede complicar determinadas políticas de acceso.

## 4. Acoplamiento organizacional

Compartir Repository puede incentivar dependencias innecesarias si no existen límites claros.

## 5. Escalabilidad operativa

Repositories grandes pueden requerir estrategias especiales para optimizar Git, instalaciones, builds y procesos de desarrollo.

## 6. Coordinación de equipos

Los cambios en configuraciones compartidas pueden afectar a múltiples proyectos.

Por eso necesitamos acuerdos y estándares claros.

---

# 🏢 Ventajas potenciales de Polyrepo

## 1. Independencia

Cada Repository puede mantener sus propios procesos de desarrollo.

## 2. Límites de acceso

Es más sencillo establecer ciertos permisos a nivel de Repository.

## 3. Ciclos de vida separados

Cada proyecto puede mantener su propio ritmo de cambios y releases.

## 4. Tooling específico

Cada Repository puede utilizar herramientas adecuadas a sus necesidades.

## 5. Fronteras organizacionales

Puede encajar bien cuando los proyectos pertenecen a equipos con responsabilidades claramente separadas.

---

# ⚠️ Desventajas potenciales de Polyrepo

## 1. Configuración duplicada

Diferentes Repositories pueden terminar manteniendo configuraciones similares.

Por ejemplo:

```text
ESLint Configuration
TypeScript Configuration
CI Configuration
```

## 2. Actualizaciones distribuidas

Un cambio en una Library compartida puede requerir actualizaciones en varios Repositories.

## 3. Visibilidad fragmentada

Comprender relaciones entre proyectos puede requerir navegar por diferentes Repositories.

## 4. Coordinación de versiones

Los consumidores pueden utilizar versiones diferentes de una misma dependencia interna.

## 5. Automatización distribuida

Es posible que necesitemos coordinar múltiples pipelines y procesos de release.

Estos problemas pueden mitigarse mediante Packages compartidos, plantillas y automatización.

---

# 📊 Comparación general

| Criterio | Monorepo | Polyrepo |
|---|---|---|
| Organización | Múltiples proyectos en un Repository | Proyectos distribuidos en varios Repositories |
| Historial Git | Compartido | Separado por Repository |
| Cambios entre proyectos | Pueden coordinarse en un mismo cambio | Requieren coordinación entre Repositories |
| Configuración compartida | Puede centralizarse | Puede distribuirse mediante Packages o Templates |
| Permisos | Frontera principal compartida | Fronteras independientes |
| CI | Puede aprovechar relaciones entre proyectos | Normalmente se organiza por Repository |
| Releases | Pueden ser independientes | Pueden ser independientes |
| Tooling | Puede requerir orquestación adicional | Puede requerir coordinación distribuida |
| Escalabilidad | Depende de arquitectura y herramientas | Depende de integración y coordinación |

No existe un ganador universal.

---

# 🧠 ¿Cuándo puede convenir un Monorepo?

Un Monorepo puede ser especialmente útil cuando:

- Existen varios proyectos relacionados.
- Hay código y configuraciones compartidas.
- Se realizan cambios coordinados frecuentemente.
- Los equipos necesitan visibilidad transversal.
- Queremos administrar tareas considerando dependencias entre proyectos.
- Podemos invertir en herramientas y estándares compartidos.

Por ejemplo:

```text
Web Application
Admin Application
Shared UI
Shared Validation
Shared Types
```

puede ser un escenario razonable para evaluar un Monorepo.

---

# 🧠 ¿Cuándo puede convenir un Polyrepo?

Un Polyrepo puede resultar adecuado cuando:

- Los proyectos tienen ciclos de vida muy diferentes.
- Existen requisitos de acceso independientes.
- Los equipos trabajan con poca dependencia entre ellos.
- Se necesita aislamiento organizacional.
- Cada proyecto tiene procesos técnicos considerablemente diferentes.
- La coordinación entre proyectos es limitada.

Por ejemplo:

```text
Independent Product A
Independent Product B
Independent Service C
```

podrían mantenerse razonablemente en Repositories separados.

---

# ⚖️ No todo debe estar junto

Elegir Monorepo no significa colocar todos los proyectos de una organización en un único Repository.

Podemos tener diferentes Monorepos para distintos dominios.

Por ejemplo:

```text
Company
│
├── Frontend Monorepo
├── Backend Monorepo
└── Infrastructure Repository
```

También podemos combinar Monorepos y Repositories independientes.

La decisión debe responder a necesidades reales.

---

# 🔄 Migrar entre estrategias

La organización de repositorios puede cambiar con el tiempo.

Por ejemplo:

```text
Single Repository
        ↓
Growing Number of Projects
        ↓
Evaluate Architecture
        ↓
Monorepo or Polyrepo
```

También una organización puede consolidar proyectos previamente separados o dividir un Repository demasiado grande.

Estas decisiones tienen costes y deben evaluarse cuidadosamente.

La arquitectura de repositorios no es necesariamente permanente.

---

# 🏗️ ¿Por qué nuestro Mastery utilizará Monorepo?

En Developer Tooling Mastery 2026 queremos aprender progresivamente:

```text
Package Management
Shared Configuration
Internal Packages
Workspaces
Task Orchestration
Caching
Dependency Graphs
CI Automation
```

Para estudiar estos conceptos de manera integrada, un Monorepo será un entorno educativo adecuado.

Nos permitirá construir varias aplicaciones y Packages relacionados.

Por ejemplo:

```text
developer-tooling-mastery-2026/
│
├── docs/
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
└── tools/
```

Esta es una representación de nuestro objetivo futuro.

No necesitamos crear toda la estructura ni configurar todas las herramientas desde ahora.

---

# 📈 Evolución de nuestro repositorio

Nuestro aprendizaje seguirá esta progresión:

```text
Documentation Repository
        ↓
Development Environment
        ↓
Single Project
        ↓
Multiple Projects
        ↓
Shared Packages
        ↓
pnpm Workspaces
        ↓
Monorepo Tooling
        ↓
Nx
        ↓
Professional Workspace
```

Cada etapa aparecerá cuando entendamos el problema que resuelve.

---

# 🔑 Una decisión importante: Repository Strategy vs Tooling

Debemos separar dos preguntas.

Primera:

> ¿Cómo queremos organizar nuestros proyectos?

Esta pregunta pertenece a:

```text
Repository Architecture
```

Segunda:

> ¿Qué herramientas necesitamos para administrar esa organización?

Esta pregunta pertenece a:

```text
Developer Tooling
```

Por ejemplo:

```text
Decision
Use a Monorepo
        ↓
Need
Manage Internal Packages
        ↓
Tool
pnpm Workspaces
        ↓
New Need
Coordinate Tasks Efficiently
        ↓
Tool
Nx
```

Este ejemplo ilustra una posible evolución, no una obligación.

Podemos tener un Monorepo sin pnpm o sin Nx.

---

# 💼 Modelo profesional

Cuando evalúes la organización de una empresa, intenta responder:

```text
How many projects exist?

How closely related are they?

How much code is shared?

How frequently do changes affect multiple projects?

Do teams need independent permissions?

Are release cycles independent?

How are dependencies distributed?

How are CI pipelines organized?

What tooling complexity can the team maintain?
```

Estas preguntas son más importantes que elegir una estrategia solamente porque está de moda.

---

# ⚠️ Errores comunes

## 1. Pensar que Monorepo siempre es mejor

No existe una estrategia universalmente superior.

## 2. Pensar que Polyrepo es una arquitectura anticuada

Polyrepo sigue siendo una opción válida para numerosos equipos y organizaciones.

## 3. Pensar que Monorepo significa Nx

Nx es una herramienta; Monorepo es una estrategia.

## 4. Pensar que todos los Packages de un Monorepo deben publicarse juntos

Podemos tener diferentes estrategias de versionado y distribución.

## 5. Pensar que todos los Projects deben desplegarse juntos

Un Monorepo puede contener aplicaciones con despliegues independientes.

## 6. Pensar que compartir Repository garantiza reutilización

La reutilización requiere buenas fronteras, interfaces y decisiones de diseño.

## 7. Pensar que Polyrepo impide compartir código

Podemos distribuir Packages compartidos y utilizar automatizaciones entre Repositories.

## 8. Introducir Monorepo Tooling antes de comprender la necesidad

Las herramientas deberían responder a problemas concretos.

---

# 🧠 Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es un Monorepo?
2. ¿Qué es un Polyrepo?
3. ¿Cuál es la diferencia principal entre ambos?
4. ¿Una Application puede depender de una Library en ambas estrategias?
5. ¿Por qué un Monorepo puede facilitar cambios coordinados?
6. ¿Qué problemas puede introducir un Monorepo grande?
7. ¿Qué ventajas puede proporcionar Polyrepo?
8. ¿Monorepo significa que todos los Packages deben tener la misma versión?
9. ¿Monorepo significa que todas las aplicaciones se despliegan juntas?
10. ¿Necesitamos Nx para tener un Monorepo?
11. ¿Qué responsabilidad tiene pnpm Workspaces?
12. ¿Por qué un Dependency Graph puede ser importante?
13. ¿Qué criterios deberíamos evaluar antes de elegir una estrategia?
14. ¿Por qué nuestro Mastery evolucionará hacia un Monorepo?

Si puedes explicar estas respuestas con tus propias palabras, ya tienes una base conceptual para comprender las arquitecturas de repositorios.

---

# 💡 Idea clave

La diferencia fundamental es:

```text
Monorepo
    ↓
Multiple Projects
    ↓
One Repository
```

```text
Polyrepo
    ↓
Multiple Projects
    ↓
Multiple Repositories
```

Ambas estrategias pueden ser profesionales.

La decisión correcta depende de las necesidades del software y del equipo.

Y debemos recordar:

```text
Repository Strategy
        ≠
Tool Selection
```

Primero decidimos qué problema queremos resolver.

Después elegimos las herramientas adecuadas.

---

## 🚀 Siguiente paso

Ya comprendemos cómo se pueden organizar múltiples proyectos y por qué existen diferentes estrategias de repositorios.

Ahora volveremos a la pregunta central de este Mastery:

**¿Por qué necesitamos Developer Tooling y qué problemas resuelve realmente?**

👉 [Why Developer Tooling Matters](./10-why-developer-tooling-matters.md)