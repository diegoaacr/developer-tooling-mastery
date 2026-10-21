# macOS PATH Configuration

Cuando trabajamos desde la Terminal de macOS, ejecutamos comandos como:

```bash
git --version
node --version
brew --version
```

Estos comandos parecen sencillos, pero detrás existe un mecanismo que permite al Shell localizar los programas correspondientes.

Ese mecanismo está relacionado principalmente con una variable de entorno llamada **`PATH`**.

Comprender cómo funciona `PATH` es fundamental para evitar conflictos entre herramientas, diagnosticar errores y administrar correctamente nuestro Development Environment.

En este documento estudiaremos cómo funciona la resolución de comandos en macOS, qué archivos utiliza Zsh para configurar su entorno y cómo integrar herramientas como Homebrew sin introducir configuraciones innecesarias.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder explicar:

- Qué es `PATH` y qué problema resuelve.
- Qué diferencia existe entre un comando y un ejecutable.
- Cómo busca el Shell un comando.
- Qué importancia tiene el orden de los directorios en `PATH`.
- Qué son las Environment Variables.
- Qué diferencia existe entre variables locales y exportadas.
- Qué archivos de configuración utiliza Zsh.
- Qué diferencia existe entre `.zprofile`, `.zshrc` y `.zshenv`.
- Cómo se relacionan los Login Shells y los Interactive Shells.
- Cómo se integra Homebrew mediante `brew shellenv`.
- Cómo investigar conflictos entre diferentes versiones de una herramienta.
- Cómo modificar `PATH` de forma controlada.
- Cómo diagnosticar errores de configuración.
- Qué prácticas ayudan a mantener un entorno limpio y reproducible.

---

## 🧠 1. El problema: Command Not Found

Imagina que instalamos una herramienta.

Por ejemplo, Node.js.

Después abrimos nuestra Terminal y ejecutamos:

```bash
node --version
```

Pero obtenemos:

```text
zsh: command not found: node
```

¿Qué significa?

El Shell no ha conseguido resolver el comando `node` en esa sesión.

Esto puede suceder por diferentes razones:

- Node.js no está instalado.
- El ejecutable no está disponible en los directorios de búsqueda.
- La configuración del Shell es incorrecta.
- Un gestor de versiones no está inicializado.
- Estamos utilizando una sesión diferente de la habitual.

Por tanto:

**Command Not Found no significa necesariamente que la herramienta no esté instalada.**

Para comprender el problema necesitamos conocer cómo funciona la resolución de comandos.

---

## ⚙️ 2. Command vs Executable

Primero debemos diferenciar dos conceptos.

### Command

Un **Command** es una instrucción que introducimos en el Shell.

Por ejemplo:

```bash
git --version
```

Aquí:

- `git` es el nombre del comando.
- `--version` es un argumento.

### Executable

Un **Executable** es un archivo que puede ejecutarse mediante los mecanismos correspondientes del sistema operativo.

Por ejemplo, Git puede estar disponible en una ruta como:

```text
/usr/bin/git
```

O:

```text
/opt/homebrew/bin/git
```

Ambas rutas son ejemplos posibles en macOS.

### Relación

```text
Developer
    ↓
Command: git --version
    ↓
Shell
    ↓
Command Resolution
    ↓
Executable
    ↓
Process
```

Sin embargo, no todos los comandos corresponden directamente a archivos ejecutables.

Un comando también puede resolverse como:

- Alias.
- Función.
- Built-in del Shell.
- Ejecutable externo.

Por eso debemos distinguir **Command Resolution** de la búsqueda específica de ejecutables mediante `PATH`.

---

## 🌍 3. ¿Qué es PATH?

`PATH` es una Environment Variable utilizada por el Shell y otras herramientas para localizar ejecutables.

Habitualmente contiene una lista ordenada de directorios.

Por ejemplo:

```text
/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin
```

Cada directorio está separado mediante dos puntos (`:`).

Podemos representarlo así:

```text
PATH
│
├── /opt/homebrew/bin
├── /usr/local/bin
├── /usr/bin
└── /bin
```

Cuando ejecutamos un comando externo sin especificar su ruta, el Shell puede buscarlo en estos directorios.

### Ejemplo

Escribimos:

```bash
git --version
```

El Shell puede buscar:

```text
/opt/homebrew/bin/git
/usr/local/bin/git
/usr/bin/git
/bin/git
```

