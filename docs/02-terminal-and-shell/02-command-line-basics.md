# Command Line Basics

> **Developer Tooling Mastery 2026 — Module 02**
>
> **Topic 02:** Command Line Basics  
> **Level:** Beginner → Professional Foundations  
> **Prerequisites:** [01 — Terminal vs Shell](./01-terminal-vs-shell.md)

---

## 1. Introducción

En el documento anterior aprendimos que un **Terminal** proporciona la interfaz donde escribimos comandos y que un **Shell** interpreta nuestras instrucciones.

Ahora necesitamos responder una nueva pregunta:

**¿Cómo se construye y ejecuta correctamente un comando?**

Observemos estos ejemplos:

```bash
git status
```

```bash
git log --oneline -5
```

```bash
node --version
```

```bash
npm run dev
```

Aunque todos son comandos, contienen elementos diferentes:

- Nombre del programa.
- Subcommands.
- Arguments.
- Options.
- Flags.

Además, un Shell puede interpretar caracteres especiales, expandir variables o procesar comillas antes de ejecutar un programa.

Por eso no basta con saber escribir comandos.

Necesitamos comprender **cómo se interpretan, qué información reciben y cómo identificar sus resultados**.

En este documento construiremos esa base.

---

## 2. Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Comprender qué es un Command.
2. Identificar los componentes de un comando.
3. Diferenciar Command, Program y Executable.
4. Comprender qué son los Arguments.
5. Diferenciar Arguments, Options y Flags.
6. Comprender qué es un Subcommand.
7. Identificar Short Options y Long Options.
8. Comprender cómo el Shell interpreta una línea de comandos.
9. Reconocer la importancia de espacios y comillas.
10. Diferenciar comandos internos y externos.
11. Descubrir qué comando se ejecutará.
12. Consultar documentación mediante `--help`, `help`, `man` y `Get-Help`.
13. Utilizar Command History.
14. Comprender Autocompletion.
15. Interpretar Standard Output y Standard Error de forma introductoria.
16. Comprender qué es un Exit Code.
17. Identificar operaciones de lectura y modificación.
18. Ejecutar comandos de forma consciente y segura.

---

# 3. ¿Qué es un Command?

Un **Command** es una instrucción que proporcionamos a un Shell o a una interfaz de línea de comandos para solicitar una operación.

Por ejemplo:

```bash
git status
```

Esta instrucción solicita a Git que muestre información sobre el estado del repositorio actual.

Otro ejemplo:

```bash
node --version
```

Solicita a Node.js que muestre su versión.

Sin embargo, debemos comprender algo importante:

**Un comando no es necesariamente un programa independiente.**

Puede representar:

- Un comando interno del Shell.
- Una función.
- Un Alias.
- Un programa externo.
- Una instrucción que utiliza un Subcommand.

### Modelo mental

```text
Developer
    │
    ▼
Command
    │
    ▼
Shell Interpretation
    │
    ▼
Command Resolution
    │
    ├── Built-in
    ├── Function
    ├── Alias Expansion
    └── External Program
```

La resolución exacta depende del Shell utilizado.

---

# 4. Anatomía de un comando

Analicemos:

```bash
git log --oneline -5
```

Podemos representarlo así:

```text
git log --oneline -5
 │   │      │     │
 │   │      │     └── Option with a value encoded in short form
 │   │      │
 │   │      └──────── Long Option
 │   │
 │   └─────────────── Subcommand
 │
 └─────────────────── Program
```

En este ejemplo:

| Elemento | Valor | Responsabilidad |
|---|---|---|
| Program | `git` | Herramienta que ejecutamos |
| Subcommand | `log` | Operación solicitada |
| Long Option | `--oneline` | Solicita una presentación resumida |
| Option | `-5` | Limita la cantidad de entradas mostradas a cinco |

No todos los programas utilizan la misma estructura.

Por ejemplo:

```bash
node --version
```

No tiene un Subcommand.

Y:

```bash
cd ..
```

Utiliza un comando interno del Shell y un argumento que representa una ruta.

### Idea clave

**La estructura de un comando depende de la interfaz definida por la herramienta que estamos utilizando.**

---

# 5. Program vs Command vs Executable

Estos términos están relacionados, pero no significan exactamente lo mismo.

## 5.1 Program

Un **Program** es software que contiene instrucciones para realizar operaciones.

Ejemplos:

- Git.
- Node.js.
- Python.
- Un navegador.
- Una aplicación de escritorio.

## 5.2 Executable

Un **Executable** es un archivo o componente que puede iniciarse como programa en un entorno compatible.

Por ejemplo, una instalación de Node.js proporciona un ejecutable que podemos invocar mediante:

```bash
node
```

## 5.3 Command

Un **Command** es la instrucción que solicitamos ejecutar.

```bash
node --version
```

## 5.4 Comparación

| Concepto | Ejemplo |
|---|---|
| Program | Node.js |
| Executable | Ejecutable `node` |
| Command | `node --version` |
| Argument/Option | `--version` |

### Modelo

