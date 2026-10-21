# Windows Subsystem for Linux (WSL)

Windows Subsystem for Linux, conocido como **WSL**, es una tecnología de Microsoft que permite utilizar entornos Linux directamente desde Windows, sin necesidad de sustituir Windows como sistema operativo principal.

Con WSL podemos trabajar con distribuciones como Ubuntu o Debian, ejecutar herramientas de línea de comandos Linux, utilizar Bash, instalar paquetes mediante gestores como APT y desarrollar aplicaciones utilizando herramientas propias del ecosistema Linux.

Sin embargo, WSL no es simplemente otra Terminal ni una versión avanzada de Git Bash.

Es una tecnología que proporciona un entorno de ejecución Linux integrado con Windows.

Comprender su funcionamiento nos ayudará a decidir cuándo utilizar desarrollo nativo en Windows y cuándo trabajar con Linux, evitando problemas de compatibilidad, rendimiento y administración de dependencias.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder:

- Explicar qué es WSL y qué problema resuelve.
- Diferenciar WSL, Git Bash, PowerShell y una máquina virtual tradicional.
- Comprender las diferencias entre WSL 1 y WSL 2.
- Explicar qué es un Kernel Linux y por qué importa.
- Comprender qué son las distribuciones Linux.
- Identificar cómo se relacionan Windows y Linux dentro de WSL.
- Comprender la separación entre sus sistemas de archivos.
- Diferenciar herramientas instaladas en Windows y en Linux.
- Identificar cómo funcionan los procesos, las redes y los puertos.
- Comprender las implicaciones para Node.js, npm y pnpm.
- Conocer la relación entre WSL y Docker.
- Evaluar cuándo utilizar WSL.
- Realizar una instalación inicial cuando sea necesaria.
- Diagnosticar problemas frecuentes.
- Aplicar buenas prácticas para entornos profesionales.

---

## 🧠 1. El problema: desarrollar para Linux desde Windows

Imagina que trabajamos en Windows y desarrollamos una aplicación Backend con Node.js.

Nuestro proyecto utiliza:

```text
Node.js
PostgreSQL
Redis
Docker
Bash Scripts
Linux Utilities
```

El equipo despliega la aplicación en servidores Linux.

Nuestro entorno local, sin embargo, utiliza Windows.

Esto no significa necesariamente que el proyecto vaya a fallar, pero pueden aparecer diferencias importantes.

Por ejemplo:

- Rutas de archivos.
- Permisos.
- Scripts.
- Dependencias nativas.
- Variables de entorno.
- Herramientas del sistema.
- Comportamiento de procesos.

### Ejemplo

Un Script utiliza:

```bash
#!/usr/bin/env bash

echo "Starting application"

export NODE_ENV=development

node server.js
```

Este Script está escrito para Bash.

PowerShell utiliza otra sintaxis para las variables de entorno.

Podríamos adaptar el Script para Windows.

Pero si nuestro equipo utiliza muchas herramientas Linux, puede resultar conveniente disponer de un entorno Linux local.

Aquí aparece WSL.

### Modelo conceptual

```text
Development Machine
        │
        └── Windows
               │
               └── WSL
                     │
                     └── Linux Environment
                            │
                            ├── Bash
                            ├── Node.js
                            ├── Git
                            ├── Package Managers
                            └── Development Tools
```

**WSL permite utilizar herramientas Linux manteniendo Windows como sistema operativo principal.**

---

## 🧩 2. ¿Qué es WSL?

WSL significa:

**Windows Subsystem for Linux**.

Es una tecnología que permite ejecutar entornos Linux integrados con Windows.

Podemos utilizarla para:

- Ejecutar comandos Linux.
- Trabajar con Shells como Bash.
- Instalar herramientas Linux.
- Ejecutar aplicaciones Linux compatibles.
- Desarrollar proyectos.
- Automatizar tareas.
- Integrar herramientas Windows y Linux.

### Modelo simplificado

```text
Windows
   ↓
WSL
   ↓
Linux Distribution
   ↓
Linux Shell
   ↓
Development Tools
```

### ¿WSL es un Shell?

No.

WSL proporciona el entorno donde puede ejecutarse un Shell Linux.

### ¿WSL es una Terminal?

No.

Podemos acceder a WSL desde Windows Terminal, VS Code u otras interfaces compatibles.

### ¿WSL es una distribución Linux?

No.

WSL proporciona la infraestructura para ejecutar distribuciones Linux.

Ubuntu y Debian son ejemplos de distribuciones.

---

## 🐧 3. ¿Qué es Linux?

Antes de comprender WSL debemos diferenciar dos conceptos.

### Linux Kernel

El **Kernel** es el componente central del sistema operativo que administra recursos y proporciona servicios a los programas.

Entre sus responsabilidades encontramos:

- Administración de procesos.
- Administración de memoria.
- Interacción con dispositivos.
- Sistemas de archivos.
- Redes.
- Interfaces de llamadas al sistema.

### Linux Distribution

Una **distribución Linux** combina el Kernel Linux con herramientas y componentes adicionales para ofrecer un entorno utilizable.

Por ejemplo:

