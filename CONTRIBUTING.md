# Contributing

Gracias por tu interés en contribuir a **Developer Tooling Mastery 2026**.

Este repositorio está diseñado como una ruta de aprendizaje progresiva desde fundamentos hasta prácticas profesionales.

Toda contribución debe mantener esta filosofía y respetar la estructura pedagógica del proyecto.

---

## 🎯 Contribution Philosophy

El objetivo no es agregar la mayor cantidad posible de contenido.

El objetivo es mantener contenido:

- Claro.
- Progresivo.
- Práctico.
- Profesional.
- Actualizado.
- Orientado a proyectos reales.
- Comprensible para alguien que empieza desde cero.

Cada contribución debe ayudar a responder:

> ¿Por qué existe este concepto, qué problema resuelve y cómo se utiliza profesionalmente?

---

## 🧠 Learning Philosophy

El repositorio sigue una metodología basada en:

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

No queremos enseñar únicamente comandos o configuraciones.

Queremos construir modelos mentales que permitan comprender cómo funcionan las herramientas y cómo se relacionan entre sí.

---

## 📚 Repository Structure

El contenido está organizado principalmente en:

```text
docs/
labs/
projects/
templates/
packages/
tools/
```

Cada carpeta tiene una responsabilidad diferente.

### `docs/`

Contiene la documentación y los conceptos del Mastery.

Aquí se explica:

- Qué es una herramienta o concepto.
- Por qué existe.
- Qué problema resuelve.
- Cómo funciona.
- Cómo se configura.
- Cuándo utilizarlo.
- Cuándo no utilizarlo.
- Cómo se relaciona con otras herramientas.
- Buenas prácticas.

---

### `labs/`

Contiene prácticas guiadas relacionadas con los conceptos estudiados en `docs/`.

Los Labs deben permitir:

- Ejecutar comandos.
- Crear configuraciones.
- Experimentar.
- Comparar alternativas.
- Provocar errores.
- Resolver problemas.

Un Lab debe reforzar un concepto, no simplemente repetir la documentación.

---

### `projects/`

Contiene proyectos donde se integran múltiples conceptos aprendidos anteriormente.

Los Projects deben representar escenarios progresivamente más cercanos al desarrollo profesional.

Por ejemplo:

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

El objetivo es aprender cómo diferentes herramientas trabajan juntas.

---

### `templates/`

Contiene configuraciones reutilizables que ya han sido estudiadas, construidas y validadas durante el Mastery.

Los Templates deben utilizarse como aceleradores de trabajo.

Nunca deben sustituir el aprendizaje.

---

### `packages/`

Contiene paquetes compartidos utilizados dentro del Monorepo.

Por ejemplo:

```text
packages/
├── eslint-config/
├── prettier-config/
└── typescript-config/
```

Estos paquetes permiten aprender cómo las organizaciones centralizan y reutilizan configuraciones entre múltiples proyectos.

---

### `tools/`

Contiene scripts y herramientas internas utilizadas para automatizar tareas relacionadas con el repositorio.

Debe evitarse colocar aquí lógica que pertenezca directamente a una aplicación o paquete.

---

## 📝 Documentation Standards

La documentación debe mantener una estructura consistente en todo el repositorio.

### Language

La convención general es:

```text
Folders              → English
Files                → English
Code                 → English
Commands             → English
Technical terms      → English when appropriate
Explanations         → Spanish
```

Por ejemplo:

```text
docs/
└── 05-package-managers/
    └── 03-pnpm/
        ├── 01-what-is-pnpm.md
        ├── 02-pnpm-installation.md
        └── 03-pnpm-basic-commands.md
```

El archivo puede llamarse:

```text
01-what-is-pnpm.md
```

pero su contenido estará explicado principalmente en español.

---

## 📄 Markdown Lesson Structure

Cuando tenga sentido, un documento puede seguir esta estructura:

```text
# Title

🎯 Objetivo

🧠 Concepto

🧩 Ejemplo

💡 Idea clave

💼 Uso profesional

⚠️ Errores comunes

🚀 Siguiente paso
```

Esta estructura **no es obligatoria para todos los documentos**.

Un concepto pequeño puede necesitar únicamente:

```text
# Title

🎯 Objetivo

🧠 Concepto

🧩 Ejemplo

🚀 Siguiente paso
```

Mientras que un tema complejo puede necesitar secciones adicionales.

La estructura debe adaptarse al concepto.

No debemos agregar secciones únicamente para cumplir una plantilla.

---

## 🎯 Objectives

