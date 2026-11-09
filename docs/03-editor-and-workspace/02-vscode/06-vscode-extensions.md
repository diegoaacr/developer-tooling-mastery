# 06 — VS Code Extensions

## Overview

Visual Studio Code dispone de un sistema de **extensiones** que permite incorporar nuevas funcionalidades sin modificar directamente el núcleo del editor.

Mediante extensiones podemos añadir soporte para lenguajes, herramientas de desarrollo, integración con servicios externos, nuevas vistas y comandos.

Sin embargo, instalar más extensiones no significa necesariamente disponer de un mejor entorno de trabajo. Cada extensión introduce código, dependencias y posibles implicaciones de rendimiento, seguridad y mantenimiento.

Al finalizar este documento podrás:

- Diferenciar funcionalidades nativas, extensiones incorporadas y extensiones instaladas por el usuario.
- Descubrir y administrar extensiones desde VS Code.
- Identificar extensiones mediante su Publisher e identificador.
- Controlar su habilitación global y por Workspace.
- Reconocer riesgos y diagnosticar problemas relacionados con extensiones.
- Utilizar comandos básicos de administración desde la terminal.
- Instalar, verificar y desinstalar una extensión de manera controlada.

## 1. How VS Code Extensions Work

Una **VS Code Extension** es un paquete que amplía las capacidades del editor mediante los mecanismos de extensión disponibles en VS Code.

Dependiendo de su propósito, puede incorporar:

- Soporte para lenguajes y archivos.
- Comandos accesibles desde la Command Palette.
- Vistas adicionales en el Workbench.
- Integraciones con herramientas externas.
- Funcionalidades de navegación, análisis o edición.
- Temas visuales e iconos.

No todas las extensiones funcionan de la misma manera.

Algunas aportan recursos declarativos, como temas, mientras que otras ejecutan código mediante el sistema de extensiones de VS Code.

### Built-in Features vs Built-in Extensions vs Installed Extensions

Es importante distinguir tres categorías.

| Categoría | Descripción | Ejemplo |
|---|---|---|
| Built-in Features | Funcionalidades propias del editor | Explorer, Editor Groups, Settings UI |
| Built-in Extensions | Extensiones distribuidas con VS Code | Soporte integrado para JavaScript/TypeScript |
| User-installed Extensions | Extensiones añadidas posteriormente | Prettier - Code formatter |

Las **Built-in Extensions** forman parte de la distribución de VS Code y proporcionan funcionalidades que pueden parecer nativas.

Por ejemplo, VS Code incluye soporte para JavaScript y TypeScript mediante componentes y extensiones integradas.

Esto permite disponer de funcionalidades como resaltado de sintaxis, navegación y diagnósticos sin instalar necesariamente una extensión adicional.

**Principio:** antes de instalar una extensión, comprueba si VS Code ya proporciona la capacidad que necesitas.

### Extension Host

VS Code utiliza procesos o entornos denominados **Extension Hosts** para ejecutar el código de determinadas extensiones.

Esto permite separar parte del funcionamiento de las extensiones del proceso principal de la interfaz.

Sin embargo, esta separación no debe interpretarse como una garantía de aislamiento de seguridad.

Una extensión puede disponer de capacidades significativas sobre el entorno donde se ejecuta, incluyendo acceso a archivos o procesos según su implementación y contexto.

Por ello, debemos tratar las extensiones como software que instalamos y ejecutamos en nuestro equipo.

---

## 2. Discover Extensions

### Extensions View

Podemos abrir la vista **Extensions** mediante:

| macOS | Windows / Linux |
|---|---|
| `Cmd + Shift + X` | `Ctrl + Shift + X` |

También podemos acceder desde el Activity Bar.

La vista permite:

- Buscar extensiones.
- Consultar sus descripciones.
- Identificar al Publisher.
- Revisar información de versiones y actualizaciones.
- Instalar o desinstalar extensiones.
- Habilitarlas o deshabilitarlas.
- Consultar las extensiones instaladas.

