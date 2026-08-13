# Glossary

Glosario de conceptos utilizados durante **Developer Tooling Mastery 2026**.

Este documento funciona como una referencia rápida para consultar términos técnicos mientras avanzas por el repositorio.

---

## 🎯 Purpose

El objetivo de este glosario es mantener definiciones simples y consistentes de los conceptos utilizados durante el Mastery.

No pretende reemplazar la documentación disponible en `docs/`.

Utilízalo cuando necesites recordar rápidamente qué significa un término.

Para comprender un concepto en profundidad, consulta siempre el módulo correspondiente.

---

## 🧠 How to Use This Glossary

Los términos se encuentran organizados alfabéticamente.

Cada definición intenta responder principalmente:

> ¿Qué significa este concepto dentro del contexto del desarrollo de software?

Las definiciones serán deliberadamente breves.

Ejemplo:

```text
Workspace

Conjunto de proyectos o paquetes administrados como parte de un mismo entorno de desarrollo.
```

La explicación completa sobre Workspaces aparecerá posteriormente dentro de `docs/`.

---

## 🔄 Living Document

Este glosario crecerá progresivamente junto con el repositorio.

No agregaremos todos los términos desde el inicio.

El flujo será:

```text
Learn a concept
        ↓
Understand it
        ↓
Use it
        ↓
Add it to the Glossary
```

De esta manera, el glosario representa conceptos que realmente han sido estudiados durante el Mastery.

---

# 📖 Glossary

## A

### Application

Software diseñado para ser ejecutado y utilizado directamente por usuarios, sistemas u otros servicios.

Una aplicación puede ser, por ejemplo:

- Web Application.
- Backend API.
- CLI Application.
- Desktop Application.

Dentro de un Monorepo pueden existir múltiples Applications.

---

## B

### Build

Proceso mediante el cual el código fuente es transformado en una versión preparada para ejecutarse o distribuirse.

Dependiendo del proyecto, puede incluir tareas como:

- Transpilation.
- Bundling.
- Minification.
- Asset Processing.

---

### Build Tool

Herramienta encargada de facilitar o automatizar partes del proceso de desarrollo y construcción de una aplicación.

Ejemplos que estudiaremos posteriormente:

- Vite.
- Rsbuild.

---

## C

### CLI

**Command-Line Interface.**

Interfaz que permite interactuar con una herramienta mediante comandos ejecutados desde una terminal.

Ejemplo:

```bash
node --version
```

---

### Configuration

Conjunto de valores y reglas que determinan cómo debe comportarse una herramienta o proyecto.

Puede existir a diferentes niveles:

```text
Machine
Project
Workspace
Tool
Environment
```

---

## D

### Dependency

Paquete o componente externo que un proyecto necesita para funcionar.

Las dependencias permiten reutilizar funcionalidades sin implementarlas completamente desde cero.

---

### Developer Environment

Conjunto de herramientas, configuraciones y runtimes utilizados por un desarrollador para construir software.

Puede incluir:

```text
Operating System
Terminal
Shell
Editor
Runtime
Package Manager
Development Tools
```

---

### Developer Tooling

Conjunto de herramientas utilizadas para crear, configurar, analizar, ejecutar, construir, probar y mantener proyectos de software.

Developer Tooling no representa la lógica de negocio de una aplicación.

Representa la infraestructura que permite desarrollarla correctamente.

---

## E

### Editor

Herramienta utilizada principalmente para escribir y modificar código.

Ejemplo:

```text
Visual Studio Code
```

Un editor puede extender sus capacidades mediante configuraciones y extensiones.

---

### Environment

Contexto donde una aplicación o herramienta se ejecuta.

Dependiendo del contexto puede representar:

```text
Development
Testing
Staging
Production
```

---

## I

### IDE

**Integrated Development Environment.**

Entorno de desarrollo que integra múltiples herramientas dentro de una misma aplicación.

Normalmente incluye capacidades como:

- Code Editing.
- Debugging.
- Refactoring.
- Testing.
- Project Navigation.

---

## L

### Library

Conjunto de código reutilizable diseñado para ser utilizado por otras aplicaciones o paquetes.

A diferencia de una Application, una Library normalmente no representa un producto ejecutable por sí mismo.

---

### Local Configuration

Configuración aplicada específicamente a una máquina, usuario o entorno local.

No necesariamente debe compartirse con el resto del equipo.

---

## M

### Monorepo

Arquitectura de repositorio donde múltiples aplicaciones, paquetes o librerías son administrados dentro de un mismo repositorio.

Ejemplo conceptual:

```text
repository/
├── projects/
├── packages/
└── tools/
```

Un Monorepo no significa simplemente colocar muchos proyectos dentro de una carpeta.

