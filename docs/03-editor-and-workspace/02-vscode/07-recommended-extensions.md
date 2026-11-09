# 07 — Recommended Extensions

## Overview

Un entorno profesional de Visual Studio Code no necesita una gran cantidad de extensiones. Necesita un conjunto reducido de herramientas que resuelva problemas concretos sin introducir complejidad innecesaria.

VS Code ya proporciona numerosas capacidades para JavaScript, TypeScript, React y Node.js. Por ello, antes de instalar una extensión debemos identificar qué funcionalidad falta, qué herramienta la proporciona y si existe una alternativa integrada.

En este documento aprenderemos a seleccionar extensiones mediante criterios técnicos, diferenciando las que aportan valor habitual de aquellas que solo necesitamos en determinados proyectos.

Al finalizar podrás:

- Evaluar extensiones según necesidad, mantenimiento, seguridad, rendimiento y compatibilidad.
- Reconocer funcionalidades que VS Code ya incorpora.
- Seleccionar un conjunto mínimo para JavaScript/TypeScript.
- Diferenciar extensiones del editor de herramientas instaladas en el proyecto.
- Detectar redundancias y responsabilidades duplicadas.
- Justificar técnicamente qué extensiones instalar y cuáles descartar.

---

## 1. Selection Criteria

Una extensión debe resolver una necesidad identificable.

Antes de instalarla, conviene responder cinco preguntas:

| Criterio | Pregunta | Decisión esperada |
|---|---|---|
| Necesidad | ¿Qué problema concreto resuelve? | Evitar instalaciones sin propósito |
| Mantenimiento | ¿Recibe actualizaciones y soporte? | Reducir dependencias abandonadas |
| Seguridad | ¿Conocemos al Publisher y su procedencia? | Limitar riesgos innecesarios |
| Rendimiento | ¿Su consumo de recursos está justificado? | Mantener un editor ágil |
| Compatibilidad | ¿Funciona con nuestro VS Code y Stack? | Evitar herramientas incompatibles |

### Need First, Extension Second

El proceso recomendado es:

```text
Identify a need
      ↓
Check built-in capabilities
      ↓
Evaluate available extensions
      ↓
Install one suitable solution
      ↓
Verify its value
      ↓
Keep or remove
```

Por ejemplo, si necesitamos visualizar diferencias entre versiones de un archivo, primero debemos comprobar las capacidades de Git integradas en VS Code.

Solo si necesitamos funcionalidades adicionales tendría sentido evaluar una extensión especializada.

### Maintenance and Security

Antes de instalar una extensión:

1. Comprueba su identificador completo.
2. Verifica que el Publisher corresponde al proyecto esperado.
3. Consulta su documentación y mantenimiento.
4. Revisa su compatibilidad con la versión de VS Code utilizada.
5. Evalúa qué capacidades necesita para funcionar.

Una extensión popular no es automáticamente segura.

Tampoco debemos interpretar la verificación de un Publisher como una garantía absoluta de calidad o seguridad.

### Performance

Las extensiones pueden introducir procesos, análisis de archivos, conexiones externas o trabajo adicional durante la edición.

Su impacto depende de la implementación y del proyecto.

No debemos asumir que todas las extensiones ralentizan VS Code, pero tampoco que su coste es siempre despreciable.

Si una extensión no aporta valor suficiente, mantenerla instalada carece de justificación técnica.

---

## 2. What VS Code Already Provides

Antes de seleccionar extensiones, debemos conocer las capacidades disponibles sin instalar paquetes adicionales.

| Área | Funcionalidades disponibles en VS Code |
|---|---|
| JavaScript | Resaltado, IntelliSense, navegación y diagnósticos |
| TypeScript | Integración con el servicio de lenguaje de TypeScript |
| React | Soporte de edición para archivos JSX y TSX |
| Node.js | Terminal integrada y soporte de depuración de JavaScript |
| Git | Source Control, diferencias, Stage, Commit y operaciones habituales |
| JSON | Resaltado, validación y asistencia de edición |
| Markdown | Edición y vista previa integrada |
| Debugging | Capacidades integradas para JavaScript y Node.js |
| Editor | Format Document, Quick Fix y organización visual |