- Ubuntu.
- Debian.
- Fedora.

### Modelo conceptual

```text
Linux Distribution
│
├── User Applications
├── Shell
├── System Utilities
├── Package Manager
├── Libraries
└── Linux Kernel
```

### ¿Por qué importa?

Porque una aplicación puede depender de características específicas del Kernel Linux.

Git Bash no proporciona ese Kernel.

WSL 2 sí utiliza un Kernel Linux real.

---

## 🏗️ 4. WSL 1 vs WSL 2

Existen dos arquitecturas principales de WSL.

Aunque comparten el objetivo de ejecutar entornos Linux en Windows, funcionan de manera diferente.

### WSL 1

WSL 1 utiliza una capa de traducción para implementar llamadas al sistema Linux sobre el Kernel Windows.

No utiliza un Kernel Linux real.

### Modelo conceptual

```text
Linux Application
        ↓
Linux System Calls
        ↓
WSL 1 Translation Layer
        ↓
Windows Kernel
```

### WSL 2

WSL 2 utiliza un Kernel Linux real mediante tecnología de virtualización ligera.

### Modelo conceptual

```text
Linux Application
        ↓
Linux System Calls
        ↓
Linux Kernel
        ↓
Virtualization Layer
        ↓
Windows
```

### Comparación

| Característica | WSL 1 | WSL 2 |
|---|---|---|
| Kernel Linux real | No | Sí |
| Arquitectura | Traducción de llamadas | Virtualización ligera |
| Compatibilidad con llamadas Linux | Limitada | Más amplia |
| Rendimiento en sistema de archivos Linux | Depende del escenario | Generalmente favorable |
| Acceso a archivos Windows | Puede ser favorable en ciertos escenarios | Puede implicar sobrecostes entre sistemas |
| Compatibilidad con herramientas Linux modernas | Más limitada | Generalmente mejor |

### ¿Cuál recomendamos?

Para nuevos entornos de desarrollo que requieren herramientas Linux modernas, **WSL 2 suele ser la opción preferible**.

Sin embargo, debemos considerar:

- Requisitos del proyecto.
- Compatibilidad del equipo.
- Políticas corporativas.
- Restricciones de virtualización.
- Necesidades de rendimiento.

---

## 🆚 5. WSL vs Virtual Machine

Una pregunta frecuente es:

**¿WSL 2 es una máquina virtual?**

WSL 2 utiliza tecnología de virtualización para ejecutar un Kernel Linux real.

Pero proporciona una experiencia de integración distinta a la de una máquina virtual tradicional administrada manualmente.

### Máquina virtual tradicional

```text
Windows Host
    ↓
Hypervisor
    ↓
Virtual Machine
    ↓
Guest Operating System
    ↓
Applications
```

Normalmente administramos aspectos como:

- Configuración de la máquina.
- Recursos asignados.
- Discos virtuales.
- Sistema operativo invitado.
- Conectividad.

### WSL 2

```text
Windows Host
    ↓
WSL Infrastructure
    ↓
Linux Kernel
    ↓
Linux Distribution
    ↓
Applications
```

WSL automatiza parte importante de la integración y administración del entorno.

### Diferencia fundamental

WSL 2 utiliza virtualización, pero está diseñado específicamente para integrar entornos Linux con Windows.

**No debemos confundir una experiencia integrada con la ausencia de virtualización.**

---

## 🆚 6. WSL vs Git Bash

Recordemos Git Bash.

Git Bash proporciona Bash y herramientas Unix-like sobre Windows.

WSL permite ejecutar un entorno Linux.

### Comparación

| Característica | Git Bash | WSL 2 |
|---|---|---|
| Bash | Sí | Según distribución |
| Kernel Linux real | No | Sí |
| Herramientas Linux nativas | Compatibilidad limitada | Sí |
| Gestor de paquetes Linux | No como distribución Linux | Sí |
| Sistema de archivos Linux | No independiente | Sí |
| Binarios Linux | No directamente como entorno Linux | Sí |
| Integración con Windows | Sí | Sí |

### Ejemplo

En Git Bash podemos ejecutar:

```bash
git status
```

En WSL también:

```bash
git status
```

Pero el ejecutable utilizado puede ser diferente.

```text
Git Bash
   ↓
Git for Windows
```

```text
WSL
   ↓
Git for Linux
```

### Principio

**Que dos entornos acepten el mismo comando no significa que utilicen el mismo ejecutable ni el mismo sistema operativo.**

---

## 🪟 7. Arquitectura de un entorno Windows + WSL

Imagina una computadora con Windows 11 y Ubuntu instalado mediante WSL 2.

Podemos representarla así:

```text
Windows Computer
│
├── Windows Environment
│   │
│   ├── PowerShell
│   ├── Git for Windows
│   ├── Node.js for Windows
│   └── Windows Applications
│
└── WSL 2 Environment
    │
    └── Ubuntu
        │
        ├── Bash
        ├── Git for Linux
        ├── Node.js for Linux
        ├── APT
        └── Linux Applications
```

### ¿Qué debemos observar?

Tenemos dos entornos de ejecución diferentes.