Cuando exista una sección `Objetivo`, debe explicar claramente qué debería comprender el estudiante al terminar el documento.

Evita objetivos vagos como:

```text
Aprender pnpm.
```

Prefiere:

```text
Comprender qué problema resuelve pnpm, cómo administra dependencias
y por qué puede utilizarse como Package Manager en proyectos modernos.
```

---

## 🧩 Examples

Los ejemplos deben ser:

- Pequeños.
- Claros.
- Ejecutables cuando sea posible.
- Directamente relacionados con el concepto.
- Fáciles de modificar y experimentar.

Evita introducir complejidad innecesaria.

El ejemplo debe ayudar a comprender el concepto, no distraer del mismo.

---

## 💡 Key Ideas

Cuando exista una idea especialmente importante, puede destacarse mediante una sección:

```md
## 💡 Idea clave
```

Debe utilizarse para reforzar el modelo mental del estudiante.

No debe convertirse simplemente en un resumen repetido del contenido anterior.

---

## 💼 Professional Context

Cuando aporte valor, explica cómo se utiliza el concepto dentro de proyectos y equipos reales.

Puede incluir:

- Decisiones de arquitectura.
- Trabajo en equipo.
- Escalabilidad.
- Mantenibilidad.
- Automatización.
- Trade-offs.
- Diferencias entre proyectos pequeños y grandes.

El objetivo del Mastery no es únicamente aprender herramientas.

También debe enseñar a tomar decisiones.

---

## ⚠️ Common Mistakes

Cuando un concepto tenga errores frecuentes, documenta:

- Qué error suele ocurrir.
- Por qué ocurre.
- Cómo identificarlo.
- Cómo solucionarlo.
- Cómo evitarlo.

Los errores reales forman parte del aprendizaje.

---

## 🚀 Navigation

Cuando exista un orden claro entre documentos, utiliza una sección final:

```md
## 🚀 Siguiente paso

👉 [Next Topic](./02-next-topic.md)
```

Esto permite recorrer el contenido de manera progresiva.

Cuando sea útil también puede agregarse navegación hacia el contenido anterior.

---

## 📂 Folder Organization

No todas las carpetas necesitan la misma estructura interna.

Un módulo sencillo puede contener:

```text
module/
├── 01-topic.md
├── 02-topic.md
└── 03-topic.md
```

Un módulo más complejo puede utilizar:

```text
module/
├── 01-concepts/
├── 02-installation/
├── 03-configuration/
├── 04-best-practices/
└── 05-troubleshooting/
```

Las carpetas deben existir únicamente cuando aporten claridad pedagógica.

Evita crear niveles innecesarios de organización.

---

## 🏷️ Naming Conventions

Utiliza nombres:

- Descriptivos.
- Cortos.
- Consistentes.
- En minúsculas.
- Separados mediante `kebab-case`.

Ejemplo:

```text
what-is-pnpm.md
```

Evita:

```text
WhatIsPNPM.md
what_is_pnpm.md
pnpm1.md
topic.md
```

Cuando exista un orden pedagógico, utiliza prefijos numéricos:

```text
01-what-is-pnpm.md
02-pnpm-installation.md
03-pnpm-basic-commands.md
04-pnpm-workspaces.md
```

---

## 💻 Code Standards

Todo código incluido en documentación, Labs o Projects debe priorizar claridad.

Los ejemplos deben:

- Utilizar nombres descriptivos.
- Evitar abstracciones innecesarias.
- Mostrar únicamente lo necesario.
- Seguir las convenciones del proyecto.
- Ser compatibles con las herramientas utilizadas en el módulo.

Cuando una configuración sea importante, explica sus decisiones principales.

No utilices configuraciones complejas como cajas negras.

---

## 🧪 Lab Standards

Un Lab debe tener un objetivo concreto.

Una estructura recomendada es:

```text
# Lab Title

🎯 Objective

📋 Requirements

🧠 Context

🛠️ Steps

🧪 Experiments

⚠️ Common Problems

✅ Verification

🚀 Challenge
```

No todas las secciones son obligatorias.

Un buen Lab debe permitir al estudiante comprobar que realmente comprendió el concepto.

---

## 🚀 Project Standards

Los Projects deben integrar conocimientos previamente estudiados.

Cada proyecto debe indicar:

- Objetivo.
- Conocimientos necesarios.
- Requisitos.
- Arquitectura.
- Herramientas utilizadas.
- Pasos principales.
- Resultado esperado.

Los Projects deben aumentar progresivamente en complejidad.

