# How Modern Companies Build Software

Hasta ahora hemos estudiado diferentes conceptos fundamentales:

```text
Software Project
Application
Library
Package
Workspace
Repository
Developer Tooling
```

También comprendimos que desarrollar software profesionalmente requiere más que escribir código.

Pero ahora surge una pregunta importante:

**¿Cómo se combinan todos estos elementos dentro de una empresa real?**

En este documento construiremos una visión general del proceso de desarrollo de software moderno, desde una necesidad de negocio hasta la entrega y mantenimiento de una aplicación.

No todas las empresas trabajan exactamente de la misma manera. Sin embargo, existen responsabilidades, prácticas y procesos que aparecen frecuentemente en equipos profesionales.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Cómo se transforma una necesidad de negocio en software.
- Qué responsabilidades intervienen en el desarrollo profesional.
- Cómo colaboran Product, Design, Engineering y Quality Assurance.
- Qué papel cumplen los Repositories y los Development Environments.
- Cómo se integra Developer Tooling en el trabajo diario.
- Qué es un Development Workflow.
- Por qué existen Code Reviews y Pull Requests.
- Qué responsabilidad tiene Continuous Integration.
- Qué diferencia existe entre Build, Release y Deployment.
- Por qué Monitoring y Maintenance forman parte del ciclo de vida del software.
- Cómo se relacionan los estándares técnicos con el crecimiento de los equipos.

---

# 🧠 Empecemos con una necesidad

Imagina que una empresa necesita desarrollar una aplicación para administrar pedidos.

El negocio plantea:

> Necesitamos que nuestros clientes puedan consultar sus pedidos y conocer su estado.

Esta necesidad todavía no representa una solución técnica completa.

Primero debemos comprender qué problema queremos resolver.

Conceptualmente:

```text
Business Need
      ↓
Problem Understanding
      ↓
Requirements
      ↓
Solution Design
      ↓
Implementation
      ↓
Validation
      ↓
Delivery
      ↓
Maintenance
```

Este flujo es una representación simplificada.

En la práctica, las actividades pueden repetirse, superponerse y evolucionar mediante iteraciones.

---

# 🧩 1. Product: comprender qué construir

Antes de desarrollar una funcionalidad, necesitamos comprender su propósito.

Algunas preguntas importantes son:

```text
Who needs this functionality?

What problem does it solve?

What behavior is expected?

What constraints exist?

How will success be evaluated?
```

Por ejemplo, podríamos definir una funcionalidad:

```text
Feature:
Order Tracking
```

Y una necesidad:

```text
As a customer,
I want to view my order status,
so that I can track its progress.
```

Esto es un ejemplo de **User Story**.

Una User Story ayuda a expresar una necesidad desde la perspectiva de quien utilizará el producto.

Pero no sustituye por sí sola todos los requisitos.

También podríamos necesitar Acceptance Criteria.

---

# ✅ Acceptance Criteria

Los Acceptance Criteria describen condiciones que permiten evaluar si una funcionalidad cumple el comportamiento esperado.

Por ejemplo:

```text
Feature: Order Tracking

Acceptance Criteria:

- The customer can view their orders.
- Each order displays its current status.
- Only authorized customers can access their orders.
- An appropriate message appears when no orders exist.
```

Estas condiciones ayudan a conectar las expectativas del producto con la implementación y las pruebas.

---

# 🎨 2. Design: definir la experiencia

Una vez comprendida la necesidad, podemos diseñar cómo interactuará el usuario con la funcionalidad.

Por ejemplo:

```text
Requirements
      ↓
User Flows
      ↓
Wireframes
      ↓
Mockups
      ↓
Prototypes
```

No todos los proyectos necesitan ejecutar estas actividades como etapas separadas.

Dependiendo de la complejidad, algunas pueden realizarse de manera conjunta.

El objetivo es reducir incertidumbre antes y durante la implementación.

---

# 🏗️ 3. Engineering: diseñar la solución técnica

El equipo de Engineering necesita transformar los requisitos en una solución técnica.

Por ejemplo:

```text
Order Tracking
      ↓
Frontend Application
      ↓
Backend API
      ↓
Database
```

Conceptualmente:

```text
Customer
    ↓
Web Application
    ↓
Backend API
    ↓
Database
```

Este diagrama describe una posible arquitectura.

No todas las aplicaciones necesitan exactamente estas tres capas.

La solución dependerá de los requisitos y restricciones del proyecto.

---

# 🧱 4. Organizar el trabajo técnico

Antes de implementar, necesitamos decidir cómo organizaremos nuestro software.

Por ejemplo:

```text
Repository
│
├── Frontend Application
├── Backend Application
└── Shared Library
```

O podríamos mantener estas unidades en Repositories separados.

Aquí aparecen las decisiones que estudiamos anteriormente:

```text
Monorepo
    vs
Polyrepo
```

La estrategia elegida influirá en cómo colaboramos, compartimos código y administramos cambios.

---

# 💻 5. Development Environment

Cada desarrollador necesita un entorno adecuado para trabajar.

Por ejemplo:

```text
Developer Machine
│
├── Operating System
├── Terminal
├── Code Editor
├── Git
├── Runtime
├── Package Manager
└── Project Dependencies
```

Este entorno debe permitir realizar operaciones como:

```text
Clone Repository
Install Dependencies
Start Application
Make Changes
Run Checks
```

Un buen Development Environment reduce obstáculos innecesarios durante el desarrollo.

---

# 🔁 6. Onboarding de un desarrollador

Imagina que una nueva persona se incorpora al equipo.

Necesita preparar su entorno.

Conceptualmente:

```text
Join Team
    ↓
Get Repository Access
    ↓
Clone Repository
    ↓
Configure Environment
    ↓
Install Dependencies
    ↓
Run Application
    ↓
Understand Development Workflow
```

Este proceso se conoce habitualmente como **Developer Onboarding**.

Si cada persona necesita descubrir por su cuenta cómo ejecutar el proyecto, el proceso puede resultar lento y propenso a errores.

Por eso son importantes:

```text
Documentation
Standards
Tooling
Automation
```

---

# 📄 7. Documentación del proyecto

Un Repository profesional suele proporcionar instrucciones para trabajar con el software.

Por ejemplo:

```text
README.md
CONTRIBUTING.md
```

El README puede explicar:

```text
What is this project?

How do I install dependencies?

How do I start development?

How do I run tests?
```

Mientras que CONTRIBUTING puede explicar:

```text
How do we contribute?

What conventions do we follow?

How do we submit changes?

What checks are required?
```

La documentación debe mantenerse alineada con el funcionamiento real del proyecto.

---

# 🌿 8. Development Workflow

Una vez preparado el entorno, necesitamos un proceso para desarrollar cambios.

Un ejemplo habitual es:

```text
Select Task
    ↓
Create Branch
    ↓
Implement Changes
    ↓
Run Local Checks
    ↓
Commit Changes
    ↓
Push Branch
    ↓
Open Pull Request
    ↓
Code Review
    ↓
Merge
```

Este flujo no es obligatorio para todos los equipos.

Algunas organizaciones utilizan Trunk-Based Development, Feature Branches u otras estrategias.

Lo importante es que exista un proceso comprensible y adecuado para el equipo.

---

# 🧪 9. Local Quality Checks

Durante el desarrollo podemos ejecutar verificaciones locales.

Por ejemplo:

```text
Developer
    ↓
Code Changes
    ↓
Formatting
    ↓
Linting
    ↓
Type Checking
    ↓
Testing
```

Estas verificaciones ayudan a detectar problemas antes de compartir los cambios.

Aquí aparece directamente Developer Tooling.

Por ejemplo:

```text
Formatting      → Prettier
Linting         → ESLint
Type Checking   → TypeScript
Testing         → Test Runner
```

Las herramientas concretas dependerán del proyecto.

---

# 🪝 10. Git Hooks

Algunos equipos incorporan verificaciones automáticas relacionadas con eventos de Git.

Por ejemplo:

```text
Developer
    ↓
git commit
    ↓
Pre-commit Hook
    ↓
Selected Checks
    ↓
Commit
```

Podríamos utilizar herramientas como:

```text
Husky
lint-staged
commitlint
```

Estas herramientas pueden contribuir a mantener convenciones compartidas.

Sin embargo, las verificaciones locales no deben considerarse una garantía suficiente de calidad.

También necesitamos controles compartidos.

---

# 🔍 11. Pull Requests y Code Review

Cuando un desarrollador termina una modificación, puede crear un Pull Request.

Un **Pull Request** es una propuesta para integrar cambios en otra Branch dentro de plataformas como GitHub.

Conceptualmente:

```text
Feature Branch
      ↓
Pull Request
      ↓
Review
      ↓
Approval / Requested Changes
      ↓
Merge
```

El Code Review permite que otras personas examinen los cambios.

Puede ayudar a detectar:

```text
Incorrect Behavior
Maintainability Problems
Missing Tests
Unclear Design Decisions
Security Concerns
```

No garantiza que todos los problemas sean detectados, pero agrega una oportunidad importante de colaboración y revisión.

---

