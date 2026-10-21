# Linux Development Setup

## Introducción

Linux es uno de los entornos más importantes en la ingeniería de software moderna.

Aunque muchos desarrolladores utilizan Windows o macOS como sistema operativo principal, una gran cantidad de aplicaciones Backend, servidores, plataformas Cloud, sistemas de automatización y contenedores funcionan sobre tecnologías Linux.

Por esta razón, comprender Linux es una habilidad importante incluso cuando no lo utilizamos diariamente como sistema operativo de escritorio.

Sin embargo, antes de instalar herramientas como Node.js, Docker, Git o gestores de paquetes, debemos comprender qué es Linux, cómo está organizado y qué responsabilidades cumple cada componente.

Este documento presenta los fundamentos necesarios para preparar un entorno de desarrollo Linux de manera profesional.

Nuestra metodología será:

**Problema → Concepto → Arquitectura → Responsabilidades → Inspección → Preparación → Buenas prácticas.**

---

## 🎯 Objetivos de aprendizaje

Al finalizar este documento deberías poder:

- Explicar qué es Linux y qué problema resuelve.
- Diferenciar Linux Kernel y Linux Distribution.
- Comprender qué es GNU/Linux.
- Identificar las principales familias de distribuciones.
- Diferenciar Linux Desktop, Linux Server y Linux dentro de WSL.
- Comprender las capas fundamentales de un sistema Linux.
- Identificar las responsabilidades del Kernel, Shell y Terminal.
- Reconocer la estructura básica del sistema de archivos.
- Comprender el modelo de usuarios, grupos y permisos.
- Diferenciar usuarios normales y privilegios administrativos.
- Reconocer la función de los gestores de paquetes del sistema.
- Comprender la relación entre Linux y los Runtimes de desarrollo.
- Inspeccionar un entorno Linux sin modificarlo.
- Preparar una estrategia profesional para configurar una máquina de desarrollo.
- Evitar errores comunes de instalación, seguridad y configuración.

---

# 1. El problema: necesitamos un entorno donde ejecutar software

Imagina que desarrollamos una aplicación con Node.js.

Nuestro código puede ser:

```javascript
console.log("Hello from Node.js");
```

Para ejecutarlo necesitamos un Runtime:

```bash
node app.js
```

Pero Node.js no funciona de manera completamente independiente.

Necesita interactuar con el sistema operativo para realizar operaciones como:

- Leer archivos.
- Crear procesos.
- Reservar memoria.
- Abrir conexiones de red.
- Acceder a dispositivos.
- Administrar recursos.

Podemos representar esta relación así:

```text
JavaScript Application
         │
         ▼
       Node.js
         │
         ▼
 Operating System
         │
         ▼
      Hardware
```

Ahora imaginemos que nuestra aplicación se ejecutará en un servidor Linux.

Para comprender su comportamiento, debemos conocer el entorno sobre el cual funciona.

Por ejemplo:

- ¿Dónde se almacenan los archivos?
- ¿Qué usuario ejecuta el proceso?
- ¿Qué permisos tiene?
- ¿Cómo encuentra el sistema los ejecutables?
- ¿Cómo se instalan las herramientas?
- ¿Cómo se administran los procesos?
- ¿Cómo funciona la conectividad?

Estas preguntas pertenecen al ámbito del sistema operativo y del entorno de desarrollo.

**Linux proporciona una de las plataformas sobre las cuales podemos ejecutar y administrar nuestras aplicaciones.**

---

# 2. ¿Qué es Linux?

En sentido estricto, **Linux es un Kernel**.

El Kernel es el componente central de un sistema operativo.

Su responsabilidad consiste en administrar recursos del sistema y proporcionar mecanismos mediante los cuales los programas pueden interactuar con esos recursos.

Entre sus responsabilidades encontramos:

1. Administración de procesos.
2. Administración de memoria.
3. Gestión de dispositivos.
4. Acceso a sistemas de archivos.
5. Servicios de red.
6. Control de acceso a recursos.
7. Interfaces de comunicación con el sistema.

## 2.1 Modelo conceptual

```text
┌──────────────────────────────┐
│         Applications         │
│                              │
│  Node.js   Git   PostgreSQL  │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│        System Libraries      │
│      and System Calls        │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│         Linux Kernel         │
│                              │
│  Processes  Memory  Network  │
│  Filesystem Device Drivers   │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│           Hardware           │
└──────────────────────────────┘
```

Este diagrama es una simplificación.

Las aplicaciones pueden utilizar bibliotecas del sistema, llamadas al sistema y otras interfaces para interactuar con el Kernel.

## 2.2 ¿Linux es un sistema operativo completo?

En el lenguaje cotidiano solemos utilizar la palabra Linux para referirnos a un sistema operativo completo.

Por ejemplo:

> Tengo Linux instalado en mi computadora.

Sin embargo, normalmente estamos utilizando una **distribución Linux**.

Una distribución combina el Kernel con herramientas y componentes adicionales.

Esta distinción es importante porque nos permite comprender qué responsabilidad pertenece a cada capa.

---

# 3. ¿Qué es una Linux Distribution?

Una distribución Linux es un sistema preparado para utilizarse, construido alrededor del Kernel Linux y acompañado de herramientas, bibliotecas y otros componentes.

Una distribución puede incluir:

- Kernel Linux.
- Bibliotecas del sistema.
- Herramientas de línea de comandos.
- Gestor de paquetes.
- Sistema de inicialización.
- Configuraciones predeterminadas.
- Herramientas de administración.
- Entorno gráfico, cuando corresponda.

## 3.1 Modelo conceptual

```text
Linux Distribution
│
├── Applications
│
├── Desktop Environment (optional)
│
├── Shells
│
├── System Utilities
│
├── Package Manager
│
├── System Libraries
│
├── Init / Service Management
│
└── Linux Kernel
```

