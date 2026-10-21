# Homebrew

Homebrew es uno de los gestores de paquetes más utilizados en macOS.

Permite instalar, actualizar, consultar y desinstalar numerosas herramientas desde la línea de comandos, proporcionando un mecanismo común para administrar software.

Sin embargo, Homebrew no es una herramienta que debamos utilizar automáticamente para instalar cualquier cosa.

Antes de incorporarlo a nuestro Development Environment, necesitamos comprender **qué problema resuelve, cómo organiza los paquetes, dónde instala el software y cómo se relaciona con el resto de nuestras herramientas**.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué es Homebrew y qué problema resuelve.
- Qué significa Package Manager a nivel de sistema.
- Qué diferencia existe entre Homebrew, npm, pnpm y nvm.
- Qué son Formulae, Casks, Bottles y Taps.
- Qué significa Homebrew Prefix.
- Cómo se organizan Cellar, Kegs y Symlinks.
- Cómo se relaciona Homebrew con `PATH`.
- Qué papel cumplen las Apple Command Line Tools.
- Cómo instalar Homebrew mediante el procedimiento oficial.
- Cómo consultar, instalar, actualizar y desinstalar paquetes.
- Qué diferencia existe entre `brew update` y `brew upgrade`.
- Qué son los Brewfiles y para qué sirven.
- Cómo evitar instalaciones duplicadas y conflictos entre herramientas.
- Cómo diagnosticar problemas frecuentes.

---

## 🧠 1. El problema: instalar software manualmente

Imagina que necesitamos preparar una Mac para desarrollar software.

Queremos utilizar herramientas como:

```text
Git
wget
jq
Node.js
```

Una alternativa sería buscar cada herramienta en Internet, descargar su instalador, completar el proceso y comprobar su funcionamiento.

```text
Developer
    ↓
Find Official Website
    ↓
Download Installer
    ↓
Install Software
    ↓
Configure Environment
    ↓
Verify Installation
```

Este procedimiento puede funcionar correctamente.

Pero cuando necesitamos administrar muchas herramientas, aparecen desafíos:

- Diferentes mecanismos de instalación.
- Distintas ubicaciones.
- Actualizaciones independientes.
- Versiones incompatibles.
- Desinstalaciones incompletas.
- Dificultad para recordar cómo instalamos cada herramienta.

Aquí aparece la necesidad de un Package Manager.

---

## 📦 2. ¿Qué es un Package Manager?

Un **Package Manager** es una herramienta que permite administrar paquetes de software mediante operaciones como:

- Buscar.
- Instalar.
- Consultar.
- Actualizar.
- Desinstalar.

Conceptualmente:

```text
Developer
    ↓
Package Manager
    ↓
Package Information
    ↓
Download / Installation
    ↓
Installed Software
```

El Package Manager ayuda a coordinar estas operaciones y a administrar los paquetes que controla.

### ¿Qué es un Package?

Un Package es una unidad de software distribuida mediante un mecanismo de empaquetado.

Puede contener:

- Ejecutables.
- Bibliotecas.
- Recursos.
- Metadata.
- Información de dependencias.

El contenido concreto depende del ecosistema.

### ¿Qué significa Dependency?

Una **Dependency** es un componente del que otro software depende para funcionar o realizar determinadas operaciones.

Por ejemplo:

```text
Package A
    ↓
Requires Package B
```

Un Package Manager puede utilizar información sobre dependencias para instalar componentes necesarios.

---

## 🍺 3. ¿Qué es Homebrew?

**Homebrew** es un Package Manager gratuito y de código abierto que permite administrar software en macOS y Linux.

En macOS es especialmente utilizado para instalar herramientas de desarrollo.

Por ejemplo:

```bash
brew install jq
```

Este comando solicita a Homebrew instalar `jq`, una herramienta para procesar JSON desde la línea de comandos.

El proceso puede incluir:

```text
brew install jq
       ↓
Resolve Package
       ↓
Check Dependencies
       ↓
Download Required Files
       ↓
Install Package
       ↓
Make Command Available
```

El flujo real depende del paquete y del entorno.

### ¿Homebrew viene instalado con macOS?

No.

Homebrew se instala por separado.

### ¿Es obligatorio utilizarlo?

No.

