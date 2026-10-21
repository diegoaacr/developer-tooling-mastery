# Environment Variables

> **Developer Tooling Mastery 2026 — Module 02**
>
> **Topic 05:** Environment Variables  
> **Level:** Beginner → Professional Foundations  
> **Prerequisites:** [04 — Absolute vs Relative Paths](./04-absolute-vs-relative-paths.md)

---

## 1. Introducción

Cuando desarrollamos software, nuestros programas necesitan conocer información sobre el entorno donde se ejecutan.

Por ejemplo:

- ¿Cuál es el directorio personal del usuario?
- ¿Qué idioma o configuración regional utiliza el sistema?
- ¿Dónde deben buscarse los comandos?
- ¿En qué entorno se está ejecutando una aplicación?
- ¿Qué puerto debe utilizar un servidor?
- ¿Cuál es la dirección de una API?
- ¿Cómo recibe una herramienta determinadas opciones de configuración?

Una forma habitual de proporcionar esta información es mediante **Environment Variables**.

Consideremos este ejemplo:

```text
APP_PORT=3000
APP_ENV=development
API_BASE_URL=https://api.example.com
```

Tenemos tres pares de nombres y valores.

Un programa puede consultar esos valores y utilizarlos para determinar parte de su comportamiento.

Sin embargo, antes de aprender a utilizarlos debemos comprender algunas preguntas fundamentales:

**¿Dónde viven estas variables? ¿Quién las crea? ¿Quién puede leerlas? ¿Cuánto tiempo existen? ¿Qué sucede cuando abrimos otra terminal? ¿Son lo mismo que las variables de un lenguaje de programación?**

Estas preguntas son importantes porque las Environment Variables forman parte de la relación entre el Shell, el sistema operativo y los procesos.

En este documento construiremos ese modelo mental desde cero.

---

# 2. Objetivos de aprendizaje

Al finalizar deberías poder:

1. Explicar qué es una Variable.
2. Diferenciar Shell Variables y Environment Variables.
3. Comprender el concepto de Environment.
4. Explicar cómo funciona Process Inheritance.
5. Diferenciar Parent Process y Child Process.
6. Crear variables temporales en Bash, Zsh y PowerShell.
7. Consultar valores de variables.
8. Comprender Variable Expansion.
9. Utilizar `export` en Bash y Zsh.
10. Comprender el alcance o Scope de una variable.
11. Diferenciar variables temporales y persistentes.
12. Reconocer variables habituales como `HOME`, `PATH` y `USER`.
13. Comprender el papel de las variables en Node.js.
14. Distinguir Environment Variables y archivos `.env`.
15. Reconocer riesgos al manejar secretos.
16. Diagnosticar errores de configuración.
17. Aplicar buenas prácticas profesionales.

---

# 3. ¿Qué es una Variable?

Antes de estudiar Environment Variables necesitamos comprender qué es una variable.

Una **Variable** es un nombre asociado a un valor dentro de un determinado contexto.

Por ejemplo:

```text
APP_NAME = "my-application"
```

Aquí tenemos:

| Elemento | Significado |
|---|---|
| `APP_NAME` | Nombre de la variable |
| `my-application` | Valor |

El nombre permite referirnos al valor sin repetirlo directamente.

## 3.1 Ejemplo en JavaScript

```javascript
const appName = "my-application";

console.log(appName);
```

En este ejemplo, `appName` es una variable de JavaScript.

## 3.2 Ejemplo en Bash

```bash
APP_NAME="my-application"
```

Aquí estamos creando una variable del Shell.

Aunque ambos ejemplos utilizan variables, **no pertenecen al mismo contexto ni funcionan necesariamente de la misma manera**.

## 3.3 ¿Qué significa Context?

Es el entorno dentro del cual un nombre y su valor tienen significado.

Por ejemplo:

- Una función.
- Un módulo.
- Un proceso.
- Una sesión del Shell.
- Un entorno de ejecución.

### Idea clave

**Una variable siempre existe dentro de algún contexto; no debemos asumir que todos los programas pueden acceder a ella.**

---

# 4. ¿Qué es un Environment?

En el contexto de procesos, un **Environment** es un conjunto de pares nombre-valor que un proceso puede recibir al iniciarse y utilizar durante su ejecución.

Ejemplo conceptual:

```text
Process Environment
│
├── HOME=/home/developer
├── LANG=en_US.UTF-8
├── APP_ENV=development
└── APP_PORT=3000
```

Los nombres y valores se representan habitualmente como cadenas de texto.

## 4.1 ¿Para qué sirve?

Permite proporcionar información a programas sin introducir necesariamente esos valores directamente en su código fuente.

Por ejemplo:

```text
Application
    │
    ▼
Read APP_PORT
    │
    ▼
Start Server
```

## 4.2 ¿Todas las aplicaciones utilizan Environment Variables?

No.

Cada programa decide qué variables reconoce y cómo las interpreta.

Una variable llamada:

```text
APP_PORT
```

no tiene significado universal.

Solo influirá en un programa si este ha sido diseñado para consultarla.

## 4.3 ¿El sistema operativo interpreta todas las variables?

No.

Algunas variables tienen convenciones ampliamente utilizadas, pero muchas son específicas de herramientas y aplicaciones.

### Idea clave

**Una Environment Variable proporciona información; corresponde al programa decidir qué hacer con ella.**

---

# 5. ¿Qué es una Environment Variable?

Una **Environment Variable** es una entrada de nombre y valor disponible en el entorno de un proceso.

Ejemplo:

```text
APP_ENV=development
```

Podemos separar sus componentes:

```text
APP_ENV = development
   │          │
   │          └── Value
   │
   └───────────── Name
```

## 5.1 Características principales

Una Environment Variable:

- Tiene un nombre.
- Tiene un valor.
- Forma parte del entorno de un proceso.
- Puede transmitirse a procesos hijos.
- Puede influir en el comportamiento de programas.
- No necesita estar almacenada en un archivo.
- No es automáticamente compartida con todos los procesos del sistema.

## 5.2 ¿Son configuraciones globales?

No necesariamente.

Pueden existir únicamente dentro del entorno de un proceso.

## 5.3 ¿Son permanentes?

No necesariamente.

Algunas existen solo durante una sesión o la ejecución de un comando.

## 5.4 ¿Son seguras para guardar secretos?

No por sí mismas.

Su utilización para transportar secretos requiere controles adicionales que estudiaremos más adelante.

### Idea clave

**Environment Variable no significa Global Variable ni Permanent Variable.**

---

# 6. Shell Variables vs Environment Variables

Esta distinción es fundamental.

## 6.1 Shell Variable

Una **Shell Variable** pertenece al estado interno de una sesión del Shell.

Por ejemplo, en Bash:

```bash
APP_NAME="my-app"
```

Podemos consultarla:

```bash
echo "$APP_NAME"
```

Pero eso no significa necesariamente que un programa hijo la recibirá.

## 6.2 Environment Variable

En Bash y Zsh podemos exportar una variable:

```bash
export APP_NAME="my-app"
```

Ahora esa variable queda marcada para incluirse en el entorno de los procesos hijos iniciados por ese Shell.

