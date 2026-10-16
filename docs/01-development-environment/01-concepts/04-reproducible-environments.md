# Reproducible Environments

En los documentos anteriores aprendimos que un Development Environment está compuesto por diferentes sistemas, herramientas y configuraciones.

También comprendimos que cada desarrollador puede tener preferencias personales, mientras que el proyecto establece determinados requisitos compartidos.

Sin embargo, todavía existe un problema:

**Dos desarrolladores pueden utilizar el mismo Repository y obtener resultados diferentes.**

Esto sucede porque compartir el código fuente no significa compartir automáticamente todas las condiciones necesarias para ejecutarlo.

Para reducir este problema necesitamos comprender el concepto de **Reproducible Development Environments**.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué significa reproducibilidad en un entorno de desarrollo.
- Por qué aparece el problema *It works on my machine*.
- Qué diferencias pueden existir entre dos entornos.
- Qué significa Environment Drift.
- Qué relación existe entre consistencia, reproducibilidad y portabilidad.
- Qué componentes debemos declarar o documentar.
- Qué diferencia existe entre una instalación manual y un proceso reproducible.
- Qué papel cumplen las versiones, las dependencias y las configuraciones.
- Cómo verificar que un entorno cumple los requisitos de un proyecto.
- Qué limitaciones tiene la reproducibilidad.
- Cómo comenzar a diseñar un entorno reproducible sin instalar herramientas avanzadas.

---

## 🧠 1. El problema: It Works on My Machine

Imagina que dos desarrolladores trabajan en la misma aplicación.

Ana descarga el Repository, instala las dependencias y ejecuta el proyecto.

Todo funciona correctamente.

Carlos descarga exactamente el mismo Repository e intenta ejecutar los mismos comandos.

Pero obtiene un error.

```text
Shared Repository
       │
       ├── Developer A
       │       ↓
       │   Application Works
       │
       └── Developer B
               ↓
           Application Fails
```

¿Cómo es posible?

Porque el Repository no necesariamente contiene todas las condiciones que influyen en la ejecución del software.

Por ejemplo:

| Componente | Developer A | Developer B |
|---|---|---|
| Operating System | macOS | Windows |
| Node.js | Versión compatible | Versión incompatible |
| Dependencies | Instalación consistente | Dependencias diferentes |
| Environment Variables | Completas | Falta una variable |
| System Tools | Disponibles | Falta una herramienta |
| Permissions | Correctos | Acceso restringido |

El problema no siempre está en el código fuente.

Puede encontrarse en el entorno que lo ejecuta.

Esta situación suele resumirse mediante la expresión:

**It works on my machine.**

El objetivo de un entorno reproducible es reducir este tipo de diferencias.

---

## 🔁 2. ¿Qué es un Reproducible Development Environment?

Un **Reproducible Development Environment** es un entorno cuyos requisitos y procedimientos de preparación están suficientemente definidos para que pueda reconstruirse y utilizarse de manera consistente.

Conceptualmente:

```text
Declared Requirements
        ↓
Documented Setup
        ↓
Environment Preparation
        ↓
Validation
        ↓
Predictable Development
```

La idea fundamental es que preparar el proyecto no dependa exclusivamente del conocimiento de una persona.

Por ejemplo, no queremos que la única instrucción disponible sea:

> Pregúntale a Ana cómo configuró su computadora.

Queremos disponer de requisitos y procedimientos que otros desarrolladores puedan seguir.

### Importante

Un entorno reproducible no garantiza que todas las computadoras se comporten de manera absolutamente idéntica.

El sistema operativo, la arquitectura del procesador, las herramientas externas y otros factores pueden introducir diferencias.

La reproducibilidad busca **controlar las variables relevantes y reducir la incertidumbre**.

---

## 🧩 3. Reproducibility vs Consistency vs Portability

Estos tres conceptos están relacionados, pero no significan exactamente lo mismo.

### Reproducibility

Capacidad de reconstruir un entorno a partir de requisitos y procedimientos definidos, obteniendo resultados suficientemente equivalentes.

### Consistency

Grado en que distintos entornos respetan los mismos requisitos y producen comportamientos compatibles.

### Portability

