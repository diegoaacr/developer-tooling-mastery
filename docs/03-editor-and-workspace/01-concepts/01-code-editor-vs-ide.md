# 01 — Code Editor vs IDE

## Overview

Un **Code Editor** y un **IDE (Integrated Development Environment)** son herramientas que facilitan el desarrollo de software, pero difieren principalmente en cómo organizan e integran sus capacidades.

Comprender esta diferencia permite elegir herramientas adecuadas, identificar qué componente es responsable de cada operación y evitar confundir el editor con el entorno que realmente ejecuta nuestro código.

En este documento utilizaremos **Visual Studio Code (VS Code)** como referencia, junto con algunos IDEs representativos.

## Core Concepts

### ¿Qué es un Code Editor?

Un **Code Editor** es una aplicación diseñada principalmente para crear, leer, modificar y navegar archivos de código fuente.

Sus responsabilidades habituales incluyen:

- **Text Editing:** escritura y modificación de archivos.
- **Syntax Highlighting:** representación visual de la sintaxis.
- **Code Navigation:** búsqueda y navegación entre archivos y símbolos.
- **Code Completion:** sugerencias durante la escritura, cuando existe soporte para el lenguaje.
- **File Management:** exploración y organización de archivos.

Un editor moderno puede ampliar considerablemente estas capacidades mediante extensiones, servicios de lenguaje y herramientas externas.

**Ejemplos:** VS Code, Sublime Text, Zed y Neovim.

No todos ofrecen las mismas funcionalidades de forma nativa ni utilizan el mismo modelo de extensibilidad.

### ¿Qué es un IDE?

Un **IDE (Integrated Development Environment)** es un entorno que reúne y coordina herramientas utilizadas durante el ciclo de desarrollo de software.

Además de editar código, suele ofrecer una experiencia integrada para actividades como:

- Comprender la estructura de un proyecto.
- Analizar código y detectar problemas.
- Ejecutar y depurar aplicaciones.
- Administrar configuraciones de ejecución.
- Ejecutar pruebas.
- Refactorizar código.
- Integrarse con compiladores, Build Tools y sistemas de control de versiones.

**Ejemplos:** IntelliJ IDEA, WebStorm, Visual Studio y Android Studio.

La característica fundamental no es simplemente disponer de más funcionalidades, sino **integrarlas dentro de una experiencia de desarrollo coherente**.

Un IDE tampoco ejecuta necesariamente el código por sí mismo: puede integrar y coordinar Runtimes, SDKs, Compilers y Debuggers externos. La diferencia respecto a un Code Editor está principalmente en el grado y la forma de integración de estas herramientas, no en qué aplicación ejecuta físicamente el programa.

### Diferencias fundamentales

| Aspecto | Code Editor | IDE |
|---|---|---|
| Enfoque principal | Edición y navegación de código | Flujo de desarrollo integrado |
| Capacidades iniciales | Dependen del editor | Suelen incluir más herramientas coordinadas |
| Extensibilidad | Frecuentemente mediante Plugins o Extensions | También mediante Plugins e integraciones |
| Análisis de código | Puede depender de servicios de lenguaje | Suele estar integrado con el modelo del proyecto |
| Debugging | Puede ser nativo, extensible o externo | Habitualmente integrado |
| Build y ejecución | Se conecta con herramientas externas | Coordina herramientas del proyecto desde su interfaz |
| Configuración | Puede requerir seleccionar integraciones | Suele ofrecer convenciones específicas por plataforma o lenguaje |

Esta tabla describe tendencias, no reglas universales.

Un editor extensible puede proporcionar muchas capacidades asociadas tradicionalmente con los IDEs. Del mismo modo, un IDE puede ser modular y altamente configurable.

### VS Code: un editor con capacidades de IDE

VS Code es un ejemplo importante porque combina:

- Un núcleo de edición y navegación.
- Funcionalidades integradas, como terminal y Source Control.
- Soporte para extensiones.
- Servicios de lenguaje.
- Integraciones con Debuggers, Runtimes y herramientas del proyecto.

Por ejemplo, VS Code ofrece soporte integrado para JavaScript y TypeScript, incluyendo funcionalidades de edición inteligente basadas en el servicio de lenguaje de TypeScript.

También permite ampliar su comportamiento mediante extensiones.

Por eso puede ofrecer una experiencia cercana a la de un IDE completo.

**La distinción entre Code Editor e IDE no es una frontera técnica absoluta: depende del grado de integración, las capacidades disponibles y la experiencia que proporciona la herramienta.**

