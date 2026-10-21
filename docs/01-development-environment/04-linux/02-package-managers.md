# Linux Package Managers

## Introducción

Cuando comenzamos a utilizar Linux, una de las primeras necesidades que encontramos es instalar herramientas.

Por ejemplo:

- Git.
- Curl.
- Compiladores.
- Bibliotecas del sistema.
- Utilidades de diagnóstico.
- Herramientas de desarrollo.

Podríamos buscar cada aplicación en Internet, descargar archivos e intentar instalarlos manualmente.

Sin embargo, ese procedimiento presenta varios problemas:

- ¿De dónde descargamos el software?
- ¿Cómo verificamos su procedencia?
- ¿Qué dependencias necesita?
- ¿Cómo sabemos si es compatible con nuestra distribución?
- ¿Cómo lo actualizamos?
- ¿Cómo lo desinstalamos?
- ¿Cómo evitamos conflictos entre paquetes?

Para resolver estos problemas, las distribuciones Linux utilizan sistemas de administración de paquetes.

Un **Package Manager** permite instalar, consultar, actualizar y eliminar software utilizando mecanismos definidos por la distribución o por el ecosistema correspondiente.

Pero no todos los gestores de paquetes cumplen exactamente la misma función.

En este documento aprenderemos a distinguir entre los gestores de paquetes del sistema operativo y los gestores de paquetes utilizados dentro de nuestros proyectos de software.

Nuestra metodología será:

**Problema → Concepto → Responsabilidad → Arquitectura → Herramientas → Diagnóstico → Práctica → Buenas prácticas.**

---

## 🎯 Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Explicar qué es un paquete de software.
2. Comprender qué problema resuelve un Package Manager.
3. Diferenciar Package Manager, Package Repository y Package Registry.
4. Comprender qué son los metadatos de paquetes.
5. Explicar cómo se resuelven las dependencias.
6. Diferenciar paquetes del sistema y dependencias del proyecto.
7. Reconocer las principales familias de gestores Linux.
8. Comprender la relación entre APT y dpkg.
9. Comprender la relación entre DNF y RPM.
10. Identificar las responsabilidades de pacman, Zypper y apk.
11. Diferenciar actualizar índices de actualizar paquetes instalados.
12. Consultar herramientas y paquetes sin modificar el sistema.
13. Reconocer riesgos de repositorios externos.
14. Comprender los problemas de versiones y compatibilidad.
15. Aplicar una estrategia profesional de administración de herramientas.

---

# 1. El problema: instalar software manualmente no escala

Imagina que necesitamos utilizar Git en una computadora Linux.

Podríamos intentar descargar un archivo ejecutable desde alguna página de Internet.

Pero pronto aparecerían preguntas importantes.

¿Ese ejecutable es compatible con nuestra arquitectura?

¿Necesita bibliotecas adicionales?

¿Está firmado?

¿Quién mantiene las actualizaciones?

¿Dónde se instalarán sus archivos?

¿Cómo lo eliminaremos correctamente?

Ahora imagina que necesitamos instalar veinte herramientas.

```text
Development Machine
│
├── Git
├── Curl
├── Compiler
├── Build Tools
├── SSL Libraries
├── Database Client
├── Network Utilities
└── Other Dependencies
```

Administrar manualmente cada componente sería difícil y propenso a errores.

Necesitamos un mecanismo que centralice estas responsabilidades.

## 1.1 La solución conceptual

```text
Developer
    │
    ▼
Package Manager
    │
    ├── Discover Packages
    ├── Resolve Dependencies
    ├── Download Packages
    ├── Verify Packages
    ├── Install Software
    ├── Update Software
    └── Remove Software
```

El gestor de paquetes coordina estas operaciones utilizando las capacidades de su ecosistema.

### Idea clave

**Un Package Manager no es simplemente una herramienta para descargar software. Es un mecanismo para administrar su ciclo de vida.**

---

# 2. ¿Qué es un Package?

Un **Package** es una unidad de distribución de software que puede contener programas, bibliotecas, metadatos y otros archivos necesarios para su instalación o funcionamiento.

Dependiendo del formato, también puede incluir información sobre:

- Nombre.
- Versión.
- Arquitectura.
- Dependencias.
- Descripción.
- Mantenedor.
- Archivos proporcionados.
- Scripts asociados a determinadas operaciones.

## 2.1 Ejemplo conceptual

Imaginemos un paquete llamado:

```text
git
```

Su representación conceptual podría ser:

```text
Git Package
│
├── Package Metadata
│   ├── Name
│   ├── Version
│   ├── Architecture
│   └── Dependencies
│
├── Executable Files
│
├── Supporting Files
│
└── Documentation
```

Este diagrama no representa necesariamente la estructura interna exacta de un paquete real.

Sirve para comprender qué información puede administrar el sistema.

## 2.2 ¿Un paquete es siempre un ejecutable?

No.

Un paquete también puede proporcionar:

- Bibliotecas.
- Archivos de configuración.
- Documentación.
- Datos.
- Herramientas auxiliares.

Por ejemplo, una biblioteca compartida puede ser necesaria para ejecutar otras aplicaciones, aunque el desarrollador nunca la invoque directamente desde la Terminal.

---

# 3. ¿Qué es un Package Manager?

Un **Package Manager** es una herramienta o conjunto de herramientas que administra paquetes de software.

Sus responsabilidades pueden incluir:

| Responsabilidad | Descripción |
|---|---|
| Discovery | Buscar paquetes disponibles |
| Metadata | Consultar información de paquetes |
| Dependency Resolution | Determinar dependencias necesarias |
| Installation | Instalar paquetes |
| Update | Obtener versiones actualizadas |
| Removal | Desinstalar paquetes |
| Verification | Comprobar información de integridad o procedencia |
| State Tracking | Registrar paquetes instalados |

No todos los gestores implementan estas capacidades de la misma manera.

## 3.1 Ejemplo conceptual

```text
Developer
    │
    │ Install Git
    ▼
Package Manager
    │
    ├── Read Package Metadata
    │
    ├── Resolve Dependencies
    │
    ├── Select Compatible Packages
    │
    ├── Download Required Files
    │
    └── Perform Installation
              │
              ▼
         Git Available
```

