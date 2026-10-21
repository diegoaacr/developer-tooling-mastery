# Command Chaining and Pipes

> **Developer Tooling Mastery 2026 — Module 02**
>
> **Topic 10:** Command Chaining and Pipes  
> **Level:** Beginner → Professional Foundations  
> **Prerequisites:** [09 — Processes and Ports](./09-processes-and-ports.md)

---

## 1. Introduction

Hasta ahora hemos aprendido a ejecutar comandos individuales.

Por ejemplo:

```bash
pwd
```

```bash
ls
```

```bash
git status
```

Sin embargo, en el desarrollo profesional es habitual necesitar operaciones más complejas.

Imaginemos que queremos:

1. Crear un directorio.
2. Entrar en él.
3. Inicializar un repositorio Git.
4. Mostrar su estado.

Podríamos ejecutar cada instrucción por separado.

Pero también podemos construir un flujo:

```bash
mkdir my-project && cd my-project && git init && git status
```

Ahora imaginemos otra necesidad: queremos buscar una palabra dentro de la salida de un comando.

Podemos conectar dos comandos mediante un **Pipe**:

```bash
git branch | grep feature
```

Estos mecanismos forman parte de una capacidad fundamental de la terminal: **Command Composition**.

En este documento aprenderemos cómo combinar comandos sin perder el control de sus resultados, errores y efectos secundarios.

---

# 2. Learning Objectives

Al finalizar este documento podrás:

1. Comprender qué son los Standard Streams.
2. Diferenciar Standard Input, Output y Error.
3. Comprender qué es un Exit Code.
4. Diferenciar `;`, `&&` y `||`.
5. Comprender cómo funcionan los Pipes.
6. Redirigir resultados a archivos.
7. Diferenciar sobrescritura y adición.
8. Comprender el comportamiento de errores en Pipelines.
9. Utilizar Command Substitution.
10. Reconocer diferencias entre Bash, Zsh y PowerShell.
11. Construir flujos sencillos y seguros.
12. Aplicar estos fundamentos a scripts de desarrollo.

---

# 3. The Problem: Isolated Commands

Un comando individual realiza una operación.

Por ejemplo:

```bash
git status
```

Pero los flujos de desarrollo suelen requerir varias operaciones relacionadas.

```text
Developer Workflow
       │
       ├── Create Directory
       ├── Enter Directory
       ├── Initialize Project
       ├── Install Dependencies
       └── Start Development Server
```

Si ejecutamos cada operación manualmente, debemos comprobar continuamente si la anterior terminó correctamente.

El Shell proporciona mecanismos para expresar esas relaciones.

Por ejemplo:

```text
Command A
    │
    ├── Success → Command B
    │
    └── Failure → Stop
```

O:

```text
Command A Output
        │
        ▼
Command B Input
```

Son problemas diferentes y requieren mecanismos diferentes.

### Key Idea

**Command Chaining controla cuándo se ejecutan los comandos; Pipes permiten conectar sus flujos de datos.**

---

# 4. Standard Streams

Antes de combinar comandos debemos comprender cómo intercambian información con su entorno.

En sistemas Unix-like, los procesos suelen disponer de tres flujos estándar.

| Stream | Nombre | File Descriptor |
|---|---|---|
| Standard Input | `stdin` | `0` |
| Standard Output | `stdout` | `1` |
| Standard Error | `stderr` | `2` |

Estos números son convenciones fundamentales en entornos Unix-like.

PowerShell también dispone de flujos de salida, pero su modelo es más amplio y utiliza objetos.

---

# 5. Standard Input — stdin

**Standard Input** representa un canal habitual por el que un programa puede recibir datos.

Ejemplo conceptual:

```text
Keyboard
    │
    ▼
Standard Input
    │
    ▼
Program
```

Podemos utilizar:

```bash
cat
```

En una terminal interactiva Unix-like, si no recibe archivos como argumentos, `cat` puede leer desde `stdin`.

Escribimos:

```text
Hello Developer
```

Y el programa reproduce la entrada.

Para terminar la entrada en muchos entornos Unix-like podemos utilizar `Ctrl + D` en una línea vacía.

## 5.1 ¿stdin siempre viene del teclado?

No.

También puede provenir de:

- Otro programa.
- Un archivo.
- Un Pipe.
- Otros mecanismos de entrada.

### Key Idea

**stdin es un canal de entrada, no necesariamente el teclado.**

---

# 6. Standard Output — stdout

**Standard Output** es el flujo habitual utilizado por un programa para producir resultados.

Ejemplo:

```bash
echo "Hello Developer"
```

Salida:

```text
Hello Developer
```

Modelo:

```text
Program
   │
   ▼
stdout
   │
   ▼
Terminal
```

## 6.1 ¿stdout siempre aparece en pantalla?

No.

