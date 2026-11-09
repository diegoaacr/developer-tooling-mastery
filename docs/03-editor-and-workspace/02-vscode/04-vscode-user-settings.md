# 04 — VS Code User Settings

## Overview

Visual Studio Code permite personalizar la experiencia de desarrollo mediante **User Settings**, configuraciones que controlan aspectos como la apariencia, la edición de archivos y el comportamiento general del editor.

Estas preferencias pueden administrarse desde dos interfaces:

- **Settings UI:** interfaz gráfica para buscar, consultar y modificar configuraciones.
- **Settings JSON:** archivo donde se almacenan las configuraciones personalizadas del usuario.

Ambas interfaces permiten trabajar sobre las mismas preferencias, pero ofrecen diferentes formas de interactuar con ellas.

Al finalizar este documento podrás:

- Acceder a User Settings desde Settings UI y Settings JSON.
- Diferenciar los valores predeterminados de las preferencias personalizadas.
- Buscar configuraciones y reconocer sus identificadores.
- Modificar, verificar y restablecer preferencias.
- Comprender la relación básica entre User Settings y VS Code Profiles.
- Mantener preferencias personales sin modificar innecesariamente la configuración del proyecto.

## 1. Access User Settings

### Settings UI

La **Settings UI** permite administrar configuraciones mediante controles visuales como checkboxes, listas desplegables y campos de texto.

Podemos abrirla desde la Command Palette:

```text
Preferences: Open User Settings
```

También podemos utilizar el atajo habitual:

| macOS | Windows / Linux |
|---|---|
| `Cmd + ,` | `Ctrl + ,` |

El atajo abre Settings. Si aparece un selector de ámbito, debemos comprobar que estamos trabajando en **User**.

En Settings UI encontramos:

- Un campo de búsqueda.
- Categorías de configuración.
- Descripciones de las preferencias.
- Controles para modificar valores.
- Indicadores de configuraciones modificadas.

**Ventaja:** permite descubrir configuraciones sin conocer previamente sus identificadores.

### Settings JSON

VS Code también permite modificar User Settings directamente mediante JSON.

Desde la Command Palette ejecutamos:

```text
Preferences: Open User Settings (JSON)
```

Se abrirá un archivo similar a:

```json
{
  "editor.fontSize": 16,
  "editor.minimap.enabled": false,
  "editor.wordWrap": "on"
}
```

Cada propiedad representa una configuración identificada mediante una clave.

| Identificador | Valor | Comportamiento |
|---|---|---|
| `editor.fontSize` | `16` | Tamaño de fuente del editor |
| `editor.minimap.enabled` | `false` | Oculta el Minimap |
| `editor.wordWrap` | `"on"` | Activa el ajuste visual de líneas |

El archivo de Settings de VS Code admite **JSON with Comments (JSONC)**, por lo que puede contener comentarios y comas finales, aunque los ejemplos de este documento utilizan JSON estándar.

**Ventaja:** facilita consultar y modificar varias preferencias de manera explícita.

### Settings UI vs Settings JSON

| Criterio | Settings UI | Settings JSON |
|---|---|---|
| Interacción | Controles visuales | Edición de propiedades |
| Descubrimiento | Búsqueda y categorías | Requiere conocer o consultar identificadores |
| Descripciones | Visibles en la interfaz | No aparecen automáticamente junto a cada propiedad |
| Validación | Controles adaptados al tipo de valor | Diagnósticos y sugerencias del editor |
| Uso habitual | Explorar y modificar preferencias | Revisar configuraciones explícitas |

**Recomendación:** utiliza Settings UI para descubrir una configuración y Settings JSON cuando necesites trabajar directamente con sus identificadores y valores.

No es necesario elegir exclusivamente una interfaz.

---

## 2. Default Settings vs Customized Settings

VS Code incluye valores predeterminados para sus configuraciones.

Estos valores se conocen como **Default Settings**.

Por ejemplo, una configuración puede tener un valor predeterminado aunque no aparezca en nuestro archivo `settings.json`.

### Default Settings

Los Default Settings representan los valores utilizados cuando no existe una configuración aplicable que los sustituya.

Podemos consultarlos desde la Command Palette:

```text
Preferences: Open Default Settings (JSON)
```

Esta vista permite inspeccionar las configuraciones predeterminadas y sus descripciones.

**Importante:** los Default Settings son una referencia, no un archivo que debamos modificar directamente.

Los valores predeterminados pueden cambiar entre versiones de VS Code.

### Customized Settings