### VS Code Marketplace

El **Visual Studio Marketplace** es el catálogo oficial utilizado habitualmente por VS Code para descubrir y distribuir extensiones.

Sitio oficial:

https://marketplace.visualstudio.com/vscode

Cada extensión dispone de una página con información como:

- Nombre.
- Publisher.
- Descripción.
- Versión.
- Historial de cambios, cuando está disponible.
- Instrucciones de uso.
- Información adicional proporcionada por su mantenedor.

Antes de instalar una extensión, conviene revisar su propósito y procedencia.

### Extension Identifier y Publisher

Las extensiones se identifican mediante un identificador con la estructura:

```text
publisher.extension-name
```

Por ejemplo:

```text
esbenp.prettier-vscode
```

| Parte | Valor | Significado |
|---|---|---|
| Publisher | `esbenp` | Identificador del publicador |
| Extension Name | `prettier-vscode` | Identificador de la extensión |
| Extension ID | `esbenp.prettier-vscode` | Identificador completo |

El nombre visible de una extensión no es necesariamente su identificador técnico.

Por ello, para instalar una extensión específica debemos comprobar su **Extension ID**, no únicamente su nombre comercial.

**Importante:** una extensión con un nombre parecido al de una herramienta conocida no necesariamente pertenece al proyecto o Publisher oficial.

---

## 3. Manage Extensions

### Install

Para instalar una extensión desde VS Code:

1. Abre Extensions.
2. Busca la extensión por nombre o identificador.
3. Selecciona el resultado correcto.
4. Comprueba su Publisher y descripción.
5. Pulsa **Install**.

Una vez instalada, puede activarse automáticamente o requerir una acción adicional, dependiendo de la extensión.

Algunas funcionalidades también pueden requerir herramientas externas.

Por ejemplo, instalar una extensión que integra un Linter no garantiza que todas las dependencias necesarias estén disponibles en el proyecto.

### Enable and Disable

VS Code permite habilitar y deshabilitar extensiones sin desinstalarlas.

| Acción | Resultado |
|---|---|
| Enable | Permite utilizar la extensión |
| Disable | Deshabilita la extensión |
| Enable (Workspace) | Habilita la extensión para el Workspace actual |
| Disable (Workspace) | Deshabilita la extensión para el Workspace actual |

Las opciones disponibles dependen del estado de la extensión y del contexto activo.

Deshabilitar una extensión es útil cuando:

- Queremos comprobar si provoca un problema.
- No necesitamos sus funcionalidades temporalmente.
- Queremos evitar su activación en un Workspace concreto.

**Disable no equivale a Uninstall:** los archivos de la extensión permanecen instalados.

### Update

Las extensiones pueden recibir actualizaciones para incorporar funcionalidades, corregir errores o resolver problemas de seguridad.

VS Code permite administrar estas actualizaciones desde Extensions.

Dependiendo de las preferencias del entorno, pueden instalarse automáticamente o requerir intervención del usuario.

En proyectos profesionales conviene prestar atención a cambios importantes de comportamiento, especialmente cuando una extensión participa en tareas habituales de desarrollo.

### Uninstall

Para desinstalar una extensión:

1. Abre Extensions.
2. Localiza la extensión instalada.
3. Abre sus acciones de administración.
4. Selecciona **Uninstall**.
5. Recarga VS Code si se solicita.

La desinstalación elimina el paquete instalado de la extensión en el entorno correspondiente.

No garantiza que desaparezcan todas las preferencias, archivos externos o datos que la extensión haya podido crear.

---

## 4. Global vs Workspace Extension State

Una extensión instalada puede tener diferentes estados de habilitación según el Workspace.

### Global Enablement

Cuando una extensión está habilitada globalmente, puede estar disponible en los Workspaces compatibles que abrimos con ese entorno de VS Code.

Por ejemplo, una extensión para visualizar archivos Markdown puede utilizarse en diferentes repositorios.

### Workspace Enablement

VS Code también permite controlar la habilitación de determinadas extensiones para un Workspace específico.