Aunque comparten la misma computadora, cada uno tiene sus propias herramientas y configuraciones.

### Ejemplo

En PowerShell:

```powershell
node --version
```

En Ubuntu:

```bash
node --version
```

Ambos comandos pueden devolver versiones distintas.

Incluso uno puede funcionar mientras el otro no.

### ¿Es un problema?

No necesariamente.

Puede ser perfectamente válido si comprendemos y administramos cada entorno.

---

## 📦 8. ¿Qué son las distribuciones WSL?

WSL permite utilizar distribuciones Linux compatibles.

Por ejemplo:

- Ubuntu.
- Debian.
- Otras distribuciones disponibles mediante mecanismos admitidos.

### ¿Qué contiene una distribución?

Entre sus componentes encontramos:

```text
Linux Distribution
│
├── File System
├── User Accounts
├── Shell
├── System Libraries
├── Package Manager
└── Installed Applications
```

### Ejemplo con Ubuntu

Ubuntu utiliza habitualmente APT para administrar paquetes del sistema.

```bash
apt --version
```

### ¿APT es equivalente a npm?

No.

APT administra paquetes de la distribución Linux.

npm administra paquetes del ecosistema JavaScript.

### Modelo conceptual

```text
Ubuntu
   ↓
APT
   ↓
Linux System Packages
```

```text
Node.js Project
   ↓
pnpm
   ↓
JavaScript Dependencies
```

Esta distinción será importante durante todo nuestro Mastery.

---

## 🔎 9. Inspeccionar WSL desde Windows

Antes de instalar cualquier componente debemos comprobar si WSL ya está disponible.

Desde PowerShell:

```powershell
wsl --status
```

Este comando consulta información sobre la configuración de WSL.

### Consultar distribuciones

```powershell
wsl --list --verbose
```

También podemos utilizar:

```powershell
wsl -l -v
```

### Ejemplo ilustrativo

```text
  NAME       STATE       VERSION
* Ubuntu     Stopped     2
```

### Interpretación

- `NAME`: distribución.
- `STATE`: estado actual.
- `VERSION`: versión de arquitectura WSL utilizada.

### ¿Qué significa Stopped?

Que la distribución no está ejecutándose en ese momento.

No significa que esté desinstalada.

### Importante

Los resultados dependen de la configuración real de nuestra computadora.

---

## ⚙️ 10. Instalar WSL

La instalación depende de la versión de Windows y de los requisitos del sistema.

En versiones compatibles de Windows, Microsoft proporciona el comando:

```powershell
wsl --install
```

Este comando puede habilitar componentes necesarios e instalar una distribución predeterminada.

### Antes de ejecutarlo

Debemos comprobar:

1. Versión de Windows.
2. Compatibilidad del equipo.
3. Disponibilidad de virtualización.
4. Permisos necesarios.
5. Políticas corporativas.
6. Si WSL ya está instalado.

### ¿Debemos instalarlo inmediatamente?

No.

Si nuestros proyectos funcionan correctamente mediante desarrollo nativo en Windows, WSL puede no ser necesario.

### Instalación opcional

Si hemos decidido utilizar WSL y nuestro equipo cumple los requisitos, podemos seguir las instrucciones oficiales de Microsoft:

https://learn.microsoft.com/windows/wsl/install

### Advertencia

`wsl --install` modifica la configuración del sistema y puede requerir reiniciar Windows.

No forma parte de nuestra práctica de inspección no destructiva.

---

## 🐧 11. Iniciar una distribución Linux

Si tenemos Ubuntu instalado, podemos iniciar la distribución mediante:

```powershell
wsl -d Ubuntu
```

El nombre debe coincidir con una distribución disponible.

También podemos abrirla desde un Profile de Windows Terminal.

### Modelo conceptual

```text
Windows Terminal
       ↓
Ubuntu Profile
       ↓
WSL
       ↓
Ubuntu
       ↓
Bash
```

### ¿Qué ocurre al iniciar?

Ingresamos a una sesión dentro del entorno Linux.

Podemos ejecutar:

```bash
pwd
```

Y:

```bash
uname -a
```

### Importante

La sesión utiliza herramientas Linux, aunque la interfaz gráfica de Terminal continúe siendo una aplicación Windows.

---

## 👤 12. Usuarios en Windows y Linux

Windows y Linux utilizan modelos de cuentas y permisos diferentes.

### Usuario Windows

Podríamos tener:

```text
C:\Users\developer
```

### Usuario Linux

Dentro de Ubuntu:

```text
/home/developer
```

### ¿Son el mismo usuario?

No necesariamente.

Aunque tengan el mismo nombre, pertenecen a sistemas de administración de usuarios diferentes.

### Consultar usuario Linux

```bash
whoami
```

### Consultar directorio personal

```bash
echo "$HOME"
```

### ¿Por qué importa?

Porque permisos, configuraciones y archivos pueden pertenecer a usuarios distintos.

### Ejemplo

```text
Windows User
    ↓
Windows Permissions
```

```text
Linux User
    ↓
Linux Permissions
```

No debemos asumir que los permisos se trasladan automáticamente entre ambos entornos.

