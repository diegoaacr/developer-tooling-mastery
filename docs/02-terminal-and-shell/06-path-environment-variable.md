# PATH Environment Variable

> **Developer Tooling Mastery 2026 — Module 02**
>
> **Topic 06:** PATH Environment Variable  
> **Level:** Beginner → Professional Foundations  
> **Prerequisites:** [05 — Environment Variables](./05-environment-variables.md)

---

## 1. Introducción

Imagina que acabas de instalar Node.js en tu computadora.

Abres la terminal y ejecutas:

```bash
node --version
```

Esperas obtener:

```text
v22.16.0
```

Pero aparece un error:

```text
command not found: node
```

O quizás Node.js funciona, pero devuelve:

```text
v20.19.0
```

cuando esperabas utilizar otra versión.

¿Por qué ocurre esto?

Podríamos pensar que instalar un programa debería ser suficiente para ejecutarlo desde cualquier ubicación.

Sin embargo, existe un mecanismo que conecta los comandos que escribimos con los programas instalados en nuestra computadora.

Ese mecanismo está relacionado con la variable de entorno **PATH**.

PATH es una de las piezas fundamentales del Developer Tooling porque interviene en la localización de herramientas como:

- `git`
- `node`
- `npm`
- `pnpm`
- `python`
- `docker`
- `code`

También resulta esencial para comprender cómo funcionan los gestores de versiones, las herramientas instaladas globalmente y los entornos reproducibles.

Nuestro objetivo será entender **por qué funciona PATH, cómo participa en la ejecución de comandos y cómo diagnosticar problemas sin modificar innecesariamente la configuración del sistema**.

---

# 2. Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Explicar qué es un Executable.
2. Diferenciar un Command de un Executable.
3. Comprender qué es PATH.
4. Explicar cómo se utiliza PATH para localizar programas.
5. Comprender Command Resolution.
6. Diferenciar comandos internos y externos.
7. Interpretar el orden de búsqueda.
8. Consultar PATH en macOS, Linux y Windows.
9. Identificar qué ejecutable utiliza un comando.
10. Comprender `which`, `type`, `command -v`, `where.exe` y `Get-Command`.
11. Diagnosticar errores como `command not found`.
12. Comprender los conflictos entre versiones.
13. Diferenciar instalaciones locales y globales.
14. Reconocer cómo interactúan PATH y los gestores de versiones.
15. Modificar PATH temporalmente de manera segura.
16. Reconocer riesgos de seguridad relacionados con PATH.
17. Aplicar buenas prácticas profesionales.

---

# 3. El problema: ¿cómo encuentra la terminal un programa?

Supongamos que tenemos esta estructura:

```text
computer/
└── tools/
    ├── git
    ├── node
    └── pnpm
```

Queremos ejecutar Node.js.

Una posibilidad sería escribir su ruta completa:

```bash
/opt/tools/node --version
```

Siempre que exista un ejecutable en esa ubicación y tengamos los permisos necesarios, el sistema podrá intentar ejecutarlo.

Pero normalmente escribimos:

```bash
node --version
```

Observa la diferencia.

En el primer ejemplo indicamos explícitamente dónde está el programa.

En el segundo solamente proporcionamos su nombre.

**¿Cómo sabe el Shell dónde buscarlo?**

Aquí interviene PATH.

---

# 4. ¿Qué es un Executable?

Un **Executable** es un archivo o recurso que el sistema puede ejecutar como programa, bajo las reglas de su sistema operativo y entorno.

Puede tratarse de:

- Un programa compilado.
- Un Script.
- Un archivo ejecutable interpretado por otro programa.
- Un archivo de comandos.
- Un Wrapper que inicia otra herramienta.

## 4.1 Ejemplo conceptual

```text
node
```

Puede representar un programa ejecutable de Node.js.

```text
git
```

Puede representar el ejecutable de Git.

## 4.2 ¿Todos los archivos son ejecutables?

No.

Un archivo de texto como:

```text
README.md
```

no es automáticamente un programa ejecutable.

La posibilidad de ejecutar un archivo depende de factores como:

- Su formato.
- El sistema operativo.
- Los permisos.
- El intérprete necesario.
- Las reglas del entorno.

## 4.3 ¿Qué es un Script ejecutable?

En sistemas Unix-like, un Script puede comenzar con una línea como:

```bash
#!/usr/bin/env bash
```

Esta línea se conoce como **Shebang**.

Indica qué intérprete debe utilizarse cuando el sistema ejecuta el Script mediante el mecanismo correspondiente.

No todos los Scripts se ejecutan directamente ni todos los sistemas utilizan las mismas reglas.

### Idea clave

**Un Executable es el recurso que se ejecuta; el comando es la instrucción que escribimos para solicitar una operación.**

---

# 5. Command vs Executable

Es importante distinguir ambos conceptos.

## 5.1 Command

Un **Command** es una instrucción que proporcionamos al Shell.

Ejemplo:

```bash
node --version
```

Contiene:

```text
node       --version
 │             │
 │             └── Argument
 │
 └──────────────── Command Name
```

## 5.2 Executable

Es el programa que puede terminar ejecutándose como resultado de interpretar ese comando.

Por ejemplo:

```text
/opt/homebrew/bin/node
```

## 5.3 ¿Siempre un comando ejecuta un archivo externo?

No.

Un comando también puede corresponder a:

- Un Shell Builtin.
- Una función.
- Un Alias.
- Una palabra reservada.
- Un programa externo.

## 5.4 Ejemplo

```bash
cd projects
```

En Bash y Zsh, `cd` es normalmente un Shell Builtin.

No necesita iniciar un programa externo para cambiar el directorio del propio Shell.

En cambio:

```bash
git status
```

normalmente utiliza un ejecutable externo de Git.

### Idea clave

**No todos los comandos son programas externos, por lo que PATH no participa de la misma manera en todos ellos.**

---

# 6. ¿Qué es PATH?

**PATH** es una variable de entorno que contiene una lista de directorios donde determinados intérpretes de comandos buscan programas ejecutables.