# 🤖 12. Continuous Integration

Durante un Pull Request podemos ejecutar verificaciones automatizadas.

Por ejemplo:

```text
Pull Request
      ↓
CI Pipeline
      │
      ├── Install Dependencies
      ├── Lint
      ├── Type Check
      ├── Test
      └── Build
      ↓
Validation Results
```

Esto forma parte de una estrategia de **Continuous Integration (CI)**.

La integración frecuente de cambios, junto con verificaciones automatizadas, ayuda a detectar problemas de integración.

En nuestro Mastery estudiaremos GitHub Actions como una herramienta para implementar automatización.

---

# 🧠 Local Checks vs CI Checks

Debemos distinguir ambos niveles.

## Local Checks

Se ejecutan en el entorno del desarrollador.

```text
Developer Machine
      ↓
Local Validation
```

## CI Checks

Se ejecutan en un entorno de automatización compartido.

```text
CI Environment
      ↓
Automated Validation
```

Ambos pueden complementarse.

Por ejemplo:

```text
Local Checks
      ↓
Early Feedback
      ↓
Pull Request
      ↓
CI Checks
      ↓
Shared Validation
```

El objetivo es detectar problemas lo antes posible y mantener verificaciones consistentes antes de integrar cambios.

---

# 🏗️ 13. Build

Una vez que el código supera las verificaciones necesarias, podemos generar artefactos para su ejecución o distribución.

Por ejemplo:

```text
Source Code
      ↓
Build Tool
      ↓
Build Artifacts
```

En una aplicación frontend podríamos obtener:

```text
dist/
├── index.html
└── assets/
```

En otros proyectos el resultado podría ser diferente.

Por ejemplo:

```text
Compiled JavaScript
Executable Files
Container Images
Libraries
```

El Build depende del tipo de software.

---

# 📦 14. Release

Una **Release** representa una versión preparada e identificada del software para su distribución o entrega.

Por ejemplo:

```text
Version 1.0.0
Version 1.1.0
Version 2.0.0
```

Una Release puede incluir:

```text
Version Identification
Release Notes
Artifacts
Compatibility Information
```

No todos los proyectos utilizan el mismo proceso de Releases.

Algunas aplicaciones despliegan continuamente cambios sin publicar versiones visibles para el usuario.

---

# 🚀 15. Deployment

**Deployment** consiste en instalar o poner una versión del software en un entorno donde pueda ejecutarse.

Por ejemplo:

```text
Build Artifacts
      ↓
Deployment Process
      ↓
Production Environment
```

En una aplicación web, esto podría implicar publicar archivos en un servidor o plataforma de alojamiento.

En un Backend, podría implicar actualizar un servicio en ejecución.

Importante:

```text
Build
    ≠
Release
    ≠
Deployment
```

Son conceptos relacionados, pero representan responsabilidades diferentes.

---

# 🌍 16. Development, Staging y Production

Muchas organizaciones utilizan diferentes entornos.

Por ejemplo:

```text
Development
    ↓
Staging
    ↓
Production
```

## Development

Entorno utilizado para desarrollar y comprobar funcionalidades.

## Staging

Entorno utilizado para determinadas verificaciones previas a producción.

## Production

Entorno donde el software proporciona su funcionalidad real a usuarios o sistemas.

No todos los proyectos necesitan exactamente estos tres entornos.

Algunas organizaciones utilizan más o menos, dependiendo de sus necesidades.

---

# 📊 17. Monitoring

Una vez desplegado el software, el trabajo no termina.

Necesitamos comprender cómo se comporta.

Por ejemplo:

```text
Production Application
        ↓
Logs
Metrics
Traces
Alerts
```

Estas señales pueden ayudar a detectar problemas y analizar el funcionamiento del sistema.

Conceptualmente:

```text
Application
    ↓
Observability
    ↓
Operational Understanding
```

Monitoring y Observability están relacionados, pero no son exactamente equivalentes.

Profundizar en estas prácticas pertenece a áreas como Operations, Cloud y DevOps.

---

# 🔧 18. Maintenance

El software necesita mantenimiento continuo.

Por ejemplo:

```text
Bug Fixes
Dependency Updates
Security Patches
Performance Improvements
Refactoring
New Features
```

Por eso el desarrollo de software no es simplemente:

```text
Write Code
    ↓
Deploy
    ↓
Finished
```

En realidad, el proceso suele ser continuo:

```text
Understand
    ↓
Build
    ↓
Validate
    ↓
Deliver
    ↓
Observe
    ↓
Improve
    ↺
```

---

# 🏢 Cómo colaboran diferentes responsabilidades

