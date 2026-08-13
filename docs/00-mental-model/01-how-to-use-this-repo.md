# How to Use This Repo

Este repositorio está diseñado para aprender **Developer Tooling desde cero hasta un nivel profesional** mediante una combinación progresiva de teoría, práctica e integración.

No está pensado para ser leído como un libro tradicional de principio a fin.

Está pensado para **estudiar, experimentar, construir y reutilizar**.

---

## 🎯 Objetivo

Al terminar este documento deberías entender:

- Cómo recorrer el repositorio.
- Qué responsabilidad tiene cada carpeta.
- Cómo utilizar `docs/`, `labs/`, `projects/` y `templates/`.
- Cuándo debes practicar un concepto.
- Cuándo debes avanzar al siguiente módulo.
- Cómo utilizar los documentos de referencia de la raíz.
- Cómo evolucionará el propio repositorio mientras aprendes.

---

## 🧠 No leas solamente

Uno de los errores más comunes al aprender herramientas de desarrollo es consumir mucha documentación sin utilizarlas realmente.

Puedes leer sobre:

```text
Node.js
pnpm
ESLint
Prettier
Vite
CI
Monorepos
Nx
```

y aun así tener dificultades cuando necesitas configurar un proyecto desde cero.

Por eso este repositorio combina diferentes formas de aprendizaje.

La idea general es:

```text
Understand
    ↓
Practice
    ↓
Experiment
    ↓
Integrate
    ↓
Reuse
```

---

# 📚 `docs/`

`docs/` contiene la ruta principal de aprendizaje.

Aquí se explican los conceptos y herramientas progresivamente.

Ejemplo:

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

Cada módulo introduce una nueva capa de conocimiento.

---

## ¿Qué encontrarás en `docs/`?

Dependiendo del tema, estudiaremos preguntas como:

```text
What is it?
Why does it exist?
What problem does it solve?
How does it work?
How is it configured?
When should I use it?
When should I not use it?
What are the trade-offs?
```

No todos los documentos necesitarán responder todas estas preguntas.

La profundidad dependerá del concepto.

---

## 📄 Un concepto puede ser simple

Algunos conceptos pueden explicarse directamente:

```text
module/
├── 01-concept.md
├── 02-concept.md
└── 03-concept.md
```

No necesitamos crear carpetas innecesarias.

---

## 📂 Un concepto también puede crecer

Cuando una herramienta requiera mayor profundidad podremos organizarla, por ejemplo:

```text
package-managers/
│
├── concepts/
├── npm/
├── pnpm/
├── yarn/
└── configuration/
```

La estructura debe ayudar a comprender el contenido.

No debe agregar complejidad artificial.

---

# 🧪 `labs/`

Los Labs son espacios de experimentación guiada.

Después de comprender un concepto podremos utilizar un Lab para comprobar cómo funciona realmente.

La progresión será:

```text
docs/
    ↓
Understand

labs/
    ↓
Experiment
```

---

## ¿Qué podemos hacer en un Lab?

Un Lab puede pedirte:

- Ejecutar comandos.
- Crear archivos.
- Instalar herramientas.
- Modificar configuraciones.
- Comparar comportamientos.
- Provocar errores.
- Analizar resultados.
- Resolver problemas.

La idea no es simplemente seguir instrucciones.

Queremos observar qué ocurre.

---

## 🔥 Romper cosas también es aprender

En algunos Labs modificaremos deliberadamente configuraciones para observar qué sucede.

Por ejemplo:

```text
Working Configuration
        ↓
Change Something
        ↓
Error
        ↓
Investigate
        ↓
Understand
        ↓
Fix
```

Comprender por qué algo falla suele enseñar más que copiar una configuración que funciona.

---

## ¿Cada documento tendrá un Lab?

No.

No mantendremos una relación artificial:

```text
1 document = 1 lab
```

Algunos conceptos son suficientemente claros con explicación y ejemplos.

Crearemos Labs cuando exista algo útil que experimentar.

