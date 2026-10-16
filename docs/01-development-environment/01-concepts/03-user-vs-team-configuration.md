# User vs Team Configuration

En el documento anterior aprendimos que las configuraciones pueden existir en diferentes ámbitos: sistema, usuario, proyecto o proceso.

También comprendimos que no todo lo que existe en nuestra computadora debe compartirse mediante Git.

Ahora necesitamos responder una pregunta importante:

**¿Qué configuraciones debería controlar cada desarrollador y cuáles deberían definirse como estándares del equipo?**

Esta distinción es fundamental para construir entornos profesionales que permitan trabajar con libertad individual sin comprometer la consistencia del proyecto.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué es User Configuration.
- Qué es Team Configuration.
- Qué diferencia existe entre preferencias individuales y requisitos compartidos.
- Por qué User Configuration y Local Configuration no significan exactamente lo mismo.
- Qué decisiones conviene estandarizar dentro de un equipo.
- Cómo pueden coexistir diferentes editores, terminales y sistemas operativos.
- Qué son los Engineering Standards.
- Qué significa tener una configuración compartida como fuente de referencia.
- Cómo se aplican y verifican los acuerdos técnicos.
- Por qué los estándares deben equilibrar consistencia, flexibilidad y mantenimiento.

---

## 🧠 1. El problema: diferentes desarrolladores, diferentes preferencias

Imagina que tres desarrolladores trabajan en la misma aplicación.

Ana utiliza:

```text
macOS
VS Code
Zsh
Dark Theme
```

Carlos utiliza:

```text
Windows
WebStorm
PowerShell
Light Theme
```

Lucía utiliza:

```text
Linux
Neovim
Bash
Custom Keyboard Shortcuts
```

Los tres pueden trabajar correctamente en el mismo proyecto.

Sus preferencias personales no necesitan ser idénticas.

Pero ahora imaginemos que cada uno utiliza reglas diferentes para analizar y formatear el código.

```text
Developer A
    ↓
Formatting Rules A

Developer B
    ↓
Formatting Rules B

Developer C
    ↓
Formatting Rules C
```

Esto puede producir cambios innecesarios, verificaciones inconsistentes y conflictos durante la colaboración.

Aquí aparece una necesidad:

**Distinguir las preferencias individuales de los requisitos compartidos del equipo.**

---

## 👤 2. ¿Qué es User Configuration?

**User Configuration** es la configuración asociada a un usuario o a sus preferencias y herramientas personales.

Puede incluir:

- Preferencias del editor.
- Apariencia de la terminal.
- Atajos de teclado.
- Configuración personal del Shell.
- Identidad utilizada en Git.
- Aliases personales.
- Preferencias de accesibilidad.

Por ejemplo:

```text
Developer
    ↓
User Preferences
    ├── Editor Theme
    ├── Font Size
    ├── Keyboard Shortcuts
    └── Shell Aliases
```

Estas configuraciones permiten adaptar el entorno de trabajo a las necesidades individuales.

### Ejemplo: preferencias del editor

Ana prefiere un tema oscuro.

Carlos prefiere un tema claro.

Ambos pueden utilizar las mismas reglas de formato del proyecto.

```text
Different Editor Themes
          +
Shared Formatting Rules
          ↓
Compatible Development Workflow
```

No necesitamos imponer una apariencia idéntica para obtener resultados técnicos consistentes.

### Una precisión importante

**User Configuration no significa necesariamente configuración exclusiva de una computadora.**

Una persona podría sincronizar determinadas preferencias entre varias computadoras.

Por ejemplo:

```text
Developer Account
       ↓
Synchronized Preferences
       ↓
Laptop + Desktop
```

Lo importante es que estas decisiones pertenecen principalmente al usuario, no al contrato técnico compartido del proyecto.

---

## 👥 3. ¿Qué es Team Configuration?

**Team Configuration** representa las configuraciones, convenciones y requisitos que un equipo acuerda utilizar para colaborar y mantener software.

Por ejemplo:

```text
Engineering Team
       ↓
Shared Standards
       ├── Runtime Requirements
       ├── Formatting Rules
       ├── Linting Rules
       ├── Commit Conventions
       ├── Validation Commands
       └── Contribution Workflow
```