## 3.2 Ejemplos de distribuciones

Entre las distribuciones conocidas encontramos:

| Distribución | Característica general |
|---|---|
| Ubuntu | Amplio uso en escritorio, servidores y aprendizaje |
| Debian | Enfoque en estabilidad y comunidad |
| Fedora | Integración de tecnologías recientes del ecosistema Linux |
| Red Hat Enterprise Linux | Orientación empresarial |
| Rocky Linux | Distribución compatible con el ecosistema RHEL |
| AlmaLinux | Distribución compatible con el ecosistema RHEL |
| Arch Linux | Configuración flexible y modelo Rolling Release |
| openSUSE | Distribución con herramientas propias de administración |

Estas descripciones son generales.

Las capacidades concretas dependen de la versión y edición utilizada.

## 3.3 ¿Todas utilizan el mismo Kernel?

Todas utilizan Linux como Kernel, pero pueden incorporar versiones, configuraciones y modificaciones diferentes.

## 3.4 ¿Todas utilizan los mismos comandos?

Muchos comandos son comunes, pero no debemos asumir que todas las distribuciones incluyen exactamente las mismas herramientas.

Por ejemplo, una distribución puede utilizar APT y otra DNF.

### Idea clave

**Linux es el Kernel; una distribución es el conjunto de componentes que nos permite utilizarlo como entorno operativo.**

---

# 4. ¿Qué significa GNU/Linux?

Al estudiar Linux encontraremos el término **GNU/Linux**.

GNU es un proyecto de software libre que desarrolló numerosas herramientas y componentes utilizados en sistemas Unix-like.

Entre ellos encontramos:

- GNU Bash.
- GNU Coreutils.
- GNU Compiler Collection (GCC).
- GNU Make.
- GNU C Library (glibc).

Muchas distribuciones combinan el Kernel Linux con herramientas del proyecto GNU.

Por esta razón, algunas personas utilizan el término GNU/Linux para referirse al sistema completo.

## 4.1 Modelo conceptual

```text
Linux Kernel
     +
GNU Utilities
     +
System Libraries
     +
Additional Software
     ↓
Linux-based Operating System
```

## 4.2 ¿Todas las distribuciones utilizan los mismos componentes GNU?

No necesariamente.

Existen sistemas basados en Linux que utilizan otras bibliotecas y conjuntos de herramientas.

Por ejemplo, algunas distribuciones emplean musl en lugar de glibc.

### ¿Por qué nos importa como desarrolladores?

Porque las diferencias entre bibliotecas y componentes del sistema pueden afectar la compatibilidad de ciertos ejecutables y dependencias nativas.

Más adelante encontraremos estas diferencias al estudiar contenedores y despliegues.

Por ahora debemos recordar:

**El Kernel y las herramientas de usuario son componentes distintos.**

---

# 5. Linux no significa necesariamente utilizar una interfaz gráfica

Cuando pensamos en un sistema operativo, podemos imaginar ventanas, iconos y aplicaciones visuales.

Pero Linux también puede utilizarse sin un entorno gráfico.

## 5.1 Linux Desktop

Una distribución orientada a escritorio puede incluir:

```text
Linux Desktop
│
├── Graphical Desktop
├── File Manager
├── Terminal Emulator
├── Web Browser
├── Development Tools
└── Linux Kernel
```

Ejemplos de entornos gráficos son GNOME y KDE Plasma.

## 5.2 Linux Server

Un servidor puede utilizarse principalmente mediante herramientas de línea de comandos.

```text
Linux Server
│
├── System Services
├── SSH Access
├── Shell
├── Runtime
├── Application Processes
└── Linux Kernel
```

No necesita obligatoriamente un entorno gráfico para ejecutar aplicaciones.

## 5.3 Linux en WSL

Dentro de Windows podemos utilizar una distribución Linux mediante WSL.

```text
Windows
   │
   ▼
WSL 2
   │
   ▼
Linux Distribution
   │
   ├── Shell
   ├── Linux Tools
   └── Linux Applications
```

WSL 2 utiliza un Kernel Linux real mediante virtualización ligera.

## 5.4 ¿Son entornos idénticos?

No.

Aunque comparten numerosos conceptos, pueden existir diferencias en:

- Arranque del sistema.
- Integración con hardware.
- Administración de servicios.
- Red.
- Sistemas de archivos.
- Recursos disponibles.

### Recomendación

Para aprender fundamentos Linux no es obligatorio reemplazar Windows o macOS.

Podemos estudiar estos conceptos utilizando un entorno Linux adecuado, incluyendo WSL 2 cuando esté disponible.

---

# 6. Arquitectura fundamental de Linux

Ahora vamos a construir un modelo mental de sus componentes.

```text
┌─────────────────────────────────┐
│          Applications           │
│                                 │
│    Node.js   Git   Database     │
├─────────────────────────────────┤
│       Shell and Utilities       │
│                                 │
│    Bash   ls   grep   find      │
├─────────────────────────────────┤
│       System Libraries          │
│                                 │
│    libc and other libraries     │
├─────────────────────────────────┤
│          Linux Kernel           │
│                                 │
│  Process  Memory  Files  Network│
├─────────────────────────────────┤
│            Hardware             │
└─────────────────────────────────┘
```

Veamos cada capa.

## 6.1 Hardware

Representa los recursos físicos o virtualizados.

Por ejemplo:

- CPU.
- Memoria RAM.
- Almacenamiento.
- Interfaces de red.

En una máquina virtual, parte del hardware observado por Linux puede estar virtualizado.

## 6.2 Linux Kernel

Administra recursos y proporciona interfaces para que los programas utilicen servicios del sistema.

## 6.3 System Libraries