## 3.2 ¿Qué ventaja ofrece?

El sistema conoce qué paquetes administra y puede utilizar esa información para futuras operaciones.

Por ejemplo:

- Actualizaciones.
- Consultas.
- Eliminaciones.
- Resolución de dependencias.

### Principio

**El gestor de paquetes establece un mecanismo coherente para administrar software dentro de su ámbito de responsabilidad.**

---

# 4. Package Manager vs Package Repository vs Package Registry

Estos términos están relacionados, pero no son idénticos.

## 4.1 Package Manager

Es la herramienta que utilizamos para administrar paquetes.

Ejemplos:

```text
APT
DNF
pacman
npm
pnpm
```

## 4.2 Package Repository

Es una fuente organizada de paquetes y metadatos.

En Linux, las distribuciones suelen proporcionar repositorios desde los cuales sus gestores obtienen software.

## 4.3 Package Registry

Es un servicio utilizado para publicar, almacenar, descubrir y distribuir paquetes, especialmente habitual en ecosistemas de lenguajes y herramientas de desarrollo.

Por ejemplo, el Registry público de npm.

## 4.4 ¿Repository y Registry son sinónimos?

En algunas conversaciones se utilizan de forma parecida.

Sin embargo, es útil diferenciarlos por su contexto.

- En distribuciones Linux hablamos frecuentemente de repositorios de paquetes.
- En ecosistemas como JavaScript hablamos frecuentemente de registries.

Ambos pueden participar en la distribución de paquetes, pero sus interfaces, formatos y mecanismos son diferentes.

## 4.5 Modelo conceptual

```text
Linux Ecosystem

Developer
    │
    ▼
APT
    │
    ▼
Linux Package Repository
    │
    ▼
System Packages
```

```text
JavaScript Ecosystem

Developer
    │
    ▼
pnpm
    │
    ▼
npm-compatible Registry
    │
    ▼
JavaScript Packages
```

### Idea importante

El concepto general de administración de paquetes se reutiliza en distintos ecosistemas.

Lo que cambia es el tipo de software administrado y el conjunto de reglas utilizadas.

---

# 5. ¿Qué es un Package Repository?

Un repositorio de paquetes es una fuente que proporciona paquetes y la información necesaria para que las herramientas correspondientes puedan encontrarlos y administrarlos.

## 5.1 ¿Qué puede contener?

Conceptualmente:

```text
Package Repository
│
├── Package A
├── Package B
├── Package C
│
└── Repository Metadata
    ├── Versions
    ├── Dependencies
    ├── Architectures
    └── Other Information
```

## 5.2 ¿Quién administra los repositorios?

Depende del ecosistema.

Pueden ser administrados por:

- Distribuciones Linux.
- Organizaciones.
- Proveedores de software.
- Equipos internos.

## 5.3 Repositorios oficiales

Una distribución suele configurar repositorios mantenidos o reconocidos por su propio proyecto.

Estos repositorios constituyen una fuente habitual para instalar software compatible con esa distribución.

## 5.4 Repositorios externos

También pueden existir fuentes proporcionadas por terceros.

Por ejemplo, un proveedor puede distribuir una aplicación mediante su propio repositorio.

### ¿Son siempre peligrosos?

No necesariamente.

Pero incorporarlos significa establecer una relación de confianza adicional.

Debemos evaluar:

- Procedencia.
- Mantenimiento.
- Autenticidad.
- Compatibilidad.
- Alcance de los paquetes.
- Políticas de actualización.

### Principio

**Añadir un repositorio no es solamente configurar una URL: es incorporar una nueva fuente de software y confianza al sistema.**

---

# 6. Package Metadata

Los gestores de paquetes necesitan información para decidir qué instalar.

Esta información se conoce como **Metadata**.

## 6.1 Ejemplo conceptual

```text
Package:
    name: example-tool
    version: 2.4.0
    architecture: amd64
    dependencies:
        - library-a
        - library-b
```

Este ejemplo es ilustrativo y no corresponde a un formato concreto de metadatos.

## 6.2 ¿Para qué sirven los metadatos?

Permiten responder preguntas como:

- ¿Qué versión está disponible?
- ¿Es compatible con la arquitectura?
- ¿Qué otros paquetes necesita?
- ¿Existe una actualización?
- ¿Qué paquete proporciona determinado archivo?

## 6.3 ¿Qué sucede si los metadatos están desactualizados?

El gestor puede no conocer versiones o cambios recientes disponibles en los repositorios configurados.

Por eso muchos sistemas distinguen entre:

1. Actualizar información de repositorios.
2. Actualizar paquetes instalados.

Estudiaremos esa diferencia más adelante.

---

# 7. Dependency Resolution

Uno de los problemas más importantes que resuelve un gestor de paquetes es la administración de dependencias.

## 7.1 ¿Qué es una dependencia?

Es un componente que otro paquete necesita para funcionar o para realizar determinadas operaciones.

Imaginemos:

```text
Application A
     │
     ├── Library B
     │
     └── Library C
              │
              └── Library D
```

Para instalar `Application A`, podríamos necesitar varios paquetes adicionales.

## 7.2 Dependencias directas

Son aquellas declaradas directamente por un paquete.

En el ejemplo:

```text
Application A → Library B
Application A → Library C
```

## 7.3 Dependencias transitivas

Son dependencias requeridas por otras dependencias.

En el ejemplo:

```text
Application A
    ↓
Library C
    ↓
Library D
```

`Library D` es una dependencia transitiva de `Application A`.

## 7.4 ¿Qué debe resolver el gestor?

Debe considerar aspectos como:

- Paquetes necesarios.
- Versiones compatibles.
- Restricciones.
- Arquitectura.
- Conflictos.
- Paquetes ya instalados.

## 7.5 ¿Siempre existe una solución?

No.

Pueden existir restricciones incompatibles o paquetes no disponibles.

### Idea clave

**Instalar un paquete no siempre equivale a copiar un archivo: puede requerir resolver un conjunto de relaciones entre componentes.**

---

# 8. Principales gestores de paquetes Linux

