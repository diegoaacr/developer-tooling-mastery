# Application vs Library

Dentro del desarrollo de software encontraremos constantemente dos conceptos:

```text
Application
Library
```

Ambos contienen código.

Ambos pueden utilizar dependencias.

Ambos pueden tener Tests, Configuration y Tooling.

Pero tienen **propósitos diferentes**.

Comprender esta diferencia será importante cuando posteriormente trabajemos con Packages, Workspaces y Monorepos.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué es una Application.
- Qué es una Library.
- Qué diferencia fundamental existe entre ambas.
- Qué significa ejecutar una Application.
- Qué significa consumir una Library.
- Por qué una Library normalmente expone una API.
- Cómo una Application puede depender de una o varias Libraries.
- Por qué ambas pueden existir dentro del mismo Repository.
- Cómo estos conceptos se relacionarán posteriormente con Packages y Monorepos.

---

# 🧠 Empecemos con el problema

Imagina que queremos construir una aplicación web.

Podríamos tener:

```text
web-app/
└── src/
```

Dentro escribimos todo el código necesario para nuestra aplicación.

Con el tiempo descubrimos que cierta funcionalidad podría ser útil también en otros lugares.

Por ejemplo:

```text
Date Formatting
Validation
Authentication Helpers
UI Components
Mathematical Functions
```

Entonces aparece una pregunta:

> ¿Ese código pertenece exclusivamente a nuestra Application o debería poder ser reutilizado?

Esta pregunta empieza a separar dos responsabilidades:

```text
Application
```

y:

```text
Library
```

---

# 🚀 ¿Qué es una Application?

Una **Application** es software diseñado para ser ejecutado y proporcionar una funcionalidad a usuarios, sistemas u otros servicios.

Podemos pensar:

```text
Application
    ↓
runs
    ↓
provides functionality
```

Algunos ejemplos pueden ser:

```text
Web Application
Backend API
Mobile Application
Desktop Application
CLI Application
```

---

# 🌐 Ejemplo: Web Application

Imagina una tienda online:

```text
ecommerce-web/
```

La aplicación podría permitir:

```text
Browse Products
Add Products to Cart
Login
Checkout
View Orders
```

El usuario interactúa con el software.

Conceptualmente:

```text
User
   ↓
Application
   ↓
Functionality
```

---

# 🖥️ Ejemplo: Backend Application

Una Application no necesita tener necesariamente una interfaz gráfica.

Podemos tener:

```text
orders-api/
```

que expone funcionalidades como:

```text
GET /orders
POST /orders
DELETE /orders/:id
```

Conceptualmente:

```text
Client
   ↓
HTTP Request
   ↓
Backend Application
   ↓
Response
```

Sigue siendo una Application porque existe para ejecutar un comportamiento y ofrecer funcionalidad.

---

# ⌨️ Ejemplo: CLI Application

También podemos tener una herramienta ejecutable desde Terminal:

```bash
my-cli generate component
```

Conceptualmente:

```text
Developer
    ↓
executes command
    ↓
CLI Application
    ↓
performs operation
```

Por tanto, Application no significa solamente:

```text
Website
```

Puede representar diferentes tipos de software ejecutable.

---

# 📚 ¿Qué es una Library?

Una **Library** es código diseñado principalmente para ser consumido por otro software.

Conceptualmente:

```text
Application
    ↓
imports
    ↓
Library
```

La Library proporciona funcionalidades reutilizables.

Por ejemplo:

```text
Validation
Date Utilities
HTTP Utilities
UI Components
Logging
Authentication Helpers
```

---

# 🧮 Ejemplo sencillo

Imagina una Library matemática:

```text
math-library/
└── src/
    └── index.js
```

Podría contener:

```js
export function sum(a, b) {
  return a + b;
}

export function multiply(a, b) {
  return a * b;
}
```

La Library no necesita representar una aplicación completa.