Son bibliotecas que proporcionan funciones reutilizables a las aplicaciones.

Por ejemplo, una aplicación puede utilizar bibliotecas para trabajar con archivos, memoria o redes.

## 6.4 Shell

Permite introducir instrucciones y ejecutar programas.

Ejemplos:

- Bash.
- Zsh.
- Fish.

## 6.5 Utilities

Son herramientas que realizan operaciones concretas.

Por ejemplo:

```bash
ls
```

```bash
grep
```

```bash
find
```

## 6.6 Applications

Son programas que ejecutamos sobre el sistema.

Por ejemplo:

- Node.js.
- Git.
- PostgreSQL.
- Nginx.

### Idea fundamental

No debemos confundir:

```text
Kernel ≠ Shell ≠ Terminal ≠ Application
```

Cada componente tiene una responsabilidad diferente.

---

# 7. Terminal vs Shell en Linux

Esta diferencia ya la hemos estudiado en macOS y Windows, pero es importante reforzarla.

## 7.1 Terminal Emulator

Una Terminal Emulator es una aplicación que proporciona una interfaz para interactuar con sesiones de línea de comandos.

Por ejemplo:

- GNOME Terminal.
- Konsole.
- Alacritty.
- Kitty.

## 7.2 Shell

El Shell interpreta comandos y proporciona un entorno para ejecutarlos.

Por ejemplo:

```text
Bash
Zsh
Fish
```

## 7.3 Relación

```text
Developer
    │
    ▼
Terminal Emulator
    │
    ▼
Shell
    │
    ▼
Command
    │
    ▼
Operating System
```

## 7.4 Ejemplo

Abrimos una Terminal y escribimos:

```bash
pwd
```

El Shell procesa el comando y ejecuta la operación correspondiente.

La Terminal presenta el resultado.

## 7.5 ¿Linux utiliza siempre Bash?

No.

Bash es común, pero existen otros Shells.

Además, el Shell predeterminado depende de la distribución y configuración del usuario.

### Comprobar Shell configurado

```bash
echo "$SHELL"
```

Esta variable suele indicar el Shell configurado para el usuario, pero no garantiza que sea el intérprete del proceso actual.

En sistemas compatibles con las opciones utilizadas, podemos consultar el proceso actual mediante:

```bash
ps -p $$ -o comm=
```

El resultado debe interpretarse considerando que `$$` identifica el proceso asociado al Shell según sus reglas.

Estudiaremos los Shells en profundidad en el módulo `02-terminal-and-shell`.

---

# 8. Linux File System

Uno de los conceptos fundamentales de Linux es su estructura de directorios.

En Windows solemos encontrar unidades como:

```text
C:\
D:\
```

En Linux existe una jerarquía de archivos que comienza en:

```text
/
```

Este directorio se conoce como **Root Directory**.

## 8.1 Estructura conceptual

```text
/
├── bin
├── boot
├── dev
├── etc
├── home
│   └── developer
├── lib
├── media
├── mnt
├── opt
├── proc
├── root
├── run
├── sbin
├── srv
├── sys
├── tmp
├── usr
│   ├── bin
│   └── lib
└── var
```

Esta estructura es ilustrativa.

No todos los sistemas incluyen exactamente los mismos directorios ni los organizan de manera idéntica.

En distribuciones modernas, algunos directorios tradicionales pueden ser enlaces simbólicos hacia ubicaciones dentro de `/usr`.

## 8.2 Directorios importantes

| Directorio | Responsabilidad habitual |
|---|---|
| `/` | Raíz de la jerarquía |
| `/home` | Directorios personales de usuarios |
| `/etc` | Configuración del sistema |
| `/usr` | Programas, bibliotecas y recursos compartidos |
| `/var` | Datos variables, como determinados Logs y cachés |
| `/tmp` | Archivos temporales |
| `/opt` | Software adicional |
| `/dev` | Representación de dispositivos |
| `/proc` | Información del Kernel y procesos |
| `/sys` | Interfaces relacionadas con dispositivos y Kernel |
| `/mnt` | Puntos de montaje |
| `/media` | Montajes de medios, según configuración |
| `/root` | Directorio personal habitual del usuario root |

## 8.3 ¿Qué es un Mount Point?

Un punto de montaje permite incorporar un sistema de archivos dentro de la jerarquía existente.

Por ejemplo, un dispositivo de almacenamiento puede montarse en una ubicación determinada.

### Modelo conceptual

```text
Linux File System
       │
       └── /mnt
             │
             └── external-drive
                    │
                    └── Mounted File System
```

## 8.4 ¿Dónde guardamos proyectos?

En una máquina de desarrollo personal, una opción habitual es utilizar una carpeta dentro del directorio personal.

Por ejemplo:

```text
/home/developer/projects
```

O:

```text
/home/developer/Developer
```

No existe una única convención obligatoria.

### Recomendación

Elegir una ubicación:

- Comprensible.
- Accesible por nuestro usuario.
- Fácil de respaldar.
- Compatible con nuestras herramientas.
- Consistente con los estándares del equipo.

---

# 9. Paths: rutas absolutas y relativas

Una ruta identifica una ubicación dentro del sistema de archivos.

## 9.1 Absolute Path

Una ruta absoluta comienza desde la raíz.

Por ejemplo:

```text
/home/developer/projects
```

## 9.2 Relative Path

Una ruta relativa se interpreta desde el directorio actual.

Por ejemplo:

```text
projects/my-app
```

## 9.3 Directorio actual

Podemos consultarlo mediante:

```bash
pwd
```

## 9.4 Directorio personal

Habitualmente podemos acceder mediante:

```bash
cd ~
```

## 9.5 Directorio superior

```bash
cd ..
```

## 9.6 Directorio actual