Supongamos que trabajamos en dos proyectos:

```text
projects/
├── react-app/
└── node-api/
```

Una extensión puede resultar útil en `react-app/`, pero innecesaria en `node-api/`.

En ese caso podemos utilizar las opciones de habilitación o deshabilitación por Workspace.

| Situación | Acción posible |
|---|---|
| Extensión necesaria habitualmente | Enable |
| Extensión innecesaria en un proyecto | Disable (Workspace) |
| Extensión deshabilitada globalmente que necesitamos en un proyecto | Enable (Workspace), cuando esté disponible |
| Extensión que ya no utilizamos | Uninstall |

### ¿Qué debemos tener presente?

- **Installed** y **Enabled** representan estados diferentes.
- Una extensión puede estar instalada y deshabilitada.
- La habilitación por Workspace no equivale a instalar una copia independiente para cada proyecto.
- El comportamiento también puede depender del Profile activo y del entorno donde se ejecuta la extensión.

Las opciones de habilitación por Workspace son controles del entorno de VS Code, no una política compartida automáticamente mediante Git.

**No debemos confundirlas con las recomendaciones de extensiones almacenadas en `.vscode/extensions.json`.**

Ese archivo se estudiará en el bloque `03-project-configuration/`.

---

## 5. Security, Trust and Maintenance

Las extensiones forman parte de la cadena de herramientas utilizada durante el desarrollo.

Por ello, debemos evaluar su procedencia y mantenimiento antes de instalarlas.

### Publisher y procedencia

Antes de instalar una extensión:

1. Verifica su identificador completo.
2. Comprueba quién es el Publisher.
3. Consulta la descripción y la documentación.
4. Revisa si dispone de mantenimiento y actualizaciones.
5. Evalúa si realmente necesitas sus funcionalidades.

Una cantidad elevada de instalaciones o una valoración positiva puede aportar contexto, pero no garantiza que una extensión sea segura.

Del mismo modo, un Publisher verificado constituye una señal de procedencia, no una auditoría completa de seguridad.

### Permisos y capacidades

VS Code no utiliza un sistema universal de permisos granulares para extensiones de escritorio equivalente al de las aplicaciones móviles.

Dependiendo de su arquitectura y entorno de ejecución, una extensión puede:

- Leer o modificar archivos.
- Iniciar procesos.
- Comunicarse con servicios externos.
- Acceder a información disponible en su entorno.
- Invocar herramientas instaladas localmente.

Las capacidades concretas dependen de la extensión.

Por tanto, no debemos instalar extensiones desconocidas suponiendo que solo pueden acceder a la funcionalidad que muestran en su interfaz.

### Workspace Trust

VS Code dispone de mecanismos de **Workspace Trust** para limitar determinadas capacidades cuando trabajamos con carpetas que no consideramos confiables.

Algunas extensiones pueden funcionar de forma limitada o quedar deshabilitadas en Restricted Mode, según su compatibilidad y configuración.

Sin embargo, Workspace Trust no sustituye la evaluación de seguridad de las extensiones instaladas.

**Regla práctica:** trata las extensiones como dependencias de tu entorno de desarrollo y los repositorios desconocidos como contenido potencialmente no confiable.

### Mantenimiento y rendimiento

Cada extensión puede introducir:

- Consumo adicional de recursos.
- Procesos o servicios en segundo plano.
- Conflictos con otras extensiones.
- Dependencias de herramientas externas.
- Cambios de comportamiento tras actualizaciones.

Por ello, conviene mantener un conjunto reducido de extensiones que realmente aporten valor.

No necesitamos instalar una extensión para cada lenguaje, Framework o herramienta que aparece en nuestro Stack.

---

## 6. Diagnose Extension Problems

Cuando VS Code presenta un comportamiento inesperado, las extensiones pueden ser una de las causas.

Ejemplos:

- El editor tarda demasiado en iniciar.
- Una funcionalidad deja de responder.
- Aparecen comandos duplicados.
- Dos extensiones intentan proporcionar comportamientos incompatibles.
- Una extensión muestra errores después de actualizarse.