Capacidad de utilizar o trasladar software entre diferentes plataformas o entornos con modificaciones limitadas o sin modificaciones.

| Concepto | Pregunta principal |
|---|---|
| Reproducibility | ¿Podemos reconstruir el entorno? |
| Consistency | ¿Los entornos cumplen los mismos requisitos? |
| Portability | ¿Puede funcionar en plataformas diferentes? |

### Ejemplo

Podemos tener un entorno reproducible específicamente para Linux.

Eso no significa automáticamente que funcione en Windows.

```text
Reproducible on Linux
          ≠
Portable to Every OS
```

También podemos tener dos entornos configurados de manera consistente sin disponer todavía de un procedimiento automatizado para reconstruirlos.

**La reproducibilidad, la consistencia y la portabilidad se complementan, pero resuelven preguntas diferentes.**

---

## 🏗️ 4. ¿Qué necesitamos reproducir?

No necesariamente necesitamos copiar toda la computadora de un desarrollador.

Debemos identificar qué componentes afectan realmente al proyecto.

Por ejemplo:

```text
Project Requirements
│
├── Operating System Compatibility
├── Runtime Requirements
├── Package Manager
├── Dependencies
├── Environment Variables
├── Required System Tools
├── Project Configuration
└── Validation Commands
```

Cada proyecto puede necesitar un conjunto diferente de requisitos.

Una aplicación frontend sencilla puede tener necesidades distintas a una aplicación que utiliza bases de datos, servicios externos o herramientas nativas.

Por eso debemos comenzar preguntando:

**¿Qué condiciones necesita este proyecto para desarrollarse y ejecutarse correctamente?**

---

## ⚙️ 5. Tool Versions

Las herramientas evolucionan mediante versiones.

Por ejemplo:

```text
Node.js 20
Node.js 22
Node.js 24
```

Estas versiones pueden introducir nuevas capacidades, cambios de comportamiento o diferencias de compatibilidad.

Imagina que un proyecto utiliza una característica disponible únicamente en determinadas versiones de Node.js.

Un desarrollador utiliza una versión compatible.

Otro utiliza una versión que no admite esa característica.

Aunque ambos tengan el mismo código, podrían obtener resultados diferentes.

```text
Same Source Code
       +
Different Runtime Versions
       ↓
Potential Compatibility Problems
```

### ¿Qué podemos hacer?

Declarar o documentar qué versiones admite el proyecto.

Por ejemplo:

```text
Project
    ↓
Supported Node.js Versions
    ↓
Developer Environment
```

Más adelante aprenderemos a administrar versiones mediante herramientas específicas.

Por ahora debemos comprender que **la versión de una herramienta forma parte de las condiciones del entorno**.

---

## 📦 6. Dependency Reproducibility

Las aplicaciones modernas utilizan dependencias externas.

Por ejemplo:

```text
Application
│
├── Dependency A
├── Dependency B
└── Dependency C
```

Estas dependencias también tienen versiones.

Incluso pueden depender de otros Packages.

```text
Application
    ↓
Dependency A
    ↓
Dependency D
```

Por tanto, instalar las dependencias de un proyecto no consiste simplemente en obtener una lista de nombres.

También necesitamos resolver versiones y relaciones entre Packages.

### El problema

Si dos desarrolladores instalan conjuntos diferentes de dependencias, pueden aparecer comportamientos distintos.

```text
Developer A
    ↓
Dependency Graph A

Developer B
    ↓
Dependency Graph B
```

### ¿Cómo reducimos este problema?

Los Package Managers modernos utilizan mecanismos para declarar y resolver dependencias.

Uno de ellos es el **Lockfile**.

Conceptualmente:

```text
Dependency Declarations
          +
Lockfile
          ↓
More Predictable Installation
```

Un Lockfile registra información sobre la resolución de dependencias.

Ayuda a reproducir instalaciones, aunque por sí solo no garantiza resultados idénticos en todas las plataformas.

Por ejemplo, algunas dependencias pueden incluir componentes específicos para determinados sistemas operativos o arquitecturas.

Estudiaremos este mecanismo en profundidad dentro de `05-package-managers`.

---

## 🌍 7. Environment Variables