```text
Command
   │
   ▼
Shell
   │
   ▼
Executable
   │
   ▼
Running Process
```

Este flujo corresponde al caso habitual de ejecutar un programa externo.

---

# 6. ¿Qué son los Arguments?

Un **Argument** es un valor que proporcionamos a un comando para indicarle sobre qué información u objeto debe trabajar, o para modificar su comportamiento.

Ejemplo:

```bash
cd ..
```

Aquí:

```text
..
```

Es el argumento que indica el directorio padre.

Otro ejemplo:

```bash
git show HEAD
```

Aquí `HEAD` es un argumento que identifica una referencia de Git.

## 6.1 Positional Arguments

Los **Positional Arguments** son argumentos cuyo significado depende de su posición.

Ejemplo conceptual:

```text
program input.txt output.txt
```

Una herramienta podría interpretar:

- Primer argumento: archivo de entrada.
- Segundo argumento: archivo de salida.

Pero eso depende de cómo esté diseñada.

## 6.2 ¿Importa el orden?

Sí, especialmente cuando existen argumentos posicionales.

No debemos asumir que podemos intercambiar libremente todos los argumentos.

## 6.3 ¿Quién define los argumentos?

La herramienta o comando que estamos ejecutando.

El Shell procesa la línea y transmite los argumentos correspondientes, pero normalmente no decide qué significa cada argumento para el programa.

### Idea clave

**Los Arguments proporcionan información a una operación; su significado depende de la interfaz del comando.**

---

# 7. ¿Qué son las Options?

Una **Option** modifica o configura el comportamiento de un comando.

Ejemplo:

```bash
git log --oneline
```

La opción:

```text
--oneline
```

Solicita una presentación resumida del historial.

Otro ejemplo:

```bash
git log --max-count=5
```

La opción `--max-count` recibe el valor `5`.

## 7.1 Short Options

Son opciones que suelen utilizar un guion y una letra.

Ejemplo:

```bash
git log -p
```

## 7.2 Long Options

Suelen utilizar dos guiones y un nombre descriptivo.

Ejemplo:

```bash
git log --oneline
```

## 7.3 Options with Values

Algunas opciones requieren valores.

Ejemplo:

```bash
git log --max-count=5
```

Otras herramientas pueden aceptar sintaxis como:

```text
program --output result.txt
```

La forma exacta depende del programa.

## 7.4 ¿Todas las herramientas utilizan guiones?

No.

Muchas herramientas siguen convenciones similares, pero no existe una sintaxis universal para todas las CLIs.

Por ejemplo, PowerShell utiliza habitualmente parámetros como:

```powershell
Get-ChildItem -Path .
```

### Idea clave

**Las Options permiten controlar cómo se ejecuta una operación.**

---

# 8. ¿Qué es un Flag?

En el uso habitual de las CLIs, un **Flag** es una opción que activa o desactiva un comportamiento.

Por ejemplo:

```bash
git status --short
```

Aquí `--short` solicita una salida abreviada.

No necesita que indiquemos un valor adicional.

Sin embargo, la terminología no es completamente uniforme.

Algunas herramientas utilizan *flag* como sinónimo general de *option*.

### Comparación

| Elemento | Ejemplo | Significado |
|---|---|---|
| Argument | `HEAD` | Valor sobre el que actúa una operación |
| Option | `--max-count=5` | Configuración con valor |
| Flag | `--short` | Activa una modalidad |

### Importante

No debemos asumir que todas las opciones son booleanas.

---

# 9. ¿Qué es un Subcommand?

Un **Subcommand** representa una operación específica dentro de una herramienta.

Git es un ejemplo excelente.

```bash
git status
```

```bash
git log
```

```bash
git branch
```

Todos utilizan el programa `git`, pero solicitan operaciones diferentes.

### Modelo

```text
git
│
├── status
├── log
├── branch
├── diff
└── show
```

## 9.1 ¿Por qué existen?

Porque permiten organizar una herramienta que ofrece múltiples funcionalidades.

En lugar de crear un ejecutable independiente para cada operación, una CLI puede proporcionar diferentes Subcommands.

## 9.2 Ejemplo conceptual

```text
tool
│
├── create
├── build
├── test
└── deploy
```

Esta estructura es conceptual y no corresponde necesariamente a una herramienta concreta.

## 9.3 ¿Todos los programas tienen Subcommands?

No.

Algunas herramientas ejecutan una operación principal y reciben argumentos u opciones.

### Idea clave

**Los Subcommands permiten organizar diferentes operaciones bajo una misma CLI.**

---

# 10. ¿Cómo interpreta el Shell una línea de comandos?

Cuando escribimos:

```bash
git log --oneline
```

El Shell no envía necesariamente el texto completo al programa como una única cadena.

Primero interpreta la línea según sus reglas.

En Bash y Zsh, entre otras operaciones, puede realizar:

- Análisis sintáctico.
- Expansiones.
- Tratamiento de comillas.
- Resolución de redirecciones.
- Identificación del comando.
- Preparación de argumentos.