---

## 📁 13. Sistemas de archivos: Windows y Linux

Este es uno de los temas más importantes para trabajar correctamente con WSL.

En Windows tenemos rutas como:

```text
C:\Users\developer\Projects
```

Dentro de WSL podemos encontrar rutas Linux como:

```text
/home/developer/projects
```

También podemos acceder a determinadas unidades Windows mediante puntos de montaje.

Por ejemplo:

```text
/mnt/c/Users/developer/Projects
```

### Modelo conceptual

```text
Windows File System
│
└── C:\Users\developer\Projects
           ↑
           │
      WSL Access
           │
           ↓
/mnt/c/Users/developer/Projects
```

### Sistema de archivos Linux

WSL 2 utiliza normalmente un sistema de archivos Linux almacenado en un disco virtual administrado por WSL.

Por ejemplo:

```text
/home/developer/projects
```

### ¿Por qué importa?

Porque acceder a archivos a través de la frontera Windows–Linux puede tener características de rendimiento y permisos diferentes.

---

## 🚀 14. ¿Dónde guardar nuestros proyectos?

Esta es una decisión importante.

### Opción A — Proyecto en Windows

```text
C:\Users\developer\Projects\my-app
```

Acceso desde WSL:

```bash
cd /mnt/c/Users/developer/Projects/my-app
```

### Opción B — Proyecto en Linux

```text
/home/developer/projects/my-app
```

Acceso desde WSL:

```bash
cd ~/projects/my-app
```

### ¿Cuál recomendamos?

Si utilizaremos principalmente herramientas Linux dentro de WSL, generalmente conviene almacenar el proyecto en el sistema de archivos Linux.

### ¿Por qué?

Porque muchas operaciones de desarrollo realizan gran cantidad de accesos al sistema de archivos.

Por ejemplo:

```text
Dependency Installation
File Watching
Build Processes
Testing
Development Servers
```

Trabajar directamente en el sistema de archivos Linux suele ofrecer un comportamiento y rendimiento más adecuados para herramientas Linux.

### Regla práctica

```text
Windows Tools
     ↓
Prefer Windows File System
```

```text
Linux Tools inside WSL
     ↓
Prefer Linux File System
```

No es una regla absoluta, pero constituye un buen punto de partida.

---

## 🔗 15. Acceder a archivos Linux desde Windows

Windows puede acceder a archivos de distribuciones WSL mediante mecanismos de integración.

Por ejemplo, desde el Explorador de archivos podemos utilizar rutas de red especiales como:

```text
\\wsl.localhost\
```

Y acceder a una distribución concreta.

### Ejemplo conceptual

```text
Windows Explorer
       ↓
WSL Integration
       ↓
Linux Distribution
       ↓
Linux Files
```

### ¿Podemos abrir proyectos Linux desde VS Code?

Sí.

VS Code dispone de integración para trabajar con proyectos dentro de WSL.

### Ejemplo

Desde una sesión WSL correctamente configurada:

```bash
code .
```

Puede abrir el directorio actual mediante la integración correspondiente.

### Precaución

No debemos manipular directamente los archivos internos del disco virtual de WSL mediante rutas de almacenamiento no soportadas.

Debemos utilizar los mecanismos oficiales de acceso.

---

## 🧭 16. PATH y variables de entorno en WSL

Dentro de Linux también existe `PATH`.

Podemos consultarlo mediante:

```bash
echo "$PATH"
```

### ¿Es el mismo PATH de Windows?

No necesariamente.

WSL construye un entorno Linux con sus propias variables y mecanismos de integración.

En determinadas configuraciones puede incorporar rutas de Windows.

### Ejemplo conceptual

```text
Windows PATH
      │
      └── Windows Executables
```

```text
Linux PATH
      │
      ├── Linux Directories
      └── Optional Windows Integration
```

### ¿Por qué importa?

Porque podemos ejecutar accidentalmente herramientas Windows desde WSL cuando esperábamos utilizar versiones Linux.

### Diagnóstico

```bash
command -v node
```

```bash
command -v git
```

Después:

```bash
node --version
```

```bash
git --version
```

### Principio

**Debemos comprobar qué ejecutable se está utilizando, no asumirlo por el nombre del comando.**

---

## 🟢 17. Node.js dentro de WSL

Podemos instalar Node.js dentro de una distribución Linux WSL.

### Modelo conceptual

```text
Windows
   ↓
WSL 2
   ↓
Ubuntu
   ↓
Node.js for Linux
   ↓
JavaScript Application
```

### ¿Es el mismo Node.js instalado en Windows?

No.

Aunque ambos ejecuten JavaScript, son instalaciones correspondientes a entornos diferentes.

### Ejemplo

En Windows:

```powershell
node --version
```

En WSL:

```bash
node --version
```

Podrían mostrar versiones diferentes.

### ¿Debemos instalar Node.js en ambos?

Solamente si nuestros flujos de trabajo lo requieren.

Si desarrollamos exclusivamente dentro de WSL, podemos utilizar una instalación Linux.

Si también desarrollamos proyectos nativos Windows, podríamos necesitar una instalación Windows.