Las **Environment Variables** también pueden afectar al comportamiento de una aplicación.

Imagina que una aplicación necesita conocer la dirección de un servicio.

```dotenv
API_BASE_URL=https://api.example.com
```

Un desarrollador tiene la variable correctamente definida.

Otro no la tiene.

```text
Developer A
    ↓
API_BASE_URL Defined
    ↓
Application Works
```

```text
Developer B
    ↓
API_BASE_URL Missing
    ↓
Application May Fail
```

El problema puede aparecer aunque ambos utilicen las mismas dependencias y versiones.

### ¿Cómo podemos evitarlo?

Documentando las variables necesarias.

Por ejemplo:

```text
.env.example
```

Podría contener:

```dotenv
API_BASE_URL=
API_TOKEN=
```

Este archivo describe los nombres de las variables requeridas sin incluir credenciales reales.

Los valores correspondientes se proporcionarían mediante mecanismos apropiados para cada entorno.

**Un entorno reproducible necesita conocer sus requisitos, pero no debe exponer secretos para conseguirlo.**

---

## 🖥️ 8. Operating System Differences

Los sistemas operativos pueden presentar diferencias relacionadas con:

- Rutas.
- Permisos.
- Shells.
- Comandos disponibles.
- Herramientas del sistema.
- Convenciones de archivos.
- Dependencias nativas.

Por ejemplo, una ruta de Windows puede representarse así:

```text
C:\Users\Developer\Projects
```

Mientras que en macOS puede utilizarse:

```text
/Users/developer/projects
```

También existen diferencias entre comandos y comportamientos de los Shells.

Un Script que depende de utilidades específicas de Unix podría no funcionar directamente en determinados entornos de Windows.

Esto introduce una decisión importante:

**¿Qué sistemas operativos debe soportar nuestro proyecto?**

No todos los proyectos necesitan ser compatibles con todas las plataformas.

Pero debemos documentar las plataformas admitidas y sus requisitos.

---

## 🔍 9. Hidden Dependencies

Una **Hidden Dependency** es una condición necesaria para que algo funcione, pero que no está correctamente declarada o documentada.

Imagina que una aplicación necesita una herramienta instalada en el sistema.

Ana la instaló hace meses.

El proyecto funciona en su computadora.

Carlos intenta preparar el proyecto, pero esa herramienta no aparece en las instrucciones.

```text
Developer A
    ↓
Hidden System Tool
    ↓
Project Works

Developer B
    ↓
Missing System Tool
    ↓
Project Fails
```

La dependencia existe, aunque no esté documentada.

### Ejemplos de dependencias ocultas

- Una herramienta instalada globalmente.
- Una variable de entorno definida manualmente.
- Una ruta configurada en el Shell.
- Un servicio que debe estar ejecutándose.
- Un permiso del sistema.
- Un archivo local que no está en Git.
- Una versión específica de una herramienta.

Las dependencias ocultas dificultan el Onboarding y el diagnóstico.

**Principio: todo requisito necesario para trabajar con el proyecto debería poder identificarse y verificarse.**

---

## 📉 10. Environment Drift

**Environment Drift** describe la situación en la que un entorno se desvía progresivamente de la configuración o estado esperado.

Por ejemplo, inicialmente tenemos:

```text
Developer A → Node.js Version X
Developer B → Node.js Version X
```

Después de un tiempo:

```text
Developer A → Node.js Version X
Developer B → Node.js Version Y
```

La diferencia puede aparecer porque un desarrollador actualizó sus herramientas mientras otro mantuvo las versiones anteriores.

También puede ocurrir con:

```text
System Packages
Global Tools
Environment Variables
Dependencies
Configuration Files
```

### ¿Por qué importa?

Porque los problemas pueden aparecer de manera gradual.

Un proyecto que funcionaba correctamente puede comenzar a fallar después de una actualización.

### ¿Cómo reducimos el Drift?

Mediante prácticas como:

- Declarar requisitos.
- Controlar versiones relevantes.
- Utilizar configuraciones compartidas.
- Documentar procedimientos.
- Validar periódicamente el entorno.
- Actualizar herramientas de forma controlada.

No necesitamos congelar todas las herramientas indefinidamente.