El comportamiento exacto depende del Shell.

## 10.1 Modelo simplificado

```text
Input
  │
  ▼
Shell Parsing
  │
  ▼
Expansions and Quoting
  │
  ▼
Command Resolution
  │
  ▼
Execution
  │
  ▼
Result
```

Este modelo no representa todas las etapas internas ni su orden exacto.

## 10.2 ¿Por qué importa?

Porque caracteres como estos pueden tener significados especiales:

```text
"  '  $  *  ?  |  >  <  &
```

Por ejemplo, un espacio puede separar argumentos.

Y una comilla puede permitir que varios caracteres se interpreten como parte de un mismo argumento.

### Idea clave

**El Shell no trata siempre nuestra entrada como texto literal: interpreta una sintaxis.**

---

# 11. Espacios y Quoting

Uno de los errores más habituales al comenzar a utilizar la terminal aparece cuando trabajamos con rutas que contienen espacios.

Consideremos esta ruta:

```text
My Projects
```

En Bash o Zsh, escribir:

```bash
cd My Projects
```

normalmente proporciona dos argumentos:

```text
My
Projects
```

Pero `cd` espera una ruta.

## 11.1 Solución mediante comillas

```bash
cd "My Projects"
```

Ahora la ruta se interpreta como un solo argumento.

## 11.2 Solución mediante Escape

En Bash o Zsh:

```bash
cd My\ Projects
```

La barra invertida evita que el espacio se interprete como separador.

## 11.3 Single Quotes vs Double Quotes

En Bash y Zsh:

```bash
echo '$HOME'
```

Produce literalmente:

```text
$HOME
```

Mientras que:

```bash
echo "$HOME"
```

expande la variable `HOME`.

## 11.4 ¿PowerShell funciona igual?

No exactamente.

PowerShell tiene sus propias reglas de Quoting, Expansions y Escape Characters.

Por ejemplo:

```powershell
Write-Output '$HOME'
```

Muestra el texto literal.

Mientras que:

```powershell
Write-Output "$HOME"
```

intenta expandir una variable de PowerShell llamada `$HOME`.

### Idea clave

**Quoting permite controlar cómo el Shell interpreta espacios, variables y caracteres especiales.**

Profundizaremos en rutas en:

[04 — Absolute vs Relative Paths](./04-absolute-vs-relative-paths.md)

---

# 12. Built-in Commands vs External Commands

Como vimos en el documento anterior, no todos los comandos se ejecutan de la misma manera.

## 12.1 Built-in Commands

Son operaciones implementadas por el propio Shell.

Ejemplo habitual en Bash y Zsh:

```bash
cd ..
```

El Shell modifica su directorio de trabajo actual.

## 12.2 External Commands

Son programas externos que el Shell puede ejecutar.

Ejemplo:

```bash
git --version
```

## 12.3 ¿Por qué importa?

Porque afecta a:

- Cómo se resuelve el comando.
- Dónde está implementado.
- Qué documentación debemos consultar.
- Cómo se ejecuta.
- Qué estado puede modificar.

## 12.4 Ejemplo con Bash/Zsh

```bash
type cd
```

```bash
type git
```

El primero normalmente identifica un Built-in.

El segundo, si Git está instalado, normalmente identifica un ejecutable externo.

## 12.5 Ejemplo con PowerShell

```powershell
Get-Command Set-Location
```

```powershell
Get-Command git
```

PowerShell identifica diferentes tipos de comandos, incluidos Cmdlets y aplicaciones externas.

### Idea clave

**Comprender qué tipo de comando estamos utilizando facilita su diagnóstico y documentación.**

---

# 13. Command Resolution

Cuando escribimos un nombre de comando, el Shell necesita determinar qué debe ejecutar.

Ejemplo:

```bash
node --version
```

La resolución puede depender de:

- Alias.
- Funciones.
- Comandos internos.
- Ejecutables disponibles.
- `PATH`.
- Reglas específicas del Shell.

## 13.1 Ejemplo conceptual

```text
Command: node
      │
      ▼
Shell Resolution
      │
      ▼
External Executable
      │
      ▼
Node.js
```

## 13.2 ¿Qué sucede si no encuentra el comando?

Podríamos recibir:

```text
command not found
```

O un mensaje equivalente.

Esto no demuestra automáticamente que el programa no esté instalado.

También podría indicar que su ubicación no está disponible en el entorno de búsqueda.

## 13.3 Bash/Zsh

Podemos consultar:

```bash
command -v node
```

Si Node.js está disponible, normalmente mostrará cómo se resuelve el comando.

También podemos utilizar:

```bash
type -a node
```

En Bash y Zsh, esta operación permite inspeccionar posibles resoluciones del nombre.

## 13.4 PowerShell

```powershell
Get-Command node -All
```

Si está disponible, mostrará las coincidencias correspondientes.

### Importante

Estos comandos son de consulta.

No instalan Node.js ni modifican su configuración.

### Idea clave

**Antes de solucionar un problema de ejecución, necesitamos identificar qué comando está resolviendo nuestro entorno.**

