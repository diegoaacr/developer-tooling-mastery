# Avoid Global Pollution

## Introducción

Imagina que desarrollamos una aplicación React con TypeScript.

En nuestra computadora ejecutamos:

```bash
tsc --version
```

Y obtenemos una versión de TypeScript.

Todo parece funcionar correctamente.

Sin embargo, otro desarrollador clona el mismo repositorio e intenta ejecutar:

```bash
tsc
```

Y recibe:

```text
command not found
```

¿Por qué sucede?

Porque posiblemente instalamos TypeScript de manera global, pero nunca lo declaramos como una dependencia del proyecto.

Nuestra aplicación depende de algo que existe en nuestra computadora, pero no necesariamente en las computadoras de los demás.

Este problema se conoce como una **Hidden Dependency**: una dependencia que afecta al funcionamiento del proyecto, pero que no está declarada adecuadamente.

Cuando acumulamos herramientas, versiones y configuraciones globales sin una estrategia, podemos generar lo que informalmente denominamos **Global Pollution**.

El objetivo de este documento no es prohibir las instalaciones globales.

Es aprender a utilizarlas correctamente.

Nuestra metodología será:

**Problema → Concepto → Alcance → Riesgos → Herramientas → Estrategias → Práctica → Estandarización.**

---

## 🎯 Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Explicar qué es Global Pollution.
2. Diferenciar instalaciones globales y locales.
3. Comprender qué es una Hidden Dependency.
4. Identificar conflictos de versiones entre proyectos.
5. Comprender cómo interviene PATH.
6. Diferenciar herramientas del sistema, usuario y proyecto.
7. Reconocer cuándo una instalación global es apropiada.
8. Comprender cómo funcionan las dependencias locales de JavaScript.
9. Diferenciar npm, pnpm, Corepack y Runtime Managers.
10. Comprender el papel de `package.json` y los Lockfiles.
11. Reconocer riesgos de las configuraciones globales.
12. Comprender los problemas de privilegios y permisos.
13. Identificar instalaciones duplicadas.
14. Auditar herramientas globales sin modificar el entorno.
15. Diseñar estrategias que favorezcan la reproducibilidad.
16. Aplicar estos principios en proyectos individuales y equipos.

---

# 1. ¿Qué es Global Pollution?

**Global Pollution** es una expresión informal utilizada para describir la acumulación descontrolada de herramientas, dependencias y configuraciones de alcance global o compartido que pueden afectar negativamente a diferentes proyectos.

No es un término técnico formal con una definición universal.

En este Mastery lo utilizaremos para representar un problema de arquitectura del entorno de desarrollo.

## 1.1 Ejemplo

Supongamos que tenemos:

```text
Development Machine
│
├── Global TypeScript
├── Global ESLint
├── Global Vite
├── Global Angular CLI
├── Global pnpm
├── Multiple Node.js Installations
├── Old PATH Entries
└── Global npm Configuration
```

Esto no significa automáticamente que todas esas instalaciones sean incorrectas.

El problema aparece cuando desconocemos:

- Qué versión utiliza cada proyecto.
- Qué instalación tiene prioridad.
- Qué configuraciones se aplican.
- Qué herramientas son necesarias.
- Cómo reconstruir el entorno.

## 1.2 Global Pollution vs Global Installation

Debemos distinguir dos conceptos.

**Global Installation:** instalación de una herramienta en un ámbito compartido, como el entorno del usuario.

**Global Pollution:** situación en la que esas instalaciones o configuraciones generan desorden, conflictos o dependencias ocultas.

Por tanto:

```text
Global Installation ≠ Global Pollution
```

Una instalación global puede estar perfectamente justificada.

### Idea clave

**El problema no es que una herramienta sea global, sino que su alcance y responsabilidad no estén controlados.**

---

# 2. Comprender los diferentes Scopes

Antes de decidir dónde instalar una herramienta debemos comprender el concepto de **Scope**.

Scope significa alcance.

En nuestro contexto, representa dónde se aplica una instalación o configuración.

## 2.1 System Scope

Afecta al sistema o a sus usuarios según los permisos y el mecanismo utilizado.

Ejemplos:

- Utilidades del sistema.
- Compiladores.
- Software administrado por el sistema operativo.

## 2.2 User Scope

Afecta principalmente a un usuario.

Ejemplos:

- Configuración personal del Shell.
- Algunas herramientas CLI.
- Gestores de versiones.
- Extensiones del editor.

## 2.3 Project Scope

Afecta a un repositorio específico.

Ejemplos:

- TypeScript.
- ESLint.
- Vite.
- Vitest.
- Dependencias de aplicación.

## 2.4 Process Scope

Afecta a la ejecución de un proceso y, según las reglas del entorno, puede transmitirse a sus procesos hijos.

Ejemplos:

- Variables de entorno.
- Directorio de trabajo.
- Opciones de ejecución.

## 2.5 Modelo general

```text
Operating System
│
├── System Scope
│
├── User Scope
│   ├── User Configuration
│   └── User Tools
│
└── Project Scope
    ├── Dependencies
    ├── Configuration
    └── Scripts
         │
         ▼
      Process Scope
```

Estos ámbitos pueden superponerse; no constituyen necesariamente compartimentos aislados.

### Principio

**Cuanto más amplio sea el alcance de una configuración, mayor será el número potencial de proyectos afectados.**

