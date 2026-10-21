# 03 — Editor and Workspace

Un editor de código es una de las herramientas con las que más interactúa un desarrollador de software.

Sin embargo, utilizar un editor profesionalmente implica mucho más que escribir código, instalar extensiones o personalizar su apariencia.

Necesitamos comprender cómo funciona, cómo se configura, cómo se integra con nuestras herramientas y cómo preparar un entorno de trabajo consistente para proyectos personales, corporativos y colaborativos.

En este módulo aprenderemos a utilizar **Visual Studio Code (VS Code)** como parte de nuestro entorno de ingeniería de software.

Nuestro objetivo será construir progresivamente un **Professional Development Workspace**: un espacio de trabajo organizado, configurable, reproducible y preparado para trabajar en equipo.

---

## 🎯 Objetivo del módulo

Comprender los fundamentos de los editores modernos y dominar la configuración profesional de VS Code, diferenciando correctamente las preferencias personales, las configuraciones del proyecto y los estándares compartidos por un equipo.

Al finalizar, deberíamos ser capaces de:

- Explicar las diferencias entre un Code Editor y un IDE.
- Comprender los distintos ámbitos de configuración de VS Code.
- Instalar y configurar VS Code en macOS, Windows o Linux.
- Utilizar eficientemente su interfaz y Command Palette.
- Administrar extensiones siguiendo criterios profesionales.
- Crear perfiles para distintos contextos de desarrollo.
- Comprender la relación entre perfiles, cuentas y autenticación.
- Trabajar con Remote SSH, WSL y Dev Containers a nivel introductorio.
- Configurar la terminal integrada.
- Utilizar Tasks y herramientas de Debugging.
- Organizar Workspaces de uno o varios proyectos.
- Configurar archivos compartidos dentro de `.vscode/`.
- Comprender cómo se resuelven configuraciones de distintos ámbitos.
- Establecer convenciones de editor para proyectos y equipos.
- Preparar un Workspace portable y reproducible.

---

## 🧠 Empecemos con el problema

Imaginemos un equipo de desarrollo con tres integrantes.

Cada desarrollador utiliza VS Code, pero sus entornos son diferentes:

- Uno utiliza macOS y Zsh.
- Otro utiliza Windows y PowerShell.
- Otro trabaja con Linux.

Además:

- Cada persona tiene extensiones diferentes.
- Los archivos se formatean de manera distinta.
- Algunas configuraciones solo funcionan en una computadora.
- Los comandos de ejecución no están documentados.
- Cada desarrollador configura manualmente su entorno.
- Los nuevos integrantes necesitan repetir todo el proceso.

Aunque todos utilicen el mismo editor, **no necesariamente tienen un entorno de trabajo consistente**.

El problema no es VS Code.

El problema es no diferenciar correctamente qué configuraciones pertenecen al desarrollador, cuáles pertenecen al proyecto y cuáles deberían compartirse con el equipo.

Durante este módulo aprenderemos a resolver esa situación de manera progresiva.

---

## 📚 Estructura del módulo

El módulo está organizado en cuatro bloques.

| Bloque | Enfoque | Documentos |
|---|---|---:|
| `01-concepts` | Fundamentos y modelos mentales | 4 |
| `02-vscode` | Instalación, uso y configuración práctica | 14 |
| `03-project-configuration` | Configuración reproducible del proyecto | 6 |
| `04-best-practices` | Convenciones y estándares profesionales | 4 |
| **Total** | | **28** |

### 01 — Concepts

Antes de configurar herramientas, necesitamos comprender las responsabilidades del editor y del proyecto.

1. [Code Editor vs IDE](./01-concepts/01-code-editor-vs-ide.md)
2. [User Settings vs Workspace Settings](./01-concepts/02-user-settings-vs-workspace-settings.md)
3. [Editor Configuration vs Project Configuration](./01-concepts/03-editor-configuration-vs-project-configuration.md)
4. [Team Editor Consistency](./01-concepts/04-team-editor-consistency.md)

**Resultado esperado:** comprender qué configuraciones son personales, cuáles pertenecen al proyecto y por qué la consistencia del equipo es importante.

### 02 — VS Code

Aprenderemos a instalar, utilizar y configurar VS Code mediante ejemplos prácticos.