Los **Customized Settings** son valores establecidos explícitamente por el usuario.

Por ejemplo:

```json
{
  "editor.fontSize": 18
}
```

Esta configuración sustituye el valor predeterminado de `editor.fontSize` dentro del ámbito correspondiente.

Si eliminamos la propiedad, VS Code vuelve a resolver el valor aplicable mediante sus configuraciones predeterminadas y otros ámbitos que puedan intervenir.

### Configuración ausente vs configuración explícita

Consideremos estos dos escenarios.

**Escenario A — Sin personalización**

```json
{}
```

VS Code utiliza el valor que corresponda según su configuración efectiva.

**Escenario B — Personalización explícita**

```json
{
  "editor.fontSize": 18
}
```

El usuario ha establecido una preferencia concreta.

La ausencia de una propiedad no significa que la funcionalidad esté desactivada.

**Modelo mental:** Default Settings proporciona el comportamiento inicial; Customized Settings expresa nuestras decisiones personales.

---

## 3. Search and Understand Settings

Antes de modificar una preferencia, conviene comprender qué controla y cuáles son sus valores permitidos.

### Buscar una configuración

Abre Settings UI y escribe:

```text
font size
```

VS Code mostrará configuraciones relacionadas con el tamaño de fuente.

Por ejemplo:

**Editor: Font Size**

Su identificador es:

```text
editor.fontSize
```

El nombre visible facilita su descubrimiento, mientras que el identificador permite referirse a ella de manera precisa.

### Interpretar una configuración

Al consultar un Setting debemos identificar:

1. **Nombre:** cómo aparece en la interfaz.
2. **Identificador:** clave utilizada en Settings JSON.
3. **Descripción:** comportamiento que controla.
4. **Tipo:** número, booleano, string, array u objeto.
5. **Valor predeterminado:** comportamiento inicial de VS Code.
6. **Ámbito:** dónde puede configurarse.

Ejemplos:

| Nombre visible | Identificador | Tipo | Ejemplo |
|---|---|---|---|
| Editor: Font Size | `editor.fontSize` | Number | `16` |
| Editor: Minimap Enabled | `editor.minimap.enabled` | Boolean | `false` |
| Editor: Word Wrap | `editor.wordWrap` | String | `"on"` |
| Editor: Line Numbers | `editor.lineNumbers` | String | `"relative"` |
| Editor: Render Whitespace | `editor.renderWhitespace` | String | `"selection"` |

No debemos asumir que todas las configuraciones aceptan cualquier valor.

Por ejemplo:

```json
{
  "editor.wordWrap": "on"
}
```

Es válido, mientras que utilizar un booleano para esta propiedad no representa el tipo esperado.

### Reconocer identificadores

Los Settings utilizan identificadores organizados habitualmente por áreas funcionales.

Ejemplos:

```text
editor.fontSize
editor.wordWrap
workbench.colorTheme
files.autoSave
terminal.integrated.fontSize
```

Los prefijos ayudan a reconocer la funcionalidad relacionada.

Sin embargo, no constituyen una jerarquía de objetos JSON.

Por ejemplo:

```json
{
  "editor.fontSize": 16
}
```

No es equivalente a:

```json
{
  "editor": {
    "fontSize": 16
  }
}
```

VS Code espera el identificador completo como clave.

### Filtrar configuraciones modificadas

Settings UI admite filtros de búsqueda.

Uno especialmente útil es:

```text
@modified
```

Este filtro permite localizar configuraciones modificadas respecto de sus valores predeterminados en el contexto de Settings seleccionado.

También podemos buscar un identificador específico:

```text
@id:editor.fontSize
```

Esto resulta útil cuando conocemos la clave exacta y queremos evitar resultados relacionados.

---

## 4. User Settings and Profiles

Los User Settings pertenecen al contexto de configuración del usuario, pero VS Code también permite trabajar con **Profiles**.

Un Profile puede mantener un conjunto diferenciado de preferencias y otros elementos del entorno.

Por ejemplo:

| Profile | Preferencias posibles |
|---|---|
| Personal | Tema oscuro y fuente de 16 |
| Work | Tema claro y fuente de 14 |
| Learning | Fuente de 18 y Minimap desactivado |

Esto permite adaptar VS Code a diferentes actividades sin modificar constantemente las mismas preferencias.

### ¿Qué debemos tener presente?

- El Profile activo puede determinar qué User Settings se utilizan.
- Algunos Settings pueden mantenerse compartidos entre perfiles, dependiendo de su configuración.
- Modificar una preferencia en un Profile no implica necesariamente modificarla en todos los demás.
- Los Profiles no deben confundirse con las cuentas autenticadas ni con las identidades de Git.

