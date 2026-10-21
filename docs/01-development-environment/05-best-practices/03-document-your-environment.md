# Document Your Environment

## Introducción

Imagina que llevas dos años trabajando en un proyecto.

Tu computadora tiene todo lo necesario:

- Git.
- Node.js.
- Un gestor de paquetes.
- Variables de entorno.
- Configuraciones de acceso.
- Herramientas de compilación.
- Servicios locales.
- Conexiones con plataformas externas.

El proyecto funciona perfectamente.

Un día recibes una computadora nueva.

Clonas el repositorio y ejecutas:

```bash
npm install
```

La instalación termina, pero la aplicación no funciona.

Descubres que necesitabas una versión específica de Node.js, una variable de entorno, acceso a un Registry privado y un servicio local que habías configurado meses atrás.

Ninguno de esos requisitos estaba documentado.

El problema no es solamente técnico.

Es un problema de **transferencia de conocimiento**.

Una computadora puede funcionar gracias a configuraciones que únicamente conoce su propietario. Cuando ese conocimiento no se registra, el entorno se convierte en una dependencia invisible.

En este documento aprenderemos a evitarlo mediante **Environment Documentation**.

Nuestra metodología será:

**Problema → Concepto → Responsabilidades → Documentación → Validación → Mantenimiento → Reproducibilidad.**

---

## 🎯 Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Explicar qué significa documentar un entorno de desarrollo.
2. Comprender por qué una computadora funcional no necesariamente es reproducible.
3. Diferenciar documentación de máquina, usuario y proyecto.
4. Identificar los requisitos técnicos que deben documentarse.
5. Registrar versiones de herramientas y Runtimes.
6. Comprender cómo documentar variables de entorno sin exponer secretos.
7. Diferenciar requisitos obligatorios y opcionales.
8. Documentar servicios locales y dependencias externas.
9. Diseñar instrucciones de instalación y validación.
10. Comprender qué son los Prerequisites y el Onboarding.
11. Reconocer el papel de README, Lockfiles y archivos de configuración.
12. Crear una matriz de compatibilidad.
13. Diseñar procedimientos de Troubleshooting.
14. Evitar documentación obsoleta.
15. Crear una guía profesional de preparación del entorno.
16. Evaluar si otro desarrollador puede reproducir nuestro Setup.

---

# 1. El problema: Works on My Machine

Una expresión habitual en desarrollo de software es:

> Works on my machine.

Significa:

> Funciona en mi computadora.

Aunque puede describir una situación real, no constituye una explicación suficiente del problema.

## 1.1 Ejemplo

Tenemos dos desarrolladores.

```text
Developer A
│
├── Node.js 22
├── pnpm
├── Environment Variables
├── Private Registry Access
└── Application Works
```

```text
Developer B
│
├── Node.js 20
├── npm
├── Missing Environment Variables
├── No Private Registry Access
└── Application Fails
```

Ambos tienen el mismo código fuente.

Sin embargo, sus entornos son diferentes.

## 1.2 ¿Por qué sucede?

Porque el comportamiento de una aplicación puede depender de elementos externos al código:

- Sistema operativo.
- Arquitectura.
- Runtime.
- Gestor de paquetes.
- Dependencias.
- Variables de entorno.
- Servicios.
- Red.
- Permisos.
- Credenciales.
- Configuración del proyecto.

## 1.3 ¿Cuál es el problema de fondo?

El repositorio no comunica todos los requisitos necesarios para trabajar con él.

## 1.4 ¿Cómo lo solucionamos?

Debemos identificar y documentar esos requisitos.

### Idea clave

**El código fuente es una parte del proyecto; el entorno necesario para ejecutarlo también forma parte de su contrato técnico.**

---

# 2. ¿Qué es Environment Documentation?

**Environment Documentation** es el conjunto de instrucciones, requisitos y referencias que permiten comprender, preparar, validar y mantener un entorno de desarrollo.

Su propósito principal es responder cuatro preguntas:

1. ¿Qué necesito?
2. ¿Por qué lo necesito?
3. ¿Cómo preparo el entorno?
4. ¿Cómo verifico que funciona?

## 2.1 Modelo

```text
Environment Documentation
│
├── Requirements
│   └── What do I need?
│
├── Explanation
│   └── Why do I need it?
│
├── Setup
│   └── How do I configure it?
│
├── Validation
│   └── How do I verify it?
│
└── Troubleshooting
    └── What if it fails?
```

## 2.2 ¿Qué no es?

No consiste simplemente en copiar una lista de comandos.

Una documentación como esta es insuficiente:

```markdown
# Setup

1. Install Node.js.
2. Install dependencies.
3. Run the application.
```

¿Por qué?

Porque deja preguntas importantes sin responder:

- ¿Qué versión de Node.js?
- ¿Qué gestor de paquetes?
- ¿Qué comando de instalación?
- ¿Qué variables necesita?
- ¿Qué servicios deben estar activos?
- ¿Cómo verificamos el resultado?

## 2.3 Mejor enfoque

Una documentación profesional debe ser:

- Clara.
- Precisa.
- Reproducible.
- Segura.
- Mantenible.
- Verificable.
- Apropiada para su audiencia.

### Principio

**Una buena documentación reduce las decisiones que cada desarrollador debe adivinar.**

---

# 3. Documentación vs Reproducibilidad

Estos conceptos están relacionados, pero no son equivalentes.

## 3.1 Documentation

Registra información e instrucciones.

## 3.2 Reproducibility

Permite reconstruir un entorno suficientemente equivalente para obtener resultados esperados.

## 3.3 Relación

```text
Documentation
      │
      ▼
Explicit Requirements
      │
      ▼
Repeatable Setup
      │
      ▼
Environment Validation
      │
      ▼
Improved Reproducibility
```

## 3.4 ¿Documentar garantiza reproducibilidad?

No.

Podemos escribir instrucciones que sean:

- Incorrectas.
- Incompletas.
- Obsoletas.
- Dependientes de servicios desaparecidos.
- Incompatibles con otras plataformas.

Por eso necesitamos validar la documentación.