La búsqueda utiliza el orden configurado, aunque los detalles de resolución y caché pueden depender del Shell.

### Idea fundamental

**`PATH` no contiene normalmente los ejecutables, sino los directorios donde deben buscarse.**

---

## 🔎 4. Consultar PATH en macOS

Podemos inspeccionar el valor actual mediante:

```bash
echo "$PATH"
```

Ejemplo:

```text
/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin
```

Este resultado es ilustrativo.

El valor real depende de nuestra configuración.

### Mostrar cada directorio por separado

En Zsh podemos utilizar:

```zsh
print -l $path
```

Zsh dispone de un Array especial llamado `path`, relacionado con la variable `PATH`.

Esto facilita inspeccionar sus elementos.

Ejemplo:

```text
/opt/homebrew/bin
/usr/local/bin
/usr/bin
/bin
```

### ¿Por qué es útil?

Porque una lista vertical permite identificar:

- Directorios duplicados.
- Rutas antiguas.
- Instalaciones de diferentes herramientas.
- Directorios inexistentes.
- Orden de prioridad.

---

## 🧭 5. El orden de PATH importa

Imagina que tenemos dos instalaciones de Git.

```text
/opt/homebrew/bin/git
/usr/bin/git
```

Y nuestro `PATH` contiene:

```text
/opt/homebrew/bin:/usr/bin:/bin
```

En una búsqueda normal de ejecutables mediante `PATH`, el directorio `/opt/homebrew/bin` tiene prioridad.

Por tanto, si contiene un ejecutable compatible llamado `git`, normalmente se seleccionará antes que `/usr/bin/git`.

### Diagrama

```text
PATH Search Order
        │
        ▼
1. /opt/homebrew/bin
        │
        ├── git found
        │       ↓
        │    Execute
        │
        └── Not found
                ↓
2. /usr/bin
                ↓
3. /bin
```

### ¿Qué sucede si cambiamos el orden?

Si configuramos:

```text
/usr/bin:/opt/homebrew/bin:/bin
```

La búsqueda puede seleccionar otra instalación de Git.

### Consecuencia

Dos sesiones de Terminal pueden ejecutar versiones distintas de una misma herramienta.

```text
Terminal A
    ↓
Git from Homebrew

Terminal B
    ↓
Git from Apple Tools
```

**El orden de `PATH` forma parte del comportamiento de nuestro entorno.**

---

## 🧰 6. Cómo identificar qué comando estamos ejecutando

No debemos adivinar qué instalación utiliza nuestro Shell.

Podemos investigarlo.

### command -v

```bash
command -v git
```

Este comando permite consultar cómo se resuelve `git`.

Si corresponde a un ejecutable externo, puede mostrar una ruta.

Por ejemplo:

```text
/opt/homebrew/bin/git
```

### type -a

En Zsh:

```zsh
type -a git
```

Permite consultar las resoluciones disponibles para el comando.

Puede mostrar varias coincidencias.

### which

También encontraremos:

```bash
which git
```

Es un comando habitual, pero su comportamiento puede variar entre sistemas y Shells.

Para nuestros diagnósticos iniciales priorizaremos:

```bash
command -v git
```

Y:

```zsh
type -a git
```

### Comprobar la versión

```bash
git --version
```

Con estas verificaciones podemos responder:

1. ¿El comando existe?
2. ¿Cómo se resuelve?
3. ¿Existen otras instalaciones?
4. ¿Qué versión estamos ejecutando?

---

## 🧩 7. PATH no es todo el proceso de resolución

Es importante evitar una simplificación excesiva.

Cuando escribimos:

```bash
git --version
```

Zsh no necesariamente comienza buscando directamente en `PATH`.

Primero puede considerar otros mecanismos de resolución.

Por ejemplo:

```text
Command
    ↓
Shell Interpretation
    ↓
Alias / Function / Built-in / External Command
    ↓
Executable Search When Applicable
    ↓
Execution
```

### Alias

Un Alias permite asociar un nombre con otra expresión de comando.

Ejemplo:

```zsh
alias ll='ls -la'
```

Después podríamos ejecutar:

```bash
ll
```

### Function

Una Function permite definir lógica reutilizable dentro del Shell.

Por ejemplo:

```zsh
greet() {
  echo "Hello, Developer!"
}
```

Después:

```bash
greet
```

### Built-in

Un Built-in es un comando implementado directamente por el Shell.

Por ejemplo:

```bash
cd
```

### External Command

Un comando externo se ejecuta mediante un programa fuera del Shell.

Por ejemplo:

```bash
git
```

### Conclusión

`PATH` es fundamental para localizar ejecutables externos, pero **no determina por sí solo todas las formas en que un Shell puede resolver un comando**.

---

## 🌱 8. Environment Variables

Antes de modificar `PATH`, debemos comprender las Environment Variables.

Una **Environment Variable** es un valor identificado mediante un nombre que puede formar parte del entorno de un proceso.

Ejemplos:

```text
PATH
HOME
LANG
EDITOR
```

### Consultar una variable

```bash
echo "$HOME"
```

O:

```bash
echo "$PATH"
```

### Crear una variable en Zsh

```zsh
PROJECT_NAME="tooling-mastery"
```

Podemos consultarla:

```bash
echo "$PROJECT_NAME"
```

Pero existe una diferencia importante entre una variable del Shell y una variable exportada.

---

## 📤 9. Shell Variables vs Exported Environment Variables

Imagina que definimos:

```zsh
PROJECT_NAME="tooling-mastery"
```

Esta variable existe en nuestra sesión de Shell.

Pero no necesariamente estará disponible para los procesos hijos.

### Export

Podemos utilizar:

```zsh
export PROJECT_NAME="tooling-mastery"
```

Esto marca la variable para incluirla en el entorno de los procesos que el Shell inicie posteriormente.

### Modelo conceptual

```text
Shell Process
│
├── Local Shell Variable
│
└── Exported Variable
         ↓
    Child Process
```

### Ejemplo práctico

```zsh
export PROJECT_NAME="tooling-mastery"
```

Después:

```bash
printenv PROJECT_NAME
```

Podríamos obtener:

```text
tooling-mastery
```

### ¿Por qué importa para PATH?

Porque `PATH` normalmente se exporta como una variable de entorno.

Esto permite que los procesos que iniciamos puedan recibir información sobre las rutas de búsqueda.

### Importante

Modificar una variable en un Shell no cambia automáticamente el entorno de todos los procesos que ya están ejecutándose.

Tampoco modifica necesariamente la configuración permanente de macOS.

---

## ⏳ 10. Temporary vs Persistent Configuration

Podemos modificar `PATH` temporalmente o configurar su inicialización para futuras sesiones.

### Temporary Configuration

Por ejemplo:

```zsh
export PATH="$HOME/tools/bin:$PATH"
```

Esto agrega un directorio al principio de `PATH` en la sesión actual.

La modificación también puede heredarse por procesos hijos iniciados posteriormente.

Pero normalmente no persistirá al cerrar esa sesión si no existe una configuración que vuelva a aplicarla.

### Persistent Configuration

Podemos colocar determinadas instrucciones en archivos de configuración del Shell.

Por ejemplo:

```text
~/.zprofile
~/.zshrc
```

La elección depende de cuándo queremos aplicar la configuración.

**No debemos agregar instrucciones al primer archivo que encontremos sin comprender su función.**

---

## 🐚 11. Zsh Startup Files

Zsh utiliza diferentes archivos de configuración durante su inicialización.

Entre los más importantes encontramos:

```text
.zshenv
.zprofile
.zshrc
.zlogin
.zlogout
```

No todos se ejecutan en todas las sesiones.

Su comportamiento depende del tipo de Shell.

### Archivos de usuario

Habitualmente se encuentran en el directorio personal:

```text
~/.zshenv
~/.zprofile
~/.zshrc
~/.zlogin
~/.zlogout
```

Estos nombres pueden cambiar de ubicación si se utiliza una configuración especial de Zsh, como `ZDOTDIR`.

### Responsabilidades habituales

| Archivo | Uso habitual |
|---|---|
| `.zshenv` | Configuración mínima necesaria en todas las invocaciones de Zsh |
| `.zprofile` | Configuración de sesiones Login |
| `.zshrc` | Configuración de sesiones Interactive |
| `.zlogin` | Acciones adicionales al iniciar un Login Shell |
| `.zlogout` | Acciones de cierre de un Login Shell |

Debemos comprender qué significa Login e Interactive antes de decidir dónde colocar nuestras configuraciones.

---