Ejemplo en macOS o Linux:

```text
/usr/local/bin:/usr/bin:/bin
```

Esta cadena representa varios directorios.

```text
/usr/local/bin
/usr/bin
/bin
```

El Shell puede consultarlos cuando necesita localizar un comando externo cuyo nombre no incluye una ruta explícita.

## 6.1 Modelo conceptual

```text
User
 │
 ▼
node --version
 │
 ▼
Shell
 │
 ▼
Command Resolution
 │
 ▼
PATH Directories
 │
 ├── /usr/local/bin
 ├── /usr/bin
 └── /bin
 │
 ▼
Matching Executable
 │
 ▼
Execution
```

## 6.2 ¿PATH contiene los programas?

No.

PATH contiene ubicaciones de búsqueda.

Los ejecutables se encuentran en el sistema de archivos.

## 6.3 ¿PATH instala herramientas?

No.

PATH no instala Node.js, Git ni ningún otro programa.

## 6.4 ¿PATH garantiza que un comando funciona?

No.

Aunque el ejecutable se encuentre, su ejecución todavía puede fallar por permisos, dependencias, configuración u otros problemas.

### Idea clave

**PATH no es un instalador ni un registro de programas: es una lista de directorios de búsqueda.**

---

# 7. ¿Por qué PATH es una Environment Variable?

En el documento anterior aprendimos que las Environment Variables permiten proporcionar información a los procesos.

PATH sigue ese principio.

Ejemplo:

```text
Shell Environment
│
├── HOME=/home/developer
├── LANG=en_US.UTF-8
└── PATH=/usr/local/bin:/usr/bin:/bin
```

El Shell consulta PATH para parte de su mecanismo de resolución de comandos.

## 7.1 ¿Quién define PATH?

Puede construirse a partir de diferentes fuentes:

- Configuración del sistema.
- Entorno del proceso padre.
- Configuración del usuario.
- Archivos de inicialización del Shell.
- Gestores de versiones.
- Herramientas de desarrollo.

## 7.2 ¿Todos los procesos tienen el mismo PATH?

No necesariamente.

Dos terminales pueden tener diferentes valores.

## 7.3 ¿Puede cambiar durante una sesión?

Sí.

Un Shell puede modificar su PATH.

## 7.4 ¿Se transmite a procesos hijos?

Normalmente sí, cuando PATH forma parte del entorno exportado.

### Idea clave

**PATH pertenece al entorno del proceso y puede variar entre sesiones, usuarios y herramientas.**

---

# 8. PATH en macOS y Linux

En sistemas Unix-like, los directorios de PATH se separan habitualmente mediante dos puntos:

```text
:
```

Ejemplo:

```text
/usr/local/bin:/usr/bin:/bin
```

## 8.1 Interpretación

```text
PATH
 │
 ├── /usr/local/bin
 │
 ├── /usr/bin
 │
 └── /bin
```

## 8.2 Consultar PATH

En Bash y Zsh:

```bash
echo "$PATH"
```

## 8.3 Mostrar un directorio por línea

Podemos utilizar:

```bash
printf '%s\n' "$PATH" | tr ':' '\n'
```

Ejemplo ilustrativo:

```text
/opt/homebrew/bin
/usr/local/bin
/usr/bin
/bin
```

## 8.4 ¿Todos esos directorios existen?

No necesariamente.

PATH puede contener rutas que no existen o que ya no contienen los programas esperados.

## 8.5 ¿El orden importa?

Sí.

Lo estudiaremos a continuación.

---

# 9. PATH en Windows

Windows utiliza habitualmente punto y coma como separador de directorios:

```text
;
```

Ejemplo:

```text
C:\Program Files\nodejs;C:\Windows\System32;C:\Windows
```

## 9.1 Consultar PATH en PowerShell

```powershell
$env:Path
```

## 9.2 Mostrar sus entradas individualmente

```powershell
$env:Path -split ';'
```

## 9.3 ¿Por qué la sintaxis es diferente?

Porque Windows y los Shells Unix-like utilizan convenciones diferentes para representar y manipular determinadas rutas y variables.

## 9.4 ¿PowerShell busca únicamente ejecutables usando PATH?

No.

PowerShell tiene un mecanismo de resolución que también considera:

- Aliases.
- Functions.
- Cmdlets.
- Aplicaciones externas.

Por eso no debemos asumir que las reglas de resolución son idénticas entre PowerShell, Bash y Zsh.

### Idea clave

**PATH es un concepto multiplataforma, pero su representación y las reglas de resolución dependen del entorno.**

---

# 10. PATH Search Order

El orden de los directorios puede influir en qué ejecutable se selecciona.

Supongamos:

```text
PATH=/tools/node-a/bin:/tools/node-b/bin:/usr/bin
```

Tenemos:

```text
/tools/node-a/bin/node
/tools/node-b/bin/node
```

Ambos directorios contienen un ejecutable llamado `node`.

## 10.1 ¿Cuál se utiliza?

En una búsqueda ordinaria de ejecutables externos mediante PATH, normalmente se selecciona el primer ejecutable válido encontrado siguiendo el orden de búsqueda.

En este ejemplo:

```text
/tools/node-a/bin/node
```

## 10.2 Modelo

```text
PATH
 │
 ├── 1. /tools/node-a/bin
 │       │
 │       └── node  ← Found
 │
 ├── 2. /tools/node-b/bin
 │       │
 │       └── node
 │
 └── 3. /usr/bin
```

## 10.3 ¿Esto explica todas las situaciones?

No.

Antes de buscar ejecutables externos, el Shell puede aplicar otras reglas, como resolver funciones, Aliases o Builtins.

Algunos Shells también mantienen información en caché sobre comandos localizados previamente.

## 10.4 Regla profesional

**El orden de PATH importa, pero primero debemos identificar qué tipo de comando está resolviendo el Shell.**

---

# 11. Command Resolution