Las distribuciones utilizan diferentes ecosistemas de administración de paquetes.

| Distribución o familia | Gestor de alto nivel habitual | Formato o herramienta de bajo nivel |
|---|---|---|
| Debian / Ubuntu | APT | dpkg / `.deb` |
| Fedora / RHEL | DNF | RPM / `.rpm` |
| Arch Linux | pacman | Formato de paquetes de Arch |
| openSUSE | Zypper | RPM / `.rpm` |
| Alpine Linux | apk | Formato de paquetes Alpine |

La tabla representa asociaciones habituales.

Debemos consultar la documentación de la distribución concreta, ya que las herramientas y versiones pueden variar.

## 8.1 ¿Por qué existen diferentes gestores?

Porque las distribuciones pueden adoptar diferentes decisiones sobre:

- Formatos.
- Repositorios.
- Políticas de actualización.
- Dependencias.
- Compatibilidad.
- Administración del sistema.

## 8.2 ¿Debemos aprender todos?

No es necesario dominarlos simultáneamente.

Lo importante es comprender los conceptos compartidos y profundizar en el gestor de nuestra distribución.

---

# 9. APT y dpkg

APT es uno de los gestores más conocidos del ecosistema Debian.

Lo encontramos habitualmente en distribuciones como Debian y Ubuntu.

## 9.1 ¿Qué significa APT?

**Advanced Package Tool.**

## 9.2 ¿Qué hace APT?

Permite realizar operaciones de alto nivel sobre paquetes, utilizando los repositorios y la información configurada en el sistema.

Por ejemplo:

- Buscar paquetes.
- Consultar información.
- Resolver dependencias.
- Instalar.
- Actualizar.
- Eliminar.

## 9.3 ¿Qué es dpkg?

`dpkg` es una herramienta de nivel inferior utilizada para administrar paquetes Debian.

Trabaja con el formato `.deb` y la base de datos local de paquetes.

## 9.4 Relación conceptual

```text
Developer
    │
    ▼
APT
    │
    ├── Repository Metadata
    ├── Dependency Resolution
    └── Package Selection
              │
              ▼
             dpkg
              │
              ▼
      Local Package System
```

APT utiliza mecanismos de nivel inferior, entre ellos dpkg, para realizar operaciones de instalación y administración.

## 9.5 ¿APT y dpkg son intercambiables?

No completamente.

Por ejemplo, instalar un archivo `.deb` directamente mediante dpkg no proporciona necesariamente el mismo flujo de resolución de dependencias que una operación de alto nivel mediante APT.

### Principio

**APT coordina operaciones de paquetes a un nivel más alto; dpkg administra paquetes Debian a un nivel más directo.**

---

# 10. Comandos fundamentales de APT

Antes de utilizarlos debemos comprender cuáles consultan información y cuáles modifican el sistema.

## 10.1 Buscar paquetes

```bash
apt search git
```

Busca coincidencias entre la información de paquetes disponible localmente.

No instala software.

## 10.2 Consultar información

```bash
apt show git
```

Muestra metadatos disponibles del paquete.

## 10.3 Consultar paquetes instalados

```bash
apt list --installed
```

La salida puede ser extensa.

## 10.4 Consultar un paquete concreto

```bash
dpkg -s git
```

Consulta información local del paquete si está registrado en dpkg.

## 10.5 Actualizar índices

```bash
sudo apt update
```

Actualiza la información de paquetes procedente de los repositorios configurados.

**Este comando puede modificar las listas locales de paquetes. No forma parte de nuestra práctica de inspección.**

## 10.6 Actualizar paquetes instalados

```bash
sudo apt upgrade
```

Solicita la actualización de paquetes instalados conforme a las reglas de APT y las restricciones aplicables.

No equivale a actualizar únicamente los índices.

## 10.7 Instalar un paquete

```bash
sudo apt install git
```

Instala Git y las dependencias necesarias según la resolución realizada.

## 10.8 Eliminar un paquete

```bash
sudo apt remove git
```

Solicita la eliminación del paquete.

## 10.9 Eliminar también determinados archivos de configuración

```bash
sudo apt purge git
```

La operación `purge` tiene un alcance diferente de `remove` respecto a los archivos de configuración administrados por el sistema de paquetes.

No garantiza eliminar cualquier archivo personal o dato generado fuera de ese ámbito.

### Advertencia

Los comandos anteriores se presentan para comprender sus responsabilidades.

**No debemos ejecutar operaciones de instalación, actualización o eliminación sin revisar primero su impacto.**

---

# 11. DNF y RPM

DNF es un gestor de paquetes utilizado en distribuciones del ecosistema Fedora y Red Hat.

## 11.1 ¿Qué es DNF?

Es una herramienta de administración de paquetes de alto nivel.

Permite:

- Consultar repositorios.
- Buscar paquetes.
- Resolver dependencias.
- Instalar software.
- Actualizar paquetes.
- Eliminar paquetes.

## 11.2 ¿Qué es RPM?

RPM es un sistema y formato de administración de paquetes utilizado por diversas distribuciones.

## 11.3 Relación conceptual

```text
Developer
    │
    ▼
DNF
    │
    ├── Repositories
    ├── Metadata
    └── Dependency Resolution
              │
              ▼
       RPM Package System
              │
              ▼
       Installed Packages
```

## 11.4 Comandos de consulta

Buscar:

```bash
dnf search git
```

Consultar:

```bash
dnf info git
```

Consultar paquetes instalados:

```bash
dnf list installed
```

Consultar mediante RPM:

```bash
rpm -q git
```

## 11.5 Comandos que modifican el sistema

Instalar:

```bash
sudo dnf install git
```

Actualizar paquetes:

```bash
sudo dnf upgrade
```

Eliminar:

```bash
sudo dnf remove git
```

### Importante

Las versiones y características de DNF pueden variar según la distribución.

Siempre debemos utilizar la documentación correspondiente al sistema concreto.

---

# 12. pacman

`pacman` es el gestor de paquetes de Arch Linux.

A diferencia de la relación APT/dpkg, pacman integra las operaciones habituales de administración de paquetes dentro de su propia interfaz.

## 12.1 Responsabilidades