En un proyecto profesional pueden intervenir diferentes especialidades.

Por ejemplo:

| Área | Responsabilidades habituales |
|---|---|
| Product | Necesidades, prioridades y resultados |
| UX/UI Design | Experiencia e interfaces |
| Software Engineering | Diseño técnico e implementación |
| Quality Assurance | Estrategias y actividades de verificación |
| Platform / DevOps | Infraestructura, automatización y operación |
| Security | Riesgos y controles de seguridad |
| Operations | Disponibilidad y funcionamiento del sistema |

Estas responsabilidades no siempre corresponden a personas o equipos separados.

En organizaciones pequeñas, una misma persona puede cubrir varias áreas.

---

# 🧩 ¿Dónde encaja Developer Tooling?

Developer Tooling atraviesa diferentes etapas del proceso.

Por ejemplo:

```text
Development Environment
        ↓
Runtime Management
        ↓
Package Management
        ↓
Code Quality
        ↓
Build
        ↓
Automation
        ↓
CI
        ↓
Delivery
```

No todas estas responsabilidades pertenecen exclusivamente a Developer Tooling.

Pero las herramientas de desarrollo contribuyen a que estos procesos sean más consistentes y eficientes.

---

# 🧱 Estándares de ingeniería

Cuando un equipo crece, necesita establecer acuerdos.

Por ejemplo:

```text
Runtime Versions
Dependency Policies
Code Formatting
Lint Rules
TypeScript Configuration
Commit Conventions
Testing Requirements
Pull Request Process
CI Checks
```

Estos acuerdos forman parte de los **Engineering Standards**.

Su objetivo es reducir decisiones repetitivas y establecer expectativas compartidas.

---

# ⚖️ Estándares vs Autonomía

Los estándares proporcionan consistencia.

Pero también debemos evitar imponer reglas innecesarias.

Por ejemplo, dos proyectos pueden tener necesidades diferentes:

```text
Frontend Application
Backend Service
```

Ambos podrían compartir ciertas convenciones:

```text
Formatting
Commit Messages
Dependency Policies
```

Pero necesitar configuraciones distintas para:

```text
Build
Runtime
Testing
Deployment
```

Una buena estrategia de estándares identifica qué conviene compartir y qué debe permanecer específico de cada proyecto.

---

# 🔄 Shared Configuration

En organizaciones con múltiples proyectos puede resultar útil reutilizar configuraciones.

Por ejemplo:

```text
@company/eslint-config
@company/typescript-config
```

Conceptualmente:

```text
Shared Configuration Package
          ↓
Multiple Projects
          ↓
Consistent Standards
```

Esto conecta directamente con los conceptos de Package y Workspace que estudiamos anteriormente.

---

# 🏗️ Ejemplo completo: una empresa con Monorepo

Imagina:

```text
company-monorepo/
│
├── projects/
│   ├── customer-portal/
│   ├── admin-dashboard/
│   └── backend-api/
│
├── packages/
│   ├── ui/
│   ├── validation/
│   ├── eslint-config/
│   └── typescript-config/
│
└── .github/
    └── workflows/
```

Podríamos tener las siguientes responsabilidades:

```text
Git
    ↓
Version Control

pnpm
    ↓
Package Management

pnpm Workspaces
    ↓
Workspace Management

ESLint
    ↓
Linting

TypeScript
    ↓
Type Checking

Build Tools
    ↓
Build

GitHub Actions
    ↓
CI Automation

Nx
    ↓
Task Orchestration
```

Estas herramientas pueden trabajar juntas sin tener exactamente la misma responsabilidad.

---

# 🕸️ Cambios que afectan múltiples proyectos

Imagina que modificamos:

```text
packages/ui/
```

Y esta Library es utilizada por:

```text
customer-portal
admin-dashboard
```

Conceptualmente:

```text
UI Package Changed
        ↓
Dependency Graph
        ↓
Affected Projects
        ↓
Relevant Validation
```

En un Monorepo profesional, herramientas de orquestación pueden ayudar a identificar y ejecutar tareas relacionadas con los proyectos afectados.

Esta será una de las razones por las que estudiaremos Nx.

---

# 📈 Evolución de la madurez técnica

Podemos imaginar diferentes etapas de evolución.

## Stage 1 — Manual Development

```text
Write Code
Run Manually
Deploy Manually
```

## Stage 2 — Basic Standards

```text
Shared Conventions
Declared Dependencies
Basic Documentation
```

## Stage 3 — Automated Quality

```text
Formatting
Linting
Type Checking
Testing
```

## Stage 4 — Continuous Integration