**Command Resolution** es el proceso mediante el cual el Shell determina qué operación o programa corresponde al comando solicitado.

Por ejemplo:

```bash
node --version
```

El Shell necesita interpretar `node`.

## 11.1 Modelo simplificado

```text
Command Entered
       │
       ▼
Shell Parsing
       │
       ▼
Command Resolution
       │
       ├── Alias / Function / Builtin
       │
       └── External Executable
                  │
                  ▼
               PATH Search
                  │
                  ▼
               Execution
```

Este diagrama es conceptual: el orden y los mecanismos exactos varían según el Shell.

## 11.2 ¿Qué ocurre con una ruta explícita?

Si escribimos:

```bash
./my-script
```

el Shell intenta utilizar esa ruta explícita, en lugar de realizar la búsqueda ordinaria del nombre `my-script` en PATH.

## 11.3 ¿Por qué importa?

Porque:

```bash
my-script
```

y:

```bash
./my-script
```

pueden producir resultados diferentes.

### Idea clave

**PATH interviene principalmente cuando necesitamos localizar un programa externo mediante su nombre, no cuando ya proporcionamos una ruta explícita.**

---

# 12. Shell Builtins, Aliases y Functions

Antes de diagnosticar PATH debemos reconocer otros tipos de comandos.

## 12.1 Shell Builtin

Es una operación implementada por el propio Shell.

Ejemplo en Bash:

```bash
cd ..
```

## 12.2 Alias

Un Alias permite definir una abreviatura para una instrucción.

Ejemplo en Bash/Zsh:

```bash
alias ll='ls -la'
```

## 12.3 Shell Function

Una función permite agrupar instrucciones dentro del Shell.

Ejemplo:

```bash
greet() {
  echo "Hello, developer"
}
```

## 12.4 External Command

Es un programa externo.

Ejemplo:

```bash
git --version
```

## 12.5 ¿Por qué importa esta distinción?

Porque un Alias o una función puede utilizar el mismo nombre que un programa instalado.

Esto puede hacer que el resultado de ejecutar un comando no coincida con lo que esperábamos únicamente al inspeccionar PATH.

### Idea clave

**Antes de asumir que PATH está mal configurado, debemos averiguar cómo está interpretando el Shell el nombre del comando.**

---

# 13. Localizar comandos en Bash y Zsh

Disponemos de varias herramientas para investigar qué comando se ejecutará.

## 13.1 `command -v`

```bash
command -v node
```

Puede devolver:

```text
/opt/homebrew/bin/node
```

Es una forma habitual de consultar cómo se resolvería un comando.

## 13.2 `type`

```bash
type node
```

Puede mostrar información sobre si el nombre corresponde a un Alias, función, Builtin o programa externo.

## 13.3 `which`

```bash
which node
```

Suele utilizarse para localizar ejecutables.

Sin embargo, su implementación y comportamiento varían entre sistemas y Shells.

## 13.4 ¿Cuál recomendamos?

Para investigar la resolución de comandos en Bash y Zsh, priorizaremos:

```bash
command -v node
```

y:

```bash
type node
```

Porque ayudan a comprender la resolución realizada por el Shell.

## 13.5 Mostrar coincidencias adicionales

En Bash y Zsh podemos utilizar:

```bash
type -a node
```

Esto puede mostrar múltiples coincidencias, según el Shell.

### Idea clave

**No basta con preguntar dónde está instalado un programa; necesitamos saber qué interpreta realmente el Shell cuando escribimos su nombre.**

---

# 14. Localizar comandos en PowerShell

PowerShell ofrece herramientas específicas.

## 14.1 `Get-Command`

```powershell
Get-Command node
```

Permite inspeccionar el comando reconocido por PowerShell.

## 14.2 Consultar todas las coincidencias

```powershell
Get-Command node -All
```

Esto ayuda a identificar posibles conflictos entre comandos.

## 14.3 `where.exe`

En Windows podemos utilizar:

```powershell
where.exe node
```

Busca archivos coincidentes siguiendo las reglas de la utilidad de Windows.

## 14.4 ¿Por qué escribir `where.exe`?

Porque `where` puede interpretarse de otra manera dentro de PowerShell.

Utilizar `where.exe` identifica explícitamente la aplicación externa.

## 14.5 Diferencia entre herramientas

| Herramienta | Propósito |
|---|---|
| `Get-Command` | Inspeccionar comandos reconocidos por PowerShell |
| `Get-Command -All` | Mostrar múltiples coincidencias |
| `where.exe` | Buscar archivos ejecutables coincidentes mediante la utilidad Windows |

### Idea clave

**En PowerShell, `Get-Command` es una herramienta fundamental para diagnosticar la resolución de comandos.**

---

# 15. Diagnóstico: Command Not Found

Supongamos que ejecutamos:

```bash
node --version
```

Y recibimos:

```text
command not found: node
```

## 15.1 ¿Qué significa?

Significa que el Shell no ha podido resolver el comando solicitado mediante sus mecanismos disponibles.

No demuestra necesariamente que Node.js no esté instalado.

## 15.2 Posibles causas

1. Node.js no está instalado.
2. Está instalado, pero su directorio no figura en PATH.
3. PATH no se ha actualizado en la sesión.
4. Se está utilizando otro Shell.
5. Se está ejecutando dentro de WSL o una VM distinta.
6. La instalación está incompleta.
7. El ejecutable no tiene los permisos apropiados.
8. Existe una configuración incorrecta del gestor de versiones.

## 15.3 Diagnóstico en Bash/Zsh

```bash
command -v node
```

Después:

```bash
echo "$PATH"
```

## 15.4 Diagnóstico en PowerShell

```powershell
Get-Command node
```

Después:

```powershell
$env:Path
```

## 15.5 ¿Qué no deberíamos hacer inmediatamente?

Modificar PATH sin saber dónde está instalado el programa.

Primero debemos identificar la causa.

### Idea clave

**`command not found` es un síntoma de resolución; no es una prueba definitiva de que la herramienta no exista.**

---