No introduzcas una herramienta importante dentro de un Project sin haberla explicado previamente en `docs/` o en el contexto correspondiente.

---

## 📦 Template Standards

Un Template debe representar una configuración reutilizable y validada.

Por ejemplo:

```text
templates/
├── react-typescript-vite/
├── react-typescript-rsbuild/
├── node-typescript/
└── pnpm-monorepo/
```

Cada Template debería indicar:

- Qué contiene.
- Para qué sirve.
- Qué decisiones incluye.
- Qué herramientas utiliza.
- De qué módulos del Mastery proviene.

Los Templates deben mantenerse simples y reutilizables.

---

## 🔗 Relationship Between Content

El contenido debe mantener una relación clara:

```text
Docs
    ↓
Labs
    ↓
Projects
    ↓
Templates
```

Antes de agregar algo nuevo, pregúntate dónde pertenece.

Un concepto pertenece principalmente a `docs/`.

Una experimentación guiada pertenece a `labs/`.

Una integración de varios conceptos pertenece a `projects/`.

Una configuración reutilizable pertenece a `templates/`.

---

## 🔄 Avoid Duplication

Evita explicar completamente el mismo concepto en múltiples lugares.

La fuente principal del conocimiento debe ser `docs/`.

Los Labs deben referenciar ese conocimiento y aplicarlo.

Los Projects deben integrarlo.

Los Templates deben reutilizarlo.

La regla general es:

```text
Explain once.

Practice it.

Integrate it.

Reuse it.
```

---

## 📦 Dependencies

No agregues una dependencia únicamente porque sea popular.

Antes de incorporar una herramienta considera:

- Qué problema resuelve.
- Si realmente es necesaria.
- Si existe una alternativa más simple.
- Su mantenimiento actual.
- Su adopción profesional.
- Su impacto sobre el proyecto.

El repositorio debe enseñar decisiones de tooling, no acumulación de tooling.

---

## 🕰️ Tooling Evolution

El ecosistema de desarrollo cambia constantemente.

Cuando una herramienta o práctica deje de representar una opción moderna:

1. Verifica su estado actual.
2. Documenta la razón del cambio.
3. Propón una alternativa.
4. Actualiza los Labs y Projects afectados.
5. Evita mantener configuraciones obsoletas únicamente por compatibilidad histórica.

El repositorio debe representar prácticas modernas sin perseguir cada nueva tendencia.

---

## 🌿 Git Workflow

Las contribuciones deben realizarse mediante ramas descriptivas.

Ejemplos:

```text
docs/pnpm-workspaces
lab/eslint-configuration
fix/vite-example
refactor/shared-config
```

Mantén los cambios pequeños y relacionados con un único objetivo cuando sea posible.

---

## 💬 Commit Conventions

Utiliza Conventional Commits.

Ejemplos:

```text
docs: add pnpm workspace concepts

feat: add eslint configuration lab

fix: correct vite environment example

refactor: simplify shared tsconfig

chore: update development dependencies
```

Los mensajes deben explicar claramente qué cambió.

---

## 🔀 Pull Requests

Antes de crear un Pull Request:

- Revisa los cambios.
- Ejecuta los checks disponibles.
- Verifica los enlaces Markdown.
- Comprueba que los ejemplos funcionen.
- Evita cambios no relacionados.
- Describe claramente el propósito de la contribución.

Un Pull Request debería responder:

```text
What changed?

Why was it changed?

How was it verified?
```

---

## ✅ Contribution Checklist

Antes de considerar terminada una contribución, verifica:

- El contenido está en la carpeta correcta.
- Los nombres respetan las convenciones.
- La explicación es progresiva.
- Los ejemplos son claros.
- No existe duplicación innecesaria.
- Las configuraciones importantes están explicadas.
- Los enlaces funcionan.
- Los Labs relacionados siguen siendo válidos.
- Los Projects relacionados siguen funcionando.
- El contenido representa prácticas actuales.

---

## 🧠 Final Principle

Toda contribución debe respetar la filosofía central del Mastery:

```text
Understand before copying.

Practice before abstracting.

Break before assuming.

Integrate before standardizing.

Standardize before reusing.
```

El objetivo final no es construir una colección de archivos.

El objetivo es construir una ruta de aprendizaje que permita pasar de:

```text
"I can use this tool."
```

a:

```text
"I understand why this tool exists,
how it works,
how it interacts with the ecosystem,
and when I should or should not use it."
```

Ese es el estándar de **Developer Tooling Mastery 2026**.