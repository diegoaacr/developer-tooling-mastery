# 02 — VS Code Interface

## Overview

Visual Studio Code organiza sus herramientas mediante una interfaz flexible que permite explorar proyectos, editar archivos, consultar diagnósticos y acceder a diferentes funcionalidades sin abandonar el entorno de trabajo.

Comprender su distribución permite navegar con mayor eficiencia, aprovechar el espacio disponible y distinguir entre los elementos propios del editor y las herramientas incorporadas mediante extensiones.

Al finalizar este documento podrás:

- Identificar las principales regiones de la interfaz de VS Code.
- Navegar entre archivos, Editors y Editor Groups.
- Utilizar las vistas principales del Activity Bar.
- Reconocer las funciones del Panel y sus diferentes vistas.
- Reorganizar y recuperar elementos de la interfaz.
- Restaurar el layout cuando sea necesario.

## 1. Workbench Layout

La interfaz principal de VS Code se denomina **Workbench**. Está organizada en regiones que pueden mostrarse, ocultarse o reorganizarse.

| Región | Responsabilidad | Ubicación habitual |
|---|---|---|
| Activity Bar | Acceso a contenedores de vistas | Lateral izquierdo |
| Primary Side Bar | Muestra vistas como Explorer o Search | Junto al Activity Bar |
| Secondary Side Bar | Permite mantener vistas adicionales visibles | Lateral derecho |
| Editor Area | Espacio principal de edición | Centro |
| Panel | Aloja Terminal, Problems, Output y otras vistas | Parte inferior |
| Status Bar | Muestra información contextual y estados | Borde inferior |

Estas ubicaciones corresponden a una distribución habitual, no a posiciones obligatorias.

### Activity Bar

El **Activity Bar** proporciona acceso a los principales contenedores de vistas de VS Code.

Habitualmente incluye accesos a:

- Explorer.
- Search.
- Source Control.
- Run and Debug.
- Extensions.

Al seleccionar uno, VS Code muestra las vistas correspondientes en la Side Bar.

El Activity Bar no contiene necesariamente todas las funcionalidades disponibles: las extensiones pueden añadir nuevos accesos y contenedores de vistas.

### Primary Side Bar

La **Primary Side Bar** muestra las vistas asociadas al contenedor seleccionado.

Por ejemplo:

- Explorer permite navegar por los archivos del Workspace.
- Search presenta resultados de búsqueda.
- Source Control muestra información relacionada con los repositorios detectados.

Puede ocultarse para ampliar el espacio de edición.

**Atajo habitual:**

| macOS | Windows / Linux |
|---|---|
| `Cmd + B` | `Ctrl + B` |

Este atajo alterna la visibilidad de la Primary Side Bar.

### Secondary Side Bar

La **Secondary Side Bar** permite mostrar vistas adicionales al mismo tiempo que la Primary Side Bar.

Por ejemplo, podemos mantener:

- Explorer a la izquierda.
- Una vista de Outline o una herramienta adicional a la derecha.
- El código en el centro.

Es especialmente útil cuando trabajamos con pantallas grandes o necesitamos consultar información sin reemplazar la vista principal.

No todas las vistas están ubicadas inicialmente en esta región. Podemos mover vistas compatibles según nuestras necesidades.

### Editor Area

El **Editor Area** es la región donde abrimos y modificamos archivos.

Puede contener:

- Archivos de código.
- Archivos Markdown.
- Configuraciones JSON.
- Vistas de diferencias de Git.
- Editores especializados proporcionados por VS Code o extensiones.

No todo lo que aparece en el Editor Area es necesariamente un archivo de texto. Algunas herramientas utilizan editores personalizados o vistas interactivas.

### Panel

El **Panel** agrupa herramientas que complementan la edición.

Sus vistas habituales incluyen:

| Vista | Propósito |
|---|---|
| Terminal | Interactuar con un Shell desde VS Code |
| Problems | Consultar errores, advertencias y otros diagnósticos |
| Output | Consultar mensajes producidos por VS Code y sus componentes |
| Debug Console | Consultar información e interactuar con sesiones de depuración compatibles |

El Panel puede ubicarse en diferentes posiciones, según la distribución elegida.

**Atajo habitual para mostrar u ocultar el Panel:**

| macOS | Windows / Linux |
|---|---|
| `Cmd + J` | `Ctrl + J` |

### Status Bar

La **Status Bar** presenta información contextual sobre el editor y el archivo activo.

Puede mostrar:

- Línea y columna del cursor.
- Tipo de archivo o Language Mode.
- Codificación.
- Final de línea (LF o CRLF).
- Indentación.
- Estado de Git.
- Información añadida por extensiones.

Por ejemplo, al abrir `index.js`, VS Code puede mostrar:

```text
Ln 5, Col 12    Spaces: 2    UTF-8    LF    JavaScript
```

Algunos elementos son interactivos y permiten consultar o modificar opciones relacionadas.

La información visible depende del archivo, las funcionalidades disponibles y las extensiones instaladas.

---

## 2. Main Views

Las vistas principales del Activity Bar permiten acceder a diferentes responsabilidades del entorno de desarrollo.

### Explorer

El **Explorer** permite navegar por las carpetas y archivos del Workspace.

Operaciones habituales:

- Abrir archivos.
- Crear archivos y carpetas.
- Renombrar elementos.
- Mover archivos.
- Eliminar archivos.
- Consultar la estructura del proyecto.

Ejemplo:

```text
my-app/
├── src/
│   ├── components/
│   │   └── Button.tsx
│   ├── App.tsx
│   └── main.tsx
├── package.json
└── tsconfig.json
```

Desde Explorer podemos abrir `App.tsx` o navegar hacia `components/Button.tsx`.

El Explorer representa archivos y carpetas del Workspace, pero también puede mostrar vistas complementarias, como Open Editors u Outline.

### Search

La vista **Search** permite buscar texto dentro de los archivos del Workspace.

Incluye funcionalidades como:

- Búsqueda global.
- Reemplazo de texto.
- Filtros por archivos o carpetas.
- Resultados agrupados por archivo.

**Atajos habituales:**

| Acción | macOS | Windows / Linux |
|---|---|---|
| Buscar en el archivo actual | `Cmd + F` | `Ctrl + F` |
| Buscar en el Workspace | `Cmd + Shift + F` | `Ctrl + Shift + F` |

La búsqueda del Workspace es diferente de la búsqueda dentro de un único archivo.

### Source Control

La vista **Source Control** proporciona una interfaz para trabajar con sistemas de control de versiones compatibles.

VS Code incluye integración con Git, que puede mostrar:

- Archivos modificados.
- Cambios pendientes.
- Diferencias entre versiones.
- Acciones de Stage y Commit.
- Información de ramas.

La integración visual no sustituye a Git como herramienta de control de versiones.

Para utilizar las operaciones locales de Git normalmente necesitamos que Git esté instalado y disponible en el entorno correspondiente.

### Run and Debug

La vista **Run and Debug** concentra controles relacionados con la ejecución y depuración de aplicaciones.

Puede presentar:

- Configuraciones de ejecución.
- Controles para iniciar sesiones.
- Breakpoints.
- Variables.
- Call Stack.

La disponibilidad de estas capacidades depende del lenguaje, las herramientas instaladas y el soporte de depuración.

Su funcionamiento se estudiará en `09-vscode-debugging.md`.

### Extensions

La vista **Extensions** permite descubrir, instalar, habilitar, deshabilitar y administrar extensiones.

Las extensiones pueden incorporar:

- Soporte para lenguajes.
- Herramientas de desarrollo.
- Nuevas vistas.
- Comandos.
- Integraciones con servicios externos.

No todas las funcionalidades de VS Code requieren una extensión: algunas forman parte de la instalación base y otras se incorporan mediante extensiones integradas o adicionales.

La administración de extensiones se estudiará en `06-vscode-extensions.md`.

---

## 3. Editors, Tabs and Editor Groups

VS Code permite trabajar con varios archivos simultáneamente dentro del Editor Area.

### Editors y Tabs

Un **Editor** es una instancia de edición o visualización de un recurso.

Las **Tabs** permiten identificar y seleccionar los Editors abiertos dentro de un grupo.

Por ejemplo, podemos tener:

```text
App.tsx | Button.tsx | package.json
```

Cada pestaña representa un Editor abierto.

### Preview Editor vs Pinned Editor

VS Code distingue entre editores abiertos en modo Preview y editores que permanecen abiertos.

| Tipo | Comportamiento habitual |
|---|---|
| Preview Editor | Puede reutilizarse al abrir otro archivo en Preview |
| Pinned Editor | Permanece abierto al navegar por otros archivos |

En la configuración habitual:

- Un clic sobre un archivo del Explorer puede abrirlo en Preview.
- Un doble clic suele abrirlo como Pinned Editor.
- Modificar un archivo en Preview puede hacer que deje de ser reutilizable como Preview.

El comportamiento concreto puede variar según las preferencias del editor.

**Consejo práctico:** si un archivo desaparece de las pestañas al abrir otro, probablemente estaba abierto en modo Preview.

### Editor Groups

Los **Editor Groups** permiten dividir el Editor Area para trabajar con varios Editors en paralelo.

Por ejemplo:

| Grupo izquierdo | Grupo derecho |
|---|---|
| `App.tsx` | `Button.tsx` |
| `main.tsx` | `package.json` |

Esta distribución facilita comparar implementaciones, consultar tipos o revisar componentes relacionados.