Estudiaremos `PATH` en profundidad en el documento 06.

---

# 14. ¿Cómo descubrir qué hace un comando?

Una habilidad profesional importante es aprender a consultar documentación.

No necesitamos memorizar cientos de comandos.

Necesitamos saber descubrir:

- Qué hace una herramienta.
- Qué argumentos acepta.
- Qué opciones ofrece.
- Qué efectos puede producir.
- Qué ejemplos proporciona.

## 14.1 `--help`

Muchas herramientas ofrecen:

```bash
git --help
```

O:

```bash
node --help
```

Pero no todas las herramientas implementan esta opción de la misma manera.

Algunas pueden abrir documentación adicional o utilizar otros mecanismos.

## 14.2 `-h`

Algunas herramientas aceptan:

```text
program -h
```

Pero no es universal.

## 14.3 Built-in Help

Bash dispone de ayuda para comandos internos.

Ejemplo:

```bash
help cd
```

## 14.4 Manual Pages

En sistemas Unix-like podemos encontrar:

```bash
man ls
```

Este comando abre una página de manual, si está disponible.

### ¿Qué suele contener?

- Name.
- Synopsis.
- Description.
- Options.
- Examples, según la herramienta.
- Related Commands.

## 14.5 PowerShell Help

PowerShell dispone de:

```powershell
Get-Help Get-ChildItem
```

También podemos solicitar ejemplos:

```powershell
Get-Help Get-ChildItem -Examples
```

Y consultar la sintaxis:

```powershell
Get-Command Get-ChildItem -Syntax
```

### Precaución

La documentación completa de PowerShell puede no estar instalada localmente.

Actualizarla puede requerir descargas y permisos adicionales.

No necesitamos hacerlo todavía.

---

# 15. ¿Qué es una Synopsis?

En la documentación de comandos podemos encontrar una sección llamada **Synopsis**.

Describe de forma resumida la sintaxis esperada.

Ejemplo conceptual:

```text
tool [OPTIONS] <INPUT>
```

Aquí:

- `tool`: nombre de la herramienta.
- `[OPTIONS]`: opciones que podrían ser opcionales.
- `<INPUT>`: valor requerido según esta convención ilustrativa.

## 15.1 Convenciones frecuentes

| Notación | Significado habitual |
|---|---|
| `[value]` | Elemento opcional |
| `<value>` | Valor que debe proporcionarse |
| `...` | Repetición o elementos adicionales |
| `A \| B` | Alternativas en documentación |

Estas convenciones dependen del formato de ayuda utilizado.

## 15.2 No copiar literalmente los placeholders

Si una documentación muestra:

```text
tool --file <filename>
```

Debemos sustituir `<filename>` por un valor real.

Por ejemplo:

```text
tool --file report.txt
```

Este es un ejemplo conceptual.

### Idea clave

**La Synopsis describe cómo construir un comando; no siempre representa texto que debamos copiar literalmente.**

---

# 16. Command History

Los Shells interactivos suelen mantener un historial de comandos.

Esto permite recuperar instrucciones utilizadas anteriormente.

## 16.1 ¿Para qué sirve?

- Repetir comandos.
- Recuperar instrucciones largas.
- Corregir errores.
- Consultar operaciones recientes.
- Aumentar la productividad.

## 16.2 Flechas del teclado

En muchos Shells interactivos:

- Flecha arriba: recuperar comandos anteriores.
- Flecha abajo: avanzar por el historial.

## 16.3 Bash/Zsh

Podemos consultar el historial disponible mediante:

```bash
history
```

El comportamiento exacto depende de la configuración del Shell.

## 16.4 PowerShell

```powershell
Get-History
```

Este comando consulta el historial de la sesión de PowerShell.

El historial persistente puede gestionarse mediante otros componentes, como PSReadLine.

## 16.5 Riesgo importante

No debemos escribir secretos directamente en comandos si existe una alternativa segura.

Por ejemplo, una contraseña introducida como argumento podría quedar expuesta en:

- Historial.
- Registros.
- Listados de procesos, según el sistema.
- Capturas de pantalla.
- Herramientas de observabilidad.

### Buena práctica

**El historial es una herramienta de productividad, pero también puede conservar información sensible.**

---

# 17. Autocompletion

**Autocompletion** permite completar comandos, rutas y otros valores de forma interactiva.

En muchos entornos utilizamos la tecla:

```text
Tab
```

## 17.1 Ejemplo conceptual

Imagina que tenemos:

```text
projects/
├── frontend-app/
└── backend-api/
```

Comenzamos a escribir:

```bash
cd front
```

Dependiendo del Shell y de su configuración, podemos utilizar Tab para completar el nombre del directorio.

## 17.2 Beneficios

- Reduce errores de escritura.
- Facilita la navegación.
- Acelera operaciones frecuentes.
- Ayuda a descubrir opciones disponibles.

## 17.3 ¿Todos los Shells completan igual?

No.

Bash, Zsh y PowerShell tienen sistemas de completado con diferencias importantes.