## 🔑 12. Login Shell vs Interactive Shell

Estos términos describen propiedades diferentes de una sesión de Shell.

### Login Shell

Un **Login Shell** es un Shell iniciado en modo Login.

Este modo determina, entre otras cosas, qué archivos de inicialización se procesan.

### Interactive Shell

Un **Interactive Shell** permite interactuar directamente con el usuario.

Por ejemplo, escribiendo comandos y recibiendo resultados.

### Non-interactive Shell

Un **Non-interactive Shell** ejecuta instrucciones sin necesitar una conversación interactiva con el usuario.

Es habitual en Scripts y automatizaciones.

### ¿Pueden combinarse?

Sí.

Login e Interactive no son categorías mutuamente excluyentes.

Podemos encontrar:

```text
Interactive Login Shell
Interactive Non-login Shell
Non-interactive Login Shell
Non-interactive Non-login Shell
```

### ¿Por qué importa?

Porque los archivos de configuración cargados pueden variar.

Por ejemplo, una configuración colocada únicamente en `.zshrc` no debe considerarse disponible automáticamente en todos los Scripts no interactivos.

---

## 🔄 13. Orden de inicialización de Zsh

De manera simplificada, Zsh procesa determinados archivos según el tipo de sesión.

### Startup Sequence

```text
Zsh Starts
    ↓
.zshenv
    ↓
Login Shell?
    ├── Yes → .zprofile
    └── No
    ↓
Interactive Shell?
    ├── Yes → .zshrc
    └── No
    ↓
Login Shell?
    ├── Yes → .zlogin
    └── No
    ↓
Shell Ready
```

Al cerrar un Login Shell, puede procesarse `.zlogout`.

### Importante

Este esquema representa principalmente archivos de usuario.

Zsh también puede procesar archivos globales del sistema, como los ubicados en `/etc`.

Además, determinadas opciones y modos de ejecución pueden alterar el comportamiento de inicialización.

### ¿Qué debemos recordar?

- `.zshenv` puede ejecutarse incluso en sesiones no interactivas.
- `.zprofile` se relaciona con Login Shells.
- `.zshrc` se relaciona con Interactive Shells.
- `.zlogin` se procesa posteriormente durante el inicio de sesiones Login.

Por eso debemos evitar colocar configuraciones pesadas o innecesarias en `.zshenv`.

---

## 📄 14. ¿Qué colocar en .zprofile?

En macOS, `.zprofile` suele ser una ubicación adecuada para determinadas configuraciones del entorno que queremos establecer al iniciar una sesión Login.

Por ejemplo, la inicialización de Homebrew.

### Ejemplo conceptual

```zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Esta instrucción ejecuta `brew shellenv` y aplica las instrucciones de configuración que produce.

### ¿Debemos copiarla siempre?

No.

La ruta depende de la instalación real de Homebrew.

En una instalación habitual de Apple Silicon puede utilizarse:

```text
/opt/homebrew/bin/brew
```

En Intel puede ser:

```text
/usr/local/bin/brew
```

Debemos comprobar nuestro Prefix antes de configurar el Shell.

### Recomendación

Mantén `.zprofile` orientado a configuraciones apropiadas para el inicio de sesiones Login.

Evita utilizarlo como un archivo donde acumular indiscriminadamente cualquier comando.

---

## 🎨 15. ¿Qué colocar en .zshrc?

`.zshrc` suele utilizarse para configurar el comportamiento de sesiones interactivas de Zsh.

Por ejemplo:

- Aliases.
- Prompt.
- Autocompletado.
- Funciones interactivas.
- Integraciones del Shell.
- Inicialización de determinadas herramientas que requieren integración interactiva.

### Ejemplo

```zsh
alias ll='ls -la'
```

Otro ejemplo:

```zsh
alias gs='git status'
```

### ¿Por qué .zshrc?

Porque estas configuraciones están orientadas a la interacción con el usuario.

No necesariamente necesitamos aplicarlas cuando un Script ejecuta Zsh de forma no interactiva.

### Precaución

Un `.zshrc` demasiado complejo puede:

- Ralentizar el inicio de sesiones.
- Introducir conflictos.
- Ejecutar comandos innecesarios.
- Dificultar el diagnóstico.

Por eso conviene mantenerlo organizado y documentado.

---

## ⚠️ 16. ¿Por qué debemos tener cuidado con .zshenv?

`.zshenv` tiene un alcance más amplio que `.zshrc` o `.zprofile`.

Puede ejecutarse en invocaciones de Zsh no interactivas.

Por ejemplo, cuando Zsh ejecuta un Script.

Esto significa que una configuración incorrecta puede afectar automatizaciones.

### Ejemplo de mala práctica

Imagina que colocamos un comando que imprime mensajes:

```zsh
echo "Welcome to my terminal!"
```

dentro de `.zshenv`.

Ese mensaje podría aparecer también en contextos donde no queremos salida adicional.

### ¿Qué problemas puede causar?

- Interferir con Scripts.
- Alterar salidas esperadas.
- Generar comportamientos inesperados.
- Introducir dependencias innecesarias.

### Recomendación

Reserva `.zshenv` para configuraciones mínimas que realmente deban aplicarse a todas las invocaciones correspondientes de Zsh.

No lo utilices como archivo general de personalización.

---

## 🍺 17. Homebrew y brew shellenv

En el documento anterior aprendimos que Homebrew utiliza un Prefix.

Por ejemplo:

```text
/opt/homebrew
```

Para que el Shell encuentre sus herramientas, puede ser necesario integrar Homebrew con el entorno.

Homebrew proporciona:

```bash
brew shellenv
```

Este comando imprime instrucciones de configuración.

### Ejemplo conceptual

Puede generar instrucciones relacionadas con:

```text
HOMEBREW_PREFIX
HOMEBREW_CELLAR
HOMEBREW_REPOSITORY
PATH
```

El contenido concreto depende de la instalación.

### ¿Qué significa eval?

En Zsh, `eval` permite evaluar texto como instrucciones del Shell.

Por ejemplo:

```zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Aquí:

1. Se ejecuta `/opt/homebrew/bin/brew shellenv`.
2. Se captura su salida.
3. `eval` interpreta las instrucciones producidas.

### ¿Por qué debemos tener cuidado?

Porque `eval` ejecuta instrucciones.

Debemos utilizarlo únicamente cuando confiamos en la herramienta que genera ese contenido.

En este caso, la integración debe realizarse utilizando la instalación oficial y verificando la ruta correspondiente.

---

## 🧪 18. Configuración práctica de Homebrew en Zsh

Esta práctica es **opcional** y modifica la configuración del Shell.

Realízala solamente si Homebrew está instalado y necesitas integrarlo con Zsh.

### Step 1 — Check Homebrew Location

En Apple Silicon podemos comprobar:

```bash
ls -l /opt/homebrew/bin/brew
```

En una instalación Intel habitual:

```bash
ls -l /usr/local/bin/brew
```

Estas comprobaciones no modifican archivos.

### Step 2 — Verify Prefix

Si Homebrew está disponible:

```bash
brew --prefix
```

### Step 3 — Inspect Current Configuration

Comprueba si existe `.zprofile`:

```bash
ls -la ~/.zprofile
```

Si el archivo no existe, el comando puede mostrar un error indicando que no se encontró.

Eso no significa que Zsh esté mal configurado.

### Step 4 — Inspect Existing Content

Si el archivo existe:

```bash
cat ~/.zprofile
```

Antes de modificarlo, debemos comprender las instrucciones existentes.

No debemos sobrescribirlo.

### Step 5 — Backup Existing Configuration

Si necesitamos editarlo y existe:

```bash
cp ~/.zprofile ~/.zprofile.backup
```

Este comando crea una copia de respaldo.

Si el archivo no existe, podemos crear uno nuevo mediante nuestro editor.

### Step 6 — Add Homebrew Initialization

Para una instalación estándar de Apple Silicon, una configuración habitual es:

```zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Para una instalación estándar Intel:

```zsh
eval "$(/usr/local/bin/brew shellenv)"
```

Utiliza únicamente la ruta que corresponda a tu instalación real.

No agregues ambas instrucciones indiscriminadamente.

### Step 7 — Start a New Login Shell

Después de guardar el archivo, abre una nueva sesión Login de Zsh.

También puedes inspeccionar el tipo de sesión para comprobar que corresponde al comportamiento esperado.

### Step 8 — Verify

```bash
brew --version
```

Después:

```bash
brew --prefix
```

Y:

```bash
command -v brew
```

Finalmente:

```zsh
print -l $path
```

### Resultado esperado

Homebrew debería estar disponible mediante la resolución de comandos correspondiente.

**No es necesario repetir esta configuración si Homebrew ya está correctamente integrado.**

---

## 🔧 19. Modificar PATH manualmente

Existen situaciones donde necesitamos agregar un directorio a `PATH`.

Por ejemplo, una herramienta instalada en:

```text
~/tools/bin
```

Podríamos agregarlo temporalmente mediante:

```zsh
export PATH="$HOME/tools/bin:$PATH"
```

### ¿Qué significa esta instrucción?

```text
PATH =
    New Directory
        +
    Existing PATH
