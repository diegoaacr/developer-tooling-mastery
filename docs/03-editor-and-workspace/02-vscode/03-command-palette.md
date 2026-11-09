# 03 — Command Palette

## Overview

La **Command Palette** es uno de los mecanismos principales para interactuar con Visual Studio Code.

Permite buscar y ejecutar acciones del editor utilizando sus nombres, sin necesidad de recorrer menús o recordar todos los atajos de teclado.

Desde ella podemos abrir configuraciones, reorganizar el Workbench, cambiar el lenguaje de un archivo, acceder a herramientas de desarrollo y ejecutar funcionalidades incorporadas por extensiones.

Al finalizar este documento podrás:

- Abrir y utilizar la Command Palette en macOS, Windows y Linux.
- Diferenciar la búsqueda de comandos de la navegación rápida entre archivos.
- Localizar y ejecutar comandos mediante búsquedas parciales.
- Reconocer la relación entre comandos, atajos de teclado y extensiones.
- Utilizar comandos habituales para organizar y controlar VS Code.

## 1. What Is the Command Palette?

La **Command Palette** es una interfaz de búsqueda y ejecución de comandos disponibles en VS Code.

Un comando representa una acción que el editor o una de sus extensiones puede realizar.

Por ejemplo:

- Abrir la configuración del usuario.
- Mostrar una vista del Workbench.
- Cambiar el lenguaje asociado a un archivo.
- Dividir el Editor Area.
- Restaurar la ubicación de las vistas.

En lugar de navegar por diferentes menús, podemos buscar una acción por su nombre y ejecutarla directamente.

### Abrir la Command Palette

| Sistema operativo | Atajo habitual |
|---|---|
| macOS | `Cmd + Shift + P` |
| Windows | `Ctrl + Shift + P` |
| Linux | `Ctrl + Shift + P` |

También podemos abrirla desde:

**View → Command Palette**

Al abrirla, VS Code muestra un campo de búsqueda precedido por el símbolo `>`.

Ejemplo:

```text
> View: Toggle Primary Side Bar Visibility
```

El símbolo `>` indica que estamos buscando comandos.

**Modelo mental:** la Command Palette permite encontrar qué acción queremos realizar, sin tener que recordar dónde está ubicada.

---

## 2. Command Palette vs Quick Open

VS Code utiliza una interfaz de búsqueda rápida que admite diferentes modos de navegación.

Dos de los más importantes son **Command Palette** y **Quick Open**.

| Característica | Command Palette | Quick Open |
|---|---|---|
| Propósito principal | Buscar y ejecutar comandos | Localizar y abrir archivos |
| Atajo macOS | `Cmd + Shift + P` | `Cmd + P` |
| Atajo Windows / Linux | `Ctrl + Shift + P` | `Ctrl + P` |
| Prefijo habitual | `>` | Sin prefijo |
| Ejemplo | `View: Toggle Panel` | `src/App.tsx` |
| Resultado | Ejecuta una acción | Abre un archivo o recurso |

### Ejemplo: buscar un archivo

Supongamos que tenemos:

```text
my-app/
├── src/
│   ├── App.tsx
│   └── components/
│       └── Button.tsx
└── package.json
```

Abrimos Quick Open:

```text
Cmd/Ctrl + P
```

Escribimos:

```text
Button.tsx
```

VS Code muestra los archivos coincidentes y podemos seleccionar el correspondiente.

### Ejemplo: ejecutar un comando

Abrimos la Command Palette:

```text
Cmd/Ctrl + Shift + P
```

Escribimos:

```text
View: Toggle Panel
```

Seleccionamos el comando para mostrar u ocultar el Panel.

### Una misma interfaz, diferentes modos

Quick Open también permite acceder a comandos introduciendo `>`.

Por ejemplo:

```text
> View: Toggle Panel
```

Por tanto, Command Palette y Quick Open no son dos sistemas completamente independientes.

**La diferencia principal es el modo de búsqueda que utilizamos: archivos o comandos.**

Otros prefijos permiten acceder a diferentes mecanismos de navegación, pero los estudiaremos cuando resulten necesarios.

---

## 3. Search and Execute Commands

### Buscar por nombre

Para ejecutar un comando:

1. Abre la Command Palette.
2. Escribe una palabra o parte del nombre de la acción.
3. Revisa los resultados disponibles.
4. Selecciona el comando con las flechas del teclado o el ratón.
5. Pulsa `Enter` para ejecutarlo.

Por ejemplo, busca:

```text
Toggle Panel
```

VS Code puede mostrar el comando:

```text
View: Toggle Panel
```

No es necesario escribir siempre el nombre completo.

### Buscar por términos parciales