## 3.5 ¿La automatización reemplaza la documentación?

Tampoco.

Un Script puede automatizar la instalación, pero debemos comprender:

- Qué hace.
- Qué modifica.
- Qué requisitos tiene.
- Qué permisos necesita.
- Cómo diagnosticar errores.

### Idea clave

**La documentación explica el entorno; la automatización ayuda a construirlo; la validación comprueba su funcionamiento.**

---

# 4. Los tres niveles de documentación

No toda la documentación debe vivir en el mismo lugar.

Podemos distinguir tres niveles.

## 4.1 Machine Documentation

Describe características generales de la computadora.

Ejemplos:

- Sistema operativo.
- Arquitectura.
- Herramientas generales.
- Gestor de Runtimes.
- Configuración básica del Terminal.

## 4.2 User Documentation

Describe preferencias y configuraciones personales.

Ejemplos:

- Alias.
- Tema del editor.
- Configuración personal del Shell.
- Organización de directorios.
- Dotfiles.

## 4.3 Project Documentation

Describe los requisitos de un repositorio específico.

Ejemplos:

- Versión de Node.js.
- Gestor de paquetes.
- Dependencias.
- Variables de entorno.
- Servicios.
- Comandos.
- Requisitos de acceso.

## 4.4 Modelo

```text
Development Machine
│
├── Machine Documentation
│   └── General Setup
│
├── User Documentation
│   └── Personal Preferences
│
└── Project Repositories
    │
    ├── Project A
    │   └── Project Documentation
    │
    └── Project B
        └── Project Documentation
```

## 4.5 ¿Por qué separar?

Porque no todos los proyectos necesitan las mismas herramientas.

Y no todas las preferencias personales deberían convertirse en requisitos del equipo.

### Principio

**Cada requisito debe documentarse en el nivel que corresponde a su responsabilidad.**

---

# 5. Requirements: qué necesita nuestro entorno

Los **Requirements** son las condiciones necesarias para preparar o utilizar un proyecto.

Podemos clasificarlos en diferentes categorías.

## 5.1 System Requirements

- Sistema operativo soportado.
- Arquitectura compatible.
- Recursos mínimos, si son relevantes.
- Características del sistema necesarias.

## 5.2 Tool Requirements

- Git.
- Runtime.
- Gestor de paquetes.
- Herramientas de compilación.
- Utilidades requeridas.

## 5.3 Project Requirements

- Dependencias.
- Configuraciones.
- Scripts.
- Archivos necesarios.

## 5.4 Infrastructure Requirements

- Base de datos.
- Cache.
- Contenedores.
- APIs.
- Servicios externos.

## 5.5 Access Requirements

- Acceso al repositorio.
- Registry privado.
- VPN.
- Credenciales.
- Permisos.

## 5.6 Modelo

```text
Project Requirements
│
├── System
├── Tools
├── Runtime
├── Dependencies
├── Configuration
├── Infrastructure
└── Access
```

### Idea clave

**Antes de documentar cómo instalar algo, debemos identificar si realmente es un requisito.**

---

# 6. Required vs Optional Tools

No todas las herramientas utilizadas por un desarrollador son obligatorias.

## 6.1 Required

Herramientas necesarias para ejecutar las operaciones esenciales del proyecto.

Por ejemplo:

```text
Node.js
Project Package Manager
```

## 6.2 Optional

Herramientas que mejoran la experiencia, pero no son indispensables.

Por ejemplo:

```text
Preferred Editor
Terminal Theme
Optional Extensions
```

## 6.3 Recommended

Herramientas sugeridas por el equipo, aunque existan alternativas compatibles.

## 6.4 Comparación

| Clasificación | Significado |
|---|---|
| Required | Necesaria |
| Recommended | Recomendada |
| Optional | Opcional |
| Unsupported | No soportada oficialmente |

## 6.5 Ejemplo

```markdown
## Development Tools

### Required

- Git
- Node.js compatible version
- Project package manager

### Recommended

- VS Code

### Optional

- Personal Terminal customization
```

## 6.6 ¿Por qué importa?

Porque declarar todo como obligatorio aumenta innecesariamente la complejidad del Setup.

### Principio

**Un requisito obligatorio debe estar justificado por una necesidad real del proyecto.**

---

# 7. Documentar el sistema operativo

No debemos asumir que un proyecto funciona idénticamente en todas las plataformas.

## 7.1 Ejemplo de matriz

| Sistema | Estado | Observaciones |
|---|---|---|
| macOS | Supported | Validado por el equipo |
| Windows | Supported | Setup nativo |
| Linux | Supported | Distribuciones definidas |
| WSL2 | Conditional | Validar servicios y rutas |

Esta tabla es un ejemplo de formato, no una declaración de compatibilidad real.

## 7.2 ¿Qué debemos registrar?

- Plataformas probadas.
- Versiones relevantes.
- Arquitecturas soportadas.
- Restricciones conocidas.
- Diferencias de instalación.

## 7.3 ¿Debemos documentar todos los sistemas?

No necesariamente.

Solamente los que el proyecto pretende soportar.

## 7.4 ¿Qué significa Supported?

Que existe un compromiso razonable del equipo de mantener y validar esa plataforma.

### Idea clave

**No debemos declarar compatibilidad con un sistema operativo que nunca hemos probado.**

---

# 8. Documentar versiones de Runtime

Los Runtimes son una parte fundamental del entorno.

Por ejemplo:

```text
Node.js
Python
Java
```

En nuestro Mastery nos enfocaremos especialmente en Node.js.

## 8.1 ¿Por qué documentar versiones?

Porque diferentes versiones pueden tener:

- APIs distintas.
- Cambios de comportamiento.
- Requisitos diferentes.
- Compatibilidad distinta con dependencias.

## 8.2 Ejemplo

```markdown
## Runtime

This project requires Node.js 22.16.0.
```

En este ejemplo la versión es un requisito hipotético de proyecto.

## 8.3 Versiones exactas vs rangos

Podemos documentar:

**Versión exacta:**

```text
22.16.0
```

**Rango compatible:**