Podemos crear grupos mediante:

- **Split Editor Right** desde el menú contextual de una pestaña.
- Arrastrar una pestaña hacia un lateral del Editor Area.
- Utilizar acciones del menú **View → Editor Layout**.

La cantidad y distribución de grupos puede modificarse según el espacio disponible.

### Navegación entre archivos

| Acción | macOS | Windows / Linux |
|---|---|---|
| Quick Open | `Cmd + P` | `Ctrl + P` |
| Cambiar al Editor anterior del grupo | `Ctrl + PageUp` | `Ctrl + PageUp` |
| Cambiar al Editor siguiente del grupo | `Ctrl + PageDown` | `Ctrl + PageDown` |
| Cerrar el Editor activo | `Cmd + W` | `Ctrl + W` |
| Dividir el Editor | `Cmd + \` | `Ctrl + \` |

Los atajos corresponden a configuraciones habituales y pueden variar según el sistema, el teclado o las personalizaciones existentes.

**Quick Open** permite localizar archivos por nombre sin recorrer manualmente el Explorer.

---

## 4. Panel Views

El Panel reúne herramientas que necesitamos consultar durante el desarrollo.

### Terminal

La **Integrated Terminal** permite utilizar un Shell dentro de VS Code.

Podemos ejecutar comandos como:

```bash
node --version
```

El comando se ejecuta mediante el Shell y las herramientas disponibles en el entorno, no mediante el editor como Runtime.

La selección de Shells y la configuración de terminales se estudiarán en `14-vscode-terminal-configuration.md`.

### Problems

La vista **Problems** presenta diagnósticos disponibles para los archivos y el Workspace.

Puede incluir:

- Errores de sintaxis.
- Problemas de tipos.
- Advertencias.
- Diagnósticos generados por herramientas integradas o extensiones.

Por ejemplo, en TypeScript:

```typescript
const total: number = "100";
```

Un servicio de lenguaje compatible puede detectar una incompatibilidad de tipos y mostrarla en Problems.

**Importante:** Problems muestra diagnósticos disponibles en VS Code. No representa necesariamente una validación completa de todas las herramientas del proyecto.

### Output

La vista **Output** presenta mensajes generados por componentes y servicios del entorno.

Podemos seleccionar distintos canales de salida según las herramientas disponibles.

Por ejemplo:

- Git.
- TypeScript.
- Extensiones.
- Otros servicios del editor.

Output resulta útil para investigar el comportamiento de una integración o identificar mensajes técnicos.

No debe confundirse con la salida estándar de cualquier comando ejecutado en la terminal.

### Debug Console

La **Debug Console** permite consultar información asociada a sesiones de depuración compatibles.

Dependiendo del Debugger, puede mostrar mensajes de la aplicación y permitir evaluar expresiones durante una sesión activa.

No sustituye a la terminal integrada ni está destinada a ejecutar comandos generales del Shell.

---

## 5. Customize and Restore the Layout

VS Code permite adaptar la distribución del Workbench sin modificar el código ni la configuración técnica del proyecto.

### Operaciones habituales

| Necesidad | Acción |
|---|---|
| Ocultar o mostrar Primary Side Bar | `Cmd/Ctrl + B` |
| Ocultar o mostrar Panel | `Cmd/Ctrl + J` |
| Mostrar Secondary Side Bar | **View → Appearance → Secondary Side Bar** |
| Cambiar la posición del Panel | **View → Appearance → Panel Position** |
| Mover una vista | Arrastrar su encabezado a una región compatible |
| Dividir el Editor | **View → Editor Layout** |
| Activar Zen Mode | **View → Appearance → Zen Mode** |

Las opciones exactas pueden variar ligeramente según la versión de VS Code.

### Recuperar elementos ocultos

Si desaparece una región de la interfaz, primero verifica si simplemente está oculta.

Puedes utilizar el menú:

**View → Appearance**

Desde allí es posible recuperar regiones como Activity Bar, Primary Side Bar, Secondary Side Bar, Panel y Status Bar.

Si has reorganizado varias vistas y quieres recuperar la distribución habitual, utiliza la acción:

**View: Reset View Locations**

Esta acción devuelve las vistas a sus ubicaciones predeterminadas.

No elimina archivos del proyecto ni desinstala extensiones.

### macOS, Windows y Linux

La estructura general del Workbench es equivalente entre plataformas.

Las diferencias más relevantes se encuentran en los menús y atajos:

| Aspecto | macOS | Windows / Linux |
|---|---|---|
| Modificador habitual | `Cmd` | `Ctrl` |
| Menú principal | Barra de menús del sistema | Barra de menús de la aplicación, según entorno |
| Abrir carpeta | File → Open Folder | File → Open Folder |
| Navegación rápida | `Cmd + P` | `Ctrl + P` |
| Mostrar Side Bar | `Cmd + B` | `Ctrl + B` |

En Linux, determinados atajos pueden entrar en conflicto con los del entorno de escritorio.

En macOS, algunas combinaciones pueden depender de la distribución del teclado o de las preferencias del sistema.

---

## 6. Hands-on — Explore and Restore the Workbench

**Objetivo:** reconocer las regiones principales de VS Code, navegar entre archivos, reorganizar Editors y recuperar la distribución inicial.

**Requisitos:** VS Code Stable instalado. No necesitamos extensiones adicionales ni configurar Runtimes.

### 1. Preparar el Workspace

Crea una carpeta llamada `vscode-interface-lab` y ábrela en VS Code.

Estructura:

```text
vscode-interface-lab/
├── src/
│   ├── App.js
│   └── utils.js
└── README.md
```

**`src/App.js`**

```javascript
import { greet } from "./utils.js";