Necesitamos gestionar los cambios de manera consciente.

---

## 📋 11. Manual Setup vs Documented Setup vs Automated Setup

Existen diferentes niveles de preparación de un entorno.

### Level 1 — Undocumented Manual Setup

Cada desarrollador prepara su computadora utilizando conocimientos propios o instrucciones informales.

```text
Developer
    ↓
Personal Knowledge
    ↓
Manual Configuration
```

El problema es que resulta difícil reproducir el proceso.

### Level 2 — Documented Setup

El proyecto proporciona instrucciones.

```text
Repository
    ↓
Setup Documentation
    ↓
Developer
    ↓
Environment Preparation
```

Por ejemplo:

```text
1. Verify operating system compatibility.
2. Install the required runtime.
3. Verify the package manager.
4. Configure required environment variables.
5. Install dependencies.
6. Run validation commands.
```

Este proceso todavía puede ser manual, pero ya es más comprensible y repetible.

### Level 3 — Automated Setup

Algunas operaciones pueden ejecutarse mediante herramientas o Scripts.

```text
Declared Requirements
        ↓
Automation
        ↓
Environment Preparation
        ↓
Validation
```

La automatización reduce pasos manuales, aunque también introduce herramientas y configuraciones que deben mantenerse.

### Comparación

| Enfoque | Ventaja | Limitación |
|---|---|---|
| Manual no documentado | Inicio rápido para una persona | Depende del conocimiento individual |
| Manual documentado | Facilita colaboración y diagnóstico | Requiere ejecutar pasos correctamente |
| Automatizado | Reduce tareas repetitivas | Necesita mantenimiento y validación |

**No debemos confundir automatización con reproducibilidad absoluta.**

Un proceso automatizado también puede fallar si depende de recursos cambiantes o requisitos no controlados.

---

## 🧱 12. Declarative vs Imperative Setup

Podemos encontrar dos enfoques complementarios.

### Imperative Setup

Describe una secuencia de acciones.

Por ejemplo:

```text
Install Tool A
Configure Variable B
Create Directory C
Run Command D
```

Se concentra en **qué pasos ejecutar**.

### Declarative Setup

Describe el estado o los requisitos deseados.

Por ejemplo:

```text
Required Runtime: Version X
Required Packages: A, B, C
Required Variables: D, E
```

Se concentra en **qué condiciones deben cumplirse**.

Conceptualmente:

```text
Imperative
    ↓
How to Prepare

Declarative
    ↓
What Is Required
```

En la práctica, los proyectos pueden combinar ambos enfoques.

Por ejemplo, un archivo puede declarar dependencias y una herramienta puede ejecutar las operaciones necesarias para instalarlas.

No necesitamos elegir uno de forma exclusiva.

---

## 🧪 13. Verification: How Do We Know It Works?

Preparar un entorno no termina cuando instalamos las herramientas.

Necesitamos comprobar que cumple los requisitos.

Conceptualmente:

```text
Environment Setup
        ↓
Verification
        ↓
Expected Results
```

Podemos realizar comprobaciones en diferentes niveles.

### Tool Availability

¿Podemos ejecutar las herramientas necesarias?

Por ejemplo:

```bash
git --version
```

### Version Compatibility

¿Las versiones cumplen los requisitos del proyecto?

Por ejemplo:

```bash
node --version
```

### Dependency Availability

¿Se instalaron correctamente las dependencias?

### Project Validation

¿Podemos ejecutar las verificaciones requeridas?

Por ejemplo:

```text
Lint
Type Check
Test
Build
```

Estos últimos son ejemplos conceptuales; los implementaremos cuando estudiemos las herramientas correspondientes.

### Importante

Que un comando devuelva una versión no significa que todo el entorno esté correctamente preparado.

La validación debe cubrir las condiciones relevantes para el proyecto.

---

## 🏢 14. Reproducibility in Professional Teams

Imagina una empresa con diez desarrolladores.

Sin requisitos claros:

```text
10 Developers
      ↓
10 Different Setups
      ↓
Unexpected Differences
      ↓
Troubleshooting
```

Con requisitos documentados:

```text
Shared Requirements
        ↓
Documented Setup
        ↓
Developer Environments
        ↓
Common Validation
```

