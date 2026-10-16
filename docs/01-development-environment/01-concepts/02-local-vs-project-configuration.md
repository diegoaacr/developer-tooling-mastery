# Local vs Project Configuration

En el documento anterior aprendimos qué es un **Development Environment** y cuáles son sus componentes principales.

Ahora necesitamos comprender una distinción fundamental:

**No todas las configuraciones que utilizamos para desarrollar software pertenecen al proyecto.**

Algunas configuraciones existen únicamente en nuestra computadora. Otras forman parte del Repository y deben ser compartidas con los demás desarrolladores.

Comprender esta diferencia nos ayudará a construir entornos más consistentes, reproducibles y fáciles de mantener.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué significa Configuration en un entorno de desarrollo.
- Qué es Local Configuration.
- Qué es Project Configuration.
- Qué diferencia existe entre ambas.
- Por qué una configuración local no debería convertirse automáticamente en un estándar del proyecto.
- Qué configuraciones conviene compartir mediante Git.
- Qué información debe permanecer fuera del Repository.
- Cómo se relacionan las configuraciones locales con las del proyecto.
- Qué significa Configuration Precedence.
- Cómo reconocer problemas provocados por diferencias de configuración.

---

## 🧠 1. ¿Qué es Configuration?

Una **Configuration** es un conjunto de valores, reglas u opciones que determinan cómo debe comportarse un sistema, una herramienta o una aplicación.

Por ejemplo, una herramienta podría permitir configurar:

- Qué archivos debe analizar.
- Qué reglas debe aplicar.
- Qué versión necesita.
- Dónde debe buscar determinados recursos.
- Cómo debe generar sus resultados.

Podemos representar su funcionamiento de manera simplificada:

```text
Tool
  +
Configuration
  ↓
Configured Behavior
```

Imagina que utilizamos un Formatter.

Podríamos definir:

```json
{
  "singleQuote": true,
  "semi": true
}
```

Esta configuración indica determinadas preferencias de formato para una herramienta compatible, como Prettier.

Pero surge una pregunta:

**¿Dónde debería almacenarse esta configuración?**

La respuesta dependerá de su propósito y de quién necesite utilizarla.

---

## 🖥️ 2. ¿Qué es Local Configuration?

**Local Configuration** hace referencia a configuraciones que existen en nuestro entorno de desarrollo y que no necesariamente forman parte del Repository.

Por ejemplo:

```text
Developer Machine
│
├── Operating System Settings
├── Terminal Preferences
├── Shell Configuration
├── Git User Configuration
├── Editor Preferences
└── Local Environment Variables
```

Estas configuraciones pueden afectar nuestra experiencia de desarrollo sin que deban compartirse con todos los miembros del equipo.

### Ejemplo: apariencia de la terminal

Imagina que prefieres utilizar:

```text
Terminal Theme: Dark
Font Size: 14
Font Family: Monospace
```

Otro desarrollador podría utilizar:

```text
Terminal Theme: Light
Font Size: 16
Font Family: Different Monospace
```

Ambas configuraciones son válidas.

No deberían afectar al comportamiento funcional del proyecto.

Por tanto, normalmente pertenecen a las preferencias personales del desarrollador.

### Idea importante

**Local no significa necesariamente global.**

Una configuración local puede pertenecer a una computadora, a un usuario o incluso a un directorio de trabajo específico.

En este documento utilizaremos *Local Configuration* para referirnos principalmente a configuraciones mantenidas fuera del conjunto de archivos compartidos del proyecto.

---

## 📦 3. ¿Qué es Project Configuration?

**Project Configuration** representa las configuraciones asociadas a un proyecto específico.

Estas configuraciones pueden definir requisitos, convenciones o comportamientos necesarios para desarrollar y mantener el software.

Por ejemplo:

```text
my-project/
│
├── src/
├── package.json
├── tsconfig.json
├── eslint.config.js
└── README.md
```

Cada archivo puede cumplir una responsabilidad diferente.

| Archivo | Responsabilidad |
|---|---|
| `package.json` | Declarar metadata, Scripts y dependencias de un Package |
| `tsconfig.json` | Definir opciones para TypeScript |
| `eslint.config.js` | Configurar reglas y comportamiento de ESLint |
| `README.md` | Documentar requisitos e instrucciones del proyecto |

Estos son ejemplos. No todos los proyectos necesitan todos estos archivos.

### ¿Por qué compartir estas configuraciones?

Porque permiten establecer expectativas comunes.

Por ejemplo:

```text
Developer A
     ↓
Same Project Configuration
     ↑
Developer B
```

Si ambos utilizan la configuración compartida, pueden ejecutar verificaciones con criterios más consistentes.

Esto no garantiza resultados idénticos en todos los sistemas, pero reduce diferencias innecesarias.

---

## 🔍 4. Local vs Project Configuration

Comparemos ambas categorías.

| Criterio | Local Configuration | Project Configuration |
|---|---|---|
| Propósito | Personalizar o preparar un entorno | Definir requisitos y comportamiento del proyecto |
| Alcance | Computadora, usuario o entorno local | Proyecto específico |
| Ubicación habitual | Fuera del Repository | Dentro del directorio del proyecto |
| Compartida mediante Git | Generalmente no | Habitualmente sí |
| Ejemplos | Tema de terminal, preferencias personales | ESLint, TypeScript, Scripts |
| Mantenimiento | Desarrollador o administrador del entorno | Responsables del proyecto |

La distinción no es absoluta.

Un proyecto puede utilizar configuraciones locales no versionadas, y una herramienta puede combinar configuraciones de distintos niveles.

Por eso debemos analizar **el propósito y el alcance de cada configuración**, no solamente su ubicación.

---

## 🧩 5. Ejemplo: dos desarrolladores, un proyecto

Imagina que Ana y Carlos trabajan en el mismo Repository.

```text
Shared Repository
│
├── package.json
├── tsconfig.json
└── eslint.config.js
```

Ana utiliza:

```text
macOS
Zsh
VS Code
```

Carlos utiliza:

```text
Windows
PowerShell
WebStorm
```

Sus entornos personales son diferentes.

Pero ambos necesitan respetar determinadas reglas del proyecto.

Conceptualmente:

```text
Ana's Local Environment
          │
          ▼
    Shared Project
          ▲
          │
Carlos's Local Environment
```

Las preferencias personales pueden variar.

Los requisitos técnicos compartidos deben ser compatibles.

**No necesitamos computadoras idénticas para colaborar correctamente.**

Necesitamos identificar qué configuraciones son personales y cuáles forman parte del contrato de desarrollo del proyecto.

---

## ⚙️ 6. ¿Qué configuraciones deberían formar parte del Repository?

Como regla general, conviene versionar las configuraciones necesarias para comprender, construir y validar el proyecto.

Por ejemplo:

```text
Project Requirements
        ↓
Shared Configuration
        ↓
Version Control
```

Podríamos compartir:

- Configuración de TypeScript.
- Reglas de Linting.
- Convenciones de Formatting.
- Scripts del proyecto.
- Metadata y dependencias declaradas.
- Archivos de configuración de herramientas.
- Instrucciones para preparar el entorno.

Por ejemplo:

```json
{
  "scripts": {
    "lint": "eslint .",
    "typecheck": "tsc --noEmit"
  }
}
```

Estos Scripts representan comandos que cualquier colaborador podría utilizar, siempre que las herramientas y dependencias requeridas estén disponibles.

La ventaja es que no necesitamos explicar manualmente comandos diferentes a cada desarrollador.

---

## 🔐 7. ¿Qué configuraciones NO deberíamos compartir?

No todo lo que utilizamos localmente debe incorporarse al Repository.

Debemos prestar especial atención a información sensible.

Por ejemplo:

```text
Passwords
API Tokens
Private Keys
Database Credentials
Personal Access Tokens
```

Estos valores no deberían incorporarse directamente a archivos versionados.

### Ejemplo: variables de entorno

Imagina que una aplicación necesita conectarse a un servicio.

Podríamos utilizar una variable:

```text
API_TOKEN=example-secret-value
```

Este valor es ilustrativo y no representa una credencial real.

No deberíamos publicar un Token auténtico en Git.

En cambio, podemos documentar qué variables necesita el proyecto mediante un archivo de ejemplo:

```text
.env.example
```

Por ejemplo:

```dotenv
API_TOKEN=
API_BASE_URL=
```

Y mantener los valores reales en un mecanismo apropiado para el entorno, como un archivo local ignorado por Git o un gestor de secretos.

### Importante

Agregar un archivo a `.gitignore` evita que Git lo incorpore automáticamente cuando todavía no está siendo rastreado.

Pero **no elimina secretos que ya fueron incorporados al historial**.

Si una credencial real se expone, puede ser necesario revocarla o rotarla.

Estudiaremos Environment Configuration con mayor profundidad en su módulo correspondiente.

---