## 6.3 Comparación

| Característica | Shell Variable | Exported Environment Variable |
|---|---|---|
| Disponible en el Shell actual | Sí | Sí |
| Se transmite normalmente a procesos hijos | No | Sí |
| Requiere `export` en Bash/Zsh | No | Sí |
| Persiste automáticamente entre sesiones | No | No |
| Es global para todo el sistema | No | No |

## 6.4 Ejemplo conceptual

```text
Shell
│
├── LOCAL_VALUE="hello"
│
└── export APP_ENV="development"
         │
         ▼
      Child Process
         │
         └── APP_ENV="development"
```

El proceso hijo recibe la variable exportada.

La variable local del Shell no se transmite automáticamente.

### Idea clave

**En Bash y Zsh, `export` conecta una variable del Shell con el entorno que recibirán sus procesos hijos.**

---

# 7. Parent Process y Child Process

Para comprender Environment Variables debemos estudiar cómo se relacionan los procesos.

## 7.1 ¿Qué es un Process?

Un **Process** es una instancia de un programa en ejecución, administrada por el sistema operativo.

Ejemplos:

- Una terminal ejecutando un Shell.
- Un proceso Node.js.
- Un servidor web.
- Una herramienta de compilación.
- Un proceso Git.

## 7.2 Parent Process

Es un proceso que inicia otro proceso.

## 7.3 Child Process

Es un proceso iniciado por otro.

## 7.4 Ejemplo

```text
Terminal Application
        │
        ▼
      Shell
        │
        ▼
    Node.js Process
```

El Shell puede iniciar Node.js.

En ese escenario:

```text
Shell = Parent Process
Node.js = Child Process
```

## 7.5 ¿Qué ocurre con el Environment?

Normalmente, cuando un proceso inicia otro, el proceso hijo recibe un entorno preparado para su ejecución.

Ese entorno suele derivarse del entorno del padre.

El programa que inicia al hijo también puede modificarlo o sustituirlo.

### Idea clave

**La transmisión de Environment Variables ocurre principalmente a través de la creación de procesos, no mediante una sincronización global permanente.**

---

# 8. Process Inheritance

**Process Inheritance**, aplicado al entorno, describe cómo un proceso hijo puede recibir variables de entorno del proceso que lo inicia.

## 8.1 Ejemplo

Tenemos un Shell:

```text
APP_ENV=development
```

Iniciamos un proceso Node.js.

```text
Shell
│
├── APP_ENV=development
│
└── Node.js
      │
      └── APP_ENV=development
```

El proceso Node.js puede consultar esa variable.

## 8.2 ¿Qué ocurre si el hijo modifica su variable?

Supongamos:

```text
Parent Process
APP_ENV=development
```

El hijo cambia su propio valor:

```text
Child Process
APP_ENV=testing
```

El valor del padre no cambia automáticamente.

## 8.3 ¿Por qué?

Porque cada proceso tiene su propio entorno.

No se trata de un objeto global compartido y sincronizado entre todos los procesos.

## 8.4 Modelo

```text
Parent Environment
       │
       │ Child creation
       ▼
Child Environment
       │
       ├── Read
       ├── Modify
       └── Use
```

### Idea clave

**La herencia transmite información hacia el proceso hijo, pero no establece una sincronización bidireccional.**

---

# 9. Consultar Environment Variables en Bash y Zsh

Comenzaremos con operaciones de lectura.

## 9.1 Consultar HOME

```bash
echo "$HOME"
```

Resultado ilustrativo:

```text
/Users/developer
```

## 9.2 Consultar SHELL

```bash
echo "$SHELL"
```

Puede mostrar la ruta del Shell configurado para el usuario.

Por ejemplo:

```text
/bin/zsh
```

**Importante:** `SHELL` no garantiza identificar el proceso de Shell que está ejecutándose en ese instante.

## 9.3 Consultar USER

```bash
echo "$USER"
```

Ejemplo:

```text
developer
```

## 9.4 Consultar una variable concreta

```bash
printenv HOME
```

`printenv` suele estar disponible en macOS y Linux.

Permite consultar una variable del entorno.

## 9.5 ¿Qué sucede si no existe?

```bash
echo "$MY_UNKNOWN_VARIABLE"
```

Habitualmente obtendremos una cadena vacía cuando la variable no esté definida, salvo que existan configuraciones del Shell que cambien ese comportamiento.

## 9.6 Buena práctica

Consultar variables concretas es preferible a mostrar indiscriminadamente todo el entorno.

**El entorno puede contener información sensible.**

---

# 10. Consultar Environment Variables en PowerShell

PowerShell utiliza una sintaxis diferente.

## 10.1 Consultar HOME

```powershell
$HOME
```

## 10.2 Consultar una Environment Variable

```powershell
$env:USERPROFILE
```

En Windows, `USERPROFILE` suele identificar el directorio de perfil del usuario.

## 10.3 Consultar PATH

```powershell
$env:Path
```

## 10.4 Consultar una variable específica

```powershell
$env:APP_ENV
```

## 10.5 ¿Qué significa `$env:`?

Es la sintaxis del proveedor de variables de entorno de PowerShell.

Permite acceder a entradas del entorno del proceso.

## 10.6 Diferencia importante

En PowerShell:

```powershell
$appName = "my-app"
```

crea una variable de PowerShell.

Mientras que:

```powershell
$env:APP_NAME = "my-app"
```

establece una variable en el entorno del proceso PowerShell.

### Idea clave

**PowerShell distingue entre sus variables normales y las variables del entorno mediante sintaxis diferente.**

---

# 11. Crear Shell Variables en Bash y Zsh

Ahora crearemos variables temporales.

## 11.1 Asignación

```bash
APP_NAME="my-application"
```

## 11.2 Consultar

```bash
echo "$APP_NAME"
```

Resultado:

```text
my-application
```

## 11.3 ¿Por qué no dejamos espacios alrededor de `=`?

En Bash y Zsh, la sintaxis de asignación no utiliza espacios alrededor del operador.

Correcto:

```bash
APP_NAME="my-application"
```

Incorrecto para esta operación:

```bash
APP_NAME = "my-application"
```

El Shell puede interpretar esta segunda expresión como un intento de ejecutar un comando.

## 11.4 ¿Es una Environment Variable exportada?

Todavía no necesariamente.

Hemos creado una variable del Shell.

## 11.5 Verificar su exportación

Podemos consultar:

```bash
printenv APP_NAME
```

Si la variable no estaba exportada previamente, no aparecerá como parte del entorno.

### Idea clave

**Asignar una variable y exportarla son operaciones conceptualmente diferentes en Bash y Zsh.**

---

# 12. Exportar variables con `export`

En Bash y Zsh utilizamos `export` para marcar variables que deben transmitirse a procesos hijos.

## 12.1 Ejemplo

```bash
export APP_NAME="my-application"
```

## 12.2 Consultar

```bash
echo "$APP_NAME"
```

## 12.3 Consultar el entorno

```bash
printenv APP_NAME
```

Resultado esperado:

```text
my-application
```

## 12.4 Otra forma

También podemos escribir:

```bash
APP_NAME="my-application"

export APP_NAME
```

## 12.5 ¿Qué hace exactamente `export`?

Marca la variable para que sea incluida en el entorno de los comandos externos que el Shell inicie posteriormente, según las reglas del Shell.

No publica automáticamente su valor a todas las aplicaciones abiertas.

## 12.6 ¿Es permanente?

No.

Si exportamos una variable dentro de una sesión interactiva, normalmente desaparecerá de esa sesión cuando termine, salvo que exista algún mecanismo que vuelva a definirla.

### Idea clave

**`export` controla la transmisión hacia procesos hijos, no la persistencia entre sesiones.**

---

# 13. Crear Environment Variables en PowerShell

En PowerShell podemos establecer una variable del entorno mediante:

```powershell
$env:APP_NAME = "my-application"
```

## 13.1 Consultar

```powershell
$env:APP_NAME
```

## 13.2 ¿La reciben los procesos hijos?

Normalmente sí, cuando se inician desde ese proceso PowerShell y heredan su entorno.

## 13.3 ¿Necesitamos `export`?

No.

`export` pertenece a la sintaxis de otros Shells.

## 13.4 Diferenciar variables

Variable de PowerShell:

```powershell
$appName = "my-application"
```

Environment Variable:

```powershell
$env:APP_NAME = "my-application"
```

No son equivalentes.

## 13.5 ¿Persiste entre sesiones?

Esta asignación modifica el entorno del proceso PowerShell actual.

No significa que la variable se haya guardado permanentemente en la configuración del usuario o del sistema.

### Idea clave

**La sintaxis cambia entre Shells, pero el concepto de entorno de proceso es compartido.**

---

# 14. Variable Expansion

**Variable Expansion** es el mecanismo mediante el cual el Shell sustituye una referencia a una variable por su valor.

## 14.1 Bash/Zsh

```bash
APP_NAME="my-app"

echo "$APP_NAME"
```

El Shell interpreta `$APP_NAME` y utiliza su valor.

## 14.2 Ejemplo

```bash
PROJECT_NAME="tooling-mastery"

echo "Project: $PROJECT_NAME"
```

Resultado:

```text
Project: tooling-mastery
```

## 14.3 Braces

Podemos delimitar explícitamente el nombre de la variable:

```bash
echo "${PROJECT_NAME}-2026"
```

Resultado:

```text
tooling-mastery-2026
```

## 14.4 ¿Por qué utilizar `${}`?

Para evitar ambigüedades al combinar nombres de variables con otros caracteres.

## 14.5 PowerShell

```powershell
$projectName = "tooling-mastery"

Write-Output "Project: $projectName"
```

PowerShell también permite utilizar delimitadores de variables cuando son necesarios.

### Idea clave

**Variable Expansion es una operación de interpretación del Shell; no debe confundirse con una búsqueda automática realizada por el sistema de archivos.**

---

# 15. Single Quotes vs Double Quotes

Las comillas afectan la interpretación de variables.

## 15.1 Bash/Zsh — Double Quotes

```bash
APP_NAME="my-app"

echo "Application: $APP_NAME"
```

Resultado:

```text
Application: my-app
```

Las comillas dobles permiten la expansión de variables en este contexto.

## 15.2 Bash/Zsh — Single Quotes

```bash
echo 'Application: $APP_NAME'
```

Resultado:

```text
Application: $APP_NAME
```

Las comillas simples impiden la expansión de la variable.

## 15.3 PowerShell — Double Quotes

```powershell
$appName = "my-app"

Write-Output "Application: $appName"
```

Resultado:

```text
Application: my-app
```

## 15.4 PowerShell — Single Quotes

```powershell
Write-Output 'Application: $appName'
```

Resultado:

```text
Application: $appName
```

## 15.5 ¿Por qué es importante?

Porque podemos necesitar:

- Insertar valores en cadenas.
- Preservar texto literal.
- Construir argumentos.
- Trabajar con rutas.
- Evitar interpretaciones inesperadas.

### Idea clave

**El tipo de comillas puede determinar si una variable se expande o se trata como texto literal.**

---

# 16. Environment Variable Scope

**Scope** significa alcance.

En este contexto, describe dónde está disponible una variable y durante cuánto tiempo.

Debemos distinguir varios niveles.

## 16.1 Process Scope

La variable está disponible en el entorno de un proceso.

## 16.2 Child Process Inheritance

Puede transmitirse a procesos hijos.

## 16.3 User-level Persistent Configuration

Un sistema puede ofrecer mecanismos para definir variables que se cargarán en futuros procesos del usuario.

## 16.4 System-level Persistent Configuration

También pueden existir configuraciones destinadas a futuros procesos de diferentes usuarios o servicios.

## 16.5 Project-level Configuration

Un proyecto puede definir convenciones o archivos que determinadas herramientas utilizan para preparar variables.

Pero un archivo de proyecto no se convierte automáticamente en una Environment Variable.

## 16.6 Comparación

| Nivel | Ejemplo | Característica |
|---|---|---|
| Shell variable | `APP_NAME="demo"` | Estado del Shell |
| Process environment | `export APP_ENV=dev` | Disponible para procesos hijos |
| User persistent configuration | Configuración del perfil | Puede aplicarse a futuras sesiones |
| System persistent configuration | Configuración del sistema | Puede aplicarse a futuros procesos del sistema |
| Project configuration | `.env` | Necesita un mecanismo de carga |

### Idea clave

**Scope y Persistence son conceptos relacionados, pero diferentes.**

---

# 17. Temporary Environment Variables

Una **Temporary Environment Variable** existe durante un alcance limitado.

Puede durar:

- Una sesión.
- Un proceso.
- Un comando.
- Una ejecución de pruebas.

## 17.1 Bash/Zsh — Una sesión

```bash
export APP_ENV="development"
```

La variable queda disponible para los procesos hijos iniciados posteriormente desde esa sesión.

## 17.2 Bash/Zsh — Un comando

```bash
APP_ENV="testing" printenv APP_ENV
```

Resultado:

```text
testing
```

La asignación se aplica al entorno de ese comando.

No equivale a establecer permanentemente la variable para toda la sesión.

## 17.3 Ejemplo conceptual

```text
Shell
│
├── APP_ENV=development
│
└── Command
      │
      └── APP_ENV=testing
```

El comando puede recibir un valor distinto del entorno general del Shell.

## 17.4 PowerShell

En PowerShell podemos establecer temporalmente una variable, ejecutar un comando y restaurar el estado anterior.

Sin embargo, para hacerlo correctamente debemos considerar si la variable existía y cuál era su valor original.

No debemos asumir que asignarle una cadena vacía equivale siempre a restaurar su estado previo.

### Idea clave

**Una configuración temporal permite adaptar una ejecución sin modificar necesariamente la configuración persistente de la máquina.**

---

# 18. Persistent Environment Variables

Una variable persistente es aquella cuya definición se conserva mediante algún mecanismo de configuración y puede aplicarse a futuros procesos.

## 18.1 Bash y Zsh

Podemos encontrar configuraciones en archivos como:

```text
~/.bashrc
~/.bash_profile
~/.profile
~/.zshrc
~/.zprofile
```

Pero estos archivos no se ejecutan siempre en las mismas circunstancias.

Su carga depende del Shell y del tipo de sesión.

## 18.2 Ejemplo conceptual

```bash
export APP_ENV="development"
```

Podría formar parte de un archivo de inicialización del Shell.

No obstante, eso no significa que sea la mejor ubicación para todas las variables.

## 18.3 Windows

Windows ofrece mecanismos de configuración de variables para usuario y sistema.

También existen diferencias entre:

- Variables del proceso actual.
- Variables persistentes del usuario.
- Variables persistentes del sistema.

## 18.4 ¿Por qué debemos tener cuidado?

Porque una variable persistente puede afectar:

- Nuevas terminales.
- Herramientas.
- Editores.
- Procesos iniciados posteriormente.
- Aplicaciones que reconozcan esa variable.

## 18.5 Regla profesional

**No debemos convertir automáticamente una configuración específica de un proyecto en una variable persistente de toda nuestra máquina.**

---

# 19. Environment Variables y Shell Startup Files

Los Shells pueden cargar configuraciones al iniciar determinadas sesiones.

Por ejemplo:

```text
Shell Starts
     │
     ▼
Startup Configuration
     │
     ▼
Variables and Settings
     │
     ▼
Interactive Session
```

## 19.1 Bash

Dependiendo de si la sesión es Login, Interactive o Non-interactive, Bash puede leer diferentes archivos de inicialización.

## 19.2 Zsh

Zsh también dispone de diferentes archivos de configuración según la fase de inicio y el tipo de sesión.

## 19.3 PowerShell

PowerShell utiliza perfiles que pueden ejecutar instrucciones al iniciar determinadas sesiones.

## 19.4 ¿Qué problema puede aparecer?

Una variable puede existir en una terminal y no en otra.

Por ejemplo:

```text
Terminal A
APP_ENV=development
```

```text
Terminal B
APP_ENV=undefined
```

## 19.5 Posibles causas

- Diferentes Shells.
- Diferentes archivos de inicio.
- Sesiones abiertas antes de cambiar una configuración.
- Procesos iniciados desde aplicaciones diferentes.
- Variables definidas solamente en una sesión.
- Entornos Windows y WSL separados.

### Idea clave

**Que una variable exista en una terminal no garantiza que exista en todas las demás.**

---

# 20. Environment Variables importantes

Existen variables utilizadas habitualmente por sistemas operativos y herramientas.

## 20.1 `HOME`

En entornos Unix-like suele identificar el directorio personal del usuario.

```bash
echo "$HOME"
```

## 20.2 `USER`

En muchos entornos Unix-like identifica el nombre del usuario.

```bash
echo "$USER"
```

## 20.3 `SHELL`

En sistemas Unix-like suele indicar el Shell configurado para el usuario.

```bash
echo "$SHELL"
```

No garantiza identificar el Shell actualmente en ejecución.

## 20.4 `PATH`

Indica una lista de directorios que determinadas herramientas utilizan para buscar comandos ejecutables.

```bash
echo "$PATH"
```

La estudiaremos en profundidad en el siguiente documento.

## 20.5 `LANG`

Puede influir en configuraciones regionales utilizadas por aplicaciones compatibles.

```bash
echo "$LANG"
```

## 20.6 `TMPDIR`, `TMP` y `TEMP`

Pueden utilizarse para indicar ubicaciones temporales, según el sistema y la herramienta.

## 20.7 `USERPROFILE`

En Windows suele identificar el directorio de perfil del usuario.

```powershell
$env:USERPROFILE
```

## 20.8 `APP_ENV`

Es un nombre ilustrativo para una variable de aplicación.

No tiene significado universal.

### Idea clave

**Algunas variables son convenciones del sistema; otras son contratos definidos por aplicaciones concretas.**

---

# 21. Environment Variables y PATH

`PATH` es una de las Environment Variables más importantes del Developer Tooling.

Ejemplo conceptual:

```text
PATH=/usr/local/bin:/usr/bin:/bin
```

En entornos Unix-like, los directorios suelen separarse mediante `:`.

En Windows, el separador habitual entre entradas de `Path` es `;`.

## 21.1 ¿Para qué sirve?

Ayuda a localizar programas ejecutables cuando escribimos un nombre de comando.

Ejemplo:

```bash
node
```

El Shell puede utilizar `PATH` para localizar un ejecutable llamado `node`, siguiendo sus reglas de resolución.

## 21.2 ¿Por qué importa?

Porque podemos tener varias instalaciones de una misma herramienta.

Ejemplo:

```text
Node.js Version A
Node.js Version B
```

La configuración y el orden de búsqueda pueden influir en cuál se ejecuta.

## 21.3 ¿Modificaremos PATH ahora?

No.

Primero necesitamos comprenderlo correctamente.

Lo estudiaremos en el siguiente documento.

### Idea clave

**PATH conecta las variables de entorno con la resolución de comandos ejecutables.**

---

# 22. Environment Variables y Node.js

Node.js permite consultar Environment Variables mediante:

```javascript
process.env
```

## 22.1 Ejemplo

```javascript
const appEnvironment = process.env.APP_ENV;

console.log(appEnvironment);
```

## 22.2 ¿Qué representa `process.env`?

Es una interfaz proporcionada por Node.js para acceder al entorno del proceso.

## 22.3 Ejemplo con un puerto

```javascript
const port = process.env.APP_PORT ?? "3000";

console.log(port);
```

Si `APP_PORT` no está definida, utilizamos el valor predeterminado.

## 22.4 Importante: los valores son cadenas

Aunque definamos:

```text
APP_PORT=3000
```

En Node.js obtenemos normalmente:

```javascript
"3000"
```

No un número.

## 22.5 Conversión y validación

Podemos convertir y validar:

```javascript
const rawPort = process.env.APP_PORT ?? "3000";

const port = Number(rawPort);

if (!Number.isInteger(port) || port < 1 || port > 65535) {
  throw new Error("APP_PORT must be a valid TCP port");
}

console.log(port);
```

## 22.6 ¿Por qué validar?

Porque una Environment Variable puede:

- No existir.
- Contener un valor inesperado.
- Tener un formato incorrecto.
- Ser modificada por el entorno de ejecución.

### Idea clave

**Las Environment Variables son entradas externas de configuración y deben validarse cuando su contenido afecta al comportamiento del programa.**

---

# 23. Environment Variables y Application Configuration

Imaginemos una aplicación que puede ejecutarse en diferentes entornos.

```text
Development
Testing
Production
```

Podríamos utilizar una variable como:

```text
APP_ENV
```

Con valores:

```text
development
testing
production
```

## 23.1 ¿Por qué?

Porque algunos comportamientos pueden variar según el entorno.

Por ejemplo:

- Nivel de Logging.
- Servicios externos.
- URLs.
- Configuraciones de observabilidad.
- Determinadas opciones de ejecución.

## 23.2 ¿Debemos cambiar el código fuente?

No necesariamente.

Podemos proporcionar configuraciones distintas durante la ejecución.

## 23.3 Modelo