# 16. Diagnóstico: Wrong Version

Este es uno de los problemas más frecuentes del Developer Tooling.

Ejecutamos:

```bash
node --version
```

Y obtenemos:

```text
v20.19.0
```

Pero el proyecto requiere:

```text
v22.16.0
```

## 16.1 ¿Qué puede estar ocurriendo?

Podemos tener varias instalaciones:

```text
System Node.js
Homebrew Node.js
Version Manager Node.js
```

Y una de ellas está siendo seleccionada antes que las demás.

## 16.2 Modelo

```text
PATH
 │
 ├── /usr/local/bin
 │       └── node v20
 │
 └── ~/.nvm/.../bin
         └── node v22
```

Si la primera ubicación contiene el ejecutable seleccionado, obtendremos la versión correspondiente.

## 16.3 Diagnóstico en Bash/Zsh

```bash
type -a node
```

```bash
command -v node
```

```bash
node --version
```

## 16.4 Diagnóstico en PowerShell

```powershell
Get-Command node -All
```

```powershell
where.exe node
```

```powershell
node --version
```

## 16.5 ¿Cuál es la solución?

Depende del gestor de versiones y de cómo se instaló Node.js.

No debemos resolver todos los conflictos modificando PATH manualmente.

### Idea clave

**Cuando se ejecuta una versión inesperada, debemos identificar primero el ejecutable seleccionado.**

---

# 17. PATH y Node.js Version Managers

Los gestores de versiones permiten trabajar con diferentes versiones de un Runtime.

Por ejemplo:

```text
Node.js 20
Node.js 22
Node.js 24
```

Herramientas como nvm y mise pueden intervenir en cómo se selecciona una versión.

## 17.1 ¿Qué relación tienen con PATH?

Dependiendo de su implementación, pueden:

- Modificar PATH.
- Preparar un entorno de Shell.
- Utilizar ejecutables intermediarios o Shims.
- Activar versiones según una configuración.
- Establecer directorios específicos de ejecución.

## 17.2 Modelo conceptual

```text
Developer
    │
    ▼
Version Manager
    │
    ▼
Runtime Selection
    │
    ▼
Command Resolution
    │
    ▼
Selected Node.js
```

## 17.3 ¿Todos funcionan igual?

No.

Cada gestor tiene sus propias reglas.

## 17.4 ¿Por qué es importante?

Porque instalar una versión no garantiza automáticamente que sea la versión activa en todos los procesos.

### Idea clave

**Un Version Manager administra versiones, pero debemos comprender cómo integra la selección con el entorno de ejecución.**

---

# 18. ¿Qué es un Shim?

Un **Shim** es un programa o Script intermediario que permite redirigir o preparar la ejecución de otra herramienta.

Ejemplo conceptual:

```text
node
 │
 ▼
Shim
 │
 ▼
Version Selection
 │
 ▼
Real Node.js Executable
```

## 18.1 ¿Para qué sirve?

Puede ayudar a:

- Seleccionar versiones.
- Preparar configuraciones.
- Mantener un punto de entrada estable.
- Ejecutar una herramienta administrada.

## 18.2 ¿Todos los gestores utilizan Shims?

No.

## 18.3 ¿Por qué importa?

Porque el ejecutable localizado en PATH podría ser un Shim y no el binario final del Runtime.

## 18.4 ¿Es algo malo?

No necesariamente.

Es una técnica habitual de integración entre herramientas.

### Idea clave

**El primer ejecutable encontrado puede actuar como intermediario de otro programa.**

---

# 19. Global vs Local Tool Installation

Otro concepto importante es la diferencia entre herramientas instaladas globalmente y dependencias locales de un proyecto.

## 19.1 Global Installation

Una herramienta puede instalarse en una ubicación accesible desde el entorno del usuario.

Ejemplo conceptual:

```text
Global Tools
│
├── tool-a
└── tool-b
```

## 19.2 Local Installation

Una dependencia puede instalarse dentro del contexto de un proyecto.

Ejemplo:

```text
my-app/
├── package.json
└── node_modules/
    └── .bin/
```

## 19.3 ¿Las dependencias locales aparecen automáticamente en PATH?

No en todas las situaciones.

Herramientas como npm y pnpm pueden preparar PATH para que determinados ejecutables locales estén disponibles durante la ejecución de Scripts.

## 19.4 Ejemplo

```json
{
  "scripts": {
    "build": "vite build"
  }
}
```

Cuando ejecutamos el Script mediante un Package Manager compatible, este puede preparar el entorno necesario para localizar el ejecutable local de Vite.

## 19.5 ¿Necesitamos instalar Vite globalmente?

Normalmente no.

Para herramientas específicas del proyecto suele ser preferible utilizar dependencias locales declaradas.

### Idea clave

**Que una herramienta funcione dentro de un Script de npm o pnpm no significa que esté disponible globalmente en cualquier terminal.**

---

# 20. PATH y Corepack

Corepack es una herramienta relacionada con la gestión de determinados Package Managers de JavaScript.

Dependiendo de la versión de Node.js y de cómo se haya instalado, puede requerir instalación o habilitación adicional.

## 20.1 ¿Qué relación tiene con PATH?

Puede proporcionar ejecutables intermediarios que permiten invocar gestores de paquetes compatibles.

## 20.2 Ejemplo conceptual

```text
pnpm
 │
 ▼
Corepack Proxy
 │
 ▼
Package Manager Selection
 │
 ▼
pnpm Execution
```

## 20.3 ¿Por qué importa?

Porque el comando `pnpm` que encuentra el Shell puede no corresponder a una instalación global independiente de pnpm.

## 20.4 ¿Lo configuraremos ahora?

No.

Lo estudiaremos en los módulos dedicados a Runtime Management y Package Managers.

### Idea clave

**La disponibilidad de un comando puede depender de herramientas intermediarias y no únicamente de una instalación directa.**

---

# 21. PATH y macOS: Apple Silicon vs Intel

En macOS podemos encontrar diferentes convenciones de instalación según la arquitectura y la herramienta utilizada.