---

## How It Works

### El editor no es el Runtime

Consideremos un proyecto Node.js:

```text
my-project/
├── src/
│   └── index.js
└── package.json
```

Nuestro archivo contiene:

```javascript
console.log("Hello from Node.js");
```

Podemos escribirlo y guardarlo utilizando VS Code.

Pero cuando ejecutamos:

```bash
node src/index.js
```

las responsabilidades se distribuyen de esta manera:

| Componente | Responsabilidad |
|---|---|
| VS Code | Permite editar, guardar y navegar el código |
| Terminal integrada | Proporciona una interfaz para interactuar con un Shell |
| Shell | Interpreta el comando y solicita su ejecución |
| Sistema operativo | Participa en la creación y administración del proceso |
| Node.js | Ejecuta el programa JavaScript |
| Aplicación | Produce el resultado definido por nuestro código |

**VS Code no ejecuta JavaScript por sí mismo en este escenario.** El Runtime responsable es Node.js.

Incluso si iniciamos la ejecución mediante un botón o una Task del editor, sigue existiendo una herramienta responsable de ejecutar el programa.

### El editor tampoco es necesariamente el Compiler

Consideremos TypeScript:

```typescript
const message: string = "Hello TypeScript";
```

VS Code puede mostrar información de tipos y diagnósticos mientras escribimos.

Sin embargo, debemos distinguir dos responsabilidades:

**Language Service**

Proporciona funcionalidades de análisis e inteligencia de código:

- Autocompletado.
- Diagnósticos.
- Navegación entre símbolos.
- Información de tipos.
- Refactorizaciones compatibles.

**Language Server**

Es un proceso o componente que puede proporcionar estas funcionalidades a un editor mediante un protocolo de comunicación, como **LSP (Language Server Protocol)**.

No todos los Language Services utilizan LSP. VS Code puede integrar servicios de lenguaje mediante distintos mecanismos, incluyendo APIs propias del editor y servidores que implementan LSP.

**Compiler / Build Tool**

Realiza operaciones como:

- Comprobar tipos.
- Transformar código.
- Generar archivos de salida, según su configuración.
- Preparar artefactos para ejecución o distribución.

En TypeScript, el servicio de lenguaje y el compilador comparten tecnología del ecosistema TypeScript, pero cumplen funciones distintas dentro del flujo de desarrollo.

Que el editor no muestre errores no sustituye necesariamente una verificación del proyecto mediante sus herramientas de compilación o CI.

### Responsabilidades de las herramientas

| Herramienta | Responsabilidad principal |
|---|---|
| Code Editor | Editar y navegar código |
| Language Service | Proporcionar análisis e inteligencia de código |
| Language Server | Exponer capacidades de lenguaje a un editor mediante un protocolo como LSP |
| Terminal | Mostrar una interfaz para interactuar con un Shell |
| Runtime | Ejecutar programas |
| Compiler | Analizar y/o transformar código según el lenguaje y sus opciones |
| Build Tool | Coordinar transformaciones y generar artefactos |
| Debugger | Controlar e inspeccionar la ejecución de un programa |
| Package Manager | Administrar dependencias y paquetes del proyecto |
| Version Control | Registrar y administrar cambios en el código |

Estas responsabilidades pueden integrarse visualmente en una sola aplicación, pero **integración no significa que todas las operaciones sean realizadas por el editor**.

---

## Practical Examples

### VS Code vs WebStorm

Para un proyecto React con TypeScript, ambas herramientas pueden proporcionar:

- Autocompletado.
- Navegación entre componentes.
- Refactorizaciones.
- Debugging.
- Integración con Git.
- Ejecución de scripts del proyecto.

La diferencia principal está en cómo ofrecen e integran esas capacidades. Tanto VS Code como WebStorm pueden coordinar herramientas externas para ejecutar, compilar y depurar aplicaciones.

| Criterio | VS Code | WebStorm |
|---|---|---|
| Tipo de producto | Editor extensible | IDE especializado |
| Enfoque | Flexible y adaptable a múltiples tecnologías | Experiencia integrada para JavaScript y TypeScript |
| Extensiones | Parte central de su ecosistema | Plugins y funcionalidades integradas |
| Análisis de proyectos | Servicios de lenguaje y extensiones | Análisis e integración propios del IDE |
| Configuración inicial | Depende de las necesidades del proyecto | Mayor cantidad de funcionalidades listas para utilizar |
| Personalización | Amplia | Amplia, dentro de su ecosistema |

No existe un ganador universal.

