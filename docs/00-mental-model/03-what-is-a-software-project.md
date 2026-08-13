# What Is a Software Project?

Cuando comenzamos a programar es fácil pensar que un proyecto de software es simplemente una carpeta que contiene código.

Por ejemplo:

```text
my-project/
└── app.js
```

Pero a medida que una aplicación crece aparecen muchas otras piezas:

```text
Dependencies
Configuration
Tests
Documentation
Tooling
Automation
Build
Environment
```

Por eso, antes de estudiar Developer Tooling necesitamos construir una definición más completa de **Software Project**.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué es un Software Project.
- Por qué un proyecto no es solamente código.
- Qué diferencia existe entre Source Code y Project.
- Qué tipos de elementos pueden formar parte de un proyecto.
- Por qué aparecen configuraciones y herramientas alrededor del código.
- Cómo evoluciona un proyecto desde algo pequeño hasta una estructura profesional.

---

## 🧠 Empecemos desde cero

Imagina que queremos crear un programa muy sencillo.

Creamos:

```text
hello-world/
└── app.js
```

Y dentro escribimos:

```js
console.log("Hello World");
```

Tenemos código que puede ejecutarse.

En un contexto muy pequeño podríamos llamar informalmente a esta carpeta nuestro "proyecto".

Pero todavía tenemos muy pocas necesidades.

---

## 🧩 Cuando el proyecto empieza a crecer

Ahora imaginemos que nuestro programa necesita utilizar código desarrollado por otras personas.

Aparecen:

```text
Dependencies
```

Después necesitamos definir cómo ejecutar diferentes tareas:

```text
Scripts
```

Después queremos mantener un estilo consistente:

```text
Formatting
```

Queremos detectar problemas:

```text
Linting
```

Queremos comprobar que funciona:

```text
Testing
```

Necesitamos construirlo para producción:

```text
Build
```

Queremos automatizar verificaciones:

```text
CI
```

Nuestro pequeño archivo:

```text
app.js
```

empieza a convertirse en un sistema alrededor del código.

---

# 🏗️ ¿Qué es un Software Project?

Podemos utilizar como modelo mental inicial:

> Un **Software Project** es el conjunto organizado de código, configuración, dependencias, documentación, herramientas y procesos necesarios para desarrollar, ejecutar, mantener y evolucionar software.

Esto significa que:

```text
Software Project
        ≠
Source Code
```

El Source Code es solamente **una parte** del proyecto.

---

# 📦 Anatomía conceptual de un proyecto

Podemos imaginar un proyecto moderno de esta manera:

```text
Software Project
│
├── Source Code
├── Dependencies
├── Configuration
├── Tests
├── Documentation
├── Tooling
├── Build
└── Automation
```

No todos los proyectos necesitan todas estas piezas.

Un proyecto pequeño puede tener solamente algunas.

Un proyecto profesional normalmente incorporará varias conforme aparezcan nuevas necesidades.

---

# 💻 Source Code

El **Source Code** contiene las instrucciones y lógica que escribimos para construir el software.

Por ejemplo:

```text
src/
├── index.js
├── calculator.js
└── utils.js
```

Podríamos tener:

```js
export function sum(a, b) {
  return a + b;
}
```

Esto forma parte del proyecto.

Pero **no representa todo el proyecto**.

---

# 📦 Dependencies

Normalmente no construimos absolutamente todo desde cero.

Utilizamos código desarrollado y distribuido por terceros.

Ese software puede convertirse en una:

```text
Dependency
```

Conceptualmente:

```text
Our Project
     ↓
depends on
     ↓
External Package
```

Más adelante estudiaremos cómo los Package Managers administran estas dependencias.

Por ahora basta comprender que las dependencias forman parte de las necesidades del proyecto.

---

# ⚙️ Configuration

Las herramientas necesitan saber cómo deben comportarse.

Para eso existen configuraciones.

Un proyecto moderno puede terminar teniendo archivos como:

```text
package.json
tsconfig.json
eslint.config.js
vite.config.js
.editorconfig
```

Todavía no necesitamos saber qué hace cada uno.

Lo importante es comprender:

> La configuración describe decisiones sobre cómo debe funcionar el proyecto o alguna de sus herramientas.

---

# 🧪 Tests

Los Tests permiten verificar automáticamente determinados comportamientos del software.

Conceptualmente:

```text
Source Code
     ↓
expected behavior
     ↓
Tests
```

Un proyecto podría tener:

```text
src/
└── calculator.js

tests/
└── calculator.test.js
```

Los Tests también forman parte del proyecto.

---

# 📚 Documentation

Un proyecto también necesita comunicar información a personas.

Por ejemplo:

```text
README.md
CONTRIBUTING.md
docs/
```

La documentación puede explicar:

- Qué hace el proyecto.
- Cómo instalarlo.
- Cómo ejecutarlo.
- Cómo configurarlo.
- Cómo contribuir.
- Cómo está organizado.

El repositorio que estás utilizando ahora mismo ya contiene bastante de esta capa.

---

# 🔧 Tooling

Developer Tooling representa las herramientas que ayudan a construir y mantener el proyecto.

Por ejemplo, eventualmente encontraremos herramientas relacionadas con:

```text
Formatting
Linting
Type Checking
Testing
Building
Automation
Dependency Management
```

Conceptualmente:

```text
Developer
    ↓
uses
    ↓
Tooling
    ↓
to work with
    ↓
Software Project
```

El Tooling ayuda al desarrollo.

No representa necesariamente la lógica de negocio del software.

---

# 🏭 Build

Dependiendo del tipo de proyecto, el código que escribimos puede necesitar transformarse antes de ser distribuido o ejecutado en producción.

Conceptualmente:

```text
Source Code
     ↓
Build Process
     ↓
Production Output
```

Más adelante estudiaremos herramientas como:

```text
Vite
Rsbuild
```

Pero todavía no necesitamos entrar en su funcionamiento.

---

# 🤖 Automation

A medida que un proyecto crece, realizar manualmente todas las tareas se vuelve poco práctico.

Podemos automatizar acciones como:

```text
Install
Format
Lint
Test
Build
Validate
Deploy
```

Por ejemplo:

```text
Developer pushes code
        ↓
CI starts
        ↓
Lint
        ↓
Test
        ↓
Build
```

Esta automatización también forma parte del ecosistema del proyecto.

---

# 🧠 Código vs proyecto

Esta es una de las distinciones más importantes de este documento.

Imagina:

```text
my-project/
├── src/
├── tests/
├── docs/
├── package.json
├── eslint.config.js
├── tsconfig.json
└── README.md
```

Podemos separar conceptualmente:

```text
src/
    ↓
Source Code
```

mientras que:

```text
my-project/
    ↓
Software Project
```

Por tanto:

```text
Source Code
    ⊂
Software Project
```

El código pertenece al proyecto.

El proyecto contiene más cosas que código.

---

# 🧩 Programa, aplicación y proyecto

Estas palabras pueden utilizarse de manera informal como si fueran equivalentes, pero representan ideas diferentes.

## Program

Un Program es un conjunto de instrucciones que una computadora puede ejecutar.

Ejemplo conceptual:

```js
console.log("Hello World");
```

---

## Application

Una Application es software diseñado para cumplir una función para usuarios, sistemas u otros servicios.

Por ejemplo:

```text
Web Application
Backend API
Desktop Application
CLI Application
```

Profundizaremos en Application cuando estudiemos:

```text
05-application-vs-library.md
```

---

## Project

El Project es el entorno organizado utilizado para desarrollar y mantener ese software.

Podemos visualizarlo así:

```text
Software Project
│
├── Application
├── Source Code
├── Tests
├── Dependencies
├── Configuration
├── Tooling
└── Documentation
```

---

# 🗃️ Proyecto vs Repository

También debemos evitar otra confusión frecuente:

```text
Project
```

y:

```text
Repository
```

no significan exactamente lo mismo.

Un Project representa una unidad organizada de desarrollo de software.

Un Repository está relacionado con dónde ese contenido es almacenado y versionado.

Muchas veces tenemos:

```text
Repository
    ↓
contains
    ↓
One Project
```

Por eso pueden parecer equivalentes.

Pero también podemos tener:

```text
Repository
│
├── Project A
├── Project B
└── Project C
```

Profundizaremos en esta diferencia en:

```text
08-what-is-a-repository.md
```

---

# 📈 Cómo evoluciona un proyecto

Un proyecto puede comenzar siendo extremadamente pequeño.

## Stage 1

```text
project/
└── app.js
```

Solo tenemos código.

---

## Stage 2

Aparecen dependencias y metadata:

```text
project/
├── app.js
└── package.json
```

---

## Stage 3

El proyecto empieza a organizarse:

```text
project/
├── src/
├── tests/
├── package.json
└── README.md
```

---

## Stage 4

Aparece Tooling:

```text
project/
├── src/
├── tests/
├── docs/
├── package.json
├── tsconfig.json
├── eslint.config.js
├── prettier.config.js
└── README.md
```

---

## Stage 5

Aparece automatización:

```text
project/
├── src/
├── tests/
├── docs/
├── .github/
├── package.json
├── tsconfig.json
├── eslint.config.js
├── prettier.config.js
└── README.md
```

La estructura creció porque **crecieron las necesidades del proyecto**.

---

# 🔑 Una idea fundamental

Observa esta progresión:

```text
Need
   ↓
Responsibility
   ↓
Tool
   ↓
Configuration
```

Por ejemplo:

```text
Need
Keep code consistently formatted
        ↓
Responsibility
Formatting
        ↓
Tool
Prettier
        ↓
Configuration
prettier.config.js
```

Otro ejemplo:

```text
Need
Detect problematic code
        ↓
Responsibility
Linting
        ↓
Tool
ESLint
        ↓
Configuration
eslint.config.js
```

No queremos pensar:

```text
"This project needs ESLint because professional projects use ESLint."
```

Queremos pensar:

```text
"We have a code-quality problem."

        ↓

"What responsibility addresses it?"

        ↓

"Linting."

        ↓

"What tool could implement that responsibility?"
```

Ese cambio de mentalidad será fundamental durante todo el Mastery.

---

# 🏢 ¿Qué ocurre en proyectos profesionales?

Cuando trabajan múltiples desarrolladores aparecen problemas adicionales.

Por ejemplo:

```text
Developer A
Node 22

Developer B
Node 24
```

o:

```text
Developer A
formats one way

Developer B
formats another way
```

o:

```text
Developer A
runs tests before pushing

Developer B
forgets
```

Entonces aparecen nuevas necesidades:

```text
Consistency
Reproducibility
Automation
Validation
Standardization
```

Y esas necesidades son una de las razones principales por las que Developer Tooling se vuelve tan importante.

---

# 🧩 Nuestro propio repositorio

Ahora observa **Developer Tooling Mastery 2026**.

Actualmente tenemos principalmente:

```text
developer-tooling-mastery-2026/
│
├── README.md
├── ROADMAP.md
├── STUDY-PLAN.md
├── CONTRIBUTING.md
├── CHANGELOG.md
├── LICENSE
├── GLOSSARY.md
├── CHEATSHEET.md
├── FAQ.md
└── docs/
```

En este momento gran parte de nuestro proyecto está formada por:

```text
Documentation
```

Todavía no hemos incorporado:

```text
Runtime Configuration
Package Manager Configuration
Formatting
Linting
Type Checking
Build
Git Hooks
CI
Workspace Configuration
Nx
```

Y eso es intencional.

Cada pieza aparecerá cuando entendamos **qué problema resuelve**.

---

# ⚠️ Error común: copiar la estructura de otro proyecto

Es fácil encontrar un proyecto profesional y pensar:

```text
I need all these files.
```

Entonces copiamos:

```text
package.json
tsconfig.json
eslint.config.js
prettier.config.js
vite.config.js
pnpm-workspace.yaml
nx.json
```

sin comprender por qué existen.

Eso produce proyectos que funcionan, pero que no necesariamente comprendemos.

Durante este Mastery haremos lo contrario:

```text
Understand the problem
        ↓
Introduce the concept
        ↓
Choose the tool
        ↓
Create the configuration
        ↓
Understand the configuration
```

---

# 💼 Modelo profesional

Cuando recibas un proyecto desconocido, no deberías observar únicamente:

```text
src/
```

También deberías comenzar a preguntarte:

```text
How is the project executed?

How are dependencies managed?

How is it configured?

How is code quality enforced?

How is it tested?

How is it built?

How is it automated?

How is it documented?
```

Estas preguntas permiten comprender mucho más rápidamente cómo funciona un proyecto real.

---

# 💡 Idea clave

Un Software Project no es solamente:

```text
Code
```

Es un sistema alrededor del código:

```text
                Software Project
                       │
       ┌───────────────┼───────────────┐
       │               │               │
     Code         Configuration    Dependencies
       │               │               │
     Tests          Tooling        Documentation
       │               │
     Build         Automation
```

No todos los proyectos tendrán exactamente las mismas piezas.

Las piezas aparecen porque existen **necesidades que resolver**.

---

# 🧠 Comprueba tu modelo mental

Antes de continuar, intenta responder sin mirar arriba:

1. ¿Es `src/` todo el Software Project?
2. ¿Qué diferencia existe entre Source Code y Project?
3. ¿Por qué un proyecto necesita Configuration?
4. ¿Por qué aparecen herramientas alrededor del código?
5. ¿Project y Repository significan exactamente lo mismo?
6. ¿Deberíamos agregar una herramienta solamente porque otros proyectos profesionales la utilizan?
7. ¿Qué debería aparecer primero: el problema o la herramienta?

Si puedes explicar estas respuestas con tus propias palabras, tienes el modelo mental que necesitamos para continuar.

---

## 🚀 Siguiente paso

Ya sabemos que un proyecto de software es mucho más que su código fuente.

Ahora veamos cómo se organizan conceptualmente todas esas piezas dentro de un proyecto moderno.

👉 [Modern Project Architecture](./04-modern-project-architecture.md)