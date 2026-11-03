# 03 — Editor Configuration vs Project Configuration

## Overview

Durante el desarrollo de software utilizamos configuraciones que afectan tanto a nuestra experiencia de edición como al comportamiento de las herramientas del proyecto.

Aunque ambas pueden coexistir en un mismo repositorio, **Editor Configuration** y **Project Configuration** tienen responsabilidades diferentes:

- **Editor Configuration:** determina cómo el editor presenta, interpreta y facilita el trabajo con el código.
- **Project Configuration:** define cómo se organiza, valida, transforma, ejecuta o construye el proyecto mediante sus herramientas.

Comprender esta separación permite evitar configuraciones duplicadas, reducir dependencias innecesarias del editor y construir proyectos que funcionen de manera consistente en diferentes entornos.

## Core Concepts

### Editor Configuration

La **Editor Configuration** reúne las preferencias y comportamientos que afectan la experiencia de desarrollo dentro de un editor.

En VS Code, estas configuraciones pueden pertenecer a distintos ámbitos, como User Settings o Workspace Settings.

Ejemplos:

| Configuración | Responsabilidad |
|---|---|
| `editor.fontSize` | Controlar el tamaño visual del código |
| `editor.wordWrap` | Ajustar visualmente las líneas largas |
| `editor.tabSize` | Establecer el tamaño de tabulación utilizado durante la edición |
| `editor.formatOnSave` | Solicitar una operación de formateo al guardar |
| `files.exclude` | Ocultar archivos o carpetas en el Explorer |
| `typescript.tsdk` | Indicar qué instalación del SDK de TypeScript utilizar para las funcionalidades de lenguaje de VS Code |

Estas opciones pueden mejorar la productividad y adaptar el editor a las necesidades del desarrollador o del equipo.

Sin embargo, **configurar el editor no equivale necesariamente a configurar las herramientas que procesan el proyecto**.

Por ejemplo, `editor.formatOnSave` permite solicitar el formateo al guardar, pero no define por sí mismo todas las reglas de formato ni garantiza que exista un formateador disponible.

### Project Configuration

La **Project Configuration** comprende los archivos y convenciones que utilizan las herramientas responsables del comportamiento técnico del proyecto.

En el ecosistema JavaScript/TypeScript encontramos ejemplos como:

| Archivo | Herramienta o estándar | Responsabilidad |
|---|---|---|
| `package.json` | Node.js y herramientas del ecosistema npm | Declarar metadatos, scripts, dependencias y otras propiedades del paquete |
| `tsconfig.json` | TypeScript | Definir opciones de compilación, comprobación de tipos y alcance del proyecto |
| `eslint.config.js` | ESLint | Configurar reglas y comportamiento del análisis estático |
| `.prettierrc.json` | Prettier | Definir opciones de formateo |
| `.editorconfig` | EditorConfig | Declarar convenciones básicas de edición compatibles con distintas herramientas |
| `vite.config.ts` | Vite | Configurar el servidor de desarrollo y el proceso de Build |

Estos archivos tienen responsabilidades distintas y no todos son obligatorios.

Tampoco significa que todas las configuraciones del proyecto sean independientes del editor: algunas, como `.editorconfig`, están diseñadas precisamente para que diferentes editores y herramientas compartan determinadas convenciones.

La diferencia importante es **qué herramienta consume la configuración y qué comportamiento controla**.

### Diferencias fundamentales

| Criterio | Editor Configuration | Project Configuration |
|---|---|---|
| Responsabilidad | Experiencia y comportamiento del editor | Comportamiento de las herramientas del proyecto |
| Consumidor principal | Editor y sus integraciones | Runtime, Compiler, Linter, Formatter, Build Tools u otras herramientas |
| Alcance | Usuario, Workspace o contexto de edición | Proyecto, paquete o herramienta correspondiente |
| Portabilidad | Depende del soporte del editor | Depende de la herramienta y su configuración |
| Ejecución en CI | Generalmente no interviene directamente | Puede utilizarse durante validaciones y Builds |
| Ejemplo | `editor.formatOnSave` | Configuración de Prettier |

**Modelo mental:** la configuración del editor determina cómo interactuamos con el código; la configuración del proyecto determina cómo deben trabajar las herramientas que lo procesan.

---

## How They Work Together

### 1. El editor puede utilizar herramientas del proyecto

Consideremos una aplicación React con TypeScript:

```text
react-app/
├── .vscode/
│   └── settings.json
├── src/
│   └── App.tsx
├── package.json
└── tsconfig.json
```

Cada archivo cumple una responsabilidad diferente:

| Archivo | Responsabilidad |
|---|---|
| `.vscode/settings.json` | Personalizar el comportamiento de VS Code para el Workspace |
| `src/App.tsx` | Contener código fuente de la aplicación |
| `package.json` | Declarar información y operaciones del paquete |
| `tsconfig.json` | Establecer opciones que TypeScript utiliza para analizar y compilar el proyecto |

VS Code puede aprovechar información de `tsconfig.json` para proporcionar diagnósticos, navegación y autocompletado de TypeScript.

Sin embargo, el archivo no pertenece a VS Code: también puede ser utilizado por herramientas de TypeScript fuera del editor.

Esta relación es importante:

**El editor puede consumir o aprovechar la configuración del proyecto sin convertirse en el propietario de sus reglas.**

### 2. Una acción del editor puede delegar el trabajo

Supongamos que activamos:

```json
{
  "editor.formatOnSave": true
}
```

Esta configuración indica a VS Code que solicite una operación de formateo al guardar, cuando exista un proveedor compatible.

No especifica necesariamente qué formateador se utilizará ni cuáles serán sus reglas.

Si un proyecto utiliza Prettier, el flujo puede ser:

1. El desarrollador guarda el archivo en VS Code.
2. VS Code solicita el formateo al proveedor configurado.
3. La integración correspondiente utiliza Prettier.
4. Prettier aplica las opciones que le correspondan.
5. VS Code incorpora los cambios resultantes al documento.

Por tanto, debemos distinguir:

- **Trigger:** cuándo se solicita la operación.
- **Tool:** qué herramienta realiza la operación.
- **Rules:** qué configuración determina el resultado.

No todos los formateadores requieren archivos de configuración propios y el comportamiento concreto depende de la integración utilizada.

La configuración detallada de Formatters y las políticas de formateo se estudiarán en el módulo `08-formatting/`.

### 3. El proyecto debe poder validarse fuera del editor

Un proyecto TypeScript puede definir un script como:

```json
{
  "scripts": {
    "typecheck": "tsc --noEmit"
  }
}
```

Cuando la dependencia y configuración necesarias están disponibles, podemos ejecutar:

```bash
npm run typecheck
```

Este comando solicita a TypeScript que compruebe el proyecto sin emitir archivos de salida.

Podemos ejecutarlo desde:

- La terminal integrada de VS Code.
- Una terminal independiente.
- Un proceso de CI.
- Una herramienta de automatización.

El resultado no debería depender de preferencias visuales como `editor.fontSize` o `editor.wordWrap`.

Esto ilustra una propiedad esencial de los proyectos profesionales: **sus validaciones técnicas deben poder ejecutarse sin depender de una interfaz de edición específica**.

---

## Practical Examples

### Caso 1 — Indentación del editor vs reglas de formato

Un equipo desarrolla una aplicación React y acuerda utilizar dos espacios de indentación.

En VS Code podría establecer:

```json
{
  "editor.tabSize": 2,
  "editor.insertSpaces": true
}
```

Estas opciones influyen en cómo el editor introduce indentación.

Si el equipo también utiliza un Formatter, sus reglas deben configurarse de manera compatible con las convenciones del proyecto.

**Límite:** `editor.tabSize` no garantiza por sí mismo que todos los archivos terminen con dos espacios de indentación. Un Formatter puede producir un resultado diferente según sus propias reglas.

### Caso 2 — Diagnósticos del editor vs validación del proyecto

VS Code puede mostrar errores de TypeScript directamente en el archivo:

```typescript
const age: number = "twenty";
```

El servicio de lenguaje identifica una incompatibilidad de tipos.

Sin embargo, visualizar un diagnóstico en el editor y ejecutar una comprobación del proyecto son operaciones diferentes.

| Operación | Responsable |
|---|---|
| Mostrar el error mientras editamos | Integración del editor con el servicio de lenguaje |
| Comprobar tipos mediante `tsc` | Compilador de TypeScript |
| Ejecutar la comprobación en CI | Sistema de automatización que invoca la herramienta |

Las herramientas pueden compartir información y reglas, pero la validación automatizada no debe depender de que un desarrollador tenga VS Code abierto.

### Caso 3 — Navegación del editor vs Build

