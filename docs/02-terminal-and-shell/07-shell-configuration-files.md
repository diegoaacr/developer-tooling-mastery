# Shell Configuration Files

> **Developer Tooling Mastery 2026 — Module 02**
>
> **Topic 07:** Shell Configuration Files  
> **Level:** Beginner → Professional Foundations  
> **Prerequisites:** [06 — PATH Environment Variable](./06-path-environment-variable.md)

---

## 1. Introducción

En los documentos anteriores aprendimos que un Shell permite ejecutar comandos y que las Environment Variables pueden influir en el comportamiento de los procesos.

También comprendimos que PATH determina parte de la búsqueda de programas ejecutables.

Ahora imaginemos esta situación.

Instalamos una herramienta y agregamos su directorio a PATH:

```bash
export PATH="$HOME/tools/bin:$PATH"
```

La herramienta funciona correctamente.

Sin embargo, cerramos la terminal, abrimos otra y descubrimos que ya no se reconoce el comando.

¿Por qué?

Porque modificamos el entorno de una sesión, pero no necesariamente configuramos cómo deben prepararse las sesiones futuras.

Para resolver este problema necesitamos comprender los **Shell Configuration Files**.

Estos archivos permiten personalizar determinados aspectos del Shell, como:

- Variables de entorno.
- PATH.
- Aliases.
- Funciones.
- Prompt.
- Integración con herramientas.
- Comportamiento de sesiones interactivas.

Pero existe una dificultad importante: **no todos los archivos de configuración se cargan en las mismas circunstancias**.

Por ejemplo, en macOS con Zsh podemos encontrar:

```text
~/.zshrc
~/.zprofile
~/.zshenv
```

En Bash:

```text
~/.bashrc
~/.bash_profile
~/.profile
```

Y en PowerShell existen archivos llamados **Profiles**.

No debemos modificar estos archivos al azar.

Primero necesitamos entender cuándo se ejecutan y cuál es la responsabilidad de cada uno.

---

## 2. Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Explicar qué es un Shell Configuration File.
2. Comprender qué significa Shell Initialization.
3. Diferenciar Login Shell y Non-login Shell.
4. Diferenciar Interactive Shell y Non-interactive Shell.
5. Comprender por qué estas clasificaciones son independientes.
6. Reconocer los principales archivos de configuración de Bash.
7. Reconocer los principales archivos de configuración de Zsh.
8. Comprender los Profiles de PowerShell.
9. Identificar qué Shell estás utilizando.
10. Comprender cuándo se cargan los archivos de configuración.
11. Diferenciar configuración de usuario y configuración de proyecto.
12. Entender dónde definir PATH, Aliases y funciones.
13. Comprender el comando `source`.
14. Diagnosticar configuraciones que no se aplican.
15. Evitar configuraciones duplicadas o conflictivas.
16. Aplicar buenas prácticas profesionales.

---

# 3. ¿Qué es Shell Configuration?

**Shell Configuration** es el conjunto de ajustes que determinan cómo se comporta una instancia del Shell.

Por ejemplo, podemos configurar:

```text
Shell Configuration
│
├── Environment Variables
├── PATH
├── Aliases
├── Functions
├── Prompt
└── Tool Integrations
```

Estas configuraciones pueden provenir de distintas fuentes:

- Valores predeterminados del Shell.
- Configuración del sistema.
- Variables heredadas del proceso padre.
- Archivos de inicialización.
- Comandos ejecutados durante la sesión.

## 3.1 ¿Por qué necesitamos configuración?

Porque no queremos preparar manualmente nuestro entorno cada vez que abrimos una terminal.

Imagina tener que ejecutar lo siguiente diariamente:

```bash
export EDITOR="code"
export PATH="$HOME/tools/bin:$PATH"
alias ll="ls -la"
```

Podríamos automatizar estas definiciones mediante archivos de configuración apropiados.

## 3.2 ¿Toda configuración debe ser permanente?

No.

Algunas configuraciones deben ser temporales y otras específicas de un proyecto.

Por ejemplo:

```text
Global User Configuration
        │
        ├── Editor Preference
        └── Personal Aliases

Project Configuration
        │
        ├── Required Node Version
        └── Project-specific Variables
```

No deberíamos colocar todas las configuraciones de nuestros proyectos dentro del perfil global del Shell.

### Idea clave

**Shell Configuration permite preparar el entorno de trabajo, pero debemos decidir correctamente qué configuración pertenece al usuario, al Shell o al proyecto.**

---

# 4. ¿Qué es Shell Initialization?

**Shell Initialization** es el proceso mediante el cual una instancia del Shell prepara su estado al iniciarse.

Puede incluir:

1. Recibir el entorno del proceso padre.
2. Identificar el tipo de sesión.
3. Leer determinados archivos de inicialización.
4. Ejecutar instrucciones de configuración.
5. Prepararse para recibir comandos o ejecutar un Script.

Modelo conceptual:

```text
Shell Process Starts
        │
        ▼
Inherited Environment
        │
        ▼
Determine Shell Mode
        │
        ▼
Read Applicable Startup Files
        │
        ▼
Apply Configuration
        │
        ▼
Ready to Execute Commands
```

El conjunto exacto de archivos depende del Shell y de cómo se haya iniciado.

## 4.1 ¿Se ejecutan todos los archivos?

No.

## 4.2 ¿Se ejecutan siempre en el mismo orden?

No.

Cada Shell tiene sus propias reglas.

## 4.3 ¿Son iguales Bash, Zsh y PowerShell?

No.

Comparten objetivos similares, pero sus mecanismos de inicialización son diferentes.

### Idea clave

**El comportamiento de una sesión depende tanto de la configuración disponible como del modo en que se inicia el Shell.**

---

# 5. Login Shell vs Non-login Shell

Esta es nuestra primera clasificación importante.

## 5.1 ¿Qué es un Login Shell?

Un **Login Shell** es una instancia del Shell iniciada en modo Login.

Históricamente, este modo estaba asociado al inicio de una sesión de usuario.

Actualmente también puede utilizarse en terminales gráficas.

## 5.2 ¿Qué es un Non-login Shell?

Es una instancia del Shell que no se inicia en modo Login.

Por ejemplo, podemos iniciar un nuevo Shell dentro de otro sin utilizar el modo Login.

## 5.3 ¿Por qué importa?

Porque los Shells pueden leer archivos diferentes dependiendo de este modo.

Modelo:

```text
Shell Startup
     │
     ├── Login Shell
     │      └── Login-specific Configuration
     │
     └── Non-login Shell
            └── Other Applicable Configuration
```

## 5.4 ¿Un Login Shell siempre solicita contraseña?

No.

El término describe un modo de inicialización del Shell, no necesariamente una pantalla de autenticación.

