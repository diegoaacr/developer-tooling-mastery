# FAQ

Preguntas frecuentes sobre **Developer Tooling Mastery 2026**, su estructura, metodología y forma de aprendizaje.

Este documento crecerá progresivamente conforme aparezcan nuevas preguntas durante el desarrollo del Mastery.

---

## 🎯 Purpose

El objetivo de este FAQ es responder rápidamente dudas frecuentes sobre el repositorio.

No pretende reemplazar:

- `README.md`
- `ROADMAP.md`
- `STUDY-PLAN.md`
- `docs/`

Si una pregunta requiere una explicación técnica completa, deberá existir dentro del módulo correspondiente en `docs/`.

---

## 🧠 About the Mastery

### ¿Qué es Developer Tooling Mastery 2026?

Es una ruta de aprendizaje diseñada para comprender el ecosistema de herramientas que rodea el desarrollo profesional de software.

El objetivo no es enseñar únicamente a instalar herramientas.

Queremos comprender:

- Por qué existen.
- Qué problema resuelven.
- Cómo funcionan.
- Cómo se configuran.
- Cómo interactúan entre ellas.
- Cuándo utilizarlas.
- Cuándo no utilizarlas.
- Cómo se utilizan dentro de proyectos profesionales.

---

### ¿Necesito experiencia previa?

No.

El repositorio está diseñado para comenzar desde cero.

Los primeros módulos construyen progresivamente los modelos mentales necesarios antes de introducir configuraciones más avanzadas.

La progresión general será:

```text
Beginner
    ↓
Intermediate
    ↓
Advanced
    ↓
Professional
```

---

### ¿Este repositorio enseña programación?

No directamente.

Developer Tooling Mastery no pretende enseñar JavaScript, TypeScript, React o Node.js como tecnologías de programación.

Para eso existirán Mastery específicos.

Aquí estudiamos principalmente el ecosistema que permite crear y mantener proyectos profesionales.

---

### Entonces, ¿por qué aparecen JavaScript, TypeScript o Node.js?

Porque muchas herramientas modernas del ecosistema frontend y backend funcionan alrededor de estas tecnologías.

Por ejemplo, utilizaremos Node.js como Runtime para ejecutar diferentes herramientas.

TypeScript también aparecerá desde la perspectiva de Tooling y análisis estático.

Pero aprender el lenguaje TypeScript en profundidad pertenecerá a:

```text
TypeScript Mastery
```

---

## 🗺️ Learning Path

### ¿Por dónde debo empezar?

Comienza por:

```text
README.md
    ↓
ROADMAP.md
    ↓
STUDY-PLAN.md
    ↓
docs/00-mental-model/
```

Después sigue el orden establecido en `ROADMAP.md`.

---

### ¿Debo seguir los módulos en orden?

Sí, especialmente durante la primera vez que recorras el repositorio.

Los módulos están diseñados de forma progresiva.

Conceptos posteriores dependen frecuentemente de conocimientos anteriores.

Por ejemplo:

```text
Runtime
    ↓
Package Manager
    ↓
Project Metadata
    ↓
Formatting / Linting
    ↓
Build Tools
    ↓
Automation
    ↓
Monorepo
```

Cuando ya tengas experiencia, puedes utilizar el repositorio también como referencia y consultar módulos específicos.

---

### ¿Tengo que memorizar todo antes de continuar?

No.

El objetivo es comprender, no memorizar.

Puedes avanzar cuando seas capaz de:

- Explicar el concepto con tus propias palabras.
- Entender qué problema resuelve.
- Utilizarlo en un ejemplo sencillo.
- Reconocer sus configuraciones principales.
- Resolver problemas básicos.

Muchos conceptos se comprenderán todavía mejor cuando vuelvan a aparecer posteriormente.

---

### ¿Cuánto tiempo debería dedicar a cada módulo?

No existe una duración obligatoria.

Algunos conceptos pueden comprenderse rápidamente.

Otros necesitarán:

- Lectura.
- Experimentación.
- Labs.
- Proyectos.
- Repetición.

Prioriza:

```text
Understanding > Speed
```

Completar rápidamente un módulo no significa haberlo aprendido.

---

## 📚 Docs

### ¿Qué contiene `docs/`?

`docs/` contiene la fuente principal de conocimiento del repositorio.

Aquí estudiaremos:

```text
What?
Why?
How?
When?
When not?
Trade-offs?
Best Practices?
```

Los conceptos deben comprenderse primero aquí antes de utilizarlos en escenarios más complejos.

---

### ¿Debo leer todos los archivos Markdown?

Durante el primer recorrido, sí es recomendable seguir el orden definido.

Los nombres numéricos indican la progresión:

```text
01-concept.md
02-concept.md
03-concept.md
```

Cuando ya domines el contenido, podrás utilizar los documentos como referencia independiente.

---

## 🧪 Labs

### ¿Qué diferencia existe entre `docs/` y `labs/`?

`docs/` explica.

`labs/` permite experimentar.

```text
docs/
    ↓
Understand

labs/
    ↓
Practice
```

Un Lab puede pedirte:

- Ejecutar comandos.
- Crear archivos.
- Configurar herramientas.
- Modificar configuraciones.
- Provocar errores.
- Resolver problemas.
- Comparar alternativas.

---

### ¿Cada documento tendrá un Lab?

No necesariamente.

Crearemos un Lab cuando exista algo significativo que practicar.

No queremos crear Labs artificiales únicamente para mantener una relación 1:1 con cada archivo Markdown.

---

### ¿Debo hacer todos los Labs?

Durante el recorrido completo del Mastery, sí es recomendable.

La práctica es una parte fundamental del aprendizaje.

Leer cómo funciona una herramienta no equivale a haberla utilizado.

---

## 🚀 Projects

### ¿Cuál es la diferencia entre un Lab y un Project?

Un Lab normalmente estudia un concepto específico.

Un Project integra múltiples conceptos.

Por ejemplo:

```text
LAB

Configure Prettier
```

frente a:

```text
PROJECT

pnpm
+
TypeScript
+
ESLint
+
Prettier
+
Vite
+
Git Hooks
```

Los Projects se acercan progresivamente a escenarios profesionales.

---

### ¿Habrá un Project después de cada módulo?

No obligatoriamente.

Un Project aparecerá cuando exista suficiente conocimiento acumulado para construir algo significativo.

No crearemos proyectos artificiales únicamente para mantener una numeración.

---

## 📦 Templates

### ¿Qué contiene `templates/`?

Configuraciones reutilizables que ya fueron estudiadas y validadas durante el Mastery.

Por ejemplo, eventualmente podríamos disponer de bases para:

```text
React + TypeScript + Vite

React + TypeScript + Rsbuild

Node.js + TypeScript

pnpm Monorepo
```

---

### ¿Por qué no empezar directamente utilizando Templates?

Porque copiar una configuración no significa comprenderla.

La progresión correcta es:

```text
Understand
    ↓
Build
    ↓
Validate
    ↓
Standardize
    ↓
Reuse
```

Primero aprenderemos a construir las configuraciones.

Después podremos reutilizarlas.

---

## 📦 Packages

### ¿Qué contiene `packages/`?

`packages/` contendrá paquetes compartidos utilizados dentro del propio Monorepo.

Por ejemplo, más adelante podríamos construir configuraciones compartidas para:

```text
ESLint
TypeScript
Formatting
```

Esto permitirá aprender cómo una organización reutiliza configuraciones entre múltiples proyectos.

---

### ¿`packages/` y `templates/` son lo mismo?

No.

Un Package forma parte activa del Workspace y puede ser consumido por otros Packages o Projects.

Un Template es una base preparada para crear o reutilizar una determinada estructura.

Conceptualmente:

```text
Package
    ↓
Used by the Workspace

Template
    ↓
Used to create something
```

---

## 🏗️ Monorepo

### ¿Developer Tooling Mastery será un Monorepo?

Sí.

El repositorio evolucionará progresivamente hacia una arquitectura Monorepo.

Sin embargo, no comenzaremos configurando todo desde el primer día.

Primero aprenderemos los conceptos necesarios.

---

### ¿Por qué utilizaremos un Monorepo?

Porque permitirá integrar dentro de un mismo repositorio:

- Proyectos.
- Packages compartidos.
- Configuraciones.
- Herramientas.
- Labs.
- Templates.

Además, nos permitirá aprender Monorepo Tooling sobre un escenario real.

---

### ¿Qué utilizaremos para administrar el Monorepo?

La base será:

```text
pnpm Workspaces
```

