# 05 — VS Code Workspace Settings

## Overview

Los **Workspace Settings** permiten adaptar el comportamiento de Visual Studio Code al proyecto o entorno de trabajo que tenemos abierto.

A diferencia de las preferencias generales del usuario, estas configuraciones pertenecen a un Workspace específico y pueden utilizarse para establecer comportamientos de edición coherentes entre los desarrolladores de un equipo.

VS Code permite administrarlas desde **Settings UI** y **Settings JSON**, tanto en Workspaces de una sola carpeta como en entornos Multi-root.

Al finalizar este documento podrás:

- Acceder y modificar Workspace Settings desde ambas interfaces.
- Identificar dónde se almacenan según el tipo de Workspace.
- Reconocer qué configuraciones admiten el ámbito Workspace.
- Comprobar cuándo un Workspace Setting sustituye un User Setting.
- Decidir qué preferencias conviene compartir con el equipo.
- Restaurar los cambios realizados durante una práctica.

## 1. Access Workspace Settings

### Settings UI

Para acceder a las configuraciones del Workspace:

1. Abre una carpeta en VS Code mediante **File → Open Folder**.
2. Abre Settings con `Cmd + ,` en macOS o `Ctrl + ,` en Windows/Linux.
3. Selecciona la pestaña **Workspace**.
4. Busca la configuración que deseas modificar.

También puedes utilizar la Command Palette:

```text
Preferences: Open Workspace Settings
```

Settings UI permite consultar descripciones, valores y ámbitos admitidos antes de modificar una preferencia.

**Importante:** debes tener una carpeta o Workspace abierto. Si únicamente tienes una ventana vacía, no dispondrás del mismo contexto de configuración.

### Settings JSON

Para editar directamente las configuraciones:

1. Abre la Command Palette.
2. Ejecuta:

```text
Preferences: Open Workspace Settings (JSON)
```

3. Modifica las propiedades correspondientes.

Por ejemplo:

```json
{
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "files.trimTrailingWhitespace": true
}
```

En un Workspace de una sola carpeta, VS Code almacena estas configuraciones en:

```text
.vscode/settings.json
```

No es necesario crear manualmente el archivo si utilizamos el comando correspondiente.

**Settings UI y Settings JSON representan dos formas de administrar el mismo ámbito de configuración.**

---

## 2. Single-folder vs Multi-root Workspace

La ubicación de Workspace Settings depende de cómo abrimos nuestro entorno de trabajo.

### Single-folder Workspace

Un **Single-folder Workspace** corresponde a una carpeta abierta directamente en VS Code.

Ejemplo:

```text
react-app/
├── .vscode/
│   └── settings.json
├── src/
│   └── App.tsx
├── package.json
└── tsconfig.json
```

El archivo `.vscode/settings.json` contiene las configuraciones del Workspace.

Ejemplo:

```json
{
  "editor.tabSize": 2,
  "editor.insertSpaces": true
}
```

Estas preferencias se aplican cuando trabajamos con esa carpeta en VS Code, respetando los ámbitos y reglas de resolución correspondientes.

Si abrimos otra carpeta como Workspace independiente, no heredará automáticamente este archivo.

### Multi-root Workspace

Un **Multi-root Workspace** permite abrir varias carpetas dentro de una misma ventana de VS Code.

Por ejemplo:

```text
professional-workspace/
├── frontend/
│   └── package.json
├── backend/
│   └── package.json
└── development.code-workspace
```

El archivo `.code-workspace` puede declarar las carpetas y las configuraciones del Workspace:

```json
{
  "folders": [
    {
      "path": "frontend"
    },
    {
      "path": "backend"
    }
  ],
  "settings": {
    "editor.tabSize": 2,
    "editor.insertSpaces": true
  }
}
```

La propiedad `folders` identifica las carpetas incluidas.

La propiedad `settings` contiene las configuraciones del Workspace.

En un Multi-root Workspace, las carpetas también pueden disponer de configuraciones propias en `.vscode/settings.json`, pero VS Code limita qué tipos de Settings pueden aplicarse a ese nivel.