## 21.1 Apple Silicon

Homebrew utiliza habitualmente:

```text
/opt/homebrew
```

Sus ejecutables suelen encontrarse en:

```text
/opt/homebrew/bin
```

## 21.2 Intel

Homebrew utiliza habitualmente:

```text
/usr/local
```

Sus ejecutables suelen encontrarse en:

```text
/usr/local/bin
```

## 21.3 ¿Por qué importa?

Porque podríamos tener herramientas instaladas en ubicaciones distintas.

## 21.4 ¿Qué deberíamos evitar?

Copiar configuraciones de PATH de otra computadora sin verificar que correspondan a nuestro entorno.

## 21.5 Buena práctica

Consultar primero:

```bash
command -v brew
```

Y, si Homebrew está disponible:

```bash
brew --prefix
```

### Idea clave

**Las rutas habituales de instalación dependen de la arquitectura, el instalador y la configuración del sistema.**

---

# 22. PATH en Windows: PowerShell, Git Bash y WSL

Windows puede disponer de varios entornos de desarrollo.

## 22.1 PowerShell

Utiliza el entorno de Windows.

Ejemplo:

```text
C:\Program Files\nodejs
```

## 22.2 Git Bash

Permite trabajar con una interfaz Unix-like sobre Windows.

Puede adaptar determinadas rutas y variables para su entorno.

## 22.3 WSL

Ejecuta un entorno Linux.

Sus herramientas pueden instalarse dentro de la distribución.

Ejemplo:

```text
/usr/bin/node
```

## 22.4 ¿Es el mismo Node.js?

No necesariamente.

Podríamos tener:

```text
Windows Node.js
Linux Node.js inside WSL
```

Son instalaciones distintas.

## 22.5 ¿Comparten PATH?

No debemos asumirlo.

WSL puede incorporar determinadas rutas de Windows dependiendo de su configuración, pero su entorno y reglas de ejecución siguen siendo diferentes.

## 22.6 Regla profesional

**Cuando diagnosticamos una herramienta, primero debemos identificar en qué entorno se está ejecutando el comando.**

---

# 23. Modificar PATH temporalmente en Bash y Zsh

Podemos añadir un directorio a PATH durante una sesión.

Antes de hacerlo, debemos comprender la diferencia entre agregarlo al inicio o al final.

## 23.1 Prepend

Agregar al principio:

```bash
export PATH="/custom/tools/bin:$PATH"
```

Esto coloca `/custom/tools/bin` antes de las entradas anteriores.

## 23.2 Append

Agregar al final:

```bash
export PATH="$PATH:/custom/tools/bin"
```

Esto coloca el directorio después de las entradas anteriores.

## 23.3 ¿Cuál tiene prioridad?

En una búsqueda ordinaria mediante PATH, las entradas anteriores suelen tener prioridad sobre las posteriores.

## 23.4 ¿Cuál deberíamos utilizar?

Depende de la necesidad.

Prepend puede ser apropiado cuando queremos priorizar explícitamente una herramienta.

Append puede ser apropiado cuando queremos mantener la prioridad de herramientas existentes.

## 23.5 Precaución

No debemos añadir rutas inexistentes o desconocidas sin verificar su propósito.

Tampoco debemos modificar PATH permanentemente antes de entender el mecanismo de instalación de la herramienta.

### Idea clave

**Prepend y Append no son equivalentes: pueden cambiar qué versión de un ejecutable se selecciona.**

---

# 24. Modificar PATH temporalmente en PowerShell

En PowerShell podemos modificar el PATH del proceso actual.

## 24.1 Agregar al principio

```powershell
$env:Path = "C:\CustomTools\bin;$env:Path"
```

## 24.2 Agregar al final

```powershell
$env:Path = "$env:Path;C:\CustomTools\bin"
```

## 24.3 ¿Es permanente?

No.

Estas asignaciones modifican el entorno del proceso PowerShell actual.

## 24.4 ¿Qué ocurre con procesos hijos?

Normalmente recibirán el PATH actualizado cuando se inicien desde esa sesión.

## 24.5 ¿Qué ocurre con otras terminales?

No se actualizan automáticamente.

### Idea clave

**Modificar PATH en una sesión no equivale a modificar la configuración persistente del usuario o del sistema.**

---

# 25. ¿Debemos modificar PATH permanentemente?

En ocasiones puede ser necesario.

Sin embargo, hacerlo sin comprender las herramientas involucradas puede introducir problemas.

## 25.1 Riesgos habituales

- Directorios duplicados.
- Rutas inexistentes.
- Conflictos entre versiones.
- Herramientas antiguas con mayor prioridad.
- Configuraciones difíciles de mantener.
- Comandos inesperados.
- Dependencias de una máquina concreta.

## 25.2 ¿Qué recomendamos?

Antes de modificar PATH permanentemente:

1. Identificar el ejecutable.
2. Verificar su ubicación.
3. Comprender el instalador.
4. Revisar si existe un Version Manager.
5. Identificar el Shell.
6. Verificar los archivos de inicialización correspondientes.
7. Documentar el cambio.
8. Comprobar el resultado en una nueva sesión.

## 25.3 ¿Dónde se configura?

Depende del sistema operativo y del Shell.

En el siguiente documento estudiaremos los Shell Configuration Files.

### Idea clave

**PATH debe administrarse deliberadamente, no mediante acumulación de rutas copiadas de tutoriales.**

---

# 26. Command Hashing y caché del Shell

Algunos Shells mantienen información sobre comandos externos localizados previamente.

Este mecanismo puede reducir búsquedas repetidas.

## 26.1 ¿Por qué importa?

Porque después de instalar, eliminar o mover una herramienta, el Shell podría conservar información previa sobre su ubicación.

## 26.2 Bash

Bash dispone de mecanismos relacionados con la tabla de comandos recordados.

Por ejemplo:

```bash
hash
```

Y:

```bash
hash -r
```

Este último limpia las ubicaciones recordadas por Bash.