```text
Application Code
       │
       ▼
Read Configuration
       │
       ├── Development
       ├── Testing
       └── Production
```

## 23.4 Precaución

No debemos asumir que cambiar una variable convierte automáticamente una aplicación en segura para producción.

La seguridad y el comportamiento correcto requieren más controles.

### Idea clave

**Las Environment Variables ayudan a separar parte de la configuración del código, pero no sustituyen la validación ni la gestión profesional de entornos.**

---

# 24. Environment Variables vs `.env` Files

Este es uno de los conceptos que más confusión genera.

## 24.1 Environment Variable

Es una entrada disponible en el entorno de un proceso.

Ejemplo:

```text
APP_PORT=3000
```

## 24.2 `.env` File

Es un archivo que, por convención, puede contener pares de configuración.

Ejemplo:

```dotenv
APP_PORT=3000
APP_ENV=development
```

## 24.3 ¿Son lo mismo?

No.

Un archivo `.env` es un archivo.

Una Environment Variable pertenece al entorno de un proceso.

## 24.4 ¿Cómo se relacionan?

Una herramienta puede leer un archivo `.env` y utilizar sus valores para preparar o modificar la configuración disponible para una aplicación.

```text
.env File
    │
    ▼
Configuration Loader
    │
    ▼
Process Environment / Application Configuration
    │
    ▼
Application
```

## 24.5 ¿El sistema operativo carga `.env` automáticamente?

No de forma universal.

## 24.6 ¿El Shell carga `.env` automáticamente?

No debemos asumirlo.

## 24.7 ¿Node.js puede trabajar con `.env`?

Sí, mediante mecanismos compatibles con su versión y configuración, o utilizando herramientas específicas.

Pero el comportamiento exacto depende de cómo iniciemos la aplicación.

### Idea clave

**Un archivo `.env` no es una Environment Variable hasta que algún mecanismo interpreta sus valores y los pone a disposición del programa.**

---

# 25. `.env` vs `.env.example`

En proyectos profesionales es habitual encontrar:

```text
.env
.env.example
```

## 25.1 `.env`

Puede contener valores utilizados por un entorno local.

Ejemplo:

```dotenv
APP_PORT=3000
API_BASE_URL=http://localhost:4000
```

También puede contener secretos.

## 25.2 `.env.example`

Suele utilizarse como plantilla documentada.

Ejemplo:

```dotenv
APP_PORT=3000
API_BASE_URL=
```

## 25.3 Diferencia principal

| Archivo | Propósito |
|---|---|
| `.env` | Valores concretos de un entorno |
| `.env.example` | Plantilla de configuración esperada |

## 25.4 ¿Debemos subir `.env` a Git?

No debemos subir archivos que contengan secretos.

En muchos proyectos, `.env` se excluye mediante `.gitignore`.

Sin embargo, la decisión depende de la política del proyecto y del contenido real.

## 25.5 ¿Debemos subir `.env.example`?

Habitualmente sí, si no contiene información sensible.

Puede ayudar a documentar qué variables necesita el proyecto.

### Idea clave

**Una plantilla de configuración debe explicar qué necesita la aplicación sin revelar credenciales.**

---

# 26. Environment Variables y Secrets

Un **Secret** es información sensible que requiere protección.

Ejemplos:

- API Keys.
- Access Tokens.
- Passwords.
- Private Keys.
- Credenciales de servicios.

Las Environment Variables pueden utilizarse para transportar secretos hacia procesos.

Pero esto no significa que proporcionen protección automáticamente.

## 26.1 Riesgos

Los secretos pueden exponerse mediante:

- Logs.
- Capturas de pantalla.
- Comandos de diagnóstico.
- Scripts.
- Procesos con acceso suficiente.
- Herramientas de observabilidad mal configuradas.
- Archivos incluidos accidentalmente en Git.
- Historial de comandos.

## 26.2 Ejemplo conceptual

```text
API_TOKEN=<secret-value>
```

No debemos imprimir su valor para comprobar simplemente que existe.

## 26.3 ¿Qué deberíamos hacer?

- Evitar mostrar secretos.
- No incluirlos en ejemplos compartidos.
- No subirlos a Git.
- Aplicar permisos mínimos.
- Utilizar mecanismos de gestión de secretos apropiados.
- Rotarlos si se exponen.
- Validar qué procesos necesitan acceder a ellos.

## 26.4 ¿Environment Variables sustituyen a Secret Managers?

No.

Son mecanismos distintos.

Un Secret Manager puede proporcionar controles de acceso, auditoría, rotación y distribución que una variable de entorno por sí sola no ofrece.

### Idea clave

**Las Environment Variables pueden transportar secretos, pero no son por sí mismas una solución completa de gestión de secretos.**

---

# 27. Environment Variables y Git

Git también puede consultar variables de entorno.

Algunas influyen en:

- Configuración.
- Identidad.
- Ubicaciones.
- Comportamiento de determinados comandos.

## 27.1 Ejemplo conceptual

Un proceso Git puede recibir variables específicas que modifiquen parte de su comportamiento.

## 27.2 ¿Esto sustituye a Git Config?

No.

Git dispone de diferentes mecanismos de configuración.

Entre ellos:

- Configuración del sistema.
- Configuración global del usuario.
- Configuración local del repositorio.
- Variables de entorno.
- Opciones proporcionadas al comando.

Las reglas de precedencia dependen de cada configuración y mecanismo.

## 27.3 ¿Por qué importa?

Porque un comando Git puede comportarse de manera diferente entre:

- Tu terminal personal.
- Una terminal corporativa.
- Un Script.
- CI/CD.
- Un contenedor.

### Idea clave

**El entorno del proceso puede influir en Git, pero no debemos confundirlo con la configuración almacenada del repositorio.**

---

# 28. Environment Variables y Package Managers

Herramientas como npm y pnpm también pueden utilizar Environment Variables.

Por ejemplo, algunas variables pueden influir en:

- Configuraciones de red.
- Directorios.
- Comportamiento de ejecución.
- Opciones de herramientas.
- Acceso a servicios.

## 28.1 ¿Por qué importa?

Porque una instalación de dependencias puede funcionar en una máquina y fallar en otra.

## 28.2 Ejemplo conceptual

```text
Developer Machine
      │
      └── Proxy Configuration
              │
              ▼
       Package Registry
```

En una red corporativa, determinadas variables pueden influir en las conexiones de las herramientas.

## 28.3 ¿Debemos configurar npm o pnpm ahora?

No.

Estudiaremos su configuración en módulos posteriores.

### Idea clave

**El comportamiento de un Package Manager puede depender tanto del proyecto como del entorno donde se ejecuta.**

---

# 29. Environment Variables y CI/CD

En CI/CD, los procesos se ejecutan dentro de entornos preparados por una plataforma o Runner.

Podemos tener:

```text
CI Runner
    │
    ▼
Environment Configuration
    │
    ▼
Build Process
    │
    ▼
Test Process
```

## 29.1 ¿Por qué utilizar Environment Variables?

Para proporcionar configuraciones específicas a los procesos.

## 29.2 Ejemplos