```text
.
```

## 9.7 Directorio padre

```text
..
```

### Ejemplo

```text
/home/developer/projects/my-app
```

Si estamos dentro de `my-app`, la ruta:

```text
../
```

hace referencia a su directorio padre.

### Importante

Los comandos y la navegación se estudiarán con mayor profundidad en el módulo `02-terminal-and-shell`.

Aquí solamente necesitamos reconocer cómo se organizan las rutas.

---

# 10. Case Sensitivity

En muchos sistemas de archivos Linux, los nombres distinguen entre mayúsculas y minúsculas.

Por ejemplo:

```text
README.md
```

y:

```text
readme.md
```

pueden representar archivos diferentes.

## 10.1 ¿Por qué importa?

Imagina que escribimos:

```javascript
import { Button } from "./Components/Button.js";
```

Pero el directorio real se llama:

```text
components
```

En un sistema de archivos sensible a mayúsculas y minúsculas, esa diferencia puede provocar errores.

## 10.2 ¿Todos los sistemas Linux funcionan igual?

El comportamiento depende del sistema de archivos y de su configuración.

No debemos asumir que todas las ubicaciones presentan exactamente las mismas reglas.

## 10.3 Buena práctica

Mantener convenciones consistentes para nombres de archivos y directorios.

Por ejemplo:

```text
components/
services/
utils/
```

### Principio

**El hecho de que una ruta funcione en una computadora no garantiza que funcione en todos los sistemas de archivos.**

---

# 11. Usuarios y grupos

Linux utiliza un modelo de usuarios y grupos para administrar identidades y controlar el acceso a recursos.

## 11.1 Usuario

Representa una identidad dentro del sistema.

Por ejemplo:

```text
developer
```

## 11.2 Grupo

Permite agrupar usuarios y utilizar esa pertenencia para establecer permisos sobre recursos.

## 11.3 Consultar usuario actual

```bash
whoami
```

## 11.4 Consultar identificadores

```bash
id
```

La salida puede incluir:

- UID: User ID.
- GID: Group ID.
- Grupos adicionales.

## 11.5 Modelo conceptual

```text
Linux System
│
├── User: developer
│   │
│   ├── UID
│   ├── Primary Group
│   └── Supplementary Groups
│
└── Files and Processes
    │
    └── Ownership / Permissions
```

### ¿Por qué importa?

Porque los archivos y procesos están asociados a identidades y permisos.

Esto afecta operaciones como:

- Leer archivos.
- Modificar configuraciones.
- Ejecutar programas.
- Instalar paquetes del sistema.
- Acceder a servicios.

---

# 12. Linux File Permissions

Los sistemas Linux utilizan mecanismos de permisos para controlar el acceso a archivos y directorios.

Un modelo habitual contempla:

- Owner.
- Group.
- Others.

Y permisos como:

- Read.
- Write.
- Execute.

## 12.1 Representación conceptual

```text
Owner    Group    Others
 rwx      r-x      r--
```

## 12.2 Consultar permisos

```bash
ls -l
```

Podemos encontrar una salida ilustrativa como:

```text
-rw-r--r-- 1 developer developer 128 README.md
```

### Interpretación simplificada

```text
- rw- r-- r--
│  │   │   │
│  │   │   └── Others
│  │   └────── Group
│  └────────── Owner
└───────────── File Type
```

## 12.3 ¿Qué significa Read?

En un archivo, normalmente permite leer su contenido.

## 12.4 ¿Qué significa Write?

En un archivo, normalmente permite modificar su contenido.

## 12.5 ¿Qué significa Execute?

En un archivo, permite participar en la autorización de su ejecución según las reglas del sistema.

En directorios, el permiso de ejecución tiene un significado diferente: está relacionado con atravesar o acceder a entradas del directorio.

## 12.6 ¿Son estos todos los mecanismos de seguridad?

No.

También pueden intervenir:

- Access Control Lists.
- Políticas adicionales de seguridad.
- Configuraciones de montaje.
- Restricciones del sistema.

### Recomendación

No debemos modificar permisos de manera masiva sin comprender qué recurso necesita acceso y por qué.

---

# 13. Root y privilegios administrativos

Linux dispone tradicionalmente de una cuenta especial denominada:

```text
root
```

Esta cuenta tiene privilegios administrativos amplios.

## 13.1 ¿Es lo mismo `/` que `/root`?

No.

```text
/
```

Representa la raíz de la jerarquía del sistema de archivos.

```text
/root
```

Es el directorio personal habitual del usuario root.

Son conceptos diferentes.

## 13.2 ¿Qué es sudo?

`sudo` permite ejecutar determinados comandos con privilegios de otro usuario, habitualmente root, cuando la configuración del sistema lo autoriza.

### Ejemplo ilustrativo

```bash
sudo apt update
```

En una distribución compatible con APT, este comando solicita actualizar los índices de paquetes.

No debemos ejecutarlo todavía como parte de nuestra inspección inicial.

## 13.3 ¿Debemos desarrollar como root?

Generalmente no.

Es preferible utilizar una cuenta normal para las tareas habituales.

## 13.4 ¿Por qué?

Porque trabajar continuamente con privilegios elevados incrementa el impacto potencial de errores.

### Modelo conceptual

```text
Normal Development
        │
        ▼
Regular User
        │
        ├── Edit Project
        ├── Run Applications
        └── Manage User Files
```

```text
Administrative Operation
        │
        ▼
Authorized Privilege Elevation
        │
        └── Specific System Change
```

### Principio

**Utilizar los privilegios mínimos necesarios para cada operación.**

---

# 14. Procesos en Linux

Un proceso es una instancia de un programa en ejecución.

Por ejemplo, cuando ejecutamos una aplicación Node.js, el sistema crea un proceso.

