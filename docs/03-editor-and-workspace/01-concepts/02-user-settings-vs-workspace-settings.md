# 02 — User Settings vs Workspace Settings

## Overview

Visual Studio Code permite configurar el comportamiento del editor en distintos ámbitos. Los dos principales son **User Settings** y **Workspace Settings**.

La diferencia fundamental es **a quién afecta una configuración y en qué contexto se aplica**:

- **User Settings:** preferencias del desarrollador que se aplican de forma general.
- **Workspace Settings:** configuraciones asociadas al entorno de trabajo que se aplican cuando ese Workspace está abierto.

Comprender esta separación permite personalizar VS Code sin imponer preferencias individuales al equipo y mantener configuraciones consistentes entre desarrolladores.

## Core Concepts

### ¿Qué son los User Settings?

Los **User Settings** son configuraciones definidas a nivel de usuario dentro de VS Code.

Se aplican, por defecto, a los proyectos y Workspaces que abrimos con ese perfil de configuración, salvo cuando un ámbito más específico establece otro valor.

Ejemplos habituales:

| Setting | Ejemplo | Responsabilidad |
|---|---|---|
| `editor.fontSize` | `14` | Tamaño de fuente del editor |
| `editor.fontFamily` | `"Cascadia Code"` | Fuente utilizada para mostrar código |
| `editor.minimap.enabled` | `false` | Visibilidad del Minimap |
| `workbench.colorTheme` | `"Default Dark Modern"` | Tema visual |
| `editor.wordWrap` | `"on"` | Ajuste visual de líneas largas |

Estas configuraciones suelen representar preferencias personales de lectura, navegación y productividad.

Por ejemplo, un desarrollador puede preferir una fuente de 14 píxeles y otro una de 18. Ninguna de esas preferencias debería convertirse automáticamente en una regla del proyecto.

**Modelo mental:** User Settings describe cómo prefiero trabajar con mi editor.

> **Importante:** VS Code también dispone de Profiles, que permiten mantener conjuntos diferenciados de configuraciones. Por ello, no debemos asumir que todos los perfiles comparten exactamente los mismos User Settings. Estudiaremos esta funcionalidad en `02-vscode/11-vscode-profiles.md`.

### ¿Qué son los Workspace Settings?

Los **Workspace Settings** son configuraciones asociadas a un Workspace específico.

Un Workspace puede representar una carpeta abierta en VS Code o un entorno compuesto por varias carpetas (*Multi-root Workspace*).

Cuando abrimos un Workspace, VS Code puede aplicar configuraciones específicas para ese contexto.

Ejemplos:

| Setting | Ejemplo | Responsabilidad |
|---|---|---|
| `editor.tabSize` | `2` | Tamaño de tabulación utilizado por el editor |
| `editor.insertSpaces` | `true` | Uso de espacios al introducir indentación |
| `files.exclude` | `{"**/dist": true}` | Ocultar archivos o carpetas del Explorer |
| `search.exclude` | `{"**/coverage": true}` | Excluir rutas de búsquedas |
| `files.trimTrailingWhitespace` | `true` | Eliminar espacios finales al guardar |

Estas configuraciones pueden resultar útiles para establecer comportamientos consistentes durante el trabajo en un proyecto.

Sin embargo, **que una configuración pueda establecerse en un Workspace no significa que deba compartirse con el equipo**.

Por ejemplo, ocultar una carpeta en el Explorer puede ser una preferencia personal, mientras que mantener una indentación coherente puede responder a una convención del proyecto.

**Modelo mental:** Workspace Settings describe cómo debe comportarse el editor dentro de un contexto de trabajo determinado.

### Comparación de ámbitos

| Criterio | User Settings | Workspace Settings |
|---|---|---|
| Alcance | General para el usuario o perfil activo | Workspace específico |
| Propósito habitual | Personalización del editor | Adaptación al contexto del proyecto |
| Aplicación | En diferentes proyectos | Al abrir el Workspace correspondiente |
| Compartición | Normalmente personal | Puede compartirse mediante archivos versionados |
| Ejemplo | Tamaño de fuente | Indentación acordada por el equipo |
| Persistencia | Configuración del usuario o perfil | Configuración asociada al Workspace |