## 📁 8. ¿Puede existir configuración local dentro del proyecto?

Sí.

Este punto es especialmente importante.

Imagina:

```text
my-project/
│
├── package.json
├── tsconfig.json
├── .env
├── .env.example
└── README.md
```

Aquí podríamos tener:

| Archivo | Uso habitual |
|---|---|
| `package.json` | Configuración compartida del Package |
| `tsconfig.json` | Configuración compartida de TypeScript |
| `.env` | Valores específicos de un entorno, potencialmente sensibles |
| `.env.example` | Referencia compartida de variables requeridas |

Por tanto:

**Estar dentro del directorio del proyecto no significa automáticamente que un archivo deba versionarse.**

Debemos distinguir entre:

```text
Project Directory
        ↓
Tracked Files
    +
Untracked / Ignored Local Files
```

El directorio físico puede contener ambos tipos.

---

## 🧭 9. Configuration Scope

El **Scope** describe el ámbito en el que una configuración tiene efecto.

Podemos encontrar diferentes niveles:

```text
System
   ↓
User
   ↓
Project
   ↓
Process
```

Este diagrama muestra posibles ámbitos, no una jerarquía universal de prioridad.

### System Scope

Configuraciones que afectan al sistema o a múltiples usuarios.

### User Scope

Configuraciones asociadas a una cuenta de usuario.

### Project Scope

Configuraciones aplicables a un proyecto determinado.

### Process Scope

Valores utilizados por un proceso concreto durante su ejecución.

Por ejemplo, una variable de entorno puede definirse para una sesión o para un comando específico, dependiendo del sistema y del Shell.

La forma en que estos ámbitos interactúan depende de cada herramienta.

---

## 🔄 10. Configuration Precedence

**Configuration Precedence** describe qué configuración tiene prioridad cuando existen diferentes valores para una misma opción.

Imagina que una herramienta puede recibir configuraciones desde:

```text
User Configuration
Project Configuration
Command-line Arguments
```

Podría existir un mecanismo para decidir qué valor aplicar.

Pero debemos tener cuidado:

**No existe una única regla de precedencia válida para todas las herramientas.**

Algunas dan prioridad a argumentos de línea de comandos.

Otras utilizan reglas específicas de búsqueda y combinación de archivos.

Incluso pueden existir opciones que se fusionen en lugar de reemplazarse.

Por eso, cuando estudiemos una herramienta concreta, revisaremos:

1. Qué fuentes de configuración admite.
2. Cómo las localiza.
3. Qué opciones tienen prioridad.
4. Qué sucede cuando existen valores contradictorios.

No debemos asumir automáticamente que la configuración del proyecto siempre gana frente a la del usuario.

---

## 🧪 11. Ejemplo práctico: configuración de Git

Git es un buen ejemplo porque permite trabajar con configuraciones de distintos ámbitos.

Podemos consultar nuestra configuración global con:

```bash
git config --global --list
```

Y consultar la configuración local de un Repository ejecutando, desde su interior:

```bash
git config --local --list
```

La configuración local de Git se refiere al Repository, no necesariamente a preferencias personales fuera del proyecto.

Habitualmente se almacena en la configuración interna de Git y no se comparte mediante los archivos versionados del Repository.

### Ejemplo

Podríamos tener:

```text
Global Git Configuration
    ↓
user.name = Developer
```

Y una configuración específica para otro Repository:

```text
Repository Git Configuration
    ↓
user.name = Work Developer
```

Git permite utilizar configuraciones diferentes según el ámbito.

Además, admite otras fuentes de configuración y mecanismos de precedencia.

Profundizaremos en ellos cuando corresponda.

### Precaución

Al consultar configuraciones de Git, revisa el resultado antes de compartirlo públicamente.

Algunas configuraciones pueden contener rutas personales, direcciones de correo u otra información que no conviene publicar.

---

## 🧪 12. Práctica: identificar configuraciones

En esta práctica no modificaremos archivos.

Solamente clasificaremos configuraciones según su propósito.

Considera los siguientes ejemplos:

| Configuración | Clasificación habitual |
|---|---|
| Tema oscuro de la terminal | Local |
| Tamaño de fuente del editor | Local |
| Reglas de ESLint | Project |
| Configuración de TypeScript | Project |
| Token personal de acceso | Local / Secret |
| Scripts de `package.json` | Project |
| Preferencia personal de Shell | Local |
| Versión requerida de Node.js | Project Requirement |
| Ruta de instalación de una herramienta | Environment-specific |
| `.env.example` sin secretos | Project |