---

# 3. ¿Qué es una Hidden Dependency?

Una **Hidden Dependency** es una dependencia necesaria para ejecutar, construir o validar un proyecto que no está declarada o documentada adecuadamente.

## 3.1 Ejemplo

Tenemos este proyecto:

```text
react-application/
├── src/
├── package.json
└── README.md
```

Su `package.json` contiene:

```json
{
  "scripts": {
    "typecheck": "tsc --noEmit"
  }
}
```

Pero no declara TypeScript.

En nuestra computadora el comando puede funcionar porque tenemos `tsc` disponible globalmente.

En otra computadora puede fallar.

## 3.2 Modelo del problema

```text
Developer A
│
├── Global TypeScript
│
└── Project
    └── Uses tsc
```

```text
Developer B
│
└── Project
    └── Uses tsc
         │
         ▼
    Command Not Found
```

## 3.3 ¿Dónde está el error de diseño?

El proyecto necesita TypeScript, pero no expresa esa necesidad adecuadamente.

## 3.4 Enfoque recomendado

Declarar TypeScript como dependencia de desarrollo:

```json
{
  "devDependencies": {
    "typescript": "^5.0.0"
  },
  "scripts": {
    "typecheck": "tsc --noEmit"
  }
}
```

La versión es ilustrativa.

Al instalar las dependencias del proyecto, el gestor correspondiente puede poner el ejecutable local a disposición de los Scripts.

## 3.5 Resultado

```text
Project
│
├── package.json
│   └── Declares TypeScript
│
├── Lockfile
│   └── Resolves Dependency Versions
│
└── Scripts
    └── Uses Project Tool
```

### Idea clave

**Un proyecto profesional debe declarar las herramientas que necesita para funcionar, compilarse y validarse.**

---

# 4. Local Dependencies vs Global Dependencies

Esta diferencia es especialmente importante en JavaScript.

## 4.1 Local Dependencies

Son paquetes instalados y administrados en el contexto de un proyecto.

Por ejemplo:

```json
{
  "devDependencies": {
    "typescript": "^5.0.0",
    "eslint": "^9.0.0"
  }
}
```

## 4.2 Global Dependencies

Son paquetes instalados en un ámbito compartido por diferentes proyectos o comandos del usuario.

Por ejemplo, npm permite instalar paquetes globalmente mediante la opción `--global`.

## 4.3 Comparación

| Característica | Local | Global |
|---|---|---|
| Alcance principal | Proyecto | Entorno compartido |
| Declaración en `package.json` | Habitual | No automática |
| Versionado por proyecto | Sí | No directamente |
| Compartida entre proyectos | No como contrato | Habitualmente |
| Reproducibilidad | Más sencilla de controlar | Requiere gestión adicional |
| Uso habitual | Build, linting, testing | CLI de propósito general |

## 4.4 ¿Significa que las dependencias locales siempre ocupan menos espacio?

No necesariamente.

Los gestores pueden utilizar diferentes estrategias de almacenamiento y reutilización.

Por ejemplo, pnpm emplea un almacén de contenido reutilizable.

Estudiaremos estos mecanismos en `05-package-managers`.

### Principio

**El beneficio principal de una dependencia local es el control de su relación con el proyecto, no necesariamente el ahorro de almacenamiento.**

---

# 5. ¿Por qué las herramientas de Build deben pertenecer al proyecto?

Consideremos las siguientes herramientas:

- TypeScript.
- ESLint.
- Prettier.
- Vite.
- Vitest.
- Rsbuild.

Todas pueden influir en el comportamiento del repositorio.

## 5.1 Ejemplo

Un proyecto utiliza una versión determinada de Vite.

Otro proyecto utiliza una versión diferente.

```text
Project A
└── Vite Version A
```

```text
Project B
└── Vite Version B
```

Si ambos dependen exclusivamente de una instalación global, podrían aparecer incompatibilidades.

## 5.2 Enfoque recomendado

```text
Development Machine
│
├── Project A
│   ├── package.json
│   └── Vite Version A
│
└── Project B
    ├── package.json
    └── Vite Version B
```

## 5.3 ¿Qué conseguimos?

- Versiones independientes.
- Configuraciones específicas.
- Builds más previsibles.
- Mejor compatibilidad con CI.
- Menor dependencia de la computadora personal.

### Idea clave

**Las herramientas que determinan cómo se construye o valida un proyecto deben formar parte de su contrato técnico.**

---

# 6. El problema de los conflictos de versiones

Supongamos que trabajamos en dos proyectos.

```text
Project A
└── Requires Tool v1
```

```text
Project B
└── Requires Tool v2
```

Si utilizamos una única instalación global, necesitamos cambiarla constantemente o aceptar que uno de los proyectos podría ejecutar una versión incompatible.

## 6.1 Consecuencias

- Builds inconsistentes.
- Errores difíciles de reproducir.
- Diferencias entre desarrolladores.
- Dependencia del orden de instalaciones.
- Problemas al ejecutar CI.

## 6.2 Mejor estrategia

```text
Project A
├── Declared Tool v1
└── Lockfile
```

```text
Project B
├── Declared Tool v2
└── Lockfile
```

## 6.3 ¿El Lockfile garantiza reproducibilidad absoluta?

No.

También pueden influir:

- Runtime.
- Sistema operativo.
- Arquitectura.
- Dependencias nativas.
- Variables de entorno.
- Disponibilidad de paquetes.
- Configuraciones del gestor.

El Lockfile es una pieza fundamental, pero no la única.

### Principio

**El versionado del proyecto debe reducir la dependencia del estado global de la máquina.**

---

# 7. El papel de PATH en Global Pollution

PATH permite al Shell localizar ejecutables externos.

## 7.1 Ejemplo

```text
PATH
│
├── /usr/local/bin
├── ~/.local/bin
├── Runtime Manager Paths
└── System Directories
```

El orden de búsqueda puede determinar qué ejecutable se utiliza.

## 7.2 Problema

Tenemos dos instalaciones de Node.js:

```text
Installation A
└── node
```

```text
Installation B
└── node
```

Si ambas están accesibles mediante PATH, la resolución dependerá del entorno y del mecanismo de búsqueda.

## 7.3 Diagnóstico en Bash

```bash
type -a node
```

```bash
command -v node
```

```bash
node --version
```

## 7.4 Diagnóstico en PowerShell

```powershell
Get-Command node -All
```

```powershell
node --version
```

## 7.5 ¿Qué debemos investigar?

1. Qué ejecutables existen.
2. Cuál está activo.
3. Quién administra cada instalación.
4. Qué configuración modifica PATH.
5. Qué versión requiere el proyecto.

### Idea clave

**Una herramienta instalada no necesariamente es la herramienta que estamos ejecutando.**

---

# 8. Multiple Runtime Installations

Un caso frecuente de Global Pollution es instalar un mismo Runtime mediante diferentes mecanismos.

Por ejemplo:

```text
Node.js
│
├── Official Installer
├── Homebrew
└── nvm
```

## 8.1 ¿Por qué ocurre?

Podemos instalar Node.js inicialmente mediante un instalador.

Después aprendemos Homebrew.

Más adelante comenzamos a utilizar nvm.

Si no comprendemos las instalaciones anteriores, podemos terminar con varias rutas y versiones.

## 8.2 ¿Qué debemos hacer?

No eliminar inmediatamente las instalaciones.

Primero realizar una auditoría.

## 8.3 Estrategia

```text
Identify Installations
        │
        ▼
Identify Active Runtime
        │
        ▼
Identify Project Requirements
        │
        ▼
Choose Management Strategy
        │
        ▼
Plan Controlled Migration
        │
        ▼
Validate Projects
```

## 8.4 ¿Cuál es la recomendación general?

Elegir una estrategia clara para administrar versiones del Runtime.

Estudiaremos nvm, mise y otras alternativas en `04-runtime-management`.

### Principio

**No debemos mezclar mecanismos de administración sin comprender qué responsabilidad tiene cada uno.**

---

# 9. npm Global Packages

npm permite administrar paquetes tanto local como globalmente.

## 9.1 Consultar paquetes globales

```bash
npm list --global --depth=0
```

Este comando consulta los paquetes globales del npm correspondiente a la instalación y configuración activas.

## 9.2 Consultar ubicación global

```bash
npm prefix --global
```

## 9.3 ¿Por qué importa?

Porque diferentes instalaciones de Node.js o configuraciones de npm pueden tener ubicaciones globales distintas.

## 9.4 Ejemplo

```text
Node.js Installation A
└── Global npm Packages A
```

```text
Node.js Installation B
└── Global npm Packages B
```

Cambiar de versión de Node.js mediante un gestor puede hacer que algunos comandos globales dejen de estar disponibles.

El comportamiento exacto depende del gestor y de cómo administra los paquetes.

## 9.5 ¿Debemos reinstalar todo globalmente?

No necesariamente.

Primero debemos evaluar si esos paquetes deberían ser globales.

### Idea clave

**El conjunto de paquetes globales puede depender de la instalación activa del Runtime y del gestor utilizado.**

---

# 10. ¿Cuándo sí tiene sentido una instalación global?

Las instalaciones globales no son inherentemente incorrectas.

Pueden resultar útiles para herramientas generales que utilizamos desde múltiples ubicaciones.

## 10.1 Ejemplos de categorías

- Utilidades de Terminal.
- Herramientas de administración.
- Algunas CLI independientes.
- Herramientas de diagnóstico.
- Gestores de Runtimes.

## 10.2 Criterios de decisión

Antes de instalar globalmente, preguntamos:

1. ¿La herramienta pertenece a un proyecto concreto?
2. ¿Su versión afecta al resultado del Build?
3. ¿Diferentes proyectos podrían necesitar versiones distintas?
4. ¿Debe funcionar fuera de cualquier repositorio?
5. ¿Cómo se actualizará?
6. ¿Cómo se documentará?
7. ¿Qué gestor la administrará?

## 10.3 Matriz de decisión

| Situación | Estrategia habitual |
|---|---|
| TypeScript para un proyecto | Dependencia local |
| ESLint para un repositorio | Dependencia local |
| Vite para una aplicación | Dependencia local |
| Git para uso general | Herramienta de sistema/usuario |
| Runtime Manager | Herramienta de usuario |
| CLI general independiente | Evaluar instalación global |
| CLI exigida por un proyecto | Declarar o fijar versión según el caso |

### Principio

**Instalamos globalmente por una necesidad justificada, no simplemente por comodidad.**

---

# 11. Package Scripts como contrato del proyecto

`package.json` permite declarar Scripts.