1. [Install VS Code](./02-vscode/01-install-vscode.md)
2. [VS Code Interface](./02-vscode/02-vscode-interface.md)
3. [Command Palette](./02-vscode/03-command-palette.md)
4. [VS Code User Settings](./02-vscode/04-vscode-user-settings.md)
5. [VS Code Workspace Settings](./02-vscode/05-vscode-workspace-settings.md)
6. [VS Code Extensions](./02-vscode/06-vscode-extensions.md)
7. [Recommended Extensions](./02-vscode/07-recommended-extensions.md)
8. [VS Code Tasks](./02-vscode/08-vscode-tasks.md)
9. [VS Code Debugging](./02-vscode/09-vscode-debugging.md)
10. [Multi-root Workspaces](./02-vscode/10-multi-root-workspaces.md)
11. [VS Code Profiles](./02-vscode/11-vscode-profiles.md)
12. [VS Code Accounts and Authentication](./02-vscode/12-vscode-accounts-and-authentication.md)
13. [VS Code Remote Development](./02-vscode/13-vscode-remote-development.md)
14. [VS Code Terminal Configuration](./02-vscode/14-vscode-terminal-configuration.md)

**Resultado esperado:** utilizar VS Code de forma profesional y adaptar su funcionamiento a diferentes contextos de desarrollo.

Aprenderemos a diferenciar especialmente:

- **Profiles:** preferencias, configuraciones y extensiones asociadas a distintos perfiles.
- **Accounts:** sesiones autenticadas en servicios como GitHub y Microsoft.
- **Git Identity:** identidad utilizada para registrar la autoría de commits.
- **Git Credentials:** mecanismos utilizados para autenticar operaciones con repositorios.

Un perfil de VS Code no garantiza por sí mismo el aislamiento completo de las cuentas autenticadas.

### 03 — Project Configuration

Estudiaremos cómo incorporar configuraciones de VS Code directamente en nuestros proyectos.

1. [VS Code Folder](./03-project-configuration/01-vscode-folder.md)
2. [settings.json](./03-project-configuration/02-settings-json.md)
3. [extensions.json](./03-project-configuration/03-extensions-json.md)
4. [tasks.json](./03-project-configuration/04-tasks-json.md)
5. [launch.json](./03-project-configuration/05-launch-json.md)
6. [Settings Precedence](./03-project-configuration/06-settings-precedence.md)

**Resultado esperado:** comprender, crear y mantener configuraciones de Workspace que puedan compartirse y versionarse cuando corresponda.

También aprenderemos cómo interactúan los distintos ámbitos de configuración y qué sucede cuando existen valores diferentes para una misma preferencia.

### 04 — Best Practices

Finalmente, estableceremos criterios profesionales para mantener Workspaces consistentes y fáciles de utilizar.

1. [Format on Save](./04-best-practices/01-format-on-save.md)
2. [Project Level Settings](./04-best-practices/02-project-level-settings.md)
3. [Minimal Extension Policy](./04-best-practices/03-minimal-extension-policy.md)
4. [Portable Workspace Configuration](./04-best-practices/04-portable-workspace-configuration.md)

**Resultado esperado:** aplicar convenciones que mejoren la experiencia de desarrollo sin imponer configuraciones personales innecesarias a todo el equipo.

---

## 🛠️ Nuestro proyecto práctico: Professional Development Workspace

A medida que avancemos construiremos un Workspace de referencia para un proyecto JavaScript/TypeScript.

No crearemos toda la configuración desde el primer día.

Incorporaremos cada archivo cuando comprendamos su responsabilidad y podamos verificar su funcionamiento.

### Estructura objetivo

```text
professional-workspace/
│
├── .vscode/
│   ├── settings.json
│   ├── extensions.json
│   ├── tasks.json
│   └── launch.json
│
├── .editorconfig
│
├── src/
│   └── index.js
│
├── package.json
│
└── README.md
```

Esta estructura representa nuestro objetivo de aprendizaje, no una configuración obligatoria para todos los proyectos.

Algunos archivos serán opcionales y su inclusión dependerá de las necesidades reales del equipo.

### ¿Qué construiremos progresivamente?

| Etapa | Implementación | Verificación |
|---|---|---|
| Foundations | Identificar configuraciones personales y del proyecto | Explicar dónde corresponde cada preferencia |
| VS Code Setup | Instalar y preparar el editor | Abrir un proyecto y utilizar sus funciones básicas |
| User Configuration | Personalizar preferencias | Comprobar los cambios en el editor |
| Extensions | Instalar y administrar extensiones | Verificar su funcionamiento |
| Tasks | Crear tareas de desarrollo | Ejecutar comandos desde VS Code |
| Debugging | Configurar escenarios de depuración | Ejecutar código con Breakpoints |
| Profiles | Crear perfiles Personal, Work y Learning | Comparar sus configuraciones y extensiones |
| Remote Development | Conectar con un entorno remoto cuando esté disponible | Abrir y trabajar en un proyecto remoto |
| Project Configuration | Crear archivos dentro de `.vscode/` | Verificar configuraciones compartidas |
| Best Practices | Aplicar convenciones profesionales | Comprobar portabilidad y consistencia |