```text
22.x
```

La elección depende de la estrategia de compatibilidad.

## 8.4 ¿Cuál es mejor?

No existe una respuesta universal.

Una versión exacta reduce variaciones.

Un rango ofrece flexibilidad, pero requiere pruebas de compatibilidad.

## 8.5 Archivos de versión

Algunos proyectos utilizan archivos como:

```text
.nvmrc
```

Otros emplean mecanismos de configuración de sus gestores.

No todos los gestores interpretan los mismos archivos de la misma manera.

### Principio

**La versión del Runtime debe expresarse de forma coherente con la estrategia real del proyecto.**

---

# 9. Documentar el Package Manager

Un proyecto JavaScript puede utilizar:

- npm.
- pnpm.
- Yarn.

## 9.1 ¿Por qué importa?

Porque los gestores pueden diferir en:

- Lockfiles.
- Resolución.
- Organización de dependencias.
- Workspaces.
- Comandos.
- Configuraciones.

## 9.2 Ejemplo

```markdown
## Package Manager

This repository uses pnpm.

Do not switch package managers without team approval.
```

## 9.3 Declaración en package.json

Podemos encontrar:

```json
{
  "packageManager": "pnpm@X.Y.Z"
}
```

`X.Y.Z` representa una versión concreta por definir.

## 9.4 Lockfile

Si el proyecto utiliza pnpm, normalmente encontraremos:

```text
pnpm-lock.yaml
```

## 9.5 ¿Qué debemos documentar?

- Gestor elegido.
- Versión requerida o soportada.
- Método de instalación o activación.
- Comandos habituales.
- Política de Lockfile.

### Idea clave

**El gestor de paquetes es parte del contrato técnico del repositorio.**

---

# 10. Documentar herramientas del proyecto

Además del Runtime y el gestor, podemos necesitar herramientas específicas.

Ejemplos:

- Compiladores nativos.
- Docker.
- CLI de infraestructura.
- Herramientas de generación.
- Emuladores.
- Clientes de base de datos.

## 10.1 ¿Debemos listar todas las dependencias de package.json?

No.

Esa información ya pertenece a `package.json`.

La documentación debe explicar los requisitos que no quedan suficientemente claros en los archivos de configuración.

## 10.2 Ejemplo

```markdown
## Additional Requirements

- Docker-compatible container runtime
- Access to the development database
- Git
```

## 10.3 Evitar duplicación innecesaria

Si documentamos manualmente cientos de dependencias, la información se desactualizará rápidamente.

### Principio

**La documentación debe complementar las fuentes de verdad del proyecto, no duplicarlas sin necesidad.**

---

# 11. Environment Variables

Las variables de entorno permiten configurar el comportamiento de procesos.

Ejemplos:

```text
PORT
DATABASE_URL
API_BASE_URL
```

## 11.1 ¿Por qué documentarlas?

Porque una aplicación puede necesitar valores que no están incluidos en el repositorio.

## 11.2 Ejemplo

```text
Application
│
├── PORT
├── DATABASE_URL
└── API_BASE_URL
```

Si falta alguna variable obligatoria, la aplicación puede fallar.

## 11.3 ¿Qué debemos registrar?

Para cada variable:

- Nombre.
- Propósito.
- Obligatoriedad.
- Formato.
- Ejemplo seguro.
- Fuente autorizada del valor real.

## 11.4 Tabla

| Variable | Required | Description | Example |
|---|---|---|---|
| `PORT` | Yes | Puerto local | `3000` |
| `API_BASE_URL` | Yes | URL del Backend | `http://localhost:4000` |
| `DATABASE_URL` | Yes | Conexión a BD | Valor privado |

## 11.5 ¿Debemos documentar valores reales?

Depende.

Podemos documentar valores públicos y no sensibles.

No debemos incluir credenciales, Tokens o secretos.

### Idea clave

**Documentar una variable no significa publicar su valor secreto.**

---

# 12. .env vs .env.example

Este es un patrón habitual en proyectos.

## 12.1 .env

Puede contener valores utilizados en un entorno local.

Ejemplo conceptual:

```dotenv
PORT=3000
API_BASE_URL=http://localhost:4000
```

Un `.env` también puede contener información sensible.

## 12.2 .env.example

Puede servir como plantilla para mostrar qué variables necesita el proyecto.

```dotenv
PORT=3000
API_BASE_URL=http://localhost:4000
DATABASE_URL=
```

## 12.3 Modelo

```text
.env.example
     │
     ▼
Documents Required Variables
     │
     ▼
Developer Configures Local Values
     │
     ▼
Application Reads Configuration
```

## 12.4 ¿Debemos versionar .env?

No debemos versionar archivos que contengan secretos.

Las políticas exactas pueden variar según el proyecto.

## 12.5 ¿Debemos versionar .env.example?

Normalmente sí, siempre que contenga únicamente ejemplos seguros.

## 12.6 Precaución importante

La existencia de `.env` no garantiza que una aplicación lo cargue automáticamente.

Eso depende del Runtime, Framework o mecanismo de configuración utilizado.

### Principio

**`.env.example` documenta el contrato de configuración; `.env` puede contener los valores locales necesarios para cumplirlo.**

---

# 13. Documentar secretos correctamente

Un **Secret** es información que debe protegerse contra acceso o divulgación no autorizados.

Ejemplos:

- API Keys.
- Tokens.
- Contraseñas.
- Credenciales de base de datos.
- Claves privadas.

## 13.1 ¿Qué no debemos hacer?

No debemos escribir:

```markdown
DATABASE_PASSWORD=real-password
```

Ni incluir Tokens reales en capturas o ejemplos.

## 13.2 ¿Qué sí debemos hacer?

Documentar el procedimiento autorizado para obtener los valores.

Ejemplo:

```markdown
## Secrets

Required credentials are provided through the
organization's approved secret management process.

Do not commit credentials to the repository.
```

## 13.3 ¿Por qué no documentar directamente el secreto?

Porque la documentación suele compartirse, versionarse o publicarse.

## 13.4 ¿Qué pasa si un secreto se filtra?