```

Agregamos el nuevo directorio al principio de la lista.

### ¿Por qué conservar $PATH?

Porque reemplazar completamente el valor podría eliminar directorios necesarios para encontrar herramientas habituales.

### Ejemplo peligroso

```zsh
export PATH="$HOME/tools/bin"
```

Esta instrucción reemplaza el valor anterior.

Si no incluimos los directorios existentes, podemos dejar de encontrar comandos que antes funcionaban.

### Recomendación

Antes de modificar `PATH`:

1. Identifica el directorio que necesitas.
2. Comprueba que existe.
3. Verifica si ya está incluido.
4. Decide qué prioridad debe tener.
5. Aplica el cambio de forma controlada.
6. Comprueba el resultado.

---

## 🧼 20. Evitar directorios duplicados

Una configuración desordenada puede agregar repetidamente el mismo directorio a `PATH`.

Por ejemplo:

```text
/opt/homebrew/bin
/opt/homebrew/bin
/usr/bin
/bin
```

Aunque esto no siempre impide ejecutar comandos, puede dificultar la inspección.

En Zsh existe una forma de mantener únicos los elementos del Array `path`:

```zsh
typeset -U path
```

Esta declaración indica a Zsh que mantenga valores únicos en ese Array, conservando la primera aparición.

### ¿Debemos agregarla siempre?

No necesariamente.

Primero debemos identificar por qué se están duplicando las rutas.

Podría existir una inicialización repetida en diferentes archivos.

**La mejor solución suele ser corregir la causa de la duplicación, no acumular mecanismos para ocultarla.**

---

## 🧩 21. PATH y Runtime Version Managers

Más adelante estudiaremos herramientas para administrar versiones de Node.js.

Por ejemplo:

```text
nvm
mise
```

Estos gestores pueden modificar el entorno de la sesión para seleccionar determinados ejecutables.

Conceptualmente:

```text
Version Manager
      ↓
Selected Runtime Version
      ↓
Executable Location
      ↓
PATH
      ↓
node Command
```

### Ejemplo

Un proyecto requiere una versión específica de Node.js.

El gestor selecciona la versión correspondiente.

Después:

```bash
node --version
```

debería mostrar una versión compatible con el proyecto.

### ¿Por qué importa?

Porque instalar Node.js desde diferentes mecanismos puede introducir conflictos.

Por ejemplo:

```text
Node.js from Homebrew
Node.js from Version Manager
Node.js from Official Installer
```

Si varias instalaciones están disponibles, debemos comprender cuál se selecciona.

No configuraremos gestores de versiones todavía.

Lo estudiaremos en `04-runtime-management`.

---

## 🖥️ 22. PATH en Terminal.app y VS Code

Una duda frecuente es:

**¿Por qué un comando funciona en Terminal.app, pero no en la Terminal integrada de VS Code?**

Esto puede suceder porque las sesiones no siempre se inicializan de la misma manera.

Por ejemplo:

```text
Terminal.app
    ↓
Zsh Login Session
    ↓
Environment A
```

```text
VS Code Integrated Terminal
    ↓
Configured Shell Session
    ↓