## 14.1 Modelo conceptual

```text
Node.js Executable
        │
        ▼
Node.js Process
        │
        ├── Process ID
        ├── Memory
        ├── Environment
        ├── Open Files
        └── Network Connections
```

## 14.2 ¿Qué es PID?

PID significa:

**Process Identifier**.

Es un identificador asociado a un proceso.

## 14.3 Consultar procesos

```bash
ps
```

También podemos encontrar:

```bash
ps aux
```

La disponibilidad y comportamiento de las opciones dependen de la implementación utilizada.

## 14.4 ¿Por qué importa?

Porque durante el desarrollo podemos necesitar comprender:

- Qué aplicación está ejecutándose.
- Qué usuario inició el proceso.
- Qué recursos utiliza.
- Qué proceso escucha en un puerto.
- Por qué una aplicación no finaliza.

Estudiaremos estas operaciones con más profundidad en módulos posteriores.

---

# 15. Environment Variables

Las variables de entorno permiten transmitir información de configuración a los procesos.

Por ejemplo:

```text
NODE_ENV
PORT
PATH
HOME
```

## 15.1 Consultar HOME

```bash
echo "$HOME"
```

## 15.2 Consultar PATH

```bash
echo "$PATH"
```

## 15.3 ¿Qué es PATH?

`PATH` contiene una lista de directorios utilizados para localizar comandos ejecutables.

En sistemas Linux y Shells habituales, las entradas se separan mediante dos puntos:

```text
:
```

### Ejemplo ilustrativo

```text
/usr/local/bin:/usr/bin:/bin
```

## 15.4 Modelo conceptual

```text
Command: node
      │
      ▼
Shell Resolution
      │
      ▼
PATH Directories
      │
      ▼
Node.js Executable
```

## 15.5 ¿Qué ocurre si no encontramos un comando?

Podríamos obtener:

```text
command not found
```

Eso no significa necesariamente que la herramienta no esté instalada.

Podría existir un problema de resolución o configuración.

## 15.6 Consultar resolución

```bash
command -v git
```

Si Git está disponible, el comando puede mostrar su ubicación o información de resolución.

### Importante

La administración detallada de `PATH`, variables y archivos de inicialización pertenece al módulo `02-terminal-and-shell`.

---

# 16. Gestores de paquetes del sistema

Las distribuciones Linux suelen proporcionar mecanismos para instalar, actualizar y administrar software.

Estos mecanismos incluyen gestores de paquetes.

## 16.1 Ejemplos

| Familia o distribución | Herramientas habituales |
|---|---|
| Debian / Ubuntu | APT y dpkg |
| Fedora / RHEL | DNF y RPM |
| Arch Linux | pacman |
| openSUSE | Zypper y RPM |
| Alpine Linux | apk |

## 16.2 ¿Qué administra un Package Manager del sistema?

Puede administrar:

- Herramientas.
- Bibliotecas.
- Dependencias del sistema.
- Actualizaciones.
- Paquetes proporcionados por repositorios.

## 16.3 ¿Es equivalente a npm?

No.

### Linux Package Manager

```text
Linux Distribution
        │
        ▼
APT / DNF / pacman
        │
        ▼
System Packages
```

### JavaScript Package Manager

```text
JavaScript Project
        │
        ▼
npm / pnpm / Yarn
        │
        ▼
JavaScript Packages
```

## 16.4 ¿Debemos instalar Node.js con APT?

No necesariamente.

Existen distintas estrategias para administrar Runtimes.

Por ejemplo, podemos utilizar gestores de versiones cuando necesitamos trabajar con múltiples versiones de Node.js.

Estudiaremos esas estrategias en:

```text
04-runtime-management
```

Y profundizaremos en los gestores de paquetes Linux en el siguiente documento de esta sección.

---

# 17. Linux y desarrollo Backend

Linux es especialmente relevante para el desarrollo de aplicaciones Backend.

Imagina una arquitectura sencilla:

```text
Client
   │
   ▼
HTTP Request
   │
   ▼
Linux Server
   │
   ├── Reverse Proxy
   │
   ├── Node.js Application
   │
   └── Database Connection
```

En este escenario, Linux proporciona recursos y servicios que utilizan los diferentes procesos.

## 17.1 ¿Qué debe comprender un Backend Developer?

Algunos conceptos fundamentales son:

- Procesos.
- Puertos.
- Usuarios.
- Permisos.
- Variables de entorno.
- Sistemas de archivos.
- Servicios.
- Logs.
- Redes.
- Seguridad.

## 17.2 ¿Debemos dominar administración avanzada de Linux antes de crear una API?

No.

Podemos comenzar desarrollando aplicaciones y ampliar progresivamente nuestro conocimiento del sistema.

Sin embargo, comprender estos fundamentos facilita el diagnóstico y el despliegue.

### Idea clave

**El objetivo inicial no es convertirnos en administradores de sistemas Linux, sino comprender el entorno sobre el cual se ejecuta nuestro software.**

---

# 18. Linux, Docker y Cloud

Linux también es importante en el ecosistema de contenedores y Cloud.

## 18.1 Linux y contenedores

Los contenedores Linux utilizan características del Kernel para proporcionar mecanismos de aislamiento y control de recursos.

Entre ellas encontramos:

- Namespaces.
- Control Groups.
- Capacidades y otros mecanismos de seguridad.

No estudiaremos estos conceptos en profundidad todavía.

### Modelo conceptual

```text
Linux Host
    │
    ▼
Container Runtime
    │
    ├── Container A
    ├── Container B
    └── Container C
```

Los contenedores Linux comparten el Kernel del entorno Linux anfitrión correspondiente.

No son equivalentes a máquinas virtuales completas.

## 18.2 Linux y Cloud