## 26.3 ¿Debemos ejecutar `hash -r` siempre?

No.

Solo tiene sentido cuando el comportamiento observado y el Shell utilizado justifican revisar esa caché.

## 26.4 ¿Zsh funciona exactamente igual?

No necesariamente.

Aunque dispone de mecanismos relacionados, sus detalles y comandos pueden diferir.

### Idea clave

**La resolución de comandos puede involucrar estado interno del Shell además del contenido de PATH.**

---

# 27. Seguridad: PATH Hijacking

PATH también tiene implicaciones de seguridad.

Un problema conocido es **PATH Hijacking**.

Ocurre cuando un proceso ejecuta un programa diferente del esperado debido a cómo se resuelve su nombre.

## 27.1 Ejemplo conceptual

Un Script intenta ejecutar:

```text
tool
```

Pero PATH contiene primero un directorio no confiable que incluye otro ejecutable llamado `tool`.

## 27.2 Modelo

```text
PATH
 │
 ├── Untrusted Directory
 │       └── tool  ← Selected
 │
 └── Trusted Directory
         └── tool
```

## 27.3 ¿Por qué es peligroso?

Porque podría ejecutarse código distinto del previsto.

## 27.4 Buenas prácticas

- Evitar directorios no confiables en PATH.
- No colocar indiscriminadamente `.` al inicio de PATH.
- Verificar el origen de ejecutables.
- Evitar ejecutar Scripts desconocidos.
- Utilizar rutas explícitas cuando el contexto de seguridad lo requiera.
- Aplicar permisos adecuados.

## 27.5 ¿Por qué `.` puede ser problemático?

Porque representa el directorio actual.

Si está incluido en PATH, un comando podría localizar un ejecutable presente en una carpeta que no controlamos suficientemente.

### Idea clave

**PATH no solo influye en qué herramienta utilizamos, sino también en qué código terminamos ejecutando.**

---

# 28. PATH y Reproducible Environments

Recordemos que un entorno reproducible busca reducir diferencias inesperadas entre desarrolladores y sistemas.

PATH puede afectar directamente ese objetivo.

## 28.1 Ejemplo

Desarrollador A:

```text
node → v22
```

Desarrollador B:

```text
node → v20
```

Ambos ejecutan:

```bash
node --version
```

Pero reciben resultados diferentes.

## 28.2 ¿Cómo reducir el problema?

- Declarar versiones requeridas.
- Utilizar gestores de versiones.
- Documentar herramientas.
- Evitar instalaciones globales innecesarias.
- Validar versiones.
- Utilizar mecanismos consistentes de ejecución.
- Mantener configuraciones de proyecto claras.

## 28.3 ¿PATH garantiza reproducibilidad?

No.

Es solamente una pieza del entorno.

También intervienen:

- Runtime.
- Package Manager.
- Dependencias.
- Sistema operativo.
- Arquitectura.
- Variables de entorno.
- Configuración del proyecto.

### Idea clave

**Controlar PATH ayuda a reducir diferencias, pero la reproducibilidad requiere gestionar todo el entorno de desarrollo.**

---

# 29. Práctica 01 — Inspeccionar PATH

## Objetivo

Identificar los directorios donde el Shell busca ejecutables.

### Bash/Zsh

Ejecuta:

```bash
echo "$PATH"
```

Después:

```bash
printf '%s\n' "$PATH" | tr ':' '\n'
```

### PowerShell

Ejecuta:

```powershell
$env:Path
```

Después:

```powershell
$env:Path -split ';'
```

## Preguntas

1. ¿Cuántos directorios aparecen?
2. ¿Reconoces alguno?
3. ¿Hay directorios relacionados con herramientas de desarrollo?
4. ¿Observas rutas duplicadas?
5. ¿Hay rutas específicas de tu usuario?
6. ¿Qué directorio aparece primero?

**No modifiques nada todavía.**

---

# 30. Práctica 02 — Localizar Git

## Objetivo

Comprender qué ejecutable utiliza el Shell.

### Bash/Zsh

```bash
command -v git
```

```bash
type git
```

```bash
type -a git
```

### PowerShell

```powershell
Get-Command git
```

```powershell
Get-Command git -All
```

```powershell
where.exe git
```

## Preguntas

1. ¿Git está disponible?
2. ¿Qué ruta aparece?
3. ¿Existen varias coincidencias?
4. ¿Qué tipo de comando reconoce el Shell?
5. ¿La ruta pertenece a una instalación que identificas?

---

# 31. Práctica 03 — Localizar Node.js

## Objetivo

Relacionar PATH con Runtime Management.

### Bash/Zsh

```bash
node --version
```

```bash
command -v node
```

```bash
type -a node
```

### PowerShell

```powershell
node --version
```

```powershell
Get-Command node -All
```

```powershell
where.exe node
```

## Preguntas

1. ¿Qué versión se ejecuta?
2. ¿Dónde está el ejecutable seleccionado?
3. ¿Existen otras instalaciones?
4. ¿Utilizas un Version Manager?
5. ¿Podría intervenir un Shim?

Si Node.js no está instalado, puedes realizar esta práctica con Git u otra herramienta disponible.

---

# 32. Práctica 04 — PATH Search Order

Esta práctica es conceptual y no modifica tu computadora.

Tenemos:

```text
PATH=/tools/a:/tools/b:/usr/bin
```

Y estos ejecutables:

```text
/tools/a/git
/tools/b/git
/usr/bin/git
```

## Pregunta 1

¿Cuál sería seleccionado en una búsqueda ordinaria mediante PATH?

**Respuesta:**

```text
/tools/a/git
```

## Pregunta 2

¿Qué sucedería si cambiamos PATH a:

```text
PATH=/tools/b:/tools/a:/usr/bin
```

**Respuesta:**

```text
/tools/b/git
```

## Pregunta 3

¿Esto garantiza que escribir `git` siempre ejecute ese archivo?

**Respuesta:**

No necesariamente.