Podemos desarrollar software en macOS sin Homebrew.

Sin embargo, ofrece una forma práctica y consistente de administrar muchas herramientas.

**Homebrew es una opción de gestión de software, no un requisito universal de macOS.**

---

## 🧩 4. Homebrew vs npm vs pnpm vs nvm

Esta es una de las distinciones más importantes del documento.

Aunque todas estas herramientas participan en nuestro entorno de desarrollo, no cumplen la misma responsabilidad.

| Herramienta | Categoría | Responsabilidad principal |
|---|---|---|
| Homebrew | System Package Manager | Instalar y administrar software |
| npm | JavaScript Package Manager | Administrar Packages del ecosistema JavaScript |
| pnpm | JavaScript Package Manager | Administrar Packages y dependencias JavaScript |
| nvm | Node.js Version Manager | Instalar y seleccionar versiones de Node.js |

### Ejemplo con Homebrew

```bash
brew install jq
```

Instala una herramienta del sistema.

### Ejemplo con pnpm

```bash
pnpm add zod
```

Agrega una dependencia JavaScript al proyecto.

### Ejemplo con nvm

```bash
nvm install 22
```

Instala una versión de Node.js compatible con la especificación indicada, mediante nvm.

### Modelo conceptual

```text
Development Environment
│
├── System Software
│   └── Homebrew
│
├── Runtime Versions
│   └── nvm / Other Version Managers
│
└── JavaScript Project Dependencies
    └── npm / pnpm / Yarn
```

### ¿Pueden solaparse?

Sí.

Por ejemplo, Homebrew también puede instalar Node.js.

Pero eso no significa que sea siempre la estrategia más conveniente para administrar múltiples versiones de Node.js.

Cuando lleguemos a `04-runtime-management`, estudiaremos por qué los gestores de versiones pueden resultar más apropiados para proyectos con requisitos distintos.

**La decisión debe depender de qué estamos administrando y del nivel de control que necesitamos.**

---

## 🏗️ 5. ¿Cómo funciona Homebrew?

Homebrew utiliza definiciones de paquetes para conocer cómo obtener e instalar software.

De manera simplificada:

```text
Developer
    ↓
brew Command
    ↓
Package Definition
    ↓
Dependency Resolution
    ↓
Download
    ↓
Installation
    ↓
Package Management
```

Las definiciones contienen información sobre el software.

Por ejemplo:

- Nombre.
- Versión o mecanismo de distribución.
- Origen.
- Dependencias.
- Instrucciones de instalación.
- Requisitos de plataforma.

Homebrew utiliza diferentes conceptos para organizar este funcionamiento.

Los más importantes son:

```text
Homebrew
│
├── Formula
├── Cask
├── Bottle
├── Tap
├── Prefix
├── Cellar
├── Keg
└── Symlink
```

Los estudiaremos uno por uno.

---

## 🧪 6. Formula

Una **Formula** es una definición que Homebrew utiliza para instalar y administrar un paquete, habitualmente una herramienta de línea de comandos o una biblioteca.

Por ejemplo:

```bash
brew install jq
```

Aquí `jq` es el nombre de una Formula.

Otros ejemplos habituales:

```text
git
wget
jq
```

### ¿Qué puede describir una Formula?

Puede incluir información sobre:

- El software.
- Su origen.
- Sus dependencias.
- Cómo instalarlo.
- Cómo verificarlo.

### Ejemplo conceptual

```text
Formula
    ↓
Package Metadata
    ↓
Installation Instructions
    ↓
Installed Package
```

No necesitamos escribir Formulae en este módulo.

Nuestro objetivo es comprender qué representan.

---

## 🖥️ 7. Cask

Un **Cask** es un mecanismo de Homebrew utilizado principalmente para distribuir e instalar aplicaciones de macOS y determinados paquetes de software.

Por ejemplo:

```bash
brew install --cask visual-studio-code
```

Este comando solicita instalar Visual Studio Code mediante Homebrew Cask.

### Formula vs Cask

| Concepto | Uso habitual |
|---|---|
| Formula | Herramientas CLI y bibliotecas |
| Cask | Aplicaciones macOS y otros paquetes distribuidos mediante instaladores o artefactos |