Permite:

- Consultar paquetes.
- Sincronizar información.
- Instalar paquetes.
- Actualizar el sistema.
- Eliminar paquetes.

## 12.2 Consultar paquetes instalados

```bash
pacman -Q
```

## 12.3 Consultar un paquete

```bash
pacman -Qi git
```

Este comando consulta información local de un paquete instalado.

## 12.4 Buscar en repositorios

```bash
pacman -Ss git
```

## 12.5 Actualización del sistema

En Arch Linux encontramos habitualmente:

```bash
sudo pacman -Syu
```

Este comando sincroniza información de repositorios y actualiza paquetes conforme a las reglas de pacman.

### Advertencia importante

Arch Linux sigue un modelo Rolling Release.

Las actualizaciones parciales del sistema no son una práctica recomendada en su modelo habitual de mantenimiento.

No debemos copiar estrategias de actualización de Debian o Ubuntu sin comprender las reglas de Arch.

---

# 13. Zypper

Zypper es un gestor de paquetes utilizado en openSUSE y sistemas relacionados.

## 13.1 Consultar paquetes

```bash
zypper search git
```

## 13.2 Consultar información

```bash
zypper info git
```

## 13.3 Instalar

```bash
sudo zypper install git
```

## 13.4 Actualizar

```bash
sudo zypper update
```

La operación adecuada para actualizar una distribución completa puede depender del producto, edición y modelo de mantenimiento.

### Principio

No todos los comandos denominados `update` realizan exactamente la misma operación en todos los gestores.

---

# 14. apk

Alpine Linux utiliza `apk` como gestor de paquetes.

Alpine es especialmente conocido en determinados entornos ligeros y de contenedores.

## 14.1 Buscar paquetes

```sh
apk search git
```

## 14.2 Consultar paquetes instalados

```sh
apk info
```

## 14.3 Instalar

```sh
apk add git
```

## 14.4 Actualizar índices

```sh
apk update
```

## 14.5 Actualizar paquetes

```sh
apk upgrade
```

### ¿Por qué Alpine es relevante?

Porque algunas imágenes de contenedores utilizan Alpine como distribución base.

Sin embargo, Alpine puede presentar diferencias importantes respecto a otras distribuciones, como el uso habitual de musl en lugar de glibc.

Esto puede afectar determinadas dependencias nativas.

**Una imagen más pequeña no es automáticamente la mejor opción para todos los proyectos.**

---

# 15. Comparación de comandos

Esta tabla sirve como referencia conceptual.

No implica que todas las operaciones tengan exactamente la misma semántica.

| Objetivo | APT | DNF | pacman | apk |
|---|---|---|---|---|
| Buscar paquete | `apt search` | `dnf search` | `pacman -Ss` | `apk search` |
| Consultar paquete | `apt show` | `dnf info` | `pacman -Si` | `apk info` |
| Instalar | `apt install` | `dnf install` | `pacman -S` | `apk add` |
| Eliminar | `apt remove` | `dnf remove` | `pacman -R` | `apk del` |
| Actualizar índices | `apt update` | Gestión propia de metadatos | `pacman -Sy`* | `apk update` |
| Actualizar paquetes | `apt upgrade` | `dnf upgrade` | `pacman -Syu` | `apk upgrade` |

\* En Arch Linux, `pacman -Sy` por sí solo puede dejar las bases de datos de repositorios sincronizadas sin actualizar los paquetes instalados. Debemos evitar utilizarlo como paso aislado antes de instalaciones que provoquen actualizaciones parciales.

### Aprendizaje

Memorizar equivalencias no es suficiente.

Debemos comprender la política de mantenimiento de cada distribución.

---

# 16. Actualizar índices vs actualizar software

Esta diferencia es especialmente importante.

Imagina que el sistema conoce estas versiones:

```text
Local Package Metadata

Git 2.x
Curl 8.x
Tool A 1.x
```

Mientras tanto, los repositorios pueden publicar nuevas versiones.

## 16.1 Actualizar índices

El gestor obtiene información más reciente de los repositorios.

```text
Package Repositories
        │
        ▼
Refresh Metadata
        │
        ▼
Local Package Index
```

Esto no implica necesariamente actualizar los programas instalados.

## 16.2 Actualizar paquetes

El gestor evalúa las versiones instaladas y solicita las operaciones necesarias para actualizarlas.

```text
Installed Packages
        │
        ▼
Compare Available Versions
        │
        ▼
Resolve Dependencies
        │
        ▼
Upgrade Packages
```

## 16.3 Ejemplo en APT

```bash
sudo apt update
```

Actualiza índices.

```bash
sudo apt upgrade
```

Actualiza paquetes según las reglas aplicables.

## 16.4 ¿Por qué importa?

Porque un desarrollador podría ejecutar `apt update` y asumir que su sistema ya tiene todas las aplicaciones actualizadas.

Eso sería incorrecto.

### Idea clave

**Actualizar el catálogo de paquetes y actualizar el software instalado son responsabilidades diferentes.**

---

# 17. Versiones y compatibilidad

Una distribución no necesariamente ofrece la versión más reciente de todas las herramientas.

## 17.1 ¿Por qué?

Porque las distribuciones toman decisiones relacionadas con:

- Estabilidad.
- Seguridad.
- Compatibilidad.
- Mantenimiento.
- Soporte.
- Integración.

## 17.2 Ejemplo conceptual

```text
Upstream Project
    │
    └── Version 5.0
```

```text
Distribution Repository
    │
    └── Version 4.2 + Security Fixes
```

Una distribución puede mantener una versión anterior e incorporar correcciones relevantes.

Por ello, una numeración menor no demuestra automáticamente que el paquete sea inseguro o esté abandonado.

## 17.3 ¿Qué ocurre con Node.js?

Podríamos necesitar una versión concreta de Node.js para un proyecto.

Por ejemplo:

```text
Project A → Node.js 20
Project B → Node.js 22
```

En este escenario, instalar una única versión mediante el gestor de paquetes del sistema puede no resolver nuestras necesidades.

## 17.4 ¿Cuál es la alternativa?

Utilizar una estrategia apropiada de administración de versiones de Runtime.

