# Linux Shell Configuration

## Introducción

Cuando abrimos una Terminal en Linux, normalmente encontramos un entorno preparado para ejecutar comandos.

Podemos escribir:

```bash
git --version
```

O:

```bash
node --version
```

Y, si las herramientas están disponibles, obtenemos sus versiones.

Pero ¿cómo sabe el sistema dónde encontrarlas?

¿Por qué algunas variables aparecen automáticamente?

¿Por qué un comando funciona en una Terminal y falla dentro de un Script?

¿Por qué modificar `.bashrc` no siempre soluciona un problema?

¿Por qué algunas configuraciones funcionan al abrir una Terminal, pero desaparecen cuando iniciamos otra sesión?

Para responder estas preguntas necesitamos comprender cómo funciona la configuración del Shell.

En este documento estudiaremos los conceptos fundamentales de **Shell Sessions, Startup Files, Environment Variables y PATH**.

No buscamos memorizar configuraciones complejas ni personalizar nuestra Terminal prematuramente.

Buscamos construir un modelo mental que nos permita comprender, diagnosticar y configurar correctamente un entorno Linux.

Nuestra metodología será:

**Problema → Concepto → Responsabilidad → Ciclo de inicio → Configuración → Diagnóstico → Práctica → Buenas prácticas.**

---

## 🎯 Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Explicar qué es un Shell.
2. Diferenciar Terminal Emulator y Shell.
3. Reconocer los principales Shells disponibles en Linux.
4. Comprender qué es una Shell Session.
5. Diferenciar Login Shell, Interactive Shell y Non-interactive Shell.
6. Explicar qué son los Startup Files.
7. Comprender la responsabilidad de `.bashrc`, `.bash_profile` y `.profile`.
8. Comprender las diferencias generales entre Bash y Zsh.
9. Diferenciar Shell Variables y Environment Variables.
10. Comprender cómo se heredan las variables de entorno.
11. Explicar qué es PATH y cómo se resuelven comandos.
12. Diferenciar configuración temporal y persistente.
13. Comprender qué son Alias y Shell Functions.
14. Reconocer errores frecuentes de configuración.
15. Diagnosticar problemas sin modificar innecesariamente el sistema.
16. Aplicar buenas prácticas de configuración personal y de equipo.

---

# 1. El problema: un comando funciona en una Terminal, pero no en otra

Imagina que instalamos Node.js.

Abrimos una Terminal y ejecutamos:

```bash
node --version
```

Resultado:

```text
v22.x.x
```

Todo parece correcto.

Sin embargo, ejecutamos un Script desde otro contexto y recibimos:

```text
node: command not found
```

¿Cómo es posible?

Podríamos pensar que Node.js se ha desinstalado.

Pero no necesariamente.

El problema puede estar relacionado con la configuración del entorno donde se ejecuta el comando.

Por ejemplo:

```text
Terminal A
    │
    ▼
Bash Interactive Session
    │
    ▼
PATH Configuration
    │
    ▼
Node.js Available
```

Mientras tanto:

```text
Automation Process
    │
    ▼
Non-interactive Shell
    │
    ▼
Different Environment
    │
    ▼
Node.js Not Found
```

Ambos procesos pueden ejecutarse en la misma máquina y tener entornos diferentes.

## 1.1 ¿Por qué sucede?

Porque los procesos no comparten necesariamente las mismas variables ni cargan los mismos archivos de configuración.

## 1.2 ¿Cuál es nuestro objetivo?

Comprender cómo se construye el entorno de ejecución de cada proceso.

### Idea clave

**Una herramienta puede estar instalada correctamente y, aun así, no estar disponible en todas las sesiones.**

---

# 2. ¿Qué es un Shell?

Un **Shell** es un programa que proporciona una interfaz para ejecutar comandos y trabajar con el sistema operativo.

Entre sus responsabilidades habituales encontramos:

- Interpretar instrucciones.
- Ejecutar programas.
- Gestionar variables.
- Procesar redirecciones.
- Crear pipelines.
- Ejecutar Scripts.
- Proporcionar funcionalidades interactivas.

## 2.1 Modelo conceptual

```text
Developer
    │
    ▼
Shell
    │
    ├── Interpret Commands
    ├── Expand Variables
    ├── Resolve Commands
    ├── Handle Redirections
    └── Execute Programs
             │
             ▼
       Operating System
```

## 2.2 Ejemplo

```bash
echo "Hello Linux"
```

El Shell interpreta la instrucción y ejecuta la operación correspondiente.

Dependiendo del Shell, `echo` puede implementarse como un comando interno.

## 2.3 ¿El Shell es el sistema operativo?

No.

El Shell es un programa que utiliza servicios del sistema operativo.

## 2.4 ¿El Shell es la Terminal?

Tampoco.

Son componentes distintos.

---

# 3. Terminal Emulator vs Shell

Una **Terminal Emulator** es una aplicación que proporciona una interfaz para interactuar con sesiones de línea de comandos.

Un **Shell** interpreta las instrucciones introducidas.

## 3.1 Ejemplos de Terminal Emulators

- GNOME Terminal.
- Konsole.
- Alacritty.
- Kitty.
- Xfce Terminal.

## 3.2 Ejemplos de Shells

- Bash.
- Zsh.
- Fish.
- Dash.

## 3.3 Relación conceptual

```text
┌──────────────────────────────┐
│       Terminal Emulator      │
│                              │
│  ┌────────────────────────┐  │
│  │         Shell          │  │
│  │                        │  │
│  │   $ git --version      │  │
│  │                        │  │
│  └────────────────────────┘  │
└──────────────────────────────┘
```

## 3.4 ¿Una Terminal siempre necesita un Shell?

No necesariamente.

Una Terminal Emulator puede ejecutar otros programas de consola.

Sin embargo, en el desarrollo cotidiano suele utilizarse para interactuar con un Shell.

## 3.5 ¿Podemos utilizar un Shell sin una Terminal gráfica?