Podemos redirigirlo hacia:

- Un archivo.
- Otro proceso.
- Un dispositivo.
- Un mecanismo de captura.

Por ejemplo:

```bash
echo "Hello Developer" > output.txt
```

Ahora el resultado se escribe en un archivo.

### Key Idea

**stdout representa un flujo de salida; la terminal es solamente uno de sus posibles destinos.**

---

# 7. Standard Error — stderr

**Standard Error** es el flujo habitualmente utilizado para mensajes de error y diagnóstico.

Ejemplo en Bash/Zsh:

```bash
ls nonexistent-directory
```

Podemos recibir un mensaje indicando que el directorio no existe.

Conceptualmente:

```text
Program
   │
   ├── stdout → Normal Output
   │
   └── stderr → Error Messages
```

## 7.1 ¿Por qué separar stdout y stderr?

Porque podemos querer procesar los resultados normales sin mezclar mensajes de error.

Por ejemplo, un Script puede necesitar guardar únicamente los datos producidos correctamente.

## 7.2 ¿Todo mensaje en stderr representa un fallo?

No necesariamente.

Algunas herramientas escriben advertencias o información de diagnóstico en `stderr`.

## 7.3 ¿Todo error aparece en stderr?

Tampoco debemos asumirlo.

El comportamiento depende de la aplicación.

### Key Idea

**stdout y stderr son canales distintos; el Exit Code es el mecanismo habitual para comunicar el resultado de ejecución de un proceso.**

---

# 8. Exit Codes

Cuando un proceso termina, normalmente comunica un **Exit Status** o **Exit Code**.

En sistemas Unix-like:

```text
0 → Success
Non-zero → Failure or another status
```

El significado exacto de los valores distintos de cero depende del programa.

## 8.1 Ejemplo

```bash
git --version
```

Después:

```bash
echo $?
```

Si el comando terminó correctamente, normalmente obtendremos:

```text
0
```

## 8.2 Ejemplo de fallo

```bash
ls nonexistent-directory
```

Después:

```bash
echo $?
```

Normalmente obtendremos un valor distinto de cero.

## 8.3 ¿Qué representa `$?`?

En Bash y Zsh, permite consultar el estado de la operación anterior, según las reglas del Shell.

Debemos consultarlo inmediatamente, porque ejecutar otro comando puede cambiar su valor.

## 8.4 PowerShell

En PowerShell encontramos:

```powershell
$?
```

que indica si la última operación se consideró satisfactoria.

También existe:

```powershell
$LASTEXITCODE
```

para consultar el código de salida de programas nativos cuando corresponde.

No son variables equivalentes.

### Key Idea

**Los Exit Codes permiten que otros comandos y sistemas de automatización conozcan el resultado de una ejecución.**

---

# 9. Command Chaining

**Command Chaining** consiste en relacionar varias instrucciones dentro de una misma expresión del Shell.

Los operadores más conocidos en Bash/Zsh son:

| Operador | Comportamiento |
|---|---|
| `;` | Ejecutar secuencialmente |
| `&&` | Ejecutar el siguiente si el anterior tiene éxito |
| `||` | Ejecutar el siguiente si el anterior falla |

Vamos a estudiarlos individualmente.

---

# 10. Sequential Execution — `;`

El operador `;` permite separar comandos.

Ejemplo:

```bash
echo "First"; echo "Second"
```

Resultado:

```text
First
Second
```

## 10.1 ¿Depende del éxito?

No.

Por ejemplo:

```bash
ls nonexistent-directory; echo "Finished"
```

Aunque `ls` falle, el siguiente comando se ejecuta.

## 10.2 ¿Cuándo utilizarlo?

Cuando queremos ejecutar operaciones secuenciales sin condicionar cada una al resultado anterior.

## 10.3 ¿Es recomendable para instalar dependencias y ejecutar una aplicación?

No siempre.

Si una instalación falla, normalmente no queremos iniciar el siguiente paso como si todo estuviera correcto.

### Key Idea

**`;` expresa secuencia, no dependencia de éxito.**

---

# 11. Conditional Execution — `&&`

El operador `&&` permite ejecutar el siguiente comando únicamente cuando el anterior termina con éxito.

Ejemplo:

```bash
mkdir my-project && cd my-project
```

## 11.1 ¿Qué ocurre?

Primero intentamos crear el directorio.

Si la operación tiene éxito, ejecutamos:

```bash
cd my-project
```

Si falla, no ejecutamos la segunda operación.

## 11.2 Modelo

```text
Command A
    │
    ▼
Exit Status
    │
    ├── Success → Command B
    │
    └── Failure → Stop Chain
```

## 11.3 Ejemplo con Git

```bash
git init && git status
```

## 11.4 ¿Por qué es útil?

Porque muchas operaciones de desarrollo tienen dependencias.