## 5.5 ¿Todas las terminales de macOS son Login Shells?

No debemos asumirlo.

El comportamiento depende de la aplicación de terminal y su configuración.

### Idea clave

**Login Shell describe cómo se inicia el Shell y qué reglas de inicialización aplica; no significa simplemente que el usuario acaba de introducir una contraseña.**

---

# 6. Interactive Shell vs Non-interactive Shell

Esta es nuestra segunda clasificación.

## 6.1 Interactive Shell

Un **Interactive Shell** está diseñado para interactuar con el usuario.

Por ejemplo:

```text
developer@computer ~ %
```

El usuario escribe comandos y recibe resultados.

## 6.2 Non-interactive Shell

Un **Non-interactive Shell** ejecuta instrucciones sin necesitar una conversación continua con el usuario.

Por ejemplo:

```bash
bash script.sh
```

O:

```bash
bash -c 'echo "Hello"'
```

## 6.3 ¿Por qué importa?

Porque ciertas configuraciones solamente tienen sentido en sesiones interactivas.

Ejemplos:

- Prompt.
- Autocompletado.
- Aliases personales.
- Integraciones visuales.

Otras configuraciones pueden ser necesarias para Scripts.

## 6.4 Modelo

```text
Shell
 │
 ├── Interactive
 │      │
 │      ├── Prompt
 │      ├── Completion
 │      └── User Commands
 │
 └── Non-interactive
        │
        └── Automated Commands
```

### Idea clave

**Una configuración útil para trabajar manualmente en la terminal no necesariamente es apropiada para Scripts automatizados.**

---

# 7. Dos clasificaciones independientes

Este punto es especialmente importante.

**Login/Non-login** e **Interactive/Non-interactive** son dimensiones diferentes.

Por lo tanto, podemos encontrar cuatro combinaciones.

| Modo | Descripción |
|---|---|
| Interactive Login | Sesión interactiva iniciada en modo Login |
| Interactive Non-login | Sesión interactiva sin modo Login |
| Non-interactive Login | Ejecución no interactiva en modo Login |
| Non-interactive Non-login | Ejecución automatizada sin modo Login |

## 7.1 Ejemplos con Bash

Interactive Login:

```bash
bash --login -i
```

Interactive Non-login:

```bash
bash -i
```

Non-interactive Login:

```bash
bash --login -c 'echo "Hello"'
```

Non-interactive Non-login:

```bash
bash -c 'echo "Hello"'
```

Estos ejemplos sirven para observar los modos de ejecución; las condiciones del entorno pueden influir en su comportamiento.

## 7.2 ¿Por qué debemos comprender las cuatro combinaciones?

Porque decir simplemente:

> “El Shell lee su archivo de configuración al iniciarse”.

es demasiado impreciso.

Necesitamos saber **qué Shell**, **qué modo** y **qué archivos corresponden**.

### Idea clave

**Antes de investigar por qué una configuración no se carga, identifica tanto el modo Login como el modo Interactive.**

---

# 8. ¿Cómo identificar el Shell actual?

Antes de modificar archivos necesitamos saber qué Shell estamos utilizando.

## 8.1 Bash y Zsh

Podemos consultar:

```bash
echo "$0"
```

El resultado puede ofrecer información sobre cómo se invocó el Shell.

Ejemplos ilustrativos:

```text
-zsh
```

```text
bash
```

Sin embargo, `$0` no es un identificador universalmente fiable de todos los detalles de la sesión.

## 8.2 Consultar SHELL

```bash
echo "$SHELL"
```

Ejemplo:

```text
/bin/zsh
```

**Precaución:** `SHELL` suele representar el Shell configurado para el usuario, no necesariamente el proceso actual.

## 8.3 Consultar el proceso

En macOS o Linux:

```bash
ps -p $$ -o comm=
```

En Bash y Zsh, `$$` suele representar el identificador del proceso del Shell, con particularidades según el contexto.

## 8.4 PowerShell

Podemos consultar:

```powershell
$PSVersionTable
```

Esto permite identificar información sobre la versión de PowerShell.

## 8.5 Buena práctica

No debemos modificar `.bashrc` si realmente utilizamos Zsh esperando que Zsh lo lea automáticamente.

### Idea clave

**El primer paso de cualquier configuración es identificar el Shell y el contexto de ejecución.**

---

# 9. Bash Configuration Files

Bash utiliza diferentes archivos de inicialización según el modo de ejecución.

Los principales archivos de usuario son:

```text
~/.bash_profile
~/.bash_login
~/.profile
~/.bashrc
```

También existen mecanismos de configuración a nivel del sistema.

## 9.1 Bash Login Shell

Para una sesión Login, Bash puede leer:

```text
/etc/profile
```

Después busca el primer archivo legible de esta secuencia:

```text
~/.bash_profile
~/.bash_login
~/.profile
```

**Importante:** no ejecuta necesariamente los tres archivos.

Se utiliza el primero que corresponda según las reglas de Bash.

## 9.2 Bash Interactive Non-login Shell

Normalmente lee:

```text
~/.bashrc
```

## 9.3 Bash Non-interactive Shell

Normalmente no lee `.bashrc` de la misma manera que una sesión interactiva.

Puede utilizar mecanismos como `BASH_ENV` y existen particularidades según cómo se invoque.

## 9.4 Tabla de referencia

| Modo Bash | Configuración habitual |
|---|---|
| Interactive Login | `/etc/profile` y primer archivo de perfil de usuario aplicable |
| Interactive Non-login | `~/.bashrc` |
| Non-interactive Non-login | Posible uso de `BASH_ENV` |
| Non-interactive Login | Reglas de inicialización Login y particularidades del modo |

### Idea clave

**En Bash, `.bash_profile` y `.bashrc` tienen responsabilidades de inicialización diferentes.**

---

# 10. ¿Qué es `.bashrc`?

`.bashrc` es un archivo utilizado habitualmente para configurar sesiones interactivas Non-login de Bash.

Puede contener:

- Aliases.
- Funciones.
- Opciones del Shell.
- Configuración de autocompletado.
- Personalización del Prompt.

Ejemplo:

```bash
alias ll='ls -la'
```

También podemos definir una función:

```bash
mkcd() {
  mkdir -p -- "$1" && cd -- "$1"
}
```

Esta función crea un directorio y entra en él, suponiendo que recibe un argumento válido.

## 10.1 ¿Podemos modificar PATH en `.bashrc`?

Técnicamente sí.

Sin embargo, debemos considerar si la configuración necesita aplicarse únicamente a sesiones interactivas o también a otros procesos.

## 10.2 ¿Debemos colocar todo en `.bashrc`?

No.

Conviene evitar:

- Comandos lentos innecesarios.
- Operaciones destructivas.
- Instalaciones automáticas.
- Scripts que requieren interacción.
- Configuraciones duplicadas.

## 10.3 ¿Por qué?

Porque `.bashrc` puede ejecutarse repetidamente al abrir nuevas sesiones.

### Idea clave

**`.bashrc` suele ser apropiado para preparar la experiencia interactiva de Bash.**

---

# 11. ¿Qué es `.bash_profile`?

`.bash_profile` es uno de los archivos que Bash puede leer al iniciarse en modo Login.

Históricamente se utiliza para preparar parte del entorno de la sesión.

Ejemplo conceptual:

```bash
export EDITOR="code"
```

## 11.1 ¿Qué ocurre si tenemos `.bash_profile` y `.profile`?

En el mecanismo habitual de inicialización Login de Bash, `.bash_profile` tiene prioridad en la secuencia de búsqueda.

Por tanto, `.profile` no se ejecuta automáticamente después.

## 11.2 ¿Puede `.bash_profile` cargar `.bashrc`?

Sí.

Una configuración frecuente es:

```bash
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
```

Esto permite reutilizar determinadas configuraciones interactivas.

## 11.3 ¿Es obligatorio hacerlo?

No.

Depende de cómo queremos organizar nuestra configuración.

## 11.4 Precaución

Si reutilizamos `.bashrc`, debemos asegurarnos de que sus instrucciones sean apropiadas para los modos en los que pueda cargarse.

### Idea clave

**`.bash_profile` puede preparar una sesión Login y reutilizar otras configuraciones, pero debemos controlar qué instrucciones se ejecutan.**

---

# 12. ¿Qué es `.profile`?

`.profile` es un archivo tradicional de configuración de sesiones Login compatible con convenciones de Shells POSIX.

Puede utilizarse para definir determinadas variables y configuraciones generales.

Ejemplo:

```sh
export EDITOR="vi"
```

## 12.1 ¿Bash siempre lee `.profile`?

No.

Como vimos, Bash busca primero otros archivos de perfil de usuario.

## 12.2 ¿Zsh lee automáticamente `.profile`?

No bajo sus reglas normales de inicialización.

## 12.3 ¿Por qué importa?

Porque copiar una configuración a `.profile` no garantiza que todos los Shells la carguen.

### Idea clave

**`.profile` es una convención histórica útil, pero no representa un archivo universal de configuración para todos los Shells.**

---

# 13. Zsh Configuration Files

Zsh dispone de varios archivos de inicialización.

Los más conocidos son:

```text
~/.zshenv
~/.zprofile
~/.zshrc
~/.zlogin
~/.zlogout
```

Cada uno tiene una responsabilidad diferente.

## 13.1 Modelo de inicialización

```text
Zsh Starts
    │
    ▼
.zshenv
    │
    ├── Login?
    │      └── .zprofile
    │
    ├── Interactive?
    │      └── .zshrc
    │
    └── Login?
           └── .zlogin
```

El diagrama representa el orden conceptual de los archivos de usuario, sin mostrar los archivos de configuración del sistema ni las excepciones de inicio.

## 13.2 ¿Por qué tantos archivos?

Porque Zsh distingue diferentes momentos y tipos de inicialización.

### Idea clave

**Zsh ofrece archivos separados para configuraciones generales, Login e interacción con el usuario.**

---

# 14. ¿Qué es `.zshenv`?

`.zshenv` se carga normalmente al iniciar Zsh, incluso en sesiones no interactivas.

Por eso debe tratarse con especial cuidado.

## 14.1 ¿Para qué puede utilizarse?

Para configuraciones mínimas que realmente necesitan estar disponibles en diferentes modos de ejecución de Zsh.

## 14.2 ¿Qué deberíamos evitar?

- Mostrar mensajes.
- Ejecutar programas lentos.
- Iniciar herramientas interactivas.
- Modificar directorios sin necesidad.
- Ejecutar instalaciones.
- Introducir efectos secundarios inesperados.

## 14.3 ¿Por qué?

Porque una instrucción colocada aquí puede afectar Scripts y otros procesos que invoquen Zsh.

## 14.4 Recomendación

**Mantener `.zshenv` mínimo y evitar utilizarlo como archivo general de personalización.**

### Idea clave

**Cuanto más ampliamente se carga un archivo, mayor cuidado debemos tener con sus efectos secundarios.**

---

# 15. ¿Qué es `.zprofile`?

`.zprofile` se utiliza durante la inicialización Login de Zsh.

Puede ser apropiado para determinadas configuraciones relacionadas con el entorno de la sesión.

Ejemplo:

```zsh
export EDITOR="code"
```

## 15.1 ¿Cuándo se carga?

En sesiones Zsh iniciadas en modo Login, bajo sus reglas de inicialización.

## 15.2 ¿Se carga en todos los Shells interactivos?

No.

Un Zsh Interactive Non-login normalmente no lee `.zprofile`.

## 15.3 ¿Por qué importa?

Porque podemos definir una variable en `.zprofile` y no encontrarla al iniciar una sesión que no sea Login.

### Idea clave

**`.zprofile` pertenece al ciclo de inicialización Login de Zsh.**

---

# 16. ¿Qué es `.zshrc`?

`.zshrc` es uno de los archivos más utilizados por desarrolladores que trabajan con Zsh.

Se carga normalmente en sesiones interactivas.

Puede contener:

- Aliases.
- Funciones.
- Configuración del Prompt.
- Autocompletado.
- Opciones interactivas.
- Integración con herramientas de desarrollo.

## 16.1 Ejemplo de Alias

```zsh
alias ll='ls -la'
```

## 16.2 Ejemplo de variable

```zsh
export EDITOR="code"
```

## 16.3 Ejemplo de función

```zsh
croot() {
  cd "$HOME/projects"
}
```

La función supone que existe ese directorio.

## 16.4 ¿Debemos utilizar `.zshrc` para todo?

No.

Es preferible mantenerlo organizado y evitar configuraciones específicas de un proyecto que deban funcionar también fuera de una sesión interactiva.

## 16.5 ¿Qué ocurre si se vuelve muy grande?

Puede resultar difícil de mantener.

Podemos dividir configuraciones en archivos adicionales y cargarlos deliberadamente.

### Idea clave

**`.zshrc` suele ser el lugar principal para personalizar la experiencia interactiva de Zsh.**

---

# 17. `.zlogin` y `.zlogout`

Zsh también dispone de archivos relacionados con el inicio y finalización de sesiones Login.

## 17.1 `.zlogin`

Se ejecuta en sesiones Login después de otros archivos de inicialización aplicables.

No es simplemente otro nombre para `.zprofile`.

## 17.2 `.zlogout`

Se utiliza al finalizar determinadas sesiones Login.

## 17.3 ¿Necesitamos configurarlos?