Un proyecto utiliza Vite para desarrollar una aplicación React.

VS Code permite navegar entre componentes, editar archivos y consultar diagnósticos.

Vite, por su parte, se encarga de tareas como iniciar el servidor de desarrollo y generar el Build según la configuración del proyecto.

Aunque ambas herramientas participen en el mismo flujo de trabajo, sus responsabilidades no son intercambiables.

### ¿Dónde debe vivir una configuración?

| Necesidad | Ubicación o responsable recomendado |
|---|---|
| Cambiar el tamaño de fuente | User Settings |
| Ajustar la visualización del Explorer | User o Workspace Settings, según el contexto |
| Compartir convenciones básicas de indentación | `.editorconfig` cuando exista soporte adecuado |
| Definir reglas de formateo | Configuración del Formatter |
| Definir reglas de análisis estático | Configuración del Linter |
| Establecer opciones de TypeScript | `tsconfig.json` |
| Definir comandos reutilizables del paquete | `package.json` |
| Configurar el proceso de Build | Build Tool correspondiente |

La ubicación adecuada depende de quién debe consumir la configuración y de si la regla debe funcionar fuera del editor.

---

## Hands-on — Separate Editor and Project Responsibilities

**Objetivo:** comprobar que una preferencia del editor no modifica la configuración ni el comportamiento de una herramienta del proyecto.

**Requisitos:** VS Code, Node.js y npm disponibles. No es necesario instalar extensiones.

### 1. Preparar el proyecto

Crea y abre en VS Code una carpeta llamada `configuration-boundaries-lab`.

Dentro, crea estos archivos:

```text
configuration-boundaries-lab/
├── .vscode/
│   └── settings.json
├── index.js
└── package.json
```

**`index.js`**

```javascript
const message = "Editor and Project Configuration";

console.log(message);
```

**`package.json`**

```json
{
  "name": "configuration-boundaries-lab",
  "private": true,
  "scripts": {
    "start": "node index.js"
  }
}
```

**`.vscode/settings.json`**

```json
{
  "editor.fontSize": 18,
  "editor.wordWrap": "on"
}
```

### 2. Observar la configuración del editor

Con el Workspace abierto:

1. Comprueba que VS Code utiliza el tamaño de fuente configurado.
2. Cambia temporalmente `editor.fontSize` de `18` a `14`.
3. Observa que cambia la presentación del código, pero no su contenido.

### 3. Ejecutar el proyecto

Desde la carpeta del ejercicio, ejecuta en la terminal integrada:

```bash
npm run start
```

**Resultado esperado:**

```text
Editor and Project Configuration
```

Ahora ejecuta el mismo comando desde una terminal independiente, situada en la misma carpeta.

El resultado debe ser idéntico.

### 4. Verificar las responsabilidades

| Cambio u operación | Resultado |
|---|---|
| Modificar `editor.fontSize` | Cambia la presentación del código en VS Code |
| Modificar `editor.wordWrap` | Cambia el ajuste visual de líneas |
| Ejecutar `npm run start` | npm invoca el script declarado en `package.json` |
| Ejecutar desde otra terminal | Node.js ejecuta el mismo archivo sin depender de VS Code |

**Resultado de la práctica:** hemos comprobado que las preferencias visuales del editor y los scripts del proyecto pertenecen a responsabilidades diferentes.

Al finalizar, puedes eliminar la carpeta de práctica. No hemos modificado User Settings ni configuraciones globales.

---

## Key Takeaways

- **Editor Configuration** controla la experiencia de edición y las integraciones del editor.
- **Project Configuration** define el comportamiento de las herramientas utilizadas por el proyecto.
- El editor puede consumir configuraciones del proyecto o invocar herramientas externas sin asumir sus responsabilidades.
- Algunas convenciones pueden compartirse entre editores mediante estándares como EditorConfig.
- Las validaciones y operaciones esenciales del proyecto deben poder ejecutarse fuera del editor.
- La ubicación de una configuración debe responder a su propósito y a la herramienta que la consume.

**Modelo mental:** el editor facilita nuestro trabajo; las herramientas del proyecto establecen y ejecutan las reglas técnicas correspondientes.

### 🚀 Siguiente paso

Estudiaremos cómo aplicar esta separación en equipos de desarrollo, definiendo convenciones compartidas sin imponer preferencias individuales.

👉 [04 — Team Editor Consistency](./04-team-editor-consistency.md)