La estudiaremos en:

`docs/04-runtime-management/`

### Principio

**La versión de una herramienta debe seleccionarse según su responsabilidad y los requisitos del proyecto, no solamente por ser la más reciente.**

---

# 18. System Package Manager vs Runtime Version Manager

Esta distinción es fundamental.

## 18.1 System Package Manager

Administra software del sistema.

Ejemplos:

```text
APT
DNF
pacman
```

## 18.2 Runtime Version Manager

Permite administrar diferentes versiones de determinados Runtimes o herramientas.

Ejemplos en el ecosistema de desarrollo:

```text
nvm
mise
```

## 18.3 Modelo conceptual

```text
Linux Machine
│
├── System Package Manager
│   │
│   ├── Git
│   ├── Curl
│   └── System Libraries
│
└── Runtime Version Manager
    │
    ├── Node.js 20
    └── Node.js 22
```

Este modelo es ilustrativo; la instalación real depende de las herramientas y la estrategia elegida.

## 18.4 ¿Son excluyentes?

No necesariamente.

Podemos utilizar un gestor de paquetes del sistema para ciertas herramientas y un gestor de versiones para otras.

### Buena práctica

Evitar administrar el mismo Runtime mediante varias estrategias sin comprender cuál tiene prioridad.

---

# 19. System Package Manager vs JavaScript Package Manager

Ahora comparemos APT con npm y pnpm.

## 19.1 APT

Se utiliza para administrar paquetes del sistema en distribuciones compatibles.

## 19.2 npm

Se utiliza para administrar paquetes del ecosistema JavaScript y Node.js.

## 19.3 pnpm

Es otro gestor de paquetes JavaScript, con estrategias propias de instalación y administración de dependencias.

## 19.4 Ejemplo

```text
Linux Operating System
        │
        ▼
APT
        │
        ▼
System Tools
```

```text
JavaScript Project
        │
        ▼
pnpm
        │
        ▼
Project Dependencies
```

## 19.5 ¿Qué administra cada uno?

| Herramienta | Responsabilidad principal |
|---|---|
| APT | Paquetes del sistema Debian/Ubuntu |
| DNF | Paquetes del sistema Fedora/RHEL |
| pacman | Paquetes del sistema Arch |
| nvm | Versiones de Node.js |
| mise | Versiones de herramientas y Runtimes compatibles |
| npm | Paquetes JavaScript |
| pnpm | Paquetes JavaScript y Workspaces |
| Yarn | Paquetes JavaScript |

## 19.6 ¿Por qué importa para monorepos?

Porque un monorepo puede necesitar:

```text
Operating System
    │
    ├── Git
    ├── Build Tools
    │
    └── Node.js Runtime
             │
             ▼
           pnpm
             │
             ▼
          Monorepo
             │
             ├── Application A
             ├── Application B
             └── Shared Packages
```

Cada herramienta cumple una responsabilidad distinta.

---

# 20. Instalación global vs instalación de proyecto

El término *global* puede resultar ambiguo.

Por ejemplo:

```bash
sudo apt install git
```

Administra un paquete del sistema.

En cambio:

```bash
npm install -g typescript
```

Solicita una instalación global dentro del ámbito configurado para npm.

Y:

```bash
npm install --save-dev typescript
```

Declara TypeScript como dependencia de desarrollo del proyecto actual.

## 20.1 ¿Son equivalentes?

No.

Las tres operaciones utilizan diferentes mecanismos de administración.

## 20.2 Problema frecuente

Imagina que un desarrollador utiliza TypeScript instalado globalmente.

```text
Developer A
    │
    └── Global TypeScript Version X
```

Mientras otro utiliza:

```text
Developer B
    │
    └── Global TypeScript Version Y
```

Si el proyecto no declara correctamente su dependencia, pueden aparecer diferencias de comportamiento.

## 20.3 Recomendación

Las herramientas necesarias para construir, verificar o ejecutar un proyecto deberían administrarse de manera reproducible según su función.

No debemos depender innecesariamente de instalaciones globales ocultas.

---

# 21. ¿Qué ocurre cuando instalamos un paquete?

Vamos a observar el proceso de forma conceptual.

Supongamos que solicitamos instalar Git mediante APT.

```text
Developer
    │
    ▼
apt install git
    │
    ▼
Read Available Metadata
    │
    ▼
Resolve Dependencies
    │
    ▼
Calculate Installation Plan
    │
    ▼
Download Packages
    │
    ▼
Verify Required Information
    │
    ▼
Install Packages
    │
    ▼
Update Local Package State
```

## 21.1 ¿Siempre sucede exactamente así?

No.

La implementación concreta depende del gestor y de la operación.

Pero el modelo permite identificar sus responsabilidades principales.

## 21.2 ¿Por qué debemos revisar el plan?

Porque una instalación puede implicar más paquetes de los que esperábamos.

Y una eliminación puede afectar componentes dependientes.

### Principio

**Antes de aceptar una operación de paquetes, debemos comprender qué software se instalará, actualizará o eliminará.**

---

# 22. Repositorios externos y seguridad

Una práctica común consiste en copiar comandos desde tutoriales.

Por ejemplo, podemos encontrar instrucciones que descargan y ejecutan un Script remoto.

Conceptualmente:

```text
Download Remote Script
          │
          ▼
Execute Script
          │
          ▼
Modify System
```

## 22.1 ¿Cuál es el riesgo?

Podemos ejecutar código que:

- Modifique configuraciones.
- Instale software.
- Añada repositorios.
- Cambie permisos.
- Acceda a información del usuario.

## 22.2 ¿Qué debemos comprobar?

Antes de utilizar un procedimiento de instalación:

1. ¿Cuál es la fuente oficial?
2. ¿Quién mantiene el Script?
3. ¿Qué operaciones realiza?
4. ¿Requiere privilegios administrativos?
5. ¿Es compatible con nuestra distribución?
6. ¿Cómo se verifican los paquetes?
7. ¿Cómo se actualiza o elimina después?

## 22.3 Firmas y confianza

Los ecosistemas de paquetes pueden utilizar mecanismos criptográficos para verificar la autenticidad o integridad de información y paquetes.