En la mayoría de los entornos de desarrollo cotidianos, no es necesario comenzar personalizando estos archivos.

## 17.4 Recomendación

Utilizar únicamente los archivos cuya responsabilidad comprendemos y realmente necesitamos.

### Idea clave

**No necesitamos modificar todos los archivos disponibles para tener un entorno profesional.**

---

# 18. Bash vs Zsh Configuration

Veamos una comparación.

| Responsabilidad | Bash | Zsh |
|---|---|---|
| Configuración interactiva habitual | `.bashrc` | `.zshrc` |
| Configuración Login habitual | `.bash_profile` o alternativas | `.zprofile` |
| Configuración de todas las invocaciones | Mecanismos específicos | `.zshenv` |
| Configuración al finalizar Login | Mecanismos específicos | `.zlogout` |

## 18.1 ¿Son intercambiables?

No.

Aunque ambos Shells compartan parte de su sintaxis, sus reglas de inicialización no son idénticas.

## 18.2 ¿Podemos compartir configuraciones?

En determinados casos, sí.

Pero debemos considerar:

- Compatibilidad de sintaxis.
- Tipo de configuración.
- Orden de carga.
- Diferencias de comportamiento.

### Idea clave

**Podemos reutilizar conceptos entre Bash y Zsh, pero no debemos asumir que sus archivos de inicialización funcionan igual.**

---

# 19. PowerShell Profiles

PowerShell utiliza archivos de configuración llamados **Profiles**.

Un Profile es un Script de PowerShell que puede ejecutarse cuando se inicia una sesión compatible con su mecanismo de perfiles.

## 19.1 ¿Cómo consultar el perfil actual?

```powershell
$PROFILE
```

Esta variable automática contiene la ruta del perfil correspondiente al usuario actual y al Host actual.

## 19.2 ¿Dónde puede encontrarse?

La ubicación depende de:

- Sistema operativo.
- Versión de PowerShell.
- Host.
- Usuario.
- Tipo de perfil.

## 19.3 ¿Todos los perfiles existen automáticamente?

No.

Es posible que la ruta esté definida, pero el archivo todavía no exista.

## 19.4 Verificar existencia

```powershell
Test-Path $PROFILE
```

## 19.5 ¿Para qué sirve?

Puede utilizarse para configurar:

- Funciones.
- Aliases.
- Variables.
- Prompt.
- Integraciones de herramientas.

### Idea clave

**PowerShell utiliza Scripts de perfil para personalizar sesiones, pero sus ubicaciones y ámbitos dependen del Host y del usuario.**

---

# 20. Tipos de PowerShell Profiles

PowerShell contempla cuatro ámbitos habituales de perfil.

| Profile | Alcance |
|---|---|
| All Users, All Hosts | Todos los usuarios y Hosts compatibles |
| All Users, Current Host | Todos los usuarios del Host actual |
| Current User, All Hosts | Usuario actual en distintos Hosts |
| Current User, Current Host | Usuario y Host actuales |

## 20.1 Consultar rutas

```powershell
$PROFILE.AllUsersAllHosts
```

```powershell
$PROFILE.AllUsersCurrentHost
```

```powershell
$PROFILE.CurrentUserAllHosts
```

```powershell
$PROFILE.CurrentUserCurrentHost
```

## 20.2 ¿Cuál deberíamos modificar?

Para personalizaciones personales suele ser preferible un perfil de usuario.

Pero debemos elegir si la configuración debe aplicarse a todos los Hosts o solamente al actual.

## 20.3 ¿Qué es un Host?

Es la aplicación o entorno que proporciona la interfaz donde se ejecuta PowerShell.

Por ejemplo, diferentes Hosts pueden utilizar perfiles distintos.

### Idea clave

**En PowerShell, el alcance del perfil también depende del Host, no únicamente del usuario.**

---

# 21. Crear un PowerShell Profile

Antes de crear un perfil debemos comprobar si existe.

```powershell
Test-Path $PROFILE
```

Si no existe, podemos crear el directorio correspondiente y después el archivo.

```powershell
$profileDirectory = Split-Path -Parent $PROFILE

New-Item -ItemType Directory -Path $profileDirectory -Force
```

Después:

```powershell
New-Item -ItemType File -Path $PROFILE -Force
```

**Precaución:** si el perfil ya existe, no debemos sobrescribirlo sin revisar su contenido.

## 21.1 Abrirlo con VS Code

Si el comando `code` está disponible:

```powershell
code $PROFILE
```

## 21.2 Ejemplo de contenido

```powershell
function Say-Hello {
    Write-Output "Hello, developer"
}
```

## 21.3 ¿Cómo aplicar cambios?

Podemos iniciar una nueva sesión o cargar el perfil de forma deliberada.

```powershell
. $PROFILE
```

Esto ejecuta el contenido del perfil en la sesión actual.

### Idea clave

**Antes de crear o modificar un perfil, debemos comprobar su existencia y comprender el alcance de sus instrucciones.**

---

# 22. ¿Qué es `source`?

En Bash y Zsh podemos utilizar:

```bash
source file.sh
```

O su forma abreviada:

```bash
. file.sh
```

Estas instrucciones permiten ejecutar el contenido de un archivo dentro del contexto del Shell actual.

## 22.1 ¿Por qué importa?

Porque las asignaciones y funciones pueden afectar a la sesión actual.

Ejemplo:

```bash
source ~/.zshrc
```

Puede volver a ejecutar las instrucciones de ese archivo.

## 22.2 ¿Es lo mismo que ejecutar un Script normalmente?

No necesariamente.

Comparemos:

```bash
bash script.sh
```

con:

```bash
source script.sh
```

El primer comando inicia otra instancia de Bash.

El segundo ejecuta las instrucciones en el contexto del Shell actual.

## 22.3 Modelo

```text
Execute Script
     │
     ▼
Child Shell
     │
     └── Changes stay in child context
```

```text
Source Script
     │
     ▼
Current Shell
     │
     └── Changes can affect current session
```

## 22.4 Precaución importante

`source` ejecuta código.

No debemos utilizarlo con archivos desconocidos o no confiables.

### Idea clave

**Sourcing permite aplicar instrucciones al Shell actual, pero también ejecuta sus posibles efectos secundarios.**

---

# 23. ¿Debemos utilizar `source` después de cada cambio?

No necesariamente.

Depende del archivo y del tipo de configuración.

## 23.1 Caso habitual

Modificamos `.zshrc`.

Podemos abrir una nueva sesión interactiva de Zsh para comprobar la configuración.

## 23.2 Otra posibilidad

Ejecutar:

```bash
source ~/.zshrc
```

Pero esto puede volver a ejecutar:

- Modificaciones de PATH.
- Inicializaciones.
- Aliases.
- Funciones.
- Comandos con efectos secundarios.

## 23.3 ¿Qué problema puede aparecer?

Supongamos que `.zshrc` contiene:

```bash
export PATH="$HOME/tools/bin:$PATH"
```

Si lo cargamos repetidamente, podríamos duplicar esa entrada.

## 23.4 Recomendación profesional

Para verificar cambios de inicialización, abrir una nueva sesión suele ser una estrategia clara.

Utilizar `source` cuando comprendemos qué instrucciones estamos ejecutando.

### Idea clave

**Recargar un archivo de configuración no siempre es una operación sin efectos secundarios.**

---

# 24. Configuración de PATH en Startup Files

En el documento anterior aprendimos a modificar PATH temporalmente.

Ahora comprendemos que podemos establecer ciertas modificaciones durante la inicialización.

## 24.1 Ejemplo Bash/Zsh

```bash
export PATH="$HOME/tools/bin:$PATH"
```

## 24.2 ¿Dónde deberíamos colocarlo?

Depende de:

- Shell utilizado.
- Tipo de sesión.
- Herramienta instalada.
- Necesidad de la configuración.
- Instrucciones oficiales del instalador.

## 24.3 ¿Por qué no existe una respuesta universal?

Porque una configuración colocada en `.zshrc` puede estar disponible en sesiones interactivas, pero no necesariamente en procesos no interactivos.

Una configuración colocada en `.zprofile` puede aplicarse a sesiones Login, pero no a todas las demás.

## 24.4 ¿Qué ocurre con Version Managers?

Herramientas como nvm o mise pueden requerir mecanismos específicos de inicialización.

No debemos inventar configuraciones manuales si la herramienta proporciona instrucciones adecuadas para nuestro Shell.

### Idea clave

**El archivo correcto depende de cuándo necesitamos que la configuración esté disponible.**

---

# 25. Configuración de Aliases y Functions

Los Aliases y las funciones suelen estar relacionados con la productividad interactiva.

## 25.1 Alias en Bash/Zsh

```bash
alias gs='git status'
```

## 25.2 Función en Bash/Zsh

```bash
cprojects() {
  cd "$HOME/projects"
}
```

## 25.3 ¿Dónde colocarlos?

Normalmente en la configuración interactiva del Shell.

Por ejemplo:

```text
Bash → ~/.bashrc
Zsh  → ~/.zshrc
```

## 25.4 ¿Por qué no colocarlos indiscriminadamente en configuraciones globales?

Porque pueden:

- Cambiar el significado de comandos.
- Introducir dependencias personales.
- Afectar Scripts.
- Crear conflictos entre herramientas.

## 25.5 PowerShell

Podemos definir funciones dentro de un Profile:

```powershell
function Go-Projects {
    Set-Location "$HOME/projects"
}
```

### Idea clave

**Aliases y Functions son herramientas de productividad, pero deben mantenerse separadas de las necesidades esenciales de los proyectos.**

---

# 26. User Configuration vs Project Configuration

Una distinción profesional muy importante.

## 26.1 User Configuration

Pertenece a las preferencias personales del desarrollador.

Ejemplos:

- Prompt.
- Aliases.
- Funciones personales.
- Editor preferido.
- Integraciones visuales.

## 26.2 Project Configuration

Pertenece a las necesidades de un proyecto.

Ejemplos:

- Versión requerida de Node.js.
- Package Manager.
- Scripts.
- Variables necesarias.
- Configuración de herramientas.
- Convenciones de desarrollo.

## 26.3 Ejemplo

No es recomendable que un proyecto dependa exclusivamente de un Alias personal:

```bash
alias startapp='cd ~/projects/my-app && npm run dev'
```

El Alias puede ser útil para ti.

Pero otros desarrolladores no necesariamente lo tendrán.

## 26.4 ¿Qué debería hacer el proyecto?

Declarar sus propias instrucciones y Scripts.

Ejemplo:

```json
{
  "scripts": {
    "dev": "vite"
  }
}
```

### Idea clave

**La configuración personal mejora nuestra productividad; la configuración del proyecto permite que el equipo trabaje de manera consistente.**

---

# 27. Shell Configuration y Reproducible Environments

Una configuración profesional debe permitir que el entorno sea comprensible y mantenible.

## 27.1 Problema habitual

Un desarrollador configura manualmente su Shell durante años.

Termina con:

```text
.zshrc
│
├── Old Node Configuration
├── Previous PATH Entries
├── Unused Aliases
├── Deprecated Tools
├── Duplicate Initialization
└── Unknown Scripts
```

El entorno funciona parcialmente, pero resulta difícil de reproducir.

## 27.2 ¿Cómo mejorar?

- Mantener configuraciones organizadas.
- Documentar herramientas necesarias.
- Evitar duplicaciones.
- Eliminar configuraciones obsoletas.
- Separar preferencias personales.
- Utilizar gestores de versiones.
- Evitar rutas absolutas personales dentro de proyectos compartidos.

## 27.3 ¿Debemos guardar nuestros Dotfiles en Git?

Puede ser útil.

Pero antes debemos revisar que no contengan:

- Credenciales.
- Tokens.
- Claves privadas.
- Datos sensibles.
- Rutas corporativas que no deban compartirse.

### Idea clave

**Un entorno profesional no necesita una configuración enorme; necesita una configuración clara, controlada y mantenible.**

---

# 28. ¿Qué son Dotfiles?

Los **Dotfiles** son archivos cuyos nombres comienzan con un punto en sistemas Unix-like.

Ejemplos:

```text
.zshrc
.bashrc
.gitconfig
.npmrc
```

En estos sistemas, suelen estar ocultos en listados normales de directorios.

## 28.1 ¿Todos son Shell Configuration Files?

No.

Por ejemplo:

```text
.gitconfig
```

es un archivo de configuración de Git.

```text
.npmrc
```

es un archivo de configuración de npm y herramientas compatibles.

## 28.2 ¿Por qué se llaman Dotfiles?

Por el punto inicial del nombre.

## 28.3 ¿Por qué importan?

Porque muchas herramientas de desarrollo utilizan archivos de configuración en el directorio personal o dentro de proyectos.

### Idea clave

**Dotfile describe una convención de nombre; no significa necesariamente configuración del Shell.**

---

# 29. Buenas prácticas para organizar la configuración

## 29.1 Mantener responsabilidades separadas

Ejemplo:

```text
~/.zprofile
    └── Login Environment

~/.zshrc
    ├── Aliases
    ├── Functions
    └── Interactive Tooling
```

## 29.2 Evitar duplicar PATH

Antes de agregar un directorio, verificar si ya está presente cuando la configuración pueda ejecutarse repetidamente.

## 29.3 Evitar operaciones destructivas