Por ejemplo:

```bash
pnpm install && pnpm build
```

Si la instalación falla, evitamos continuar con el Build.

### Key Idea

**`&&` expresa una dependencia: el siguiente paso requiere que el anterior haya terminado correctamente.**

---

# 12. Conditional Execution — `||`

El operador `||` permite ejecutar el siguiente comando cuando el anterior falla.

Ejemplo:

```bash
test -d my-project || echo "Directory not found"
```

## 12.1 ¿Qué hace `test -d`?

Comprueba si la ruta corresponde a un directorio.

## 12.2 Modelo

```text
Command A
    │
    ▼
Exit Status
    │
    ├── Success → Skip Command B
    │
    └── Failure → Command B
```

## 12.3 Ejemplo de diagnóstico

```bash
git status || echo "Git status failed"
```

## 12.4 Precaución

No debemos utilizar `||` para ocultar errores importantes.

Por ejemplo:

```bash
pnpm test || true
```

Puede hacer que el conjunto de comandos termine con éxito aunque las pruebas hayan fallado.

Esto es especialmente peligroso en CI/CD.

### Key Idea

**`||` permite definir acciones alternativas ante fallos, pero no debemos utilizarlo indiscriminadamente para ignorarlos.**

---

# 13. Combining `&&` and `||`

Podemos combinar ambos operadores.

Ejemplo:

```bash
test -d my-project && echo "Exists" || echo "Not found"
```

Parece un `if/else`.

Sin embargo, existe una diferencia importante.

En Bash/Zsh, las listas con `&&` y `||` tienen la misma precedencia y se evalúan de izquierda a derecha.

Si el comando posterior a `&&` falla, puede ejecutarse la rama de `||`, aunque la condición original haya sido verdadera.

## 13.1 Alternativa más clara

```bash
if test -d my-project; then
  echo "Exists"
else
  echo "Not found"
fi
```

## 13.2 ¿Cuál recomendamos?

Para condiciones sencillas, los operadores pueden ser suficientes.

Para lógica con múltiples ramas o efectos secundarios, preferimos estructuras explícitas.

### Key Idea

**No confundas una cadena `&& ... || ...` con un `if/else` completamente equivalente.**

---

# 14. What Is a Pipe?

Un **Pipe** conecta la salida estándar de un comando con la entrada estándar de otro.

El operador es:

```bash
|
```

Ejemplo:

```bash
printf '%s\n' "apple" "banana" "orange" | grep banana
```

Resultado:

```text
banana
```

## 14.1 Modelo conceptual

```text
Command A
    │
    ▼
stdout
    │
    ▼
   Pipe
    │
    ▼
stdin
    │
    ▼
Command B
```

## 14.2 ¿Qué ocurre?

El primer comando produce datos.

El segundo los recibe y procesa.

## 14.3 ¿Es lo mismo que `&&`?

No.

```bash
commandA && commandB
```

controla la ejecución según el éxito.

```bash
commandA | commandB
```

conecta flujos de datos.

### Key Idea

**Un Pipe conecta datos entre comandos; no significa simplemente ejecutar uno después de otro.**

---

# 15. Practical Example: Filtering Output

Imaginemos que queremos mostrar únicamente las ramas Git cuyo nombre contiene `feature`.

Podemos ejecutar:

```bash
git branch --list
```

Y después filtrar:

```bash
git branch --list | grep feature
```

## 15.1 ¿Qué ocurre?

```text
git branch --list
        │
        ▼
Branch Names
        │
        ▼
grep feature
        │
        ▼
Filtered Results
```

## 15.2 ¿Qué hace grep?

Busca líneas que coincidan con un patrón.

## 15.3 ¿Es universal?

`grep` está disponible habitualmente en macOS y Linux.

En Windows PowerShell existen alternativas como `Select-String`.

### Key Idea

**Los Pipes permiten construir pequeñas transformaciones reutilizando comandos especializados.**

---

# 16. Multiple Pipes

Podemos conectar más de dos comandos.

Ejemplo:

```bash
printf '%s\n' "apple" "banana" "apricot" "avocado" |
  grep '^a' |
  sort
```

Resultado:

```text
apple
apricot
avocado
```

## 16.1 ¿Qué ocurre?

Primero producimos varias líneas.

Después filtramos las que comienzan con `a`.

Finalmente ordenamos los resultados.

Modelo:

```text
Data Producer
      │
      ▼
Filter
      │
      ▼
Sort
      │
      ▼
Result
```

## 16.2 ¿Cuál es la ventaja?

Cada comando tiene una responsabilidad específica.

Esta idea se relaciona con un principio clásico de Unix:

**Crear herramientas que realicen una tarea bien y puedan combinarse.**

### Key Idea

**Una Pipeline permite construir operaciones más complejas a partir de componentes sencillos.**

---

