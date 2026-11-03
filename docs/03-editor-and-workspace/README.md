# 03 — Editor and Workspace

Aprenderemos a utilizar y configurar **Visual Studio Code (VS Code)** como una herramienta profesional de desarrollo, diferenciando las preferencias personales, la configuración del proyecto y los estándares compartidos por un equipo.

El módulo combina fundamentos, configuración práctica y buenas prácticas para construir un entorno de trabajo **productivo, reproducible, seguro y portable**.

## 🎯 Objetivos de aprendizaje

Al finalizar el módulo podrás:

- Diferenciar Code Editors, IDEs y las responsabilidades del editor frente al proyecto.
- Instalar y configurar VS Code en macOS, Windows y, cuando corresponda, Linux.
- Administrar User Settings, Workspace Settings y sus reglas de precedencia.
- Utilizar Command Palette, Extensions, Tasks y Debugging.
- Organizar proyectos mediante Single-folder y Multi-root Workspaces.
- Crear perfiles Personal, Work y Learning, comprendiendo sus límites respecto a las cuentas autenticadas.
- Distinguir cuentas de VS Code, identidad Git y credenciales de autenticación.
- Configurar la terminal integrada y trabajar con Remote SSH, WSL o Dev Containers según el entorno.
- Crear y verificar configuraciones compartidas dentro de `.vscode/`.
- Aplicar criterios de configuración mínima, seguridad y consistencia de equipo.

## 📚 Contenido del módulo

El recorrido está organizado en cuatro bloques, con **28 documentos temáticos**.

### 01 — Concepts

Fundamentos para comprender qué pertenece al editor, al desarrollador y al proyecto.

| Documento | Tema |
|---|---|
| [01 — Code Editor vs IDE](./01-concepts/01-code-editor-vs-ide.md) | Responsabilidades y diferencias |
| [02 — User Settings vs Workspace Settings](./01-concepts/02-user-settings-vs-workspace-settings.md) | Configuración personal y compartida |
| [03 — Editor Configuration vs Project Configuration](./01-concepts/03-editor-configuration-vs-project-configuration.md) | Límites entre editor y herramientas del proyecto |
| [04 — Team Editor Consistency](./01-concepts/04-team-editor-consistency.md) | Convenciones y colaboración |

### 02 — VS Code

Uso práctico de las funcionalidades del editor: instalación, navegación, preferencias, extensiones, Tasks, Debugging y entornos de desarrollo. La sintaxis y configuración reproducible de los archivos JSON se profundizarán en el siguiente bloque.

| Documento | Tema |
|---|---|
| [01 — Install VS Code](./02-vscode/01-install-vscode.md) | Instalación y verificación |
| [02 — VS Code Interface](./02-vscode/02-vscode-interface.md) | Interfaz y navegación |
| [03 — Command Palette](./02-vscode/03-command-palette.md) | Comandos y productividad |
| [04 — VS Code User Settings](./02-vscode/04-vscode-user-settings.md) | Preferencias personales |
| [05 — VS Code Workspace Settings](./02-vscode/05-vscode-workspace-settings.md) | Preferencias por Workspace |
| [06 — VS Code Extensions](./02-vscode/06-vscode-extensions.md) | Instalación y administración |
| [07 — Recommended Extensions](./02-vscode/07-recommended-extensions.md) | Selección justificada de extensiones |
| [08 — VS Code Tasks](./02-vscode/08-vscode-tasks.md) | Ejecución de tareas |
| [09 — VS Code Debugging](./02-vscode/09-vscode-debugging.md) | Breakpoints y depuración |
| [10 — Multi-root Workspaces](./02-vscode/10-multi-root-workspaces.md) | Trabajo con múltiples carpetas |
| [11 — VS Code Profiles](./02-vscode/11-vscode-profiles.md) | Perfiles Personal, Work y Learning |
| [12 — VS Code Accounts and Authentication](./02-vscode/12-vscode-accounts-and-authentication.md) | GitHub, Copilot, Settings Sync y credenciales |
| [13 — VS Code Remote Development](./02-vscode/13-vscode-remote-development.md) | Remote SSH, WSL y Dev Containers |
| [14 — VS Code Terminal Configuration](./02-vscode/14-vscode-terminal-configuration.md) | Shells, perfiles y variables de entorno |