### Verificar si una extensión provoca el problema

Un procedimiento inicial consiste en:

1. Identificar cuándo comenzó el problema.
2. Comprobar si coincide con una instalación o actualización.
3. Deshabilitar temporalmente la extensión sospechosa.
4. Reproducir la operación.
5. Volver a habilitarla para confirmar si el problema reaparece.

Evita desinstalar todas las extensiones sin identificar primero el origen.

### Extension Bisect

VS Code incluye una herramienta denominada **Extension Bisect**.

Podemos iniciarla desde la Command Palette:

```text
Help: Start Extension Bisect
```

Esta funcionalidad deshabilita grupos de extensiones instaladas y solicita comprobar si el problema continúa.

Mediante varias iteraciones ayuda a identificar una extensión potencialmente responsable.

Es especialmente útil cuando tenemos muchas extensiones instaladas y desconocemos cuál provoca el comportamiento.

### Extension Host y logs

VS Code también proporciona herramientas de diagnóstico como:

```text
Developer: Show Running Extensions
```

Esta vista permite consultar información relacionada con las extensiones en ejecución.

Para investigar errores podemos revisar los canales disponibles en **Output**, incluidos los relacionados con Extension Host cuando correspondan.

**Importante:** que una extensión consuma recursos no significa automáticamente que sea defectuosa. Debemos relacionar la información de diagnóstico con un problema reproducible.

---

## 7. Manage Extensions from the CLI

VS Code permite administrar extensiones desde la terminal mediante el comando `code`.

### List installed extensions

Para consultar los identificadores de las extensiones instaladas:

```bash
code --list-extensions
```

Salida ilustrativa:

```text
esbenp.prettier-vscode
ms-vscode.vscode-typescript-next
```

Los resultados reales dependerán de las extensiones instaladas.

Para incluir las versiones:

```bash
code --list-extensions --show-versions
```

Esto resulta útil para identificar exactamente qué extensiones y versiones tenemos instaladas.

**Nota:** el listado de extensiones instaladas no debe interpretarse como una lista de extensiones habilitadas en el Workspace actual.

### Install an extension

Podemos instalar una extensión mediante su identificador:

```bash
code --install-extension esbenp.prettier-vscode
```

El comando utiliza el identificador completo para localizar la extensión.

También podemos instalar un archivo `.vsix` compatible:

```bash
code --install-extension ./extension.vsix
```

En ese caso, debemos verificar cuidadosamente la procedencia del archivo.

### Uninstall an extension

Para desinstalar una extensión:

```bash
code --uninstall-extension esbenp.prettier-vscode
```

### Consultar las opciones disponibles

Podemos revisar los comandos admitidos por nuestra instalación:

```bash
code --help
```

**Importante:** estos comandos operan sobre el entorno de extensiones correspondiente a la instalación y opciones de VS Code utilizadas. No debemos asumir que modifican todas las instalaciones, Profiles o entornos remotos.

---

## 8. Hands-on — Install, Verify and Remove an Extension

**Objetivo:** instalar una extensión conocida, verificar su identificación y funcionamiento, y revertir los cambios sin modificar la configuración del proyecto.

**Requisitos:** VS Code Stable, acceso a VS Code Marketplace y el comando `code` disponible desde la terminal.

Reutilizaremos el Workspace `command-palette-lab` de los documentos anteriores.

Utilizaremos **EditorConfig for VS Code**, una extensión conocida que permite incorporar soporte para EditorConfig en VS Code.

Su identificador es:

```text
EditorConfig.EditorConfig
```

Esta extensión se utilizará únicamente como ejemplo de administración. No configuraremos todavía archivos `.editorconfig`.

### 1. Comprobar el estado inicial

Abre `command-palette-lab` en VS Code.

Desde una terminal ejecuta:

```bash
code --list-extensions
```

Comprueba si aparece:

```text
EditorConfig.EditorConfig
```