La diferencia no consiste simplemente en que Formula signifique Terminal y Cask signifique interfaz gráfica.

Son mecanismos de empaquetado diferentes, con usos habituales distintos.

### Ejemplo

```text
Homebrew
│
├── Formula
│   └── jq
│
└── Cask
    └── Visual Studio Code
```

Ambos pueden administrarse mediante comandos de Homebrew.

---

## 🍾 8. Bottle

Una **Bottle** es un paquete binario precompilado utilizado por Homebrew para determinadas Formulae.

### ¿Por qué es importante?

Porque compilar software desde código fuente puede requerir:

- Compiladores.
- Dependencias de construcción.
- Tiempo de procesamiento.
- Recursos del sistema.

Una Bottle permite utilizar un resultado ya compilado cuando existe una versión compatible.

### Instalación desde código fuente

```text
Source Code
    ↓
Compiler
    ↓
Build
    ↓
Installed Software
```

### Instalación utilizando Bottle

```text
Precompiled Package
        ↓
Download
        ↓
Installation
```

La disponibilidad de Bottles depende del paquete, la plataforma y otros requisitos.

### Relación con Apple Silicon e Intel

Una Bottle debe ser compatible con el entorno donde se utilizará.

Por ejemplo, pueden existir artefactos diferentes para arquitecturas o versiones de macOS.

**Una Bottle no es un Package Manager distinto: es un formato de distribución utilizado por Homebrew.**

---

## 🗃️ 9. Tap

Un **Tap** es un repositorio de definiciones de paquetes que Homebrew puede utilizar.

Conceptualmente:

```text
Homebrew
    ↓
Tap
    ↓
Package Definitions
```

Homebrew dispone de fuentes oficiales y también admite Taps adicionales.

Por ejemplo, un proyecto puede distribuir sus propias Formulae mediante un Tap.

### ¿Necesitamos agregar Taps manualmente?

No siempre.

Muchas herramientas habituales pueden instalarse sin configurar Taps adicionales.

### Precaución

Agregar un Tap de terceros significa confiar en una fuente adicional de definiciones de instalación.

Antes de hacerlo debemos verificar:

- Quién lo mantiene.
- Si es necesario.
- Si está actualizado.
- Si es una fuente confiable.

No debemos agregar repositorios desconocidos solamente porque una guía de Internet lo recomienda.

---

## 📁 10. Homebrew Prefix

El **Prefix** es el directorio base utilizado por una instalación de Homebrew.

En macOS, las ubicaciones predeterminadas habituales son:

| Arquitectura | Prefix habitual |
|---|---|
| Apple Silicon | `/opt/homebrew` |
| Intel | `/usr/local` |

Estas rutas corresponden a instalaciones habituales de Homebrew.

No debemos asumir que todas las instalaciones personalizadas utilizan exactamente el mismo directorio.

### Ejemplo en Apple Silicon

```text
/opt/homebrew/
```

### Ejemplo en Intel

```text
/usr/local/
```

### ¿Cómo comprobar nuestro Prefix?

Si Homebrew está instalado:

```bash
brew --prefix
```

Podríamos obtener:

```text
/opt/homebrew
```

### ¿Por qué importa?

Porque el Prefix influye en dónde Homebrew administra paquetes, ejecutables y otros recursos.

También se relaciona con la configuración de `PATH`.

---

## 🧱 11. Cellar, Keg y Symlink

Estos conceptos explican parte de la organización interna de Homebrew.

### Cellar

El **Cellar** es el directorio donde Homebrew almacena instalaciones de Formulae.

En una instalación habitual de Apple Silicon:

```text
/opt/homebrew/Cellar/
```

### Keg

Un **Keg** representa una instalación de una Formula dentro del Cellar.

Por ejemplo:

```text
/opt/homebrew/Cellar/jq/<version>/
```

La ruta es ilustrativa.

### Symlink

Un **Symbolic Link** es una referencia del sistema de archivos que apunta a otra ubicación.

Homebrew puede utilizar Symlinks para exponer determinados archivos o ejecutables desde su Prefix.

### Ejemplo conceptual

```text
/opt/homebrew/
│
├── Cellar/
│   └── jq/
│       └── <version>/
│           └── bin/
│               └── jq
│
└── bin/
    └── jq → ../Cellar/jq/<version>/bin/jq
```