Estas decisiones ayudan a establecer expectativas comunes.

No todas deben implementarse mediante un archivo de configuración.

Algunas pueden expresarse mediante:

- Configuraciones versionadas.
- Scripts.
- Documentación.
- Políticas del Repository.
- Automatizaciones.
- Procesos de revisión.

Por tanto, Team Configuration es un concepto más amplio que un archivo concreto.

---

## 🔍 4. User vs Team Configuration

Comparemos ambas categorías.

| Criterio | User Configuration | Team Configuration |
|---|---|---|
| Propósito | Adaptar el entorno personal | Establecer acuerdos compartidos |
| Responsable habitual | Desarrollador | Equipo o responsables técnicos |
| Alcance | Usuario y sus herramientas | Equipo, Repository o proyecto |
| Ejemplos | Tema del editor, aliases | Linting, versiones requeridas |
| Flexibilidad | Generalmente alta | Depende del requisito |
| Forma de compartir | Opcional, personal | Documentación, Git o políticas |
| Validación | Según preferencia personal | Puede verificarse automáticamente |

Estas categorías no son necesariamente excluyentes.

Una herramienta puede admitir preferencias individuales y configuraciones compartidas al mismo tiempo.

---

## 🧩 5. Local vs Project no es lo mismo que User vs Team

Este punto conecta directamente con el documento anterior.

Estudiamos dos distinciones:

**Local vs Project Configuration**

Nos ayuda a identificar dónde se mantiene una configuración y cuál es su alcance respecto al proyecto.

**User vs Team Configuration**

Nos ayuda a identificar quién decide la configuración y si representa una preferencia individual o un acuerdo compartido.

No son dos clasificaciones idénticas.

Por ejemplo:

| Configuración | Ubicación habitual | Responsabilidad |
|---|---|---|
| Tema personal del editor | Usuario | User |
| Reglas de ESLint versionadas | Proyecto | Team |
| Versión requerida de Node.js | Proyecto | Team |
| Credencial personal para acceder a un servicio | Local o gestor de secretos | Personal, sujeta a políticas de seguridad |
| Configuración de un agente corporativo | Máquina | Team / Organization |
| Ajustes personales no versionados de un proyecto | Proyecto local | User |

Observa el caso del agente corporativo.

Puede instalarse y configurarse localmente, pero sus requisitos pueden provenir de la organización.

Por eso:

**Local no siempre significa User, y Project no siempre significa Team.**

Debemos evaluar cada dimensión por separado.

---

## ⚖️ 6. Personal Freedom vs Project Consistency

Un equipo necesita equilibrar dos objetivos.

### Personal Freedom

Permitir que los desarrolladores utilicen herramientas y preferencias que favorezcan su productividad.

Por ejemplo:

```text
VS Code
WebStorm
Neovim
```

### Project Consistency

Mantener requisitos y resultados técnicos suficientemente consistentes.

Por ejemplo:

```text
Shared Lint Rules
Shared Formatting Rules
Required Runtime Version
Common Validation Commands
```

Conceptualmente:

```text
Personal Preferences
        +
Shared Project Requirements
        ↓
Consistent Collaboration
```

El objetivo no es eliminar todas las diferencias.

Queremos evitar aquellas que afectan negativamente al desarrollo, la integración y el mantenimiento.

---

## 🏗️ 7. ¿Qué configuraciones conviene compartir?

Podemos utilizar un criterio sencillo:

**Si una decisión afecta a cómo se construye, comprueba o mantiene el proyecto, probablemente merece ser compartida o documentada.**

Por ejemplo:

| Configuración | ¿Conviene compartirla? | Motivo |
|---|---|---|
| Reglas de Formatting | Sí, habitualmente | Evitar diferencias de estilo |
| Reglas de Linting | Sí, habitualmente | Verificaciones consistentes |
| Opciones de TypeScript | Sí | Definir criterios de tipos y compilación |
| Versión requerida de Node.js | Sí | Reducir incompatibilidades |
| Scripts del proyecto | Sí | Establecer comandos comunes |
| Tema del editor | Generalmente no | Preferencia visual |
| Tamaño de fuente | Generalmente no | Preferencia personal |
| Aliases personales del Shell | Generalmente no | Productividad individual |
| Secretos personales | No mediante Git | Seguridad |