Debe seguirse el procedimiento de respuesta de seguridad correspondiente, que puede incluir revocación y rotación.

Eliminarlo de un archivo no garantiza que desaparezca del historial o de copias existentes.

### Idea clave

**La documentación debe explicar cómo acceder legítimamente a los secretos, no convertirse en un almacén de secretos.**

---

# 14. Documentar servicios locales

Algunos proyectos necesitan servicios adicionales.

Ejemplos:

- PostgreSQL.
- Redis.
- APIs locales.
- Servicios de mensajería.
- Contenedores.

## 14.1 Ejemplo

```text
Frontend
    │
    ▼
Backend API
    │
    ├── PostgreSQL
    └── Redis
```

## 14.2 ¿Qué debemos registrar?

- Nombre del servicio.
- Propósito.
- Versión requerida, cuando corresponda.
- Puerto.
- Método de inicio.
- Método de verificación.
- Dependencias.
- Procedimiento de detención.

## 14.3 Tabla

| Servicio | Propósito | Puerto de ejemplo |
|---|---|---|
| Frontend | Aplicación web | 5173 |
| Backend | API | 3000 |
| PostgreSQL | Persistencia | 5432 |
| Redis | Cache/colas | 6379 |

Los puertos son ilustrativos.

## 14.4 ¿Qué no debemos asumir?

Que todos los servicios se ejecutan localmente.

Un proyecto puede utilizar infraestructura remota.

### Principio

**Una dependencia de infraestructura debe estar documentada aunque no forme parte de las dependencias JavaScript.**

---

# 15. Documentar dependencias externas

Una aplicación puede depender de servicios que no administramos localmente.

Por ejemplo:

- APIs externas.
- Cloud Services.
- Authentication Providers.
- Private Registries.
- VPN.
- Gateways.

## 15.1 Modelo

```text
Local Application
       │
       ▼
External Service
       │
       ├── Authentication
       ├── Network Access
       └── Permissions
```

## 15.2 ¿Qué debemos documentar?

- Qué servicio se necesita.
- Para qué se utiliza.
- Qué entorno debe seleccionarse.
- Qué permisos son necesarios.
- Cómo solicitar acceso.
- Cómo verificar conectividad.

## 15.3 ¿Qué debemos evitar?

Publicar URLs internas sensibles, Tokens o detalles de infraestructura restringidos en documentación pública.

## 15.4 Ejemplo

```markdown
## External Dependencies

The application requires access to the development API.

Access is managed by the infrastructure team.

Verify that the approved network connection is active
before starting integration tests.
```

### Idea clave

**Un proyecto puede estar correctamente instalado y aun así no funcionar porque carece de acceso a un servicio externo.**

---

# 16. Documentar acceso a Private Registries

En organizaciones empresariales es habitual utilizar paquetes privados.

## 16.1 Ejemplo

```text
Project
   │
   ▼
Package Manager
   │
   ▼
Private Registry
   │
   ▼
Private Dependencies
```

## 16.2 ¿Qué requisitos pueden existir?

- Cuenta corporativa.
- Permisos de lectura.
- Autenticación.
- Configuración del Registry.
- Conectividad de red.

## 16.3 ¿Qué debemos documentar?

- Qué Registry utiliza el proyecto.
- Qué paquetes o Scopes dependen de él.
- Qué permisos solicitar.
- Dónde encontrar las instrucciones oficiales.
- Cómo validar la autenticación de forma segura.

## 16.4 ¿Qué no debemos hacer?

Incluir Tokens reales dentro del README.

Tampoco debemos asumir que copiar la configuración de otra persona es una práctica autorizada.

### Principio

**La documentación de un Registry privado debe permitir configurar el acceso sin exponer credenciales.**

---

# 17. Documentar el proceso de instalación

Ahora podemos organizar los requisitos en una secuencia.

## 17.1 Orden recomendado

```text
Check Prerequisites
        │
        ▼
Prepare Runtime
        │
        ▼
Prepare Package Manager
        │
        ▼
Configure Access
        │
        ▼
Install Dependencies
        │
        ▼
Configure Environment
        │
        ▼
Start Services
        │
        ▼
Run Application
        │
        ▼
Validate
```

El orden concreto depende del proyecto.

## 17.2 Ejemplo de instrucciones

```markdown
## Setup

1. Verify the supported operating system.
2. Install the required Node.js version.
3. Activate the project's package manager.
4. Configure access to required registries.
5. Install dependencies.
6. Create the local environment configuration.
7. Start required services.
8. Run the development command.
9. Verify the application.
```

## 17.3 ¿Por qué importa el orden?

Porque algunos pasos dependen de otros.

Por ejemplo, no podemos instalar dependencias desde un Registry privado si todavía no tenemos acceso.

### Idea clave

**Una guía de instalación debe respetar las dependencias entre pasos.**

---

# 18. Documentar comandos de desarrollo

Una vez instalado el proyecto, necesitamos conocer sus operaciones habituales.

## 18.1 Ejemplo

```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "lint": "eslint .",
    "typecheck": "tsc --noEmit",
    "test": "vitest"
  }
}
```

## 18.2 Documentación

| Comando | Propósito |
|---|---|
| `pnpm dev` | Iniciar desarrollo |
| `pnpm build` | Generar Build |
| `pnpm lint` | Ejecutar Linting |
| `pnpm typecheck` | Comprobar tipos |
| `pnpm test` | Ejecutar pruebas |

Estos comandos son ilustrativos y solo funcionarán si los Scripts y herramientas correspondientes existen en el proyecto.

## 18.3 ¿Por qué documentarlos?

Porque facilitan:

- Onboarding.
- Desarrollo diario.
- Revisiones.
- CI/CD.
- Resolución de incidencias.

### Principio

**Los comandos compartidos deben ser fáciles de descubrir y comprender.**

---

# 19. Validation: comprobar que el entorno funciona

Una guía de instalación no debería terminar en:

> Ya está instalado.

Necesitamos comprobar el resultado.

## 19.1 ¿Qué es Environment Validation?

