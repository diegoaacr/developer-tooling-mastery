# Modern Project Architecture

En el documento anterior aprendimos una idea fundamental:

```text
Software Project
        ≠
Source Code
```

Un proyecto moderno contiene código, pero también puede necesitar dependencias, configuración, herramientas, pruebas, documentación y automatización.

Ahora necesitamos organizar todas esas piezas dentro de un **modelo mental común**.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué entendemos por Modern Project Architecture dentro de este Mastery.
- Qué capas pueden existir alrededor del código.
- Qué responsabilidad tiene cada capa.
- Cómo se relacionan Source Code, Dependencies, Configuration y Tooling.
- Qué diferencia existe entre código del producto y herramientas de desarrollo.
- Por qué la arquitectura de un proyecto crece conforme aparecen nuevas necesidades.
- Cómo reconocer las principales piezas de un proyecto profesional.

El objetivo todavía no es configurar herramientas.

👉 Primero queremos aprender a reconocer las responsabilidades.

---

# 🧠 ¿Qué significa Architecture aquí?

La palabra **Architecture** puede utilizarse en muchos contextos.

Por ejemplo:

```text
Software Architecture
System Architecture
Application Architecture
Infrastructure Architecture
Repository Architecture
Project Architecture
```

En este documento no vamos a estudiar patrones como:

```text
Clean Architecture
Hexagonal Architecture
MVC
Microservices
Event-Driven Architecture
```

Esos conceptos pertenecen principalmente a Software Architecture.

Aquí utilizaremos **Modern Project Architecture** para observar cómo se organiza el entorno completo que permite desarrollar un proyecto moderno.

Nuestro foco será:

```text
Code
Dependencies
Configuration
Tooling
Tests
Build
Documentation
Automation
```

---

# 🏗️ Del código al proyecto

Podemos comenzar con algo extremadamente sencillo:

```text
project/
└── app.js
```

Aquí prácticamente todo nuestro proyecto es código.

Pero conforme aparecen nuevas necesidades, aparecen nuevas responsabilidades.

Por ejemplo:

```text
Need external code
        ↓
Dependencies

Need consistent configuration
        ↓
Configuration

Need code validation
        ↓
Quality Tooling

Need confidence
        ↓
Testing

Need production output
        ↓
Build

Need repeatable processes
        ↓
Automation
```

El proyecto empieza a crecer alrededor del código.

---

# 🧩 Un modelo conceptual

Podemos representar un proyecto moderno de esta manera:

```text
Modern Software Project
│
├── Source Code
├── Dependencies
├── Configuration
├── Tooling
├── Tests
├── Build
├── Documentation
└── Automation
```

Este modelo no significa que todos los proyectos deban tener exactamente estas carpetas.

No significa:

```text
project/
├── source-code/
├── dependencies/
├── configuration/
├── tooling/
├── tests/
├── build/
├── documentation/
└── automation/
```

Estamos hablando de **responsabilidades conceptuales**, no necesariamente de nombres de carpetas.

---

# 1️⃣ Source Code

El Source Code representa el código que implementa el comportamiento principal del software.

Por ejemplo:

```text
src/
├── main.ts
├── components/
├── services/
└── utils/
```

En una aplicación React podríamos encontrar:

```text
src/
├── components/
├── pages/
├── hooks/
├── services/
└── main.tsx
```

En una aplicación Node.js:

```text
src/
├── controllers/
├── services/
├── repositories/
└── server.ts
```

La organización interna del Source Code dependerá del tipo de aplicación y de su arquitectura.

Eso no es el foco de este Mastery.

Nuestro interés es reconocer:

```text
Source Code
        ↓
is one responsibility
        ↓
inside the Project
```

---

# 2️⃣ Dependencies

La mayoría de proyectos modernos utilizan software externo.

Por ejemplo, eventualmente un proyecto podría depender de:

```text
React
TypeScript
ESLint
Vite
Vitest
```

Estas dependencias no tienen todas la misma responsabilidad.

Algunas pueden ser necesarias para ejecutar el software.

Otras solamente para desarrollarlo.

Conceptualmente:

```text
Project
    ↓
depends on
    ↓
External Packages
```

Más adelante aprenderemos a distinguir:

```text
dependencies

vs

devDependencies
```

y estudiaremos cómo herramientas como:

```text
npm
pnpm
Yarn
```

administran estas dependencias.

---

# 3️⃣ Configuration

Las herramientas y proyectos necesitan decisiones explícitas sobre cómo deben comportarse.

Estas decisiones suelen expresarse mediante configuración.

Por ejemplo, más adelante encontraremos archivos como:

```text
package.json
tsconfig.json
eslint.config.js
prettier.config.js
vite.config.ts
.editorconfig
```

Cada uno pertenece a una responsabilidad diferente.

Conceptualmente:

```text
Tool
    +
Configuration
    ↓
Defined Behavior
```

Por ejemplo:

```text
ESLint
    +
eslint.config.js
    ↓
Linting Rules
```

Todavía no necesitamos conocer esas configuraciones.

Lo importante es reconocer que **la configuración es parte de la arquitectura del proyecto**.

---

# 4️⃣ Tooling

Tooling representa las herramientas que ayudan al equipo a desarrollar, analizar, transformar, validar o mantener el proyecto.

Podemos dividir conceptualmente el Tooling en responsabilidades.

Por ejemplo:

```text
Developer Tooling
│
├── Runtime Management
├── Package Management
├── Formatting
├── Linting
├── Type Checking
├── Testing
├── Build
├── Git Hooks
├── CI
└── Monorepo Tooling
```

Más adelante podremos asociar herramientas concretas:

```text
Formatting
    ↓
Prettier / Biome

Linting
    ↓
ESLint / Biome

Build
    ↓
Vite / Rsbuild

Package Management
    ↓
pnpm

Monorepo Orchestration
    ↓
Nx
```

Pero primero debemos comprender la responsabilidad.

---

# 5️⃣ Tests

Los Tests verifican automáticamente comportamientos esperados.

Podemos imaginar:

```text
Source Code
     ↓
implements behavior

Tests
     ↓
verify behavior
```

Dependiendo del proyecto podremos tener diferentes niveles de Testing:

```text
Unit
Integration
Component
End-to-End
```

Este Mastery no pretende enseñar Testing completo.

Nuestro interés será principalmente comprender **cómo Testing se integra dentro del Tooling y los procesos del proyecto**.

---

# 6️⃣ Build

Durante desarrollo podemos trabajar con Source Code que no necesariamente será exactamente lo que distribuiremos.

Puede existir un proceso:

```text
Source Code
     ↓
Build Tool
     ↓
Transformation
     ↓
Production Output
```

Por ejemplo:

```text
src/
    ↓
Build
    ↓
dist/
```

El Build puede involucrar diferentes responsabilidades dependiendo del proyecto:

```text
Bundling
Transpilation
Optimization
Asset Processing
Code Splitting
```

Profundizaremos en estos conceptos cuando lleguemos a:

```text
11-build-tools/
```

---

# 7️⃣ Documentation

La documentación permite que otras personas comprendan el proyecto.

Puede existir documentación para:

```text
Developers
Contributors
Maintainers
Users
Teams
```

Por ejemplo:

```text
README.md
ROADMAP.md
CONTRIBUTING.md
docs/
```

La documentación también forma parte de la mantenibilidad del proyecto.

Un proyecto técnicamente excelente pero imposible de comprender puede convertirse rápidamente en un problema para el equipo.

---

# 8️⃣ Automation

Muchas tareas pueden comenzar siendo manuales.

Por ejemplo:

```text
Developer
    ↓
Format
    ↓
Lint
    ↓
Test
    ↓
Build
```

Pero depender permanentemente de procesos manuales genera inconsistencias.

Entonces aparece Automation:

```text
Event
    ↓
Automated Process
    ↓
Validation
```

Por ejemplo:

```text
git commit
    ↓
Git Hook
    ↓
Validation
```

o:

```text
git push
    ↓
Continuous Integration
    ↓
Lint
    ↓
Test
    ↓
Build
```

La automatización convierte reglas y procesos en comportamientos repetibles.

---

# 🧱 Responsabilidad antes que herramienta

Este será uno de los modelos más importantes de todo el Mastery.

Imagina que vemos:

```text
Prettier
ESLint
Vitest
Vite
pnpm
Nx
```

Si aprendemos solamente los nombres, tenemos una lista de herramientas.

Pero si primero pensamos en responsabilidades:

```text
Package Management
Formatting
Linting
Testing
Building
Monorepo Orchestration
```

entonces podemos establecer:

```text
Responsibility              Possible Tool

Package Management      →   pnpm
Formatting              →   Prettier
Linting                 →   ESLint
Testing                 →   Vitest
Building                →   Vite
Monorepo Orchestration  →   Nx
```

Esto cambia completamente la manera de aprender Tooling.

---

# 🔄 Las herramientas pueden cambiar

Supongamos que hoy utilizamos:

```text
Formatting
    ↓
Prettier
```

Mañana podríamos decidir utilizar:

```text
Formatting
    ↓
Biome
```

La herramienta cambió.