Ejemplo:

```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "typecheck": "tsc --noEmit",
    "lint": "eslint .",
    "test": "vitest"
  }
}
```

## 11.1 ¿Qué ventaja ofrecen?

Permiten establecer comandos compartidos para el equipo.

En lugar de depender de instrucciones personales, podemos utilizar:

```bash
npm run build
```

O el comando equivalente del gestor elegido.

## 11.2 ¿Cómo encuentra el Script las herramientas?

Los gestores JavaScript suelen incorporar los ejecutables de las dependencias locales al entorno de ejecución de sus Scripts.

Por ejemplo, los binarios disponibles mediante `node_modules/.bin`.

## 11.3 Modelo

```text
package.json
    │
    ▼
Project Script
    │
    ▼
Package Manager
    │
    ▼
Local Tool
    │
    ▼
Project Operation
```

## 11.4 ¿Qué conseguimos?

- Comandos compartidos.
- Menos dependencias globales.
- Mejor integración con CI.
- Requisitos más visibles.

### Idea clave

**Los Scripts del proyecto son una interfaz profesional entre el repositorio y sus desarrolladores.**

---

# 12. El papel de package.json

`package.json` es un archivo fundamental del ecosistema JavaScript.

Permite declarar información como:

- Nombre del paquete.
- Versión.
- Dependencias.
- Dependencias de desarrollo.
- Scripts.
- Requisitos de ejecución.
- Gestor de paquetes esperado.

## 12.1 Ejemplo

```json
{
  "name": "professional-app",
  "private": true,
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "lint": "eslint ."
  },
  "devDependencies": {
    "vite": "^6.0.0",
    "eslint": "^9.0.0"
  }
}
```

Las versiones son ilustrativas.

## 12.2 ¿Qué representa?

Un contrato técnico parcial del proyecto.

## 12.3 ¿Es suficiente por sí solo?

No siempre.

También necesitamos considerar:

- Lockfile.
- Runtime.
- Gestor de paquetes.
- Variables.
- Configuración del sistema.
- Servicios externos.

### Principio

**Cuantos más requisitos importantes estén declarados, menos dependeremos de configuraciones personales ocultas.**

---

# 13. Lockfiles y reproducibilidad

Un Lockfile registra información sobre la resolución de dependencias.

Ejemplos:

```text
package-lock.json
pnpm-lock.yaml
yarn.lock
```

## 13.1 ¿Qué problema resuelve?

Una declaración como:

```json
{
  "dependencies": {
    "some-package": "^2.0.0"
  }
}
```

puede admitir diferentes versiones compatibles según las reglas del gestor.

El Lockfile permite registrar una resolución concreta del árbol de dependencias.

## 13.2 Modelo

```text
package.json
    │
    ▼
Dependency Constraints
    │
    ▼
Package Manager
    │
    ▼
Lockfile
    │
    ▼
Resolved Dependency Graph
```

## 13.3 ¿Qué debemos evitar?

Eliminar el Lockfile como primera reacción ante un error de instalación.

Esto puede cambiar las versiones resueltas y ocultar el problema original.

## 13.4 Buena práctica

Versionar el Lockfile apropiado para el proyecto y utilizar los mecanismos de instalación reproducible del gestor elegido.

### Idea clave

**El Lockfile ayuda a evitar que dos instalaciones resuelvan dependencias diferentes sin que el equipo lo advierta.**

---

# 14. Corepack y el control del Package Manager

Hasta ahora hemos hablado de controlar las dependencias del proyecto.

Pero existe otra pregunta importante:

> ¿Cómo controlamos la versión del propio gestor de paquetes?

Por ejemplo, diferentes desarrolladores podrían utilizar distintas versiones de pnpm.

## 14.1 El problema

```text
Developer A
└── pnpm Version A
```

```text
Developer B
└── pnpm Version B
```

Dependiendo de las versiones y características utilizadas, esto puede generar diferencias.

## 14.2 ¿Qué es Corepack?

Corepack es una herramienta que puede ayudar a administrar el uso de determinadas versiones de gestores de paquetes JavaScript.

Su disponibilidad e instalación dependen de la versión y distribución de Node.js; no debemos asumir que viene incluido en todas las instalaciones modernas.

## 14.3 packageManager

Un proyecto puede declarar:

```json
{
  "packageManager": "pnpm@X.Y.Z"
}
```

`X.Y.Z` representa una versión concreta que debe sustituirse por una versión real.

## 14.4 Modelo

```text
Project
│
├── package.json
│   └── packageManager
│
└── Package Manager Version
    └── Controlled by Team Strategy
```

## 14.5 ¿Corepack elimina toda Global Pollution?

No.

Ayuda a resolver un problema específico: el control del gestor de paquetes compatible.

No sustituye la gestión de Runtimes, dependencias o configuraciones.

### Principio

**También debemos controlar las herramientas que administran nuestras dependencias.**

---

# 15. Runtime Version vs Package Manager Version

Es importante no confundir ambos conceptos.

## 15.1 Runtime

Ejemplo:

```text
Node.js 22
```

Es el entorno que ejecuta JavaScript fuera del navegador.

## 15.2 Package Manager

Ejemplo:

```text
pnpm
```

Administra dependencias y operaciones relacionadas con paquetes.

## 15.3 Relación