El Shell puede tener Aliases, funciones u otros mecanismos que afecten la resolución.

### Aprendizaje

**El orden importa, pero debe analizarse dentro de las reglas completas del Shell.**

---

# 33. Práctica 05 — Modificación temporal de PATH

Esta práctica utiliza un directorio temporal y evita modificar archivos de configuración.

## Bash/Zsh

### Paso 1 — Crear un directorio de prueba

```bash
mkdir -p "$HOME/tooling-path-practice/bin"
```

### Paso 2 — Guardar PATH original

```bash
ORIGINAL_PATH="$PATH"
```

### Paso 3 — Agregar el directorio al final

```bash
export PATH="$PATH:$HOME/tooling-path-practice/bin"
```

### Paso 4 — Verificar

```bash
printf '%s\n' "$PATH" | tr ':' '\n'
```

### Paso 5 — Restaurar

```bash
export PATH="$ORIGINAL_PATH"
```

### Paso 6 — Eliminar el directorio de prueba

```bash
rmdir "$HOME/tooling-path-practice/bin"
rmdir "$HOME/tooling-path-practice"
```

Realiza la limpieza únicamente si los directorios están vacíos y corresponden a esta práctica.

## Reflexión

1. ¿Qué cambió en PATH?
2. ¿Por qué agregamos el directorio al final?
3. ¿Qué ocurriría si lo agregáramos al principio?
4. ¿Por qué guardamos el valor original?
5. ¿El cambio afectó permanentemente al sistema?

---

# 34. Práctica 06 — Diagnosticar un conflicto

Imagina esta situación:

```text
Developer Machine
│
├── Node.js 20 installed globally
│
└── Node.js 22 managed by a version manager
```

El proyecto necesita Node.js 22.

Pero:

```bash
node --version
```

devuelve Node.js 20.

## Tu tarea

Diseña un diagnóstico respondiendo:

1. ¿Qué Shell se está utilizando?
2. ¿Qué ejecutable se está seleccionando?
3. ¿Existen varias coincidencias?
4. ¿Qué directorios aparecen primero en PATH?
5. ¿Está activado correctamente el Version Manager?
6. ¿El proceso utiliza un Shim?
7. ¿Se inició una nueva sesión después de configurar la herramienta?
8. ¿Qué solución aplicarías sin modificar PATH innecesariamente?

## Resultado esperado

No buscamos memorizar una solución universal.

Buscamos aprender a identificar la causa antes de modificar el entorno.

---

# 35. Casos reales de ingeniería

## Caso 1 — Node.js instalado, pero no reconocido

**Problema:** `node` no se encuentra.

**Posible causa:** El ejecutable no está disponible mediante los mecanismos de resolución del Shell.

**Aprendizaje:** Verificar instalación, ubicación y PATH.

---

## Caso 2 — Versión equivocada de Node.js

**Problema:** El proyecto necesita Node.js 22, pero se ejecuta Node.js 20.

**Posible causa:** Otra instalación tiene prioridad.

**Aprendizaje:** Inspeccionar el ejecutable seleccionado y el gestor de versiones.

---

## Caso 3 — pnpm funciona en npm Scripts, pero no en la terminal

**Problema:** Una herramienta está disponible en un contexto, pero no en otro.

**Posible causa:** El Package Manager prepara un entorno de ejecución diferente.

**Aprendizaje:** Distinguir herramientas locales y globales.

---

## Caso 4 — Git funciona en Git Bash, pero no en PowerShell

**Problema:** El comando se reconoce en un Shell y en otro no.

**Posible causa:** Diferencias de entorno o configuración.

**Aprendizaje:** Comparar los mecanismos de resolución de cada Shell.

---

## Caso 5 — Una herramienta funciona en Windows, pero no en WSL

**Problema:** El comando no está disponible dentro de Linux.

**Posible causa:** La herramienta está instalada únicamente en Windows.

**Aprendizaje:** Distinguir los entornos de ejecución.

---

## Caso 6 — Una herramienta cambia después de instalar otra

**Problema:** El mismo comando comienza a ejecutar otro programa.

**Posible causa:** El instalador modificó PATH o introdujo una nueva coincidencia.

**Aprendizaje:** Revisar las prioridades y el origen de los ejecutables.

---

# 36. Errores frecuentes

### Error 1 — Pensar que PATH contiene programas

PATH contiene directorios de búsqueda.

### Error 2 — Pensar que instalar una herramienta garantiza su disponibilidad

La instalación y la resolución son responsabilidades diferentes.

### Error 3 — Pensar que todos los comandos se buscan mediante PATH

Existen Builtins, Aliases y funciones.

### Error 4 — Ignorar el orden de búsqueda

Puede cambiar el ejecutable seleccionado.

### Error 5 — Modificar PATH sin diagnosticar

Puede introducir nuevos conflictos.

### Error 6 — Confundir `which` con una explicación completa de Command Resolution

Su comportamiento depende de la implementación.

### Error 7 — Pensar que todas las terminales tienen el mismo PATH

Los procesos pueden tener entornos diferentes.

### Error 8 — Pensar que Windows y WSL comparten todas las instalaciones

Son entornos distintos.

### Error 9 — Confundir un Shim con el ejecutable final

Algunas herramientas utilizan intermediarios.

### Error 10 — Instalar herramientas globalmente sin necesidad

Puede dificultar la reproducibilidad.

### Error 11 — Agregar directorios no confiables

Puede introducir riesgos de seguridad.

### Error 12 — Ignorar configuraciones del Version Manager

Puede provocar versiones inesperadas.

### Error 13 — Modificar PATH permanentemente para solucionar un problema temporal

Puede contaminar futuras sesiones.

### Error 14 — No verificar la versión real

Encontrar un ejecutable no garantiza que sea la versión requerida.

### Error 15 — Copiar rutas de instalación de otra máquina

Pueden no corresponder al sistema actual.

---

# 37. Comprueba tu modelo mental