Su objetivo puede ser simplemente proporcionar funcionalidades reutilizables.

Otra Application podría utilizarla:

```js
import { sum } from "math-library";

const total = sum(10, 20);

console.log(total);
```

Conceptualmente:

```text
Application
    ↓
imports
    ↓
Library
    ↓
uses functionality
```

---

# 🔑 Diferencia fundamental

Podemos construir un primer modelo mental:

```text
Application
    ↓
is executed
```

mientras que:

```text
Library
    ↓
is consumed
```

O de manera aún más sencilla:

```text
Application → runs

Library → is used by something else
```

Esta distinción no cubre todos los casos posibles del ecosistema de software, pero es un excelente modelo mental inicial.

---

# 🧩 Application

La pregunta principal de una Application suele ser:

> ¿Qué funcionalidad proporciona cuando se ejecuta?

Por ejemplo:

```text
Storefront
Admin Dashboard
REST API
CLI
```

---

# 📦 Library

La pregunta principal de una Library suele ser:

> ¿Qué funcionalidad proporciona para que otro software pueda utilizarla?

Por ejemplo:

```text
UI Components
Validation Functions
Date Utilities
Logging
Shared Types
```

---

# 🔌 Una Library necesita una interfaz

Si otra parte del software necesita utilizar una Library, debe existir alguna forma de acceder a sus funcionalidades.

Por ejemplo:

```js
export function sum(a, b) {
  return a + b;
}
```

La palabra:

```js
export
```

permite exponer esa funcionalidad para que otro módulo pueda consumirla.

Después:

```js
import { sum } from "./math.js";
```

permite utilizarla.

Conceptualmente:

```text
Library
   ↓
exposes
   ↓
Public API
   ↓
consumed by
   ↓
Application
```

---

# 🧠 ¿Qué significa API aquí?

Cuando escuchamos:

```text
API
```

es común pensar inmediatamente en:

```text
REST API
HTTP
GET
POST
JSON
```

Pero API significa:

```text
Application Programming Interface
```

Una Library también puede proporcionar una API.

Por ejemplo:

```js
import { formatDate } from "@my-company/date-utils";
```

Aquí:

```text
formatDate
```

forma parte de la interfaz que la Library ofrece a sus consumidores.

No necesitamos HTTP.

---

# 🚪 Public API

Una Library puede tener mucho código interno:

```text
library/
└── src/
    ├── internal/
    ├── helpers/
    ├── parser/
    └── index.ts
```

Pero no necesariamente queremos que sus consumidores accedan directamente a todo.

Podemos decidir qué exponer.

Conceptualmente:

```text
Library
│
├── Internal Implementation
│
└── Public API
        ↓
     Consumer
```

Esto nos permite ocultar detalles internos.

---

# 🏠 Internal Implementation vs Public API

Imagina:

```text
math-library/
└── src/
    ├── internal-calculation.ts
    └── index.ts
```

Podríamos tener:

```ts
function internalCalculation() {
  // Internal implementation
}

export function calculateTotal() {
  return internalCalculation();
}
```

Desde fuera queremos consumir:

```ts
calculateTotal()
```

pero no necesariamente:

```ts
internalCalculation()
```

Conceptualmente:

```text
Consumer
    ↓
Public API
    ↓
Internal Implementation
```

Esta separación será muy importante cuando estudiemos Libraries y Packages profesionales.

---

# 🔗 Application + Library

Ahora podemos combinarlas.

Imagina:

```text
ecommerce/
│
├── application/
└── library/
```

La relación podría ser:

```text
E-commerce Application
        ↓
uses
        ↓
Validation Library
```

La Library podría proporcionar:

```text
validateEmail()
validatePassword()
validateAddress()
```

Mientras la Application utiliza esas funcionalidades para construir el producto.

---

# 🧩 Una Application puede utilizar muchas Libraries

Una aplicación moderna normalmente depende de múltiples Libraries.

Conceptualmente:

```text
                    Application
                         │
          ┌──────────────┼──────────────┐
          ↓              ↓              ↓
     UI Library     Validation      Date Utils
          │
          ↓
     More Libraries
```

Esto nos lleva hacia una idea que veremos posteriormente:

```text
Dependency Graph
```

El software empieza a formar relaciones entre diferentes unidades.

---

# 📚 Una Library también puede depender de otra Library

Las relaciones no son solamente:

```text
Application
    ↓
Library
```

También podemos tener:

```text
Application
    ↓
Library A
    ↓
Library B
```

Por ejemplo:

```text
Web Application
      ↓
UI Library
      ↓
Utility Library
```

Esto forma una pequeña cadena de dependencias.

---

# 🕸️ Dependency Graph

Si tenemos:

```text
Web Application
Admin Application
UI Library
Validation Library
Utility Library
```

podrían relacionarse así:

```text
Web Application ────────┐
        │                │
        ↓                ↓
   UI Library      Validation Library
        │                │
        └───────┬────────┘
                ↓
          Utility Library

Admin Application
        │
        ├────────────→ UI Library
        │
        └────────────→ Validation Library
```

Esto empieza a parecer un:

```text
Dependency Graph
```

Más adelante veremos por qué herramientas de Monorepo pueden utilizar este tipo de relaciones.

---

# 🏗️ Application y Library pueden ser Projects

Desde la perspectiva del repositorio podemos tener diferentes Projects.

Por ejemplo:

```text
Repository
│
├── Web Application
├── Admin Application
├── UI Library
└── Utility Library
```

Podemos considerar cada uno una unidad de desarrollo con una responsabilidad determinada.

Conceptualmente:

```text
Project
    ↓
can represent
    ↓
Application or Library
```

Pero todavía necesitamos otro concepto para entender cómo estas unidades pueden distribuirse y relacionarse dentro del ecosistema.

Ese concepto será:

```text
Package
```

---

# 📦 ¿Library significa Package?

No necesariamente.

Esta distinción es importante.

```text
Library
```

describe principalmente **qué tipo de software estamos construyendo y cómo esperamos que sea utilizado**.

Mientras que:

```text
Package
```

está relacionado con una unidad organizada que puede ser administrada, versionada, distribuida o consumida dentro de un ecosistema.

Por ahora recuerda:

```text
Library
    ≠
Package
```

aunque frecuentemente una Library puede distribuirse como Package.

Profundizaremos en esto en el siguiente documento.

---

# 📦 ¿Application puede ser un Package?

Sí, dependiendo del ecosistema y de cómo organicemos el proyecto.

Por eso tampoco debemos construir este modelo:

```text
Application = Project

Library = Package
```

No es una equivalencia correcta.

Tenemos conceptos diferentes que describen diferentes dimensiones del software.

Más adelante conectaremos:

```text
Application
Library
Project
Package
Workspace
Repository
```

---

# 🧠 Diferentes preguntas, diferentes conceptos

Una forma útil de evitar confusiones es observar qué pregunta responde cada concepto.

```text
Application / Library

What kind of software is this?
How is it intended to be used?
```

Mientras que:

```text
Project

What are we organizing and developing?
```

Y más adelante:

```text
Package

How can this unit be managed or consumed?
```

No necesitamos dominar todavía todas las diferencias.

Las construiremos progresivamente.

---

# 🏢 Ejemplo profesional

Imagina que una empresa tiene dos aplicaciones:

```text
Customer Portal
Admin Portal
```

Ambas necesitan:

```text
Buttons
Forms
Modals
Typography
```

Podríamos duplicar esos componentes:

```text
Customer Portal
└── Button

Admin Portal
└── Button
```

Pero ahora tenemos dos implementaciones.

Si queremos compartirlas, podríamos extraer una Library:

```text
                UI Library
               ↙          ↘
Customer Portal          Admin Portal
```