Para este documento trabajaremos con el **Profile actualmente activo**.

La creación, administración y compartición de Profiles se estudiará en `11-vscode-profiles.md`.

---

## 5. Practical Settings for JavaScript/TypeScript Developers

Las siguientes preferencias pueden resultar útiles al trabajar con JavaScript, TypeScript, React o Node.js.

No son configuraciones obligatorias ni representan un estándar universal.

### Legibilidad

```json
{
  "editor.fontSize": 16,
  "editor.lineHeight": 24,
  "editor.minimap.enabled": false
}
```

| Setting | Efecto |
|---|---|
| `editor.fontSize` | Ajusta el tamaño de fuente |
| `editor.lineHeight` | Define la altura de línea en píxeles |
| `editor.minimap.enabled` | Muestra u oculta el Minimap |

Estas preferencias afectan principalmente a la presentación del código.

### Navegación

```json
{
  "editor.lineNumbers": "relative",
  "editor.renderWhitespace": "selection",
  "editor.guides.indentation": true
}
```

| Setting | Efecto |
|---|---|
| `editor.lineNumbers` | Define cómo se muestran los números de línea |
| `editor.renderWhitespace` | Controla la visualización de espacios y tabulaciones |
| `editor.guides.indentation` | Muestra guías visuales de indentación |

Los números de línea relativos pueden resultar útiles para determinados estilos de navegación, pero no todos los desarrolladores los prefieren.

### Edición

```json
{
  "editor.wordWrap": "on",
  "editor.bracketPairColorization.enabled": true
}
```

| Setting | Efecto |
|---|---|
| `editor.wordWrap` | Ajusta visualmente líneas largas |
| `editor.bracketPairColorization.enabled` | Diferencia visualmente pares de brackets |

Por ejemplo, al trabajar con componentes React que contienen JSX anidado, la colorización de brackets puede facilitar la lectura.

**Importante:** estas configuraciones no sustituyen las reglas de TypeScript, ESLint o Prettier.

Tampoco es necesario copiar todos los ejemplos en nuestro `settings.json`.

Una buena configuración personal debe responder a necesidades reales, no a la cantidad de opciones disponibles.

---

## 6. Modify, Reset and Verify a Setting

Para administrar correctamente una preferencia debemos poder identificar su estado anterior, modificarla y comprobar el resultado.

### Modificar desde Settings UI

Ejemplo: cambiar el tamaño de fuente.

1. Abre **User Settings**.
2. Busca `editor.fontSize`.
3. Identifica el valor actual.
4. Introduce un nuevo valor.
5. Observa el cambio en el Editor Area.

El cambio suele aplicarse inmediatamente.

### Modificar desde Settings JSON

Abre:

```text
Preferences: Open User Settings (JSON)
```

Añade o modifica:

```json
{
  "editor.fontSize": 18
}
```

Guarda el archivo si es necesario.

Si ya existen otras propiedades, consérvalas y modifica únicamente la configuración deseada.

### Restablecer una configuración

Desde Settings UI, localiza la configuración modificada y utiliza la opción **Reset Setting** disponible en su menú de acciones.

Desde Settings JSON, elimina la propiedad personalizada.

Por ejemplo, para restablecer `editor.fontSize`, elimina:

```json
"editor.fontSize": 18
```

No es necesario reemplazarla manualmente por el valor predeterminado.

**Diferencia importante:**

- **Reset:** elimina la personalización explícita.
- **Modificar:** establece otro valor personalizado.

Restablecer una preferencia no siempre significa recuperar exactamente el valor visual anterior si existen otros ámbitos de configuración aplicables.

### Verificar el valor efectivo

Una configuración puede aparecer en User Settings y producir un comportamiento diferente en un Workspace determinado.

Para comprobar qué valor está utilizando VS Code:

1. Abre Settings UI.
2. Busca el identificador de la configuración.
3. Comprueba el ámbito seleccionado.
4. Revisa si existen indicadores de configuración en otros ámbitos.
5. Observa el comportamiento real del editor.

No profundizaremos todavía en la jerarquía completa de resolución de Settings.

Por ahora, basta con distinguir entre el **valor personalizado que hemos definido** y el **comportamiento efectivo que observamos**.

---

## 7. Hands-on — Customize and Restore User Settings

**Objetivo:** utilizar Settings UI y Settings JSON para modificar preferencias personales, verificar sus efectos y restaurar el estado original.