1. ¿Qué es un Executable?
2. ¿Qué es un Command?
3. ¿Cuál es la diferencia entre ambos?
4. ¿Qué es PATH?
5. ¿PATH contiene programas?
6. ¿Qué significa Command Resolution?
7. ¿Qué es un Shell Builtin?
8. ¿Qué es un Alias?
9. ¿Qué es una Shell Function?
10. ¿Todos los comandos externos se buscan mediante PATH?
11. ¿Qué ocurre cuando proporcionamos una ruta explícita?
12. ¿Por qué importa el orden de PATH?
13. ¿Qué separador utiliza habitualmente macOS?
14. ¿Qué separador utiliza habitualmente Windows?
15. ¿Cómo consultas PATH en Bash?
16. ¿Cómo consultas PATH en PowerShell?
17. ¿Qué hace `command -v`?
18. ¿Qué hace `type`?
19. ¿Por qué `which` no siempre es suficiente?
20. ¿Qué hace `Get-Command`?
21. ¿Qué hace `where.exe`?
22. ¿Qué significa `command not found`?
23. ¿Demuestra que una herramienta no está instalada?
24. ¿Cómo identificarías el ejecutable seleccionado?
25. ¿Por qué puede ejecutarse una versión inesperada?
26. ¿Qué es un Version Manager?
27. ¿Cómo puede relacionarse con PATH?
28. ¿Qué es un Shim?
29. ¿Qué diferencia existe entre herramientas locales y globales?
30. ¿Por qué npm Scripts pueden localizar ejecutables locales?
31. ¿Qué relación existe entre Corepack y la ejecución de Package Managers?
32. ¿Dónde suele instalarse Homebrew en Apple Silicon?
33. ¿Dónde suele instalarse Homebrew en Intel?
34. ¿Por qué Windows y WSL pueden ejecutar versiones diferentes?
35. ¿Qué significa Prepend?
36. ¿Qué significa Append?
37. ¿Cuál tiene mayor prioridad en una búsqueda ordinaria?
38. ¿Una modificación temporal de PATH afecta a todas las terminales?
39. ¿Qué es Command Hashing?
40. ¿Qué es PATH Hijacking?
41. ¿Por qué puede ser peligroso incluir directorios no confiables?
42. ¿PATH garantiza un entorno reproducible?
43. ¿Por qué conviene declarar versiones?
44. ¿Qué revisarías antes de modificar PATH?
45. ¿Cuál es la pregunta más importante al diagnosticar un comando?

---

# 38. Checklist de aprendizaje

## Fundamentals

- [ ] Comprendo qué es un Executable.
- [ ] Diferencio Command y Executable.
- [ ] Comprendo qué es PATH.
- [ ] Comprendo Command Resolution.
- [ ] Distingo Builtins, Aliases, Functions y programas externos.

## PATH Inspection

- [ ] Sé consultar PATH en Bash/Zsh.
- [ ] Sé consultar PATH en PowerShell.
- [ ] Comprendo los separadores de cada sistema.
- [ ] Comprendo el orden de búsqueda.
- [ ] Sé localizar un comando.

## Troubleshooting

- [ ] Puedo investigar `command not found`.
- [ ] Puedo identificar qué versión se ejecuta.
- [ ] Sé detectar múltiples coincidencias.
- [ ] Comprendo la relación con Version Managers.
- [ ] Reconozco la función de los Shims.

## Professional Practices

- [ ] Evito modificar PATH sin diagnosticar.
- [ ] Diferencio cambios temporales y persistentes.
- [ ] Comprendo los riesgos de PATH Hijacking.
- [ ] Evito directorios no confiables.
- [ ] Comprendo la importancia de las versiones reproducibles.
- [ ] Reconozco diferencias entre macOS, Windows y WSL.

---

# 39. Resumen conceptual

El modelo mental principal es:

```text
Developer
    │
    ▼
Command
    │
    ▼
Shell
    │
    ▼
Command Resolution
    │
    ├── Builtin
    ├── Alias
    ├── Function
    │
    └── External Program
             │
             ▼
         PATH Search
             │
             ▼
         Executable
             │
             ▼
          Process
```

Y cuando existen varias versiones:

```text
PATH Search Order
        │
        ▼
First Applicable Match
        │
        ▼
Selected Executable
        │
        ▼
Observed Tool Version
```

Debemos recordar:

```text
Installation ≠ Command Availability
```

```text
Command Name ≠ Executable Path
```

```text
PATH Configuration ≠ Runtime Version Management
```

Son conceptos relacionados, pero con responsabilidades distintas.

---

# 40. Idea clave

**PATH permite que el Shell encuentre ejecutables mediante sus nombres, pero la herramienta que finalmente se ejecuta depende de las reglas de resolución, el orden de búsqueda y la configuración del entorno.**

Un ingeniero de software profesional no debería solucionar los problemas de herramientas únicamente reinstalando programas.

Primero debe comprender:

- Qué comando está ejecutando.
- Qué tipo de comando es.
- Qué ejecutable se selecciona.
- Dónde se encuentra.
- Qué versión representa.
- Qué mecanismo administra esa versión.
- Qué configuración influye en la resolución.

Este conocimiento será especialmente importante cuando trabajemos con Node.js, npm, pnpm, gestores de versiones y Monorepos.

---

# 41. Siguiente paso

Ahora que comprendemos cómo PATH participa en la localización de programas, necesitamos estudiar dónde se almacenan determinadas configuraciones del Shell y cómo se cargan al iniciar una sesión.

En el siguiente documento aprenderemos:

- Shell Startup Files.
- Login Shell vs Non-login Shell.
- Interactive vs Non-interactive Shell.
- `.bashrc`.
- `.bash_profile`.
- `.profile`.
- `.zshrc`.
- `.zprofile`.
- PowerShell Profiles.
- Buenas prácticas para configurar el Shell.

👉 [07 — Shell Configuration Files](./07-shell-configuration-files.md)

**Primero comprendimos cómo el Shell encuentra los programas. Ahora aprenderemos cómo se prepara su configuración al iniciar una sesión.**