Estas capacidades pueden estar implementadas mediante funcionalidades del núcleo de VS Code o extensiones incorporadas.

### JavaScript and TypeScript

VS Code incluye soporte para JavaScript y TypeScript.

Por ejemplo, en un archivo TypeScript:

```typescript
interface User {
  id: string;
  name: string;
}

const user: User = {
  id: "1",
  name: "Diego"
};
```

El editor puede proporcionar autocompletado, navegación y diagnósticos mediante su integración con TypeScript.

No necesitamos instalar una extensión adicional únicamente para obtener soporte básico de TypeScript.

### React

VS Code reconoce archivos `.jsx` y `.tsx` y proporciona funcionalidades de edición mediante su soporte de JavaScript y TypeScript.

Ejemplo:

```tsx
type ButtonProps = {
  label: string;
};

export function Button({ label }: ButtonProps) {
  return <button>{label}</button>;
}
```

Esto no significa que VS Code incluya todas las herramientas específicas del ecosistema React.

Por ejemplo, las reglas de React Hooks o las convenciones de un proyecto pueden requerir herramientas adicionales.

### Node.js

VS Code incorpora soporte de depuración de JavaScript que permite trabajar con aplicaciones Node.js.

También podemos ejecutar comandos mediante la terminal integrada.

Sin embargo, **VS Code no sustituye la instalación de Node.js**.

La capacidad del editor para trabajar con un lenguaje no implica que su Runtime esté instalado.

### Git

VS Code proporciona una integración Git incorporada.

Para las operaciones habituales, no necesitamos instalar GitLens ni otra extensión de Git.

La integración depende de disponer de Git en el entorno correspondiente.

**Principio:** una extensión debe complementar una capacidad existente o cubrir una necesidad real, no duplicar funcionalidades sin una ventaja concreta.

---

## 3. A Minimal Professional Extension Set

Para un entorno JavaScript/TypeScript, conviene comenzar con una selección pequeña.

La siguiente propuesta distingue entre herramientas de uso frecuente y extensiones que dependen del proyecto.

### Core Candidates

| Extensión | Extension ID | Valor principal | Cuándo instalar |
|---|---|---|---|
| ESLint | `dbaeumer.vscode-eslint` | Integración de diagnósticos y acciones de ESLint | Proyectos que utilizan ESLint |
| Prettier - Code formatter | `esbenp.prettier-vscode` | Integración de Prettier con el editor | Proyectos que utilizan Prettier |
| EditorConfig for VS Code | `EditorConfig.EditorConfig` | Aplicación de convenciones EditorConfig | Proyectos que utilizan `.editorconfig` |

Estas tres extensiones son candidatas habituales, **no requisitos universales**.

Su necesidad depende de las herramientas y convenciones utilizadas por cada proyecto.

Por ejemplo:

- Si el proyecto utiliza ESLint, su extensión puede mejorar la retroalimentación durante la edición.
- Si el proyecto utiliza Prettier, su extensión permite integrarlo con las acciones de formato del editor.
- Si el repositorio utiliza `.editorconfig`, su extensión puede ayudar a respetar esas convenciones desde VS Code.

Si una herramienta no forma parte del proyecto, no debemos incorporarla automáticamente solo porque su extensión sea popular.

### Optional Extensions

| Extensión | Extension ID | Valor adicional | Cuándo considerar |
|---|---|---|---|
| GitLens — Git supercharged | `eamodio.gitlens` | Historial, autoría y navegación Git enriquecida | Cuando la integración Git incorporada resulta insuficiente |
| Error Lens | `usernamehw.errorlens` | Diagnósticos visibles directamente junto al código | Cuando mejora la lectura de errores sin generar distracciones |

**GitLens** puede resultar útil al investigar cambios complejos o analizar la evolución de un repositorio.

No es necesario para realizar operaciones Git básicas.