En plataformas Cloud podemos ejecutar aplicaciones utilizando diferentes servicios.

Algunos escenarios utilizan servidores Linux.

Otros abstraen gran parte de la administración del sistema operativo.

### Ejemplo conceptual

```text
Cloud Infrastructure
        │
        ▼
Linux Virtual Machine
        │
        ▼
Node.js Runtime
        │
        ▼
Backend Application
```

## 18.3 ¿Necesitamos dominar Linux para utilizar Cloud?

Depende del servicio y de las responsabilidades que asumamos.

Cuanto más control tengamos sobre servidores y procesos, más importante será comprender el sistema operativo.

### Principio

**Aprender Linux nos ayuda a comprender las capas que muchas plataformas Cloud administran por nosotros.**

---

# 19. Elegir una distribución para aprender

Si estamos comenzando, debemos evitar complicar innecesariamente la elección.

## 19.1 Criterios importantes

Podemos considerar:

1. Documentación disponible.
2. Comunidad.
3. Compatibilidad con herramientas.
4. Facilidad de instalación.
5. Estabilidad.
6. Requisitos del equipo.
7. Distribución utilizada por nuestro equipo profesional.

## 19.2 ¿Qué recomendaríamos para comenzar?

**Ubuntu LTS o Debian Stable** son opciones razonables para estudiar fundamentos Linux.

Ubuntu LTS puede resultar especialmente accesible por la disponibilidad de documentación y tutoriales.

Debian Stable también es una excelente alternativa.

## 19.3 ¿Debemos utilizar Arch Linux para aprender más?

No es necesario.

Arch Linux ofrece una experiencia de configuración diferente, pero no constituye un requisito para desarrollar una comprensión profesional de Linux.

## 19.4 ¿Debemos cambiar nuestra computadora a Linux?

No.

Podemos aprender utilizando:

- Una máquina Linux existente.
- Una máquina virtual.
- WSL 2.
- Un entorno de laboratorio autorizado.

### Recomendación

Elegir un entorno que permita practicar sin comprometer nuestra computadora principal ni nuestras herramientas de trabajo.

---

# 20. Estrategia profesional de preparación

Antes de instalar software debemos planificar el entorno.

## 20.1 Identificar necesidades

Preguntarnos:

- ¿Qué proyectos desarrollaremos?
- ¿Necesitamos Node.js?
- ¿Necesitamos Git?
- ¿Utilizaremos Docker?
- ¿Trabajaremos con bases de datos?
- ¿El proyecto requiere herramientas Linux específicas?

## 20.2 Identificar restricciones

Por ejemplo:

- Recursos del equipo.
- Permisos disponibles.
- Conectividad.
- Políticas corporativas.
- Versiones requeridas.

## 20.3 Separar herramientas por responsabilidad

```text
Linux Development Environment
│
├── Operating System
│
├── Shell
│
├── System Package Manager
│
├── Runtime Version Manager
│
├── Language Runtime
│
├── JavaScript Package Manager
│
├── Editor
│
└── Project Configuration
```

## 20.4 Evitar instalaciones prematuras

No debemos instalar todas las herramientas que aparecen en un Roadmap.

Primero debemos comprender qué responsabilidad cumple cada una.

## 20.5 Documentar decisiones

Por ejemplo:

```text
Operating System:
Ubuntu LTS

Shell:
Bash

Runtime Strategy:
Version Manager

JavaScript Package Manager:
Project-defined

Editor:
VS Code

Project Location:
User Home Directory
```

Este ejemplo es una plantilla conceptual, no una configuración obligatoria.

---

# 21. Práctica: Linux Environment Audit

Vamos a realizar una inspección inicial del sistema.

**Todos los comandos de esta práctica son de consulta. No requieren instalar paquetes ni modificar configuraciones.**

Puedes ejecutarlos en una distribución Linux disponible.

Si utilizas WSL, recuerda que algunos resultados reflejarán ese entorno particular.

## Step 1 — Identificar distribución

```bash
cat /etc/os-release
```

### ¿Qué debemos observar?

Campos como:

```text
NAME
VERSION
ID
```

La información exacta depende de la distribución.

## Step 2 — Identificar Kernel

```bash
uname -r
```

Este comando muestra información de la versión del Kernel.

## Step 3 — Identificar arquitectura

```bash
uname -m
```

Podemos encontrar valores como:

```text
x86_64
```

O:

```text
aarch64
```

Estos valores representan arquitecturas distintas.

## Step 4 — Identificar usuario

```bash
whoami
```

## Step 5 — Identificar grupos

```bash
id
```

## Step 6 — Identificar directorio personal

```bash
echo "$HOME"
```

## Step 7 — Identificar directorio actual

```bash
pwd
```

## Step 8 — Identificar Shell configurado

```bash
echo "$SHELL"
```

## Step 9 — Consultar PATH

```bash
echo "$PATH"
```

## Step 10 — Consultar Git

```bash
command -v git
```

Si Git está disponible:

```bash
git --version
```

## Step 11 — Consultar Node.js

```bash
command -v node
```

Si Node.js está disponible:

```bash
node --version
```

## Step 12 — Consultar npm

```bash
command -v npm
```

Si npm está disponible:

```bash
npm --version
```

## Step 13 — Consultar espacio disponible

```bash
df -h
```

Este comando muestra información de sistemas de archivos y espacio.

## Step 14 — Consultar memoria

En sistemas que proporcionan esta herramienta:

```bash
free -h
```

Si no está disponible, no debemos asumir que el sistema está mal configurado.

## Step 15 — Consultar procesos

```bash
ps
```

## Step 16 — Consultar directorio personal

```bash
ls -la "$HOME"
```

Este comando puede mostrar archivos y directorios ocultos.

No es necesario compartir públicamente su salida completa.

---