Los detalles dependen del gestor.

### Advertencia

Una firma válida demuestra una relación con una clave de confianza, pero no garantiza por sí sola que el software esté libre de vulnerabilidades o comportamientos no deseados.

## 22.4 ¿Debemos desactivar verificaciones?

No como solución genérica.

Debemos investigar el origen de cualquier problema de confianza.

### Idea clave

**Instalar software también implica tomar decisiones sobre seguridad y confianza.**

---

# 23. Package Cache

Muchos gestores mantienen una caché local.

## 23.1 ¿Para qué sirve?

Puede almacenar:

- Metadatos.
- Paquetes descargados.
- Información reutilizable.

## 23.2 Modelo conceptual

```text
Package Repository
        │
        ▼
Package Manager
        │
        ├── Local Cache
        │
        └── Installed Packages
```

## 23.3 ¿Por qué es útil?

Puede reducir descargas repetidas y facilitar determinadas operaciones.

## 23.4 ¿Debemos limpiar la caché constantemente?

No.

La limpieza puede ser útil en situaciones concretas, pero no debe convertirse en una operación automática sin necesidad.

### Recomendación

Comprender qué almacena la caché y qué consecuencias tiene eliminarla antes de ejecutar comandos de limpieza.

---

# 24. Package Removal y dependencias

Eliminar un paquete puede ser más complejo de lo que parece.

Imaginemos:

```text
Application A
     │
     └── Library B
```

Si eliminamos `Application A`, podríamos preguntarnos:

¿Debemos eliminar también `Library B`?

Depende.

`Library B` podría ser utilizada por otras aplicaciones.

## 24.1 Dependencias compartidas

```text
Application A ──┐
                ├── Library B
Application C ──┘
```

Eliminar `Library B` podría afectar a `Application C`.

## 24.2 ¿Qué hace el gestor?

Utiliza la información disponible sobre paquetes y dependencias para determinar operaciones posibles.

## 24.3 ¿Qué debemos revisar?

Especialmente antes de:

- Eliminar paquetes.
- Ejecutar limpiezas automáticas.
- Actualizar componentes críticos.
- Cambiar repositorios.

### Principio

**Una operación sobre un paquete puede tener consecuencias sobre otros componentes del sistema.**

---

# 25. Reproducibilidad y Package Managers

Nuestro objetivo profesional no consiste únicamente en conseguir que una herramienta funcione en una máquina.

También queremos poder reproducir el entorno.

## 25.1 Problema

Dos desarrolladores utilizan la misma distribución, pero instalaron paquetes en momentos diferentes.

```text
Developer A
    │
    └── Tool Version 1
```

```text
Developer B
    │
    └── Tool Version 2
```

Podrían aparecer diferencias.

## 25.2 ¿Cómo mejoramos la reproducibilidad?

Mediante:

- Documentación de requisitos.
- Versiones compatibles.
- Fuentes confiables.
- Estrategias de actualización.
- Automatización controlada.
- Separación entre herramientas del sistema y dependencias del proyecto.

## 25.3 ¿Un Package Manager garantiza reproducibilidad absoluta?

No.

Los repositorios pueden cambiar y las versiones disponibles pueden variar.

La reproducibilidad requiere una estrategia más amplia.

### Relación con nuestro Mastery

```text
Development Environment
         │
         ▼
Runtime Management
         │
         ▼
Package Management
         │
         ▼
Project Configuration
         │
         ▼
Reproducible Workspace
```

---

# 26. Troubleshooting: Package Not Found

## 26.1 Síntoma

Intentamos localizar un paquete y el gestor indica que no está disponible.

## 26.2 Posibles causas

- Nombre incorrecto.
- Repositorio no configurado.
- Metadatos desactualizados.
- Paquete no disponible para la distribución.
- Arquitectura no compatible.
- Versión de distribución no compatible.

## 26.3 Diagnóstico en APT

```bash
apt search package-name
```

```bash
apt-cache policy package-name
```

Sustituimos `package-name` por el nombre real.

## 26.4 ¿Qué debemos evitar?

No debemos añadir repositorios desconocidos inmediatamente.

Primero debemos confirmar que el paquete existe y que corresponde a nuestra distribución.

---

# 27. Troubleshooting: Dependency Conflict

## 27.1 Síntoma

El gestor no puede resolver las dependencias necesarias.

## 27.2 Posibles causas

- Restricciones incompatibles.
- Repositorios mezclados.
- Versiones retenidas.
- Paquetes incompatibles.
- Estado incompleto de una operación anterior.

## 27.3 Procedimiento recomendado

1. Leer el error completo.
2. Identificar los paquetes afectados.
3. Consultar sus versiones.
4. Revisar repositorios configurados.
5. Comprender las restricciones.
6. Evaluar una solución compatible.

## 27.4 ¿Qué no debemos hacer?

No debemos forzar instalaciones ni eliminar componentes esenciales sin comprender las consecuencias.

---

# 28. Troubleshooting: Permission Denied

## 28.1 Síntoma

Una operación de instalación falla por permisos.

## 28.2 Posible explicación

El gestor intenta modificar ubicaciones administradas por el sistema.

Estas operaciones suelen requerir privilegios administrativos.

## 28.3 ¿Debemos ejecutar siempre sudo?

No.

Los comandos de consulta normalmente pueden ejecutarse sin privilegios elevados.

Debemos distinguir:

```text
Read Information
```

de:

```text
Modify System
```

## 28.4 Buena práctica

Utilizar privilegios administrativos solamente cuando la operación lo requiera y esté autorizada.

---

# 29. Troubleshooting: Network or Repository Errors

## 29.1 Síntoma

El gestor no puede obtener información o descargar paquetes.

## 29.2 Posibles causas

- Conectividad.
- DNS.
- Proxy.
- Certificados.
- Repositorio no disponible.
- Configuración incorrecta.
- Problemas de autenticación.

## 29.3 Modelo conceptual

```text
Linux Machine
     │
     ▼
Network Configuration
     │
     ▼
DNS / Proxy
     │
     ▼
Package Repository
```

## 29.4 Diagnóstico

