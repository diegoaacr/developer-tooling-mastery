# Study Plan

Guía de estudio para aprovechar correctamente **Developer Tooling Mastery 2026** y avanzar desde los fundamentos hasta un nivel profesional.

Este documento no define qué debes aprender. Para eso consulta [`ROADMAP.md`](./ROADMAP.md).

Aquí aprenderás **cómo estudiar, practicar y consolidar cada módulo**.

---

## 🎯 Purpose

El objetivo de este Study Plan es evitar dos problemas comunes al aprender tecnología:

* Consumir demasiada teoría sin practicar.
* Copiar configuraciones o código sin comprender qué hacen.

Developer Tooling Mastery utiliza un enfoque progresivo donde cada concepto debe ser comprendido, utilizado y finalmente integrado dentro de un proyecto.

La meta no es terminar el repositorio rápidamente.

La meta es construir conocimiento que puedas reutilizar en proyectos reales.

---

## 🧠 Learning Method

La metodología principal del repositorio es:

```text
Docs
    ↓
Labs
    ↓
Projects
    ↓
Templates
```

Cada capa tiene una responsabilidad diferente.

### 📚 Docs — Understand

Primero estudia el concepto.

Aquí debes comprender:

* Qué es.
* Por qué existe.
* Qué problema resuelve.
* Cómo funciona.
* Cuándo utilizarlo.
* Cuándo no utilizarlo.
* Cómo se relaciona con otras herramientas.

No intentes memorizar configuraciones.

Busca construir un modelo mental.

---

### 🧪 Labs — Practice

Después aplica el concepto de forma aislada.

Los Labs están diseñados para experimentar con una herramienta o concepto específico sin la complejidad de un proyecto completo.

Aquí debes:

* Ejecutar comandos.
* Crear configuraciones.
* Modificar valores.
* Observar resultados.
* Provocar errores.
* Resolver problemas.

El objetivo es pasar de:

```text
"Entiendo qué es"
```

a:

```text
"Sé utilizarlo"
```

---

### 🚀 Projects — Integrate

Los Projects combinan múltiples conceptos.

Aquí dejarás de utilizar las herramientas de forma aislada y comenzarás a trabajar como lo harías en un proyecto real.

Un Project puede integrar, por ejemplo:

```text
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
+
CI
```

El objetivo es comprender cómo las herramientas trabajan juntas.

---

### 📦 Templates — Reuse

Los Templates representan configuraciones que ya comprendiste y validaste.

Pueden utilizarse posteriormente como punto de partida para nuevos proyectos.

Por ejemplo:

```text
React + TypeScript + Vite

React + TypeScript + Rsbuild

Node.js + TypeScript

pnpm Monorepo
```

Nunca utilices un Template como sustituto del aprendizaje.

Primero comprende cómo se construye.

Después reutilízalo.

---

## 🔄 How to Study a Module

Cada módulo debería seguir aproximadamente este proceso.

### 1. Understand

Lee la documentación en orden.

Intenta comprender el concepto antes de ejecutar comandos.

Pregúntate:

* ¿Qué problema estamos intentando resolver?
* ¿Por qué necesitamos esta herramienta?
* ¿Qué ocurriría si no la utilizáramos?

---

### 2. Configure

Configura la herramienta manualmente.

Evita comenzar copiando configuraciones completas.

Entiende cada archivo y cada opción importante.

---

### 3. Use

Utiliza la herramienta en un escenario pequeño.

Ejecuta comandos.

Modifica configuraciones.

Observa cómo cambia el comportamiento.

---

### 4. Break

Cuando sea seguro hacerlo, provoca errores intencionalmente.

Por ejemplo:

* Elimina una configuración.
* Utiliza una versión incompatible.
* Introduce código que debería fallar.
* Rompe una regla del Linter.
* Modifica una variable de entorno.

Comprender por qué algo falla es una parte importante del aprendizaje.

---

### 5. Fix

Investiga el problema y resuélvelo.

No copies inmediatamente la solución.

Primero intenta interpretar:

* El mensaje de error.
* La herramienta que produjo el error.
* La configuración relacionada.
* La causa probable.

---

### 6. Integrate

Finalmente conecta el concepto con las herramientas aprendidas anteriormente.

El flujo completo es:

```text
Understand
    ↓
Configure
    ↓
Use
    ↓
Break
    ↓
Fix
    ↓
Integrate
```

Este ciclo representa la filosofía práctica de los repositorios Mastery.

---

## ⏱️ Recommended Study Session

No existe una duración obligatoria.

Una sesión puede durar 30 minutos, 1 hora o varias horas dependiendo del concepto.

Una sesión típica puede organizarse así:

```text
Concept
    ↓
Practice
    ↓
Experiment
    ↓
Review
```

### Concept

Estudia una cantidad pequeña de documentación.

Evita consumir muchos temas nuevos en una sola sesión.

### Practice

Ejecuta lo aprendido.

Si existe un Lab relacionado, utilízalo.

### Experiment

Cambia configuraciones y observa qué ocurre.

No te limites al ejemplo proporcionado.

### Review

Antes de terminar la sesión, intenta explicar con tus propias palabras:

* Qué aprendiste.
* Qué problema resuelve.
* Cómo funciona.
* Cómo se relaciona con conceptos anteriores.