Posteriormente estudiaremos:

```text
Nx
```

para comprender capacidades adicionales relacionadas con:

- Project Graph.
- Task Execution.
- Caching.
- Affected Projects.
- Escalabilidad.

---

### ¿pnpm Workspaces y Nx son lo mismo?

No.

Esta diferencia se estudiará en profundidad posteriormente.

Como modelo mental inicial:

```text
pnpm Workspaces
        ↓
Workspace + Package Management

Nx
        ↓
Monorepo Orchestration + Project Graph + Task Management
```

Nx no sustituye necesariamente al Package Manager.

Ambas herramientas pueden trabajar juntas.

---

### ¿Todos los futuros Mastery serán Monorepos?

La arquitectura Monorepo será nuestra base estándar cuando aporte valor.

Esto facilitará mantener una estructura consistente para futuros repositorios como:

```text
JavaScript Mastery
TypeScript Mastery
React Mastery
Node.js Mastery
```

Sin embargo, también estudiaremos cuándo **no** utilizar un Monorepo.

La arquitectura debe ser una decisión, no una regla ciega.

---

## 🔧 Tooling Decisions

### ¿Por qué pnpm y no únicamente npm?

No asumiremos que pnpm es "mejor" simplemente por utilizarlo.

Primero estudiaremos:

```text
npm
pnpm
Yarn
```

Después comprenderemos sus diferencias y por qué pnpm resulta adecuado para la arquitectura que construiremos.

---

### ¿Utilizaremos Vite?

Sí.

Vite tendrá un módulo dedicado dentro de Build Tools.

No lo trataremos únicamente como un comando para crear proyectos.

Estudiaremos:

- Qué es.
- Qué problema resuelve.
- Dev Server.
- Build.
- Configuración.
- Variables de entorno.
- Buenas prácticas.

---

### ¿Utilizaremos Rsbuild?

Sí.

También estudiaremos Rsbuild como alternativa moderna dentro del ecosistema de Build Tools.

El objetivo no será declarar automáticamente un ganador entre:

```text
Vite
vs
Rsbuild
```

Queremos comprender sus diferencias y cuándo tiene sentido utilizar cada uno.

---

### ¿Estudiaremos Rspack directamente?

No como herramienta principal dentro de este Mastery.

Nuestro foco práctico estará en:

```text
Vite
Rsbuild
```

Podremos mencionar Rspack cuando sea necesario para comprender el ecosistema alrededor de Rsbuild.

---

### ¿Utilizaremos ESLint, Prettier y Biome?

Sí, pero progresivamente.

Queremos comprender primero qué responsabilidades existen:

```text
Formatting
Linting
Type Checking
```

Después estudiaremos las herramientas correspondientes y sus posibles solapamientos.

---

### ¿Por qué estudiar herramientas que hacen cosas parecidas?

Porque parte del nivel profesional consiste en comprender alternativas y trade-offs.

El objetivo no es instalar todas las herramientas simultáneamente.

El objetivo es poder responder:

> ¿Cuál tiene sentido para este proyecto y por qué?

---

## 🔄 Keeping the Repository Updated

### ¿Este FAQ está terminado?

No.

Es un Living Document.

Cuando aparezca una pregunta recurrente durante el Mastery, podremos agregarla aquí.

---

### ¿El Glossary y el Cheatsheet también evolucionarán?

Sí.

Los tres documentos tienen responsabilidades diferentes:

```text
GLOSSARY.md
    ↓
¿Qué significa?

CHEATSHEET.md
    ↓
¿Cómo era ese comando o configuración?

FAQ.md
    ↓
¿Qué pasa con esta duda frecuente?
```

Los tres crecerán junto con el aprendizaje.

---

## 🧠 Final Principle

Si durante el Mastery tienes dudas sobre una herramienta, evita comenzar preguntando:

> ¿Qué configuración debo copiar?

Empieza preguntando:

> ¿Qué problema estoy intentando resolver?

Después:

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

Ese cambio de mentalidad es una de las ideas principales de **Developer Tooling Mastery 2026**.

---

## 🚀 Next Step

Con los documentos principales del repositorio preparados, el siguiente paso es comenzar el aprendizaje real:

👉 [`docs/00-mental-model/`](./docs/00-mental-model/)

Aquí construiremos el modelo mental que utilizaremos durante todo el Mastery.