También implica definir cómo se relacionan, administran y ejecutan esos proyectos.

---

## N

### Node.js

Runtime de JavaScript que permite ejecutar JavaScript fuera del navegador.

Dentro de este Mastery será uno de los componentes principales sobre los que funcionarán muchas herramientas del ecosistema.

---

## P

### Package

Unidad de software que puede contener código, configuración, dependencias y metadata.

Dentro del ecosistema Node.js normalmente está representada por un directorio que contiene un archivo:

```text
package.json
```

Un Package puede representar, por ejemplo:

- Una Application.
- Una Library.
- Una configuración compartida.
- Una herramienta interna.

---

### Package Manager

Herramienta utilizada para instalar, actualizar y administrar las dependencias de un proyecto.

Durante este Mastery estudiaremos principalmente:

- npm.
- pnpm.
- Yarn.

---

### Polyrepo

Arquitectura donde diferentes aplicaciones, servicios o librerías se mantienen en repositorios independientes.

Ejemplo conceptual:

```text
frontend-repository

backend-repository

shared-library-repository
```

Monorepo y Polyrepo representan estrategias diferentes de organización y tienen distintos trade-offs.

---

### Project

Unidad organizada de trabajo utilizada para construir una aplicación, librería, herramienta u otro componente de software.

Un proyecto normalmente contiene:

```text
Source Code
Configuration
Dependencies
Documentation
Tooling
```

---

### Project Configuration

Configuración almacenada dentro del proyecto y diseñada para controlar cómo deben trabajar sus herramientas.

A diferencia de una configuración personal, normalmente puede compartirse con el equipo mediante el repositorio.

---

## R

### Repository

Espacio donde se almacena y versiona el contenido de un proyecto o conjunto de proyectos.

Normalmente será administrado mediante un sistema de control de versiones como Git.

Un Repository puede contener:

```text
One Project
```

o:

```text
Multiple Projects
```

---

### Runtime

Entorno encargado de ejecutar un programa.

En este Mastery utilizaremos principalmente:

```text
Node.js
```

El Runtime no debe confundirse con el lenguaje.

JavaScript es un lenguaje.

Node.js es uno de los runtimes capaces de ejecutarlo.

---

## S

### Shell

Programa que interpreta comandos y permite interactuar con el sistema operativo.

Ejemplos:

```text
Bash
PowerShell
Zsh
```

---

### Software Project

Conjunto organizado de código, configuración, documentación, dependencias y herramientas utilizado para desarrollar software.

Un proyecto profesional no está formado únicamente por código fuente.

También incluye el ecosistema necesario para construirlo y mantenerlo.

---

## T

### Template

Base reutilizable que contiene una estructura o configuración previamente preparada.

Dentro de este Mastery, los Templates aparecerán después de comprender y construir manualmente las configuraciones que contienen.

La regla será:

```text
Understand
    ↓
Build
    ↓
Validate
    ↓
Reuse as Template
```

---

### Terminal

Aplicación que proporciona una interfaz para interactuar con un Shell.

Aunque frecuentemente se utilizan como sinónimos, Terminal y Shell representan conceptos diferentes.

---

### Tooling

Forma abreviada de referirse al conjunto de herramientas utilizadas alrededor del proceso de desarrollo.

Puede incluir:

```text
Formatters
Linters
Build Tools
Package Managers
Testing Tools
CI Tools
Monorepo Tools
```

---

## W

### Workspace

Entorno que agrupa y administra uno o múltiples proyectos o paquetes relacionados.

En el contexto de Package Managers, un Workspace permite trabajar con múltiples Packages desde una estructura común.

Posteriormente estudiaremos esta idea en profundidad utilizando:

```text
pnpm Workspaces
```

---

### Workspace Configuration

Configuración compartida que afecta a múltiples proyectos o paquetes dentro de un mismo Workspace.

Permite reducir duplicación y mantener estándares comunes.

---

## ➕ Adding New Terms

Cuando aparezca un nuevo concepto importante durante el Mastery:

1. Estudia primero el concepto dentro de `docs/`.
2. Utilízalo cuando corresponda en un Lab.
3. Comprueba que entiendes su significado.
4. Agrega una definición breve a este archivo.
5. Evita duplicar aquí toda la explicación disponible en `docs/`.

---

## 🧠 Key Principle

El Glossary debe responder:

> ¿Qué significa?

La documentación debe responder:

> ¿Cómo funciona, por qué existe, cuándo se utiliza y cómo se aplica?

Por eso las definiciones de este archivo deben mantenerse simples.

---

## 🚀 Next Step

Continúa utilizando el [`ROADMAP.md`](./ROADMAP.md) como guía principal del aprendizaje.

Este glosario crecerá progresivamente mientras avances por **Developer Tooling Mastery 2026**.