**Requisitos:** VS Code Stable instalado.

Reutilizaremos el Workspace `command-palette-lab` del documento anterior, si todavía está disponible.

No necesitamos instalar extensiones ni crear un proyecto nuevo.

### 1. Preparar el entorno

Abre `command-palette-lab` en VS Code.

Utiliza el archivo `src/app.js` creado anteriormente.

Antes de comenzar:

1. Comprueba qué Profile está activo.
2. Abre **Preferences: Open User Settings (JSON)**.
3. Registra los valores originales de las siguientes propiedades, incluyendo si estaban ausentes:

```text
editor.fontSize
editor.minimap.enabled
editor.wordWrap
```

Puedes guardar temporalmente esa información en una nota fuera del archivo de Settings.

**Importante:** si una propiedad no existe, registra que estaba ausente en lugar de asumir un valor predeterminado.

### 2. Modificar una preferencia desde Settings UI

1. Abre Settings UI mediante `Cmd/Ctrl + ,`.
2. Comprueba que estás en el ámbito **User**.
3. Busca `editor.fontSize`.
4. Establece temporalmente el valor `18`.
5. Regresa a `src/app.js`.

**Verificación:** el texto del editor debe mostrarse con el tamaño configurado, siempre que no exista otra configuración aplicable que lo sustituya.

### 3. Modificar preferencias desde Settings JSON

Abre:

```text
Preferences: Open User Settings (JSON)
```

Añade o modifica únicamente estas propiedades:

```json
{
  "editor.minimap.enabled": false,
  "editor.wordWrap": "on"
}
```

Conserva el resto de tus preferencias existentes, incluido el cambio de `editor.fontSize` realizado en el paso anterior.

**Verificación:**

- El Minimap debe quedar oculto.
- Las líneas que superen el ancho disponible del Editor Area deben ajustarse visualmente.
- El contenido del archivo no debe modificarse por activar Word Wrap.

Para observar Word Wrap, puedes reducir temporalmente el ancho del Editor Area o utilizar una línea suficientemente larga.

### 4. Localizar las configuraciones modificadas

Regresa a Settings UI.

Introduce:

```text
@modified
```

Comprueba que aparecen las preferencias personalizadas en el ámbito correspondiente.

Después, busca:

```text
@id:editor.fontSize
```

Verifica que puedes localizar una configuración mediante su identificador exacto.

### 5. Restaurar las preferencias originales

Utiliza los valores registrados en el primer paso.

Para cada propiedad:

- Si existía originalmente, restaura su valor anterior.
- Si estaba ausente, elimina la propiedad añadida.
- Si la modificaste desde Settings UI, también puedes utilizar **Reset Setting** cuando corresponda eliminar una personalización que no existía.

Comprueba que el archivo User Settings conserva las demás preferencias sin cambios.

**Resultado esperado:**

| Acción | Verificación |
|---|---|
| Abrir Settings UI | Accedes a las preferencias del usuario |
| Modificar `editor.fontSize` | Cambia el tamaño visual del código |
| Modificar `editor.minimap.enabled` | Se oculta el Minimap |
| Modificar `editor.wordWrap` | Las líneas largas se ajustan visualmente |
| Buscar `@modified` | Localizas preferencias personalizadas |
| Buscar por identificador | Encuentras un Setting específico |
| Restaurar preferencias | Recuperas el estado inicial de User Settings |

**Resultado de la práctica:** puedes descubrir, modificar y restablecer preferencias personales utilizando ambas interfaces de configuración sin alterar el código del proyecto.

---

## Key Takeaways

- **Settings UI** facilita descubrir y modificar configuraciones mediante controles visuales.
- **Settings JSON** permite trabajar directamente con identificadores y valores.
- **Default Settings** define los valores iniciales; las configuraciones personalizadas expresan preferencias explícitas.
- Los identificadores, como `editor.fontSize`, permiten reconocer una configuración de manera precisa.
- Los filtros `@modified` y `@id:` facilitan localizar Settings.
- El Profile activo puede influir en el conjunto de User Settings utilizado.
- Antes de modificar preferencias existentes, conviene registrar sus valores para poder restaurarlas correctamente.
- Las preferencias personales deben mejorar la experiencia de desarrollo sin imponer reglas innecesarias al proyecto.

### 🚀 Siguiente paso

Continuaremos con la configuración específica de un Workspace y aprenderemos a modificar preferencias que se aplican únicamente al entorno de trabajo abierto.

👉 [05 — VS Code Workspace Settings](./05-vscode-workspace-settings.md)