**Error Lens** hace más visibles los diagnósticos existentes, pero no sustituye a TypeScript, ESLint ni otras herramientas que los producen.

Si el desarrollador ya consulta cómodamente Problems y los indicadores del editor, Error Lens puede ser innecesaria.

### Project-dependent Extensions

Algunas extensiones solo tienen sentido cuando el proyecto utiliza una tecnología concreta.

| Extensión | Extension ID | Condición |
|---|---|---|
| Tailwind CSS IntelliSense | `bradlc.vscode-tailwindcss` | Proyecto que utiliza Tailwind CSS |
| Docker | `ms-azuretools.vscode-docker` | Trabajo habitual con Docker |
| Prisma | `Prisma.prisma` | Proyecto que utiliza Prisma |

No debemos instalarlas por anticipado.

Por ejemplo, Tailwind CSS IntelliSense aporta valor al trabajar con clases y archivos relacionados con Tailwind, pero no es necesaria para un proyecto que utiliza CSS convencional.

Del mismo modo, una extensión para Prisma no aporta valor significativo a un proyecto que no utiliza Prisma.

**Nota:** los nombres comerciales, Publishers, funcionalidades y condiciones de compatibilidad pueden cambiar. Antes de instalar una extensión, confirma su identificador y procedencia en Marketplace.

---

## 4. Extension vs Project Tool

Una distinción fundamental es que **instalar una extensión no equivale a instalar o configurar la herramienta correspondiente en el proyecto**.

### ESLint

Consideremos un proyecto:

```text
my-app/
├── src/
│   └── index.ts
├── eslint.config.js
├── package.json
└── pnpm-lock.yaml
```

La responsabilidad se divide así:

| Componente | Responsabilidad |
|---|---|
| ESLint | Analizar código según reglas configuradas |
| `eslint.config.js` | Definir la configuración de ESLint |
| Dependencia `eslint` | Proporcionar la herramienta al proyecto |
| Extensión ESLint | Integrar diagnósticos y acciones en VS Code |

Por ejemplo:

```bash
pnpm add -D eslint
```

Instala ESLint como dependencia de desarrollo.

En cambio, instalar:

```text
dbaeumer.vscode-eslint
```

Añade su integración con VS Code.

La extensión no reemplaza automáticamente la instalación ni la configuración del Linter.

### Prettier

La misma distinción se aplica a Prettier.

```bash
pnpm add -D prettier
```

Instala la herramienta en el proyecto.

Mientras que:

```text
esbenp.prettier-vscode
```

Identifica la extensión que permite utilizar Prettier desde VS Code.

La extensión puede incluir una versión de Prettier para determinados escenarios, pero eso no sustituye la decisión de declarar y controlar la dependencia del proyecto.

Para mantener resultados reproducibles entre desarrolladores y CI, conviene que el proyecto defina explícitamente la versión y las reglas de formato que necesita.

### EditorConfig

EditorConfig funciona de manera diferente.

Un archivo:

```ini
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 2
```

Declara convenciones de edición.

La extensión `EditorConfig.EditorConfig` permite que VS Code interprete esas convenciones.

No estamos instalando necesariamente una herramienta de análisis o formateo equivalente a ESLint o Prettier.

### Responsibility Matrix

| Herramienta | Define reglas del proyecto | Se puede ejecutar independientemente del editor | Extensión aporta integración |
|---|---|---|---|
| ESLint | Sí | Sí | Sí |
| Prettier | Sí, mediante configuración y opciones | Sí | Sí |
| EditorConfig | Sí, mediante `.editorconfig` | Depende de herramientas compatibles | Sí |

**Principio:** las reglas y herramientas esenciales del proyecto deben poder comprenderse y verificarse sin depender exclusivamente de una instalación personal de VS Code.

Los detalles de configuración de ESLint, Prettier y las herramientas de formato se estudiarán en sus módulos correspondientes.

---

## 5. Avoid Redundant Extensions

Instalar varias extensiones que compiten por una misma responsabilidad puede introducir comportamientos inesperados.