# 17. Output Redirection — `>`

Podemos redirigir stdout hacia un archivo.

Ejemplo:

```bash
echo "Hello Developer" > output.txt
```

Esto escribe el resultado en `output.txt`.

## 17.1 ¿Qué ocurre si el archivo no existe?

Normalmente se crea.

## 17.2 ¿Qué ocurre si existe?

Su contenido se sobrescribe.

Por ejemplo:

```bash
echo "First" > output.txt
```

Después:

```bash
echo "Second" > output.txt
```

El archivo terminará conteniendo:

```text
Second
```

## 17.3 Riesgo importante

Podemos sobrescribir archivos accidentalmente.

### Key Idea

**`>` redirige stdout y normalmente reemplaza el contenido del archivo de destino.**

---

# 18. Append Redirection — `>>`

Si queremos agregar contenido sin reemplazar lo anterior, utilizamos:

```bash
>>
```

Ejemplo:

```bash
echo "First" > output.txt
echo "Second" >> output.txt
```

Resultado:

```text
First
Second
```

## 18.1 ¿Qué significa Append?

Agregar información al final de un archivo.

## 18.2 ¿Cuándo resulta útil?

Por ejemplo:

- Registrar eventos.
- Crear archivos de prueba.
- Acumular resultados.
- Añadir información a un registro local.

## 18.3 ¿Podemos usarlo indiscriminadamente para Logs?

No.

En aplicaciones profesionales, la gestión de Logs requiere considerar rotación, volumen, estructura y seguridad.

### Key Idea

**`>` sobrescribe; `>>` agrega al final.**

---

# 19. Error Redirection — `2>`

En Bash/Zsh podemos redirigir stderr de manera independiente.

Ejemplo:

```bash
ls nonexistent-directory 2> errors.txt
```

## 19.1 ¿Qué significa `2`?

Representa el File Descriptor de stderr.

## 19.2 ¿Qué contiene errors.txt?

Normalmente, el mensaje de error producido por `ls`.

## 19.3 ¿Qué ocurre con stdout?

No se redirige mediante `2>`.

### Key Idea

**Podemos manejar la salida normal y la salida de error por separado.**

---

# 20. Redirect stdout and stderr

En Bash/Zsh podemos utilizar:

```bash
some-command > output.txt 2> errors.txt
```

Esto separa ambos flujos.

También podemos combinarlos:

```bash
some-command > all-output.txt 2>&1
```

## 20.1 ¿Qué significa `2>&1`?

Redirige stderr hacia el destino actual de stdout.

## 20.2 ¿Importa el orden?

Sí.

No debemos asumir que:

```bash
some-command 2>&1 > output.txt
```

produce exactamente el mismo resultado.

Las redirecciones se procesan en orden y pueden producir destinos diferentes.

## 20.3 Alternativa Bash/Zsh

En estos Shells también encontramos:

```bash
some-command &> all-output.txt
```

Es una sintaxis específica compatible con ellos, no una convención universal de todos los Shells.

### Key Idea

**El orden de las redirecciones importa porque los destinos se establecen secuencialmente.**

---

# 21. Input Redirection — `<`

Podemos proporcionar el contenido de un archivo como entrada estándar.

Ejemplo:

```bash
sort < names.txt
```

El programa recibe el contenido de `names.txt` mediante stdin.

## 21.1 ¿Es lo mismo que pasar un nombre de archivo?

No necesariamente.

Comparemos:

```bash
sort names.txt
```

con:

```bash
sort < names.txt
```

En este caso pueden producir resultados similares, pero el mecanismo de entrada es diferente.

## 21.2 ¿Por qué importa?

Porque no todos los programas aceptan nombres de archivo como argumentos, pero muchos pueden leer desde stdin.

### Key Idea

**`<` conecta el contenido de un archivo con la entrada estándar de un comando.**

---

# 22. Here Documents

En Bash/Zsh podemos utilizar un **Here Document** para proporcionar múltiples líneas de entrada.

Ejemplo:

```bash
cat <<'EOF'
Hello
Developer
Tooling Mastery
EOF
```

Resultado:

```text
Hello
Developer
Tooling Mastery
```

## 22.1 ¿Qué significa EOF?

Es un delimitador elegido para señalar dónde termina el contenido.

No tiene que llamarse necesariamente `EOF`.

## 22.2 ¿Por qué utilizamos `'EOF'` entre comillas?

Para evitar determinadas expansiones del Shell dentro del contenido.

## 22.3 ¿Cuándo resulta útil?

Para proporcionar texto multilínea a comandos o generar contenido durante prácticas y automatizaciones.

### Key Idea

**Here Documents permiten proporcionar bloques de texto como entrada a un comando.**

---

# 23. Command Substitution

**Command Substitution** permite utilizar la salida de un comando dentro de otra instrucción.