console.log(greet("Developer"));
```

**`src/utils.js`**

```javascript
export function greet(name) {
  return `Hello, ${name}!`;
}
```

**`README.md`**

```markdown
# VS Code Interface Lab

Exploring the VS Code Workbench.
```

No ejecutaremos la aplicación. El objetivo es practicar navegación y organización visual.

### 2. Explorar las regiones

Realiza estas acciones:

1. Identifica Activity Bar, Primary Side Bar, Editor Area, Panel y Status Bar.
2. Abre Explorer y localiza `src/App.js`.
3. Abre Search y busca `greet` en el Workspace.
4. Accede a Source Control, Run and Debug y Extensions para reconocer sus vistas principales.
5. Abre el Panel y localiza Terminal, Problems, Output y Debug Console.

**Verificación:** puedes identificar dónde aparece cada vista y distinguirla de las regiones que la contienen.

### 3. Trabajar con Editors y Editor Groups

1. Abre `App.js` desde Explorer.
2. Abre `utils.js` mediante Quick Open (`Cmd/Ctrl + P`).
3. Fija ambos Editors si están abiertos en Preview.
4. Divide el Editor Area utilizando **Split Editor Right**.
5. Coloca `App.js` a la izquierda y `utils.js` a la derecha.
6. Alterna entre los Editors y observa qué grupo está activo.

**Verificación:** ambos archivos permanecen visibles simultáneamente en dos Editor Groups.

### 4. Reorganizar la interfaz

1. Oculta y vuelve a mostrar la Primary Side Bar con `Cmd/Ctrl + B`.
2. Oculta y vuelve a mostrar el Panel con `Cmd/Ctrl + J`.
3. Muestra la Secondary Side Bar desde **View → Appearance**.
4. Mueve una vista compatible a la Secondary Side Bar.
5. Cambia temporalmente la posición del Panel.

**Verificación:** puedes reorganizar las regiones sin modificar los archivos del Workspace.

### 5. Restaurar el layout

1. Ejecuta **View: Reset View Locations** para recuperar la ubicación predeterminada de las vistas.
2. Si alguna región continúa oculta, muéstrala desde **View → Appearance**.
3. Cierra los Editor Groups adicionales que hayas creado.
4. Devuelve el Panel a su posición inferior si deseas recuperar la distribución habitual.

**Resultado esperado:**

| Capacidad | Verificación |
|---|---|
| Identificar regiones | Reconoces los elementos principales del Workbench |
| Navegar entre archivos | Abres archivos desde Explorer y Quick Open |
| Utilizar Editor Groups | Visualizas dos archivos simultáneamente |
| Explorar Panel | Localizas Terminal, Problems, Output y Debug Console |
| Reorganizar vistas | Mueves y muestras regiones del Workbench |
| Restaurar layout | Recuperas una distribución de trabajo funcional |

**Resultado de la práctica:** puedes navegar y organizar VS Code sin depender de una distribución fija de la interfaz.

---

## Key Takeaways

- El **Workbench** organiza VS Code mediante regiones como Activity Bar, Side Bars, Editor Area, Panel y Status Bar.
- Las vistas Explorer, Search, Source Control, Run and Debug y Extensions ofrecen acceso a diferentes funcionalidades.
- Los Editors, Tabs y Editor Groups permiten trabajar con varios archivos y distribuciones.
- Terminal, Problems, Output y Debug Console cumplen responsabilidades diferentes.
- Las extensiones pueden añadir vistas y capacidades, pero no todos los elementos de la interfaz dependen de ellas.
- El layout puede personalizarse y restaurarse sin afectar al código del proyecto.

### 🚀 Siguiente paso

Ahora que conocemos la interfaz, aprenderemos a utilizar la **Command Palette** para acceder rápidamente a las acciones disponibles en VS Code.

👉 [03 — Command Palette](./03-command-palette.md)