Sí.

Por ejemplo:

- Sesiones SSH.
- Scripts.
- Procesos automatizados.
- Contenedores.
- Entornos sin interfaz gráfica.

### Principio

**La Terminal proporciona una interfaz; el Shell proporciona un entorno de interpretación y ejecución.**

---

# 4. Principales Shells en Linux

Linux permite utilizar diferentes Shells.

## 4.1 Bash

Bash significa:

**Bourne Again Shell**.

Es uno de los Shells más utilizados en sistemas Linux.

Proporciona:

- Ejecución de comandos.
- Variables.
- Funciones.
- Scripts.
- Historial interactivo.
- Autocompletado configurable.

## 4.2 Zsh

Zsh es otro Shell con capacidades interactivas y de scripting.

Es conocido por sus opciones de personalización y funcionalidades de interacción.

## 4.3 Fish

Fish está orientado a ofrecer una experiencia interactiva accesible.

Incluye funcionalidades como sugerencias y autocompletado.

Su lenguaje de scripting no es completamente compatible con Bash.

## 4.4 Dash

Dash es un Shell ligero que implementa funcionalidades del lenguaje POSIX Shell.

En algunas distribuciones se utiliza para ejecutar determinados Scripts del sistema.

## 4.5 Comparación

| Shell | Característica general |
|---|---|
| Bash | Muy utilizado en Linux y scripting |
| Zsh | Amplias capacidades interactivas |
| Fish | Experiencia interactiva y sintaxis propia |
| Dash | Shell ligero orientado a compatibilidad POSIX |

## 4.6 ¿Cuál deberíamos aprender primero?

**Bash es una excelente opción para comenzar.**

Su conocimiento resulta útil para:

- Desarrollo Backend.
- Automatización.
- Linux Servers.
- CI/CD.
- Contenedores.
- DevOps.

No significa que debamos abandonar Zsh, Fish u otros Shells.

### Recomendación

Aprender primero los fundamentos generales y después profundizar en las características particulares del Shell elegido.

---

# 5. ¿Qué es una Shell Session?

Una **Shell Session** es una instancia de ejecución de un Shell.

Cada sesión posee un contexto propio.

Puede incluir:

- Variables.
- Directorio actual.
- Opciones del Shell.
- Alias.
- Funciones.
- Historial.
- Procesos asociados.

## 5.1 Ejemplo

Abrimos dos Terminales.

```text
Terminal A
    │
    ▼
Bash Process A
```

```text
Terminal B
    │
    ▼
Bash Process B
```

Aunque ambas utilicen Bash, no son el mismo proceso.

## 5.2 ¿Comparten todas sus variables?

No.

Pueden comenzar con entornos similares, pero sus modificaciones posteriores no se sincronizan automáticamente.

## 5.3 Ejemplo conceptual

En la sesión A:

```bash
PROJECT_NAME="Tooling Mastery"
```

En la sesión B:

```bash
echo "$PROJECT_NAME"
```

La variable no tiene por qué existir.

## 5.4 ¿Por qué importa?

Porque una configuración realizada en una sesión puede no afectar a las demás.

### Idea clave

**Cada sesión tiene su propio estado y contexto de ejecución.**

---

# 6. Interactive Shell vs Non-interactive Shell

Esta distinción es fundamental.

## 6.1 Interactive Shell

Es un Shell preparado para interactuar directamente con el usuario.

Por ejemplo, cuando abrimos una Terminal y escribimos comandos.

```text
Developer
    │
    ▼
Interactive Shell
    │
    ▼
Commands
```

Puede proporcionar:

- Prompt.
- Historial.
- Autocompletado.
- Funciones interactivas.

## 6.2 Non-interactive Shell

Es un Shell que ejecuta instrucciones sin requerir una interacción continua con el usuario.

Por ejemplo, un Script.

```bash
bash script.sh
```

## 6.3 Modelo conceptual

```text
Interactive Shell
    │
    ├── User Input
    ├── Prompt
    └── Interactive Features
```

```text
Non-interactive Shell
    │
    ├── Script Input
    └── Automated Execution
```

## 6.4 ¿Por qué importa?

Porque Bash puede cargar archivos de configuración diferentes según el tipo de sesión.

Por ejemplo, `.bashrc` suele utilizarse para configurar sesiones interactivas de Bash que no son de inicio de sesión.

Un Script no interactivo no debe depender de que se haya cargado automáticamente la configuración personal interactiva.

### Principio

**Los Scripts profesionales deben declarar o recibir explícitamente las dependencias de entorno que necesitan.**

---

# 7. Login Shell vs Non-login Shell

Ahora introduciremos otra clasificación.

Una sesión puede ser:

- Login Shell.
- Non-login Shell.

Esta clasificación es independiente de si la sesión es interactiva.

## 7.1 Login Shell

Es una sesión iniciada bajo las reglas de inicio de sesión del Shell.

Puede utilizarse en determinados accesos al sistema o configuraciones de Terminal.

## 7.2 Non-login Shell

Es una sesión que no utiliza ese modo de inicio.

Por ejemplo, muchas Terminales gráficas abren sesiones interactivas no-login por defecto.

Pero este comportamiento depende de la aplicación y de su configuración.

## 7.3 Combinaciones posibles

| Tipo | Interactive | Login |
|---|---|---|
| Interactive Login Shell | Sí | Sí |
| Interactive Non-login Shell | Sí | No |
| Non-interactive Login Shell | No | Sí |
| Non-interactive Non-login Shell | No | No |

## 7.4 ¿Por qué importa?

Porque los archivos de inicialización que carga Bash dependen de estas condiciones.

### Idea clave

**Interactive y Login describen propiedades diferentes de una sesión.**

---

# 8. ¿Qué son los Shell Startup Files?

Los **Startup Files** son archivos que un Shell puede leer durante su inicialización.

Permiten establecer configuraciones como:

- Variables.
- PATH.
- Alias.
- Funciones.
- Opciones.
- Comportamientos interactivos.

## 8.1 Ejemplo conceptual

```text
Start Shell
    │
    ▼
Determine Session Type
    │
    ▼
Read Applicable Startup Files
    │
    ▼
Apply Configuration
    │
    ▼
Shell Ready
```

## 8.2 ¿Todos los Shells utilizan los mismos archivos?

No.

Bash, Zsh y Fish tienen mecanismos diferentes.

## 8.3 ¿Los Startup Files siempre se ejecutan?

No.

Depende de:

- Shell.
- Modo de inicio.
- Configuración.
- Forma de invocación.
- Condiciones particulares del entorno.

### Principio

**No debemos modificar un archivo de configuración sin comprender cuándo y por qué se carga.**

---

# 9. Bash Startup Files

Bash utiliza diferentes archivos según el tipo de sesión.

Entre los más importantes encontramos:

```text
/etc/profile
~/.bash_profile
~/.bash_login
~/.profile
~/.bashrc
~/.bash_logout
```

También pueden intervenir otros archivos según la distribución y la configuración.

## 9.1 `/etc/profile`

Es un archivo de configuración a nivel del sistema que Bash puede leer en sesiones Login.

## 9.2 `~/.bash_profile`

Es un archivo de configuración personal que Bash puede leer durante una sesión Login.

## 9.3 `~/.bash_login`

Es otra alternativa para la configuración personal de sesiones Login.

## 9.4 `~/.profile`

Es un archivo utilizado habitualmente para configuraciones personales de inicio de sesión.

No es exclusivo de Bash.

## 9.5 `~/.bashrc`

Se utiliza habitualmente para configurar sesiones interactivas de Bash que no son Login.

## 9.6 `~/.bash_logout`

Puede ejecutarse al finalizar determinadas sesiones Login de Bash.

### Importante

Estos archivos no son equivalentes.

---

# 10. Orden de carga en Bash

Vamos a construir un modelo mental.

## 10.1 Interactive Login Shell

En una invocación habitual de Bash como Login Shell, Bash lee:

```text
/etc/profile
```

Después busca el primero que exista y sea legible entre:

```text
~/.bash_profile
~/.bash_login
~/.profile
```

No ejecuta automáticamente los tres archivos personales.

### Modelo

```text
Bash Login Shell
       │
       ▼
 /etc/profile
       │
       ▼
First Available:
       │
       ├── ~/.bash_profile
       ├── ~/.bash_login
       └── ~/.profile
```

## 10.2 Interactive Non-login Shell

Normalmente lee:

```text
~/.bashrc
```

### Modelo

```text
Bash Interactive Non-login
           │
           ▼
        ~/.bashrc
```

## 10.3 Non-interactive Shell

En general, Bash no carga automáticamente `.bashrc` como lo hace en una sesión interactiva.

Existen mecanismos y casos especiales, como `BASH_ENV`, además de comportamientos específicos según la invocación.

## 10.4 ¿Un Login Shell carga `.bashrc`?

No necesariamente de manera directa.

Es frecuente que un archivo como `.bash_profile` incluya instrucciones para cargar `.bashrc`.

Pero eso depende de la configuración.

### Ejemplo conceptual

```bash
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
```

Este fragmento comprueba si el archivo existe y lo carga en la sesión actual.

No debemos añadirlo automáticamente sin revisar primero los archivos existentes.

### Idea clave

**Los archivos cargados dependen del modo de inicio y de las decisiones de configuración del sistema.**

---

# 11. ¿Qué significa `source`?

En Bash podemos utilizar:

```bash
source archivo
```

O:

```bash
. archivo
```

Ambas formas permiten ejecutar el contenido de un archivo dentro del contexto del Shell actual.

## 11.1 ¿Por qué importa?

Porque no es lo mismo ejecutar un Script como proceso separado que cargarlo en el Shell actual.

## 11.2 Ejemplo

Archivo conceptual:

```bash
PROJECT_NAME="Tooling Mastery"
```

Si lo ejecutamos mediante otro proceso de Bash, la variable no se incorpora automáticamente al Shell padre.

Pero si lo cargamos con `source`, la asignación ocurre en la sesión actual.

## 11.3 Modelo conceptual

```text
Execute Script
      │
      ▼
Child Shell
      │
      └── Changes Remain in Child
```

```text
Source File
      │
      ▼
Current Shell
      │
      └── Changes Affect Current Session
```

## 11.4 Advertencia

`source` ejecuta las instrucciones del archivo.

No debemos utilizarlo sobre archivos desconocidos o no confiables.

---

# 12. Zsh Startup Files

Zsh utiliza una estructura diferente de Bash.

Entre sus archivos habituales encontramos:

```text
~/.zshenv
~/.zprofile
~/.zshrc
~/.zlogin
~/.zlogout
```

## 12.1 `.zshenv`

Se utiliza para configuraciones que pueden aplicarse a múltiples tipos de invocación de Zsh.

Debemos mantenerlo ligero y evitar operaciones interactivas o costosas.

## 12.2 `.zprofile`

Se utiliza habitualmente para configuraciones de sesiones Login.

## 12.3 `.zshrc`

Se utiliza habitualmente para configuraciones interactivas.

## 12.4 `.zlogin`

Puede utilizarse para operaciones adicionales al iniciar una sesión Login.

## 12.5 `.zlogout`

Puede ejecutarse al finalizar determinadas sesiones Login.

## 12.6 Comparación conceptual

| Propósito | Bash | Zsh |
|---|---|---|
| Configuración interactiva habitual | `.bashrc` | `.zshrc` |
| Configuración personal Login | `.bash_profile` / `.profile` | `.zprofile` |
| Configuración general del Shell | Depende de invocación y archivos | `.zshenv` |
| Operaciones al cerrar determinadas sesiones Login | `.bash_logout` | `.zlogout` |

### Importante

La tabla no representa equivalencias exactas entre los mecanismos internos de ambos Shells.