- Identificador del entorno.
- URLs de servicios.
- Opciones de ejecución.
- Credenciales gestionadas por la plataforma.
- Indicadores de ejecución automatizada.

## 29.3 ¿Son las mismas variables que en local?

No necesariamente.

## 29.4 ¿Por qué fallan algunos proyectos en CI?

Porque dependen de variables definidas únicamente en la computadora del desarrollador.

## 29.5 Buena práctica

Documentar las variables necesarias y comprobar su presencia durante la inicialización de la aplicación o herramienta.

### Idea clave

**Una aplicación reproducible debe declarar sus necesidades de configuración, no depender de variables desconocidas de una máquina concreta.**

---

# 30. Environment Variables y Reproducibility

Recordemos el concepto de **Reproducible Environment**.

Queremos que diferentes desarrolladores puedan ejecutar un proyecto con resultados consistentes.

Las Environment Variables pueden afectar esa consistencia.

## 30.1 Ejemplo

Desarrollador A:

```text
APP_ENV=development
```

Desarrollador B:

```text
APP_ENV=testing
```

Si la aplicación utiliza esta variable, ambos podrían observar comportamientos diferentes.

## 30.2 ¿Cómo mejorar la reproducibilidad?

- Documentar variables necesarias.
- Definir valores predeterminados cuando corresponda.
- Validar valores.
- Proporcionar plantillas.
- Separar secretos de configuración pública.
- Establecer convenciones por entorno.
- Evitar dependencias globales innecesarias.

## 30.3 ¿Debemos compartir todos los valores?

No.

Los secretos y configuraciones sensibles deben distribuirse mediante mecanismos apropiados.

### Idea clave

**La reproducibilidad requiere controlar y documentar la configuración, no necesariamente compartir todos sus valores.**

---

# 31. Troubleshooting: Variable Not Found

Uno de los errores más frecuentes es que una aplicación no encuentre una variable.

## 31.1 Síntoma

La aplicación espera:

```text
APP_PORT
```

Pero recibe un valor ausente.

## 31.2 Posibles causas

- La variable nunca fue definida.
- Fue definida como Shell Variable, pero no exportada.
- Se definió en otra terminal.
- El proceso se inició antes de configurarla.
- Se definió en otro usuario.
- El Shell no cargó el archivo esperado.
- Se utilizó un nombre diferente.
- El archivo `.env` no fue cargado.
- La herramienta utiliza otro mecanismo de configuración.

## 31.3 Diagnóstico en Bash/Zsh

```bash
printenv APP_PORT
```

## 31.4 Diagnóstico en PowerShell

```powershell
$env:APP_PORT
```

## 31.5 Preguntas de diagnóstico

1. ¿Qué proceso necesita la variable?
2. ¿Dónde se definió?
3. ¿Se exportó correctamente?
4. ¿El proceso se inició después?
5. ¿Se está utilizando el Shell esperado?
6. ¿La variable pertenece a otro entorno?
7. ¿La aplicación realmente consulta ese nombre?

### Idea clave

**Cuando una variable no aparece, debemos investigar su origen, alcance y transmisión hacia el proceso.**

---

# 32. Troubleshooting: Works in Terminal but Not in VS Code

Este problema es frecuente.

## 32.1 Situación

En una terminal externa:

```text
APP_ENV=development
```

Pero en la terminal integrada de VS Code:

```text
APP_ENV=undefined
```

## 32.2 Posibles causas

- VS Code se inició con otro entorno.
- Utiliza otro Shell.
- Se cargaron diferentes Startup Files.
- La variable fue definida después de iniciar VS Code.
- Se configuró solo en una sesión.
- El proceso utiliza un entorno distinto.

## 32.3 Modelo

```text
Operating System
      │
      ├── Terminal Application
      │        │
      │        └── Shell A
      │
      └── VS Code
               │
               └── Integrated Terminal
                        │
                        └── Shell B
```

Los entornos pueden diferir.

## 32.4 Diagnóstico

Comparar únicamente variables no sensibles.

Por ejemplo:

Bash/Zsh:

```bash
echo "$SHELL"
echo "$HOME"
```

PowerShell:

```powershell
$HOME
```

También debemos identificar cómo se iniciaron ambos procesos.

### Idea clave

**Dos terminales pueden utilizar el mismo Shell y aun así tener entornos diferentes.**

---

# 33. Troubleshooting: Variable Has an Unexpected Value

## 33.1 Situación

Esperamos:

```text
APP_ENV=development
```

Pero la aplicación recibe:

```text
APP_ENV=production
```

## 33.2 Posibles causas

- Configuración persistente.
- Archivo de inicio.
- Variable definida por un proceso padre.
- Configuración de la herramienta.
- Script que modifica el entorno.
- Archivo `.env` cargado con reglas de precedencia específicas.

## 33.3 ¿Qué debemos investigar?

- Dónde se define el valor.
- Cuándo se define.
- Qué mecanismo lo carga.
- Qué reglas de precedencia utiliza la herramienta.
- Si el proceso se reinició después de cambiarlo.

## 33.4 Precaución

No debemos asumir que un archivo `.env` sobrescribe siempre una variable existente.

El comportamiento depende del mecanismo de carga utilizado.

### Idea clave

**El valor efectivo de una variable depende de cómo se construyó el entorno del proceso.**

---

# 34. Práctica 01 — Shell Variables

Esta práctica está diseñada para Bash y Zsh.

## Objetivo

Comprender la diferencia entre asignar y exportar una variable.

## Paso 1 — Crear una variable

```bash
TOOLING_TOPIC="environment-variables"
```

## Paso 2 — Consultarla

```bash
echo "$TOOLING_TOPIC"
```

Resultado:

```text
environment-variables
```

## Paso 3 — Consultar si está exportada

```bash
printenv TOOLING_TOPIC
```

En una sesión donde la variable no estaba previamente exportada, no debería aparecer.

## Paso 4 — Exportarla

```bash
export TOOLING_TOPIC
```

## Paso 5 — Consultar nuevamente

```bash
printenv TOOLING_TOPIC
```

Resultado esperado:

```text
environment-variables
```

## Reflexión

1. ¿Qué diferencia observaste?
2. ¿La variable existía antes de exportarla?
3. ¿Qué cambia cuando utilizamos `export`?
4. ¿La variable será permanente después de cerrar la sesión?

---

# 35. Práctica 02 — Process Inheritance

Utilizaremos Bash o Zsh.

## Objetivo

Comprobar que un proceso hijo puede recibir una variable exportada.

## Paso 1 — Definir la variable

```bash
export TOOLING_LEVEL="beginner"
```

## Paso 2 — Iniciar un proceso hijo

Si Bash está instalado:

```bash
bash -c 'printenv TOOLING_LEVEL'
```

Resultado esperado:

```text
beginner
```

## Paso 3 — Modificar la variable dentro del hijo

```bash
bash -c 'export TOOLING_LEVEL="advanced"; printenv TOOLING_LEVEL'
```

Resultado:

```text
advanced
```

## Paso 4 — Consultar nuevamente en el padre

```bash
printenv TOOLING_LEVEL
```

Resultado esperado:

```text
beginner
```

