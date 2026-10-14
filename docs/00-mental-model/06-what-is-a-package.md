# What Is a Package?

En el documento anterior aprendimos a distinguir dos conceptos:

```text
Application
    ↓
Software intended to run

Library
    ↓
Software intended to be consumed
```

Pero en el desarrollo moderno necesitamos algo más que escribir aplicaciones y librerías.

Necesitamos poder **organizar, identificar, administrar y compartir unidades de software**.

Aquí aparece un concepto fundamental:

**Package**.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué es un Package.
- Qué problema resuelve.
- Qué diferencia existe entre Package, Library, Application y Project.
- Cómo se identifica un Package dentro del ecosistema JavaScript.
- Qué papel cumple `package.json`.
- Qué significa que un Package tenga dependencias.
- Qué diferencia existe entre Public Package, Private Package e Internal Package.
- Qué es un Package Registry.
- Cómo se relacionan Packages y Package Managers.
- Por qué los Packages serán importantes dentro de nuestro futuro Monorepo.

Todavía no configuraremos ningún Package Manager.

Primero construiremos el modelo mental.

---

# 🧠 Empecemos con el problema

Imagina que desarrollamos una funcionalidad para validar direcciones de correo electrónico.

```js
export function validateEmail(email) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}
```

Inicialmente esta función existe dentro de una aplicación:

```text
customer-portal/
└── src/
    └── validate-email.js
```

Pero ahora tenemos otra aplicación:

```text
admin-portal/
```

que necesita exactamente la misma funcionalidad.

Podríamos copiar el archivo:

```text
customer-portal/
└── src/
    └── validate-email.js

admin-portal/
└── src/
    └── validate-email.js
```

Sin embargo, ahora tenemos dos copias que debemos mantener.

Si corregimos un problema en una implementación, la otra no se actualizará automáticamente.

Surge una necesidad:

> ¿Cómo podemos organizar esta funcionalidad como una unidad que diferentes proyectos puedan consumir?

Una posible solución consiste en convertir esa funcionalidad en una Library organizada como un Package.

---

# 📦 ¿Qué es un Package?

Un **Package** es una unidad organizada de software que puede identificarse y administrarse dentro de un ecosistema de desarrollo.

Dependiendo del ecosistema, puede contener:

- Source Code.
- Metadata.
- Dependencies.
- Configuration.
- Documentation.
- Public API.
- Archivos preparados para distribución.

Un Package puede utilizarse dentro de un mismo Repository o distribuirse para que otros proyectos lo consuman.

Conceptualmente:

```text
Package
│
├── Identity
├── Metadata
├── Code / Resources
├── Dependencies
└── Configuration
```

No todos los Packages necesitan contener exactamente los mismos elementos.

---

# 🔑 El Package como unidad

Una de las ideas más importantes es que un Package establece una unidad reconocible dentro del ecosistema.

Por ejemplo:

```text
@company/validation
```

Este nombre puede identificar un Package que proporciona funcionalidades de validación.

Otro proyecto podría consumirlo:

```js
import { validateEmail } from "@company/validation";
```

Conceptualmente:

```text
Application
    ↓
depends on
    ↓
@company/validation
    ↓
provides
    ↓
Validation Functionality
```

El Package permite establecer una relación explícita entre el consumidor y la funcionalidad proporcionada.

---

# 🧩 Package vs Library

Recordemos:

Una Library describe principalmente software diseñado para ser consumido por otro software.

Un Package describe una unidad que puede identificarse y administrarse dentro de un ecosistema.

Por tanto:

```text
Library
    ≠
Package
```

Pero ambos conceptos pueden relacionarse.

Por ejemplo:

```text
Validation Library
        ↓
organized as
        ↓
@company/validation Package
```

Una Library puede distribuirse mediante un Package.

Sin embargo, no todos los Packages son Libraries tradicionales.

---

# 🚀 ¿Una Application puede ser un Package?

Sí.

En el ecosistema Node.js, una Application también puede organizarse como un Package.

Por ejemplo:

```text
customer-portal/
├── src/
└── package.json
```

Podemos tener:

```json
{
  "name": "customer-portal",
  "version": "1.0.0",
  "private": true
}
```

Esta Application también es un Package desde la perspectiva de la administración del proyecto con las herramientas del ecosistema Node.js.

Por eso sería incorrecto pensar:

```text
Application = Project

Library = Package
```

Los conceptos describen dimensiones diferentes.

---

# 🧠 Diferentes conceptos, diferentes preguntas

Podemos diferenciarlos así:

| Concept | Pregunta principal |
|---|---|
| Application | ¿Qué software se ejecuta para proporcionar funcionalidad? |
| Library | ¿Qué software proporciona funcionalidad reutilizable? |
| Project | ¿Qué unidad de desarrollo estamos organizando? |
| Package | ¿Qué unidad de software estamos identificando y administrando? |
| Repository | ¿Dónde almacenamos y versionamos nuestro trabajo? |

Estas definiciones son modelos mentales iniciales.

En proyectos reales los conceptos pueden superponerse.

---

# 🗂️ ¿Cómo se ve un Package?

En el ecosistema JavaScript y Node.js, un Package puede organizarse de esta manera:

```text
validation/
│
├── src/
│   └── index.js
│
├── package.json
└── README.md
```

El código podría ser:

```js
// src/index.js

export function validateEmail(email) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}
```

Y su metadata:

```json
{
  "name": "@company/validation",
  "version": "1.0.0",
  "type": "module",
  "exports": "./src/index.js"
}
```

Este ejemplo es intencionalmente sencillo.

No representa todavía una configuración profesional completa.

---

# 📄 ¿Qué es `package.json`?

Dentro del ecosistema Node.js, `package.json` es el archivo principal de metadata de un Package.

Permite describir información como:

```text
Name
Version
Description
Dependencies
Scripts
Exports
Package Type
```

Por ejemplo:

```json
{
  "name": "@company/validation",
  "version": "1.0.0",
  "description": "Shared validation utilities",
  "type": "module",
  "exports": "./src/index.js"
}
```

Por ahora no necesitamos comprender cada propiedad.

Estudiaremos `package.json` en profundidad en:

```text
06-project-metadata/
```

Lo importante es entender su responsabilidad:

> `package.json` permite describir un Package y proporcionar información que otras herramientas pueden utilizar.

---

# 🏷️ Package Name

Un Package necesita una identidad que permita referenciarlo.

En el ecosistema npm podemos encontrar nombres como:

```text
react
typescript
eslint
```

También podemos encontrar nombres con Scope:

```text
@company/validation
@company/ui
@company/eslint-config
```

El Scope es la parte que comienza con:

```text
@company/
```

y forma parte del nombre del Package.

Conceptualmente:

```text
@company/validation
    │       │
    │       └── Package Name
    │
    └── Scope
```

Los Scopes ayudan a organizar nombres dentro del ecosistema.

No significan automáticamente que el Package sea privado.

---

# 🔢 Package Version

Los Packages también pueden tener versiones.

Por ejemplo:

```text
@company/validation

1.0.0
1.1.0
2.0.0
```

Esto permite identificar diferentes versiones de una unidad de software.

Conceptualmente:

```text
Package
    +
Version
    ↓
Identifiable Release
```

Más adelante estudiaremos:

```text
Semantic Versioning
```

y comprenderemos cómo se administran los cambios entre versiones.

---

# 🔗 Package Dependencies

Un Package puede necesitar otros Packages para funcionar.

Por ejemplo:

```text
@company/validation
        ↓
depends on
        ↓
external-package
```

También podemos tener:

```text
Application
    ↓
@company/ui
    ↓
@company/utils
```

Estas relaciones forman dependencias entre Packages.

---

# 🕸️ Dependency Graph

Imagina que tenemos:

```text
Web Application
Admin Application
UI Package
Validation Package
Utils Package
```

Podríamos tener:

```text
Web Application ───────→ UI Package
       │                      │
       │                      ↓
       └───────────────→ Utils Package
                              ↑
                              │
Admin Application ─────→ Validation Package
```

Este tipo de relaciones puede representarse mediante un Dependency Graph.