---

# 13. Shell Variables vs Environment Variables

Estos conceptos están relacionados, pero debemos diferenciarlos.

## 13.1 Shell Variable

Es una variable mantenida dentro del contexto del Shell.

Ejemplo:

```bash
PROJECT_NAME="Tooling Mastery"
```

## 13.2 Environment Variable

Es una variable que forma parte del entorno exportado hacia procesos hijos.

En Bash:

```bash
export PROJECT_NAME="Tooling Mastery"
```

## 13.3 ¿Cuál es la diferencia?

Una variable normal del Shell no se transmite automáticamente a los procesos hijos.

Una variable exportada puede formar parte del entorno que reciben.

## 13.4 Modelo conceptual

```text
Parent Shell
│
├── LOCAL_VARIABLE
│
└── EXPORTED_VARIABLE
         │
         ▼
      Child Process
         │
         └── EXPORTED_VARIABLE
```

## 13.5 ¿Cómo consultamos una variable?

```bash
echo "$PROJECT_NAME"
```

## 13.6 ¿Cómo comprobamos si está exportada?

En Bash podemos utilizar:

```bash
export -p
```

Este comando muestra variables exportadas.

**Precaución:** la salida puede contener información sensible. No debemos compartirla públicamente sin revisarla.

---

# 14. Herencia de variables de entorno

Cuando un proceso crea otro proceso, normalmente puede proporcionarle un entorno basado en sus variables exportadas.

## 14.1 Ejemplo conceptual

```text
Terminal Emulator
        │
        ▼
      Bash
        │
        ├── PATH
        ├── HOME
        └── PROJECT_NAME
                │
                ▼
           Node.js Process
```

El proceso Node.js puede recibir las variables exportadas por su proceso padre.

## 14.2 ¿Los procesos hijos pueden modificar el entorno del padre?

Normalmente no.

Un proceso hijo puede modificar su propio entorno, pero esos cambios no se propagan automáticamente hacia su proceso padre.

## 14.3 ¿Por qué importa?

Porque ejecutar un Script que cambia PATH no garantiza que la Terminal desde la cual se lanzó adopte esos cambios.

### Principio

**La herencia del entorno sigue normalmente la relación padre → hijo, no hijo → padre.**

---

# 15. ¿Qué es PATH?

`PATH` es una variable de entorno utilizada por el Shell y otras herramientas para localizar ejecutables.

En Linux, normalmente contiene una lista de directorios separados por dos puntos.

## 15.1 Ejemplo

```text
/usr/local/bin:/usr/bin:/bin
```

## 15.2 Modelo conceptual

```text
Command: git
     │
     ▼
Shell Command Resolution
     │
     ├── Shell-specific Rules
     │
     └── PATH Search
              │
              ▼
       Git Executable
```

## 15.3 ¿PATH contiene ejecutables?

No directamente.

Contiene rutas a directorios donde pueden encontrarse ejecutables.

## 15.4 Consultar PATH

```bash
echo "$PATH"
```

## 15.5 Visualizar cada directorio

En Bash:

```bash
printf '%s\n' "${PATH//:/$'\n'}"
```

Este ejemplo utiliza características específicas de Bash.

No debemos asumir que funcionará en cualquier Shell.

### Idea clave

**PATH permite localizar herramientas sin escribir su ruta absoluta en cada ejecución.**

---

# 16. ¿Cómo resuelve Bash un comando?

Cuando escribimos:

```bash
git --version
```

Bash utiliza reglas de resolución de comandos.

No siempre comienza buscando directamente en PATH.

Pueden intervenir:

- Alias.
- Palabras reservadas.
- Funciones.
- Comandos internos.
- Ejecutables externos.

La resolución exacta depende del tipo de instrucción y de las reglas del Shell.

## 16.1 Consultar resolución

```bash
type git
```

## 16.2 Consultar todas las coincidencias conocidas

En Bash:

```bash
type -a git
```

## 16.3 Consultar ubicación

```bash
command -v git
```

## 16.4 ¿Qué debemos observar?

Podemos descubrir que un nombre corresponde a:

- Un alias.
- Una función.
- Un comando interno.
- Un ejecutable externo.

### Recomendación

Antes de concluir que una herramienta no está instalada, debemos investigar cómo se resuelve su comando.

---

# 17. Orden de PATH

El orden de los directorios puede afectar qué ejecutable se encuentra.

## 17.1 Ejemplo conceptual

```text
PATH
│
├── /home/developer/.local/bin
├── /usr/local/bin
└── /usr/bin
```

Imaginemos que existen dos ejecutables llamados `node`.

Uno está en:

```text
/home/developer/.local/bin/node
```

Otro está en:

```text
/usr/bin/node
```

El orden de búsqueda puede determinar cuál se utiliza.

## 17.2 ¿Por qué importa?

Porque podríamos tener instaladas varias versiones de una herramienta.

## 17.3 Diagnóstico

```bash
type -a node
```

Y:

```bash
command -v node
```

## 17.4 Problema habitual

Un gestor de versiones configura una ruta, pero otra instalación tiene prioridad.

### Principio

**La presencia de una herramienta en el sistema no garantiza que sea la versión que estamos ejecutando.**

---

# 18. Configuración temporal de PATH

Podemos modificar PATH solamente para la sesión actual.

Ejemplo:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

## 18.1 ¿Qué hace?

Añade un directorio al principio de PATH.

## 18.2 ¿Qué sucede al cerrar la sesión?

El cambio normalmente desaparece, salvo que otro mecanismo vuelva a establecerlo.

## 18.3 ¿Es siempre correcto anteponer directorios?

No.

El orden debe decidirse según qué herramientas queremos priorizar y qué nivel de confianza tenemos en las ubicaciones.

## 18.4 ¿Debemos ejecutar ese comando ahora?

No es necesario.

Primero debemos comprobar si el directorio existe y si realmente necesitamos modificar PATH.