### Recomendación

Utilizar un gestor de versiones compatible con cada entorno cuando trabajemos con proyectos que requieren diferentes versiones.

Profundizaremos en esto en:

```text
04-runtime-management
```

---

## 📦 18. npm, pnpm y dependencias nativas

Los Package Managers de JavaScript pueden utilizarse dentro de WSL.

Por ejemplo:

```bash
npm --version
```

O:

```bash
pnpm --version
```

si están instalados.

### ¿Qué debemos evitar?

Mezclar indiscriminadamente dependencias instaladas para Windows con dependencias instaladas para Linux.

### ¿Por qué?

Porque algunos paquetes contienen componentes específicos del sistema operativo.

Por ejemplo:

```text
Native Modules
Platform-specific Binaries
Compiled Dependencies
```

### Modelo conceptual

```text
Windows Node.js
      ↓
Windows Dependencies
```

```text
Linux Node.js
      ↓
Linux Dependencies
```

### Ejemplo

Si instalamos dependencias desde PowerShell utilizando Node.js para Windows, después no debemos asumir que todos los archivos generados funcionarán sin problemas con Node.js para Linux.

### Buena práctica

Elegir un entorno principal para instalar dependencias y ejecutar el proyecto.

Esto reduce inconsistencias.

---

## 🐳 19. WSL y Docker

Docker es una tecnología ampliamente utilizada para ejecutar aplicaciones en contenedores.

En Windows, Docker Desktop puede utilizar un Backend basado en WSL 2.

### Modelo conceptual

```text
Windows
   ↓
Docker Desktop
   ↓
WSL 2 Backend
   ↓
Linux Containers
```

### ¿Qué aporta?

Permite trabajar con contenedores Linux desde una computadora Windows mediante una integración administrada por Docker Desktop.

### ¿WSL es Docker?

No.

WSL proporciona un entorno Linux.

Docker proporciona herramientas para construir, distribuir y ejecutar contenedores.

### ¿Docker requiere siempre WSL?

No.

Existen diferentes configuraciones y plataformas para utilizar Docker.

### ¿Debemos instalar Docker ahora?

No.

Lo estudiaremos cuando abordemos los fundamentos de contenedores y DevOps.

### Idea importante

**WSL puede formar parte de la infraestructura utilizada por Docker en Windows, pero no reemplaza Docker.**

---

## 🌐 20. Networking entre Windows y WSL

Las aplicaciones dentro de WSL pueden utilizar redes.

Por ejemplo, una aplicación Node.js puede escuchar en un puerto.

```text
Linux Application
       ↓
Port 3000
```

### Ejemplo conceptual

```text
Windows Browser
       ↓
localhost:3000
       ↓
WSL Networking Integration
       ↓
Linux Development Server
```

En configuraciones habituales de WSL 2, Windows puede acceder a servicios Linux mediante `localhost`.

Sin embargo, el comportamiento exacto depende de la configuración de red, la versión de WSL y las interfaces en las que escucha la aplicación.

### ¿Qué debemos comprender?

- `localhost` representa el entorno local desde la perspectiva del proceso.
- Windows y WSL tienen mecanismos de integración de red.
- No todos los escenarios de conectividad son idénticos.
- El acceso desde otros dispositivos puede requerir configuraciones adicionales.

### Ejemplo

Una aplicación puede escuchar en:

```text
127.0.0.1:3000
```

O:

```text
0.0.0.0:3000
```

Estas direcciones no representan lo mismo.

`127.0.0.1` es una dirección de Loopback.

`0.0.0.0`, cuando se utiliza como dirección de escucha, indica generalmente todas las interfaces IPv4 disponibles en ese entorno.

### Precaución

No debemos exponer servicios en interfaces adicionales sin comprender las implicaciones de seguridad.

---

## ⚙️ 21. Administrar distribuciones WSL

Desde PowerShell podemos consultar las distribuciones instaladas.

```powershell
wsl --list --verbose
```

### Iniciar una distribución

```powershell
wsl -d Ubuntu
```

### Apagar las instancias de WSL

```powershell
wsl --shutdown
```

Este comando detiene las distribuciones y la infraestructura de WSL en ejecución.

Puede interrumpir procesos y servicios activos.

### Consultar ayuda

```powershell
wsl --help
```

### Precaución importante

Existen comandos de administración que pueden eliminar distribuciones y sus datos.

Por ejemplo:

```powershell
wsl --unregister <DistributionName>
```

Este comando elimina el registro de la distribución y sus datos asociados.

**No debemos ejecutarlo como método genérico de Troubleshooting.**

Antes de operaciones destructivas debemos verificar respaldos y comprender su impacto.

---

## 💾 22. Recursos y consumo de WSL

WSL 2 utiliza recursos de la computadora para ejecutar el entorno Linux.

Entre ellos:

- Memoria.
- CPU.
- Almacenamiento.
- Recursos de virtualización.

### ¿Consume recursos aunque no estemos trabajando?

Depende de las distribuciones, procesos y configuración.

### ¿Podemos configurar recursos?