La búsqueda admite coincidencias parciales y mecanismos de búsqueda aproximada (*fuzzy matching*).

Por ejemplo:

| Búsqueda | Comando que podemos localizar |
|---|---|
| `settings` | Preferences: Open Settings (UI) |
| `user settings json` | Preferences: Open User Settings (JSON) |
| `split editor` | View: Split Editor Right |
| `language mode` | Change Language Mode |
| `reset view` | View: Reset View Locations |

Los resultados dependen de la versión de VS Code, del contexto activo y de las extensiones disponibles.

### Navegar por los resultados

| Acción | Control habitual |
|---|---|
| Seleccionar resultado anterior | `Arrow Up` |
| Seleccionar resultado siguiente | `Arrow Down` |
| Ejecutar comando seleccionado | `Enter` |
| Cerrar la Command Palette | `Esc` |

Algunos comandos ejecutan una acción inmediatamente.

Otros abren una nueva selección, solicitan información adicional o muestran una interfaz específica.

Por ejemplo, **Change Language Mode** abre una lista de lenguajes disponibles para el archivo activo.

### Comandos dependientes del contexto

No todos los comandos están disponibles en cualquier momento.

Algunas acciones requieren:

- Un archivo abierto.
- Un Workspace activo.
- Una selección de texto.
- Una sesión de depuración.
- Una extensión instalada y habilitada.

Por ejemplo, determinados comandos relacionados con un Editor solo tienen sentido cuando existe un Editor activo.

**Importante:** que un comando no aparezca o no pueda ejecutarse no significa necesariamente que VS Code esté funcionando incorrectamente. Puede depender del contexto o de una funcionalidad no disponible.

---

## 4. Commands, Keyboard Shortcuts and Extensions

### Commands vs Keyboard Shortcuts

Un **Command** representa una acción.

Un **Keyboard Shortcut** o *Keybinding* es una combinación de teclas que puede invocar esa acción.

Ejemplo:

| Elemento | Ejemplo |
|---|---|
| Command | View: Toggle Primary Side Bar Visibility |
| Keyboard Shortcut en macOS | `Cmd + B` |
| Keyboard Shortcut en Windows / Linux | `Ctrl + B` |

Ambos mecanismos pueden ejecutar la misma funcionalidad.

Esto significa que no necesitamos memorizar todos los atajos para utilizar VS Code eficientemente.

Podemos comenzar buscando comandos por nombre y aprender progresivamente los atajos de las acciones que utilizamos con mayor frecuencia.

Algunos comandos no tienen un atajo asignado por defecto.

### Comandos incorporados y comandos de extensiones

VS Code dispone de comandos propios y también permite que las extensiones registren nuevos comandos.

| Origen | Ejemplo de funcionalidad |
|---|---|
| VS Code | Mostrar u ocultar el Panel |
| VS Code | Abrir User Settings |
| VS Code | Dividir el Editor |
| Extensión | Ejecutar una operación específica de una herramienta integrada |
| Extensión | Abrir una vista o funcionalidad adicional |

La Command Palette actúa como un punto de acceso común a estas acciones.

No todas las funcionalidades que aparecen en ella pertenecen necesariamente al núcleo del editor.

Además, algunas funcionalidades integradas de VS Code se distribuyen mediante extensiones incorporadas.

**Principio:** la Command Palette permite descubrir y ejecutar capacidades disponibles; no instala ni habilita automáticamente las herramientas que necesita cada comando.

---

## 5. Useful Commands for Daily Work

Los siguientes comandos permiten realizar operaciones habituales sin profundizar todavía en configuraciones avanzadas.

### Navegación y edición

| Comando | Utilidad |
|---|---|
| `View: Split Editor Right` | Dividir el Editor Area hacia la derecha |
| `View: Close Editor` | Cerrar el Editor activo |
| `Change Language Mode` | Cambiar el lenguaje asociado al archivo activo |
| `File: Reveal in File Explorer` | Mostrar el archivo en el explorador del sistema, cuando esté disponible |

### Configuración

| Comando | Utilidad |
|---|---|
| `Preferences: Open Settings (UI)` | Abrir la interfaz gráfica de Settings |
| `Preferences: Open User Settings (JSON)` | Abrir las configuraciones de usuario en formato JSON |
| `Preferences: Open Workspace Settings (JSON)` | Abrir la configuración del Workspace, cuando corresponda |

Por ahora, únicamente necesitamos saber cómo acceder a estas opciones.

Los User Settings y Workspace Settings se estudiarán operativamente en los siguientes documentos.

### Organización del Workbench