La distinción es de **alcance**, no de importancia: ambos tipos de configuración pueden modificar el comportamiento del mismo editor.

---

## How Settings Interact

### Una misma configuración puede existir en ambos ámbitos

Supongamos que tenemos estas preferencias:

**User Settings**

```json
{
  "editor.tabSize": 4,
  "editor.fontSize": 16
}
```

**Workspace Settings**

```json
{
  "editor.tabSize": 2
}
```

Cuando abrimos ese Workspace, el comportamiento efectivo será:

| Setting | Valor efectivo | Motivo |
|---|---|---|
| `editor.tabSize` | `2` | El Workspace define un valor más específico |
| `editor.fontSize` | `16` | No existe una configuración del Workspace que lo sustituya |

En este ejemplo, VS Code combina configuraciones de distintos ámbitos y resuelve el valor aplicable.

La regla básica es:

**Para una configuración compatible con ambos ámbitos, Workspace Settings tiene prioridad sobre User Settings.**

Esta es una simplificación útil para comenzar. VS Code dispone de otros ámbitos, restricciones por tipo de configuración y reglas adicionales, especialmente en Multi-root Workspaces y configuraciones específicas de lenguaje.

La jerarquía completa se estudiará en [06 — Settings Precedence](../03-project-configuration/06-settings-precedence.md).

### ¿Dónde se almacenan?

VS Code permite modificar ambos ámbitos mediante su interfaz de Settings o mediante archivos de configuración.

| Ámbito | Ubicación conceptual |
|---|---|
| User Settings | Configuración del usuario o perfil de VS Code |
| Workspace Settings — Single-folder | `.vscode/settings.json` dentro de la carpeta abierta |
| Workspace Settings — Multi-root | Sección `settings` del archivo `.code-workspace` |

Ejemplo de un proyecto con configuración de Workspace:

```text
my-react-app/
├── .vscode/
│   └── settings.json
├── src/
│   └── App.tsx
└── package.json
```

En un proyecto compartido, el archivo `.vscode/settings.json` puede incluirse en Git para distribuir determinadas configuraciones del editor.

Esto no implica que debamos versionar todas las preferencias del equipo.

La estructura, sintaxis y mantenimiento de estos archivos se abordarán en el bloque `03-project-configuration/`.

---

## Practical Examples

### Caso 1 — Preferencias personales

Trabajamos en varios proyectos React y Node.js.

Preferimos utilizar:

```json
{
  "editor.fontSize": 16,
  "editor.minimap.enabled": false,
  "editor.wordWrap": "on"
}
```

Estas preferencias no dependen de React ni de Node.js.

**Ámbito recomendado:** User Settings.

No existe una razón técnica para imponerlas a todos los colaboradores.

### Caso 2 — Convenciones de un proyecto

Un equipo trabaja en una aplicación React con TypeScript y utiliza dos espacios para la indentación.

Podría establecer:

```json
{
  "editor.tabSize": 2,
  "editor.insertSpaces": true
}
```

**Ámbito posible:** Workspace Settings.

Esto facilita que los desarrolladores utilicen un comportamiento de edición coherente.

No obstante, estas opciones no sustituyen las reglas de formateo del proyecto ni garantizan por sí solas que todos los archivos mantengan un estilo consistente. Algunas herramientas o configuraciones específicas de archivo pueden intervenir.

Estudiaremos esa separación en [03 — Editor Configuration vs Project Configuration](./03-editor-configuration-vs-project-configuration.md).

### Caso 3 — Dos proyectos con necesidades diferentes

Imaginemos que trabajamos simultáneamente en:

- `frontend-app/`: proyecto React y TypeScript.
- `legacy-service/`: aplicación JavaScript con convenciones distintas.

Podemos mantener nuestras preferencias visuales generales mediante User Settings y utilizar Workspace Settings diferentes cuando existan necesidades justificadas.

| Configuración | User | Frontend Workspace | Legacy Workspace |
|---|---|---|---|
| Font Size | `16` | Heredado | Heredado |
| Minimap | `false` | Heredado | Heredado |
| Tab Size | `4` | `2` | `4` |
| Insert Spaces | `true` | `true` | `true` |

Así evitamos modificar manualmente nuestras preferencias generales cada vez que cambiamos de proyecto.