Debemos identificar en qué punto falla la operación.

Por ejemplo:

- ¿Se resuelve el nombre?
- ¿Existe conectividad?
- ¿Responde el servidor?
- ¿Se verifica la información de confianza?
- ¿Está configurado el repositorio correcto?

### Advertencia

No debemos desactivar verificaciones TLS ni mecanismos de autenticación para resolver errores sin comprender su causa.

---

# 30. Práctica: identificar el gestor de paquetes

Esta práctica está diseñada para ser **no destructiva**.

No instalaremos ni eliminaremos paquetes.

## Step 1 — Identificar distribución

```bash
cat /etc/os-release
```

Anota:

```text
Distribution:
Version:
```

## Step 2 — Buscar gestores disponibles

```bash
command -v apt
```

```bash
command -v dnf
```

```bash
command -v pacman
```

```bash
command -v zypper
```

```bash
command -v apk
```

Es normal que varios comandos no devuelvan ninguna ruta.

## Step 3 — Identificar el gestor correspondiente

Utiliza la distribución y la documentación del sistema para determinar cuál es el gestor principal.

No asumas que la presencia de un ejecutable demuestra por sí sola que es el gestor oficial de esa distribución.

## Step 4 — Consultar Git

```bash
command -v git
```

Si está disponible:

```bash
git --version
```

## Step 5 — Consultar el paquete Git

Selecciona únicamente el comando correspondiente a tu distribución.

### Debian / Ubuntu

```bash
apt show git
```

### Fedora / RHEL

```bash
dnf info git
```

### Arch Linux

```bash
pacman -Si git
```

### openSUSE

```bash
zypper info git
```

### Alpine Linux

```sh
apk info git
```

En Alpine, la información mostrada por `apk info` depende de las opciones y del estado local; consulta la ayuda de tu versión para distinguir consultas locales y de repositorios.

## Step 6 — Consultar si Git está instalado

### Debian / Ubuntu

```bash
dpkg -s git
```

### Fedora / RHEL

```bash
rpm -q git
```

### Arch Linux

```bash
pacman -Q git
```

### Alpine Linux

```sh
apk info -e git
```

La disponibilidad de estos comandos depende del entorno.

## Step 7 — Documentar

Completa:

| Pregunta | Resultado |
|---|---|
| ¿Qué distribución utilizo? | |
| ¿Qué gestor de paquetes utiliza? | |
| ¿Qué formato de paquete administra? | |
| ¿Git está instalado? | |
| ¿Qué versión de Git tengo? | |
| ¿Qué repositorios utiliza el sistema? | |
| ¿Necesito instalar alguna herramienta adicional? | |

No es necesario modificar el sistema para responder las primeras cinco preguntas.

Para identificar los repositorios, utiliza las herramientas de consulta documentadas por tu distribución y evita publicar URLs privadas o credenciales.

---

# 31. Práctica: analizar una instalación antes de ejecutarla

Imaginemos que necesitamos instalar una herramienta llamada:

```text
example-tool
```

Antes de ejecutar una instalación debemos responder:

1. ¿Qué problema resuelve?
2. ¿Es una herramienta del sistema o del proyecto?
3. ¿Existe en los repositorios de la distribución?
4. ¿Qué versión está disponible?
5. ¿Qué dependencias requiere?
6. ¿Es compatible con nuestra arquitectura?
7. ¿Quién mantiene el paquete?
8. ¿Necesita privilegios administrativos?
9. ¿Cómo se actualizará?
10. ¿Cómo se eliminará?

## 31.1 Evaluar responsabilidades

```text
Need a Tool
     │
     ▼
Identify Responsibility
     │
     ├── System Tool
     │       │
     │       ▼
     │   Linux Package Manager
     │
     ├── Language Runtime
     │       │
     │       ▼
     │   Runtime Strategy
     │
     └── Project Dependency
             │
             ▼
       Project Package Manager
```

## 31.2 Aprendizaje

La primera pregunta profesional no debería ser:

> ¿Qué comando utilizo para instalarlo?

Debería ser:

> ¿Qué responsabilidad cumple esta herramienta y cuál es el mecanismo apropiado para administrarla?

---

# 32. Buenas prácticas profesionales

## 32.1 Utilizar fuentes confiables

Priorizar los repositorios de la distribución y los procedimientos oficiales compatibles con nuestro entorno.

## 32.2 Comprender antes de instalar

Investigar qué paquete necesitamos y qué dependencias incorpora.

## 32.3 No mezclar repositorios indiscriminadamente

Puede provocar incompatibilidades y conflictos.

## 32.4 Revisar las operaciones propuestas

Antes de aceptar una instalación o eliminación, observar qué paquetes serán afectados.

## 32.5 Mantener una estrategia de actualizaciones

Actualizar de manera consciente, considerando seguridad y compatibilidad.

## 32.6 Separar responsabilidades

No utilizar el gestor de paquetes del sistema como sustituto automático del gestor de versiones del Runtime.

## 32.7 Evitar privilegios elevados innecesarios

Consultar información sin `sudo` cuando sea posible.

## 32.8 No ejecutar Scripts remotos sin revisarlos

La comodidad no sustituye la evaluación de confianza.

## 32.9 Documentar herramientas necesarias

Los requisitos importantes deben quedar registrados para el equipo.

## 32.10 Priorizar reproducibilidad

Una instalación individual no constituye por sí sola un entorno profesional reproducible.

---

# 33. Errores comunes

### Error 1 — Confundir Package Manager con Package Repository

Uno administra paquetes; el otro proporciona una fuente de paquetes e información.

### Error 2 — Pensar que todos los gestores Linux son iguales

Comparten conceptos, pero pueden tener semánticas diferentes.

### Error 3 — Confundir APT con dpkg

Operan en niveles diferentes del ecosistema Debian.

### Error 4 — Confundir DNF con RPM

Tienen responsabilidades relacionadas, pero distintas.

### Error 5 — Pensar que `apt update` actualiza todas las aplicaciones

Actualiza información de paquetes, no necesariamente los paquetes instalados.

### Error 6 — Utilizar comandos de Ubuntu en cualquier distribución

No todas utilizan APT.