Un archivo de inicialización no debería borrar archivos ni modificar proyectos inesperadamente.

## 29.4 Evitar instalaciones automáticas

No es recomendable que cada nueva terminal intente instalar herramientas.

## 29.5 Evitar imprimir secretos

No debemos mostrar tokens o credenciales durante el inicio.

## 29.6 Documentar configuraciones especiales

Especialmente cuando una herramienta necesita instrucciones particulares.

## 29.7 Mantener la inicialización rápida

Una configuración lenta afecta cada nueva sesión.

## 29.8 Revisar cambios antes de aplicarlos

Una modificación incorrecta puede dificultar el uso de la terminal.

### Idea clave

**La calidad de una configuración se mide por su claridad, seguridad y previsibilidad, no por la cantidad de personalizaciones.**

---

# 30. Troubleshooting: Changes Are Not Applied

## Situación

Modificamos:

```text
~/.zshrc
```

Pero no observamos el cambio esperado.

## Posibles causas

1. Estamos utilizando otro Shell.
2. La sesión no es interactiva.
3. El archivo no existe en la ubicación esperada.
4. Existe un error de sintaxis.
5. La configuración está siendo sobrescrita posteriormente.
6. El cambio requiere una nueva sesión.
7. La herramienta utiliza otro mecanismo de inicialización.

## Diagnóstico

### Paso 1

Identificar el Shell.

### Paso 2

Identificar el modo de sesión.

### Paso 3

Verificar el archivo.

```bash
ls -la ~/.zshrc
```

### Paso 4

Revisar el contenido.

```bash
cat ~/.zshrc
```

Antes de compartir la salida, revisar que no contenga información sensible.

### Paso 5

Comprobar la sintaxis.

Para Zsh:

```bash
zsh -n ~/.zshrc
```

Para Bash:

```bash
bash -n ~/.bashrc
```

Estas comprobaciones ayudan a detectar errores de sintaxis, pero no garantizan que toda la configuración sea correcta.

### Idea clave

**Cuando un cambio no se aplica, debemos investigar el ciclo de inicialización antes de modificar más archivos.**

---

# 31. Troubleshooting: PATH Works in One Terminal Only

## Situación

Node.js funciona en una terminal externa, pero no en otra sesión.

## Posibles causas

- Diferentes Shells.
- Diferentes modos Login.
- Diferentes Startup Files.
- Diferente entorno heredado.
- Inicialización incompleta de un Version Manager.
- Sesiones iniciadas antes de los cambios.

## Modelo

```text
Terminal A
    │
    ▼
Login Zsh
    │
    ├── .zprofile
    └── .zshrc
```

```text
Terminal B
    │
    ▼
Interactive Non-login Zsh
    │
    └── .zshrc
```

Ambas sesiones pueden terminar con configuraciones diferentes.

## Diagnóstico

Comparar:

```bash
command -v node
```

```bash
node --version
```

Y, cuando sea necesario, inspeccionar PATH sin compartir datos sensibles.

### Idea clave

**La diferencia entre terminales puede estar en cómo se inicia el Shell, no en la instalación de Node.js.**

---

# 32. Troubleshooting: Terminal Starts Slowly

## Situación

Abrir una terminal tarda varios segundos.

## Posibles causas

- Inicializaciones repetidas.
- Herramientas lentas.
- Scripts innecesarios.
- Comandos de red.
- Configuraciones duplicadas.
- Integraciones obsoletas.

## 32.1 ¿Cómo investigar?

Revisar los archivos cargados y las herramientas inicializadas.

Podemos probar temporalmente un Shell con una configuración mínima, siguiendo las opciones apropiadas de ese Shell.

## 32.2 ¿Debemos borrar `.zshrc`?

No.

Primero debemos identificar qué instrucciones producen el problema.

## 32.3 Buena práctica

Realizar cambios pequeños y verificables.

### Idea clave

**La configuración del Shell forma parte del rendimiento y la experiencia del entorno de desarrollo.**

---

# 33. Troubleshooting: Duplicate PATH Entries

## Situación

Observamos:

```text
/home/developer/tools/bin
/home/developer/tools/bin
/home/developer/tools/bin
```

dentro de PATH.

## Posible causa

Un archivo de inicialización agrega la misma ruta repetidamente.

Ejemplo:

```bash
export PATH="$HOME/tools/bin:$PATH"
```

Si se ejecuta varias veces, puede duplicar la entrada.

## 33.1 ¿Es siempre un error crítico?

No.

Pero puede dificultar el diagnóstico y mantener una configuración innecesariamente compleja.

## 33.2 ¿Cómo prevenirlo?

Podemos diseñar configuraciones idempotentes.

**Idempotent Configuration** significa que ejecutar la configuración repetidamente no produce cambios acumulativos indeseados.

## 33.3 Ejemplo conceptual

```text
Check if directory is present
             │
             ├── Yes → Do nothing
             │
             └── No → Add directory
```

### Idea clave

**Una buena configuración debe comportarse de forma predecible incluso cuando se carga más de una vez.**

---

# 34. Práctica 01 — Identificar el Shell

## Objetivo

Reconocer qué Shell utilizamos.

### Bash/Zsh

Ejecuta:

```bash
echo "$SHELL"
```

Después:

```bash
echo "$0"
```

Y:

```bash
ps -p $$ -o comm=
```

## Preguntas

1. ¿Qué Shell está configurado para tu usuario?
2. ¿Qué proceso parece estar ejecutándose?
3. ¿Coinciden los resultados?
4. ¿Por qué no deberíamos confiar únicamente en `SHELL`?

### PowerShell

Ejecuta:

```powershell
$PSVersionTable.PSVersion
```

Y:

```powershell
$PROFILE
```

## Preguntas

1. ¿Qué versión de PowerShell utilizas?
2. ¿Cuál es la ruta de tu perfil?
3. ¿El archivo existe?

---

# 35. Práctica 02 — Identificar el modo del Shell

## Objetivo

Diferenciar Login e Interactive.

### Bash

Para comprobar si la sesión es interactiva:

```bash
case $- in
  *i*) echo "Interactive" ;;
  *) echo "Non-interactive" ;;
esac
```

Para consultar el estado Login en Bash:

```bash
shopt -q login_shell && echo "Login" || echo "Non-login"
```

### Zsh

Podemos consultar opciones del Shell:

```zsh
[[ -o interactive ]] && echo "Interactive" || echo "Non-interactive"
```

```zsh
[[ -o login ]] && echo "Login" || echo "Non-login"
```

## Preguntas

1. ¿Tu Shell es interactivo?
2. ¿Está iniciado en modo Login?
3. ¿Qué archivos debería cargar según ese modo?
4. ¿La configuración de tu terminal coincide con lo esperado?

---