**Si ya está instalada, no la desinstales al finalizar.** Registra su versión y estado de habilitación para poder conservarlos.

Para que la práctica sea completamente reversible, lo ideal es utilizar una extensión que no estuviera instalada previamente.

### 2. Instalar la extensión

Abre Extensions mediante `Cmd/Ctrl + Shift + X`.

Busca:

```text
EditorConfig.EditorConfig
```

Antes de instalar, comprueba:

- Nombre: EditorConfig for VS Code.
- Identificador: `EditorConfig.EditorConfig`.
- Publisher: EditorConfig.

Selecciona **Install**.

Como alternativa, puedes instalarla desde la terminal:

```bash
code --install-extension EditorConfig.EditorConfig
```

Utiliza uno de los dos métodos; no es necesario ejecutar ambos.

### 3. Verificar la instalación

Ejecuta:

```bash
code --list-extensions --show-versions
```

Comprueba que aparece una entrada con el identificador y su versión:

```text
EditorConfig.EditorConfig@<version>
```

El número de versión dependerá de la publicación instalada.

Regresa a Extensions y verifica que la extensión aparece como instalada.

**Resultado:** hemos identificado la misma extensión desde la interfaz gráfica y desde la CLI.

### 4. Probar la habilitación por Workspace

Con `command-palette-lab` abierto:

1. Localiza EditorConfig for VS Code en Extensions.
2. Abre su menú de administración.
3. Selecciona **Disable (Workspace)**, si está disponible.
4. Comprueba que VS Code indica su estado deshabilitado para el Workspace.
5. Vuelve a habilitarla mediante **Enable (Workspace)**.

**Verificación:** la extensión permanece instalada mientras cambia su estado de habilitación para el Workspace.

No necesitamos modificar archivos del proyecto.

### 5. Restaurar el entorno

Si la extensión **no estaba instalada inicialmente**, desinstálala desde Extensions o ejecuta:

```bash
code --uninstall-extension EditorConfig.EditorConfig
```

Después, comprueba que ya no aparece en:

```bash
code --list-extensions
```

Si la extensión **ya estaba instalada**, conserva la instalación y restaura su estado de habilitación original.

### Resultado esperado

| Acción | Verificación |
|---|---|
| Buscar una extensión | Identificas nombre, Publisher y Extension ID |
| Instalar | La extensión aparece como instalada |
| Listar desde CLI | `code --list-extensions` muestra su identificador |
| Consultar versión | `--show-versions` muestra la versión instalada |
| Disable (Workspace) | La extensión queda deshabilitada en el Workspace |
| Enable (Workspace) | La extensión vuelve a estar habilitada |
| Desinstalar, si corresponde | La extensión deja de aparecer en el listado |

**Resultado de la práctica:** puedes administrar el ciclo básico de una extensión, distinguir instalación de habilitación y verificar los cambios desde VS Code y la terminal.

---

## Key Takeaways

- Las extensiones amplían las capacidades de VS Code mediante funcionalidades adicionales.
- Debemos distinguir entre Built-in Features, Built-in Extensions y User-installed Extensions.
- El identificador `publisher.extension-name` permite reconocer una extensión de manera precisa.
- **Installed**, **Enabled** y **Disabled** representan estados diferentes.
- VS Code permite controlar la habilitación de determinadas extensiones por Workspace.
- Las extensiones deben evaluarse como software con implicaciones de seguridad, rendimiento y mantenimiento.
- Extension Bisect ayuda a investigar problemas relacionados con extensiones.
- Los comandos `code --list-extensions`, `code --install-extension` y `code --uninstall-extension` permiten administrar extensiones desde la terminal.
- Una instalación profesional debe priorizar extensiones necesarias, confiables y mantenidas.

### 🚀 Siguiente paso

Continuaremos identificando qué extensiones aportan valor real al desarrollo JavaScript/TypeScript y cómo seleccionar un conjunto mínimo según las necesidades del proyecto.

👉 [07 — Recommended Extensions](./07-recommended-extensions.md)