### Error 7 — Instalar herramientas desde repositorios desconocidos

Introduce riesgos de seguridad y mantenimiento.

### Error 8 — Mezclar repositorios incompatibles

Puede provocar conflictos de dependencias.

### Error 9 — Forzar dependencias sin comprenderlas

Puede afectar otros paquetes del sistema.

### Error 10 — Confundir APT con npm

Administran paquetes de ecosistemas diferentes.

### Error 11 — Instalar todas las herramientas globalmente

Puede introducir dependencias ocultas y conflictos.

### Error 12 — Utilizar siempre la versión más reciente

No garantiza compatibilidad con el proyecto.

### Error 13 — Eliminar paquetes sin revisar dependencias

Puede afectar aplicaciones que dependen de ellos.

### Error 14 — Desactivar verificaciones de seguridad

Puede comprometer la confianza en los paquetes.

### Error 15 — No documentar la estrategia de instalación

Dificulta reproducir el entorno.

---

# 34. Comprueba tu modelo mental

Responde las siguientes preguntas:

1. ¿Qué es un paquete de software?
2. ¿Qué es un Package Manager?
3. ¿Qué problema resuelve?
4. ¿Qué es un Package Repository?
5. ¿Qué es un Package Registry?
6. ¿Qué diferencias existen entre Package Manager y Package Repository?
7. ¿Qué son los metadatos de un paquete?
8. ¿Qué es Dependency Resolution?
9. ¿Qué es una dependencia directa?
10. ¿Qué es una dependencia transitiva?
11. ¿Por qué una instalación puede afectar varios paquetes?
12. ¿Qué gestor utiliza habitualmente Ubuntu?
13. ¿Qué relación existe entre APT y dpkg?
14. ¿Qué gestor utiliza habitualmente Fedora?
15. ¿Qué relación existe entre DNF y RPM?
16. ¿Qué gestor utiliza Arch Linux?
17. ¿Qué es pacman?
18. ¿Qué gestor utiliza Alpine Linux?
19. ¿Qué es apk?
20. ¿Qué diferencia existe entre actualizar índices y actualizar paquetes?
21. ¿Por qué `apt update` y `apt upgrade` no son equivalentes?
22. ¿Por qué Arch Linux requiere especial cuidado con las actualizaciones parciales?
23. ¿Por qué una distribución puede ofrecer una versión anterior de una herramienta?
24. ¿Qué es un Runtime Version Manager?
25. ¿Qué diferencia existe entre APT y nvm?
26. ¿Qué diferencia existe entre APT y pnpm?
27. ¿Por qué no deberíamos depender innecesariamente de TypeScript global?
28. ¿Qué riesgos existen al añadir repositorios externos?
29. ¿Qué papel cumplen las firmas de paquetes?
30. ¿Por qué una firma válida no garantiza ausencia de vulnerabilidades?
31. ¿Qué es una Package Cache?
32. ¿Por qué no debemos limpiar la caché indiscriminadamente?
33. ¿Por qué eliminar un paquete puede afectar a otros?
34. ¿Qué significa reproducibilidad del entorno?
35. ¿Un Package Manager garantiza reproducibilidad absoluta?
36. ¿Cómo diagnosticarías un paquete no encontrado?
37. ¿Qué investigarías ante un conflicto de dependencias?
38. ¿Por qué no debemos utilizar `sudo` para todas las operaciones?
39. ¿Qué comprobarías antes de instalar una herramienta?
40. ¿Cómo decidirías entre APT, un gestor de versiones y pnpm?

---

# 35. Checklist de aprendizaje

- [ ] Comprendo qué es un paquete.
- [ ] Comprendo qué es un gestor de paquetes.
- [ ] Diferencio Package Manager, Repository y Registry.
- [ ] Comprendo qué son los metadatos.
- [ ] Comprendo la resolución de dependencias.
- [ ] Reconozco las principales familias de gestores Linux.
- [ ] Diferencio APT y dpkg.
- [ ] Diferencio DNF y RPM.
- [ ] Comprendo el papel de pacman.
- [ ] Comprendo el papel de apk.
- [ ] Diferencio actualización de índices y paquetes.
- [ ] Puedo identificar el gestor de mi distribución.
- [ ] Puedo consultar un paquete sin instalarlo.
- [ ] Comprendo los riesgos de repositorios externos.
- [ ] Diferencio paquetes del sistema y dependencias JavaScript.
- [ ] Comprendo cuándo considerar un gestor de versiones.
- [ ] Evito instalaciones innecesarias.
- [ ] Puedo explicar cómo una instalación afecta a las dependencias.
- [ ] Comprendo la importancia de la reproducibilidad.

---

# 💡 Idea clave

Los gestores de paquetes representan una solución a un problema fundamental de la ingeniería de software:

**Administrar software y dependencias de manera organizada, consistente y mantenible.**

```text
Developer
    │
    ▼
Identify Tool Responsibility
    │
    ├── Operating System Package
    │       │
    │       ▼
    │   APT / DNF / pacman
    │
    ├── Runtime Version
    │       │
    │       ▼
    │   nvm / mise
    │
    └── JavaScript Dependency
            │
            ▼
       npm / pnpm / Yarn
```

Comprender esta separación nos permitirá evitar conflictos de versiones, configuraciones innecesarias y dependencias ocultas.

El objetivo no es instalar más herramientas.

**El objetivo es saber qué herramienta administra cada responsabilidad y cómo reproducir esa configuración profesionalmente.**

---

# 🚀 Siguiente paso

Ahora comprendemos cómo las distribuciones Linux administran paquetes del sistema.

En el siguiente documento estudiaremos la **configuración del Shell en Linux**.

Aprenderemos:

- Cómo identificar el Shell activo.
- Qué sucede cuando iniciamos una sesión.
- Diferencias entre Login Shell e Interactive Shell.
- Qué son los archivos de inicialización.
- Para qué sirven `.bashrc`, `.profile` y otros archivos.
- Cómo funcionan las variables de entorno.
- Cómo se configura PATH.
- Qué errores debemos evitar al personalizar nuestro entorno.

👉 [Linux Shell Configuration](./03-shell-configuration.md)