# 22. Documentar nuestro entorno

Completa la siguiente tabla:

| Componente | Resultado |
|---|---|
| Distribución Linux | |
| Versión de distribución | |
| Kernel | |
| Arquitectura | |
| Usuario | |
| UID | |
| Directorio personal | |
| Shell configurado | |
| PATH | |
| Git | |
| Node.js | |
| npm | |
| Espacio disponible | |

### Reflexión

Después de completar la tabla, responde:

1. ¿Qué distribución utilizas?
2. ¿Qué Kernel reporta?
3. ¿Qué arquitectura utiliza?
4. ¿Qué usuario ejecuta tus comandos?
5. ¿Dónde se encuentra tu directorio personal?
6. ¿Qué Shell tienes configurado?
7. ¿Git está disponible?
8. ¿Node.js está disponible?
9. ¿Necesitas instalar alguna herramienta para tu proyecto actual?
10. ¿Qué información deberías documentar para otro desarrollador?

### Importante

No tener Node.js, Git o npm instalado todavía no significa que Linux esté mal configurado.

La necesidad de esas herramientas depende del proyecto.

---

# 23. Problemas frecuentes en la preparación inicial

## Problema A — No sabemos qué distribución utilizamos

### Diagnóstico

```bash
cat /etc/os-release
```

### Aprendizaje

Antes de seguir instrucciones de instalación debemos identificar la distribución.

No debemos utilizar comandos de Ubuntu indiscriminadamente en Fedora o Arch Linux.

---

## Problema B — Command Not Found

### Síntoma

```text
command not found
```

### Posibles causas

- Herramienta no instalada.
- PATH incorrecto.
- Nombre de comando equivocado.
- Configuración del Shell.
- Herramienta disponible solamente en otro entorno.

### Diagnóstico

```bash
command -v git
```

```bash
echo "$PATH"
```

### Recomendación

Investigar antes de instalar o modificar.

---

## Problema C — Permission Denied

### Posibles causas

- Permisos insuficientes.
- Archivo no ejecutable.
- Propiedad incorrecta.
- Restricciones de montaje.
- Políticas de seguridad.

### Diagnóstico

```bash
whoami
```

```bash
id
```

```bash
ls -l
```

### Precaución

No debemos utilizar `sudo` como respuesta automática.

---

## Problema D — No sabemos dónde guardar proyectos

### Recomendación

Utilizar una ubicación apropiada dentro del directorio personal, salvo que el equipo tenga una convención diferente.

Por ejemplo:

```text
~/projects
```

### Ventaja

Permite separar nuestros proyectos de los archivos del sistema.

---

## Problema E — El tutorial utiliza otro gestor de paquetes

### Ejemplo

El tutorial utiliza:

```text
apt
```

Pero nuestra distribución utiliza:

```text
dnf
```

### Explicación

Los gestores de paquetes dependen de la distribución.

### Solución

Consultar la documentación de nuestra distribución y utilizar el gestor apropiado.

No debemos copiar comandos de instalación sin comprenderlos.

---

## Problema F — El tutorial utiliza otra versión de Linux

### Posibles diferencias

- Nombres de paquetes.
- Versiones disponibles.
- Configuraciones.
- Ubicación de archivos.
- Servicios.
- Compatibilidad.

### Recomendación

Comprobar la versión de la distribución y buscar documentación correspondiente.

---

## Problema G — Una herramienta funciona en Windows, pero no en WSL

### Explicación

Windows y WSL utilizan entornos de ejecución diferentes.

### Diagnóstico

Dentro de WSL:

```bash
command -v node
```

```bash
node --version
```

El segundo comando solamente funcionará si `node` puede resolverse.

### Recomendación

Administrar las herramientas correspondientes al entorno donde ejecutaremos el proyecto.

---

# 24. Buenas prácticas profesionales

## 24.1 Comprender antes de instalar

No debemos instalar herramientas solamente porque aparecen en un tutorial.

## 24.2 Utilizar una cuenta normal

Reservar privilegios administrativos para operaciones que realmente los necesiten.

## 24.3 Evitar modificaciones masivas

No debemos modificar permisos o propiedades de directorios completos sin comprender sus consecuencias.

## 24.4 Respetar la distribución

Utilizar herramientas y documentación compatibles con nuestro sistema.

## 24.5 Mantener separadas las responsabilidades

Distinguir:

- Gestor de paquetes del sistema.
- Gestor de versiones del Runtime.
- Gestor de paquetes del lenguaje.
- Configuración del proyecto.

## 24.6 Evitar configuraciones globales innecesarias

Preferir configuraciones específicas del proyecto cuando corresponda.

## 24.7 Proteger credenciales

No almacenar contraseñas, Tokens ni claves privadas en archivos compartidos del repositorio.

## 24.8 Documentar versiones

Registrar las versiones requeridas para reproducir el entorno.

## 24.9 No ejecutar Scripts desconocidos

Debemos comprender el origen y el contenido de los Scripts antes de ejecutarlos, especialmente cuando requieren privilegios elevados.

## 24.10 Mantener una estrategia de actualización

Actualizar herramientas y componentes siguiendo una política consciente de compatibilidad y seguridad.

---

# 25. Errores comunes

### 1. Confundir Linux con una distribución

Linux es el Kernel; las distribuciones incorporan herramientas y componentes adicionales.

### 2. Pensar que todas las distribuciones son idénticas

Pueden diferir en gestores de paquetes, configuraciones y componentes.

### 3. Confundir Terminal con Shell

Cumplen responsabilidades distintas.

### 4. Pensar que Linux siempre necesita una interfaz gráfica

Puede funcionar sin un entorno gráfico.

### 5. Confundir `/` con `/root`

Representan ubicaciones diferentes.

### 6. Ignorar los permisos