También puede variar según las herramientas instaladas y su configuración.

### Idea clave

**Autocompletion es una ayuda interactiva, no un sustituto de comprender el comando que estamos ejecutando.**

---

# 18. Standard Output y Standard Error

Cuando ejecutamos un comando, podemos recibir información como resultado.

Dos conceptos fundamentales son:

- Standard Output (`stdout`).
- Standard Error (`stderr`).

## 18.1 Standard Output

Es el flujo utilizado habitualmente para producir la salida normal de un programa.

Ejemplo:

```bash
git --version
```

Si Git está instalado, normalmente veremos información sobre su versión.

## 18.2 Standard Error

Es un flujo utilizado habitualmente para comunicar errores o diagnósticos.

Por ejemplo, un programa puede informar que recibió un argumento inválido.

## 18.3 ¿Se muestran ambos en el Terminal?

Habitualmente sí, cuando están conectados a la sesión.

Pero representan canales diferentes.

## 18.4 Modelo

```text
Program
   │
   ├── Standard Output
   │         │
   │         ▼
   │      Normal Output
   │
   └── Standard Error
             │
             ▼
         Diagnostics
```

## 18.5 ¿Por qué importa?

Porque posteriormente podremos:

- Redirigir resultados.
- Guardar salidas.
- Separar errores.
- Conectar comandos mediante Pipes.

### Importante

No debemos asumir que todo mensaje de error aparece necesariamente en `stderr`.

Cada programa decide cómo utiliza sus flujos.

Profundizaremos en estos conceptos en:

[10 — Command Chaining and Pipes](./10-command-chaining-and-pipes.md)

---

# 19. Exit Codes

Cuando un comando termina, normalmente comunica un **Exit Status**.

Este valor permite conocer cómo finalizó la operación.

## 19.1 Convención habitual

En muchos programas:

```text
0 → Success
```

Y:

```text
Non-zero → Failure or Special Status
```

El significado exacto depende del programa.

## 19.2 Ejemplo

Ejecutamos:

```bash
git --version
```

Si se ejecuta correctamente, normalmente termina con estado `0`.

## 19.3 Bash/Zsh

Podemos consultar el estado del último comando mediante:

```bash
echo $?
```

Debe ejecutarse inmediatamente después del comando que queremos comprobar.

Si ejecutamos otro comando antes, el valor puede cambiar.

## 19.4 PowerShell

PowerShell dispone de diferentes mecanismos para conocer el resultado de una operación.

Por ejemplo:

```powershell
$LASTEXITCODE
```

Representa el código de salida del último programa nativo relevante.

También existe:

```powershell
$?
```

Que representa el estado de éxito de la operación anterior según las reglas de PowerShell.

**No son equivalentes en todos los casos.**

## 19.5 ¿Por qué importa?

Porque las herramientas de automatización necesitan identificar si una operación terminó correctamente.

Ejemplo conceptual:

```text
Run Command
     │
     ▼
Exit Status
     │
     ├── Success
     │
     └── Failure
```

Este mecanismo será especialmente importante en CI/CD.

---

# 20. Read-only Commands vs Mutating Commands

No todos los comandos tienen el mismo impacto.

Antes de ejecutar una instrucción debemos comprender si consulta o modifica información.

## 20.1 Read-only Commands

Son operaciones diseñadas para consultar información.

Ejemplos:

```bash
git status
```

```bash
git --version
```

```bash
pwd
```

En un uso habitual, estas operaciones no modifican intencionalmente archivos del proyecto.

Sin embargo, algunas herramientas pueden realizar operaciones internas de mantenimiento, registro o caché.

## 20.2 Mutating Commands

Son operaciones que modifican información o estado.

Ejemplos conceptuales:

- Crear archivos.
- Renombrar directorios.
- Instalar software.
- Cambiar permisos.
- Detener procesos.
- Eliminar archivos.

## 20.3 Operaciones potencialmente destructivas

Debemos prestar especial atención a operaciones como:

```bash
rm
```

O:

```powershell
Remove-Item
```

Estas herramientas pueden eliminar recursos.

No las utilizaremos indiscriminadamente.

## 20.4 Regla profesional

Antes de ejecutar un comando, debemos preguntarnos:

1. ¿Qué hace?
2. ¿Qué argumentos recibe?
3. ¿Sobre qué recursos actúa?
4. ¿Modifica información?
5. ¿Puede eliminar datos?
6. ¿Necesita permisos elevados?
7. ¿Cómo verificaré el resultado?

### Idea clave

**Comprender el impacto de un comando es parte de utilizar la terminal profesionalmente.**

---

# 21. Ejemplos prácticos de comandos

Veamos algunos ejemplos sencillos.

## 21.1 Consultar versión de Git

```bash
git --version
```

| Elemento | Valor |
|---|---|
| Program | `git` |
| Option | `--version` |
| Resultado | Información sobre la versión |

## 21.2 Consultar versión de Node.js

```bash
node --version
```