## Reflexión

1. ¿El proceso hijo recibió la variable?
2. ¿Pudo modificar su propio valor?
3. ¿Cambió el valor del proceso padre?
4. ¿Qué nos demuestra sobre Process Inheritance?

---

# 36. Práctica 03 — PowerShell Environment Variables

Esta práctica está diseñada para PowerShell.

## Paso 1 — Crear una variable de PowerShell

```powershell
$toolingTopic = "environment-variables"
```

## Paso 2 — Consultarla

```powershell
$toolingTopic
```

## Paso 3 — Crear una Environment Variable

```powershell
$env:TOOLING_TOPIC = "environment-variables"
```

## Paso 4 — Consultarla

```powershell
$env:TOOLING_TOPIC
```

## Paso 5 — Comparar

Responde:

1. ¿Qué diferencia existe entre `$toolingTopic` y `$env:TOOLING_TOPIC`?
2. ¿Cuál pertenece al entorno del proceso?
3. ¿Cuál podría recibir normalmente un proceso hijo?
4. ¿La asignación es persistente entre nuevas sesiones?

### Aprendizaje

**PowerShell dispone de variables propias y de un mecanismo específico para trabajar con Environment Variables.**

---

# 37. Práctica 04 — Temporary Command Environment

Esta práctica está diseñada para Bash y Zsh.

## Objetivo

Comprender las variables aplicadas a una única ejecución.

## Paso 1 — Ejecutar

```bash
TOOLING_MODE="practice" printenv TOOLING_MODE
```

Resultado esperado:

```text
practice
```

## Paso 2 — Consultar la sesión

```bash
printenv TOOLING_MODE
```

Si la variable no estaba definida previamente en la sesión, normalmente no aparecerá.

## Paso 3 — Reflexión

1. ¿Por qué el primer comando pudo leerla?
2. ¿Por qué no necesariamente permanece después?
3. ¿En qué situaciones sería útil esta técnica?
4. ¿Qué ventajas ofrece frente a modificar una configuración persistente?

---

# 38. Práctica 05 — Environment Audit

Realizaremos una pequeña auditoría no destructiva.

No modificaremos configuraciones del sistema.

## Bash/Zsh

```bash
echo "$HOME"
```

```bash
echo "$SHELL"
```

```bash
printenv LANG
```

```bash
printenv PATH
```

**Precaución:** `PATH` puede revelar nombres de usuario y ubicaciones locales. No compartas su salida completa públicamente sin revisarla.

## PowerShell

```powershell
$HOME
```

```powershell
$env:USERPROFILE
```

```powershell
$env:Path
```

## Preguntas

1. ¿Qué variables existen?
2. ¿Cuáles dependen del sistema operativo?
3. ¿Cuáles dependen del usuario?
4. ¿Qué variables podrían influir en herramientas de desarrollo?
5. ¿Qué información no deberíamos compartir sin revisarla?

---

# 39. Práctica 06 — Diseñar la configuración de una aplicación

Imaginemos una aplicación Backend con estas necesidades:

- Puerto HTTP.
- URL de base de datos.
- Entorno de ejecución.
- Nivel de Logging.

## Paso 1 — Identificar variables

Podríamos diseñar:

```dotenv
APP_PORT=3000
APP_ENV=development
DATABASE_URL=
LOG_LEVEL=info
```

## Paso 2 — Clasificar

| Variable | Propósito | ¿Potencialmente sensible? |
|---|---|---|
| `APP_PORT` | Puerto del servidor | Normalmente no |
| `APP_ENV` | Entorno de ejecución | Normalmente no |
| `DATABASE_URL` | Conexión a base de datos | Sí, si contiene credenciales |
| `LOG_LEVEL` | Nivel de Logging | Normalmente no |

## Paso 3 — Diseñar validaciones

Preguntas:

1. ¿`APP_PORT` es un número válido?
2. ¿`APP_ENV` pertenece a los valores permitidos?
3. ¿`DATABASE_URL` está presente cuando se necesita?
4. ¿`LOG_LEVEL` utiliza un valor reconocido?
5. ¿Qué valores pueden tener Default?
6. ¿Cuáles deberían ser obligatorios?

## Paso 4 — Diseñar una plantilla

```dotenv
APP_PORT=3000
APP_ENV=development
DATABASE_URL=
LOG_LEVEL=info
```

La plantilla no debe contener credenciales reales.

### Aprendizaje

**La configuración profesional comienza identificando necesidades, tipos de datos, valores permitidos y responsabilidades.**

---

# 40. Casos reales de ingeniería

## Caso 1 — Node.js no recibe una variable

### Situación

Un desarrollador escribe:

```bash
APP_PORT=3000
```

Después inicia Node.js.

La aplicación no recibe `APP_PORT`.

### Posible causa

La variable no fue exportada.

### Solución conceptual

Comprender la diferencia entre Shell Variable y Environment Variable.

---

## Caso 2 — Una API utiliza una URL equivocada

### Situación

La aplicación utiliza una variable como:

```text
API_BASE_URL
```

Pero apunta a otro entorno.

### Posible causa

El proceso recibió un valor diferente del esperado.

### Solución conceptual

Revisar el origen y la precedencia de la configuración sin exponer secretos.

---

## Caso 3 — Funciona en local, falla en CI

### Situación

El desarrollador tiene variables configuradas manualmente en su computadora.

CI no las recibe.

### Posible causa

El proyecto depende de configuración no documentada.

### Solución conceptual

Declarar y validar las necesidades de configuración.

---

## Caso 4 — Funciona en PowerShell, falla en Git Bash

### Situación

Una variable fue definida dentro de una sesión PowerShell.

Después se abre Git Bash de manera independiente.

### Posible causa

Los procesos no comparten automáticamente las modificaciones temporales realizadas en otras sesiones.

### Solución conceptual

Comprender Process Scope e Inheritance.

---

## Caso 5 — `.env` existe, pero la aplicación no encuentra la variable

### Situación

Tenemos:

```text
.env
```

Pero Node.js no recibe el valor esperado.

### Posible causa

No existe un mecanismo activo que cargue el archivo.

### Solución conceptual

Distinguir el archivo de configuración del entorno real del proceso.

---

## Caso 6 — Una variable contiene un número inválido

### Situación

Tenemos:

```text
APP_PORT=hello
```

La aplicación espera un puerto numérico.

### Posible causa

No se validó la configuración.

### Solución conceptual

Convertir y validar los valores antes de utilizarlos.

---

# 41. Errores frecuentes

### Error 1 — Confundir Shell Variables y Environment Variables

No todas las variables del Shell se transmiten a procesos hijos.

### Error 2 — Pensar que `export` guarda permanentemente una variable

Exportar no equivale a persistir.

### Error 3 — Pensar que todos los procesos comparten el mismo entorno

Cada proceso dispone de su propio entorno.

### Error 4 — Suponer que un hijo puede modificar el entorno del padre

No existe sincronización automática en esa dirección.

### Error 5 — Confundir variables de JavaScript con variables del sistema

Pertenecen a contextos diferentes.

### Error 6 — Suponer que `.env` se carga automáticamente