Es el proceso de verificar que los requisitos del entorno están correctamente preparados.

## 19.2 Niveles de validación

```text
Environment Validation
│
├── Tool Validation
├── Runtime Validation
├── Dependency Validation
├── Configuration Validation
├── Service Validation
└── Application Validation
```

## 19.3 Tool Validation

Comprobar herramientas:

```bash
git --version
```

```bash
node --version
```

## 19.4 Package Manager Validation

Comprobar el gestor requerido:

```bash
pnpm --version
```

## 19.5 Project Validation

Ejecutar las operaciones definidas por el proyecto:

```bash
pnpm build
```

```bash
pnpm test
```

Siempre que esos Scripts existan.

## 19.6 Application Validation

Comprobar que la aplicación:

- Inicia correctamente.
- Responde en el puerto esperado.
- Puede acceder a los servicios necesarios.
- Ejecuta una operación básica.

### Idea clave

**Un entorno no está validado únicamente porque las herramientas estén instaladas.**

---

# 20. Documentar el resultado esperado

Una instrucción debe indicar qué significa que haya funcionado.

## 20.1 Ejemplo incompleto

```markdown
Run the application:

pnpm dev
```

## 20.2 Ejemplo mejorado

```markdown
Run the development server:

pnpm dev

Expected result:

- The command starts without configuration errors.
- The development server displays its local address.
- The application loads successfully in the browser.
```

## 20.3 ¿Por qué importa?

Porque un desarrollador principiante puede ejecutar correctamente un comando y no saber si el resultado es el esperado.

## 20.4 Evitar expectativas falsas

No debemos prometer mensajes exactos si pueden cambiar entre versiones.

### Principio

**Cada paso importante debería tener una condición observable de éxito.**

---

# 21. Troubleshooting Documentation

Incluso una buena guía puede encontrar errores.

Por eso necesitamos documentar problemas frecuentes.

## 21.1 Estructura recomendada

```text
Problem
   │
   ▼
Symptoms
   │
   ▼
Possible Causes
   │
   ▼
Safe Diagnostics
   │
   ▼
Resolution
   │
   ▼
Validation
```

## 21.2 Ejemplo: versión incorrecta de Node.js

**Síntoma:** el proyecto informa que la versión de Node.js no es compatible.

**Posibles causas:**

- Runtime incorrecto.
- Gestor de versiones no activado.
- Instalaciones duplicadas.

**Diagnóstico:**

```bash
node --version
```

**Resolución:**

Seleccionar la versión requerida utilizando el procedimiento aprobado por el proyecto.

**Validación:**

Volver a consultar la versión y ejecutar los comandos de comprobación.

## 21.3 Ejemplo: acceso a Registry privado

**Síntoma:** la instalación de dependencias falla con un error de autenticación o autorización.

**Posibles causas:**

- Credenciales ausentes.
- Credenciales caducadas.
- Permisos insuficientes.
- Registry incorrecto.

**Diagnóstico:**

Revisar la configuración aplicable y confirmar los permisos mediante el procedimiento autorizado.

**Resolución:**

Seguir las instrucciones oficiales de acceso.

**Validación:**

Reintentar la operación requerida sin publicar Tokens ni registros sensibles.

### Idea clave

**Una buena sección de Troubleshooting enseña a diagnosticar, no solamente a copiar soluciones.**

---

# 22. Documentar diferencias entre sistemas operativos

Un mismo proyecto puede requerir instrucciones diferentes según el sistema.

## 22.1 Ejemplo

En macOS y Linux podemos utilizar Shells como Bash o Zsh.

En Windows podemos utilizar PowerShell, Git Bash o WSL.

## 22.2 Problema

Un comando escrito para Bash puede no funcionar igual en PowerShell.

## 22.3 Mejor enfoque

Separar instrucciones cuando realmente existan diferencias.

```text
Setup Guide
│
├── Shared Requirements
│
├── macOS
│
├── Windows
│
└── Linux
```

## 22.4 ¿Debemos duplicar toda la guía?

No.

Conviene mantener una sección común y separar solamente los pasos específicos.

## 22.5 WSL

Si el proyecto utiliza WSL, debemos documentar si el entorno de desarrollo se ejecuta:

- En Windows nativo.
- Dentro de la distribución Linux.
- En una combinación controlada de ambos.

### Principio

**La documentación multiplataforma debe hacer explícitas las diferencias que afectan a la ejecución.**

---

# 23. Environment Inventory

Un **Environment Inventory** es un registro de las herramientas y configuraciones relevantes.

## 23.1 Ejemplo

| Component | Required Version | Installed Version | Status |
|---|---|---|---|
| Git | Compatible | Por verificar | Pending |
| Node.js | Definida por proyecto | Por verificar | Pending |
| pnpm | Definida por proyecto | Por verificar | Pending |
| Docker | Si es requerido | Por verificar | Pending |

## 23.2 ¿Para qué sirve?

- Preparar una máquina.
- Diagnosticar diferencias.
- Planificar migraciones.
- Documentar requisitos.
- Facilitar soporte.

## 23.3 ¿Debemos versionar un inventario personal completo?

No necesariamente.

Las versiones personales instaladas cambian y pueden no representar requisitos del proyecto.

### Principio

**Debemos distinguir el estado actual de una máquina del estado requerido por el proyecto.**

---

# 24. Source of Truth

Un concepto fundamental en ingeniería es **Source of Truth**.

Se refiere a la fuente autorizada para una determinada información.

## 24.1 Problema

Imaginemos:

```text
README.md
    └── Node.js 20
```

```text
.nvmrc
    └── Node.js 22
```

```text
CI Configuration
    └── Node.js 18
```

¿Qué versión es la correcta?

Tenemos información contradictoria.

## 24.2 ¿Cómo evitarlo?

Definir qué archivo representa la referencia principal y mantener las demás configuraciones alineadas.

## 24.3 Ejemplo de responsabilidades

| Información | Fuente principal posible |
|---|---|
| Dependencias | `package.json` |
| Resolución de dependencias | Lockfile |
| Versión de Runtime | Archivo/configuración elegida |
| Scripts | `package.json` |
| Variables requeridas | Esquema o `.env.example` |
| Procedimiento | README / Setup Guide |