```text
Development Machine
       │
       ▼
Runtime Version Manager
       │
       ▼
Node.js
       │
       ▼
Package Manager
       │
       ▼
Project Dependencies
```

Este diagrama representa una organización habitual, no una dependencia universal idéntica para todos los gestores y entornos.

## 15.4 ¿Por qué controlar ambos?

Porque un proyecto puede ser sensible tanto a la versión de Node.js como a la del gestor de paquetes.

### Idea clave

**Controlar Node.js y controlar pnpm son responsabilidades relacionadas, pero diferentes.**

---

# 16. Global Configuration Pollution

Global Pollution no se limita a paquetes instalados.

También puede aparecer en configuraciones.

## 16.1 Ejemplos

- Variables de entorno.
- Configuraciones Git globales.
- Configuraciones npm globales o de usuario.
- Alias del Shell.
- Modificaciones de PATH.
- Configuraciones de proxy.
- Certificados.
- Preferencias del editor.

## 16.2 Ejemplo

Una configuración global de npm puede modificar el Registry utilizado por determinadas operaciones.

Esto puede resultar útil en ciertos entornos corporativos.

Pero también puede afectar inesperadamente a proyectos personales.

## 16.3 Modelo

```text
User Configuration
       │
       ├── Project A
       ├── Project B
       └── Project C
```

Una configuración de usuario puede influir en múltiples proyectos.

## 16.4 ¿Cuál es el riesgo?

Que el comportamiento del proyecto dependa de algo que no está documentado en su repositorio.

### Principio

**Las configuraciones compartidas también deben tener un propietario y una responsabilidad claros.**

---

# 17. Global Git Configuration

Git permite configurar valores en diferentes niveles.

Por ejemplo:

- System.
- Global.
- Local.

## 17.1 Ejemplo

Una identidad Git global puede resultar apropiada para proyectos personales.

Pero un proyecto corporativo podría necesitar otra identidad.

## 17.2 Consultar configuración

```bash
git config --global --list
```

Este comando puede mostrar datos personales o información sensible, por lo que debemos revisar la salida antes de compartirla.

## 17.3 Consultar origen

```bash
git config --show-origin --get user.name
```

## 17.4 ¿Qué debemos comprender?

La configuración efectiva depende de las reglas de precedencia de Git y de las fuentes aplicables.

## 17.5 Buena práctica

Mantener una estrategia clara para identidades personales y corporativas.

### Idea clave

**La configuración global de Git es útil, pero no debe impedir que un repositorio utilice la identidad correcta.**

---

# 18. Global npm Configuration

npm utiliza diferentes fuentes de configuración.

Una de ellas puede ser un archivo `.npmrc`.

## 18.1 ¿Qué puede contener?

- Configuración de Registry.
- Opciones de instalación.
- Configuración de red.
- Parámetros de autenticación.

## 18.2 ¿Dónde puede aplicarse?

Dependiendo del caso, podemos encontrar configuraciones:

- Del proyecto.
- Del usuario.
- Globales.
- De entorno.

## 18.3 Riesgo habitual

Una configuración preparada para un Registry privado afecta inesperadamente a otro proyecto.

## 18.4 ¿Qué debemos hacer?

Identificar qué configuración está siendo aplicada y cuál es su origen.

## 18.5 Seguridad

No debemos publicar Tokens ni credenciales.

Tampoco debemos copiar indiscriminadamente archivos `.npmrc` corporativos a repositorios públicos.

### Principio

**Los Registries privados deben configurarse con un alcance apropiado y sin exponer credenciales.**

---

# 19. Environment Variables y contaminación global

Las variables de entorno pueden afectar a diferentes herramientas.

Ejemplos conceptuales:

```text
PATH
NODE_ENV
HTTP_PROXY
HTTPS_PROXY
```

## 19.1 ¿Qué problema puede aparecer?

Una variable configurada persistentemente para un proyecto puede influir en otro.

## 19.2 Ejemplo

```text
Global Environment Variable
          │
          ├── Project A
          └── Project B
```

Ambos proyectos pueden heredar una configuración que solamente uno necesitaba.

## 19.3 ¿Qué debemos hacer?

Definir las variables en el alcance más apropiado.

## 19.4 ¿Todas las variables deben ser locales?

No.

Algunas representan preferencias generales del usuario o del sistema.

## 19.5 Recomendación

Documentar las variables requeridas por el proyecto sin versionar sus valores secretos.

### Idea clave

**Una variable de entorno es una dependencia de ejecución cuando el proyecto necesita su presencia o valor.**

---

# 20. El problema de sudo y las instalaciones globales

En Linux y macOS, algunos desarrolladores intentan solucionar errores de instalación utilizando `sudo`.

## 20.1 Ejemplo de una reacción incorrecta

Una instalación global falla por permisos.

El desarrollador decide ejecutar la misma operación con privilegios elevados sin investigar.

## 20.2 ¿Qué riesgos existen?

- Archivos con propietarios inesperados.
- Modificaciones en ubicaciones protegidas.
- Mayor impacto de errores.
- Configuraciones difíciles de mantener.

## 20.3 ¿Cuál es la estrategia profesional?

Investigar:

1. Dónde intenta instalar la herramienta.
2. Qué usuario ejecuta el comando.
3. Qué permisos tiene la ubicación.
4. Qué gestor administra la instalación.
5. Qué procedimiento recomienda la documentación oficial.