La elección depende de las tecnologías, la experiencia deseada, las herramientas del equipo y los requisitos del proyecto.

### Otros ejemplos

**Visual Studio**

IDE especialmente relevante para desarrollo .NET y C++, con herramientas integradas para compilación, depuración y administración de soluciones.

No debe confundirse con Visual Studio Code: son productos diferentes.

**IntelliJ IDEA**

IDE orientado principalmente al ecosistema JVM, con análisis de proyectos, refactorización y herramientas integradas.

**Neovim**

Editor altamente configurable que puede integrar Language Servers, herramientas de diagnóstico y otras funcionalidades mediante Plugins y herramientas externas.

Estos ejemplos muestran que **el nivel de integración y extensibilidad importa más que una clasificación rígida**.

### ¿Cuándo elegir cada enfoque?

Un editor extensible puede ser adecuado cuando:

- Trabajamos con varios lenguajes o tipos de proyectos.
- Preferimos seleccionar nuestras propias integraciones.
- Buscamos una experiencia adaptable.
- Nuestro equipo ya dispone de herramientas de desarrollo bien definidas.

Un IDE más integrado puede ser conveniente cuando:

- Trabajamos intensivamente con un ecosistema específico.
- Necesitamos análisis y refactorizaciones avanzadas.
- Valoramos disponer de un conjunto amplio de funcionalidades coordinadas.
- Queremos reducir la configuración manual de determinadas herramientas.

También debemos considerar licencias, requisitos del sistema, compatibilidad con el proyecto y políticas corporativas.

---

## Hands-on — Identify the Tool Responsibilities

**Objetivo:** comprobar qué operaciones pertenecen al editor y cuáles requieren herramientas externas.

**Requisitos:** VS Code y Node.js instalado y disponible en la terminal.

### 1. Crear un archivo JavaScript

Abre una carpeta de práctica en VS Code y crea:

```text
editor-vs-ide-lab/
└── index.js
```

Contenido de `index.js`:

```javascript
const developer = "Developer Tooling Mastery";

console.log(`Hello, ${developer}!`);
```

Observa que VS Code permite editar el archivo y resaltar su sintaxis sin necesidad de ejecutar el programa.

### 2. Ejecutar el programa

Abre la terminal integrada de VS Code y verifica:

```bash
node --version
```

Después, desde la carpeta del ejercicio, ejecuta:

```bash
node index.js
```

**Resultado esperado:**

```text
Hello, Developer Tooling Mastery!
```

### 3. Ejecutar fuera de VS Code

Abre una terminal independiente del editor.

Accede a la carpeta del ejercicio y ejecuta nuevamente:

```bash
node index.js
```

Deberías obtener el mismo resultado, siempre que Node.js esté disponible y utilices el mismo archivo.

### 4. Verificar el modelo mental

| Observación | Conclusión |
|---|---|
| VS Code permite escribir el archivo | La edición es responsabilidad del editor |
| `node --version` identifica el Runtime disponible | Node.js es una herramienta independiente |
| `node index.js` ejecuta el programa | La ejecución la realiza Node.js |
| El programa también funciona fuera de VS Code | El Runtime no depende del editor |
| La terminal integrada permite introducir comandos | VS Code integra una terminal, pero no sustituye al Shell |

**Resultado de la práctica:** hemos comprobado que el editor y el Runtime colaboran, pero tienen responsabilidades diferentes.

No necesitamos configurar extensiones, Tasks ni Debugging para demostrar esta separación.

---

## Key Takeaways

- Un **Code Editor** se centra en editar y navegar código; un **IDE** ofrece una experiencia de desarrollo más integrada.
- No son categorías completamente excluyentes: las extensiones y herramientas externas pueden ampliar significativamente un editor.
- VS Code puede proporcionar capacidades propias de un IDE mediante funcionalidades integradas, servicios de lenguaje y extensiones.
- El editor, el Runtime, el Compiler, el Debugger y las herramientas del proyecto tienen responsabilidades diferentes, aunque se utilicen desde una misma interfaz.
- Elegir una herramienta profesional depende del contexto del proyecto, no de una clasificación absoluta.

**Modelo mental:** el editor es nuestro punto de interacción con el código y las herramientas; no necesariamente el componente que ejecuta, compila o construye la aplicación.

### 🚀 Siguiente paso

Ahora que comprendemos la responsabilidad del editor, estudiaremos cómo separar las preferencias personales de las configuraciones asociadas a un Workspace.

👉 [02 — User Settings vs Workspace Settings](./02-user-settings-vs-workspace-settings.md)