Environment B
```

La configuración exacta depende de la aplicación y de cómo se inicia el Shell.

Además, una aplicación gráfica puede heredar un entorno diferente según cómo fue iniciada.

### ¿Cómo investigar?

En ambas Terminales ejecuta:

```bash
echo "$SHELL"
```

Después:

```bash
echo "$PATH"
```

Y:

```bash
command -v node
```

También puedes comprobar:

```bash
node --version
```

### ¿Qué debemos comparar?

- Shell utilizado.
- Tipo de sesión.
- Valor de `PATH`.
- Ubicación del ejecutable.
- Versión seleccionada.

No debemos asumir que un error de VS Code requiere reinstalar Node.js.

Primero debemos comparar los entornos.

---

## 🔍 23. Troubleshooting: diagnóstico por capas

Cuando un comando no funciona, conviene seguir un procedimiento ordenado.

### Step 1 — Identify the Command

Por ejemplo:

```bash
node --version
```

### Step 2 — Check Command Resolution

```bash
command -v node
```

### Step 3 — Check All Available Resolutions

```zsh
type -a node
```

### Step 4 — Inspect PATH

```zsh
print -l $path
```

### Step 5 — Identify Installation Mechanism

Pregúntate:

- ¿Node.js fue instalado mediante Homebrew?
- ¿Utilizamos un gestor de versiones?
- ¿Se instaló mediante un instalador oficial?
- ¿Existe más de una instalación?

### Step 6 — Inspect Shell Configuration

Revisa los archivos relevantes:

```text
~/.zprofile
~/.zshrc
~/.zshenv
```

No los modifiques todavía.

### Step 7 — Compare Sessions

Si el comando funciona en una Terminal pero no en otra, compara sus configuraciones.

### Step 8 — Apply a Controlled Fix

Modifica únicamente lo necesario.

### Step 9 — Verify Again

Comprueba:

```bash
command -v node
```

Y:

```bash
node --version
```

### Flujo completo

```text
Command Fails
     ↓
Inspect Resolution
     ↓
Inspect PATH
     ↓
Identify Installation
     ↓
Inspect Shell Startup
     ↓
Compare Environments
     ↓
Apply Fix
     ↓
Verify
```

---

## ⚠️ 24. Errores comunes

### 1. Pensar que PATH contiene ejecutables

`PATH` contiene directorios de búsqueda.

### 2. Pensar que PATH resuelve todos los comandos

También existen Aliases, Functions y Built-ins.

### 3. Ignorar el orden de PATH

La prioridad puede determinar qué versión se ejecuta.

### 4. Sobrescribir PATH accidentalmente

Podemos eliminar directorios importantes de la búsqueda.

### 5. Modificar .zshenv sin comprender su alcance

Puede afectar Scripts y sesiones no interactivas.

### 6. Colocar cualquier configuración en .zshrc

No todas las configuraciones pertenecen al mismo tipo de sesión.

### 7. Duplicar la inicialización de Homebrew

Puede introducir entradas repetidas o configuraciones innecesarias.

### 8. Copiar rutas de otra computadora

Apple Silicon e Intel pueden utilizar ubicaciones diferentes.

### 9. Instalar varias versiones de una herramienta sin una estrategia

Podemos perder claridad sobre cuál se está ejecutando.

### 10. Reinstalar herramientas sin investigar PATH

El problema podría ser únicamente de resolución.

### 11. Suponer que todas las Terminales comparten el mismo entorno

Pueden utilizar configuraciones de inicio distintas.

### 12. Ejecutar eval con contenido desconocido

Debemos comprender y confiar en las instrucciones que se van a evaluar.

---

## 🧪 25. Práctica: PATH Environment Audit

Vamos a realizar una inspección de nuestro entorno.

**Esta práctica no requiere modificar archivos.**

### Step 1 — Inspect Current Shell

```bash
echo "$SHELL"
```

### Step 2 — Inspect Current Process

```bash
ps -p $$ -o comm=
```

### Step 3 — Inspect PATH

```bash
echo "$PATH"
```

### Step 4 — Inspect PATH Entries

En Zsh:

```zsh
print -l $path
```

### Step 5 — Inspect Git

```bash
command -v git
```

Después:

```zsh
type -a git
```

### Step 6 — Inspect Homebrew

Si está instalado:

```bash
command -v brew
```

Y:

```bash
brew --prefix
```

### Step 7 — Inspect Node.js

Si está instalado:

```bash
command -v node
```

Después:

```bash
node --version
```

### Step 8 — Inspect Startup Files

```bash
ls -la ~/.zprofile ~/.zshrc ~/.zshenv
```

Es normal que algunos archivos no existan.

### Step 9 — Complete Your Inventory

| Component | Result |
|---|---|
| Default Shell | |
| Current Shell | |
| PATH Entries | |
| Git Resolution | |
| Git Version | |
| Homebrew Resolution | |
| Homebrew Prefix | |
| Node.js Resolution | |
| Node.js Version | |
| `.zprofile` Exists | |
| `.zshrc` Exists | |
| `.zshenv` Exists | |

### Step 10 — Reflection

Responde:

1. ¿Qué directorios contiene tu `PATH`?
2. ¿Qué directorio tiene mayor prioridad?
3. ¿Existen entradas duplicadas?
4. ¿Qué instalación de Git estás utilizando?
5. ¿Homebrew está correctamente integrado?
6. ¿Cómo se resuelve Node.js?
7. ¿Qué archivos de Zsh existen?
8. ¿Necesitas modificar alguna configuración?

No debemos modificar nada únicamente porque nuestra configuración sea diferente a la de otra persona.

---

## 🏢 26. PATH en equipos profesionales

En equipos profesionales, los desarrolladores pueden utilizar diferentes mecanismos para instalar herramientas.

Por ejemplo:

```text
Developer A
    ↓