Esto puede mejorar:

- Onboarding.
- Colaboración.
- Diagnóstico.
- Consistencia.
- Mantenimiento.
- Automatización.

También facilita la incorporación de nuevos desarrolladores.

En lugar de depender exclusivamente de explicaciones informales, pueden seguir instrucciones verificables.

---

## 🔗 15. Reproducibility and CI

La reproducibilidad también se relaciona con **Continuous Integration (CI)**.

En un equipo, los desarrolladores ejecutan verificaciones en sus computadoras.

Pero podemos necesitar comprobar el proyecto en un entorno de automatización.

```text
Developer Environment
        ↓
Code Changes
        ↓
Repository
        ↓
CI Environment
        ↓
Validation
```

El entorno de CI puede tener características distintas de las computadoras personales.

Por eso es importante declarar requisitos y evitar dependencias ocultas.

Si un proyecto solamente funciona porque alguien tiene una herramienta instalada manualmente, puede fallar al ejecutarse en CI.

Más adelante estudiaremos cómo preparar verificaciones automatizadas mediante GitHub Actions.

Por ahora debemos comprender que **la reproducibilidad facilita trasladar los procesos de desarrollo a otros entornos**.

---

## 🧰 16. ¿Necesitamos Containers para conseguir reproducibilidad?

No necesariamente.

Herramientas como Docker pueden ayudar a definir y ejecutar entornos aislados.

Pero no son el único mecanismo disponible.

Podemos mejorar la reproducibilidad utilizando:

```text
Documented Requirements
Version Management
Dependency Lockfiles
Shared Configuration
Validation Scripts
```

Los contenedores pueden aportar aislamiento y control adicional, pero también introducen complejidad.

Además, utilizar contenedores no elimina automáticamente todas las diferencias: siguen existiendo factores como arquitectura, imágenes utilizadas, servicios externos y configuración del Host.

Nuestro enfoque será progresivo.

**Primero comprenderemos los requisitos del entorno. Después evaluaremos qué herramientas necesitamos para reproducirlo.**

---

## 🏗️ 17. Cómo aplicaremos esto en Developer Tooling Mastery 2026

Nuestro Repository evolucionará progresivamente.

Actualmente estamos construyendo los fundamentos.

Más adelante incorporaremos:

```text
Developer Tooling Mastery
        ↓
Environment Documentation
        ↓
Runtime Requirements
        ↓
Package Manager Configuration
        ↓
Dependency Lockfile
        ↓
Shared Tooling Configuration
        ↓
Validation Scripts
        ↓
CI
```

Cada incorporación resolverá una necesidad concreta.

No crearemos todas estas configuraciones ahora.

Por ejemplo, cuando lleguemos a Runtime Management, aprenderemos a declarar y administrar versiones de Node.js.

Cuando estudiemos Package Managers, comprenderemos los Lockfiles.

Y cuando lleguemos a CI, ejecutaremos verificaciones en un entorno automatizado.

La reproducibilidad será un objetivo transversal durante todo el Mastery.

---

## 🧪 18. Práctica: Environment Reproducibility Audit

Vamos a realizar una primera evaluación de nuestro entorno.

No instalaremos ni modificaremos herramientas.

El objetivo es identificar qué sabemos y qué información todavía nos falta.

### Step 1 — Identify Your Environment

Completa:

| Component | Current State |
|---|---|
| Operating System | |
| OS Version | |
| Terminal | |
| Shell | |
| Code Editor | |
| Git Version | |
| Node.js Version, if installed | |
| Package Manager, if available | |

Si una herramienta no está instalada, escribe `Not installed`.

No necesitas instalarla todavía.

### Step 2 — Identify Potential Differences

Imagina que otro desarrollador utiliza un sistema operativo diferente.

Responde:

1. ¿Qué rutas podrían cambiar?
2. ¿Qué comandos podrían comportarse de manera distinta?
3. ¿Qué herramientas necesitaría instalar?
4. ¿Qué versiones deberían ser compatibles?
5. ¿Qué configuraciones deberían documentarse?

### Step 3 — Identify Hidden Requirements

Piensa en algún proyecto que hayas utilizado anteriormente.