WSL dispone de mecanismos de configuración para determinados parámetros de la infraestructura.

Por ejemplo, mediante archivos como:

```text
.wslconfig
```

En configuraciones compatibles, este archivo puede controlar opciones globales de WSL 2.

### Diferencia importante

No debemos confundir:

```text
.wslconfig
```

con:

```text
wsl.conf
```

El primero se utiliza para determinadas configuraciones globales de WSL desde Windows.

El segundo permite configurar comportamientos de una distribución WSL desde Linux.

### ¿Debemos modificarlos ahora?

No.

Primero debemos comprender el comportamiento predeterminado y determinar si existe una necesidad real.

---

## 🔐 23. Seguridad y permisos

WSL combina dos entornos con modelos de seguridad relacionados, pero diferentes.

### Windows

Utiliza mecanismos como:

```text
Windows Accounts
NTFS Permissions
Corporate Policies
```

### Linux

Utiliza mecanismos como:

```text
Linux Users
Groups
File Permissions
sudo
```

### ¿Qué es sudo?

`sudo` permite ejecutar determinados comandos con privilegios de otro usuario, habitualmente con privilegios administrativos, cuando la configuración lo autoriza.

### Ejemplo

En Ubuntu:

```bash
sudo apt update
```

Este comando solicita actualizar los índices de paquetes mediante APT y puede requerir privilegios elevados.

### ¿Debemos utilizar sudo para todo?

No.

Debemos aplicar el principio de privilegio mínimo.

### Importante

Tener acceso a `sudo` dentro de Linux no significa que todos los mecanismos de seguridad de Windows desaparezcan.

Tampoco debemos tratar WSL como un entorno aislado completamente de Windows.

Existe integración entre ambos sistemas y debemos proteger los recursos compartidos.

---

## 🏢 24. WSL en entornos corporativos

En organizaciones podemos encontrar restricciones relacionadas con:

- Virtualización.
- Instalación de distribuciones.
- Acceso a redes.
- VPN.
- Proxies.
- Certificados.
- Seguridad del endpoint.
- Herramientas aprobadas.
- Políticas de administración.

### Ejemplo

```text
Corporate Windows Machine
        ↓
WSL 2
        ↓
Ubuntu
        ↓
Node.js
        ↓
Private Package Registry
```

### ¿Qué puede fallar?

Por ejemplo:

```text
DNS Resolution
Proxy Configuration
TLS Certificates
VPN Routing
Registry Authentication
```

### ¿Qué debemos hacer?

Identificar si el problema pertenece a:

1. Windows.
2. WSL.
3. La distribución Linux.
4. La red.
5. El Package Manager.
6. La configuración del proyecto.

### Principio

**No debemos desactivar controles de seguridad para solucionar problemas de conectividad sin comprender la causa.**

---

## 🧪 25. Práctica: WSL Environment Audit

Esta práctica está diseñada para inspeccionar un entorno WSL existente.

No requiere instalar ni eliminar distribuciones.

Si WSL no está disponible, puedes estudiar los resultados esperados de forma conceptual.

### Parte A — Desde Windows

Abre PowerShell.

#### Step 1 — Consultar WSL

```powershell
wsl --status
```

#### Step 2 — Consultar distribuciones

```powershell
wsl --list --verbose
```

#### Step 3 — Consultar ayuda

```powershell
wsl --help
```

### Parte B — Dentro de Linux

Si tienes una distribución instalada, ingresa a ella.

#### Step 4 — Consultar Kernel

```bash
uname -r
```

#### Step 5 — Consultar distribución

```bash
cat /etc/os-release
```

#### Step 6 — Consultar usuario

```bash
whoami
```

#### Step 7 — Consultar directorio personal

```bash
echo "$HOME"
```

#### Step 8 — Consultar directorio actual

```bash
pwd
```

#### Step 9 — Consultar PATH

```bash
printf '%s\n' "$PATH" | tr ':' '\n'
```

#### Step 10 — Consultar Git

```bash
command -v git
```

Si está disponible:

```bash
git --version
```

#### Step 11 — Consultar Node.js

```bash
command -v node
```

Si está disponible:

```bash
node --version
```

#### Step 12 — Consultar sistema de archivos

```bash
df -h
```

#### Step 13 — Consultar rutas Windows

Si existe el montaje habitual:

```bash
ls /mnt/c
```

### Parte C — Documentar resultados

| Component | Result |
|---|---|
| WSL Available | |
| WSL Version | |
| Linux Distribution | |
| Linux Kernel | |
| Linux User | |
| Linux Home | |
| Git Available | |
| Node.js Available | |
| Linux File System | |
| Windows Mount Available | |

### Reflexión

Responde:

1. ¿Qué versión de WSL utiliza tu distribución?
2. ¿Qué distribución Linux tienes?
3. ¿Qué Kernel utiliza?
4. ¿Cuál es tu usuario Linux?
5. ¿Dónde está tu directorio personal?
6. ¿Git está instalado dentro de Linux?
7. ¿Node.js está instalado dentro de Linux?
8. ¿Qué diferencias existen respecto a Windows?
9. ¿Dónde guardarías tus proyectos?
10. ¿Necesitas WSL para tu flujo de trabajo actual?