| Elemento | Valor |
|---|---|
| Program | `node` |
| Option | `--version` |
| Resultado | Información sobre la versión |

Si Node.js no está instalado, el comando puede fallar.

Eso no impide comprender su estructura.

## 21.3 Consultar estado de Git

```bash
git status
```

| Elemento | Valor |
|---|---|
| Program | `git` |
| Subcommand | `status` |
| Resultado | Estado del repositorio |

Fuera de un repositorio Git, el comando puede devolver un error.

## 21.4 Consultar historial de Git

```bash
git log --oneline -5
```

| Elemento | Valor |
|---|---|
| Program | `git` |
| Subcommand | `log` |
| Option | `--oneline` |
| Option | `-5` |

## 21.5 Consultar directorio actual

Bash/Zsh:

```bash
pwd
```

PowerShell:

```powershell
Get-Location
```

Ambos permiten consultar la ubicación actual, aunque sus implementaciones y resultados pueden diferir.

---

# 22. Práctica 01 — Descomponer comandos

Analiza los siguientes comandos.

### Ejercicio A

```bash
git status
```

Identifica:

- Program.
- Subcommand.
- Arguments.
- Options.

### Ejercicio B

```bash
git log --oneline -3
```

Identifica:

- Program.
- Subcommand.
- Options.

### Ejercicio C

```bash
node --version
```

Identifica:

- Program.
- Option.

### Ejercicio D

```powershell
Get-ChildItem -Path .
```

Identifica:

- Command.
- Parameter.
- Argument Value.

## Respuestas

| Ejercicio | Programa/comando | Operación | Opciones/parámetros |
|---|---|---|---|
| A | `git` | `status` | Ninguna |
| B | `git` | `log` | `--oneline`, `-3` |
| C | `node` | Consultar versión | `--version` |
| D | `Get-ChildItem` | Listar elementos | `-Path .` |

### Aprendizaje

**Leer correctamente un comando es el primer paso para comprender su comportamiento.**

---

# 23. Práctica 02 — Descubrir comandos

Esta práctica utiliza operaciones de consulta.

## Bash/Zsh

Ejecuta:

```bash
type cd
```

Después:

```bash
type pwd
```

Y, si Git está instalado:

```bash
type git
```

### Preguntas

1. ¿Qué tipo de comando es `cd`?
2. ¿Qué tipo de comando es `pwd` en tu Shell?
3. ¿Qué tipo de comando es `git`?
4. ¿Qué diferencias encuentras?

## PowerShell

Ejecuta:

```powershell
Get-Command Set-Location
```

```powershell
Get-Command Get-Location
```

Y, si Git está instalado:

```powershell
Get-Command git
```

### Aprendizaje

No todos los comandos se resuelven como ejecutables externos.

---

# 24. Práctica 03 — Consultar documentación

## Bash

Consulta:

```bash
help cd
```

Si Git está disponible:

```bash
git status -h
```

También puedes utilizar:

```bash
git --version
```

## macOS/Linux

Si está disponible:

```bash
man ls
```

Dentro del visor habitual de `man`, puedes presionar `q` para salir.

## PowerShell

Consulta:

```powershell
Get-Help Get-Location
```

Después:

```powershell
Get-Command Get-Location -Syntax
```

### Preguntas

1. ¿Dónde aparece la descripción?
2. ¿Qué opciones acepta?
3. ¿Qué argumentos necesita?
4. ¿Qué ejemplos proporciona?
5. ¿La documentación indica efectos secundarios?

### Aprendizaje

**Antes de buscar una solución externa, aprende a consultar la documentación oficial de la herramienta.**

---

# 25. Práctica 04 — Consultar Exit Codes

## Bash/Zsh

Ejecuta:

```bash
git --version
```

Si Git está disponible, consulta inmediatamente:

```bash
echo $?
```

Deberías obtener normalmente:

```text
0
```

## PowerShell

Ejecuta:

```powershell
git --version
```

Después consulta:

```powershell
$LASTEXITCODE
```

Si Git terminó correctamente, normalmente será `0`.

### Preguntas

1. ¿Qué representa el valor?
2. ¿Significa siempre lo mismo un código distinto de cero?
3. ¿Por qué las herramientas de CI necesitan Exit Codes?

### Aprendizaje

Los Exit Codes permiten comunicar el resultado de una operación de manera estructurada.

---

# 26. Práctica 05 — Quoting

Esta práctica no modifica archivos.

## Bash/Zsh

Ejecuta:

```bash
echo "Hello World"
```

Después:

```bash
echo '$HOME'
```

Y:

```bash
echo "$HOME"
```

### Observa

- En el primer caso se muestra un mensaje.
- En el segundo, el nombre de la variable permanece literal.
- En el tercero, el Shell expande la variable.

## PowerShell

Ejecuta:

```powershell
Write-Output "Hello World"
```

Después:

```powershell
Write-Output '$HOME'
```

Y:

```powershell
Write-Output "$HOME"
```

### Preguntas

1. ¿Qué diferencia observas?
2. ¿Qué ocurre con las comillas simples?
3. ¿Qué ocurre con las comillas dobles?
4. ¿Por qué esto será importante para las rutas?