¿Necesitaba alguna condición que no estuviera documentada?

Por ejemplo:

```text
A globally installed tool
An environment variable
A local configuration file
A running service
```

Si no tienes un proyecto previo, utiliza los ejemplos de este documento.

### Step 4 — Define a Verification Checklist

Crea una lista conceptual:

```text
[ ] Operating System Supported
[ ] Required Tools Available
[ ] Tool Versions Compatible
[ ] Required Variables Documented
[ ] Dependencies Installed
[ ] Project Validation Successful
```

No necesitas marcar todas las casillas.

El propósito es comprender qué deberíamos verificar cuando preparemos un proyecto real.

---

## ⚠️ Errores comunes

### 1. Pensar que compartir el Repository garantiza reproducibilidad

El código fuente no siempre incluye todos los requisitos del entorno.

### 2. Confundir reproducibilidad con computadoras idénticas

Podemos reproducir condiciones relevantes utilizando sistemas diferentes, siempre que el proyecto los soporte.

### 3. Ignorar las versiones de herramientas

Las diferencias de versión pueden introducir incompatibilidades.

### 4. Pensar que un Lockfile garantiza resultados idénticos

Un Lockfile mejora la consistencia de dependencias, pero existen otros factores.

### 5. No documentar variables de entorno

Las variables ausentes pueden impedir ejecutar una aplicación.

### 6. Depender de herramientas instaladas globalmente sin documentarlas

Esto introduce Hidden Dependencies.

### 7. Automatizar un proceso sin controlar sus requisitos

La automatización no elimina automáticamente las diferencias.

### 8. No verificar el resultado del Setup

Instalar herramientas no garantiza que el proyecto funcione.

### 9. Confundir reproducibilidad con portabilidad

Un entorno puede ser reproducible en una plataforma específica sin ser portable a todas las demás.

### 10. Ignorar Environment Drift

Las actualizaciones y modificaciones acumuladas pueden alejar el entorno de su estado esperado.

---

## 🧠 Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es un Reproducible Development Environment?
2. ¿Por qué aparece el problema *It works on my machine*?
3. ¿Qué diferencia existe entre Reproducibility, Consistency y Portability?
4. ¿Qué componentes pueden afectar la reproducibilidad?
5. ¿Por qué importan las versiones de Node.js?
6. ¿Qué problema intentan reducir los Lockfiles?
7. ¿Por qué las Environment Variables forman parte de los requisitos?
8. ¿Qué es una Hidden Dependency?
9. ¿Qué significa Environment Drift?
10. ¿Qué diferencia existe entre un Setup manual no documentado y uno documentado?
11. ¿Qué aporta la automatización?
12. ¿Qué diferencia existe entre Declarative e Imperative Setup?
13. ¿Por qué debemos verificar el entorno después de prepararlo?
14. ¿Cómo se relaciona la reproducibilidad con CI?
15. ¿Es obligatorio utilizar Docker para conseguir reproducibilidad?

---

## 💡 Idea clave

Un entorno reproducible no es simplemente una computadora con herramientas instaladas.

Es un entorno cuyos requisitos pueden identificarse, prepararse y verificarse de manera consistente.

```text
Project Requirements
        ↓
Declared Versions
        +
Dependencies
        +
Environment Configuration
        +
Documented Setup
        ↓
Environment Preparation
        ↓
Validation
        ↓
Reproducible Development Workflow
```

**La reproducibilidad reduce la dependencia del conocimiento individual y facilita que diferentes desarrolladores puedan trabajar con el mismo proyecto bajo condiciones compatibles.**

Nuestro objetivo no es eliminar absolutamente todas las diferencias.

Es comprender cuáles importan y aprender a controlarlas.

---

## 🚀 Siguiente paso

Ahora sabemos por qué es importante definir y reproducir las condiciones de nuestro entorno.

Pero todavía necesitamos comprender cómo se organizan los componentes que intervienen en él.

En el siguiente documento estudiaremos las diferentes capas de un Development Environment y cómo se relacionan el Hardware, el Operating System, el Shell, los Runtimes y las herramientas de desarrollo.

👉 [Development Environment Layers](./05-development-environment-layers.md)