Se necesita un mecanismo compatible de carga.

### Error 7 — Guardar secretos en Git

Puede provocar exposición de credenciales.

### Error 8 — Imprimir todo el entorno para diagnosticar

Podría revelar información sensible.

### Error 9 — Tratar valores de Environment Variables como números

En Node.js se reciben normalmente como cadenas.

### Error 10 — No validar valores

Puede provocar errores o comportamientos inesperados.

### Error 11 — Definir variables específicas del proyecto globalmente

Puede contaminar otros entornos.

### Error 12 — Pensar que todas las terminales tienen las mismas variables

Depende de cómo se iniciaron y configuraron.

### Error 13 — Confundir Scope y Persistence

Una variable puede tener un alcance limitado aunque su definición esté almacenada en una configuración persistente.

### Error 14 — Asumir reglas universales de precedencia

Cada herramienta puede aplicar reglas diferentes.

### Error 15 — No documentar las variables necesarias

Dificulta Onboarding, Testing y CI/CD.

---

# 42. Comprueba tu modelo mental

1. ¿Qué es una Variable?
2. ¿Qué es un Environment?
3. ¿Qué es una Environment Variable?
4. ¿Qué es una Shell Variable?
5. ¿Cuál es la diferencia entre Shell Variable y Environment Variable?
6. ¿Qué hace `export`?
7. ¿`export` hace que una variable sea permanente?
8. ¿Qué es un Process?
9. ¿Qué es un Parent Process?
10. ¿Qué es un Child Process?
11. ¿Qué significa Process Inheritance?
12. ¿Un proceso hijo recibe siempre todas las variables del padre sin modificaciones?
13. ¿Puede un proceso hijo modificar automáticamente el entorno del padre?
14. ¿Cómo consultas una variable en Bash?
15. ¿Cómo consultas una Environment Variable en PowerShell?
16. ¿Qué significa `$env:`?
17. ¿Cómo creas una Shell Variable en Bash?
18. ¿Cómo exportas una variable?
19. ¿Qué es Variable Expansion?
20. ¿Qué diferencia existe entre Single Quotes y Double Quotes?
21. ¿Qué significa Scope?
22. ¿Qué significa Persistence?
23. ¿Qué es una Temporary Environment Variable?
24. ¿Qué es una Persistent Environment Variable?
25. ¿Por qué dos terminales pueden tener entornos diferentes?
26. ¿Qué representa `HOME`?
27. ¿Qué representa `SHELL`?
28. ¿Qué representa `PATH`?
29. ¿Qué relación existe entre `PATH` y los ejecutables?
30. ¿Cómo consulta Node.js las Environment Variables?
31. ¿Qué representa `process.env`?
32. ¿Por qué debemos convertir valores numéricos?
33. ¿Qué diferencia existe entre `.env` y una Environment Variable?
34. ¿El sistema operativo carga `.env` automáticamente?
35. ¿Qué es `.env.example`?
36. ¿Por qué no debemos subir secretos a Git?
37. ¿Una Environment Variable protege automáticamente un Secret?
38. ¿Por qué una aplicación puede funcionar en local y fallar en CI?
39. ¿Qué ocurre si una variable no existe?
40. ¿Por qué debemos validar la configuración?
41. ¿Cómo investigarías una variable ausente?
42. ¿Qué problemas pueden aparecer al definir variables globalmente?
43. ¿Qué información deberíamos documentar en un proyecto?
44. ¿Cómo mejorarías la reproducibilidad de una aplicación?
45. ¿Cuál es la diferencia entre configuración de aplicación y entorno de proceso?

---

# 43. Checklist de aprendizaje

## Fundamentals

- [ ] Comprendo qué es una Variable.
- [ ] Comprendo qué es un Environment.
- [ ] Comprendo qué es una Environment Variable.
- [ ] Diferencio Shell Variables y Environment Variables.
- [ ] Comprendo Process Inheritance.

## Shell Operations

- [ ] Sé crear variables en Bash/Zsh.
- [ ] Sé utilizar `export`.
- [ ] Sé consultar variables con `echo`.
- [ ] Sé consultar variables con `printenv`.
- [ ] Sé crear Environment Variables en PowerShell.
- [ ] Comprendo Variable Expansion.
- [ ] Comprendo Single Quotes y Double Quotes.

## Scope and Persistence

- [ ] Comprendo Process Scope.
- [ ] Diferencio variables temporales y persistentes.
- [ ] Sé que un proceso hijo no modifica automáticamente el entorno del padre.
- [ ] Comprendo por qué diferentes terminales pueden tener entornos diferentes.
- [ ] Reconozco el papel de los Shell Startup Files.

## Professional Development

- [ ] Comprendo `process.env` en Node.js.
- [ ] Sé que los valores deben validarse.
- [ ] Diferencio `.env` y Environment Variables.
- [ ] Comprendo el propósito de `.env.example`.
- [ ] Reconozco riesgos al utilizar secretos.
- [ ] Comprendo la relación con Git, Package Managers y CI/CD.
- [ ] Puedo diagnosticar variables ausentes o incorrectas.

---

# 44. Resumen conceptual

Nuestro modelo mental queda así:

```text
Operating System
       │
       ▼
Terminal Application
       │
       ▼
Shell Process
       │
       ├── Shell Variables
       │
       └── Environment Variables
                 │
                 │ Process Creation
                 ▼
            Child Process
                 │
                 ▼
         Application Runtime
                 │
                 ▼
       Read Environment Values
                 │
                 ▼
       Application Configuration
```

Debemos recordar tres diferencias fundamentales:

```text
Shell Variable
      ≠
Environment Variable
```

```text
Environment Variable
      ≠
.env File
```

```text
Exported Variable
      ≠
Persistent Variable
```

Estas distinciones serán esenciales en los siguientes módulos.

---

# 45. Idea clave

**Las Environment Variables permiten proporcionar configuración a los procesos, pero su disponibilidad depende de cómo se construye y transmite el entorno de ejecución.**

Un ingeniero de software debe comprender:

- Quién define una variable.
- Dónde se define.
- Qué procesos pueden recibirla.
- Cuánto tiempo permanece disponible.
- Cómo se interpreta su valor.
- Qué riesgos de seguridad presenta.
- Cómo documentarla y validarla.

No se trata únicamente de aprender `export` o `process.env`.

Se trata de comprender cómo los programas reciben información del entorno donde se ejecutan.

---

# 46. Siguiente paso

Ahora que comprendemos las Environment Variables, estudiaremos una de las más importantes para cualquier desarrollador:

**PATH**.

Aprenderemos:

- Cómo encuentra el Shell los comandos.
- Qué es un Executable.
- Cómo funciona Command Resolution.
- Qué ocurre cuando tenemos varias versiones de una herramienta.
- Cómo inspeccionar PATH.
- Cómo diagnosticar `command not found`.
- Cómo evitar conflictos entre herramientas instaladas.

👉 [06 — PATH and Command Resolution](./06-path-and-command-resolution.md)

**Primero aprendimos cómo los procesos reciben variables. Ahora comprenderemos cómo el Shell encuentra los programas que ejecutamos.**