La organización real puede variar según el paquete y las decisiones de Homebrew.

### ¿Por qué importa?

Porque permite comprender cómo Homebrew administra instalaciones y expone comandos.

No necesitamos modificar manualmente el Cellar.

**Homebrew debe administrar los archivos que instala.**

---

## 🔗 12. Homebrew y PATH

Imagina que Homebrew instala una herramienta.

Para ejecutarla escribimos:

```bash
jq --version
```

Nuestro Shell necesita localizar el ejecutable.

Aquí interviene `PATH`.

Conceptualmente:

```text
Homebrew Installation
        ↓
Executable Available
        ↓
PATH / Command Resolution
        ↓
Command Execution
```

### Ejemplo

En Apple Silicon, un ejecutable puede estar disponible mediante:

```text
/opt/homebrew/bin/jq
```

Si el Shell puede localizarlo, podremos escribir:

```bash
jq --version
```

sin utilizar la ruta completa.

### Consultar PATH

```bash
echo "$PATH"
```

### Consultar cómo se resuelve un comando

```bash
command -v jq
```

### Consultar el entorno de Homebrew

```bash
brew shellenv
```

Este comando imprime instrucciones de configuración del entorno para Homebrew.

**Importante:** mostrar esas instrucciones no significa aplicarlas automáticamente.

La integración correcta con el Shell dependerá de cómo esté instalado y configurado Homebrew.

Estudiaremos este tema con más profundidad en `04-macos-path-configuration.md`.

---

## 📥 13. Instalar Homebrew

Antes de instalarlo, debemos comprobar si ya está disponible.

### Step 1 — Verify Existing Installation

```bash
brew --version
```

Si funciona, Homebrew ya está accesible desde esa sesión.

También podemos consultar:

```bash
command -v brew
```

Si no aparece, no debemos concluir inmediatamente que Homebrew no existe en ninguna ubicación.

Podría estar instalado sin estar configurado correctamente en `PATH`.

### Step 2 — Check Official Requirements

Antes de instalar, debemos revisar los requisitos oficiales de Homebrew:

https://docs.brew.sh/Installation

Estos requisitos pueden cambiar con el tiempo.

También debemos considerar la versión de macOS, la arquitectura y la disponibilidad de herramientas de desarrollo.

### Step 3 — Official Installation

Homebrew publica su procedimiento oficial de instalación en:

https://brew.sh/

El comando de instalación mostrado oficialmente utiliza un Script descargado desde el proyecto Homebrew.

Un ejemplo del comando publicado es:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Advertencia importante

Este comando descarga y ejecuta un Script.

Antes de utilizarlo:

1. Verifica que estás consultando el sitio oficial.
2. Comprueba los requisitos.
3. Revisa el procedimiento de instalación.
4. Comprende qué cambios realizará.
5. Sigue las instrucciones mostradas por el instalador.

No debemos ejecutar Scripts remotos sin comprobar su procedencia.

### Step 4 — Follow Installation Instructions

El instalador puede mostrar instrucciones adicionales para integrar Homebrew con nuestro Shell.

No debemos copiar configuraciones de otras computadoras sin comprobar nuestro Prefix y entorno.

### Step 5 — Verify Installation

Después de completar la instalación:

```bash
brew --version
```

También:

```bash
brew --prefix
```

Y:

```bash
brew doctor
```

`brew doctor` realiza comprobaciones de diagnóstico y puede mostrar advertencias.

Una advertencia no siempre significa que Homebrew sea inutilizable. Debemos interpretar el mensaje según nuestro entorno.

---

## 🔎 14. Buscar e inspeccionar paquetes

Homebrew proporciona comandos para explorar software disponible.

### Buscar un paquete

```bash
brew search jq
```

### Consultar información

```bash
brew info jq
```

Esto permite investigar:

- Descripción.
- Versión.
- Dependencias.
- Información de instalación.
- Otros detalles disponibles.

### ¿Por qué es importante inspeccionar primero?

Porque no siempre necesitamos instalar inmediatamente una herramienta.

Podemos comprobar qué es, qué dependencias requiere y si existe una alternativa adecuada.

---

## 📦 15. Instalar paquetes

Podemos instalar una Formula:

```bash
brew install jq
```

O un Cask:

```bash
brew install --cask visual-studio-code
```

Estos comandos **modifican el sistema** instalando software.

No es necesario ejecutarlos para comprender el documento.

### Verificar la instalación de jq

Si decidimos instalarlo:

```bash
jq --version
```

También podemos consultar:

```bash
brew info jq
```

### Principio

**Una instalación no está completa desde el punto de vista operativo hasta que verificamos que la herramienta requerida funciona.**

---

## 📋 16. Consultar paquetes instalados

Homebrew permite consultar el software que administra.

### Listar Formulae

```bash
brew list --formula
```

### Listar Casks

```bash
brew list --cask
```

### Consultar un paquete específico

```bash
brew info jq
```

### ¿Qué no debemos asumir?

Que `brew list` representa todo el software instalado en nuestra computadora.

Homebrew solamente conoce los paquetes que administra.

Podemos tener herramientas instaladas mediante:

- Instaladores oficiales.
- App Store.
- Apple Command Line Tools.
- Gestores de versiones.
- Otros mecanismos.

---

## 🔄 17. brew update vs brew upgrade

Esta distinción es especialmente importante.

### brew update

```bash
brew update
```

Actualiza la información y los componentes correspondientes de Homebrew para conocer las definiciones disponibles más recientes.

No equivale a actualizar automáticamente todos los paquetes instalados.

### brew upgrade

```bash
brew upgrade
```

Actualiza paquetes instalados que Homebrew considera actualizables, según sus reglas.

### Comparación

| Comando | Responsabilidad principal |
|---|---|
| `brew update` | Actualizar Homebrew y su información de paquetes |
| `brew upgrade` | Actualizar paquetes instalados |
| `brew outdated` | Consultar paquetes con actualizaciones disponibles |

### Ejemplo de flujo

```text
brew update
     ↓
Refresh Package Information
     ↓
brew outdated
     ↓
Review Available Updates
     ↓
brew upgrade
```

### Precaución

No debemos ejecutar actualizaciones generales sin considerar su impacto.

Una nueva versión puede introducir cambios que afecten herramientas o proyectos.

En entornos profesionales conviene revisar los requisitos de compatibilidad antes de actualizar componentes críticos.

---

## 🧹 18. Desinstalar y limpiar

### Desinstalar una Formula

```bash
brew uninstall jq
```

### Desinstalar un Cask

```bash
brew uninstall --cask visual-studio-code
```

Estos comandos modifican las instalaciones administradas por Homebrew.

### Cleanup

```bash
brew cleanup
```

Este comando permite eliminar determinados archivos y versiones antiguas que Homebrew considera innecesarios, según sus reglas.

### Importante

No debemos asumir que desinstalar una aplicación elimina automáticamente todos sus datos personales o configuraciones.

Tampoco debemos borrar manualmente directorios internos de Homebrew para intentar limpiar instalaciones.

Primero debemos comprender qué administra la herramienta y qué queremos eliminar.

---

## 🩺 19. brew doctor

Homebrew proporciona un comando de diagnóstico:

```bash
brew doctor
```

Este comando analiza determinadas condiciones del entorno y puede informar problemas o advertencias.

Por ejemplo, podría detectar situaciones relacionadas con:

- Configuración.
- Herramientas de desarrollo.
- Instalaciones.
- Rutas.
- Compatibilidad.

### ¿Debemos corregir todas las advertencias?

No automáticamente.

Algunas advertencias pueden ser relevantes para nuestro trabajo y otras no.

Debemos leer el mensaje, comprender su causa y evaluar si requiere intervención.

### Flujo recomendado

```text
brew doctor
     ↓
Read Diagnostic
     ↓
Identify Affected Component
     ↓
Understand Cause
     ↓
Apply Appropriate Fix
     ↓
Verify Again
```

No debemos modificar configuraciones únicamente para conseguir que desaparezca cualquier advertencia.

---

## 🗂️ 20. Brewfile y Brew Bundle

Cuando necesitamos preparar varias computadoras, puede resultar útil declarar qué software queremos administrar mediante Homebrew.

Para ello existe **Homebrew Bundle**.

Utiliza un archivo conocido como **Brewfile**.

### Ejemplo conceptual