En Bash/Zsh:

```bash
$(command)
```

Ejemplo:

```bash
current_directory=$(pwd)
```

Después:

```bash
echo "$current_directory"
```

## 23.1 ¿Qué ocurre?

El Shell ejecuta:

```bash
pwd
```

Captura su stdout y utiliza ese resultado en la asignación.

## 23.2 Otro ejemplo

```bash
echo "Current directory: $(pwd)"
```

## 23.3 ¿Qué debemos recordar?

La sustitución de comandos tiene reglas de expansión y tratamiento de saltos de línea.

Debemos utilizar comillas cuando corresponda para evitar divisiones de palabras o expansión de patrones no deseadas.

### Key Idea

**Command Substitution permite convertir la salida de un comando en parte de otra expresión.**

---

# 24. Exit Codes in Pipelines

Consideremos:

```bash
commandA | commandB
```

¿Qué ocurre si `commandA` falla, pero `commandB` termina correctamente?

En Bash y Zsh, el comportamiento habitual del estado final de una Pipeline es reflejar el estado del último comando, salvo configuraciones adicionales.

Esto puede ocultar fallos anteriores.

## 24.1 Bash y pipefail

En Bash podemos activar:

```bash
set -o pipefail
```

Con esta opción, el estado de la Pipeline refleja el último comando que terminó con un estado distinto de cero, o cero si todos tuvieron éxito.

Zsh también dispone de la opción `pipefail`.

## 24.2 ¿Por qué importa?

Especialmente en:

- Build Scripts.
- Testing.
- CI/CD.
- Automatización.

## 24.3 ¿Debemos activar todas las opciones estrictas sin comprenderlas?

No.

Debemos entender cómo afectan al flujo de ejecución y al tratamiento de errores.

### Key Idea

**Una Pipeline puede producir un resultado aparentemente correcto aunque un comando anterior haya fallado.**

---

# 25. PowerShell Pipelines

PowerShell también utiliza el operador:

```powershell
|
```

Pero existe una diferencia fundamental.

En Bash/Zsh, las Pipelines suelen conectar flujos de bytes que las herramientas de texto interpretan.

En PowerShell, las Pipelines entre Cmdlets normalmente transportan **objetos .NET**.

## 25.1 Ejemplo

```powershell
Get-Process | Where-Object ProcessName -eq "node"
```

## 25.2 ¿Qué ocurre?

```text
Get-Process
     │
     ▼
Process Objects
     │
     ▼
Where-Object
     │
     ▼
Filtered Objects
```

## 25.3 Seleccionar propiedades

```powershell
Get-Process |
    Select-Object ProcessName, Id
```

## 25.4 ¿Por qué es importante?

Porque no necesitamos analizar texto para acceder a propiedades como `Id` o `ProcessName`.

## 25.5 ¿Y los programas nativos?

Cuando PowerShell interactúa con ejecutables externos, existen diferencias importantes en la conversión y tratamiento de sus flujos.

No debemos asumir que todas las Pipelines de PowerShell transportan objetos estructurados desde cualquier programa.

### Key Idea

**Bash/Zsh destacan por combinar flujos de texto; PowerShell permite combinar objetos estructurados entre sus comandos nativos.**

---

# 26. PowerShell Command Chaining

PowerShell utiliza mecanismos similares, pero debemos considerar la versión.

## 26.1 Sequential Commands

```powershell
Write-Output "First"; Write-Output "Second"
```

## 26.2 PowerShell 7+

PowerShell 7 incorpora operadores de cadena de Pipelines:

```powershell
commandA && commandB
```

Y:

```powershell
commandA || commandB
```

Estos operadores no están disponibles de la misma manera en Windows PowerShell 5.1.

## 26.3 Alternativa explícita

Podemos utilizar estructuras de control:

```powershell
if (Test-Path "./my-project") {
    Write-Output "Directory exists"
} else {
    Write-Output "Directory not found"
}
```

## 26.4 ¿Por qué importa?

Porque no todo comando que funciona en PowerShell 7 funcionará en Windows PowerShell 5.1.

### Key Idea

**La portabilidad de un comando PowerShell depende también de la versión utilizada.**

---

# 27. PowerShell Redirection

PowerShell admite redirecciones como:

```powershell
Get-Process > processes.txt
```

También:

```powershell
Write-Output "Another line" >> processes.txt
```

Y para el flujo de errores:

```powershell
Get-Item "./missing-file" 2> errors.txt
```

## 27.1 Diferencia importante

PowerShell maneja múltiples flujos y aplica sus propias reglas de representación y codificación.

No debemos asumir que la redirección funciona internamente igual que en Bash.

## 27.2 ¿Qué ocurre con la codificación?

El comportamiento depende de la versión de PowerShell y del tipo de comando.

Es importante al generar archivos consumidos por otras herramientas.