---

## 🛠️ 26. Troubleshooting: problemas frecuentes

### Problema A — WSL Not Installed

Ejecutamos:

```powershell
wsl --status
```

Pero el entorno no está disponible o informa que faltan componentes.

### Posibles causas

- WSL no está instalado.
- Faltan características necesarias.
- La versión de Windows no cumple requisitos.
- Existen restricciones corporativas.

### Diagnóstico

Consultar la versión de Windows y los requisitos oficiales.

No debemos habilitar componentes sin comprobar la compatibilidad.

---

### Problema B — Virtualization Not Available

WSL 2 no puede iniciar correctamente.

### Posibles causas

- Virtualización deshabilitada.
- Requisitos del sistema no cumplidos.
- Restricciones de una máquina virtual corporativa.
- Configuración incompatible.

### Diagnóstico

Comprobar las capacidades de virtualización del equipo y la documentación correspondiente.

### Importante

En una máquina virtual corporativa, puede ser necesaria una configuración de virtualización anidada o pueden existir restricciones que impidan utilizar WSL 2.

No debemos modificar configuraciones corporativas sin autorización.

---

### Problema C — Node.js Works on Windows but Not WSL

En PowerShell:

```powershell
node --version
```

Funciona.

En WSL:

```bash
node --version
```

No funciona.

### Posible causa

Node.js no está instalado en Linux o no se encuentra mediante su resolución de comandos.

### Diagnóstico

```bash
command -v node
```

```bash
echo "$PATH"
```

### Solución

Determinar si necesitamos una instalación Linux de Node.js.

No debemos asumir que la instalación Windows cumple automáticamente esa responsabilidad.

---

### Problema D — Slow File Operations

Las instalaciones de dependencias o Builds son lentos.

### Posible causa

El proyecto está almacenado en el sistema de archivos Windows, pero se ejecuta principalmente mediante herramientas Linux dentro de WSL.

### Diagnóstico

```bash
pwd
```

Si encontramos una ruta como:

```text
/mnt/c/Users/developer/Projects/my-app
```

debemos considerar si la ubicación es apropiada.

### Posible solución

Para flujos Linux, evaluar trabajar en el sistema de archivos Linux.

No debemos mover proyectos sin considerar respaldos, permisos y configuraciones existentes.

---

### Problema E — Permission Denied

Una operación falla por permisos.

### Diagnóstico

```bash
ls -l
```

```bash
whoami
```

### Posibles causas

- Permisos Linux.
- Propiedad incorrecta.
- Restricciones de archivos Windows montados.
- Configuración del sistema de archivos.

### Solución

Identificar el recurso y el modelo de permisos correspondiente.

No debemos aplicar `sudo` indiscriminadamente.

---

### Problema F — Cannot Access Development Server

Una aplicación funciona dentro de WSL, pero no podemos acceder desde Windows.

### Posibles causas

- El servidor no está ejecutándose.
- El puerto es incorrecto.
- La aplicación escucha en otra interfaz.
- Existe una configuración de red particular.
- Hay restricciones de Firewall o seguridad.

### Diagnóstico

Primero debemos verificar que la aplicación esté funcionando dentro de WSL.

Después investigar el puerto y la configuración de red.

### Precaución

No debemos abrir puertos o desactivar el Firewall sin comprender las implicaciones.

---

### Problema G — Docker Integration Not Working

Docker Desktop no puede utilizar correctamente WSL.

### Posibles causas

- Integración deshabilitada.
- WSL desactualizado.
- Distribución incompatible.
- Configuración incorrecta.
- Restricciones corporativas.

### Diagnóstico

Revisar las versiones y configuraciones compatibles de Docker Desktop y WSL.

No debemos eliminar distribuciones como primer intento de reparación.

---

## 🧭 27. ¿Cuándo recomendamos WSL?

### Caso A — Frontend React

Si desarrollamos una aplicación React y todas nuestras herramientas funcionan correctamente en Windows, podemos trabajar de manera nativa.

WSL es opcional.

### Caso B — Backend Node.js

Si el proyecto utiliza herramientas Linux, Scripts Bash y dependencias nativas, WSL puede resultar conveniente.

### Caso C — Docker y contenedores Linux

WSL 2 puede formar parte de una configuración práctica para trabajar con Docker Desktop en Windows.

### Caso D — Cloud y DevOps

Si estamos aprendiendo herramientas y conceptos asociados a servidores Linux, WSL puede proporcionar un entorno útil para practicar.

### Caso E — Máquina virtual corporativa

Si trabajamos dentro de una VM administrada, debemos comprobar si WSL está permitido y si la virtualización necesaria está disponible.

### Modelo de decisión

```text
Project Requirements
        │
        ├── Native Windows Compatible
        │       ↓
        │   Windows Development
        │
        ├── Bash Compatibility Only
        │       ↓
        │   Consider Git Bash
        │
        └── Linux Environment Required
                ↓
             WSL 2
```

### Recomendación profesional

No necesitamos WSL para demostrar que nuestro entorno es avanzado.