```ruby
brew "git"
brew "jq"

cask "visual-studio-code"
```

Este archivo describe paquetes que queremos gestionar.

### ¿Qué ventaja ofrece?

En lugar de recordar manualmente todas las instalaciones:

```text
Install Git
Install jq
Install VS Code
```

Podemos declarar un conjunto:

```text
Brewfile
    ↓
Homebrew Bundle
    ↓
Required Software
```

### Comandos habituales

Para instalar los elementos declarados:

```bash
brew bundle install
```

Para comprobar su estado:

```bash
brew bundle check
```

Para generar un inventario basado en instalaciones existentes:

```bash
brew bundle dump
```

Este último comando puede crear un Brewfile y, según las opciones y el estado del directorio, requerir gestionar un archivo existente.

No lo ejecutaremos todavía.

### ¿Es obligatorio utilizar Brewfile?

No.

Es una herramienta útil cuando necesitamos administrar conjuntos de software de forma más declarativa.

### Relación con reproducibilidad

Un Brewfile puede ayudar a documentar herramientas requeridas.

Sin embargo, por sí solo no garantiza una reproducción exacta de todas las versiones o del estado completo de una computadora.

La reproducibilidad depende también de versiones, fuentes, compatibilidad y otros requisitos.

---

## ⚠️ 21. Evitar instalaciones duplicadas

Imagina que instalamos Git mediante las herramientas de Apple.

Después instalamos otra versión mediante Homebrew.

Podríamos tener:

```text
/usr/bin/git

/opt/homebrew/bin/git
```

Esto no es necesariamente un error.

Pero puede generar confusión si no comprendemos cuál se utiliza.

### Consultar el comando seleccionado

```bash
command -v git
```

### Consultar coincidencias en PATH

En Zsh o Bash podemos utilizar:

```bash
type -a git
```

Esto permite investigar las distintas resoluciones disponibles del comando.

### ¿Por qué importa?

Porque diferentes sesiones pueden resolver ejecutables distintos si su configuración de `PATH` cambia.

```text
Terminal Session A
        ↓
Git Installation A

Terminal Session B
        ↓
Git Installation B
```

### Recomendación

Antes de instalar una herramienta:

1. Comprueba si ya existe.
2. Identifica cómo se instaló.
3. Revisa su versión.
4. Comprueba los requisitos del proyecto.
5. Decide si necesitas otra instalación.

**Instalar más herramientas no significa tener un entorno mejor preparado.**

---

## 🔐 22. Seguridad y confianza

Un Package Manager facilita instalaciones, pero también introduce decisiones de confianza.

Debemos considerar:

### Official Sources

Preferir fuentes oficiales y mantenidas.

### Third-party Taps

Revisar quién mantiene las definiciones externas.

### Installation Scripts

Comprender que algunas instalaciones pueden ejecutar operaciones durante su preparación.

### Updates

Evaluar el impacto de cambios de versión.

### Permissions

Evitar modificar manualmente permisos o ejecutar comandos privilegiados sin comprenderlos.

### Supply Chain

Recordar que instalar software implica confiar en artefactos, definiciones y mecanismos de distribución.

Homebrew facilita la administración, pero no elimina por completo los riesgos asociados a las dependencias de software.

---

## 🏢 23. Homebrew en equipos profesionales

Imagina que un equipo necesita:

```text
Git
jq
wget
```

Podríamos documentar manualmente cómo instalar cada herramienta.

Otra alternativa es utilizar Homebrew cuando el equipo trabaja con macOS y el proyecto lo considera adecuado.

```text
Team Requirements
        ↓
Documented Tools
        ↓
Homebrew
        ↓
Developer Machines
```

Si necesitamos declarar un conjunto de herramientas, podemos evaluar Brewfile.

Pero debemos recordar que:

- Los desarrolladores pueden utilizar diferentes arquitecturas.
- Las versiones de macOS pueden variar.
- Algunas herramientas pueden necesitar mecanismos distintos.
- El proyecto puede requerir versiones específicas.
- No todo el software debe instalarse mediante Homebrew.

### ¿Deberíamos instalar Node.js mediante Homebrew?

Es posible, pero no necesariamente es la mejor decisión para todos los equipos.