# 36. Práctica 03 — Inspeccionar Startup Files

## Objetivo

Identificar archivos existentes sin modificarlos.

### Zsh

```bash
ls -la ~/.zshenv ~/.zprofile ~/.zshrc ~/.zlogin 2>/dev/null
```

### Bash

```bash
ls -la ~/.bash_profile ~/.bash_login ~/.bashrc ~/.profile 2>/dev/null
```

Los comandos anteriores muestran archivos existentes y silencian errores de archivos ausentes.

## Preguntas

1. ¿Qué archivos existen?
2. ¿Cuáles no existen?
3. ¿Qué archivos corresponden a tu Shell?
4. ¿Necesitas realmente crear alguno nuevo?

**No crees archivos innecesarios.**

---

# 37. Práctica 04 — Comprender `source`

Esta práctica utiliza un archivo temporal y evita modificar tu configuración personal.

Diseñada para Bash y Zsh.

## Paso 1 — Crear un directorio de práctica

```bash
mkdir -p "$HOME/tooling-shell-practice"
```

## Paso 2 — Crear un archivo de prueba

```bash
printf '%s\n' 'TOOLING_MESSAGE="Hello from sourced file"' > "$HOME/tooling-shell-practice/example.sh"
```

## Paso 3 — Ejecutar el archivo con Bash

```bash
bash "$HOME/tooling-shell-practice/example.sh"
```

## Paso 4 — Consultar la variable

```bash
echo "$TOOLING_MESSAGE"
```

Si no estaba definida previamente, no debería mostrar el valor asignado por el proceso hijo.

## Paso 5 — Cargarlo con `source`

```bash
source "$HOME/tooling-shell-practice/example.sh"
```

## Paso 6 — Consultar nuevamente

```bash
echo "$TOOLING_MESSAGE"
```

Resultado esperado:

```text
Hello from sourced file
```

## Paso 7 — Limpiar

```bash
unset TOOLING_MESSAGE
```

```bash
rm "$HOME/tooling-shell-practice/example.sh"
rmdir "$HOME/tooling-shell-practice"
```

Realiza la limpieza únicamente si los archivos corresponden a esta práctica.

## Reflexión

1. ¿Qué ocurrió al ejecutar el Script mediante Bash?
2. ¿Qué ocurrió al utilizar `source`?
3. ¿Por qué la variable permaneció disponible después del segundo caso?
4. ¿Qué riesgos existirían al cargar un archivo desconocido?

---

# 38. Práctica 05 — Diseñar una configuración profesional

Imaginemos que queremos configurar Zsh para trabajar con:

- Git.
- Node.js.
- VS Code.
- Un directorio personal de proyectos.

## Objetivo

Decidir qué configuración pertenece al Shell y qué configuración pertenece a los proyectos.

## Propuesta conceptual

```text
User Shell Configuration
│
├── Editor Preference
├── Git Aliases
├── Personal Navigation Functions
└── Version Manager Integration
```

```text
Project Configuration
│
├── Required Node Version
├── Package Manager
├── Build Scripts
├── Lint Scripts
└── Environment Template
```

## Preguntas

1. ¿Dónde colocarías un Alias personal de Git?
2. ¿Dónde declararías la versión requerida de Node.js?
3. ¿Dónde documentarías variables necesarias para una API?
4. ¿Dónde configurarías una integración interactiva del Prompt?
5. ¿Qué información no debería aparecer en Dotfiles públicos?

### Aprendizaje

**Un entorno profesional separa preferencias personales de requisitos compartidos del proyecto.**

---

# 39. Casos reales de ingeniería

## Caso 1 — nvm funciona en una terminal, pero no en otra

**Posible causa:** La inicialización de nvm no se ejecuta en el tipo de sesión utilizado.

**Aprendizaje:** Identificar el Shell, sus Startup Files y el mecanismo de inicialización del gestor.

---

## Caso 2 — Un Alias funciona manualmente, pero no en CI

**Posible causa:** El Alias pertenece a una sesión interactiva personal.

**Aprendizaje:** Los Scripts de proyecto no deben depender de Aliases personales.

---

## Caso 3 — PATH contiene rutas duplicadas

**Posible causa:** Un archivo de configuración agrega directorios repetidamente.

**Aprendizaje:** Diseñar configuraciones idempotentes.

---

## Caso 4 — PowerShell no carga el perfil esperado

**Posibles causas:** Perfil inexistente, Host diferente, inicio con opciones que omiten perfiles o restricciones de ejecución.

**Aprendizaje:** Comprobar el perfil correspondiente y el contexto de ejecución.

---

## Caso 5 — Un cambio en `.zprofile` no afecta una sesión Non-login

**Posible causa:** Ese tipo de sesión no carga `.zprofile`.

**Aprendizaje:** Elegir el archivo según el modo de inicialización.

---

## Caso 6 — La terminal tarda demasiado en abrirse

**Posible causa:** Inicializaciones lentas o repetidas.

**Aprendizaje:** Mantener configuraciones ligeras y revisar sus efectos secundarios.

---

# 40. Errores frecuentes

### Error 1 — Pensar que todos los Shells leen los mismos archivos

Bash, Zsh y PowerShell tienen mecanismos distintos.

### Error 2 — Confundir Login con Interactive

Son dimensiones independientes.

### Error 3 — Modificar `.bashrc` mientras utilizamos Zsh

Zsh no lo carga automáticamente bajo sus reglas normales.

### Error 4 — Colocar todo en `.zshenv`

Puede afectar ejecuciones no interactivas.

### Error 5 — Suponer que `.profile` se carga siempre

Depende del Shell y de otros archivos existentes.

### Error 6 — Pensar que `source` inicia un proceso hijo

Ejecuta instrucciones en el contexto del Shell actual.

### Error 7 — Ejecutar `source` sobre archivos desconocidos

Puede ejecutar código no confiable.

### Error 8 — Duplicar PATH

Puede producir configuraciones difíciles de mantener.

### Error 9 — Colocar secretos en Dotfiles compartidos

Puede provocar exposición de credenciales.

### Error 10 — Depender de Aliases personales en Scripts de proyecto

Reduce la reproducibilidad.

### Error 11 — Sobrescribir perfiles existentes

Puede destruir configuraciones útiles.

### Error 12 — Modificar configuraciones sin verificar el Shell actual

Puede provocar cambios ineficaces o confusos.

### Error 13 — Colocar comandos lentos en archivos de inicialización

Puede afectar cada nueva sesión.

### Error 14 — Confundir configuración temporal y persistente

Tienen alcances diferentes.

### Error 15 — No documentar integraciones especiales

Dificulta el mantenimiento y la migración a otra computadora.

---

# 41. Comprueba tu modelo mental