Lo necesitamos cuando resuelve un problema real de compatibilidad, herramientas o flujo de trabajo.

---

## ⚠️ 28. Errores comunes

### 1. Confundir WSL con una Terminal

WSL proporciona un entorno Linux; Windows Terminal es una aplicación para interactuar con sesiones.

### 2. Pensar que WSL es Git Bash

Utilizan arquitecturas diferentes.

### 3. Pensar que WSL 1 y WSL 2 funcionan igual

Sus mecanismos internos son distintos.

### 4. Suponer que WSL 2 no utiliza virtualización

Utiliza tecnología de virtualización ligera.

### 5. Pensar que Ubuntu y WSL son lo mismo

Ubuntu es una distribución; WSL proporciona la infraestructura.

### 6. Instalar Node.js solamente en Windows y esperar que funcione como instalación Linux

Son entornos diferentes.

### 7. Mezclar dependencias nativas de Windows y Linux

Puede provocar incompatibilidades.

### 8. Guardar proyectos Linux en ubicaciones poco adecuadas

Puede afectar al rendimiento y comportamiento de herramientas.

### 9. Ignorar la diferencia entre permisos Windows y Linux

Pueden aplicarse mecanismos distintos.

### 10. Pensar que WSL es Docker

Son tecnologías diferentes.

### 11. Modificar configuraciones de red sin comprenderlas

Puede generar problemas de conectividad o seguridad.

### 12. Utilizar sudo para resolver cualquier error

Puede introducir problemas adicionales.

### 13. Eliminar una distribución para solucionar errores menores

Puede provocar pérdida de datos.

### 14. Instalar WSL sin considerar restricciones corporativas

Puede no estar permitido o no ser compatible con el equipo.

---

## 🧠 29. Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es WSL?
2. ¿Qué problema resuelve?
3. ¿WSL es una Terminal?
4. ¿WSL es un Shell?
5. ¿Qué es un Kernel?
6. ¿Qué es una distribución Linux?
7. ¿Qué diferencia existe entre WSL 1 y WSL 2?
8. ¿WSL 2 utiliza un Kernel Linux real?
9. ¿WSL 2 utiliza virtualización?
10. ¿Qué diferencia existe entre WSL y una máquina virtual tradicional?
11. ¿Qué diferencia existe entre WSL y Git Bash?
12. ¿Qué es Ubuntu?
13. ¿Qué es APT?
14. ¿Qué diferencia existe entre APT y pnpm?
15. ¿Windows y WSL utilizan las mismas instalaciones de Node.js?
16. ¿Qué representa `/home/developer`?
17. ¿Qué representa `/mnt/c`?
18. ¿Dónde conviene guardar proyectos que ejecutaremos principalmente con herramientas Linux?
19. ¿Por qué puede ser problemático compartir `node_modules` entre Windows y Linux?
20. ¿Qué relación existe entre WSL y Docker?
21. ¿Qué significa `localhost`?
22. ¿Qué diferencia existe entre `127.0.0.1` y `0.0.0.0` al escuchar conexiones?
23. ¿Qué hace `wsl --list --verbose`?
24. ¿Qué hace `wsl --shutdown`?
25. ¿Por qué `wsl --unregister` requiere especial precaución?
26. ¿Qué diferencia existe entre `.wslconfig` y `wsl.conf`?
27. ¿Qué investigarías si Node.js funciona en Windows, pero no en WSL?
28. ¿Qué investigarías si una aplicación es lenta dentro de WSL?
29. ¿Qué restricciones pueden existir en una VM corporativa?
30. ¿Cuándo recomendarías WSL y cuándo desarrollo nativo?

---

## 💡 Idea clave

WSL permite trabajar con entornos Linux dentro de Windows.

```text
Windows
   │
   ├── Native Development
   │      ├── PowerShell
   │      ├── Windows Tools
   │      └── Windows Runtimes
   │
   └── WSL 2
          ├── Linux Kernel
          ├── Linux Distribution
          ├── Linux Shell
          ├── Linux Tools
          └── Linux Runtimes
```

La integración entre Windows y Linux es una ventaja importante, pero no elimina las diferencias entre ambos entornos.

**Para trabajar profesionalmente con WSL debemos comprender dónde se ejecutan nuestros procesos, dónde están nuestros archivos, qué herramientas utilizamos y qué sistema operativo administra cada recurso.**

---

## 🚀 Siguiente paso

Ahora comprendemos cómo funciona WSL y cuándo utilizarlo.

Conocemos las diferencias entre:

- Desarrollo nativo Windows.
- PowerShell.
- Git Bash.
- WSL 1.
- WSL 2.
- Distribuciones Linux.

El siguiente documento cerrará nuestra sección de Windows mediante un enfoque práctico de diagnóstico.

Estudiaremos los problemas más frecuentes relacionados con:

- `PATH`.
- Permisos.
- PowerShell.
- Git Bash.
- WSL.
- Versiones de herramientas.
- Variables de entorno.
- Redes corporativas.
- Dependencias.
- Compatibilidad entre Windows y Linux.

👉 [Common Windows Issues](./06-common-windows-issues.md)