### 03 — Project Configuration

Sintaxis, estructura y mantenimiento de los archivos de configuración de VS Code, con énfasis en configuraciones reproducibles y compartidas.

| Documento | Tema |
|---|---|
| [01 — VS Code Folder](./03-project-configuration/01-vscode-folder.md) | Estructura y propósito de `.vscode/` |
| [02 — settings.json](./03-project-configuration/02-settings-json.md) | Sintaxis y configuración del Workspace |
| [03 — extensions.json](./03-project-configuration/03-extensions-json.md) | Declaración de recomendaciones de extensiones |
| [04 — tasks.json](./03-project-configuration/04-tasks-json.md) | Definición de tareas reutilizables |
| [05 — launch.json](./03-project-configuration/05-launch-json.md) | Configuraciones de depuración |
| [06 — Settings Precedence](./03-project-configuration/06-settings-precedence.md) | Ámbitos, jerarquía y resolución de conflictos |

### 04 — Best Practices

Criterios para mantener un editor eficiente y configuraciones compartidas sostenibles.

| Documento | Tema |
|---|---|
| [01 — Format on Save](./04-best-practices/01-format-on-save.md) | Formateo automático y sus límites |
| [02 — Project Level Settings](./04-best-practices/02-project-level-settings.md) | Configuración adecuada para equipos |
| [03 — Minimal Extension Policy](./04-best-practices/03-minimal-extension-policy.md) | Control de extensiones y mantenimiento |
| [04 — Portable Workspace Configuration](./04-best-practices/04-portable-workspace-configuration.md) | Portabilidad y reproducibilidad |

## 🛠️ Proyecto práctico — Professional Development Workspace

Construiremos progresivamente un Workspace de referencia para JavaScript, incorporando configuraciones conforme aprendamos su responsabilidad.

**Estructura objetivo:**

```text
professional-workspace/
├── .vscode/
│   ├── settings.json
│   ├── extensions.json
│   ├── tasks.json
│   └── launch.json
├── .editorconfig
├── src/
│   └── index.js
├── package.json
└── README.md
```

No crearemos todos estos archivos desde el inicio ni añadiremos configuraciones que no podamos justificar.

| Etapa | Implementación práctica |
|---|---|
| 01 — Concepts | Clasificar configuraciones personales, del editor y del proyecto |
| 02 — VS Code | Instalar y configurar el editor, administrar extensiones y perfiles, ejecutar Tasks y depurar código con Breakpoints |
| 03 — Project Configuration | Incorporar, comprender y verificar los archivos necesarios de `.vscode/` |
| 04 — Best Practices | Revisar seguridad, configuración mínima, consistencia de equipo y portabilidad |

El módulo se centrará en la integración con el editor. La configuración profunda de Node.js, pnpm, Prettier, ESLint y TypeScript se abordará en sus módulos correspondientes.

## ✅ Criterios de finalización

Consideraremos completado el módulo cuando podamos demostrar lo siguiente:

- [ ] Explicar qué configuraciones pertenecen al usuario, al Workspace y al proyecto.
- [ ] Abrir y trabajar en un proyecto con VS Code correctamente configurado.
- [ ] Ejecutar una Task y depurar un archivo JavaScript con Breakpoints.
- [ ] Crear perfiles diferenciados y explicar por qué no garantizan aislamiento de cuentas.
- [ ] Identificar la diferencia entre autenticación de VS Code, identidad Git y credenciales Git.
- [ ] Configurar y verificar la terminal integrada.
- [ ] Reconocer cuándo utilizar Remote SSH, WSL o Dev Containers y probar una modalidad cuando el entorno esté disponible.
- [ ] Crear y validar las configuraciones necesarias de `.vscode/`.
- [ ] Resolver un conflicto de Settings Precedence.
- [ ] Justificar qué configuraciones y extensiones conviene compartir con el equipo.
- [ ] Reproducir las configuraciones compartidas del Workspace en otro entorno, sin depender de preferencias personales ni credenciales privadas.

## 🚀 Comenzar

Iniciamos con los fundamentos y avanzaremos hacia la configuración práctica del editor y del Workspace.

👉 [01 — Code Editor vs IDE](./01-concepts/01-code-editor-vs-ide.md)