### ¿Cómo decidir el ámbito correcto?

Antes de establecer una configuración, identifica su responsabilidad:

| Pregunta | Orientación |
|---|---|
| ¿Es una preferencia visual o de comodidad personal? | User Settings |
| ¿Es una necesidad específica de un Workspace? | Workspace Settings |
| ¿Todos los colaboradores necesitan el mismo comportamiento? | Evaluar una configuración compartida |
| ¿La regla debe cumplirse independientemente del editor? | Configuración propia del proyecto o de sus herramientas |
| ¿Contiene credenciales o información privada? | No compartirla en archivos versionados |

**Criterio profesional:** utilizar Workspace Settings cuando aporten valor al contexto del proyecto, no simplemente porque VS Code permita configurarlos.

---

## Hands-on — Observe Settings Scope

**Objetivo:** comprobar cómo una configuración personal puede ser sustituida por una configuración específica del Workspace.

**Requisitos:** VS Code y una carpeta de práctica. No necesitamos instalar extensiones.

### 1. Crear un Workspace de práctica

Crea una carpeta llamada `settings-scope-lab` y ábrela en VS Code mediante **File → Open Folder**.

Crea un archivo `example.js`:

```javascript
function greet(name) {
  console.log(`Hello, ${name}`);
}

greet("Developer");
```

### 2. Definir un User Setting

Abre **Preferences: Open User Settings (JSON)** desde la Command Palette.

Antes de modificar tus preferencias, identifica los valores originales de `editor.tabSize` y `editor.detectIndentation` para restaurarlos al finalizar.

Añade o modifica estas propiedades:

```json
{
  "editor.tabSize": 4,
  "editor.detectIndentation": false
}
```

Si el archivo ya contiene otras configuraciones, conserva las existentes y agrega únicamente estas propiedades.

Establecer temporalmente `editor.detectIndentation` en `false` evita que VS Code determine el tamaño de tabulación a partir del contenido del archivo.

Con `example.js` abierto, comprueba que la barra de estado de VS Code muestra **Spaces: 4** (o **Tab Size: 4**, según la configuración de indentación).

### 3. Definir un Workspace Setting

Abre **Preferences: Open Workspace Settings (JSON)** desde la Command Palette.

Establece:

```json
{
  "editor.tabSize": 2
}
```

VS Code guardará esta configuración en `.vscode/settings.json` dentro de la carpeta de práctica.

### 4. Verificar el resultado

Con `example.js` abierto:

1. Comprueba que la barra de estado muestra un tamaño de tabulación de `2`.
2. Abre la configuración del Workspace y elimina `editor.tabSize`.
3. Verifica que el valor vuelve a ser `4`.

**Resultado esperado:**

| Situación | Tab Size |
|---|---|
| Solo User Setting | `4` |
| User Setting + Workspace Setting | `2` |
| Workspace Setting eliminado | `4` |

La práctica demuestra que una configuración de Workspace puede modificar el comportamiento del editor sin cambiar el valor definido en User Settings.

**Al finalizar:** restaura los valores originales de `editor.tabSize` y `editor.detectIndentation` en User Settings. Si alguna propiedad no existía previamente, elimínala para recuperar el comportamiento anterior.

**Nota:** `editor.tabSize` afecta al comportamiento de edición; no reformatea automáticamente el contenido existente.

---

## Key Takeaways

- **User Settings** establece preferencias generales del desarrollador o del perfil activo.
- **Workspace Settings** adapta el editor a un contexto de trabajo específico.
- Una configuración compatible definida en el Workspace normalmente prevalece sobre su equivalente en User Settings.
- No toda configuración de Workspace debe compartirse con el equipo.
- Las convenciones que deben cumplirse independientemente del editor pertenecen a las herramientas y configuraciones del proyecto.

**Modelo mental:** User Settings personaliza mi experiencia; Workspace Settings adapta esa experiencia al proyecto sin reemplazar mis preferencias generales.

### 🚀 Siguiente paso

Continuaremos diferenciando las configuraciones del editor de las reglas y herramientas que forman parte del proyecto.

👉 [03 — Editor Configuration vs Project Configuration](./03-editor-configuration-vs-project-configuration.md)