| Comando | Utilidad |
|---|---|
| `View: Toggle Primary Side Bar Visibility` | Mostrar u ocultar la Primary Side Bar |
| `View: Toggle Panel` | Mostrar u ocultar el Panel |
| `View: Toggle Secondary Side Bar Visibility` | Mostrar u ocultar la Secondary Side Bar |
| `View: Reset View Locations` | Restaurar las ubicaciones predeterminadas de las vistas |
| `View: Toggle Zen Mode` | Activar o desactivar un modo de edición con menos distracciones |

Los nombres mostrados pueden variar ligeramente entre versiones.

**Recomendación práctica:** busca primero el nombre de la funcionalidad y confirma el comando antes de ejecutarlo, especialmente cuando una acción pueda modificar archivos o configuraciones.

---

## 6. Hands-on — Navigate VS Code with Commands

**Objetivo:** utilizar la Command Palette para descubrir comandos, ejecutar acciones y reorganizar el Workbench sin depender de extensiones adicionales.

**Requisitos:** VS Code Stable instalado.

### 1. Preparar el Workspace

Crea una carpeta llamada `command-palette-lab` y ábrela en VS Code.

Estructura:

```text
command-palette-lab/
├── src/
│   ├── app.js
│   └── utils.js
└── README.md
```

**`src/app.js`**

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
# Command Palette Lab

Learning how to execute VS Code commands.
```

No ejecutaremos el código. La práctica se centra en navegación y comandos del editor.

### 2. Comparar Quick Open y Command Palette

1. Abre Quick Open con `Cmd/Ctrl + P`.
2. Busca `app.js` y ábrelo.
3. Abre la Command Palette con `Cmd/Ctrl + Shift + P`.
4. Busca `Change Language Mode`.
5. Ejecuta el comando y comprueba que **JavaScript** es el lenguaje seleccionado. Si no lo es, selecciónalo.

**Verificación:** Quick Open permite localizar el archivo; Command Palette permite ejecutar una acción sobre él.

### 3. Ejecutar comandos de organización

Con `app.js` abierto:

1. Abre la Command Palette y busca `Split Editor Right`.
2. Ejecuta **View: Split Editor Right**.
3. Abre `utils.js` en el segundo Editor Group utilizando Quick Open.
4. Busca y ejecuta **View: Toggle Panel**.
5. Ejecuta nuevamente el mismo comando para recuperar la visibilidad anterior del Panel.

**Verificación:** puedes visualizar dos Editor Groups y controlar el Panel mediante comandos.

### 4. Descubrir comandos de configuración

1. Abre la Command Palette.
2. Busca `Open Settings`.
3. Selecciona **Preferences: Open Settings (UI)**.
4. Comprueba que se abre la interfaz de configuración.
5. Cierra ese Editor sin modificar ninguna preferencia.

**Verificación:** has localizado una funcionalidad utilizando únicamente su nombre.

### 5. Restaurar el entorno

1. Ejecuta **View: Reset View Locations**.
2. Cierra el Editor Group adicional creado durante la práctica.
3. Si alguna región permanece oculta, recupérala desde **View → Appearance**.

El comando de restauración de vistas no elimina automáticamente los Editor Groups, por lo que debemos cerrar los grupos adicionales por separado.

**Resultado esperado:**

| Acción | Resultado verificable |
|---|---|
| Quick Open | Abre `app.js` por nombre |
| Change Language Mode | Identifica JavaScript como lenguaje del archivo |
| Split Editor Right | Crea un segundo Editor Group |
| Toggle Panel | Alterna la visibilidad del Panel |
| Open Settings | Abre la interfaz de configuración |
| Reset View Locations | Restaura las ubicaciones predeterminadas de las vistas |

**Resultado de la práctica:** puedes localizar y ejecutar comandos sin memorizar sus atajos ni depender de extensiones adicionales.

---

## Key Takeaways

- La **Command Palette** centraliza la búsqueda y ejecución de acciones disponibles en VS Code.
- `Cmd/Ctrl + Shift + P` abre directamente el modo de comandos.
- **Quick Open** se utiliza principalmente para localizar archivos; el prefijo `>` permite acceder al modo de comandos.
- Podemos buscar comandos mediante nombres completos, términos parciales o coincidencias aproximadas.
- Los comandos representan acciones; los Keyboard Shortcuts son mecanismos para invocarlas.
- Las extensiones pueden incorporar comandos adicionales y algunos dependen del contexto activo.
- Conocer la Command Palette reduce la dependencia de menús y facilita descubrir funcionalidades del editor.

### 🚀 Siguiente paso

Continuaremos con la configuración personal de VS Code y aprenderemos a gestionar las preferencias del usuario desde su interfaz y sus archivos de Settings.

👉 [04 — VS Code User Settings](./04-vscode-user-settings.md)