### Recomendación

**Inspeccionar antes de cambiar.**

---

# 19. Configuración persistente de PATH

Para aplicar configuraciones en futuras sesiones podemos utilizar archivos de inicialización apropiados.

Pero debemos elegir el archivo correcto.

## 19.1 Ejemplo conceptual para Bash

En una configuración interactiva personal podríamos encontrar:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

## 19.2 ¿Dónde debería colocarse?

Depende de:

- Distribución.
- Shell.
- Tipo de sesión.
- Objetivo.
- Configuración existente.

No existe una respuesta universal.

## 19.3 ¿Por qué no debemos añadirlo siempre a `.bashrc`?

Porque `.bashrc` no se carga automáticamente en todas las invocaciones de Bash.

Por ejemplo, determinados procesos no interactivos pueden utilizar un entorno diferente.

## 19.4 ¿Y `.profile`?

Puede ser apropiado para determinadas configuraciones de inicio de sesión, pero debemos comprobar cómo se carga en nuestro entorno.

### Principio

**Una configuración persistente debe colocarse en el archivo correspondiente al alcance y ciclo de vida que necesitamos.**

---

# 20. Aliases

Un **Alias** permite definir una sustitución de comandos dentro del Shell.

## 20.1 Ejemplo

```bash
alias ll='ls -la'
```

Después podemos utilizar:

```bash
ll
```

## 20.2 ¿Qué ventaja ofrece?

Puede simplificar comandos frecuentes.

## 20.3 ¿Dónde se definen?

Habitualmente en archivos de configuración interactiva.

Por ejemplo, `.bashrc`.

## 20.4 ¿Debemos depender de Alias en Scripts?

Generalmente no.

Los Alias son más apropiados para comodidad interactiva.

Los Scripts profesionales deben utilizar comandos explícitos y mecanismos compatibles con su intérprete.

## 20.5 ¿Por qué?

Porque la expansión de Alias depende del Shell y de su configuración.

### Idea clave

**Un Alias es una comodidad personal, no una dependencia confiable para automatizaciones portables.**

---

# 21. Shell Functions

Una **Shell Function** permite agrupar instrucciones reutilizables dentro del Shell.

## 21.1 Ejemplo en Bash

```bash
croot() {
  cd "$HOME"
}
```

Después podemos ejecutar:

```bash
croot
```

## 21.2 ¿Qué diferencia existe con un Alias?

Un Alias realiza una sustitución textual conforme a las reglas del Shell.

Una función permite ejecutar una secuencia de instrucciones y trabajar con argumentos.

## 21.3 Ejemplo con argumentos

```bash
greet() {
  printf 'Hello, %s\n' "$1"
}
```

Uso:

```bash
greet "Developer"
```

Resultado:

```text
Hello, Developer
```

## 21.4 ¿Dónde utilizarlas?

Pueden ser útiles para personalizaciones interactivas o utilidades pequeñas.

Sin embargo, si una herramienta es importante para el equipo, deberíamos evaluar si corresponde convertirla en un Script versionado dentro del repositorio.

### Principio

**Las funciones personales mejoran la experiencia individual; las automatizaciones del proyecto deben poder compartirse y reproducirse.**

---

# 22. Configuración personal vs configuración de equipo

No todas las configuraciones deben compartirse.

## 22.1 Configuración personal

Ejemplos:

- Prompt.
- Tema.
- Alias personales.
- Preferencias de historial.
- Autocompletado.

## 22.2 Configuración del proyecto

Ejemplos:

- Versión requerida de Node.js.
- Scripts de desarrollo.
- Dependencias.
- Configuraciones de herramientas.
- Requisitos documentados.

## 22.3 Modelo conceptual

```text
Developer Environment
│
├── Personal Configuration
│   │
│   ├── Prompt
│   ├── Aliases
│   └── Shell Preferences
│
└── Project Configuration
    │
    ├── Runtime Requirements
    ├── Dependencies
    ├── Scripts
    └── Shared Standards
```

## 22.4 ¿Por qué importa?

Porque el proyecto no debería depender de que cada desarrollador tenga exactamente el mismo `.bashrc`.

### Principio

**La configuración personal puede variar; los requisitos esenciales del proyecto deben estar documentados y ser reproducibles.**

---

# 23. Shell Configuration y Runtime Managers

Los gestores de versiones suelen necesitar integración con el Shell.

Por ejemplo:

- nvm.
- mise.

## 23.1 ¿Por qué?

Porque deben facilitar la selección y resolución de versiones de herramientas.

## 23.2 Ejemplo conceptual

```text
Start Shell
    │
    ▼
Load Relevant Configuration
    │
    ▼
Initialize Runtime Manager
    │
    ▼
Select Tool Version
    │
    ▼
Resolve Runtime Command
```

## 23.3 ¿Qué puede fallar?

Una configuración puede cargarse en una Terminal interactiva, pero no en otro contexto.

Por ejemplo:

```text
Interactive Bash
    │
    ▼
Runtime Manager Available
```

Mientras tanto:

```text
Automation Script
    │
    ▼
Runtime Manager Not Initialized
```

## 23.4 ¿Qué debemos hacer?

Comprender cómo debe inicializarse cada herramienta según su documentación y el contexto de ejecución.

No debemos copiar configuraciones de un Shell a otro sin adaptarlas.

### Importante

Estudiaremos nvm y mise en profundidad en el módulo:

`04-runtime-management`

---

# 24. Shell Configuration y VS Code

VS Code puede utilizar una Terminal integrada.

Pero debemos distinguir entre:

- La aplicación VS Code.
- Su proceso.
- La Terminal integrada.
- El Shell iniciado.
- Las variables heredadas.

## 24.1 Modelo conceptual

```text
Desktop Environment
       │
       ▼
     VS Code
       │
       ▼
Integrated Terminal
       │
       ▼
      Bash
       │
       ▼
Development Commands
```

## 24.2 ¿Por qué pueden existir diferencias?