Más adelante aprenderemos por qué es importante dentro de un Monorepo.

---

# 📥 ¿Cómo se obtiene un Package?

Cuando queremos utilizar un Package externo, normalmente necesitamos un mecanismo para obtenerlo y administrar sus dependencias.

Aquí aparecen los:

```text
Package Managers
```

En el ecosistema JavaScript estudiaremos:

```text
npm
pnpm
Yarn
```

Por ejemplo, eventualmente utilizaremos comandos como:

```bash
pnpm add react
```

Este comando permite agregar `react` como dependencia del Package o proyecto actual.

Todavía no necesitamos ejecutarlo.

Lo estudiaremos en:

```text
05-package-managers/
```

---

# 🏪 ¿Qué es un Package Registry?

Un **Package Registry** es un servicio utilizado para almacenar y distribuir Packages.

Por ejemplo, dentro del ecosistema JavaScript existe:

```text
npm Registry
```

Conceptualmente:

```text
Developer
    ↓
Package Manager
    ↓
Package Registry
    ↓
Package
```

Un Package Manager puede consultar un Registry para obtener Packages.

Un ejemplo conocido es:

```text
https://www.npmjs.com/
```

Pero no todos los Packages tienen que publicarse en un Registry.

---

# 🌍 Public Package

Un Public Package es un Package disponible públicamente según las reglas del servicio donde se distribuye.

Por ejemplo:

```text
react
typescript
eslint
```

Estos Packages pueden utilizarse desde proyectos diferentes.

Conceptualmente:

```text
Public Registry
       ↓
Public Package
       ↓
Multiple Consumers
```

---

# 🔒 Private Package

Un Private Package es un Package cuyo acceso o distribución está restringido.

Por ejemplo, una empresa podría tener:

```text
@company/design-system
```

y permitir que solamente determinados equipos puedan obtenerlo desde un Registry privado o con acceso controlado.

Conceptualmente:

```text
Private Registry / Restricted Access
        ↓
Private Package
        ↓
Authorized Consumers
```

Importante:

La propiedad:

```json
{
  "private": true
}
```

en `package.json` significa que las herramientas compatibles con el ecosistema npm deben impedir su publicación mediante el flujo habitual de publicación.

**No significa que el Package haya sido publicado de manera privada.**

Un Package privado en un Registry y un Package con `"private": true` son conceptos distintos.

---

# 🏠 Internal Package

Un Internal Package es un Package utilizado internamente dentro de un proyecto, organización o Workspace.

Por ejemplo:

```text
repository/
│
├── projects/
│   ├── web-app/
│   └── admin-app/
│
└── packages/
    └── validation/
```

Las aplicaciones podrían consumir:

```text
@company/validation
```

sin que necesariamente publiquemos ese Package en un Registry.

Conceptualmente:

```text
Workspace
│
├── Web Application
│       ↓
│   Internal Package
│       ↑
└── Admin Application
```

Este será uno de los conceptos más importantes de nuestro futuro Monorepo.

---

# ⚠️ Public, Private e Internal no son categorías excluyentes

Es importante comprender que estos términos describen características diferentes.

Por ejemplo:

Un Package puede ser:

```text
Internal
+
Not Published
```

Otro puede ser:

```text
Internal to a company
+
Published to a Private Registry
```

Y otro puede ser:

```text
Publicly Published
+
Consumed by many projects
```

Por tanto, no debemos pensar que Public, Private e Internal son siempre tres categorías completamente separadas.

---

# 📦 ¿Un Package necesita publicarse?

No.

Esta es una distinción fundamental.

Podemos tener:

```text
Package
    ↓
Published
```

o:

```text
Package
    ↓
Not Published
```

Ambos pueden ser Packages válidos dentro de su ecosistema.

Por ejemplo, nuestra futura aplicación React podrá tener:

```text
package.json
```

y ser administrada como Package sin publicarse en npm.

---

# 🧩 Package vs Folder

Una carpeta no se convierte automáticamente en un Package simplemente por contener código.

Por ejemplo:

```text
src/
└── utils/
    └── format-date.js
```

Aquí tenemos una carpeta que organiza código.