```text
Pull Requests
Automated Checks
Build Validation
```

## Stage 5 — Shared Tooling

```text
Shared Configurations
Reusable Packages
Standard Commands
```

## Stage 6 — Coordinated Development

```text
Workspaces
Dependency Graphs
Task Orchestration
Caching
```

Estas etapas son un modelo educativo, no una clasificación oficial de madurez empresarial.

Una organización puede combinar prácticas de distintas etapas.

---

# 🎯 Nuestro objetivo en Developer Tooling Mastery

Nuestro propósito no es reproducir todos los procesos de una empresa.

Queremos comprender y construir la parte relacionada con las herramientas y estándares de desarrollo.

Por ejemplo:

```text
Developer
    ↓
Development Environment
    ↓
Repository
    ↓
Package Management
    ↓
Code Quality
    ↓
Build
    ↓
Automation
    ↓
Professional Workspace
```

Al finalizar el Mastery, deberíamos poder explicar por qué existe cada herramienta, cómo configurarla y cómo integrarla con otras.

---

# 🧠 Pensar como un Software Engineer

Cuando ingreses a un proyecto profesional, no basta con preguntar:

```text
How do I run the application?
```

También conviene comprender:

```text
How is the repository organized?

How are dependencies managed?

What standards exist?

How are changes reviewed?

What checks run locally?

What checks run in CI?

How are artifacts generated?

How is software delivered?

Who owns the shared tooling?
```

Estas preguntas permiten comprender el proceso de ingeniería, no solamente el código.

---

# ⚠️ Errores comunes

## 1. Pensar que desarrollar software es solamente programar

El desarrollo profesional incluye análisis, diseño, validación, entrega y mantenimiento.

## 2. Pensar que todas las empresas siguen el mismo Workflow

Los procesos varían según el tamaño, contexto y necesidades de la organización.

## 3. Confundir Build con Deployment

Build genera o prepara artefactos; Deployment los instala o pone en funcionamiento en un entorno.

## 4. Pensar que Code Review garantiza ausencia de errores

Code Review es una práctica de revisión, no una garantía absoluta.

## 5. Pensar que CI reemplaza las pruebas locales

Ambas formas de validación pueden complementarse.

## 6. Pensar que un Monorepo obliga a desplegar todo junto

Los proyectos de un Monorepo pueden tener procesos de Deployment independientes.

## 7. Pensar que los estándares deben ser idénticos para todos los proyectos

Los estándares deben equilibrar consistencia y necesidades específicas.

## 8. Pensar que el trabajo termina después del Deployment

El software requiere observación, mantenimiento y evolución.

---

# 🧠 Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Cómo se transforma una necesidad de negocio en software?
2. ¿Qué responsabilidad tiene Product?
3. ¿Para qué sirven los Acceptance Criteria?
4. ¿Por qué es importante el Developer Onboarding?
5. ¿Qué es un Development Workflow?
6. ¿Qué es un Pull Request?
7. ¿Qué objetivo tiene Code Review?
8. ¿Qué diferencia existe entre Local Checks y CI Checks?
9. ¿Qué es Continuous Integration?
10. ¿Qué diferencia existe entre Build, Release y Deployment?
11. ¿Qué responsabilidad tiene Monitoring?
12. ¿Por qué el mantenimiento forma parte del desarrollo de software?
13. ¿Qué son los Engineering Standards?
14. ¿Por qué conviene compartir determinadas configuraciones?
15. ¿Dónde encaja Developer Tooling dentro del ciclo de vida del software?

Si puedes responder estas preguntas con tus propias palabras, tendrás una visión mucho más completa del contexto profesional donde utilizaremos nuestras herramientas.

---

# 💡 Idea clave

El desarrollo de software profesional es un proceso continuo que combina personas, decisiones, código, herramientas y automatización.

```text
Business Need
      ↓
Requirements
      ↓
Design
      ↓
Implementation
      ↓
Validation
      ↓
Integration
      ↓
Delivery
      ↓
Monitoring
      ↓
Maintenance
      ↺
```

Developer Tooling contribuye a que muchas de estas actividades sean más consistentes, reproducibles y eficientes.

**No estudiamos herramientas de manera aislada: las estudiamos porque forman parte de un proceso de ingeniería.**

---

## 🚀 Siguiente paso

Ya comprendemos cómo se desarrolla software dentro de equipos profesionales y dónde encajan las herramientas que estudiaremos.

Ahora vamos a definir con mayor precisión qué construiremos durante Developer Tooling Mastery 2026 y cómo evolucionará nuestro Repository.

👉 [What We Will Build](./12-what-we-will-build.md)