### Aprendizaje

**Quoting controla cómo se interpreta una instrucción antes de ejecutarse.**

---

# 27. Casos reales de ingeniería

## Caso 1 — Un comando no reconoce una opción

### Situación

Ejecutamos una herramienta con una opción copiada de un tutorial.

La herramienta devuelve:

```text
Unknown option
```

### Posibles causas

- La opción no existe.
- Pertenece a otra versión.
- Se escribió incorrectamente.
- Se utilizó con el Subcommand equivocado.

### Diagnóstico

Consultar la ayuda de la versión instalada.

### Aprendizaje

No debemos asumir que todas las versiones de una CLI aceptan las mismas opciones.

---

## Caso 2 — Una ruta con espacios produce un error

### Situación

Intentamos acceder a un directorio con espacios en su nombre.

### Posible causa

El Shell interpreta partes de la ruta como argumentos separados.

### Diagnóstico

Revisar Quoting y Escape Characters.

### Aprendizaje

Los espacios pueden tener significado sintáctico.

---

## Caso 3 — Ejecutamos una versión inesperada

### Situación

```bash
node --version
```

Devuelve una versión diferente de la esperada.

### Posibles causas

- Instalaciones duplicadas.
- `PATH` diferente.
- Gestor de versiones.
- Shell con configuración antigua.

### Diagnóstico

Identificar el ejecutable utilizado.

### Aprendizaje

El nombre de un comando no garantiza qué instalación se ejecutará.

---

## Caso 4 — El comando funciona, pero devuelve un error

### Situación

```bash
git status
```

Se ejecuta, pero indica que no estamos dentro de un repositorio Git.

### Interpretación

El programa Git pudo iniciarse correctamente.

Sin embargo, la operación solicitada no pudo completarse en ese contexto.

### Aprendizaje

**Que un ejecutable exista no significa que cualquier operación pueda ejecutarse correctamente.**

---

## Caso 5 — Un Script automatizado falla

### Situación

Una herramienta de CI ejecuta un comando y recibe un Exit Code distinto de cero.

### Posibles causas

- Argumentos incorrectos.
- Dependencias ausentes.
- Configuración incompleta.
- Archivos inexistentes.
- Error de ejecución.

### Aprendizaje

Los Exit Codes permiten que otros sistemas detecten resultados sin depender únicamente de mensajes visibles.

---

# 28. Errores frecuentes

### Error 1 — Confundir Arguments con Options

Los Arguments proporcionan valores; las Options configuran el comportamiento.

La terminología concreta depende de cada CLI.

### Error 2 — Pensar que todos los comandos tienen Subcommands

Muchas herramientas no los necesitan.

### Error 3 — Pensar que todas las Options empiezan con `--`

Existen diferentes convenciones.

### Error 4 — Copiar placeholders literalmente

Debemos sustituir valores como `<filename>` por argumentos reales.

### Error 5 — Copiar el Prompt

En ejemplos como `$ git status`, normalmente `$` no forma parte del comando.

### Error 6 — Ignorar las comillas

Las rutas con espacios pueden interpretarse incorrectamente.

### Error 7 — Asumir que todos los Shells utilizan la misma sintaxis

Bash, Zsh y PowerShell tienen diferencias.

### Error 8 — Pensar que `command not found` siempre significa que el programa no está instalado

También puede existir un problema de resolución.

### Error 9 — Ignorar los Exit Codes

Una herramienta puede comunicar fallos mediante su estado de finalización.

### Error 10 — Confundir Output con éxito

Que un programa imprima texto no garantiza que haya terminado correctamente.

### Error 11 — Ejecutar comandos desconocidos

Una instrucción puede modificar archivos, configuraciones o procesos.

### Error 12 — Instalar herramientas sin verificar el problema

Primero debemos identificar qué comando se necesita y por qué falla.

### Error 13 — Asumir que `--help` funciona universalmente

Las interfaces de ayuda varían entre herramientas.

### Error 14 — Ignorar la versión de una CLI

Las opciones disponibles pueden cambiar entre versiones.

### Error 15 — Guardar secretos en el historial

Los comandos pueden conservarse y quedar expuestos.

---

# 29. Comprueba tu modelo mental

Responde sin consultar las explicaciones anteriores.