Si trabajamos con proyectos que requieren diferentes versiones de Node.js, un gestor de versiones puede ofrecer un flujo más adecuado.

Estudiaremos esta decisión en `04-runtime-management`.

---

## 🧪 24. Práctica: Homebrew Environment Audit

Esta práctica está diseñada para comprender el estado de nuestra computadora.

**No instalaremos ni desinstalaremos software.**

### Step 1 — Check Homebrew

```bash
brew --version
```

Si el comando no está disponible, registra el resultado y omite los pasos que requieren Homebrew.

### Step 2 — Check Command Resolution

```bash
command -v brew
```

### Step 3 — Check Prefix

```bash
brew --prefix
```

### Step 4 — Inspect Installed Formulae

```bash
brew list --formula
```

### Step 5 — Inspect Installed Casks

```bash
brew list --cask
```

### Step 6 — Inspect a Package

```bash
brew info jq
```

Este comando puede consultar información de `jq` aunque no lo tengamos instalado.

### Step 7 — Check Outdated Packages

```bash
brew outdated
```

Este comando consulta paquetes que Homebrew considera desactualizados.

No realiza una actualización general de los paquetes.

### Step 8 — Inspect PATH

```bash
echo "$PATH"
```

### Step 9 — Inspect Git Resolution

```bash
type -a git
```

### Step 10 — Document Results

| Component | Result |
|---|---|
| Homebrew Available | |
| Homebrew Version | |
| Homebrew Prefix | |
| Installed Formulae | |
| Installed Casks | |
| Outdated Packages | |
| Git Command Resolution | |
| Homebrew in PATH | |

### Reflexión

Responde:

1. ¿Homebrew está instalado?
2. ¿Qué Prefix utiliza?
3. ¿Qué herramientas administra?
4. ¿Existen aplicaciones instaladas fuera de Homebrew?
5. ¿Git proviene de Homebrew o de otro mecanismo?
6. ¿Hay actualizaciones disponibles?
7. ¿Necesitamos modificar algo?

El objetivo no es conseguir una instalación perfecta.

Es comprender el estado real del entorno.

---

## 🛠️ 25. Troubleshooting: problemas frecuentes

### Problema A — brew: command not found

Ejecutamos:

```bash
brew --version
```

Y recibimos un error indicando que el comando no existe.

Posibles causas:

- Homebrew no está instalado.
- Homebrew está instalado, pero no está disponible mediante `PATH`.
- Estamos utilizando una sesión con una configuración diferente.

### Diagnóstico inicial

```bash
command -v brew
```

Podemos revisar si existe una instalación en el Prefix habitual correspondiente a nuestra arquitectura.

No debemos modificar `PATH` sin confirmar primero la ubicación real.

---

### Problema B — Different Homebrew Prefix

Esperábamos:

```text
/opt/homebrew
```

Pero encontramos otra ubicación.

Esto puede deberse a:

- Arquitectura.
- Instalación personalizada.
- Entorno de ejecución.
- Configuración heredada.

### Diagnóstico

```bash
brew --prefix
```

Y:

```bash
uname -m
```

Recordemos que `uname -m` puede reflejar una sesión bajo Rosetta en Apple Silicon.

No debemos cambiar el Prefix manualmente sin comprender cómo se instaló Homebrew.

---

### Problema C — Multiple Versions of a Tool

Ejecutamos:

```bash
git --version
```

Y encontramos una versión diferente de la esperada.

### Diagnóstico

```bash
type -a git
```

También:

```bash
command -v git
```

Debemos comprobar qué instalación está utilizando el Shell.

---

### Problema D — Installation Requires Developer Tools

Una instalación necesita compiladores o recursos de desarrollo.

Podemos revisar:

```bash
xcode-select -p
```

Y:

```bash
clang --version
```

Si faltan herramientas, debemos revisar los requisitos del paquete y el estado de las Apple Command Line Tools.

No debemos asumir que todos los errores de instalación se solucionan reinstalando Homebrew.

---

### Problema E — brew doctor Shows Warnings

Ejecutamos:

```bash
brew doctor
```

Y aparecen advertencias.

Debemos:

1. Leer cada advertencia.
2. Identificar el componente afectado.
3. Revisar si el problema afecta nuestras herramientas.
4. Consultar la documentación correspondiente.
5. Aplicar cambios únicamente cuando sean necesarios.

