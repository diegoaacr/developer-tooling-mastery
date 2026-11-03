# 04 — Team Editor Consistency

## Overview

En un equipo de desarrollo, cada integrante puede utilizar diferentes editores, sistemas operativos y preferencias personales. Sin embargo, todos deben poder trabajar sobre el mismo código sin introducir diferencias innecesarias.

**Team Editor Consistency** consiste en establecer convenciones compartidas que faciliten la colaboración, manteniendo la libertad de personalizar la experiencia individual.

El objetivo no es conseguir que todos los desarrolladores utilicen un editor idéntico, sino que **las diferencias entre sus entornos no afecten negativamente al código ni al flujo de trabajo del equipo**.

## Core Concepts

### Consistencia no significa uniformidad

Consideremos un equipo que desarrolla una aplicación React con TypeScript:

| Desarrollador | Sistema operativo | Editor |
|---|---|---|
| Frontend Developer | macOS | VS Code |
| Backend Developer | Windows | WebStorm |
| Fullstack Developer | Linux | Neovim |

Los tres pueden colaborar en el mismo repositorio sin compartir exactamente las mismas preferencias.

Por ejemplo:

- Cada desarrollador elige su tema visual y tamaño de fuente.
- El equipo acuerda utilizar espacios en lugar de tabulaciones.
- Los archivos deben mantener una codificación compatible.
- Las herramientas de validación del proyecto aplican las mismas reglas independientemente del editor.

**La consistencia debe centrarse en los resultados compartidos, no en la apariencia individual del entorno.**

### Convenciones compartidas vs preferencias personales

Una decisión importante es identificar qué configuraciones deben ser comunes y cuáles pueden permanecer bajo el control de cada desarrollador.

| Configuración o decisión | Clasificación habitual | Motivo |
|---|---|---|
| Tamaño de fuente | Personal | Accesibilidad y comodidad |
| Tema visual | Personal | Preferencia de visualización |
| Distribución de paneles | Personal | Organización del espacio de trabajo |
| Atajos de teclado | Personal | Productividad individual |
| Indentación | Compartida | Reduce diferencias innecesarias en archivos |
| Codificación de texto | Compartida | Facilita compatibilidad |
| Final de línea | Compartida | Evita cambios accidentales entre sistemas |
| Reglas de formateo | Compartida | Mantiene un estilo de código consistente |
| Reglas de análisis estático | Compartida | Establece criterios comunes de calidad |

Esta clasificación es orientativa.

Por ejemplo, un equipo puede recomendar determinadas extensiones de VS Code, pero eso no implica que todos deban utilizarlas si existen alternativas compatibles.

**Criterio:** compartir una configuración cuando protege una propiedad del proyecto o facilita una operación colectiva; mantenerla personal cuando afecta únicamente a la experiencia individual.

---

## Shared Configuration Responsibilities

La consistencia entre desarrolladores no depende de un único archivo o herramienta.

Existen tres mecanismos complementarios.

### 1. EditorConfig — Convenciones básicas entre editores

**EditorConfig** permite declarar determinadas convenciones de edición mediante un archivo `.editorconfig`.

Su propósito es facilitar que distintos editores y herramientas compatibles interpreten las mismas reglas básicas.

Ejemplo:

```ini
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 2
```

| Propiedad | Responsabilidad |
|---|---|
| `root = true` | Detiene la búsqueda de archivos `.editorconfig` en directorios superiores |
| `charset = utf-8` | Declara la codificación esperada |
| `end_of_line = lf` | Establece LF como final de línea |
| `insert_final_newline = true` | Solicita una línea final |
| `indent_style = space` | Establece espacios para la indentación |
| `indent_size = 2` | Define el tamaño de indentación |

Estas convenciones pueden ser útiles en proyectos JavaScript, TypeScript, React y Node.js.

**Importante:** EditorConfig no transforma automáticamente todos los archivos existentes ni garantiza que cualquier editor aplique todas sus propiedades.

Su comportamiento depende del soporte de la herramienta utilizada. Algunos editores lo incorporan directamente y otros requieren un Plugin.

### 2. Editor Settings — Integración con el entorno

Los editores pueden utilizar configuraciones específicas para adaptar su comportamiento al proyecto.

Por ejemplo, un equipo que utiliza VS Code puede compartir determinadas recomendaciones o configuraciones del Workspace.

Sin embargo, estos ajustes no necesariamente serán interpretados por WebStorm, Neovim u otros editores.

Por ello, debemos evitar que una regla esencial del proyecto exista exclusivamente como una preferencia de VS Code.

**Responsabilidad:** facilitar la experiencia dentro de un editor concreto, respetando las convenciones del proyecto.

La organización y sintaxis de los archivos `.vscode/` se estudiarán en el bloque `03-project-configuration/`.

### 3. Project Tools — Reglas verificables

Herramientas como Prettier, ESLint y TypeScript permiten establecer comportamientos y validaciones que pueden ejecutarse fuera del editor.

Por ejemplo:

| Herramienta | Responsabilidad |
|---|---|
| Prettier | Aplicar reglas de formateo compatibles con su configuración |
| ESLint | Analizar código según reglas configuradas |
| TypeScript | Comprobar tipos y aplicar opciones del compilador |

Un equipo puede integrar estas herramientas en sus scripts y procesos de CI para comprobar el proyecto sin depender del editor utilizado por cada desarrollador.

**Principio:** las convenciones importantes deben poder verificarse mediante las herramientas responsables de aplicarlas.

EditorConfig, Editor Settings y Project Tools pueden complementarse. No son mecanismos intercambiables ni garantizan por sí solos el mismo nivel de consistencia.