Pueden determinar si una operación está autorizada.

### 7. Utilizar root para todo

Incrementa innecesariamente los privilegios de las operaciones.

### 8. Copiar comandos de otra distribución sin comprobarlos

Puede producir errores o cambios no deseados.

### 9. Confundir APT con npm

Administran diferentes tipos de paquetes.

### 10. Instalar múltiples Runtimes sin una estrategia

Puede generar conflictos de versiones.

### 11. Ignorar Case Sensitivity

Puede provocar errores al mover proyectos entre sistemas.

### 12. Pensar que WSL y Linux nativo son entornos idénticos

Comparten numerosos conceptos, pero su integración y administración pueden diferir.

### 13. Modificar PATH sin comprenderlo

Puede impedir encontrar herramientas existentes.

### 14. Ejecutar Scripts remotos sin revisarlos

Puede introducir riesgos de seguridad.

### 15. Configurar todas las herramientas antes de conocer los requisitos del proyecto

Genera complejidad innecesaria.

---

# 26. Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es Linux?
2. ¿Qué es un Kernel?
3. ¿Qué responsabilidades tiene el Kernel?
4. ¿Qué es una distribución Linux?
5. ¿Qué diferencia existe entre Linux y Ubuntu?
6. ¿Qué significa GNU/Linux?
7. ¿Qué son GNU Coreutils?
8. ¿Todas las distribuciones utilizan exactamente las mismas herramientas?
9. ¿Qué diferencia existe entre Linux Desktop y Linux Server?
10. ¿Qué diferencia existe entre Linux nativo y WSL 2?
11. ¿Qué es una Terminal Emulator?
12. ¿Qué es un Shell?
13. ¿Linux utiliza siempre Bash?
14. ¿Qué representa `/`?
15. ¿Qué representa `/home`?
16. ¿Qué representa `/etc`?
17. ¿Qué representa `/usr`?
18. ¿Qué representa `/var`?
19. ¿Qué diferencia existe entre `/` y `/root`?
20. ¿Qué es una ruta absoluta?
21. ¿Qué es una ruta relativa?
22. ¿Qué significa Case Sensitivity?
23. ¿Qué es un usuario Linux?
24. ¿Qué es un grupo?
25. ¿Qué representa UID?
26. ¿Qué representa GID?
27. ¿Qué son los permisos Read, Write y Execute?
28. ¿Qué es root?
29. ¿Qué hace sudo?
30. ¿Por qué no debemos desarrollar habitualmente como root?
31. ¿Qué es un proceso?
32. ¿Qué significa PID?
33. ¿Qué es una variable de entorno?
34. ¿Qué responsabilidad cumple PATH?
35. ¿Qué diferencia existe entre APT y npm?
36. ¿Por qué Linux es importante para Backend?
37. ¿Qué relación existe entre Linux y los contenedores?
38. ¿Por qué es importante conocer Linux para Cloud?
39. ¿Qué distribución elegirías para comenzar y por qué?
40. ¿Qué revisarías antes de instalar herramientas en una máquina Linux?

---

# 27. Checklist de preparación

Antes de continuar, comprueba:

- [ ] Comprendo la diferencia entre Linux Kernel y distribución.
- [ ] Puedo identificar mi distribución.
- [ ] Puedo consultar la versión del Kernel.
- [ ] Puedo identificar la arquitectura del sistema.
- [ ] Comprendo la diferencia entre Terminal y Shell.
- [ ] Conozco el significado del directorio raíz `/`.
- [ ] Identifico mi directorio personal.
- [ ] Comprendo qué son usuarios y grupos.
- [ ] Reconozco los permisos básicos.
- [ ] Comprendo cuándo se requieren privilegios administrativos.
- [ ] Puedo consultar PATH.
- [ ] Puedo comprobar si una herramienta está disponible.
- [ ] Comprendo la diferencia entre gestores de paquetes del sistema y de JavaScript.
- [ ] Tengo una estrategia inicial para organizar proyectos.
- [ ] Evito instalaciones y configuraciones innecesarias.

---

# 💡 Idea clave

Linux no debe entenderse únicamente como un conjunto de comandos.

Es una plataforma formada por diferentes capas que permiten ejecutar y administrar software.

```text
Developer
    │
    ▼
Terminal
    │
    ▼
Shell
    │
    ▼
Development Tools
    │
    ▼
System Libraries
    │
    ▼
Linux Kernel
    │
    ▼
Hardware
```

Comprender estas capas nos permite identificar responsabilidades, diagnosticar problemas y construir entornos reproducibles.

**Un ingeniero de software no necesita memorizar todos los comandos Linux desde el primer día. Necesita comprender cómo funciona el entorno y aprender a investigar cada componente de manera sistemática.**

---

# 🚀 Siguiente paso

Ahora comprendemos los fundamentos de un entorno de desarrollo Linux.

Sabemos:

- Qué es Linux.
- Qué es una distribución.
- Qué responsabilidades cumple el Kernel.
- Cómo se organiza el sistema de archivos.
- Cómo funcionan usuarios y permisos a nivel conceptual.
- Qué papel cumplen Shell y Terminal.
- Por qué Linux es relevante para Backend, Docker y Cloud.

El siguiente documento profundizará en los **gestores de paquetes del sistema Linux**.

Estudiaremos:

- Qué es un paquete del sistema.
- Qué es un repositorio de paquetes.
- Qué son los metadatos y las dependencias.
- Diferencias entre APT, DNF, pacman y otros gestores.
- Cómo consultar paquetes instalados.
- Diferencia entre actualizar índices y actualizar software.
- Buenas prácticas para instalar y mantener herramientas.
- Riesgos de repositorios externos y Scripts de instalación.

👉 [Linux Package Managers](./02-package-managers.md)