### Multiple Formatters

Supongamos que un proyecto dispone de:

- Prettier.
- Un Formatter alternativo.
- Acciones de formato adicionales proporcionadas por otras extensiones.

Podemos encontrarnos con diferentes herramientas capaces de formatear el mismo archivo.

Esto no significa que sean incompatibles automáticamente.

El problema aparece cuando no está claro cuál debe aplicar las reglas del proyecto.

**Recomendación:** definir una herramienta de formato principal y evitar configuraciones contradictorias.

### Multiple Linters

Un proyecto puede utilizar varias herramientas de análisis cuando sus responsabilidades están diferenciadas.

Sin embargo, instalar extensiones que presentan diagnósticos duplicados puede dificultar la interpretación de los problemas.

Por ejemplo, no conviene instalar un segundo mecanismo de análisis solo para reproducir exactamente los diagnósticos que ya proporciona ESLint.

### Overlapping Git Features

VS Code incluye funcionalidades Git.

GitLens añade capacidades complementarias, pero no debe considerarse imprescindible.

Antes de instalarlo, conviene identificar qué operación concreta no podemos resolver adecuadamente con la integración existente.

### Excessive Visual Feedback

Las extensiones que muestran indicadores adicionales pueden mejorar la experiencia, pero también aumentar el ruido visual.

Por ejemplo, Error Lens puede resultar útil en determinados proyectos, aunque algunos desarrolladores prefieren utilizar únicamente Problems y los diagnósticos incorporados.

La decisión debe basarse en productividad y claridad, no en popularidad.

---

## 6. Recommended Selection Strategy

Para comenzar con un entorno profesional, podemos utilizar tres categorías.

### Essential

Extensiones necesarias para una actividad concreta del proyecto.

Por ejemplo:

- ESLint, cuando necesitamos su integración con un proyecto que utiliza ESLint.
- Prettier, cuando queremos integrarlo como Formatter del proyecto.
- EditorConfig, cuando necesitamos que VS Code aplique las convenciones del repositorio.

**Essential significa necesario para nuestro flujo de trabajo, no obligatorio para todos los desarrolladores.**

### Optional

Extensiones que mejoran una experiencia ya cubierta parcialmente por VS Code.

Ejemplos:

- GitLens.
- Error Lens.

Se instalan cuando sus ventajas justifican el coste adicional.

### Project-dependent

Extensiones relacionadas con tecnologías utilizadas en proyectos específicos.

Ejemplos:

- Tailwind CSS IntelliSense.
- Docker.
- Prisma.

No forman parte necesariamente del entorno base.

### Decision Table

| Situación | Decisión recomendada |
|---|---|
| VS Code ya cubre la necesidad | No instalar inicialmente |
| El proyecto utiliza una herramienta concreta | Evaluar su extensión oficial o mantenida |
| La extensión mejora una tarea frecuente | Probar y medir su utilidad |
| Dos extensiones duplican la misma responsabilidad | Mantener una solución clara |
| La extensión no recibe mantenimiento | Buscar alternativas o evitarla |
| La funcionalidad solo se utiliza en un proyecto | Considerar su uso únicamente cuando sea necesario |

El resultado ideal no es una lista fija de extensiones, sino un proceso repetible para seleccionar herramientas.

---

## 7. Hands-on — Evaluate an Extension Set

**Objetivo:** evaluar un conjunto reducido de extensiones y justificar cuáles instalaríamos en un entorno profesional JavaScript/TypeScript.

**Requisitos:** VS Code Stable y acceso a Extensions.

Reutilizaremos `command-palette-lab`.

No es necesario instalar ninguna extensión durante esta práctica.

### 1. Revisar las capacidades integradas

Abre:

```text
command-palette-lab/
├── src/
│   ├── app.js
│   └── utils.js
└── README.md
```

En `src/app.js`, comprueba:

1. Que VS Code reconoce el archivo como JavaScript.
2. Que dispone de resaltado de sintaxis.
3. Que puedes utilizar navegación básica entre archivos.
4. Que puedes consultar Problems.
5. Que puedes abrir Source Control.