Porque VS Code puede iniciarse desde un contexto con variables diferentes a las de otra Terminal.

Además, la Terminal integrada puede utilizar un Shell o modo de inicio distinto.

## 24.3 Ejemplo de problema

En una Terminal externa:

```bash
node --version
```

Funciona.

En VS Code:

```bash
node --version
```

No funciona.

## 24.4 ¿Qué investigar?

1. ¿Qué Shell utiliza cada Terminal?
2. ¿Son sesiones Login o Non-login?
3. ¿Qué archivos de configuración se cargan?
4. ¿Qué PATH tiene cada sesión?
5. ¿Dónde se resuelve Node.js?
6. ¿Cómo se inició VS Code?

### Principio

**Antes de reinstalar una herramienta, debemos comparar los contextos donde funciona y donde falla.**

---

# 25. Shell Configuration y SSH

SSH permite acceder a sistemas remotos.

Pero una sesión SSH no necesariamente reproduce exactamente el entorno de nuestra Terminal local.

## 25.1 Modelo conceptual

```text
Local Machine
     │
     ▼
SSH Client
     │
     ▼
Remote Linux Machine
     │
     ▼
Remote Shell
```

## 25.2 ¿Qué cambia?

Podemos encontrar diferencias en:

- Usuario.
- Directorio personal.
- PATH.
- Shell.
- Archivos de configuración.
- Herramientas instaladas.
- Variables de entorno.

## 25.3 ¿Por qué importa?

Porque una herramienta instalada en nuestra computadora no tiene por qué estar instalada en el servidor remoto.

## 25.4 Buena práctica

Diagnosticar el entorno remoto como un sistema independiente.

---

# 26. Shell Configuration y CI/CD

Los sistemas de integración continua suelen ejecutar comandos en entornos automatizados.

Por ejemplo:

```text
CI Runner
    │
    ▼
Shell Process
    │
    ▼
Build Script
    │
    ▼
Project Tools
```

## 26.1 ¿Cuál es el problema?

Un Script podría depender accidentalmente de configuraciones personales.

Por ejemplo:

- Alias.
- Funciones.
- PATH personalizado.
- Variables no documentadas.

## 26.2 ¿Qué debería hacer un proyecto profesional?

Declarar explícitamente sus requisitos.

Por ejemplo:

- Versión de Runtime.
- Dependencias.
- Variables necesarias.
- Comandos de Build.
- Herramientas de validación.

## 26.3 ¿Por qué?

Porque un Pipeline no debería depender de la configuración personal del desarrollador que creó el proyecto.

### Principio

**La automatización debe ser reproducible y no depender de personalizaciones ocultas del Shell.**

---

# 27. Troubleshooting: Command Not Found

## 27.1 Síntoma

```text
command not found
```

## 27.2 Posibles causas

- Herramienta no instalada.
- PATH incorrecto.
- Shell diferente.
- Configuración no cargada.
- Gestor de versiones no inicializado.
- Nombre de comando incorrecto.

## 27.3 Diagnóstico

```bash
command -v node
```

```bash
type -a node
```

```bash
echo "$PATH"
```

## 27.4 Procedimiento

```text
Command Not Found
        │
        ▼
Check Command Resolution
        │
        ▼
Check PATH
        │
        ▼
Identify Shell
        │
        ▼
Identify Startup Configuration
        │
        ▼
Check Tool Installation
```

### Recomendación

No reinstalar inmediatamente.

---

# 28. Troubleshooting: PATH Duplicado

## 28.1 Síntoma

Encontramos varias veces el mismo directorio dentro de PATH.

## 28.2 Posible causa

Una configuración añade el mismo directorio repetidamente.

Por ejemplo, al cargar varias veces un archivo de inicialización.

## 28.3 ¿Es siempre un error crítico?

No.

Pero puede dificultar el mantenimiento y el diagnóstico.

## 28.4 ¿Cómo evitarlo?

Podemos comprobar si un directorio ya existe antes de añadirlo.

Ejemplo conceptual en Bash:

```bash
case ":$PATH:" in
  *":$HOME/.local/bin:"*)
    ;;
  *)
    PATH="$HOME/.local/bin:$PATH"
    ;;
esac

export PATH
```

Este ejemplo es ilustrativo.

Antes de aplicarlo debemos verificar que la ubicación y la prioridad deseadas sean correctas.

---

# 29. Troubleshooting: Configuración no aplicada

## 29.1 Síntoma

Modificamos `.bashrc`, abrimos otra sesión y el cambio no aparece.

## 29.2 Posibles causas

- La sesión no utiliza Bash.
- El Shell es Login y no carga `.bashrc` mediante su configuración actual.
- La sesión no es interactiva.
- Modificamos el archivo de otro usuario.
- Existe un error en el archivo.
- La aplicación utiliza un entorno diferente.

## 29.3 Diagnóstico

```bash
echo "$SHELL"
```

```bash
ps -p $$ -o comm=
```

En Bash:

```bash
shopt -q login_shell && echo "Login" || echo "Non-login"
```

Y:

```bash
case $- in
  *i*) echo "Interactive" ;;
  *)   echo "Non-interactive" ;;
esac
```

## 29.4 Recomendación

Identificar el tipo de sesión antes de modificar más archivos.

---

# 30. Troubleshooting: Un Script funciona manualmente, pero falla en CI

## 30.1 Síntoma

El Script funciona en nuestra Terminal, pero falla en un Pipeline.

## 30.2 Posibles causas

- Diferente Shell.
- Variables ausentes.
- Runtime no disponible.
- PATH diferente.
- Dependencias no instaladas.
- Directorio de trabajo incorrecto.
- Permisos diferentes.

## 30.3 Diagnóstico

Comparar:

```text
Local Environment
        │
        ├── Shell
        ├── Runtime
        ├── PATH
        ├── Variables
        └── Working Directory
```

Con:

```text
CI Environment
        │
        ├── Shell
        ├── Runtime
        ├── PATH
        ├── Variables
        └── Working Directory
```

## 30.4 Buena práctica

Hacer explícitos los requisitos del Script.

No depender de Alias ni configuraciones personales.

---

# 31. Práctica: Shell Environment Audit

Esta práctica es de inspección.

No modificaremos archivos de configuración.

## Step 1 — Identificar Shell configurado

```bash
echo "$SHELL"
```

## Step 2 — Identificar proceso del Shell

```bash
ps -p $$ -o comm=
```

## Step 3 — Consultar usuario

```bash
whoami
```

## Step 4 — Consultar directorio personal

```bash
echo "$HOME"
```

## Step 5 — Consultar directorio actual

```bash
pwd
```

## Step 6 — Consultar PATH

```bash
echo "$PATH"
```

## Step 7 — Consultar Git

```bash
command -v git
```

## Step 8 — Consultar Node.js

```bash
command -v node
```

## Step 9 — Consultar Bash

```bash
command -v bash
```

## Step 10 — Consultar Zsh

```bash
command -v zsh
```

## Step 11 — Consultar archivos de configuración

```bash
ls -la "$HOME"/.bashrc "$HOME"/.bash_profile "$HOME"/.profile 2>/dev/null
```

Que alguno no exista es completamente normal.

## Step 12 — Consultar archivos de Zsh

```bash
ls -la "$HOME"/.zshenv "$HOME"/.zprofile "$HOME"/.zshrc 2>/dev/null
```

## Step 13 — Identificar tipo de sesión Bash

Si estás utilizando Bash:

```bash
shopt -q login_shell && echo "Login" || echo "Non-login"
```

Y:

```bash
case $- in
  *i*) echo "Interactive" ;;
  *)   echo "Non-interactive" ;;
esac
```

## Step 14 — Consultar resolución de herramientas

En Bash:

```bash
type -a git
```

Si Node.js está disponible:

```bash
type -a node
```

## Step 15 — Documentar resultados

| Componente | Resultado |
|---|---|
| Usuario | |
| Shell configurado | |
| Proceso Shell observado | |
| Tipo de sesión | |
| HOME | |
| Directorio actual | |
| PATH | |
| Git disponible | |
| Node.js disponible | |
| `.bashrc` existe | |
| `.profile` existe | |
| `.zshrc` existe | |

---

# 32. Práctica: comprobar herencia de variables

Esta práctica no modifica archivos.

Utilizaremos Bash para demostrar la diferencia entre una variable local y una exportada.

## Step 1 — Crear variable local

```bash
MASTERY_TOPIC="Shell Configuration"
```

## Step 2 — Consultarla

```bash
echo "$MASTERY_TOPIC"
```

Resultado esperado:

```text
Shell Configuration
```

## Step 3 — Crear un proceso hijo

```bash
bash -c 'echo "${MASTERY_TOPIC:-Not available}"'
```

Resultado esperado si no estaba exportada previamente:

```text
Not available
```

## Step 4 — Exportar variable

```bash
export MASTERY_TOPIC
```

## Step 5 — Ejecutar otro proceso hijo

```bash
bash -c 'echo "${MASTERY_TOPIC:-Not available}"'
```

Resultado:

```text
Shell Configuration
```

## Step 6 — Interpretación

```text
Parent Bash
│
├── Local Variable
│   │
│   └── Not Automatically Inherited
│
└── Exported Variable
    │
    └── Available to Child Bash
```

### Aprendizaje

**Exportar una variable cambia su disponibilidad para los procesos hijos.**

---

# 33. Práctica: comparar sesiones

Abre dos Terminales.

## Terminal A

Ejecuta:

```bash
export MASTERY_SESSION="Terminal A"
```

Después:

```bash
echo "$MASTERY_SESSION"
```

## Terminal B

Ejecuta:

```bash
echo "${MASTERY_SESSION:-Not defined}"
```

Si ambas sesiones son independientes y la segunda no recibió previamente esa variable, mostrará:

```text
Not defined
```

## Reflexión

¿Por qué una variable definida en la Terminal A no aparece automáticamente en la Terminal B?

Porque las sesiones tienen contextos propios.

### Aprendizaje

**Modificar el entorno de una sesión no implica modificar todas las sesiones del sistema.**

---

# 34. Buenas prácticas profesionales

## 34.1 Comprender el Shell antes de configurarlo

No copiar configuraciones sin saber para qué Shell fueron escritas.

## 34.2 Separar configuración interactiva y automatización

No hacer que los Scripts dependan de Alias o preferencias personales.

## 34.3 Mantener Startup Files comprensibles

Evitar configuraciones innecesariamente complejas.

## 34.4 No duplicar PATH indiscriminadamente

Comprobar las rutas existentes antes de añadir otras.

## 34.5 Evitar secretos en archivos compartidos

No almacenar Tokens ni contraseñas en configuraciones versionadas públicamente.

## 34.6 Utilizar el archivo correcto

Elegir según Shell y tipo de sesión.

## 34.7 No asumir que todos los procesos cargan `.bashrc`

Cada contexto de ejecución puede ser diferente.

## 34.8 Documentar dependencias del proyecto

No depender de personalizaciones individuales.

## 34.9 Diagnosticar antes de reinstalar

Comparar Shell, PATH y variables antes de cambiar herramientas.

## 34.10 Mantener configuraciones reversibles

Antes de modificar archivos importantes, comprender el cambio y disponer de una forma segura de revertirlo.

---

# 35. Errores comunes

### 1. Confundir Terminal y Shell

Son componentes diferentes.

### 2. Pensar que Bash es el único Shell de Linux

Existen múltiples Shells.

### 3. Confundir Interactive y Login

Son propiedades independientes.

### 4. Pensar que `.bashrc` siempre se carga

Depende del tipo de sesión.

### 5. Pensar que `.bash_profile` y `.bashrc` son equivalentes

Cumplen responsabilidades diferentes.