### Key Idea

**Los símbolos pueden parecer iguales entre Shells, pero sus detalles de implementación no siempre coinciden.**

---

# 28. Practical Example: Git Workflow

Imaginemos que queremos verificar el estado de Git y mostrar un mensaje alternativo si el comando falla.

En Bash/Zsh:

```bash
git status && echo "Git status completed"
```

O:

```bash
git status || echo "Unable to inspect Git status"
```

## 28.1 ¿Es suficiente para automatizaciones grandes?

No siempre.

Para automatizaciones más complejas conviene utilizar Scripts con:

- Validaciones.
- Manejo de errores.
- Mensajes claros.
- Códigos de salida.
- Comportamiento predecible.

### Key Idea

**Command Chaining es excelente para operaciones sencillas; no reemplaza el diseño adecuado de Scripts.**

---

# 29. Practical Example: Node.js and pnpm

Supongamos que queremos instalar dependencias y después ejecutar las pruebas.

```bash
pnpm install && pnpm test
```

## 29.1 ¿Qué expresa?

Que las pruebas deben ejecutarse únicamente si la instalación termina correctamente.

## 29.2 ¿Qué ocurre si la instalación falla?

El segundo comando no se ejecuta.

## 29.3 ¿Por qué es útil en CI?

Porque evita continuar con pasos dependientes de una preparación fallida.

## 29.4 ¿Es suficiente para un Pipeline profesional?

No.

Los sistemas de CI/CD también ofrecen mecanismos de dependencias, condiciones, artefactos y manejo de errores.

Estudiaremos esos mecanismos en módulos posteriores.

### Key Idea

**Los operadores del Shell son fundamentos que posteriormente encontraremos en automatizaciones más complejas.**

---

# 30. Practical Example: Searching Logs

Imaginemos que tenemos un archivo de Logs:

```text
INFO Server started
WARN Cache unavailable
ERROR Database connection failed
INFO Request completed
```

En Bash/Zsh podemos buscar:

```bash
grep ERROR app.log
```

También:

```bash
cat app.log | grep ERROR
```

Pero en este caso `cat` es innecesario porque `grep` puede leer directamente el archivo.

## 30.1 ¿Qué aprendemos?

Que utilizar Pipes no significa que siempre debamos utilizarlos.

La solución más sencilla puede ser mejor.

## 30.2 PowerShell

Podemos utilizar:

```powershell
Select-String -Path app.log -Pattern "ERROR"
```

### Key Idea

**La composición de comandos debe mejorar la claridad, no agregar complejidad innecesaria.**

---

# 31. Security Considerations

Combinar comandos es poderoso, pero también puede introducir riesgos.

## 31.1 Sobrescritura accidental

```bash
echo "Hello" > important-file.txt
```

Puede reemplazar el contenido existente.

## 31.2 Ocultar errores

```bash
pnpm test || true
```

Puede provocar que una automatización no detecte pruebas fallidas.

## 31.3 Ejecutar contenido desconocido

No debemos ejecutar automáticamente instrucciones descargadas de fuentes no confiables.

## 31.4 Exponer secretos

Redirigir variables de entorno, Logs o resultados de comandos hacia archivos puede almacenar información sensible.

## 31.5 Command Injection

Construir comandos utilizando entradas no confiables puede permitir que datos sean interpretados como instrucciones.

Este problema se estudia con mayor profundidad en Seguridad y Backend.

### Key Idea

**La capacidad de combinar comandos requiere comprender sus efectos, especialmente cuando modifican archivos o ejecutan contenido externo.**

---

# 32. Common Mistakes

### Mistake 1 — Confundir `&&` con `|`

Uno controla ejecución; el otro conecta datos.

### Mistake 2 — Pensar que `;` detiene la cadena ante errores

No lo hace por sí solo.

### Mistake 3 — Pensar que `||` significa ejecutar siempre una alternativa

Se ejecuta según el estado del comando anterior.

### Mistake 4 — Confundir stdout y stderr

Son flujos distintos.

### Mistake 5 — Pensar que todo mensaje de stderr implica un Exit Code distinto de cero

No necesariamente.

### Mistake 6 — Sobrescribir archivos accidentalmente

`>` puede reemplazar contenido.

### Mistake 7 — Confundir `>` con `>>`

Uno sobrescribe y el otro agrega.

### Mistake 8 — Ignorar el orden de las redirecciones

Puede cambiar los destinos de los flujos.

### Mistake 9 — Suponer que una Pipeline siempre detecta todos los fallos

Depende de la configuración.

### Mistake 10 — Tratar las Pipelines de PowerShell como simples Pipelines de texto

Entre Cmdlets suelen transportar objetos.

### Mistake 11 — Suponer que PowerShell 5.1 y 7 son idénticos

Existen diferencias importantes.