1. ¿Qué es un Command?
2. ¿Qué diferencia existe entre Command y Program?
3. ¿Qué es un Executable?
4. ¿Qué es un Argument?
5. ¿Qué es un Positional Argument?
6. ¿Qué es una Option?
7. ¿Qué es un Flag?
8. ¿Qué es una Short Option?
9. ¿Qué es una Long Option?
10. ¿Qué es un Subcommand?
11. ¿Todos los programas tienen Subcommands?
12. ¿Quién define los argumentos aceptados por una herramienta?
13. ¿Por qué importa el orden de algunos argumentos?
14. ¿Qué hace el Shell antes de ejecutar un programa?
15. ¿Por qué los espacios pueden modificar la interpretación?
16. ¿Qué es Quoting?
17. ¿Qué diferencia existe entre Single Quotes y Double Quotes en Bash?
18. ¿Qué es un Built-in Command?
19. ¿Qué es un External Command?
20. ¿Cómo podemos descubrir qué tipo de comando estamos ejecutando?
21. ¿Qué es Command Resolution?
22. ¿Qué papel tiene `PATH`?
23. ¿Qué significa `command not found`?
24. ¿Qué es `--help`?
25. ¿Qué es una Manual Page?
26. ¿Qué es una Synopsis?
27. ¿Qué es Command History?
28. ¿Qué es Autocompletion?
29. ¿Qué es Standard Output?
30. ¿Qué es Standard Error?
31. ¿Qué es un Exit Code?
32. ¿Qué representa normalmente el código `0`?
33. ¿Qué significa un código distinto de cero?
34. ¿Cómo consultamos el Exit Code en Bash?
35. ¿Cómo consultamos el Exit Code de un programa nativo en PowerShell?
36. ¿Qué diferencia existe entre un comando de lectura y uno que modifica el sistema?
37. ¿Por qué debemos consultar la documentación antes de ejecutar comandos desconocidos?
38. ¿Por qué una CLI puede funcionar en una versión y fallar en otra?
39. ¿Por qué no debemos escribir contraseñas directamente como argumentos?
40. ¿Cómo investigarías una opción desconocida?

---

# 30. Checklist de aprendizaje

## Fundamentals

- [ ] Comprendo qué es un Command.
- [ ] Diferencio Program y Executable.
- [ ] Comprendo la estructura de un comando.
- [ ] Identifico Arguments.
- [ ] Identifico Options.
- [ ] Comprendo Flags.
- [ ] Comprendo Subcommands.

## Shell Interpretation

- [ ] Comprendo que el Shell interpreta sintaxis.
- [ ] Reconozco la importancia de los espacios.
- [ ] Comprendo Quoting básico.
- [ ] Distingo Built-in y External Commands.
- [ ] Comprendo Command Resolution.

## Documentation

- [ ] Sé consultar `--help`.
- [ ] Conozco `help` de Bash.
- [ ] Conozco `man`.
- [ ] Conozco `Get-Help`.
- [ ] Comprendo una Synopsis.
- [ ] Sé buscar información sobre argumentos y opciones.

## Productivity

- [ ] Conozco Command History.
- [ ] Comprendo Autocompletion.
- [ ] Evito almacenar secretos innecesariamente en comandos.

## Execution

- [ ] Comprendo Standard Output de forma introductoria.
- [ ] Comprendo Standard Error de forma introductoria.
- [ ] Comprendo Exit Codes.
- [ ] Puedo consultar el resultado de un comando.
- [ ] Distingo operaciones de lectura y modificación.
- [ ] Verifico los efectos de los comandos antes de ejecutarlos.

---

# 31. Resumen conceptual

Los conceptos principales de este documento se relacionan de la siguiente manera:

```text
Developer
    │
    ▼
Command Line
    │
    ▼
Shell
    │
    ├── Parse Syntax
    │
    ├── Process Quoting
    │
    ├── Resolve Command
    │
    └── Prepare Arguments
    │
    ▼
Command Execution
    │
    ├── Built-in
    │
    └── External Program
             │
             ▼
          Process
             │
             ├── Standard Output
             ├── Standard Error
             └── Exit Status
```

Un comando puede estar compuesto por:

```text
Program
   │
   ├── Subcommand
   │
   ├── Arguments
   │
   └── Options / Flags
```

Y un desarrollador debe ser capaz de:

```text
Read Command
     │
     ▼
Understand Syntax
     │
     ▼
Check Documentation
     │
     ▼
Evaluate Side Effects
     │
     ▼
Execute
     │
     ▼
Interpret Result
```

---

# 32. Idea clave

**Utilizar una CLI profesionalmente no consiste en memorizar comandos, sino en comprender su estructura, interpretar sus argumentos, consultar su documentación y verificar los resultados de su ejecución.**

Esta habilidad será fundamental para trabajar posteriormente con:

- Git.
- Node.js.
- npm.
- pnpm.
- TypeScript.
- Vite.
- Docker.
- GitHub Actions.
- Nx.

---

# 33. Siguiente paso

Ahora que comprendemos cómo se construyen y ejecutan comandos, comenzaremos a utilizarlos para interactuar con el sistema de archivos.

En el siguiente documento aprenderemos:

- Qué es un File System.
- Qué son Files y Directories.
- Qué es Root Directory.
- Qué es Home Directory.
- Qué es Current Working Directory.
- Cómo navegar entre directorios.
- Cómo listar archivos.
- Cómo inspeccionar su contenido.
- Cómo realizar operaciones básicas de forma segura.

👉 [03 — File System Navigation](./03-file-system-navigation.md)

**Primero aprendimos a interpretar comandos. Ahora aprenderemos a utilizarlos para movernos por nuestro entorno de desarrollo.**