Ahora ambos productos pueden reutilizar componentes comunes.

---

# 🧱 Shared Library

Conceptualmente:

```text
ui-library/
├── Button
├── Input
├── Modal
└── Card
```

y:

```text
customer-portal/
    ↓
uses
    ↓
ui-library
```

junto con:

```text
admin-portal/
    ↓
uses
    ↓
ui-library
```

Esto introduce una nueva ventaja:

```text
Reuse
```

pero también una nueva relación:

```text
Dependency
```

---

# ⚖️ Reutilización también tiene un coste

Crear una Library no es automáticamente mejor que mantener código dentro de una Application.

Una Library compartida introduce responsabilidades adicionales:

```text
Public API
Compatibility
Testing
Documentation
Versioning
Consumers
Maintenance
```

Por eso no debemos pensar:

```text
Reusable code
    ↓
Always create a library
```

Primero debemos evaluar si realmente existe una necesidad de reutilización o separación.

---

# ⚠️ Abstracción prematura

Imagina que tenemos:

```text
Application
└── formatUserName()
```

y esa función solamente se utiliza una vez.

No necesitamos convertir inmediatamente:

```text
formatUserName()
```

en:

```text
@company/user-utils
```

Crear una Library demasiado pronto puede generar:

```text
More structure
More boundaries
More maintenance
More complexity
```

La separación debería responder a una necesidad real.

---

# 🏢 Cuando una Library empieza a tener sentido

Una Library puede tener más sentido cuando existe:

```text
Real Reuse
Clear Responsibility
Multiple Consumers
Stable Abstraction
Independent Testing Need
Clear Ownership
```

Por ejemplo:

```text
Customer Portal
Admin Portal
Mobile Web
        ↓
all need
        ↓
Shared Validation
```

Entonces una:

```text
Validation Library
```

puede convertirse en una unidad razonable.

---

# 🗃️ Dentro de un Repository

Podemos tener un Repository sencillo:

```text
repository/
└── web-application/
```

O eventualmente:

```text
repository/
│
├── applications/
│   ├── customer-portal/
│   └── admin-portal/
│
└── libraries/
    ├── ui/
    ├── validation/
    └── utilities/
```

Todavía no estamos diciendo que esta sea nuestra estructura final.

Es simplemente un modelo conceptual.

---

# 🌐 Dentro de múltiples Repositories

También podríamos separar cada unidad:

```text
customer-portal-repository
admin-portal-repository
ui-library-repository
validation-library-repository
```

Esto nos acerca a una decisión que estudiaremos más adelante:

```text
Monorepo
    vs
Polyrepo
```

Pero primero necesitamos comprender las piezas que pueden vivir dentro de ellos.

---

# 🧩 Nuestro futuro Monorepo

Más adelante nuestro propio repositorio podrá contener diferentes tipos de Projects.

Conceptualmente:

```text
developer-tooling-mastery-2026/
│
├── projects/
│   ├── react-vite-app/
│   ├── react-rsbuild-app/
│   └── node-typescript-app/
│
└── packages/
    ├── shared-config/
    └── shared-library/
```

Algunas unidades serán Applications.

Otras podrán ser Libraries o configuraciones compartidas.

Esto nos permitirá experimentar relaciones reales entre diferentes Projects.

---

# 🔧 ¿Una configuración compartida es una Library?

Aquí aparece una distinción interesante.

Podremos tener algo como:

```text
packages/
└── eslint-config/
```

Eso puede ser un Package compartido.

Pero no necesariamente lo describiríamos como una Library de negocio tradicional.

Esto refuerza una idea:

```text
Package
```

es un concepto más amplio que:

```text
Library
```

y precisamente por eso necesitamos estudiarlo por separado.

---

# 📊 Application vs Library

Podemos resumir nuestro modelo inicial:

| Concept | Application | Library |
|---|---|---|
| Propósito principal | Proporcionar funcionalidad al ejecutarse | Proporcionar funcionalidad a otro software |
| Uso típico | Ejecutarse | Ser consumida |
| Consumidor | Usuario, sistema o servicio | Otra Application o Library |
| Public API | Puede tenerla | Normalmente es fundamental |
| Reutilización | Puede existir | Suele ser una motivación importante |
| Puede tener Dependencies | Sí | Sí |
| Puede tener Tests | Sí | Sí |
| Puede tener Tooling | Sí | Sí |
| Puede ser un Project | Sí | Sí |

La diferencia principal no está en si contiene código.

Ambas contienen código.

La diferencia está principalmente en **cómo esperamos que ese software sea utilizado**.

---

# 🔗 Nuestro modelo mental está creciendo

Hasta ahora tenemos:

```text
Software Project
        ↓
contains multiple responsibilities
        ↓
Modern Project Architecture
```

Ahora agregamos:

```text
Project
    ↓
can represent
    ↓
Application
or
Library
```

Y podemos empezar a visualizar:

```text
Repository
│
├── Application
│       ↓
│     uses
│       ↓
└── Library
```

Todavía nos falta una pieza importante:

```text
Package
```

---

# 💼 Modelo profesional

Cuando encuentres una unidad de código dentro de un proyecto real, intenta preguntarte:

```text
Is this intended to run?

Is this intended to be consumed?

Who consumes it?

What does it expose?

Does it have a Public API?

Does another Project depend on it?

Is this Application-specific?

Is this truly shared?
```

Estas preguntas ayudan a comprender las fronteras del software.

---

# ⚠️ Errores comunes

## 1. Pensar que toda carpeta reutilizable debe ser una Library

No necesariamente.

Una carpeta interna puede simplemente organizar código dentro de una Application.

---

## 2. Pensar que Library y Package son sinónimos

No necesariamente.

Una Library puede distribuirse como Package, pero los conceptos describen cosas diferentes.

---

## 3. Pensar que Application significa solamente Web Application

También podemos tener:

```text
Backend API
CLI
Desktop Application
Mobile Application
Worker
```

entre otros tipos de software ejecutable.

---

## 4. Crear Libraries demasiado pronto

Extraer código compartido tiene costes.

Primero debe existir una razón clara para crear esa frontera.

---

## 5. Exponer toda la implementación de una Library

Una Library debería intentar definir una Public API clara y evitar que sus consumidores dependan innecesariamente de detalles internos.

---

# 🧠 Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Cuál es la diferencia fundamental entre una Application y una Library?
2. ¿Una Application necesita necesariamente una interfaz gráfica?
3. ¿Quién consume normalmente una Library?
4. ¿Qué significa Public API dentro de una Library?
5. ¿API significa necesariamente REST o HTTP?
6. ¿Una Library puede depender de otra Library?
7. ¿Una Application puede utilizar varias Libraries?
8. ¿Library y Package significan exactamente lo mismo?
9. ¿Toda función reutilizable debería convertirse inmediatamente en una Library?
10. ¿Qué nuevos costes aparecen cuando creamos una Library compartida?

Si puedes explicar estas respuestas con tus propias palabras, podemos introducir el siguiente concepto.

---

# 💡 Idea clave

Podemos recordar la diferencia inicial de esta manera:

```text
Application
    ↓
runs to provide functionality
```

mientras que:

```text
Library
    ↓
provides functionality to other software
```

Ambas pueden ser Projects.

Ambas pueden tener:

```text
Source Code
Dependencies
Tests
Configuration
Tooling
Documentation
```

Pero tienen una intención diferente.

---

## 🚀 Siguiente paso

Ya podemos distinguir software diseñado principalmente para ejecutarse de software diseñado principalmente para ser consumido.

Ahora necesitamos entender una unidad fundamental del ecosistema moderno que permitirá organizar, identificar y relacionar estas piezas:

👉 [What Is a Package?](./06-what-is-a-package.md)