Si puedes explicarlo de forma sencilla, probablemente lo estás comprendiendo.

---

## 📈 Progression Levels

El repositorio comienza desde cero, pero progresivamente introduce decisiones de ingeniería más avanzadas.

La evolución aproximada será:

```text
Beginner
    ↓
Intermediate
    ↓
Advanced
    ↓
Professional
```

### 🟢 Beginner

Aprendes qué herramientas existen y cómo utilizarlas.

### 🟡 Intermediate

Aprendes a configurarlas y combinarlas.

### 🔵 Advanced

Comprendes decisiones, alternativas, trade-offs y arquitectura.

### ⚫ Professional

Puedes diseñar y estandarizar el tooling de un proyecto o equipo.

No existe una frontera exacta entre estos niveles.

El progreso ocurre gradualmente durante todo el Mastery.

---

## 🧪 When to Do a Lab

Realiza un Lab cuando necesites convertir un concepto teórico en experiencia práctica.

No todos los archivos de documentación necesitan obligatoriamente un laboratorio independiente.

Un Lab tiene sentido cuando existe algo que:

* Instalar.
* Configurar.
* Ejecutar.
* Comparar.
* Experimentar.
* Romper.
* Resolver.

El Lab debe reforzar el concepto, no repetir la documentación.

---

## 🚀 When to Do a Project

Un Project aparece cuando ya existen suficientes conceptos para construir algo significativo.

No necesitas crear un proyecto después de cada documento.

Los Projects sirven para integrar conocimientos.

Por ejemplo:

```text
Runtime Management
        +
Package Managers
        +
Project Metadata
        +
Project Files
        ↓
Professional Project Foundation
```

Cada nuevo Project puede reutilizar conceptos aprendidos anteriormente.

---

## 📦 How to Use Templates

Los Templates son resultados reutilizables del aprendizaje.

Úsalos cuando ya comprendas las decisiones que contienen.

Un Template debe permitirte comenzar rápidamente un nuevo proyecto sin repetir configuraciones conocidas.

Pero recuerda:

```text
Template ≠ Learning
```

Un Template acelera trabajo que **ya sabes realizar**.

No reemplaza el conocimiento necesario para construirlo.

---

## ✅ When to Move Forward

No necesitas dominar completamente un concepto antes de continuar.

Puedes avanzar cuando seas capaz de:

* Explicar qué problema resuelve.
* Describir cómo funciona a nivel general.
* Utilizarlo en un ejemplo sencillo.
* Reconocer sus archivos o configuraciones principales.
* Resolver problemas básicos relacionados.
* Comprender cómo se conecta con lo aprendido anteriormente.

Si únicamente puedes copiar una configuración sin explicar qué hace, todavía necesitas practicar.

---

## 🔁 Review Strategy

El conocimiento técnico necesita repetición.

No intentes memorizar todo durante la primera lectura.

Utiliza una estrategia progresiva:

```text
Learn
    ↓
Practice
    ↓
Continue
    ↓
Reuse
    ↓
Review
```

Los conceptos importantes aparecerán nuevamente en módulos posteriores.

Por ejemplo:

`package.json` aparecerá inicialmente como metadata del proyecto y posteriormente volverá a utilizarse con:

* Scripts.
* Package Managers.
* Workspaces.
* Build Tools.
* Git Hooks.
* CI.
* Monorepos.

Cada nueva utilización profundizará tu comprensión.

---

## ⚠️ Common Mistakes

Evita estos errores durante el Mastery.

### Memorizar comandos

Los comandos pueden consultarse.

El modelo mental es mucho más importante.

### Copiar configuraciones sin comprenderlas

Una configuración que funciona no significa que comprendas la herramienta.

### Instalar todo inmediatamente

Las herramientas se introducirán progresivamente.

Instala algo cuando entiendas por qué lo necesitas.

### Saltar directamente a los Projects

Los Projects asumen conocimientos adquiridos previamente.

### Buscar la configuración "perfecta"

No existe una configuración universal.

Cada herramienta implica decisiones y trade-offs.

### Avanzar demasiado rápido

Completar archivos no significa aprender.

Prioriza comprensión sobre velocidad.

---

## 🧭 Mastery Mindset

Durante todo el repositorio intenta mantener esta mentalidad:

```text
Understand before copying.

Practice before abstracting.

Break before assuming.

Integrate before standardizing.

Standardize before reusing.
```

En otras palabras:

**comprende → practica → experimenta → integra → estandariza → reutiliza.**

---

## 🏁 Final Recommendation

No estudies Developer Tooling como una colección de herramientas independientes.

Intenta construir progresivamente una imagen completa del sistema.

Al principio verás herramientas separadas:

```text
Node.js

pnpm

VS Code

ESLint

Prettier

Vite

GitHub Actions

Nx
```

Conforme avances comenzarás a ver cómo se conectan:

```text
Development Environment
        ↓
Runtime
        ↓
Package Manager
        ↓
Project Configuration
        ↓
Code Quality
        ↓
Build
        ↓
Automation
        ↓
Monorepo
        ↓
Professional Workspace
```

Cuando puedas comprender y diseñar ese sistema completo, habrás alcanzado el verdadero objetivo de **Developer Tooling Mastery 2026**.