## 20.4 ¿Debemos evitar siempre sudo?

No.

Algunas tareas administrativas legítimas requieren privilegios.

El objetivo es utilizarlos solamente cuando corresponde.

### Principio

**Un error de permisos no demuestra automáticamente que necesitemos privilegios administrativos.**

---

# 21. Global Pollution en CI/CD

La integración continua permite detectar dependencias ocultas.

## 21.1 Ejemplo

Nuestra máquina contiene:

```text
Global TypeScript
Global ESLint
Global Vite
```

Pero el repositorio no declara esas herramientas.

## 21.2 ¿Qué sucede en CI?

El entorno de CI puede comenzar con una configuración diferente.

```text
CI Environment
│
├── Runtime
├── Package Manager
└── Declared Dependencies
```

Cuando ejecutamos el Build, aparecen errores.

## 21.3 ¿Por qué es útil?

Porque revela que el proyecto dependía de una instalación personal.

## 21.4 ¿CI garantiza un entorno limpio?

No necesariamente.

Los Runners pueden contener herramientas preinstaladas, cachés o configuraciones específicas.

Por eso debemos diseñar los Pipelines para declarar explícitamente sus requisitos.

### Idea clave

**CI ayuda a descubrir dependencias ocultas cuando el Pipeline no depende de instalaciones personales no declaradas.**

---

# 22. Global Pollution en equipos

Consideremos tres desarrolladores.

```text
Developer A
├── Node.js Version A
├── Global ESLint
└── npm
```

```text
Developer B
├── Node.js Version B
├── Global TypeScript
└── pnpm
```

```text
Developer C
├── Node.js Version C
└── Yarn
```

Si el repositorio no define requisitos, cada persona puede experimentar resultados diferentes.

## 22.1 Consecuencias

- Problemas de incorporación.
- Errores inconsistentes.
- Tiempo perdido en configuraciones.
- Dificultad para reproducir incidencias.
- Diferencias entre máquinas y CI.

## 22.2 Solución arquitectónica

```text
Team Repository
│
├── Runtime Requirements
├── Package Manager Strategy
├── package.json
├── Lockfile
├── Project Configuration
├── Scripts
└── Setup Documentation
```

## 22.3 Beneficio

El equipo comparte un contrato técnico.

### Principio

**La reproducibilidad del equipo comienza cuando el repositorio declara sus requisitos en lugar de depender de hábitos personales.**

---

# 23. Estrategia profesional para evitar Global Pollution

Podemos aplicar una metodología de siete etapas.

## Step 1 — Identify

Identificar qué herramientas utiliza el proyecto.

## Step 2 — Classify

Clasificar cada herramienta:

```text
System
User
Runtime
Project
```

## Step 3 — Declare

Declarar las dependencias que pertenecen al proyecto.

## Step 4 — Version

Controlar las versiones importantes.

## Step 5 — Standardize

Establecer comandos y configuraciones compartidas.

## Step 6 — Validate

Comprobar el funcionamiento en un entorno que cumpla los requisitos declarados.

## Step 7 — Document

Registrar decisiones y procedimientos.

## Modelo

```text
Identify Tools
      │
      ▼
Classify Scope
      │
      ▼
Declare Dependencies
      │
      ▼
Control Versions
      │
      ▼
Standardize Commands
      │
      ▼
Validate Environment
      │
      ▼
Document Setup
```

### Idea clave

**Evitar Global Pollution es una decisión de arquitectura y mantenimiento, no solamente una tarea de limpieza.**

---

# 24. Práctica: auditar paquetes globales de npm

Realizaremos una auditoría de solo lectura.

No instalaremos ni eliminaremos paquetes.

## Step 1 — Comprobar npm

```bash
npm --version
```

Ejecutar solamente si npm está disponible.

## Step 2 — Listar paquetes globales

```bash
npm list --global --depth=0
```

## Step 3 — Consultar ubicación

```bash
npm prefix --global
```

## Step 4 — Clasificar

Completar:

| Paquete | ¿Para qué sirve? | ¿Lo necesito globalmente? | ¿Pertenece a un proyecto? |
|---|---|---|---|
| Package A | | | |
| Package B | | | |
| Package C | | | |

## Step 5 — Reflexionar

Preguntas:

- ¿Conozco todos los paquetes?
- ¿Qué versiones utilizan?
- ¿Alguno debería ser local?
- ¿Existen herramientas obsoletas?
- ¿Qué gestor administra estas instalaciones?

## Resultado esperado

Un inventario.

No una desinstalación automática.

---

# 25. Práctica: identificar la resolución de comandos

## Objetivo

Comprender qué ejecutable utiliza el Shell.

### Bash

```bash
type -a node
```

```bash
type -a npm
```

```bash
type -a pnpm
```

### PowerShell

```powershell
Get-Command node -All
```

```powershell
Get-Command npm -All
```

```powershell
Get-Command pnpm -All
```

## Preguntas

1. ¿Cuántas coincidencias encontramos?
2. ¿Cuál tiene prioridad?
3. ¿Existen varias instalaciones?
4. ¿Conocemos su origen?
5. ¿Qué herramienta administra cada una?

## Aprendizaje

**La resolución de comandos es una pieza fundamental para diagnosticar conflictos globales.**

---

# 26. Práctica: identificar una Hidden Dependency

Analicemos el siguiente proyecto:

```text
example-project/
├── src/
├── package.json
└── README.md
```

Su `package.json` contiene:

```json
{
  "scripts": {
    "build": "tsc",
    "lint": "eslint .",
    "test": "vitest"
  },
  "devDependencies": {
    "typescript": "^5.0.0"
  }
}
```

## 26.1 Pregunta

¿Qué herramientas utiliza el proyecto?

Respuesta:

- TypeScript.
- ESLint.
- Vitest.

## 26.2 ¿Cuáles están declaradas?

Solamente TypeScript.

## 26.3 ¿Qué problemas potenciales existen?

ESLint y Vitest podrían depender de instalaciones globales o de otras condiciones no documentadas.

## 26.4 ¿Qué deberíamos mejorar?

Declarar las herramientas necesarias en las dependencias apropiadas del proyecto.

## 26.5 Modelo corregido

```json
{
  "scripts": {
    "build": "tsc",
    "lint": "eslint .",
    "test": "vitest"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "eslint": "^9.0.0",
    "vitest": "^2.0.0"
  }
}
```

Las versiones son ilustrativas y no constituyen una recomendación de versiones actuales.

## Aprendizaje

**Los Scripts y las dependencias declaradas deben describir coherentemente las herramientas necesarias.**

---

# 27. Práctica: diseñar una estrategia de instalación

Supongamos que necesitamos las siguientes herramientas:

- Git.
- Node.js.
- pnpm.
- TypeScript.
- ESLint.
- Vite.
- Docker.
- AWS CLI.

## 27.1 Clasificación

| Herramienta | Estrategia habitual |
|---|---|
| Git | Sistema/usuario |
| Node.js | Runtime Manager |
| pnpm | Estrategia de gestor de paquetes controlada |
| TypeScript | Proyecto |
| ESLint | Proyecto |
| Vite | Proyecto |
| Docker | Infraestructura de desarrollo |
| AWS CLI | Usuario/entorno |

## 27.2 Preguntas

- ¿Qué herramientas deben funcionar fuera de un repositorio?
- ¿Cuáles influyen en el Build?
- ¿Cuáles necesitan versiones específicas?
- ¿Cuáles dependen de políticas corporativas?
- ¿Cuáles deberían documentarse?

## 27.3 Resultado esperado

Una estrategia que reduzca dependencias ocultas.

No existe una única respuesta universal para todas las organizaciones.

---

# 28. Global Pollution Prevention Checklist

## Runtime

- [ ] Conozco qué versiones de Node.js tengo disponibles.
- [ ] Sé qué instalación está activa.
- [ ] Utilizo una estrategia clara de gestión de versiones.
- [ ] Evito instalaciones duplicadas sin justificación.

## Package Managers

- [ ] Sé qué gestor utiliza cada proyecto.
- [ ] Conozco la versión requerida cuando está especificada.
- [ ] Comprendo el papel de Corepack.
- [ ] No mezclo gestores sin comprender las consecuencias.

## Project Dependencies

- [ ] TypeScript está declarado cuando el proyecto lo necesita.
- [ ] ESLint está declarado cuando el proyecto lo necesita.
- [ ] Las herramientas de Build están declaradas.
- [ ] Las herramientas de Testing están declaradas.
- [ ] Los Scripts no dependen de CLI globales ocultas.

## Configuration

- [ ] Comprendo mi PATH.
- [ ] Conozco mis configuraciones Git.
- [ ] Conozco las configuraciones npm relevantes.
- [ ] Evito variables globales innecesarias.
- [ ] Protejo Tokens y credenciales.

## Reproducibility

- [ ] El proyecto documenta sus requisitos.
- [ ] Existe una estrategia de Lockfile.
- [ ] Las versiones importantes están controladas.
- [ ] CI declara sus herramientas necesarias.
- [ ] Otro desarrollador puede preparar el entorno sin depender de mis instalaciones personales.

---

# 29. Errores comunes

### Error 1 — Instalar TypeScript globalmente como única dependencia

El proyecto puede funcionar localmente y fallar en otro entorno.

### Error 2 — Instalar ESLint globalmente para todos los repositorios

Diferentes proyectos pueden necesitar versiones o configuraciones distintas.

### Error 3 — Depender de una versión global de Vite

Puede generar incompatibilidades.

### Error 4 — Confundir npm con nvm

Administran responsabilidades diferentes.

### Error 5 — Confundir pnpm con Corepack

Corepack puede ayudar a administrar versiones del gestor; pnpm administra paquetes y Workspaces.

### Error 6 — Instalar Node.js mediante múltiples mecanismos sin control

Puede introducir conflictos de PATH.

### Error 7 — No declarar las herramientas utilizadas por los Scripts

Genera dependencias ocultas.

### Error 8 — Eliminar Lockfiles para solucionar errores

Puede cambiar el árbol de dependencias y ocultar la causa original.

### Error 9 — Modificar PATH sin comprender su origen

Puede alterar la prioridad de los ejecutables.

### Error 10 — Configurar un Registry privado globalmente sin evaluar su alcance

Puede afectar otros proyectos.

### Error 11 — Compartir archivos de configuración con Tokens

Puede comprometer credenciales.

### Error 12 — Utilizar sudo automáticamente

Puede crear problemas de permisos y seguridad.

### Error 13 — Asumir que CI contiene nuestras herramientas globales