---

# 🚀 `projects/`

Los Projects son diferentes a los Labs.

Un Lab normalmente se concentra en uno o pocos conceptos.

Un Project integra conocimientos acumulados.

Por ejemplo:

```text
LAB

Learn how ESLint configuration works.
```

Más adelante:

```text
PROJECT

Node.js
    +
pnpm
    +
TypeScript
    +
ESLint
    +
Prettier
    +
Testing
    +
Build
```

Aquí empezamos a experimentar cómo las herramientas interactúan dentro de un proyecto real.

---

## Los Projects serán progresivos

No comenzaremos directamente construyendo una arquitectura compleja.

La dificultad crecerá con nosotros:

```text
Simple Project
      ↓
Configured Project
      ↓
Professional Project
      ↓
Multiple Projects
      ↓
Workspace
      ↓
Monorepo
      ↓
Professional Monorepo
```

Cada Project debería utilizar principalmente conocimientos que ya hemos estudiado.

---

# 📦 `templates/`

Los Templates aparecen después del aprendizaje.

Un Template contiene una configuración reutilizable que ya entendemos.

Por ejemplo, eventualmente podríamos tener:

```text
templates/
├── react-typescript-vite/
├── react-typescript-rsbuild/
├── node-typescript/
└── pnpm-monorepo/
```

Pero no comenzaremos copiando estos Templates.

---

## La regla de los Templates

Seguiremos esta progresión:

```text
Understand
    ↓
Configure manually
    ↓
Practice
    ↓
Validate
    ↓
Standardize
    ↓
Create Template
    ↓
Reuse
```

Un Template debe representar conocimiento adquirido.

No debe ocultar conocimiento que todavía no tenemos.

---

# 📦 `packages/`

Cuando nuestro repositorio evolucione hacia un Monorepo, necesitaremos compartir determinadas piezas entre diferentes proyectos.

Ahí aparecerá `packages/`.

Conceptualmente podremos llegar a tener algo parecido a:

```text
packages/
├── eslint-config/
├── typescript-config/
└── shared-utils/
```

Estos serán Packages reales utilizados por otros proyectos del Workspace.

No confundas:

```text
packages/
```

con:

```text
templates/
```

La diferencia conceptual inicial es:

```text
Package
    ↓
forma parte del Workspace
    ↓
puede ser consumido por otros Packages/Projects
```

mientras que:

```text
Template
    ↓
sirve como base reutilizable
    ↓
para crear o configurar algo
```

Profundizaremos en estas diferencias más adelante.

---

# 🔧 `tools/`

`tools/` contendrá scripts y herramientas internas relacionadas con el mantenimiento o automatización del propio repositorio.

Por ejemplo, eventualmente podrían existir scripts para:

```text
Validation
Generation
Automation
Repository Maintenance
```

No agregaremos herramientas aquí hasta que realmente aparezca la necesidad.

---

# 🗂️ Archivos de referencia

En la raíz del repositorio existen documentos con responsabilidades diferentes.

```text
README.md
ROADMAP.md
STUDY-PLAN.md
GLOSSARY.md
CHEATSHEET.md
FAQ.md
CONTRIBUTING.md
CHANGELOG.md
LICENSE
```

No necesitas leerlos constantemente.

Cada uno tiene una función específica.

---

## `README.md`

Responde principalmente:

> ¿Qué es este repositorio?

Es el punto de entrada general al Mastery.

---

## `ROADMAP.md`

Responde:

> ¿Qué voy a aprender y en qué orden?

Utilízalo para comprender tu posición dentro de la ruta completa.

---

## `STUDY-PLAN.md`

Responde:

> ¿Cómo debería estudiar este contenido?

Define la metodología y ritmo recomendado.

---

## `GLOSSARY.md`

Responde:

> ¿Qué significa este término?

Utilízalo como referencia rápida cuando olvides un concepto.

---

## `CHEATSHEET.md`

Responde:

> ¿Cómo era ese comando, configuración o flujo que ya estudié?

Crecerá progresivamente conforme aprendamos nuevas herramientas.

---

## `FAQ.md`

Responde preguntas frecuentes que aparecen durante el aprendizaje.

---

## `CONTRIBUTING.md`

Define los estándares utilizados para mantener y extender el repositorio.

También sirve como referencia para comprender las convenciones internas del Mastery.

---

## `CHANGELOG.md`

Registra cambios relevantes durante la evolución del proyecto.

---

# 🧭 Cómo estudiar un módulo

Cuando llegues a un nuevo módulo dentro de `docs/`, utiliza aproximadamente este flujo:

```text
1. Read the module README
        ↓
2. Study the concepts in order
        ↓
3. Run the examples
        ↓
4. Complete Labs when available
        ↓
5. Experiment
        ↓
6. Continue studying
        ↓
7. Build Projects when available
        ↓
8. Review
```

No todos los módulos tendrán exactamente los mismos pasos.

---

# 🧠 ¿Cuándo puedo avanzar?

No necesitas memorizar cada detalle.

Puedes avanzar cuando puedas responder razonablemente:

```text
What is it?

Why does it exist?

What problem does it solve?

How does it fit into the project?
```

Y, cuando sea una herramienta práctica:

```text
Can I use it?

Can I configure the basics?

Can I recognize common problems?
```

---

## Ejemplo

Después de estudiar un Package Manager no queremos únicamente saber:

```bash
pnpm install
```

Queremos entender:

```text
Why do Package Managers exist?

What is a dependency?

What is node_modules?

What is a lockfile?

What does install actually do?

Why are reproducible installs important?
```

El comando es solamente la superficie.

---

# 🔍 No copies configurations blindly

Durante el Mastery aparecerán archivos como:

```text
package.json
tsconfig.json
eslint.config.js
prettier.config.js
pnpm-workspace.yaml
nx.json
```

Evita copiar configuraciones sin comprenderlas.

Cuando agreguemos una configuración importante al proyecto deberíamos poder explicar:

```text
Why does this file exist?

Why is this option here?

What happens if we remove it?

Who consumes this configuration?
```

---

# 🏗️ El repositorio evolucionará contigo

Al comenzar, este repositorio contiene principalmente documentación.

Conceptualmente:

```text
Repository
    ↓
Documentation
```

No vamos a crear toda la infraestructura profesional desde el primer día.

La construiremos progresivamente.

```text
Documentation
      ↓
Development Environment
      ↓
Runtime
      ↓
Package Manager
      ↓
Project Metadata
      ↓
Project Tooling
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
      ↓
Professional Workspace
```

Cada nueva configuración debería aparecer porque ya entendemos el problema que resuelve.

---

# 🔄 El ciclo de aprendizaje

Durante todo el Mastery repetiremos un patrón parecido:

```text
Problem
    ↓
Concept
    ↓
Tool
    ↓
Configuration
    ↓
Lab
    ↓
Project
    ↓
Professional Practice
```

Con suficiente experiencia, algunas configuraciones podrán convertirse en:

```text
Template
```

o:

```text
Shared Package
```

---

# ⚠️ Errores que queremos evitar

Evita convertir el Mastery en:

```text
Copy
↓
Paste
↓
Run
↓
Works
↓
Next
```

Que algo funcione no significa necesariamente que lo entiendas.

También evita intentar aprender todas las herramientas simultáneamente.

Seguiremos una progresión.

---

# 💡 Idea clave

Este repositorio no es únicamente algo que vas a leer.

Es un entorno que vas a:

```text
Read
Build
Configure
Break
Fix
Refactor
Automate
Scale
```

Y mientras haces eso, el propio repositorio evolucionará desde una colección de documentación hasta un Workspace profesional.

---

## 🚀 Siguiente paso

Ahora que sabemos cómo utilizar el repositorio, veamos la ruta conceptual que seguiremos.

👉 [Learning Path](./02-learning-path.md)