Node.js via nvm
```

```text
Developer B
    ↓
Node.js via mise
```

Ambos pueden trabajar con el mismo proyecto si utilizan versiones compatibles y cumplen los requisitos establecidos.

Esto significa que un equipo no siempre necesita imponer exactamente el mismo gestor de versiones.

Pero sí debería declarar:

- Runtime requerido.
- Versiones compatibles.
- Package Manager esperado.
- Configuración necesaria.
- Comandos de verificación.

### Relación con reproducibilidad

```text
Project Requirements
        ↓
Developer Configuration
        ↓
PATH / Runtime Selection
        ↓
Compatible Tools
        ↓
Project Validation
```

**La reproducibilidad no exige que todos tengan un `PATH` idéntico, sino que puedan resolver las herramientas correctas y trabajar bajo condiciones compatibles.**

---

## 🧠 27. Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es `PATH`?
2. ¿Qué problema resuelve?
3. ¿Qué diferencia existe entre Command y Executable?
4. ¿Por qué importa el orden de `PATH`?
5. ¿Qué significa `command -v`?
6. ¿Qué permite investigar `type -a`?
7. ¿Qué diferencia existe entre una variable del Shell y una variable exportada?
8. ¿Qué sucede cuando modificamos `PATH` temporalmente?
9. ¿Qué es un Login Shell?
10. ¿Qué es un Interactive Shell?
11. ¿Qué diferencia existe entre `.zprofile` y `.zshrc`?
12. ¿Por qué debemos tener cuidado con `.zshenv`?
13. ¿Qué hace `brew shellenv`?
14. ¿Qué hace `eval`?
15. ¿Por qué debemos verificar el Prefix de Homebrew?
16. ¿Cómo puede un gestor de versiones afectar a `PATH`?
17. ¿Por qué pueden existir varias instalaciones de Git?
18. ¿Por qué un comando puede funcionar en Terminal.app y fallar en VS Code?
19. ¿Qué investigarías ante un error `command not found`?
20. ¿Cómo modificarías `PATH` sin perder las rutas existentes?
21. ¿Por qué no debemos copiar configuraciones de otra computadora sin revisarlas?
22. ¿Cómo se relaciona `PATH` con la reproducibilidad?

---

## 💡 Idea clave

`PATH` es una variable de entorno fundamental para localizar ejecutables.

Pero forma parte de un sistema más amplio que incluye:

```text
Developer
    ↓
Terminal
    ↓
Shell
    ↓
Command Resolution
    ├── Alias
    ├── Function
    ├── Built-in
    └── External Executable
             ↓
            PATH
             ↓
        Executable
             ↓
          Process
```

En macOS, comprender Zsh y sus archivos de inicialización nos permite controlar cómo se prepara el entorno de cada sesión.

**Un entorno profesional no depende de modificar `PATH` constantemente, sino de mantener una configuración clara, compatible y verificable.**

---

## 🚀 Siguiente paso

Ya comprendemos cómo macOS localiza ejecutables, cómo interviene `PATH` y cómo se inicializa Zsh.

Ahora estamos preparados para estudiar los problemas más frecuentes que pueden aparecer al configurar un Development Environment en macOS.

Aprenderemos a diagnosticar errores relacionados con:

- Command Line Tools.
- Homebrew.
- PATH.
- Permisos.
- Arquitectura Apple Silicon e Intel.
- Herramientas duplicadas.
- Diferencias entre Terminales.

👉 [Common macOS Issues](./05-common-macos-issues.md)