No debemos convertir estas recomendaciones en reglas absolutas.

Por ejemplo, determinadas configuraciones de accesibilidad pueden ser necesarias para un desarrollador sin que deban imponerse al resto del equipo.

---

## 📄 8. Shared Configuration as a Source of Truth

En un equipo necesitamos saber dónde consultar los requisitos oficiales del proyecto.

Imagina que tenemos tres documentos diferentes que indican versiones distintas de Node.js.

```text
README.md
    ↓
Node.js Version A

Internal Wiki
    ↓
Node.js Version B

Team Message
    ↓
Node.js Version C
```

Esto genera incertidumbre.

Una estrategia mejor es definir una referencia clara para cada requisito.

Por ejemplo:

```text
Declared Runtime Requirement
            ↓
Project Documentation
            ↓
Developer Setup
```

Podríamos utilizar un archivo de versión o un campo de metadata del proyecto, dependiendo de las herramientas elegidas.

La documentación debería explicar cómo utilizar ese requisito.

### ¿Qué significa Source of Truth?

En este contexto, una **Source of Truth** es la referencia reconocida para consultar una determinada información.

No significa que deba existir un único archivo para todas las configuraciones.

Por ejemplo:

```text
Runtime Requirement
    → Version Declaration

Linting Rules
    → Linter Configuration

Contribution Process
    → CONTRIBUTING.md
```

Cada responsabilidad puede tener su propia referencia.

Lo importante es evitar información contradictoria y mantenerla actualizada.

---

## 🔧 9. Ejemplo: Formatting como estándar compartido

Imagina que un equipo desarrolla una aplicación TypeScript.

Dos desarrolladores escriben:

```ts
const user = { name: "Ana", active: true };
```

y:

```ts
const user={name:'Ana',active:true}
```

Ambos fragmentos pueden tener el mismo comportamiento.

Pero generan diferencias de presentación.

El equipo puede acordar utilizar un Formatter.

Conceptualmente:

```text
Team Agreement
      ↓
Shared Formatter Configuration
      ↓
Developer A
Developer B
Developer C
      ↓
Consistent Formatting
```

Por ejemplo, una configuración de Prettier podría contener:

```json
{
  "singleQuote": true,
  "semi": true
}
```

Este fragmento es ilustrativo; todavía no estamos configurando Prettier.

Lo importante es que las reglas se decidan y mantengan como parte del proyecto.

Así, el resultado no dependerá exclusivamente de las preferencias personales del editor.

---

## 🧪 10. Ejemplo: Runtime Version

Imagina que una aplicación requiere una versión determinada de Node.js.

Sin un requisito compartido:

```text
Developer A → Node.js Version A
Developer B → Node.js Version B
Developer C → Node.js Version C
```

Esto puede generar incompatibilidades.

Una solución es declarar qué versión o rango de versiones admite el proyecto.

```text
Project Runtime Requirement
            ↓
Developer Environments
            ↓
Compatible Runtime Versions
```

No necesariamente todos deben utilizar una única versión exacta.

Dependerá de la política de compatibilidad del proyecto.

Más adelante estudiaremos cómo declarar y administrar versiones de Node.js dentro de `04-runtime-management`.

---

## 🔐 11. Team Standards no significa compartir secretos

Un equipo puede establecer requisitos sobre variables de entorno y acceso a servicios.

Por ejemplo:

```text
Required Environment Variables
          ↓
API_BASE_URL
API_TOKEN
```

Pero debemos distinguir:

**El nombre y propósito de una variable pueden documentarse. Su valor secreto no debe publicarse en Git.**

Por ejemplo, podemos compartir:

```dotenv
API_BASE_URL=
API_TOKEN=
```

mediante un archivo de ejemplo.

Los valores reales pueden distribuirse mediante mecanismos autorizados y seguros.

Además, un equipo puede establecer políticas sobre:

- Gestión de credenciales.
- Permisos mínimos.
- Rotación de secretos.
- Acceso a recursos corporativos.
- Protección de datos sensibles.

Estas políticas forman parte de los estándares de trabajo, aunque los secretos permanezcan fuera del Repository.

---

## 🧭 12. ¿Cómo se aplican los estándares del equipo?

Un estándar puede existir en distintos niveles.