1. ¿Qué es Shell Configuration?
2. ¿Qué es Shell Initialization?
3. ¿Qué es un Startup File?
4. ¿Qué significa Login Shell?
5. ¿Qué significa Non-login Shell?
6. ¿Qué significa Interactive Shell?
7. ¿Qué significa Non-interactive Shell?
8. ¿Por qué Login e Interactive son dimensiones diferentes?
9. ¿Cuáles son las cuatro combinaciones posibles?
10. ¿Qué archivos puede leer Bash en modo Login?
11. ¿Qué ocurre si existen `.bash_profile` y `.profile`?
12. ¿Qué función cumple `.bashrc`?
13. ¿Por qué `.bashrc` suele utilizarse para configuraciones interactivas?
14. ¿Qué es `.bash_profile`?
15. ¿Qué es `.profile`?
16. ¿Bash lee siempre `.profile`?
17. ¿Cuáles son los principales Startup Files de Zsh?
18. ¿Qué responsabilidad tiene `.zshenv`?
19. ¿Por qué debemos mantener `.zshenv` mínimo?
20. ¿Qué responsabilidad tiene `.zprofile`?
21. ¿Qué responsabilidad tiene `.zshrc`?
22. ¿Qué función cumple `.zlogin`?
23. ¿Qué función cumple `.zlogout`?
24. ¿Qué es un PowerShell Profile?
25. ¿Qué representa `$PROFILE`?
26. ¿Qué tipos de PowerShell Profiles existen?
27. ¿Qué significa Current Host?
28. ¿Cómo verificas si existe un Profile?
29. ¿Qué significa `source`?
30. ¿Cuál es la diferencia entre ejecutar y cargar un Script?
31. ¿Por qué `source` puede modificar la sesión actual?
32. ¿Qué riesgos tiene cargar archivos desconocidos?
33. ¿Qué significa una configuración idempotente?
34. ¿Por qué puede duplicarse PATH?
35. ¿Por qué una variable puede existir en una terminal y no en otra?
36. ¿Por qué un Alias puede no funcionar en CI?
37. ¿Qué son Dotfiles?
38. ¿Todos los Dotfiles son configuraciones del Shell?
39. ¿Qué diferencia existe entre User Configuration y Project Configuration?
40. ¿Dónde debería declararse una versión requerida de Node.js?
41. ¿Dónde colocarías un Alias personal?
42. ¿Qué revisarías si una configuración no se aplica?
43. ¿Qué revisarías si una terminal tarda demasiado en abrirse?
44. ¿Por qué debemos evitar instalaciones automáticas en Startup Files?
45. ¿Cuál es la regla principal para elegir un archivo de configuración?

---

# 42. Checklist de aprendizaje

## Fundamentals

- [ ] Comprendo Shell Configuration.
- [ ] Comprendo Shell Initialization.
- [ ] Diferencio Login y Non-login.
- [ ] Diferencio Interactive y Non-interactive.
- [ ] Reconozco las cuatro combinaciones.

## Bash

- [ ] Comprendo `.bashrc`.
- [ ] Comprendo `.bash_profile`.
- [ ] Comprendo `.profile`.
- [ ] Conozco las reglas básicas de carga.
- [ ] Sé que Bash no ejecuta automáticamente todos los archivos de perfil.

## Zsh

- [ ] Comprendo `.zshenv`.
- [ ] Comprendo `.zprofile`.
- [ ] Comprendo `.zshrc`.
- [ ] Reconozco `.zlogin` y `.zlogout`.
- [ ] Comprendo por qué `.zshenv` debe mantenerse mínimo.

## PowerShell

- [ ] Comprendo qué es un Profile.
- [ ] Sé consultar `$PROFILE`.
- [ ] Reconozco los cuatro ámbitos habituales.
- [ ] Sé comprobar si existe el archivo.
- [ ] Comprendo la diferencia entre usuario y Host.

## Professional Practices

- [ ] Comprendo `source`.
- [ ] Diferencio ejecutar y cargar un Script.
- [ ] Evito configuraciones duplicadas.
- [ ] Mantengo separadas configuraciones personales y de proyecto.
- [ ] Comprendo el concepto de Idempotency.
- [ ] Evito almacenar secretos en Dotfiles compartidos.
- [ ] Puedo diagnosticar problemas de inicialización.

---

# 43. Resumen conceptual

Nuestro modelo mental queda así:

```text
Terminal Application
        │
        ▼
Shell Process
        │
        ▼
Shell Initialization
        │
        ├── Login / Non-login
        │
        └── Interactive / Non-interactive
        │
        ▼
Applicable Startup Files
        │
        ▼
Shell Configuration
        │
        ├── Environment Variables
        ├── PATH
        ├── Aliases
        ├── Functions
        └── Tool Integrations
        │
        ▼
Ready Shell
```

También debemos recordar:

```text
Login Shell ≠ Interactive Shell
```

```text
Shell Configuration ≠ Project Configuration
```

```text
Execute Script ≠ Source Script
```

Y una última distinción:

```text
Persistent Configuration
          ≠
Configuration Loaded in Every Process
```

Una configuración puede estar guardada permanentemente y, aun así, no cargarse en determinados modos de ejecución.

---

# 44. Idea clave

**Los Shell Configuration Files permiten preparar nuestro entorno de trabajo, pero su comportamiento depende del Shell, del modo de inicialización y del alcance de cada configuración.**

La pregunta profesional no es únicamente:

> ¿En qué archivo debo colocar este comando?

Debemos preguntarnos:

- ¿Qué Shell utilizo?
- ¿La sesión es Login?
- ¿Es Interactive?
- ¿Qué procesos necesitan esta configuración?
- ¿Debe ser personal o compartida por el proyecto?
- ¿Puede ejecutarse repetidamente sin problemas?
- ¿Introduce riesgos de seguridad?
- ¿Cómo verificaré que funciona?

Comprender estas responsabilidades nos permitirá configurar nuestros entornos de forma profesional, evitando soluciones improvisadas y difíciles de mantener.

---

# 45. Siguiente paso

Ahora que sabemos cómo se inicializa y configura un Shell, estudiaremos dos mecanismos que permiten mejorar nuestra productividad:

**Shell Aliases y Shell Functions.**

Aprenderemos:

- Qué es un Alias.
- Cómo crear abreviaturas.
- Qué es una Shell Function.
- Diferencias entre Alias y Function.
- Parámetros y argumentos.
- Cuándo utilizar cada mecanismo.
- Cómo organizar personalizaciones.
- Errores frecuentes.
- Buenas prácticas para evitar conflictos.

👉 [08 — Shell Aliases](./08-shell-aliases.md)

**Primero aprendimos a configurar el Shell. Ahora aprenderemos a personalizar comandos sin perder claridad ni mantenibilidad.**