No todas las configuraciones de un Single-folder Workspace tienen el mismo comportamiento dentro de un Multi-root Workspace.

### Comparación operativa

| Característica | Single-folder | Multi-root |
|---|---|---|
| Carpetas abiertas | Una carpeta principal | Varias carpetas |
| Workspace Settings | `.vscode/settings.json` | Propiedad `settings` del `.code-workspace` |
| Configuración específica de carpeta | Coincide con el Workspace abierto | Puede existir en cada carpeta |
| Uso habitual | Proyecto individual | Varios proyectos relacionados |
| Complejidad | Menor | Mayor |

**Para comenzar, utilizaremos Single-folder Workspaces.**

La creación y administración avanzada de Multi-root Workspaces se estudiará en `10-multi-root-workspaces.md`.

---

## 3. Settings Scope and Limitations

No todas las configuraciones de VS Code pueden establecerse en cualquier ámbito.

Cada Setting declara un **scope**, que determina dónde puede configurarse.

Entre los ámbitos habituales encontramos:

| Scope | Responsabilidad general |
|---|---|
| Application | Configuración de la aplicación |
| Machine | Configuración vinculada al entorno o equipo |
| Window | Configuración relacionada con la ventana |
| Resource | Configuración relacionada con recursos como archivos o carpetas |
| Language-overridable | Configuración que admite valores específicos por lenguaje |

Algunos Settings también tienen variantes de ámbito más específicas.

La distinción es importante porque **una propiedad válida en User Settings no necesariamente es válida en Workspace Settings**.

### Ejemplo: configuración admitida en Workspace

```json
{
  "editor.tabSize": 2,
  "editor.insertSpaces": true
}
```

Estas configuraciones pueden aplicarse al Workspace.

También admiten configuraciones específicas por lenguaje.

Por ejemplo:

```json
{
  "editor.tabSize": 2,
  "[markdown]": {
    "editor.wordWrap": "on"
  }
}
```

En este caso, `editor.tabSize` establece una preferencia general de edición para el Workspace, mientras que `editor.wordWrap` se personaliza para archivos Markdown.

### Ejemplo: configuración limitada a otro ámbito

La configuración:

```text
update.mode
```

Controla el comportamiento de las actualizaciones de VS Code en los entornos donde está disponible.

Es una configuración de aplicación y no corresponde establecerla como una regla compartida del Workspace.

### ¿Cómo reconocer el ámbito permitido?

Desde Settings UI:

1. Busca el identificador del Setting.
2. Consulta su descripción y la información de ámbito disponible.
3. Comprueba si puede modificarse desde la pestaña Workspace.
4. Si no está disponible en ese ámbito, utiliza uno compatible.

Desde Settings JSON, VS Code puede mostrar diagnósticos cuando una configuración se declara en un ámbito no admitido.

**Regla práctica:** antes de compartir una configuración, verifica que VS Code la admite en el ámbito elegido y que realmente corresponde al proyecto.

La jerarquía completa y los casos especiales se estudiarán en `../03-project-configuration/06-settings-precedence.md`.

---

## 4. User Settings and Workspace Settings in Practice

Supongamos que tenemos estas preferencias personales:

**User Settings**

```json
{
  "editor.tabSize": 4,
  "editor.fontSize": 16
}
```

Ahora abrimos un proyecto que establece:

**Workspace Settings**

```json
{
  "editor.tabSize": 2
}
```

El resultado esperado es:

| Setting | User | Workspace | Valor efectivo |
|---|---|---|---|
| `editor.tabSize` | `4` | `2` | `2` |
| `editor.fontSize` | `16` | No definido | `16` |

Para configuraciones compatibles, Workspace Settings normalmente tiene prioridad sobre User Settings.

Esto permite conservar preferencias personales generales y aplicar convenciones específicas cuando trabajamos en un proyecto.

### Precaución con la detección de indentación

VS Code dispone de una configuración:

```json
{
  "editor.detectIndentation": true
}
```

Cuando está habilitada, el editor puede detectar la indentación del archivo y ajustar el comportamiento observado.

Por ello, comprobar `editor.tabSize` únicamente mirando la barra de estado puede resultar confuso si interviene la detección automática.

Para una prueba controlada podemos desactivarla temporalmente:

```json
{
  "editor.detectIndentation": false
}
```

Esto no significa que debamos deshabilitarla permanentemente en todos los proyectos.

Tampoco debemos utilizar **Indentation: Change Tab Size** para demostrar la prioridad entre User y Workspace Settings, porque modifica el comportamiento de indentación del Editor activo y puede introducir un estado adicional que dificulta la comparación.

---

## 5. What Should Be Shared with the Team?

Un Workspace Setting puede almacenarse en un archivo versionado, pero eso no significa que toda preferencia deba compartirse.

### Configuraciones potencialmente compartidas

En un proyecto JavaScript/TypeScript podrían resultar útiles:

```json
{
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true
}
```

Estas opciones pueden facilitar determinadas convenciones de edición.

Sin embargo, deben ser coherentes con las reglas establecidas mediante EditorConfig y las herramientas del proyecto.

**Workspace Settings complementa esas reglas; no debe convertirse en su único mecanismo de aplicación.**

### Configuraciones preferentemente personales

Por ejemplo:

```json
{
  "editor.fontSize": 18,
  "editor.minimap.enabled": false,
  "workbench.colorTheme": "Default Dark Modern"
}
```

Estas preferencias suelen responder a necesidades individuales.

Aunque algunas puedan configurarse técnicamente en un Workspace, normalmente no aportan valor como convenciones compartidas.

### Criterios de decisión

| Pregunta | Recomendación |
|---|---|
| ¿La configuración representa una convención del equipo? | Considerar Workspace Settings |
| ¿Es una preferencia visual o de accesibilidad? | Mantener en User Settings |
| ¿Debe cumplirse fuera de VS Code? | Utilizar la herramienta o estándar del proyecto |
| ¿Depende de rutas o recursos personales? | Evitar compartirla sin una justificación clara |
| ¿Contiene credenciales o secretos? | No incluirlos en configuraciones versionadas |

### Ejemplo: proyecto React con TypeScript

Consideremos:

```text
react-app/
├── .vscode/
│   └── settings.json
├── .editorconfig
├── src/
│   └── App.tsx
├── package.json
└── tsconfig.json
```

Las responsabilidades deben mantenerse diferenciadas:

| Archivo | Responsabilidad |
|---|---|
| `.vscode/settings.json` | Comportamiento de VS Code para el Workspace |
| `.editorconfig` | Convenciones básicas de edición entre herramientas compatibles |
| `tsconfig.json` | Configuración del proyecto TypeScript |
| `package.json` | Metadatos, dependencias y scripts del paquete |

La estructura y administración detallada de `.vscode/settings.json` se estudiarán en `../03-project-configuration/02-settings-json.md`.

---

## 6. Hands-on — Verify Workspace Settings

**Objetivo:** comprobar que un Workspace Setting puede sustituir una preferencia de usuario, identificar su ubicación y restaurar los cambios realizados.

**Requisitos:** VS Code Stable instalado.

Reutilizaremos `command-palette-lab`, creado en documentos anteriores.

### 1. Preparar el Workspace

Abre la carpeta:

```text
command-palette-lab/
├── src/
│   ├── app.js
│   └── utils.js
└── README.md
```

Abre `src/app.js` y comprueba que estás trabajando en un Single-folder Workspace.

### 2. Registrar las preferencias originales

Abre:

```text
Preferences: Open User Settings (JSON)
```

Identifica los valores originales de:

```text
editor.tabSize
editor.detectIndentation
```

Registra también si alguna propiedad estaba ausente.

Después, abre:

```text
Preferences: Open Workspace Settings (JSON)
```