## 24.4 ¿El README debe repetir todas las versiones?

No necesariamente.

Puede referirse a los archivos que contienen los requisitos.

### Idea clave

**La documentación debe indicar dónde está la verdad, no crear múltiples versiones contradictorias de ella.**

---

# 25. Documentation as Code

**Documentation as Code** consiste en tratar la documentación con prácticas similares a las del desarrollo de software.

## 25.1 Características

- Archivos versionados.
- Revisión mediante Pull Requests.
- Historial de cambios.
- Convenciones.
- Validación.
- Mantenimiento junto al código.

## 25.2 Ejemplo

```text
Repository
│
├── README.md
├── docs/
│   └── development-setup.md
├── package.json
├── pnpm-lock.yaml
└── src/
```

## 25.3 Beneficios

- La documentación evoluciona con el proyecto.
- Los cambios pueden revisarse.
- El equipo puede proponer mejoras.
- Es posible detectar información obsoleta.

## 25.4 ¿Qué herramientas podemos utilizar?

- Markdown.
- Git.
- Pull Requests.
- Linters de documentación.
- Validación de enlaces.
- Automatización.

Las herramientas específicas se estudiarán en módulos posteriores.

### Principio

**La documentación técnica debe mantenerse como parte del producto, no como un documento abandonado después del Onboarding.**

---

# 26. Onboarding de nuevos desarrolladores

**Onboarding** es el proceso de incorporación de una persona a un equipo o proyecto.

La preparación del entorno es una parte importante de ese proceso.

## 26.1 Modelo

```text
New Developer
      │
      ▼
Access Repository
      │
      ▼
Read Requirements
      │
      ▼
Prepare Environment
      │
      ▼
Install Dependencies
      │
      ▼
Configure Services
      │
      ▼
Run Validation
      │
      ▼
Start Contributing
```

## 26.2 ¿Qué caracteriza a un buen Onboarding?

Un desarrollador debería poder identificar:

- Qué necesita.
- Dónde obtenerlo.
- Cómo configurarlo.
- Cómo verificarlo.
- A quién acudir si falla.

## 26.3 ¿Debemos eliminar toda intervención humana?

No.

Algunos permisos o accesos requieren aprobación.

La documentación debe explicar esos pasos sin prometer automatización donde no existe.

### Idea clave

**Una buena guía de Setup reduce la dependencia de explicaciones informales y repetitivas.**

---

# 27. ¿Cómo mantener actualizada la documentación?

La documentación puede convertirse en deuda técnica.

## 27.1 Ejemplo

Actualizamos Node.js en el proyecto, pero olvidamos modificar el README.

El siguiente desarrollador sigue instrucciones antiguas.

## 27.2 Estrategia

Cada cambio que afecte al entorno debe considerar su impacto documental.

Por ejemplo:

```text
Change Runtime Version
          │
          ▼
Update Configuration
          │
          ▼
Update Documentation
          │
          ▼
Validate Setup
          │
          ▼
Review in Pull Request
```

## 27.3 Cambios que requieren revisión

- Runtime.
- Package Manager.
- Dependencias externas.
- Variables.
- Scripts.
- Puertos.
- Servicios.
- Requisitos de acceso.
- Sistemas soportados.

## 27.4 Responsabilidad

La documentación no debería depender exclusivamente de una persona.

El equipo debe asumir su mantenimiento.

### Principio

**Si cambia la manera de preparar o ejecutar el proyecto, debemos revisar su documentación.**

---

# 28. Ejemplo profesional: Development Environment Guide

Vamos a construir una plantilla reutilizable.

El siguiente ejemplo representa un proyecto hipotético.

Las versiones, comandos y servicios deben adaptarse a los requisitos reales de cada repositorio.

## 28.1 Estructura propuesta

```text
project/
│
├── README.md
├── docs/
│   └── development-setup.md
├── .env.example
├── package.json
├── pnpm-lock.yaml
└── src/
```

## 28.2 Plantilla

```markdown
# Development Environment Setup

## Overview

This document explains how to prepare the local
development environment.

## Supported Platforms

- macOS: Supported
- Windows: Supported
- Linux: Supported

Support status must be validated by the project team.

## Prerequisites

### Required

- Git
- Supported Node.js version
- Project package manager
- Access to required services

### Recommended

- VS Code

## Runtime

Use the Node.js version declared by the project.

Verify:

node --version

## Package Manager

Use the package manager and version specified
in package.json.

Verify its availability before installing dependencies.

## Repository Access

Request access through the approved team process.

## Private Packages

Configure private Registry authentication using
the organization's official instructions.

Do not commit credentials.

## Installation

1. Clone the repository.
2. Select the required Runtime.
3. Activate the required package manager.
4. Configure Registry access.
5. Install dependencies.
6. Configure environment variables.
7. Start required services.
8. Start the application.

## Environment Variables

Copy the documented variable names from
.env.example into the appropriate local configuration.

Obtain secret values through approved channels.

## Development Commands

- pnpm dev
- pnpm build
- pnpm lint
- pnpm test

Only use commands that exist in this project.

## Validation

1. Verify Runtime version.
2. Verify package manager version.
3. Verify dependencies.
4. Run the Build.
5. Run the tests.
6. Start the application.
7. Confirm expected functionality.

## Troubleshooting

### Runtime mismatch

Verify the active Node.js version.

### Registry authentication failure

Verify authorized access and configuration.

### Missing environment variable

Review .env.example and the configuration guide.

### Service unavailable

Verify required services and network access.

## Security

- Never commit secrets.
- Do not share access Tokens.
- Follow organizational security policies.
- Use least privilege.

## Support

Contact the responsible project team through
the established support channel.
```

## 28.3 ¿Qué tiene de profesional esta plantilla?

Incluye:

- Contexto.
- Requisitos.
- Acceso.
- Configuración.
- Instalación.
- Validación.
- Troubleshooting.
- Seguridad.
- Soporte.