Pero no necesariamente una unidad administrada como Package.

En cambio:

```text
packages/
└── date-utils/
    ├── package.json
    └── src/
        └── index.js
```

puede representar un Package dentro de un Workspace Node.js.

La diferencia no está solamente en el nombre de la carpeta.

Está en cómo se identifica, declara y administra esa unidad.

---

# 🧱 Package vs Module

Otro término que encontraremos es:

```text
Module
```

En JavaScript, un Module es una unidad de código que puede importar y exportar funcionalidades.

Por ejemplo:

```js
// math.js

export function sum(a, b) {
  return a + b;
}
```

Este archivo puede ser un JavaScript Module.

Pero eso no significa que sea un Package independiente.

Conceptualmente:

```text
Package
│
├── Module A
├── Module B
└── Module C
```

Un Package puede contener múltiples Modules.

No debemos confundir ambos conceptos.

---

# 🏢 Ejemplo profesional

Imagina que una empresa desarrolla:

```text
Customer Portal
Admin Portal
```

Ambas aplicaciones necesitan:

```text
UI Components
Validation
Date Utilities
```

Podemos organizar estas responsabilidades en Packages:

```text
company-workspace/
│
├── projects/
│   ├── customer-portal/
│   └── admin-portal/
│
└── packages/
    ├── ui/
    ├── validation/
    └── date-utils/
```

Podríamos identificarlos como:

```text
@company/ui
@company/validation
@company/date-utils
```

Y las aplicaciones podrían declarar dependencias sobre ellos.

Conceptualmente:

```text
Customer Portal
       │
       ├────→ @company/ui
       │
       └────→ @company/validation

Admin Portal
       │
       ├────→ @company/ui
       │
       └────→ @company/date-utils
```

Esto nos permite organizar funcionalidades compartidas y establecer relaciones explícitas.

---

# 🔧 No todos los Packages contienen lógica de negocio

Hasta ahora utilizamos ejemplos de Libraries.

Pero un Package también puede contener configuraciones reutilizables.

Por ejemplo:

```text
packages/
│
├── eslint-config/
├── typescript-config/
└── shared-utils/
```

Podríamos tener:

```text
@company/eslint-config
```

para compartir reglas de Linting.

O:

```text
@company/typescript-config
```

para compartir configuraciones de TypeScript.

Esto será muy importante en nuestro Mastery porque aprenderemos a construir **Shared Configuration Packages**.

---

# 🧠 Package como frontera

Organizar código en Packages también introduce fronteras.

Por ejemplo:

```text
@company/ui
```

debería tener una responsabilidad comprensible.

Mientras:

```text
@company/validation
```

debería concentrarse en funcionalidades de validación.

Conceptualmente:

```text
Package
    ↓
Clear Responsibility
    ↓
Defined Interface
    ↓
Consumers
```

Pero una frontera también introduce mantenimiento.

Por eso no debemos crear Packages innecesariamente.

---

# ⚠️ No todo necesita ser un Package

Imagina una Application pequeña:

```text
web-app/
└── src/
    ├── components/
    ├── hooks/
    └── utils/
```

No necesitamos convertir inmediatamente cada carpeta en:

```text
@company/components
@company/hooks
@company/utils
```

Esto podría agregar complejidad sin aportar beneficios reales.

Primero debemos evaluar:

```text
Is there real reuse?

Is there a clear responsibility?

Are there multiple consumers?

Does this need an independent boundary?
```

La separación en Packages debe tener una justificación.

---

# 🌐 ¿Cómo se relaciona con Workspaces?

Hasta ahora sabemos que un Package es una unidad identificable y administrable.

Pero imaginemos que tenemos muchos Packages dentro del mismo Repository:

```text
repository/
│
├── projects/
│   ├── web/
│   └── admin/
│
└── packages/
    ├── ui/
    ├── validation/
    └── utils/
```

Aparecen nuevas preguntas:

```text
How do we manage them together?

How do we connect internal packages?

How do we install dependencies?

How do we execute shared commands?

How do we organize the workspace?
```

Estas preguntas nos conducirán al siguiente concepto:

```text
Workspace
```