Si ya existen configuraciones en `.vscode/settings.json`, conserva su contenido y registra los valores originales de las mismas dos propiedades.

**No sobrescribas configuraciones existentes.**

### 3. Establecer User Settings temporales

En User Settings, establece:

```json
{
  "editor.tabSize": 4,
  "editor.detectIndentation": false
}
```

Si el archivo contiene otras propiedades, añade o modifica únicamente estas dos.

Con `app.js` abierto, comprueba en la Status Bar que aparece **Spaces: 4** o **Tab Size: 4**, según el modo de indentación.

Desactivar temporalmente `editor.detectIndentation` evita que la detección automática del contenido altere la observación.

### 4. Establecer Workspace Settings

Abre:

```text
Preferences: Open Workspace Settings (JSON)
```

Establece:

```json
{
  "editor.tabSize": 2
}
```

Conserva cualquier otra configuración existente.

Comprueba que VS Code ha creado o modificado:

```text
command-palette-lab/
└── .vscode/
    └── settings.json
```

### 5. Verificar el valor efectivo

Regresa a `src/app.js`.

Comprueba que la Status Bar muestra:

```text
Spaces: 2
```

O el indicador equivalente de tamaño de tabulación.

Ahora abre Settings UI y busca:

```text
@id:editor.tabSize
```

Compara los valores en los ámbitos User y Workspace.

**Resultado esperado:**

| Ámbito | Valor |
|---|---|
| User Settings | `4` |
| Workspace Settings | `2` |
| Valor efectivo del Editor | `2` |

El valor del Workspace se aplica sin modificar la preferencia personal de `4`.

**Importante:** `editor.tabSize` no reformatea automáticamente el contenido existente.

### 6. Restaurar el estado original

En Workspace Settings:

1. Restaura el valor anterior de `editor.tabSize`, si existía.
2. Si no existía, elimina la propiedad añadida.
3. Conserva las demás configuraciones del archivo.

En User Settings:

1. Restaura el valor original de `editor.tabSize`.
2. Restaura el valor original de `editor.detectIndentation`.
3. Si alguna propiedad estaba ausente originalmente, elimínala.

Si `.vscode/settings.json` fue creado exclusivamente para esta práctica y no contiene otras configuraciones, puedes eliminarlo junto con la carpeta `.vscode` si queda vacía.

### Resultado esperado

| Verificación | Resultado |
|---|---|
| Abrir Workspace Settings UI | Accedes al ámbito Workspace |
| Abrir Workspace Settings JSON | Identificas `.vscode/settings.json` |
| Modificar `editor.tabSize` | El Workspace utiliza el valor `2` |
| Comparar User y Workspace | Identificas valores diferentes para el mismo Setting |
| Consultar Status Bar | Observas el valor efectivo |
| Restaurar configuraciones | Recuperas las preferencias originales |

**Resultado de la práctica:** has comprobado cómo VS Code aplica una configuración específica del Workspace sin reemplazar permanentemente tus User Settings.

---

## Key Takeaways

- Workspace Settings permite adaptar VS Code al entorno de trabajo abierto.
- En un Single-folder Workspace, las configuraciones se almacenan en `.vscode/settings.json`.
- En un Multi-root Workspace, las configuraciones generales se almacenan en la propiedad `settings` del archivo `.code-workspace`.
- No todos los Settings admiten todos los ámbitos; debemos verificar su scope antes de utilizarlos.
- Para configuraciones compatibles, Workspace Settings normalmente prevalece sobre User Settings.
- Las preferencias compartidas deben responder a necesidades del equipo, no a gustos individuales.
- Las reglas técnicas del proyecto deben mantenerse en las herramientas responsables de aplicarlas.
- Al experimentar con Settings, conviene registrar y restaurar los valores originales.

### 🚀 Siguiente paso

Continuaremos con el sistema de extensiones de VS Code, comprendiendo cómo amplían las capacidades del editor y cómo administrarlas correctamente.

👉 [06 — VS Code Extensions](./06-vscode-extensions.md)