## 28.4 ¿Es suficiente para cualquier proyecto?

No.

Es un punto de partida.

Cada repositorio debe incorporar sus necesidades reales.

---

# 29. Práctica: documentar tu entorno actual

Esta práctica no modificará tu computadora.

Su objetivo es crear un inventario.

## Step 1 — Identificar sistema operativo

### macOS

```bash
sw_vers
```

### Linux

```bash
cat /etc/os-release
```

### Windows PowerShell

```powershell
Get-ComputerInfo |
  Select-Object WindowsProductName, OsArchitecture
```

## Step 2 — Identificar Git

```bash
git --version
```

## Step 3 — Identificar Node.js

```bash
node --version
```

## Step 4 — Identificar el gestor de paquetes

Si utilizas pnpm:

```bash
pnpm --version
```

## Step 5 — Identificar la ubicación de los ejecutables

### Bash / Zsh

```bash
type -a node
```

### PowerShell

```powershell
Get-Command node -All
```

## Step 6 — Completar inventario

| Herramienta | Versión actual | Método de instalación | Propósito |
|---|---|---|---|
| Git | | | |
| Node.js | | | |
| npm | | | |
| pnpm | | | |
| Editor | | | |
| Runtime Manager | | | |

No es necesario que todas estén instaladas.

## Step 7 — Reflexión

Pregúntate:

- ¿Sé por qué instalé cada herramienta?
- ¿Conozco qué proyectos la utilizan?
- ¿Puedo reconstruir esta configuración?
- ¿Existen instalaciones duplicadas?
- ¿Qué información debería documentar?

---

# 30. Práctica: identificar requisitos ocultos

Imagina este proyecto:

```text
frontend-app/
├── src/
├── package.json
└── README.md
```

El README contiene:

```markdown
# Frontend App

Run:

npm install

npm run dev
```

Pero el proyecto necesita:

- Node.js 22.
- pnpm.
- Un Registry privado.
- Una variable `API_BASE_URL`.
- Acceso a una API corporativa.

## 30.1 ¿Qué problemas encontramos?

La documentación:

1. No especifica el Runtime.
2. Indica un gestor de paquetes incorrecto.
3. No menciona el Registry.
4. No documenta variables.
5. No menciona el acceso a la API.
6. No incluye validación.

## 30.2 Ejercicio

Redacta una nueva guía que contenga:

- Prerequisites.
- Runtime.
- Package Manager.
- Private Registry.
- Environment Variables.
- Setup.
- Validation.
- Troubleshooting.

## 30.3 Resultado esperado

Una persona que nunca trabajó en el proyecto debería poder identificar todos los requisitos, incluso si algunos accesos deben solicitarse.

### Aprendizaje

**La documentación debe revelar las dependencias que no son evidentes al observar únicamente el código.**

---

# 31. Práctica: evaluar una guía de Setup

Considera estas dos versiones.

## Versión A

```markdown
# Setup

Install Node and run the project.
```

## Versión B

```markdown
# Setup

## Requirements

Use the Node.js version declared by the project.

## Installation

Install dependencies using the documented package manager.

## Configuration

Create the required local environment configuration.

## Validation

Run the project's Build and test commands.

## Troubleshooting

Consult the documented diagnostics for common failures.
```

## Preguntas

1. ¿Cuál ofrece más contexto?
2. ¿Cuál reduce las suposiciones?
3. ¿Cuál permite validar el resultado?
4. ¿Qué información sigue faltando en la versión B?
5. ¿Cómo mejorarías ambas?

## Reflexión

La versión B es mejor, pero todavía necesita valores y procedimientos concretos.

**Una buena estructura documental no reemplaza la precisión técnica.**

---

# 32. Environment Documentation Checklist

## Requirements

- [ ] El sistema operativo soportado está identificado.
- [ ] Las arquitecturas relevantes están documentadas.
- [ ] Las herramientas obligatorias están listadas.
- [ ] Las herramientas opcionales están diferenciadas.
- [ ] Las versiones importantes están definidas.

## Runtime

- [ ] La versión requerida está declarada.
- [ ] Existe una estrategia para seleccionarla.
- [ ] El procedimiento de validación está documentado.

## Package Manager

- [ ] El gestor elegido está identificado.
- [ ] La versión requerida está definida cuando corresponde.
- [ ] El Lockfile está gestionado correctamente.
- [ ] Los comandos de instalación están documentados.

## Configuration

- [ ] Las variables necesarias están identificadas.
- [ ] Existe una plantilla segura cuando corresponde.
- [ ] Los secretos no están publicados.
- [ ] El procedimiento para obtener credenciales está explicado.

## Infrastructure

- [ ] Los servicios necesarios están documentados.
- [ ] Los puertos relevantes están identificados.
- [ ] Las dependencias externas están explicadas.
- [ ] Los requisitos de acceso están claros.

## Setup

- [ ] Los pasos siguen un orden lógico.
- [ ] Los comandos corresponden al proyecto.
- [ ] Las diferencias entre sistemas están contempladas.
- [ ] Existen resultados esperados.

## Validation

- [ ] Podemos comprobar herramientas.
- [ ] Podemos comprobar versiones.
- [ ] Podemos ejecutar el Build.
- [ ] Podemos ejecutar las pruebas pertinentes.
- [ ] Podemos verificar la aplicación.

## Maintenance

- [ ] La documentación tiene responsables.
- [ ] Se revisa cuando cambia el entorno.
- [ ] No contradice los archivos de configuración.
- [ ] Los enlaces y procedimientos siguen vigentes.
- [ ] La guía ha sido probada por alguien distinto de su autor.

---

# 33. Errores comunes

### Error 1 — Documentar solamente comandos

Sin explicar requisitos, contexto ni resultados.

### Error 2 — Escribir «instala Node.js» sin indicar versión

Puede generar incompatibilidades.

### Error 3 — No especificar el gestor de paquetes

Puede producir Lockfiles y comportamientos distintos.

### Error 4 — Omitir variables de entorno

La aplicación puede fallar aunque las dependencias estén instaladas.

### Error 5 — Publicar credenciales