### Mistake 12 — Construir cadenas complejas difíciles de leer

En esos casos, un Script explícito suele ser mejor.

---

# 33. Practice 01 — Standard Streams

**Environment:** Bash/Zsh.

## Step 1

Ejecuta:

```bash
echo "Hello Developer"
```

## Step 2

Redirige stdout:

```bash
echo "Hello Developer" > output.txt
```

## Step 3

Consulta el archivo:

```bash
cat output.txt
```

## Step 4

Provoca un error controlado:

```bash
ls nonexistent-directory 2> errors.txt
```

## Step 5

Consulta:

```bash
cat errors.txt
```

## Questions

1. ¿Qué contiene stdout?
2. ¿Qué contiene stderr?
3. ¿Qué hace `>`?
4. ¿Qué hace `2>`?
5. ¿Por qué conviene separar los flujos?

---

# 34. Practice 02 — Command Chaining

**Environment:** Bash/Zsh.

## Step 1

Crea un directorio:

```bash
mkdir chaining-practice
```

## Step 2

Prueba:

```bash
cd chaining-practice && pwd
```

## Step 3

Ejecuta:

```bash
test -d missing-directory || echo "Directory does not exist"
```

## Step 4

Ejecuta:

```bash
echo "First"; echo "Second"
```

## Questions

1. ¿Qué diferencia existe entre `;` y `&&`?
2. ¿Cuándo se ejecuta el comando posterior a `||`?
3. ¿Por qué `&&` es útil para operaciones dependientes?

---

# 35. Practice 03 — Pipes

**Environment:** Bash/Zsh.

## Step 1

Produce datos:

```bash
printf '%s\n' "apple" "banana" "apricot" "orange"
```

## Step 2

Filtra:

```bash
printf '%s\n' "apple" "banana" "apricot" "orange" | grep '^a'
```

## Step 3

Ordena:

```bash
printf '%s\n' "apple" "banana" "apricot" "orange" |
  grep '^a' |
  sort
```

## Questions

1. ¿Qué datos produce el primer comando?
2. ¿Qué recibe `grep`?
3. ¿Qué recibe `sort`?
4. ¿Qué ventaja tiene la composición?

---

# 36. Practice 04 — File Redirection

**Environment:** Bash/Zsh.

## Step 1

```bash
echo "First" > notes.txt
```

## Step 2

```bash
echo "Second" >> notes.txt
```

## Step 3

```bash
cat notes.txt
```

## Step 4

```bash
echo "Third" > notes.txt
```

## Step 5

```bash
cat notes.txt
```

## Questions

1. ¿Qué ocurrió con el contenido original?
2. ¿Qué diferencia existe entre Append y Overwrite?
3. ¿Por qué debemos revisar el destino antes de redirigir?

---

# 37. Practice 05 — PowerShell Pipelines

**Environment:** PowerShell.

## Step 1

Consulta procesos:

```powershell
Get-Process
```

## Step 2

Selecciona propiedades:

```powershell
Get-Process |
    Select-Object ProcessName, Id
```

## Step 3

Ordena por nombre:

```powershell
Get-Process |
    Sort-Object ProcessName |
    Select-Object ProcessName, Id
```

## Step 4

Filtra:

```powershell
Get-Process |
    Where-Object ProcessName -eq "node"
```

## Questions

1. ¿Qué transporta normalmente la Pipeline entre Cmdlets?
2. ¿Qué hace `Select-Object`?
3. ¿Qué hace `Where-Object`?
4. ¿Cuál es la principal diferencia frente a una Pipeline de texto?

---

# 38. Real-world Engineering Scenarios

## Scenario 1 — Install and Build

```bash
pnpm install && pnpm build
```

**Learning:** Dependencias entre operaciones.

## Scenario 2 — Find Errors

```bash
grep ERROR app.log
```

**Learning:** Filtrado de información.

## Scenario 3 — Capture Output

```bash
git status > git-status.txt
```

**Learning:** Redirección de resultados.

## Scenario 4 — Handle Failures

```bash
pnpm test || echo "Tests failed"
```

**Learning:** Acciones alternativas ante errores. Para CI, debemos conservar correctamente el estado de fallo.

## Scenario 5 — Inspect Processes in PowerShell

```powershell
Get-Process |
    Where-Object ProcessName -eq "node"
```

**Learning:** Filtrado de objetos.

---

# 39. Knowledge Check