### Level 1 — Documentation

El equipo documenta una convención.

Por ejemplo:

> Los cambios deben superar las verificaciones de Linting.

### Level 2 — Shared Configuration

El Repository incluye la configuración correspondiente.

```text
Repository
    ↓
Shared Lint Configuration
```

### Level 3 — Common Commands

El proyecto proporciona comandos consistentes para ejecutar las verificaciones.

```text
Project Scripts
    ↓
Lint
Type Check
Test
```

### Level 4 — Automated Validation

Las verificaciones se ejecutan mediante automatización.

```text
Pull Request
      ↓
CI
      ↓
Validation Results
```

Estas capas pueden complementarse.

No todos los acuerdos necesitan automatización, pero los requisitos críticos y verificables suelen beneficiarse de controles consistentes.

Estudiaremos estas implementaciones en módulos posteriores.

---

## 🚦 13. Recomendaciones vs Requisitos obligatorios

No todas las decisiones compartidas deben tener la misma importancia.

Podemos distinguir:

### Required

Condiciones necesarias para desarrollar, validar o entregar correctamente el proyecto.

Ejemplo:

```text
Required:
Use a supported Node.js version.
```

### Recommended

Prácticas que el equipo aconseja, pero que pueden admitir alternativas.

Ejemplo:

```text
Recommended:
Use an editor with TypeScript support.
```

### Personal

Decisiones que cada desarrollador puede tomar libremente.

Ejemplo:

```text
Personal:
Choose your editor theme.
```

Esta distinción ayuda a evitar políticas innecesariamente rígidas.

También facilita el Onboarding, porque permite identificar qué debemos configurar obligatoriamente y qué podemos personalizar.

---

## 🏢 14. Engineering Standards

Los **Engineering Standards** son acuerdos técnicos y prácticas que una organización o equipo adopta para desarrollar software de manera consistente.

Pueden incluir:

```text
Engineering Standards
│
├── Development Environment
├── Code Quality
├── Version Control
├── Dependency Management
├── Testing
├── Security
├── CI
└── Documentation
```

No todos los estándares pertenecen exclusivamente a Developer Tooling.

Pero las herramientas pueden ayudar a implementarlos.

Por ejemplo:

```text
Standard
All code must pass lint checks
        ↓
Configuration
Shared ESLint Rules
        ↓
Automation
CI Validation
```

El estándar define una expectativa.

La herramienta y la automatización ayudan a comprobar su cumplimiento.

---

## 🧠 15. ¿Quién decide los estándares?

Depende de la organización.

En algunos equipos las decisiones se toman colectivamente.

En otros intervienen:

- Tech Leads.
- Software Architects.
- Platform Engineers.
- Engineering Managers.
- Equipos de Security.
- Responsables de Developer Experience.

Sin embargo, no debemos asumir que una única persona siempre decide todas las configuraciones.

Una buena decisión técnica debería considerar:

```text
Problem
    ↓
Team Requirements
    ↓
Alternatives
    ↓
Trade-offs
    ↓
Decision
    ↓
Documentation
    ↓
Review
```

Los estándares también deben poder evolucionar.

Una convención útil hoy puede necesitar cambios cuando cambian las herramientas o los requisitos del proyecto.

---

## 🔄 16. Standards Are Not Permanent

Imagina que un equipo utiliza una herramienta de Formatting.

Tiempo después evalúa una alternativa.

No debería cambiar únicamente porque la nueva herramienta sea popular.

Conviene analizar:

- Beneficios concretos.
- Compatibilidad.
- Costes de migración.
- Impacto en CI.
- Integración con editores.
- Mantenimiento futuro.
- Efecto sobre los proyectos existentes.

Conceptualmente:

```text
Existing Standard
       ↓
New Requirement or Opportunity
       ↓
Evaluation
       ↓
Decision
       ↓
Controlled Migration
```

Esto nos recuerda que los estándares deben tener un propósito y mantenerse mediante decisiones justificadas.

---

## 🧪 17. Práctica: clasificar decisiones de equipo

Imagina que te incorporas a un proyecto profesional.

El equipo utiliza:

```text
Node.js
TypeScript
ESLint
Prettier
Git
VS Code
```