Compromete la seguridad.

### Error 6 — Documentar servicios sin explicar cómo verificarlos

Dificulta el diagnóstico.

### Error 7 — Declarar compatibilidad con sistemas no probados

Crea expectativas incorrectas.

### Error 8 — Duplicar versiones en múltiples documentos

Puede generar contradicciones.

### Error 9 — No actualizar la documentación al cambiar el Runtime

Provoca instrucciones obsoletas.

### Error 10 — Confundir preferencias personales con requisitos

Complica innecesariamente el Setup.

### Error 11 — No distinguir herramientas obligatorias y opcionales

Hace que el entorno parezca más complejo de lo necesario.

### Error 12 — Omitir accesos corporativos

Puede bloquear la instalación.

### Error 13 — No documentar Private Registries

Dificulta instalar dependencias.

### Error 14 — Terminar la guía sin validación

No permite comprobar que el entorno funciona.

### Error 15 — Escribir instrucciones que nunca se prueban

Puede perpetuar errores durante meses.

### Error 16 — Confiar exclusivamente en el conocimiento de un compañero

Genera dependencia de personas concretas.

---

# 34. Comprueba tu modelo mental

1. ¿Qué significa Works on My Machine?
2. ¿Por qué el mismo código puede comportarse de manera diferente en dos computadoras?
3. ¿Qué es Environment Documentation?
4. ¿Qué cuatro preguntas principales debe responder?
5. ¿Qué diferencia existe entre Documentation y Reproducibility?
6. ¿La documentación garantiza reproducibilidad?
7. ¿La automatización reemplaza la documentación?
8. ¿Qué es Machine Documentation?
9. ¿Qué es User Documentation?
10. ¿Qué es Project Documentation?
11. ¿Qué significa Required?
12. ¿Qué significa Optional?
13. ¿Qué significa Recommended?
14. ¿Por qué debemos documentar sistemas operativos soportados?
15. ¿Por qué es importante registrar versiones de Runtime?
16. ¿Qué diferencia existe entre versión exacta y rango compatible?
17. ¿Por qué debemos documentar el gestor de paquetes?
18. ¿Qué información ya está representada en `package.json`?
19. ¿Qué es una Environment Variable?
20. ¿Para qué sirve `.env.example`?
21. ¿`.env` se carga automáticamente en cualquier aplicación?
22. ¿Por qué no debemos documentar Tokens reales?
23. ¿Qué información debemos registrar sobre servicios locales?
24. ¿Qué es una dependencia externa?
25. ¿Por qué debemos documentar el acceso a Registries privados?
26. ¿Qué es Environment Validation?
27. ¿Por qué una instalación exitosa no garantiza que la aplicación funcione?
28. ¿Qué es Troubleshooting Documentation?
29. ¿Qué es Onboarding?
30. ¿Qué es Source of Truth?
31. ¿Por qué es peligroso mantener versiones contradictorias?
32. ¿Qué es Documentation as Code?
33. ¿Cuándo debemos actualizar la documentación?
34. ¿Qué caracteriza a una buena guía de Setup?
35. ¿Cómo comprobarías que tu documentación es reproducible?

---

# 35. Checklist de aprendizaje

- [ ] Comprendo el problema de Works on My Machine.
- [ ] Sé explicar Environment Documentation.
- [ ] Distingo documentación y reproducibilidad.
- [ ] Identifico Machine, User y Project Documentation.
- [ ] Puedo clasificar requisitos.
- [ ] Distingo Required, Recommended y Optional.
- [ ] Comprendo la importancia de documentar plataformas.
- [ ] Sé documentar versiones de Runtime.
- [ ] Sé documentar el gestor de paquetes.
- [ ] Comprendo cómo documentar herramientas adicionales.
- [ ] Sé documentar variables de entorno.
- [ ] Diferencio `.env` y `.env.example`.
- [ ] Comprendo cómo proteger secretos.
- [ ] Sé documentar servicios locales.
- [ ] Sé documentar dependencias externas.
- [ ] Comprendo cómo documentar Private Registries.
- [ ] Puedo organizar una guía de instalación.
- [ ] Puedo documentar comandos.
- [ ] Comprendo Environment Validation.
- [ ] Sé describir resultados esperados.
- [ ] Puedo estructurar Troubleshooting.
- [ ] Comprendo las diferencias multiplataforma.
- [ ] Puedo elaborar un Environment Inventory.
- [ ] Comprendo Source of Truth.
- [ ] Comprendo Documentation as Code.
- [ ] Puedo evaluar una guía de Onboarding.
- [ ] Sé cuándo actualizar documentación.
- [ ] Puedo diseñar una guía profesional de Setup.

---

# 💡 Idea clave

Una computadora de desarrollo no debería funcionar gracias a configuraciones que solamente conoce su propietario.

```text
Undocumented Environment
          │
          ▼
    Hidden Requirements
          │
          ▼
   Difficult Onboarding
          │
          ▼
  Inconsistent Development
```

El enfoque profesional es:

```text
Identify Requirements
          │
          ▼
Document Responsibilities
          │
          ▼
Define Setup Procedure
          │
          ▼
Validate Environment
          │
          ▼
Maintain Documentation
          │
          ▼
Reproducible Development
```

**Documentar nuestro entorno significa transformar conocimiento personal en conocimiento técnico compartido, verificable y mantenible.**

---

# 🚀 Siguiente paso

Ahora sabemos cómo organizar nuestra máquina, evitar dependencias globales ocultas y documentar los requisitos de desarrollo.

Nos queda una última responsabilidad: **mantener nuestras herramientas actualizadas sin comprometer la estabilidad de los proyectos**.

En el siguiente documento aprenderemos:

- Cómo planificar actualizaciones.
- Qué diferencia existe entre Update y Upgrade.
- Cómo interpretar versiones.
- Cuándo mantener una versión.
- Cómo reducir riesgos de incompatibilidad.
- Cómo validar cambios.
- Cómo diseñar una política de mantenimiento.

👉 [Keep Your Tools Updated](./04-keep-your-tools-updated.md)