No todas las advertencias requieren una intervención inmediata.

---

## ⚠️ 26. Errores comunes

### 1. Confundir Homebrew con npm o pnpm

Administran software en ecosistemas y ámbitos diferentes.

### 2. Pensar que Homebrew es obligatorio

macOS admite otros mecanismos de instalación.

### 3. Instalar todo mediante Homebrew

Algunas herramientas pueden gestionarse mejor mediante instaladores oficiales o gestores especializados.

### 4. Confundir Formula con Cask

Son mecanismos de empaquetado distintos.

### 5. Confundir Bottle con Formula

Una Bottle es un artefacto precompilado utilizado para distribuir determinadas Formulae.

### 6. Modificar manualmente Cellar

Homebrew debe administrar sus propias instalaciones.

### 7. Confundir `brew update` con `brew upgrade`

Uno actualiza información y componentes de Homebrew; el otro actualiza paquetes instalados.

### 8. Ejecutar actualizaciones generales sin evaluar compatibilidad

Podemos introducir cambios que afecten proyectos existentes.

### 9. Ignorar PATH

Podemos tener una herramienta instalada y ejecutar otra versión.

### 10. Pensar que Brewfile garantiza reproducibilidad absoluta

Ayuda a declarar herramientas, pero no controla automáticamente todos los factores del entorno.

### 11. Agregar Taps desconocidos

Debemos evaluar la procedencia y mantenimiento de las fuentes.

### 12. Utilizar privilegios elevados innecesariamente

No debemos ejecutar comandos con `sudo` por costumbre.

---

## 🧠 27. Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es Homebrew?
2. ¿Qué problema resuelve?
3. ¿Qué es un Package Manager?
4. ¿Qué diferencia existe entre Homebrew y pnpm?
5. ¿Qué diferencia existe entre Homebrew y nvm?
6. ¿Qué es una Formula?
7. ¿Qué es un Cask?
8. ¿Qué es una Bottle?
9. ¿Qué es un Tap?
10. ¿Qué significa Prefix?
11. ¿Qué es Cellar?
12. ¿Qué es un Keg?
13. ¿Qué es un Symlink?
14. ¿Cómo se relaciona Homebrew con `PATH`?
15. ¿Qué diferencia existe entre `brew update` y `brew upgrade`?
16. ¿Para qué sirve `brew doctor`?
17. ¿Qué es un Brewfile?
18. ¿Qué aporta Homebrew Bundle?
19. ¿Por qué pueden existir varias instalaciones de Git?
20. ¿Por qué no siempre conviene instalar Node.js mediante Homebrew?
21. ¿Qué relación existe entre Homebrew y las Command Line Tools?
22. ¿Qué precauciones debemos tomar con Taps de terceros?
23. ¿Por qué debemos inspeccionar una herramienta antes de instalarla?
24. ¿Cómo ayuda Homebrew a preparar entornos profesionales?
25. ¿Qué limitaciones tiene Homebrew respecto a la reproducibilidad?

---

## 💡 Idea clave

Homebrew permite administrar software en macOS mediante un mecanismo común.

```text
macOS
  ↓
Homebrew
  ├── Formulae
  ├── Casks
  ├── Bottles
  ├── Taps
  └── Package Management
        ↓
Installed Development Tools
```

Pero Homebrew no sustituye a los Runtimes, a los gestores de versiones ni a los Package Managers específicos de cada ecosistema.

**La clave es utilizar la herramienta adecuada para cada responsabilidad y mantener un entorno comprensible, verificable y fácil de mantener.**

---

## 🚀 Siguiente paso

Ahora comprendemos qué es Homebrew, cómo organiza sus paquetes y cómo administra instalaciones.

Pero hemos encontrado un concepto que aparece constantemente:

**PATH.**

¿Por qué algunas herramientas funcionan desde la Terminal y otras no?

¿Por qué una Mac puede tener varias versiones de Git y ejecutar solamente una cuando escribimos `git`?

¿Cómo se relacionan Homebrew, Zsh y los archivos de configuración del Shell?

Estas preguntas nos llevan al siguiente documento:

👉 [macOS PATH Configuration](./04-macos-path-configuration.md)