La responsabilidad sigue existiendo:

```text
Formatting
```

Lo mismo puede ocurrir con:

```text
Vite
Rsbuild

ESLint
Biome

npm
pnpm
Yarn
```

Por eso queremos aprender primero los conceptos.

---

# 🧠 Tool vs Responsibility

Podemos resumirlo así:

```text
Responsibility
    ↓
What needs to be solved?
```

mientras que:

```text
Tool
    ↓
How are we solving it?
```

Por ejemplo:

```text
Need
Code consistency
    ↓
Responsibility
Formatting
    ↓
Tool
Prettier
```

No debemos confundir las tres capas.

---

# 🔗 Las piezas no viven aisladas

Un proyecto moderno no contiene herramientas completamente independientes.

Muchas se relacionan.

Por ejemplo:

```text
package.json
     ↓
defines scripts
     ↓
scripts execute tools
     ↓
tools read configuration
     ↓
tools operate on source code
```

Más adelante podremos tener algo conceptualmente parecido a:

```text
Developer
    ↓
pnpm
    ↓
package.json scripts
    ↓
ESLint / TypeScript / Tests / Build
    ↓
Project
```

Y posteriormente:

```text
Git
    ↓
Git Hooks
    ↓
Local Quality Checks
```

junto con:

```text
GitHub
    ↓
CI
    ↓
Remote Quality Checks
```

Todo comienza a formar un sistema.

---

# 🏠 Local vs Project Configuration

También comenzaremos a encontrar otra separación importante.

Algunas herramientas o configuraciones pertenecen principalmente a nuestra computadora:

```text
Developer Machine
│
├── Operating System
├── Terminal
├── Shell
├── Git
└── Editor
```

Mientras otras decisiones pueden vivir dentro del proyecto:

```text
Project
│
├── package.json
├── .editorconfig
├── eslint.config.js
├── tsconfig.json
└── ...
```

Conceptualmente:

```text
Machine Configuration
        ≠
Project Configuration
```

Profundizaremos en esta diferencia en los siguientes módulos.

---

# 👤 Personal vs Shared

También tendremos que distinguir entre:

```text
Personal Preference
```

y:

```text
Project Standard
```

Por ejemplo, un desarrollador puede preferir determinado tema visual en VS Code.

Eso es principalmente personal.

Pero el equipo puede necesitar que todos utilicen:

```text
same formatting rules
same Node version
same linting rules
same build commands
```

Eso pertenece mucho más al proyecto y al equipo.

Uno de los objetivos de Developer Tooling será mover las decisiones importantes hacia configuraciones:

```text
Explicit
Versioned
Shared
Reproducible
```

---

# 🏢 De proyecto individual a proyecto de equipo

Un proyecto personal puede depender de muchas decisiones implícitas:

```text
"It works on my machine."
```

Pero cuando aparecen múltiples desarrolladores:

```text
Developer A
Developer B
Developer C
Developer D
```

necesitamos reducir diferencias.

Queremos acercarnos a:

```text
Shared Repository
        ↓
Shared Configuration
        ↓
Shared Commands
        ↓
Shared Quality Rules
        ↓
Shared Automation
```

Esto permite construir un entorno más consistente.

---

# 🔁 Reproducibility

Una propiedad importante de un proyecto profesional es que otro desarrollador pueda obtener el proyecto y reproducir razonablemente su entorno.

Idealmente:

```text
Clone Repository
        ↓
Install Dependencies
        ↓
Use Expected Runtime
        ↓
Run Defined Commands
        ↓
Same Project Behavior
```

Developer Tooling tiene un papel importante en conseguir esto.

Más adelante estudiaremos mecanismos concretos para acercarnos a ese objetivo.

---

# 📈 La arquitectura aparece progresivamente

No necesitamos comenzar un proyecto pequeño con todas las herramientas imaginables.

Podemos empezar:

```text
Code
```

Después aparece una necesidad:

```text
Code
+
Dependencies
```

Después:

```text
Code
+
Dependencies
+
Configuration
```

Después:

```text
Code
+
Dependencies
+
Configuration
+
Quality Tooling
```

Después:

```text
Code
+
Dependencies
+
Configuration
+
Quality Tooling
+
Testing
+
Build
+
Automation
```

La arquitectura crece porque el proyecto crece.

---

# ⚠️ Más herramientas no significa mejor arquitectura

Un proyecto con:

```text
20 tools
```

no es automáticamente más profesional que uno con:

```text
8 tools
```

Cada herramienta agrega:

```text
Configuration
Maintenance
Dependencies
Learning Curve
Updates
Integration Complexity
```

Por eso siempre debemos preguntarnos:

> ¿Qué problema estamos resolviendo?

Si no existe una necesidad clara, introducir una herramienta puede agregar complejidad sin aportar suficiente valor.

---

# 🧩 Ejemplo conceptual: proyecto frontend

Sin entrar todavía en configuraciones reales, podríamos imaginar:

```text
Frontend Project
│
├── Source Code
│
│   └── React
│
├── Runtime
│
│   └── Node.js
│
├── Package Management
│
│   └── pnpm
│
├── Type Checking
│
│   └── TypeScript
│
├── Formatting
│
│   └── Prettier
│
├── Linting
│
│   └── ESLint
│
├── Testing
│
│   └── Vitest
│
├── Build
│
│   └── Vite
│
└── Automation
    └── GitHub Actions
```

No significa que esta combinación sea obligatoria.

Es simplemente un ejemplo de cómo diferentes responsabilidades pueden convivir dentro de un proyecto.

---

# 🧩 Ejemplo conceptual: proyecto Node.js

También podríamos tener:

```text
Node.js Project
│
├── Source Code
├── Node.js
├── pnpm
├── TypeScript
├── ESLint
├── Prettier
├── Testing
├── Build
└── CI
```

Observa algo importante:

Muchas responsabilidades pueden repetirse entre diferentes tipos de proyectos.

Eso explica por qué Developer Tooling es una disciplina transversal.

---

# 🌐 Más adelante: múltiples proyectos

Hasta ahora estamos imaginando:

```text
Repository
    ↓
Project
```

Pero eventualmente podremos tener:

```text
Repository
│
├── Project A
├── Project B
├── Project C
└── Shared Packages
```

Entonces aparecen nuevos problemas:

```text
Shared Configuration
Shared Dependencies
Dependency Relationships
Task Execution
Caching
Affected Projects
```

Y ahí comenzarán a tener mucho más sentido conceptos como:

```text
Workspace
Monorepo
pnpm Workspaces
Nx
```

Todavía no necesitamos resolverlos.

Primero estamos construyendo el mapa.

---

# 🗺️ Nuestro mapa hasta ahora

Ya podemos conectar los dos primeros conceptos técnicos:

```text
Software Project
        ↓
is more than
        ↓
Source Code
```

y ahora:

```text
Software Project
        ↓
contains multiple responsibilities
        ↓
Modern Project Architecture
```

Podemos representarlo así:

```text
                    Software Project
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
   Source Code        Dependencies       Configuration
        │                  │                  │
      Tests             Tooling          Documentation
        │                  │
      Build           Automation
```

Este modelo crecerá durante todo el Mastery.

---

# 💼 Modelo profesional

Cuando abras un proyecto que no conoces, intenta no mirar únicamente:

```text
src/
```

Empieza a explorar:

```text
What is the source code?

What runtime does it need?

How are dependencies managed?

Where is configuration defined?

How is formatting handled?

How is linting handled?

How is it tested?

How is it built?

What automation exists?

How is the project documented?
```

Estas preguntas permiten reconstruir rápidamente la arquitectura de Tooling del proyecto.

---

# 🧠 Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué significa Modern Project Architecture dentro de este Mastery?
2. ¿Estamos hablando de Clean Architecture o Hexagonal Architecture?
3. ¿Cuál es la diferencia entre una Responsibility y una Tool?
4. ¿Por qué Formatting y Prettier no significan lo mismo?
5. ¿Por qué las herramientas pueden cambiar mientras la responsabilidad permanece?
6. ¿Qué diferencia conceptual existe entre Machine Configuration y Project Configuration?
7. ¿Por qué un equipo intenta convertir decisiones importantes en configuraciones compartidas?
8. ¿Más herramientas significan automáticamente un proyecto más profesional?
9. ¿Por qué la arquitectura de Tooling debería crecer progresivamente?

Si puedes explicar estas ideas con tus propias palabras, ya tienes una base importante para todo lo que construiremos después.

---

# 💡 Idea clave

No pienses primero:

```text
Which tools does this project use?
```

Piensa primero:

```text
What responsibilities does this project have?
```

Después podremos preguntar:

```text
Which tool handles each responsibility?
```

Ese orden nos permitirá aprender herramientas sin volvernos dependientes de herramientas específicas.

---

## 🚀 Siguiente paso

Ya sabemos qué es un Software Project y cómo podemos organizar mentalmente las responsabilidades que aparecen alrededor del código.

Ahora necesitamos distinguir dos tipos fundamentales de software que encontraremos constantemente dentro de proyectos y, más adelante, dentro de nuestro Monorepo:

👉 [Application vs Library](./05-application-vs-library.md)