**Verificación:** identificas funcionalidades disponibles sin instalar extensiones adicionales.

### 2. Evaluar tres extensiones

Abre Extensions y busca estos identificadores:

```text
dbaeumer.vscode-eslint
esbenp.prettier-vscode
eamodio.gitlens
```

Para cada extensión, comprueba:

- Nombre y Publisher.
- Propósito principal.
- Compatibilidad con tu versión de VS Code.
- Información de mantenimiento disponible.
- Funcionalidades que ya cubre VS Code.

No necesitas instalarlas.

### 3. Clasificar según el proyecto

Imagina que `command-palette-lab` evoluciona hacia un proyecto React + TypeScript que utiliza ESLint y Prettier.

Completa esta evaluación:

| Extensión | Clasificación sugerida | Justificación |
|---|---|---|
| ESLint | Essential para ese flujo | Integra el Linter configurado en el proyecto |
| Prettier | Essential para ese flujo | Integra el Formatter elegido |
| GitLens | Optional | Añade capacidades Git más allá de las integradas |
| Error Lens | Optional | Mejora la visibilidad de diagnósticos |
| Tailwind CSS IntelliSense | Project-dependent | Solo aporta valor si utilizamos Tailwind CSS |

Las clasificaciones son propuestas, no decisiones obligatorias.

Por ejemplo, un equipo puede preferir ejecutar determinadas herramientas desde CLI sin utilizar sus extensiones.

### 4. Justificar la selección

Responde brevemente:

1. ¿Qué funcionalidades ya proporciona VS Code?
2. ¿Qué extensiones necesitan una herramienta adicional en el proyecto?
3. ¿Qué extensiones mejoran capacidades existentes?
4. ¿Qué extensiones descartarías inicialmente?
5. ¿Qué condiciones justificarían instalarlas más adelante?

Una selección inicial razonable para el escenario descrito sería:

```text
Install when needed:
- dbaeumer.vscode-eslint
- esbenp.prettier-vscode

Evaluate later:
- eamodio.gitlens
- usernamehw.errorlens

Only if the project uses the technology:
- bradlc.vscode-tailwindcss
```

No estamos definiendo todavía recomendaciones compartidas mediante archivos del repositorio.

### Resultado esperado

| Capacidad | Verificación |
|---|---|
| Reconocer funcionalidades integradas | Evitas instalaciones innecesarias |
| Identificar extensiones | Compruebas nombre, Publisher e ID |
| Evaluar herramientas | Distingues necesidad real de preferencia |
| Separar extensión y dependencia | Reconoces responsabilidades diferentes |
| Detectar redundancias | Evitas herramientas que compiten sin justificación |
| Justificar decisiones | Elaboras una selección mínima y razonada |

**Resultado de la práctica:** puedes seleccionar extensiones a partir de requisitos técnicos, en lugar de instalar herramientas por popularidad.

---

## Key Takeaways

- Un entorno profesional debe priorizar extensiones necesarias, confiables y mantenidas.
- VS Code ya incluye capacidades importantes para JavaScript, TypeScript, React, Node.js y Git.
- ESLint, Prettier y EditorConfig son candidatos frecuentes, pero su necesidad depende del proyecto.
- GitLens y Error Lens son herramientas opcionales, no requisitos de un entorno profesional.
- Las extensiones específicas de tecnologías deben instalarse cuando realmente utilizamos esas tecnologías.
- Instalar una extensión no equivale a instalar o configurar la herramienta correspondiente en el proyecto.
- Las extensiones redundantes pueden introducir conflictos, diagnósticos duplicados o ruido visual.
- La selección debe basarse en necesidades verificables y mantenerse lo más reducida posible.

### 🚀 Siguiente paso

Continuaremos con **VS Code Tasks**, aprendiendo cómo ejecutar tareas habituales del proyecto desde el editor y cómo se relacionan con los comandos de las herramientas de desarrollo.

👉 [08 — VS Code Tasks](./08-vscode-tasks.md)