### Ejercicio

Para cada elemento, responde:

1. ¿Quién necesita esta configuración?
2. ¿Afecta solamente a mi experiencia personal?
3. ¿Puede modificar el comportamiento del proyecto?
4. ¿Debe compartirse mediante Git?
5. ¿Contiene información sensible?

No todas las respuestas serán binarias.

Por ejemplo, una preferencia del editor puede ser personal, pero determinadas configuraciones del editor pueden representar convenciones compartidas del equipo.

Ese será precisamente el tema del siguiente documento.

---

## 🏢 13. ¿Por qué importa en equipos profesionales?

Imagina que una empresa tiene cinco desarrolladores.

Cada uno configura manualmente las reglas de Linting según sus preferencias.

Podríamos obtener:

```text
Developer A → Rule Set A
Developer B → Rule Set B
Developer C → Rule Set C
```

Esto puede producir resultados inconsistentes.

Una alternativa es mantener reglas compartidas:

```text
Shared Project Configuration
          ↓
Developer A
Developer B
Developer C
```

Así, todos pueden utilizar las mismas reglas durante las verificaciones.

Mientras tanto, cada persona conserva sus preferencias de terminal, editor y otras herramientas cuando no interfieren con los requisitos del proyecto.

El objetivo es equilibrar:

**Personal Flexibility + Project Consistency**

---

## ⚠️ Errores comunes

### 1. Pensar que toda configuración local pertenece al usuario

Puede existir configuración específica de una computadora, Repository, sesión o proceso.

### 2. Pensar que todo archivo dentro del proyecto debe versionarse

Algunos archivos contienen valores locales o secretos y deben mantenerse fuera de Git.

### 3. Compartir credenciales en archivos de configuración

Los secretos requieren mecanismos de almacenamiento y distribución adecuados.

### 4. Asumir que una configuración global es apropiada para todos los proyectos

Diferentes proyectos pueden necesitar requisitos distintos.

### 5. Confundir Project Configuration con Project Directory

La ubicación física de un archivo no determina por sí sola si debe compartirse.

### 6. Asumir una precedencia universal

Cada herramienta puede implementar reglas distintas para resolver configuraciones.

### 7. Versionar preferencias personales innecesarias

Esto puede introducir ruido y restricciones que no aportan valor al equipo.

### 8. No documentar requisitos compartidos

Si una configuración es necesaria para ejecutar el proyecto, debemos procurar que sea declarada o documentada.

---

## 🧠 Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué significa Configuration?
2. ¿Qué es Local Configuration?
3. ¿Qué es Project Configuration?
4. ¿Qué diferencia existe entre ambas?
5. ¿Por qué dos desarrolladores pueden tener preferencias personales diferentes?
6. ¿Qué configuraciones conviene compartir mediante Git?
7. ¿Por qué no debemos versionar Tokens y credenciales?
8. ¿Qué función puede cumplir `.env.example`?
9. ¿Puede existir configuración local dentro del directorio del proyecto?
10. ¿Qué significa Configuration Scope?
11. ¿Qué significa Configuration Precedence?
12. ¿Por qué no existe una precedencia universal?
13. ¿Qué diferencia existe entre la configuración global y local de Git?
14. ¿Qué problemas aparecen cuando cada desarrollador utiliza reglas de proyecto diferentes?
15. ¿Cómo podemos equilibrar flexibilidad personal y consistencia del proyecto?

---

## 💡 Idea clave

No todas las configuraciones deben compartirse, y no todas las configuraciones locales son preferencias personales.

Debemos identificar su propósito, alcance y sensibilidad.

```text
Development Environment
        │
        ├── Local Configuration
        │     ├── Personal Preferences
        │     ├── Machine Settings
        │     └── Local Secrets
        │
        └── Project Configuration
              ├── Shared Requirements
              ├── Tooling Rules
              ├── Project Scripts
              └── Documented Setup
```

Estas categorías pueden interactuar y no son completamente excluyentes.

**Una configuración profesional debe estar en el lugar adecuado, tener un propósito claro y compartirse únicamente cuando corresponda.**

---

## 🚀 Siguiente paso

Ahora comprendemos la diferencia entre configuraciones locales y configuraciones del proyecto.

Pero todavía necesitamos responder una pregunta:

**¿Cómo distinguimos las preferencias de cada desarrollador de las decisiones que deben convertirse en estándares compartidos del equipo?**

👉 [User vs Team Configuration](./03-user-vs-team-configuration.md)