---

## Practical Examples

### Caso 1 — Desarrollo entre macOS y Windows

Un equipo trabaja en un repositorio JavaScript.

Un desarrollador utiliza macOS y otro Windows. Sus herramientas pueden utilizar diferentes finales de línea según la configuración del entorno.

Esto puede producir cambios innecesarios en Git cuando se modifican archivos.

El equipo decide utilizar LF para los archivos de código y declara:

```ini
[*]
end_of_line = lf
```

Los editores compatibles pueden utilizar esta convención al guardar archivos.

Sin embargo, Git también dispone de mecanismos propios para gestionar finales de línea. Para una política completa y reproducible, las convenciones del editor deben coordinarse con la configuración del repositorio, como `.gitattributes`.

EditorConfig ayuda durante la edición; Git controla aspectos relacionados con el almacenamiento y la normalización de archivos versionados.

### Caso 2 — Diferentes editores, mismas convenciones

Un desarrollador utiliza VS Code y otro WebStorm.

Ambos trabajan en componentes React:

```tsx
export function Welcome() {
  return <h1>Welcome</h1>;
}
```

El repositorio incluye un archivo `.editorconfig` con convenciones básicas de indentación y finales de línea.

Cada desarrollador conserva sus preferencias personales:

| Aspecto | VS Code | WebStorm |
|---|---|---|
| Tema visual | Dark | Light |
| Tamaño de fuente | 16 | 14 |
| Indentación acordada | 2 espacios | 2 espacios |
| Final de línea acordado | LF | LF |

Las diferencias visuales no afectan al contenido compartido.

Esto funciona siempre que ambos editores tengan soporte adecuado y apliquen las convenciones establecidas.

### Caso 3 — Evitar configuraciones innecesarias

Un equipo propone compartir estas configuraciones de VS Code:

```json
{
  "editor.fontSize": 16,
  "workbench.colorTheme": "Default Dark Modern",
  "editor.minimap.enabled": false
}
```

Aunque técnicamente algunas puedan establecerse en un Workspace, no existe una necesidad evidente de imponerlas.

Una alternativa más sostenible es:

1. Mantener las preferencias visuales como configuraciones personales.
2. Compartir únicamente los ajustes necesarios para colaborar.
3. Documentar las herramientas y convenciones relevantes.
4. Verificar las reglas técnicas mediante herramientas del proyecto.

**Una configuración compartida debe tener una justificación, no simplemente estar disponible.**

---

## Hands-on — Share a Convention Across Editors

**Objetivo:** comprobar cómo un archivo `.editorconfig` puede declarar una convención de edición independiente de las preferencias personales de VS Code.

**Requisitos:** VS Code y soporte de EditorConfig habilitado, ya sea integrado o mediante una extensión compatible.

### 1. Preparar el Workspace

Crea y abre una carpeta llamada `team-consistency-lab`.

Estructura:

```text
team-consistency-lab/
├── .editorconfig
└── example.js
```

En `.editorconfig`, escribe:

```ini
root = true

[*.js]
indent_style = space
indent_size = 2
end_of_line = lf
insert_final_newline = true
```

En `example.js`, escribe:

```javascript
function greet(name) {
  console.log(`Hello, ${name}`);
}

greet("Team");
```

### 2. Verificar la convención

Con `example.js` abierto:

1. Comprueba que el soporte de EditorConfig está activo.
2. Verifica en la barra de estado de VS Code que el tamaño de tabulación corresponde a **2 espacios**.
3. Si VS Code detecta la indentación existente en lugar de aplicar la convención, desactiva temporalmente `editor.detectIndentation` para esta práctica.
4. Crea una nueva línea dentro de la función y comprueba que la indentación utiliza espacios.

La convención no requiere modificar el tema visual ni el tamaño de fuente del desarrollador.

### 3. Comprobar la portabilidad

Abre el mismo proyecto en otro editor compatible con EditorConfig, si tienes uno disponible.

Verifica que interpreta las mismas convenciones de indentación.

Si no dispones de otro editor, comprueba que las reglas permanecen declaradas en `.editorconfig` y no dependen de un archivo exclusivo de VS Code.

**Resultado esperado:**

| Elemento | Resultado |
|---|---|
| `.editorconfig` | Declara convenciones compartidas |
| Editor compatible | Interpreta las reglas correspondientes |
| Preferencias visuales | Permanecen independientes |
| Código existente | No se reformatea automáticamente por crear `.editorconfig` |

**Resultado de la práctica:** hemos separado una convención compartida de las preferencias personales del editor.

Al finalizar, restaura cualquier preferencia temporal que hayas modificado.

---

## Key Takeaways

- La consistencia de equipo no exige utilizar el mismo editor, tema visual o sistema operativo.
- Las convenciones compartidas deben proteger el código y facilitar la colaboración.
- EditorConfig permite declarar reglas básicas de edición para herramientas compatibles.
- Las configuraciones específicas del editor complementan las convenciones del proyecto, pero no deben convertirse en su única fuente de verdad.
- Las herramientas del proyecto permiten aplicar y verificar reglas independientemente del editor.
- Una configuración compartida debe ser mínima, justificable y sostenible.

**Modelo mental:** el equipo comparte convenciones y resultados verificables; cada desarrollador conserva el control de su experiencia personal.

### 🚀 Siguiente paso

Concluimos el bloque **01 — Concepts**. Continuaremos con el uso práctico de Visual Studio Code, comenzando por su instalación y verificación.

👉 [01 — Install VS Code](../02-vscode/01-install-vscode.md)