1. ¿Qué es stdin?
2. ¿Qué es stdout?
3. ¿Qué es stderr?
4. ¿Qué representan los File Descriptors 0, 1 y 2?
5. ¿Qué es un Exit Code?
6. ¿Qué significa normalmente Exit Code 0?
7. ¿Qué representa `$?` en Bash?
8. ¿Qué representa `$LASTEXITCODE` en PowerShell?
9. ¿Qué hace `;`?
10. ¿Qué hace `&&`?
11. ¿Qué hace `||`?
12. ¿Cuál es la diferencia entre Chaining y Piping?
13. ¿Qué hace `|`?
14. ¿Qué recibe el segundo comando de una Pipeline Unix habitual?
15. ¿Qué hace `>`?
16. ¿Qué hace `>>`?
17. ¿Qué hace `2>`?
18. ¿Qué significa `2>&1`?
19. ¿Por qué importa el orden de las redirecciones?
20. ¿Qué hace `<`?
21. ¿Qué es un Here Document?
22. ¿Qué es Command Substitution?
23. ¿Qué significa `$(command)`?
24. ¿Qué problema resuelve `pipefail`?
25. ¿Qué transportan normalmente las Pipelines entre Cmdlets de PowerShell?
26. ¿Qué hace `Where-Object`?
27. ¿Qué hace `Select-Object`?
28. ¿Qué diferencias existen entre PowerShell 5.1 y 7?
29. ¿Por qué `pnpm test || true` puede ser peligroso?
30. ¿Cuándo conviene reemplazar una cadena de comandos por un Script?

---

# 40. Learning Checklist

## Standard Streams

- [ ] Comprendo stdin.
- [ ] Comprendo stdout.
- [ ] Comprendo stderr.
- [ ] Reconozco los File Descriptors 0, 1 y 2.
- [ ] Comprendo los Exit Codes.

## Command Chaining

- [ ] Sé utilizar `;`.
- [ ] Sé utilizar `&&`.
- [ ] Sé utilizar `||`.
- [ ] Comprendo sus diferencias.
- [ ] Evito ocultar errores importantes.

## Pipes and Redirection

- [ ] Comprendo `|`.
- [ ] Sé conectar comandos.
- [ ] Comprendo `>`.
- [ ] Comprendo `>>`.
- [ ] Comprendo `2>`.
- [ ] Reconozco `2>&1`.
- [ ] Comprendo Input Redirection.
- [ ] Reconozco Command Substitution.

## Cross-platform Understanding

- [ ] Comprendo Pipelines de texto.
- [ ] Comprendo Pipelines de objetos.
- [ ] Reconozco diferencias de PowerShell.
- [ ] Comprendo por qué la versión del Shell importa.

## Professional Practices

- [ ] Compruebo resultados antes de continuar.
- [ ] Evito sobrescrituras accidentales.
- [ ] Mantengo Scripts legibles.
- [ ] Comprendo el tratamiento de errores en Pipelines.
- [ ] Puedo construir flujos sencillos de desarrollo.

---

# 41. Mental Model

Nuestro modelo conceptual queda así:

```text
Developer
    │
    ▼
Shell
    │
    ├── Command Chaining
    │       │
    │       ├── ;
    │       ├── &&
    │       └── ||
    │
    ├── Pipes
    │       │
    │       └── stdout → stdin
    │
    ├── Redirection
    │       │
    │       ├── >
    │       ├── >>
    │       ├── <
    │       └── 2>
    │
    └── Exit Status
            │
            ├── Success
            └── Failure
```

Recordemos:

```text
Command Chaining ≠ Piping
```

```text
stdout ≠ stderr
```

```text
Overwrite ≠ Append
```

```text
Command Success ≠ Output Produced
```

Y un principio fundamental:

```text
Understand Data Flow
        +
Understand Execution Flow
        =
Reliable Shell Automation
```

---

# 42. Key Takeaway

**Command Chaining permite controlar el flujo de ejecución, mientras que Pipes y Redirection permiten controlar el flujo de datos.**

Ambos mecanismos son fundamentales para desarrollar automatizaciones fiables.

Cuando escribimos:

```bash
pnpm install && pnpm build
```

estamos definiendo una dependencia entre operaciones.

Cuando escribimos:

```bash
git branch | grep feature
```

estamos conectando la salida de un comando con la entrada de otro.

Y cuando escribimos:

```bash
git status > status.txt
```

estamos cambiando el destino de la información producida.

Comprender estas diferencias nos permitirá trabajar con herramientas de desarrollo, scripts y sistemas de automatización de forma más segura y profesional.

---

# 43. Next Step

El siguiente documento será:

**11 — Cross-platform Commands**

Estudiaremos cómo trabajar profesionalmente en diferentes sistemas operativos:

- macOS.
- Linux.
- Windows.
- Bash.
- Zsh.
- PowerShell.
- Git Bash.
- WSL.

Aprenderemos a identificar equivalencias entre comandos y a evitar problemas de portabilidad en proyectos compartidos.

👉 [11 — Cross-platform Commands](./11-cross-platform-commands.md)

**Ahora sabemos combinar comandos. El siguiente paso es comprender cómo hacerlo correctamente en diferentes entornos de desarrollo.**