Puede provocar errores de Build.

### Error 14 — Desinstalar herramientas desconocidas

Puede afectar proyectos o procesos existentes.

### Error 15 — Prohibir todas las instalaciones globales

No es necesario ni práctico.

### Error 16 — No documentar la estrategia del equipo

Permite que cada desarrollador utilice configuraciones incompatibles.

---

# 30. Comprueba tu modelo mental

1. ¿Qué significa Global Pollution?
2. ¿Es un término técnico formal?
3. ¿Qué diferencia existe entre Global Installation y Global Pollution?
4. ¿Qué es Scope?
5. ¿Qué diferencia existe entre System Scope y User Scope?
6. ¿Qué es Project Scope?
7. ¿Qué es Process Scope?
8. ¿Qué es una Hidden Dependency?
9. ¿Cómo puede una instalación global ocultar una dependencia?
10. ¿Por qué TypeScript debería declararse en el proyecto cuando este lo necesita?
11. ¿Qué diferencia existe entre Local Dependencies y Global Dependencies?
12. ¿Por qué las herramientas de Build suelen ser locales?
13. ¿Qué problemas generan los conflictos de versiones?
14. ¿Qué papel cumple PATH?
15. ¿Cómo identificarías múltiples instalaciones de Node.js?
16. ¿Qué hace `npm list --global --depth=0`?
17. ¿Qué información proporciona `npm prefix --global`?
18. ¿Cuándo puede ser apropiada una instalación global?
19. ¿Qué responsabilidad tienen los Scripts de `package.json`?
20. ¿Cómo encuentran los Scripts los ejecutables locales?
21. ¿Qué papel cumple `package.json`?
22. ¿Qué problema ayuda a resolver un Lockfile?
23. ¿Un Lockfile garantiza reproducibilidad absoluta?
24. ¿Qué es Corepack?
25. ¿Qué representa `packageManager`?
26. ¿Qué diferencia existe entre Runtime Version y Package Manager Version?
27. ¿Qué es Global Configuration Pollution?
28. ¿Por qué una configuración Git global puede afectar proyectos corporativos?
29. ¿Qué riesgos existen con un `.npmrc` de usuario?
30. ¿Cómo puede una variable de entorno convertirse en dependencia oculta?
31. ¿Por qué no debemos utilizar sudo automáticamente?
32. ¿Cómo puede CI revelar dependencias ocultas?
33. ¿Qué elementos debería declarar un repositorio profesional?
34. ¿Qué significa controlar el alcance de una herramienta?
35. ¿Por qué evitar Global Pollution es una decisión arquitectónica?

---

# 31. Checklist de aprendizaje

- [ ] Comprendo qué es Global Pollution.
- [ ] Distingo una instalación global de una contaminación global.
- [ ] Comprendo los diferentes Scopes.
- [ ] Puedo identificar Hidden Dependencies.
- [ ] Diferencio dependencias locales y globales.
- [ ] Comprendo por qué las herramientas de Build suelen pertenecer al proyecto.
- [ ] Comprendo los conflictos de versiones.
- [ ] Sé inspeccionar la resolución de comandos.
- [ ] Reconozco instalaciones duplicadas de Node.js.
- [ ] Sé consultar paquetes globales de npm.
- [ ] Puedo decidir cuándo una instalación global está justificada.
- [ ] Comprendo el papel de los Scripts.
- [ ] Comprendo el papel de `package.json`.
- [ ] Comprendo el propósito de los Lockfiles.
- [ ] Distingo Corepack, pnpm y Runtime Managers.
- [ ] Reconozco riesgos de configuraciones globales.
- [ ] Comprendo la importancia del alcance de `.npmrc`.
- [ ] Evito privilegios innecesarios.
- [ ] Comprendo cómo CI ayuda a detectar dependencias ocultas.
- [ ] Puedo diseñar una estrategia de instalación profesional.

---

# 💡 Idea clave

Una instalación global no es necesariamente un problema.

El problema aparece cuando un proyecto depende de herramientas o configuraciones compartidas que no controla.

```text
Uncontrolled Global Environment
              │
              ▼
       Hidden Dependencies
              │
              ▼
        Version Conflicts
              │
              ▼
      Inconsistent Behavior
              │
              ▼
     Difficult Reproduction
```

El enfoque profesional consiste en:

```text
Identify Requirements
         │
         ▼
Assign Correct Scope
         │
         ▼
Declare Dependencies
         │
         ▼
Control Versions
         │
         ▼
Standardize Execution
         │
         ▼
Reproducible Projects
```

**Nuestro objetivo no es eliminar todas las herramientas globales, sino impedir que el comportamiento de nuestros proyectos dependa accidentalmente de ellas.**

---

# 🚀 Siguiente paso

Ahora comprendemos cómo evitar dependencias globales ocultas y cómo asignar responsabilidades a nuestras herramientas.

Pero todavía nos falta una pieza importante:

**¿Cómo documentamos correctamente nuestro entorno de desarrollo para poder reconstruirlo o compartirlo con otros desarrolladores?**

En el siguiente documento aprenderemos a registrar:

- Requisitos del sistema.
- Herramientas necesarias.
- Versiones.
- Configuraciones.
- Variables de entorno.
- Procedimientos de instalación.
- Comandos de validación.
- Problemas conocidos.

👉 [Document Your Environment](./03-document-your-environment.md)