### 6. Copiar configuraciones de Zsh directamente en Bash

No toda la sintaxis es compatible.

### 7. Confundir Shell Variables y Environment Variables

No tienen exactamente el mismo comportamiento respecto a procesos hijos.

### 8. Pensar que PATH contiene los ejecutables

Contiene directorios utilizados para localizarlos.

### 9. Ignorar el orden de PATH

Puede determinar qué versión de una herramienta se ejecuta.

### 10. Modificar PATH sin inspeccionarlo

Puede introducir conflictos.

### 11. Ejecutar Scripts que dependen de Alias personales

Dificulta la reproducibilidad.

### 12. Utilizar `source` sobre archivos desconocidos

Ejecuta instrucciones en el contexto actual.

### 13. Asumir que VS Code y una Terminal externa comparten exactamente el mismo entorno

Pueden diferir.

### 14. Asumir que SSH utiliza nuestra configuración local

El entorno remoto es independiente.

### 15. Depender de `.bashrc` en CI/CD

Los procesos automatizados pueden no cargarlo.

---

# 36. Comprueba tu modelo mental

1. ¿Qué es un Shell?
2. ¿Qué es una Terminal Emulator?
3. ¿Qué diferencia existe entre Terminal y Shell?
4. ¿Qué es Bash?
5. ¿Qué es Zsh?
6. ¿Qué es Fish?
7. ¿Qué es Dash?
8. ¿Qué es una Shell Session?
9. ¿Dos Terminales comparten automáticamente todas sus variables?
10. ¿Qué es un Interactive Shell?
11. ¿Qué es un Non-interactive Shell?
12. ¿Qué es un Login Shell?
13. ¿Qué es un Non-login Shell?
14. ¿Interactive y Login significan lo mismo?
15. ¿Qué son los Startup Files?
16. ¿Qué responsabilidad cumple `.bashrc`?
17. ¿Qué responsabilidad cumple `.bash_profile`?
18. ¿Qué es `.profile`?
19. ¿Bash carga siempre todos sus archivos personales?
20. ¿Qué significa `source`?
21. ¿Qué diferencia existe entre ejecutar un Script y cargarlo con `source`?
22. ¿Qué es una Shell Variable?
23. ¿Qué es una Environment Variable?
24. ¿Qué hace `export`?
25. ¿Cómo se heredan las variables?
26. ¿Un proceso hijo puede modificar automáticamente el entorno del padre?
27. ¿Qué es PATH?
28. ¿Qué contiene PATH?
29. ¿Por qué importa el orden de PATH?
30. ¿Qué hace `command -v`?
31. ¿Qué hace `type -a` en Bash?
32. ¿Qué es un Alias?
33. ¿Qué es una Shell Function?
34. ¿Por qué los Scripts no deberían depender de Alias personales?
35. ¿Por qué Node.js puede funcionar en una Terminal y fallar en otra?
36. ¿Qué relación existe entre Shell Configuration y nvm?
37. ¿Por qué VS Code puede tener un PATH diferente?
38. ¿Qué cambia al conectarnos mediante SSH?
39. ¿Por qué CI/CD necesita configuraciones explícitas?
40. ¿Qué revisarías antes de modificar `.bashrc`?

---

# 37. Checklist de aprendizaje

- [ ] Comprendo qué es un Shell.
- [ ] Diferencio Terminal y Shell.
- [ ] Reconozco Bash, Zsh, Fish y Dash.
- [ ] Comprendo qué es una Shell Session.
- [ ] Diferencio Interactive y Non-interactive.
- [ ] Diferencio Login y Non-login.
- [ ] Comprendo qué son los Startup Files.
- [ ] Reconozco la responsabilidad de `.bashrc`.
- [ ] Reconozco la responsabilidad de `.bash_profile`.
- [ ] Comprendo qué hace `source`.
- [ ] Diferencio Shell Variables y Environment Variables.
- [ ] Comprendo qué hace `export`.
- [ ] Comprendo la herencia de variables.
- [ ] Comprendo PATH.
- [ ] Puedo consultar cómo se resuelve un comando.
- [ ] Comprendo por qué importa el orden de PATH.
- [ ] Diferencio Alias y Shell Functions.
- [ ] Comprendo los riesgos de configuraciones personales ocultas.
- [ ] Puedo diagnosticar diferencias entre Terminales.
- [ ] Evito modificar archivos de configuración sin comprender su función.

---

# 💡 Idea clave

El Shell no es solamente una herramienta para escribir comandos.

Es un entorno de ejecución que administra variables, interpreta instrucciones y prepara el contexto de los procesos.

```text
Start Shell
    │
    ▼
Determine Shell Mode
    │
    ▼
Load Applicable Configuration
    │
    ▼
Initialize Variables and PATH
    │
    ▼
Resolve Commands
    │
    ▼
Execute Programs
```

Comprender este ciclo permite diagnosticar muchos problemas habituales del desarrollo profesional.

**Antes de reinstalar una herramienta que no funciona, debemos comprobar qué Shell estamos utilizando, qué configuración se cargó y cómo se está resolviendo su ejecutable.**

---

# 🚀 Siguiente paso

Ahora comprendemos:

- Qué es un Shell.
- Cómo funcionan sus sesiones.
- Qué archivos de inicialización utiliza.
- Cómo se heredan las variables.
- Cómo funciona PATH.
- Por qué diferentes contextos pueden producir resultados diferentes.

El siguiente documento cerrará nuestra sección de Linux mediante un enfoque práctico de diagnóstico.

Estudiaremos:

- Problemas de permisos.
- Errores de PATH.
- Conflictos de herramientas.
- Problemas de paquetes.
- Diferencias entre distribuciones.
- Problemas de Shell.
- Fallos de red y DNS.
- Problemas de procesos y puertos.
- Diagnóstico de entornos Linux en desarrollo profesional.

👉 [Common Linux Issues](./04-common-linux-issues.md)