El objetivo es que cada configuración tenga una razón de existir.

---

## 🔄 Metodología de aprendizaje

Seguiremos nuestro ciclo habitual:

**Learn → Experiment → Implement → Debug → Build → Explain**

### Learn

Comprender qué problema resuelve una herramienta o configuración.

### Experiment

Explorar su comportamiento mediante ejemplos sencillos.

### Implement

Aplicar la configuración en nuestro Workspace.

### Debug

Investigar errores o comportamientos inesperados.

### Build

Integrar lo aprendido en un entorno de desarrollo funcional.

### Explain

Ser capaces de justificar nuestras decisiones técnicas.

No todos los documentos necesitarán un laboratorio completo. Los documentos conceptuales priorizarán la comprensión y los documentos prácticos incluirán procedimientos verificables cuando corresponda.

---

## 💻 Plataformas y herramientas

Trabajaremos principalmente con:

- Visual Studio Code.
- macOS.
- Windows.
- Linux, cuando corresponda.
- Bash, Zsh y PowerShell.
- Git y GitHub.
- JavaScript y TypeScript.
- Node.js.
- npm y pnpm.
- GitHub Copilot.
- SSH.
- WSL y Dev Containers.

Utilizaremos estas herramientas como contexto de aprendizaje, sin profundizar anticipadamente en contenidos que pertenecen a otros módulos.

Por ejemplo:

- La gestión de versiones de Node.js corresponde a `04-runtime-management`.
- Los Package Managers se estudian en `05-package-managers`.
- Las herramientas de Formatting se profundizan en `08-formatting`.
- Las herramientas de Linting se profundizan en `09-linting`.

En este módulo aprenderemos cómo integrarlas con VS Code cuando resulte necesario.

---

## ⚠️ Principios importantes

Durante el módulo mantendremos estas reglas:

1. **Understand Before Configuring:** comprender una configuración antes de copiarla.
2. **Personal vs Project:** distinguir preferencias personales de requisitos compartidos.
3. **Minimal Configuration:** evitar configuraciones innecesarias.
4. **Reproducibility:** documentar lo necesario para preparar otro entorno.
5. **Cross-platform Compatibility:** considerar diferencias entre sistemas operativos.
6. **Security First:** proteger credenciales y revisar extensiones y configuraciones desconocidas.
7. **Verify Your Setup:** comprobar que cada configuración funciona.
8. **Team Consistency:** compartir estándares sin imponer preferencias individuales injustificadas.

No buscaremos tener el editor con más extensiones ni con la configuración más compleja.

Buscaremos tener un editor **comprensible, eficiente y adecuado para el proyecto**.

---

## ✅ Resultados esperados

Al completar el módulo deberíamos contar con:

- [ ] Un modelo mental claro sobre Code Editors, IDEs y Workspaces.
- [ ] VS Code instalado y configurado profesionalmente.
- [ ] Preferencias personales separadas de las configuraciones del proyecto.
- [ ] Un conjunto justificado de extensiones.
- [ ] Conocimiento práctico de Tasks y Debugging.
- [ ] Perfiles de VS Code para diferentes contextos.
- [ ] Comprensión de las limitaciones de autenticación entre perfiles.
- [ ] Conocimiento introductorio de Remote Development.
- [ ] Una terminal integrada correctamente configurada.
- [ ] Un proyecto de referencia con configuraciones `.vscode/`.
- [ ] Comprensión de Settings Precedence.
- [ ] Convenciones para trabajar en equipo.
- [ ] Un Workspace organizado y portable.

Más importante que completar esta lista será poder explicar **por qué configuramos cada elemento y qué problema resuelve**.

---

## 🚀 Comencemos

Antes de instalar extensiones o modificar archivos de configuración, necesitamos comprender una pregunta fundamental:

**¿Qué diferencia existe entre un Code Editor y un IDE, y qué responsabilidades debería asumir cada uno?**

Ese será nuestro punto de partida.

👉 [01 — Code Editor vs IDE](./01-concepts/01-code-editor-vs-ide.md)