Debes decidir cuáles de las siguientes configuraciones deberían ser obligatorias, recomendadas o personales.

| Decisión | Clasificación sugerida |
|---|---|
| Utilizar una versión compatible de Node.js | Required |
| Superar las verificaciones de ESLint | Required |
| Respetar el formato definido por el proyecto | Required |
| Utilizar VS Code | Recommended, si es el editor sugerido |
| Utilizar un tema oscuro | Personal |
| Utilizar atajos personalizados | Personal |
| Ejecutar los Scripts oficiales del proyecto | Required para las verificaciones correspondientes |
| Utilizar una extensión específica del editor | Recommended, salvo necesidad justificada |

### Ejercicio de reflexión

Para cada decisión, responde:

1. ¿Afecta al funcionamiento del proyecto?
2. ¿Afecta a otros desarrolladores?
3. ¿Puede verificarse automáticamente?
4. ¿Existen alternativas compatibles?
5. ¿Qué problema resuelve convertirla en estándar?
6. ¿Qué coste introduce imponerla?

Estas preguntas te ayudarán a distinguir requisitos reales de preferencias personales.

---

## ⚠️ Errores comunes

### 1. Confundir User Configuration con Local Configuration

Una configuración puede existir localmente y representar una política del equipo.

### 2. Pensar que todos deben utilizar el mismo editor

Lo importante es que las herramientas elegidas permitan cumplir los requisitos del proyecto.

### 3. Convertir preferencias personales en reglas obligatorias

Un estándar debe resolver una necesidad compartida.

### 4. Mantener configuraciones contradictorias

Debemos definir referencias claras para los requisitos importantes.

### 5. Pensar que documentar una regla garantiza su cumplimiento

La documentación ayuda, pero algunas reglas necesitan verificaciones.

### 6. Compartir secretos para facilitar el Onboarding

Las credenciales deben gestionarse mediante mecanismos seguros.

### 7. Imponer demasiados estándares

La estandarización excesiva puede aumentar la fricción y reducir la flexibilidad sin aportar beneficios reales.

### 8. Pensar que los estándares nunca deben cambiar

Las decisiones técnicas deben revisarse cuando cambian las necesidades.

---

## 🧠 Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es User Configuration?
2. ¿Qué es Team Configuration?
3. ¿Qué diferencia existe entre ambas?
4. ¿Por qué Local Configuration no significa necesariamente User Configuration?
5. ¿Por qué varios desarrolladores pueden utilizar editores diferentes?
6. ¿Qué configuraciones conviene compartir?
7. ¿Qué significa Source of Truth?
8. ¿Por qué no debe existir información contradictoria sobre los requisitos del proyecto?
9. ¿Qué diferencia existe entre un estándar documentado y uno automatizado?
10. ¿Qué diferencia existe entre Required, Recommended y Personal?
11. ¿Qué son los Engineering Standards?
12. ¿Quién puede participar en la definición de estándares?
13. ¿Por qué no debemos compartir secretos mediante Git?
14. ¿Por qué los estándares deben poder evolucionar?
15. ¿Cómo equilibramos libertad individual y consistencia del proyecto?

---

## 💡 Idea clave

Un equipo profesional no necesita que todos sus desarrolladores tengan entornos idénticos.

Necesita que las diferencias personales no comprometan los requisitos compartidos.

```text
Developer A Preferences ──┐
                          │
Developer B Preferences ──┼──→ Shared Team Standards
                          │              ↓
Developer C Preferences ──┘      Consistent Development
```

Las preferencias personales favorecen la productividad individual.

Los estándares compartidos favorecen la colaboración y la confiabilidad del proyecto.

**La clave no es estandarizarlo todo, sino identificar qué debe ser consistente y qué puede permanecer flexible.**

---

## 🚀 Siguiente paso

Ahora comprendemos cómo se relacionan las configuraciones individuales con los acuerdos técnicos de un equipo.

Pero todavía necesitamos resolver un problema importante:

**¿Cómo conseguimos que diferentes desarrolladores puedan preparar un entorno compatible y ejecutar el mismo proyecto de manera consistente?**

En el siguiente documento estudiaremos el concepto de reproducibilidad y por qué es fundamental para el desarrollo profesional.

👉 [Reproducible Environments](./04-reproducible-environments.md)