Todavía no necesitamos configurar ninguno.

---

# 🏗️ Nuestro futuro Developer Tooling Mastery

Más adelante, nuestro repositorio podrá evolucionar hacia algo parecido a:

```text
developer-tooling-mastery-2026/
│
├── docs/
├── labs/
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

Algunas unidades dentro de `projects/` podrán ser Applications administradas como Packages.

Otras unidades dentro de `packages/` podrán ser Libraries o configuraciones compartidas.

Más adelante utilizaremos:

```text
pnpm Workspaces
```

para administrar estas relaciones.

Y posteriormente estudiaremos:

```text
Nx
```

para comprender cómo orquestar tareas y aprovechar el Dependency Graph.

Pero todavía no construiremos esa arquitectura.

Primero necesitamos comprenderla.

---

# 📊 Resumen conceptual

| Concept | Responsabilidad |
|---|---|
| Application | Ejecutar funcionalidades para usuarios o sistemas |
| Library | Proporcionar funcionalidades a otros programas |
| Module | Organizar código con una interfaz de importación/exportación |
| Package | Identificar y administrar una unidad de software |
| `package.json` | Describir metadata y configuración de un Package Node.js |
| Package Manager | Administrar Packages y dependencias |
| Package Registry | Almacenar y distribuir Packages |
| Internal Package | Package utilizado dentro de un entorno u organización |

---

# 💼 Modelo profesional

Cuando observes un proyecto real, intenta identificar:

```text
Which packages exist?

What is each package responsible for?

Which packages are applications?

Which packages provide reusable functionality?

Which packages provide shared configuration?

What dependencies exist between them?

Are packages published or internal?

Who consumes each package?
```

Estas preguntas ayudan a comprender cómo se organiza el software.

---

# ⚠️ Errores comunes

## 1. Pensar que Package y Library son sinónimos

Una Library puede organizarse como Package, pero un Package también puede representar una Application o una configuración compartida.

## 2. Pensar que todo Package debe publicarse en npm

Un Package puede existir y utilizarse internamente sin publicarse.

## 3. Pensar que `"private": true` significa publicación privada

Esta propiedad impide la publicación habitual del Package; no configura automáticamente un Registry privado.

## 4. Pensar que cualquier carpeta es un Package

Una carpeta puede simplemente organizar archivos. Un Package necesita ser reconocido como unidad dentro de su ecosistema.

## 5. Crear un Package para cada función

Demasiadas fronteras pueden agregar complejidad innecesaria.

## 6. Confundir Package con Package Manager

```text
Package
    ↓
Unit of software

Package Manager
    ↓
Tool that manages packages
```

Son conceptos diferentes.

---

# 🧠 Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es un Package?
2. ¿Qué diferencia existe entre Package y Library?
3. ¿Una Application puede ser un Package?
4. ¿Qué responsabilidad tiene `package.json`?
5. ¿Qué diferencia existe entre Package y Module?
6. ¿Un Package necesita publicarse en npm?
7. ¿Qué significa `"private": true`?
8. ¿Qué es un Internal Package?
9. ¿Qué hace un Package Manager?
10. ¿Qué es un Package Registry?
11. ¿Por qué un Package puede depender de otro?
12. ¿Por qué no deberíamos convertir cada carpeta en un Package?

Si puedes explicar estas respuestas con tus propias palabras, ya tenemos una base importante para comprender Workspaces.

---

# 💡 Idea clave

Un Package nos permite tratar una unidad de software como algo identificable y administrable.

```text
Software
    ↓
Organized Unit
    ↓
Package
    ↓
Identity + Metadata + Dependencies
    ↓
Can Be Consumed / Managed
```

Y debemos recordar:

```text
Library ≠ Package

Application ≠ Package

Module ≠ Package

Package ≠ Package Manager
```

Aunque todos estos conceptos pueden relacionarse dentro del mismo proyecto.

---

## 🚀 Siguiente paso

Ahora que entendemos qué es un Package, necesitamos comprender cómo podemos administrar múltiples Packages relacionados dentro de un mismo entorno de desarrollo.

👉 [What Is a Workspace?](./07-what-is-a-workspace.md)