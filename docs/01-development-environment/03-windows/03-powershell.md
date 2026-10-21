# PowerShell

PowerShell es un Shell, un lenguaje de scripting y una plataforma de automatización desarrollada por Microsoft.

Permite interactuar con el sistema operativo, ejecutar programas, administrar archivos y procesos, consultar información del entorno y automatizar tareas mediante Scripts.

Una de sus características más importantes es que **PowerShell trabaja con objetos dentro de su Pipeline**, a diferencia del enfoque tradicional de muchos Shells Unix, donde los comandos suelen intercambiar texto.

Comprender PowerShell nos permitirá trabajar con mayor precisión en Windows y construir una base sólida para aprender automatización, CI/CD, administración de entornos y herramientas de desarrollo.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder:

- Explicar qué es PowerShell y qué problema resuelve.
- Diferenciar PowerShell, Windows Terminal y CMD.
- Comprender la diferencia entre Windows PowerShell y PowerShell moderno.
- Identificar qué es un Cmdlet.
- Comprender la convención `Verb-Noun`.
- Utilizar comandos de descubrimiento y ayuda.
- Comprender qué es un Object Pipeline.
- Diferenciar el procesamiento de objetos y el procesamiento de texto.
- Consultar archivos, directorios, procesos y servicios.
- Trabajar con variables y Environment Variables.
- Comprender la resolución de comandos.
- Identificar qué son los Scripts `.ps1`.
- Entender qué es Execution Policy y sus limitaciones.
- Reconocer buenas prácticas de automatización.
- Diagnosticar problemas habituales.

---

## 🧠 1. El problema: necesitamos interactuar con Windows de forma programática

Imagina que necesitamos conocer qué procesos están ejecutándose en nuestra computadora.

Podríamos abrir Task Manager y revisarlos manualmente.

También podríamos necesitar:

- Consultar archivos.
- Identificar procesos.
- Revisar variables de entorno.
- Buscar herramientas instaladas.
- Inspeccionar servicios.
- Ejecutar tareas repetitivas.

Realizar todas estas operaciones desde interfaces gráficas puede resultar poco eficiente cuando necesitamos automatizarlas.

Aquí aparece PowerShell.

### Modelo conceptual

```text
Developer
    ↓
PowerShell
    ↓
Commands / Scripts
    ↓
Operating System
    ↓
Results
```

PowerShell proporciona una interfaz programática para trabajar con numerosos componentes del sistema y con herramientas externas.

### ¿Por qué es importante para un Software Engineer?

Porque muchas tareas de desarrollo requieren interactuar con el entorno.

Por ejemplo:

```text
Inspect Runtime Versions
Manage Files
Run Development Commands
Inspect Processes
Configure Environment
Execute Automation
```

PowerShell permite realizar estas operaciones desde un mismo entorno.

---

## 🧩 2. ¿Qué es PowerShell?

PowerShell combina tres capacidades importantes.

### 2.1 Shell

Permite ejecutar comandos de forma interactiva.

Por ejemplo:

```powershell
Get-Location
```

Este comando consulta nuestro directorio actual.

### 2.2 Scripting Language

Permite escribir instrucciones y estructuras de programación.

Por ejemplo:

```powershell
$name = "Developer"

Write-Output "Hello, $name"
```

### 2.3 Automation Platform

Permite combinar comandos para automatizar operaciones.

Por ejemplo:

```powershell
Get-Process |
    Where-Object CPU -GT 10 |
    Select-Object ProcessName, CPU
```

Este ejemplo consulta procesos, filtra por tiempo de CPU acumulado y selecciona determinadas propiedades.

No representa necesariamente el consumo de CPU en tiempo real.

### Modelo mental

```text
PowerShell
│
├── Interactive Shell
├── Scripting Language
└── Automation Capabilities
```

Estas capacidades forman parte de un mismo ecosistema.

---

## 🪟 3. PowerShell vs Windows Terminal vs CMD

Recordemos una distinción importante.

| Herramienta | Categoría | Responsabilidad |
|---|---|---|
| Windows Terminal | Terminal Emulator | Presentar sesiones de línea de comandos |
| PowerShell | Shell y lenguaje de scripting | Interpretar comandos y automatizar |
| CMD | Command Interpreter | Ejecutar comandos tradicionales de Windows |

### Ejemplo

```text
Windows Terminal
       ↓
PowerShell
       ↓
Get-Process
       ↓
Process Information
```

Windows Terminal presenta la sesión.

PowerShell interpreta el comando.

El sistema proporciona la información correspondiente.

### ¿Podemos utilizar PowerShell sin Windows Terminal?

Sí.

PowerShell puede ejecutarse desde otras aplicaciones de Terminal compatibles.

**PowerShell no depende conceptualmente de Windows Terminal para funcionar.**

---

## 🔄 4. Windows PowerShell vs PowerShell moderno

Existen dos líneas importantes que debemos distinguir.

### Windows PowerShell

Es la implementación tradicional incluida en Windows.

Su versión final principal es **Windows PowerShell 5.1**.

Habitualmente se ejecuta mediante:

```powershell
powershell.exe
```

Está basada en .NET Framework.

### PowerShell moderno

Es la evolución multiplataforma de PowerShell.

Se ejecuta habitualmente mediante:

```powershell
pwsh
```

Está basada en versiones modernas de .NET y puede utilizarse en Windows, macOS y Linux.

### Comparación

| Característica | Windows PowerShell 5.1 | PowerShell moderno |
|---|---|---|
| Ejecutable habitual | `powershell.exe` | `pwsh.exe` en Windows |
| Plataforma | Windows | Windows, macOS y Linux |
| Base tecnológica | .NET Framework | .NET moderno |
| Desarrollo de nuevas capacidades | Principalmente mantenimiento | Evolución activa |
| Compatibilidad con módulos heredados | Amplia para módulos diseñados para 5.1 | Depende del módulo |

### ¿Cuál recomendamos aprender?

Para nuevas automatizaciones, conviene familiarizarse con **PowerShell moderno**.

Sin embargo, Windows PowerShell 5.1 sigue siendo relevante en numerosos entornos corporativos.

### Consultar la versión

```powershell
$PSVersionTable.PSVersion
```

### Consultar la edición

```powershell
$PSVersionTable.PSEdition
```

Podemos encontrar valores como:

```text
Desktop
Core
```

No debemos asumir que ambas ediciones admiten exactamente los mismos módulos.

---

## 🧱 5. ¿Qué es un Cmdlet?

Un **Cmdlet** es un comando especializado de PowerShell.

Su nombre suele seguir la convención:

```text
Verb-Noun
```

Por ejemplo:

```powershell
Get-Process
```

Aquí:

- `Get` representa la acción.
- `Process` representa el recurso.

### Otros ejemplos

| Cmdlet | Responsabilidad |
|---|---|
| `Get-Location` | Consultar el directorio actual |
| `Get-ChildItem` | Enumerar elementos |
| `Get-Process` | Consultar procesos |
| `Get-Service` | Consultar servicios compatibles |
| `Get-Command` | Descubrir comandos |
| `Get-Help` | Consultar ayuda |
| `Set-Location` | Cambiar de ubicación |
| `New-Item` | Crear elementos |

### ¿Por qué Verb-Noun?

Porque facilita descubrir comandos y comprender su propósito.

Por ejemplo:

```text
Get-Process
Stop-Process
Start-Process
```

Aunque no todos los recursos admiten todos los verbos, la convención ayuda a mantener una interfaz consistente.

---

## 🔎 6. Descubrir comandos

Una habilidad importante consiste en aprender a encontrar herramientas sin memorizar todos sus nombres.

PowerShell proporciona `Get-Command`.

### Consultar un comando

```powershell
Get-Command Get-Process
```

### Buscar comandos relacionados

```powershell
Get-Command *Process*
```

### Buscar Cmdlets con un verbo específico

```powershell
Get-Command -Verb Get
```

### Buscar por sustantivo

```powershell
Get-Command -Noun Process
```

### ¿Por qué es útil?

Porque podemos explorar las capacidades disponibles en nuestro entorno.

```text
Problem
   ↓
Discover Commands
   ↓
Inspect Help
   ↓
Understand Parameters
   ↓
Execute
```

**Un buen ingeniero no necesita memorizar todos los comandos; necesita saber cómo descubrirlos y comprenderlos.**

---

## 📚 7. Get-Help

PowerShell proporciona un sistema de ayuda integrado.

### Consultar ayuda

```powershell
Get-Help Get-Process
```

### Consultar ejemplos

```powershell
Get-Help Get-Process -Examples
```

### Consultar información detallada

```powershell
Get-Help Get-Process -Detailed
```

### Consultar ayuda completa

```powershell
Get-Help Get-Process -Full
```

La cantidad de información disponible depende de los archivos de ayuda instalados.

En algunos entornos, la ayuda local puede ser limitada.

### Actualizar ayuda

PowerShell permite solicitar actualizaciones mediante:

```powershell
Update-Help
```

Este comando puede descargar contenido y modificar archivos de ayuda, por lo que no necesitamos ejecutarlo para completar nuestra práctica conceptual.

### Principio

Antes de copiar un comando desconocido:

1. Identifica qué hace.
2. Consulta sus parámetros.
3. Revisa ejemplos.
4. Determina si modifica el sistema.
5. Comprueba si existe una alternativa de inspección.

---

## 🧠 8. La característica fundamental: Object Pipeline

Ahora llegamos a uno de los conceptos más importantes de PowerShell.

En numerosos Shells tradicionales, los programas intercambian principalmente flujos de texto o bytes.

PowerShell, en cambio, permite que sus comandos internos transmitan **objetos .NET** mediante el Pipeline.

### ¿Qué es un objeto?

Un objeto representa información estructurada.

Puede contener:

- Propiedades.
- Valores.
- Métodos.
- Información sobre su tipo.

### Ejemplo conceptual

```text
Process Object
│
├── ProcessName
├── Id
├── CPU
└── Methods
```

### ¿Por qué es importante?

Porque podemos trabajar directamente con propiedades.

Por ejemplo, filtrar procesos según su identificador o seleccionar determinadas columnas sin tener que interpretar manualmente una tabla de texto.

---

## 🔗 9. ¿Qué es el Pipeline?

El **Pipeline** permite conectar la salida de un comando con la entrada de otro.

Se representa mediante:

```powershell
|
```

### Ejemplo

```powershell
Get-Process | Select-Object ProcessName, Id
```

### ¿Qué sucede?

```text
Get-Process
     ↓
Process Objects
     ↓
Select-Object
     ↓
Selected Properties
```

### Paso 1

`Get-Process` obtiene información sobre procesos.

### Paso 2

El Pipeline transmite los objetos.

### Paso 3

`Select-Object` selecciona propiedades.

### Resultado

Obtenemos información estructurada con las propiedades solicitadas.

### Idea fundamental

**El Pipeline de PowerShell no es simplemente una cadena de texto entre comandos internos.**

---

## 🆚 10. PowerShell Pipeline vs Unix Pipeline

Comparemos los modelos.

### Pipeline tradicional de Unix

```text
Command A
    ↓
Text / Byte Stream
    ↓
Command B
```

Por ejemplo, en Bash:

```bash
ps aux | grep node
```

Aquí `grep` busca texto dentro de la salida generada por `ps`.

### Pipeline de PowerShell

```text
Cmdlet A
    ↓
.NET Objects
    ↓
Cmdlet B
```

Por ejemplo:

```powershell
Get-Process |
    Where-Object ProcessName -EQ "node"
```

Aquí `Where-Object` evalúa una propiedad del objeto.

### Comparación

| Aspecto | Unix Shells | PowerShell |
|---|---|---|
| Intercambio habitual | Texto o bytes | Objetos .NET entre comandos compatibles |
| Filtrado | Herramientas de texto | Propiedades de objetos |
| Estructura | Depende del formato de salida | Tipos y propiedades |
| Integración con ejecutables externos | Natural mediante flujos | También mediante flujos de texto |

### Matiz importante

Cuando PowerShell ejecuta programas externos como `git` o `node`, sus salidas no se convierten automáticamente en objetos estructurados equivalentes a los de los Cmdlets.

La salida estándar de esos programas normalmente se procesa como texto en el Pipeline de PowerShell.

Por tanto, **PowerShell admite tanto flujos de objetos como integración con herramientas tradicionales de texto**.

---

## 🔬 11. Get-Member: inspeccionar objetos

¿Cómo sabemos qué propiedades tiene un objeto?

Podemos utilizar:

```powershell
Get-Process | Get-Member
```

`Get-Member` permite inspeccionar información sobre los miembros de los objetos recibidos.

Podemos encontrar:

```text
Properties
Methods
Type Information
```

### Ejemplo

```powershell
Get-Process |
    Get-Member -MemberType Property
```

### ¿Por qué es útil?

Porque nos permite descubrir cómo trabajar con la información disponible.

En lugar de adivinar el nombre de una propiedad, podemos inspeccionar el objeto.

### Modelo mental

```text
Get-Process
     ↓
Object
     ↓
Get-Member
     ↓
Available Properties and Methods
```

---

## 🎯 12. Where-Object: filtrar información

`Where-Object` permite filtrar objetos según condiciones.

### Ejemplo

```powershell
Get-Process |
    Where-Object CPU -GT 10
```

Este comando selecciona procesos cuyo valor de la propiedad `CPU` es superior a 10.

En los objetos de `Get-Process`, `CPU` representa normalmente tiempo de procesador acumulado en segundos, no un porcentaje instantáneo de utilización.

### Operadores habituales

| Operador | Significado |
|---|---|
| `-eq` | Equal |
| `-ne` | Not Equal |
| `-gt` | Greater Than |
| `-ge` | Greater Than or Equal |
| `-lt` | Less Than |
| `-le` | Less Than or Equal |
| `-like` | Pattern Matching |
| `-match` | Regular Expression Matching |

### Ejemplo con Script Block

```powershell
Get-Process |
    Where-Object { $_.ProcessName -like "node*" }
```

### ¿Qué es `$_`?

Dentro de este contexto, `$_` representa el objeto actual del Pipeline.

Podemos utilizar sus propiedades:

```powershell
$_.ProcessName
```

### Modelo conceptual

```text
Process Objects
       ↓
Where-Object
       ↓
Condition
       ↓
Matching Objects
```

---

## 🧾 13. Select-Object: seleccionar propiedades

`Select-Object` permite seleccionar propiedades de los objetos.

### Ejemplo

```powershell
Get-Process |
    Select-Object ProcessName, Id
```

### Seleccionar los primeros elementos

```powershell
Get-Process |
    Select-Object -First 5
```

### Combinar operaciones

```powershell
Get-Process |
    Where-Object { $_.ProcessName -like "node*" } |
    Select-Object ProcessName, Id
```

### Flujo

```text
Get-Process
     ↓
Where-Object
     ↓
Select-Object
     ↓
Result
```

Este patrón será importante cuando estudiemos automatización.

---

## 📊 14. Sort-Object y Measure-Object

PowerShell también permite ordenar y medir información.

### Ordenar procesos por CPU acumulada

```powershell
Get-Process |
    Sort-Object CPU -Descending |
    Select-Object -First 5 ProcessName, CPU
```

### Contar procesos

```powershell
Get-Process |
    Measure-Object
```

### Contar archivos

```powershell
Get-ChildItem -File |
    Measure-Object
```

### ¿Por qué es útil?

Porque podemos construir pequeñas consultas combinando Cmdlets.

```text
Retrieve
   ↓
Filter
   ↓
Sort
   ↓
Select
   ↓
Measure
```

Esta composición es una de las principales fortalezas de PowerShell.

---

## 📁 15. Navegación por archivos y directorios

PowerShell permite trabajar con el sistema de archivos mediante Cmdlets.

### Consultar ubicación actual

```powershell
Get-Location
```

### Listar elementos

```powershell
Get-ChildItem
```

### Cambiar de directorio

```powershell
Set-Location $HOME
```

### Consultar un archivo

```powershell
Get-Content .\README.md
```

Este último comando requiere que el archivo exista en la ubicación indicada.

### Aliases habituales

PowerShell también proporciona Alias como:

```powershell
pwd
ls
cd
```

Por ejemplo:

```powershell
ls
```

Puede resolverse a:

```powershell
Get-ChildItem
```

### Importante

Que PowerShell admita `ls` no significa que esté ejecutando necesariamente el mismo programa `ls` de Linux.

Podría estar utilizando un Alias.

Podemos investigarlo mediante:

```powershell
Get-Command ls
```

---

## 🧭 16. Rutas en PowerShell

En Windows podemos utilizar rutas como:

```text
C:\Users\developer\Projects
```

### Ruta absoluta

```powershell
Set-Location "C:\Users\developer\Projects"
```

La ruta debe existir.

### Ruta relativa

```powershell
Set-Location .\my-project
```

### Directorio padre

```powershell
Set-Location ..
```

### Directorio personal

```powershell
Set-Location $HOME
```

### ¿Por qué importa?

Porque numerosos comandos trabajan sobre el directorio actual.

Por ejemplo:

```powershell
git status
```

Y:

```powershell
pnpm install
```

pueden tener resultados diferentes dependiendo del directorio donde se ejecuten.

---

## 🌍 17. Environment Variables en PowerShell

PowerShell permite consultar variables de entorno mediante el proveedor `Env:`.

### Consultar PATH

```powershell
$env:Path
```

### Consultar directorio del usuario

```powershell
$env:USERPROFILE
```

### Consultar TEMP

```powershell
$env:TEMP
```

### Listar variables de entorno

```powershell
Get-ChildItem Env:
```

### Modificar una variable en la sesión

```powershell
$env:PROJECT_NAME = "tooling-mastery"
```

Podemos consultarla:

```powershell
$env:PROJECT_NAME
```

### ¿Es permanente?

No necesariamente.

Esta asignación modifica el entorno del proceso actual y puede ser heredada por procesos hijos.

No equivale a establecer una variable persistente para futuras sesiones de Windows.

### Importante

Debemos distinguir entre:

```text
Process Environment
User Environment
Machine Environment
```

La configuración persistente se estudiará cuando corresponda dentro de las prácticas de configuración de entornos.

---

## 🔍 18. Command Resolution en PowerShell

PowerShell puede resolver comandos mediante diferentes mecanismos.

Entre ellos:

- Aliases.
- Functions.
- Cmdlets.
- Scripts.
- Aplicaciones externas.

### Ejemplo

```powershell
Get-Command git
```

Podría mostrar una aplicación externa.

Mientras que:

```powershell
Get-Command Get-Process
```

mostrará un Cmdlet.

### Consultar todas las coincidencias

```powershell
Get-Command node -All
```

### ¿Por qué importa?

Porque una misma computadora puede tener múltiples instalaciones de Node.js.

Por ejemplo:

```text
Node.js Installation A
Node.js Installation B
```

Debemos identificar qué ejecutable se utiliza.

### Relación con PATH

`PATH` interviene en la búsqueda de ejecutables externos.

Pero no explica por sí solo toda la resolución de comandos de PowerShell.

---

## 🧮 19. Variables y tipos de datos

PowerShell permite utilizar variables.

### String

```powershell
$name = "Developer"
```

### Integer

```powershell
$age = 30
```

### Boolean

```powershell
$isReady = $true
```

### Array

```powershell
$tools = @("Git", "Node.js", "pnpm")
```

### Consultar un elemento

```powershell
$tools[0]
```

### ¿PowerShell utiliza tipos?

Sí.

PowerShell utiliza objetos y tipos de .NET.

Podemos inspeccionar el tipo de un valor:

```powershell
$name.GetType().FullName
```

### Resultado posible

```text
System.String
```

### ¿Por qué importa?

Porque las operaciones disponibles dependen del tipo de dato.

---

## 🔁 20. Condicionales y loops

PowerShell es un lenguaje de scripting.

Por tanto, admite estructuras de control.

### If

```powershell
$toolAvailable = $true

if ($toolAvailable) {
    Write-Output "Tool available"
} else {
    Write-Output "Tool unavailable"
}
```

### ForEach

```powershell
$tools = @("Git", "Node.js", "pnpm")

foreach ($tool in $tools) {
    Write-Output $tool
}
```

### For

```powershell
for ($i = 1; $i -le 3; $i++) {
    Write-Output $i
}
```

### ¿Necesitamos dominar programación PowerShell ahora?

No.

En este módulo buscamos comprender sus capacidades y aprender a utilizarlo para inspeccionar nuestro entorno.

La automatización avanzada se abordará posteriormente.

---

## 📜 21. PowerShell Scripts (.ps1)

PowerShell permite guardar instrucciones en archivos con extensión:

```text
.ps1
```

Por ejemplo:

```text
check-environment.ps1
```

### Ejemplo

```powershell
Write-Output "Development Environment"

Get-Location

git --version

node --version
```

Este Script supone que Git y Node.js están disponibles.

### ¿Cómo se ejecuta?

Desde PowerShell, en el directorio correspondiente:

```powershell
.\check-environment.ps1
```

La ejecución puede estar condicionada por políticas y controles de seguridad.

### ¿Por qué utilizar Scripts?

Porque permiten automatizar operaciones repetitivas.

Por ejemplo:

```text
Check Runtime
Check Git
Check Environment
Validate Configuration
```

---

## 🔐 22. Execution Policy

PowerShell dispone de una característica llamada **Execution Policy**.

Permite controlar determinadas condiciones relacionadas con la carga y ejecución de Scripts.

### Consultar políticas

```powershell
Get-ExecutionPolicy -List
```

### Políticas conocidas

| Política | Descripción general |
|---|---|
| Restricted | Restringe la ejecución de Scripts |
| AllSigned | Requiere firmas para Scripts sujetos a la política |
| RemoteSigned | Establece requisitos de firma para determinados Scripts descargados |
| Unrestricted | Permite una ejecución más amplia, con advertencias en ciertos casos |
| Bypass | No aplica los bloqueos ni advertencias habituales de Execution Policy |

### Matiz importante

**Execution Policy no constituye una frontera de seguridad completa.**

No debe tratarse como un mecanismo capaz de impedir cualquier ejecución de código malicioso.

Además, su comportamiento depende de la plataforma y de las políticas aplicables.

### ¿Debemos cambiarla inmediatamente?

No.

Primero debemos comprender:

- Qué Script queremos ejecutar.
- Su procedencia.
- Qué política está aplicada.
- Si existen restricciones corporativas.
- Qué alternativas están autorizadas.

### Advertencia

No debemos ejecutar comandos que desactiven controles de forma global solamente para conseguir que un Script funcione.

---

## 🧰 23. PowerShell y herramientas de desarrollo

PowerShell puede ejecutar herramientas externas utilizadas en nuestro stack.

Por ejemplo:

### Git

```powershell
git status
```

### Node.js

```powershell
node --version
```

### npm

```powershell
npm --version
```

### pnpm

```powershell
pnpm --version
```

### VS Code CLI

```powershell
code .
```

Estos comandos requieren que las herramientas correspondientes estén instaladas y disponibles.

### ¿Qué sucede internamente?

```text
PowerShell
    ↓
External Command
    ↓
Executable Resolution
    ↓
Process Execution
    ↓
Output
```

PowerShell no reemplaza estas herramientas.

Permite ejecutarlas y combinarlas con otras operaciones.

---

## 🧪 24. Práctica: PowerShell Environment Audit

Esta práctica está diseñada para inspeccionar nuestro entorno sin realizar modificaciones.

### Step 1 — PowerShell Version

```powershell
$PSVersionTable.PSVersion
```

### Step 2 — PowerShell Edition

```powershell
$PSVersionTable.PSEdition
```

### Step 3 — Current Directory

```powershell
Get-Location
```

### Step 4 — User Directory

```powershell
$HOME
```

### Step 5 — Environment Variables

```powershell
Get-ChildItem Env:
```

### Step 6 — PATH

```powershell
$env:Path -split ';'
```

### Step 7 — Git

```powershell
Get-Command git -ErrorAction SilentlyContinue
```

Si está disponible:

```powershell
git --version
```

### Step 8 — Node.js

```powershell
Get-Command node -ErrorAction SilentlyContinue
```

Si está disponible:

```powershell
node --version
```

### Step 9 — Processes

```powershell
Get-Process |
    Select-Object -First 5 ProcessName, Id
```

### Step 10 — Inspect Object Structure

```powershell
Get-Process |
    Get-Member -MemberType Property
```

### Step 11 — Execution Policy

```powershell
Get-ExecutionPolicy -List
```

### Step 12 — Document Results

| Component | Result |
|---|---|
| PowerShell Version | |
| PowerShell Edition | |
| Current Directory | |
| User Directory | |
| PATH Entries | |
| Git Resolution | |
| Node.js Resolution | |
| Execution Policy | |
| Object Pipeline Tested | |

### Reflexión

Responde:

1. ¿Qué versión de PowerShell utilizas?
2. ¿Qué edición está disponible?
3. ¿Git está instalado?
4. ¿Node.js está instalado?
5. ¿Cómo se resuelven sus comandos?
6. ¿Qué propiedades observaste en los objetos de procesos?
7. ¿Qué políticas de ejecución aparecen?
8. ¿Necesitas modificar alguna configuración?

El objetivo es aprender a inspeccionar antes de intervenir.

---

## 🛠️ 25. Troubleshooting: problemas frecuentes

### Problema A — pwsh: Command Not Found

Intentamos ejecutar:

```powershell
pwsh
```

Pero no está disponible.

**Posibles causas:**

- PowerShell moderno no está instalado.
- No está disponible mediante `PATH`.
- Existe una restricción del entorno.

### Diagnóstico

```powershell
Get-Command pwsh -ErrorAction SilentlyContinue
```

### Importante

Esto no significa que Windows PowerShell 5.1 no esté disponible.

Podemos comprobar:

```powershell
Get-Command powershell.exe -ErrorAction SilentlyContinue
```

---

### Problema B — Script Cannot Be Loaded

Intentamos ejecutar un Script `.ps1` y encontramos una restricción.

### Diagnóstico

```powershell
Get-ExecutionPolicy -List
```

Debemos revisar:

- La política efectiva.
- El origen del Script.
- La configuración corporativa.
- La confiabilidad del archivo.

No debemos cambiar indiscriminadamente la política de ejecución.

---

### Problema C — Command Works in CMD but Not PowerShell

Una herramienta funciona en CMD, pero no en PowerShell.

### Posibles causas

- Diferente resolución de comandos.
- Diferencias de sintaxis.
- Alias.
- Variables de entorno.
- Restricciones aplicables a Scripts.
- Diferencias en la sesión.

### Diagnóstico

```powershell
Get-Command tool-name -All
```

Reemplaza `tool-name` por el comando real.

También debemos inspeccionar:

```powershell
$env:Path
```

### Principio

No debemos asumir que ambos Shells ejecutan comandos de forma idéntica.

---

### Problema D — npm.ps1 Cannot Be Loaded

En determinadas instalaciones, PowerShell puede intentar ejecutar un Script asociado a npm y encontrar restricciones de Execution Policy.

### ¿Qué debemos investigar?

Primero:

```powershell
Get-Command npm -All
```

Esto permite identificar qué archivos o comandos están disponibles.

Después:

```powershell
Get-ExecutionPolicy -List
```

### ¿Cuál es la solución?

Depende de la política aplicable y del entorno.

En algunos casos existe un archivo de comando alternativo compatible con Windows, como `npm.cmd`, que puede utilizarse cuando corresponde.

No debemos desactivar globalmente las políticas de ejecución como solución automática.

---

### Problema E — Unexpected Command Output

Un comando devuelve un resultado diferente del esperado.

### Posibles causas

- Estamos ejecutando otro comando.
- Existe un Alias.
- El objeto contiene propiedades diferentes.
- El formato de salida oculta información.
- La versión de PowerShell es diferente.

### Diagnóstico

```powershell
Get-Command command-name
```

Y, cuando corresponda:

```powershell
Get-Help command-name
```

Si el comando devuelve objetos:

```powershell
command-name | Get-Member
```

Debemos sustituir `command-name` por un comando real.

---

## 🏢 26. PowerShell en equipos profesionales

PowerShell puede utilizarse para automatizar tareas de preparación y validación de entornos Windows.

Por ejemplo:

```text
Environment Validation
        ↓
Check Git
        ↓
Check Runtime
        ↓
Check Required Tools
        ↓
Report Results
```

También puede participar en:

- Scripts de desarrollo.
- Administración de equipos.
- Automatización de infraestructura.
- Procesos de CI/CD.
- Diagnósticos.
- Operaciones de mantenimiento.

### ¿Debemos utilizar PowerShell para todo?

No.

Para tareas específicas del proyecto JavaScript, podemos utilizar Scripts definidos en `package.json`.

Para automatizaciones multiplataforma, podemos evaluar alternativas compatibles con los sistemas requeridos.

Para operaciones nativas de Windows, PowerShell puede resultar especialmente adecuado.

### Principio

**Elegimos el lenguaje de automatización según el problema, la plataforma y los requisitos del equipo.**

---

## ⚠️ 27. Errores comunes

### 1. Confundir PowerShell con Windows Terminal

Cumplen responsabilidades diferentes.

### 2. Pensar que PowerShell es solamente una consola

También es un lenguaje de scripting y una plataforma de automatización.

### 3. Confundir Windows PowerShell con PowerShell moderno

Utilizan diferentes versiones y bases tecnológicas.

### 4. Pensar que todos los comandos de PowerShell son ejecutables externos

También existen Cmdlets, Functions y Aliases.

### 5. Pensar que el Pipeline transmite únicamente texto

Entre Cmdlets compatibles puede transmitir objetos .NET.

### 6. Suponer que la salida de Git se convierte automáticamente en objetos .NET estructurados

Los programas externos normalmente intercambian texto mediante sus flujos estándar.

### 7. Utilizar propiedades sin inspeccionar los objetos

Podemos consultar sus miembros mediante `Get-Member`.

### 8. Confundir CPU acumulada con porcentaje de CPU en tiempo real

Son métricas diferentes.

### 9. Modificar Execution Policy sin comprenderla

Puede introducir riesgos o incumplir políticas corporativas.

### 10. Copiar Scripts desconocidos

Debemos revisar su contenido y procedencia.

### 11. Utilizar PowerShell con privilegios elevados por costumbre

No es necesario para numerosas tareas de desarrollo.

### 12. No distinguir configuración temporal de persistente

Modificar `$env:Path` en una sesión no equivale a cambiar la configuración permanente de Windows.

---

## 🧠 28. Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es PowerShell?
2. ¿Qué problema resuelve?
3. ¿Qué diferencia existe entre PowerShell y Windows Terminal?
4. ¿Qué diferencia existe entre PowerShell y CMD?
5. ¿Qué es Windows PowerShell 5.1?
6. ¿Qué es PowerShell moderno?
7. ¿Qué es un Cmdlet?
8. ¿Qué significa Verb-Noun?
9. ¿Para qué sirve `Get-Command`?
10. ¿Para qué sirve `Get-Help`?
11. ¿Qué es un Object Pipeline?
12. ¿Qué diferencia existe entre el Pipeline de PowerShell y el tradicional de Unix?
13. ¿Qué es un objeto .NET?
14. ¿Para qué sirve `Get-Member`?
15. ¿Qué hace `Where-Object`?
16. ¿Qué hace `Select-Object`?
17. ¿Qué representa `$_`?
18. ¿Qué hace `Get-ChildItem`?
19. ¿Qué diferencia existe entre un Alias y un Cmdlet?
20. ¿Cómo consultamos variables de entorno?
21. ¿Cómo investigamos la resolución de un comando?
22. ¿Qué es un Script `.ps1`?
23. ¿Qué es Execution Policy?
24. ¿Por qué Execution Policy no es una frontera completa de seguridad?
25. ¿Qué investigarías si npm funciona en CMD, pero falla en PowerShell?
26. ¿Cómo utilizarías PowerShell para validar un Development Environment?

---

## 💡 Idea clave

PowerShell combina un Shell interactivo, un lenguaje de scripting y capacidades de automatización.

Su modelo basado en objetos permite construir operaciones estructuradas mediante Cmdlets y Pipelines.

```text
PowerShell
    │
    ├── Cmdlets
    │
    ├── Objects
    │
    ├── Pipeline
    │
    ├── Scripts
    │
    └── Automation
          ↓
    Development Environment
```

Pero PowerShell no reemplaza las herramientas que utilizamos.

Nos permite interactuar con ellas, consultar información y automatizar operaciones.

**Comprender PowerShell significa aprender a trabajar con el sistema de manera estructurada, no simplemente memorizar comandos.**

---

## 🚀 Siguiente paso

Ahora comprendemos el funcionamiento fundamental de PowerShell y su modelo basado en objetos.

El siguiente paso será estudiar **Git Bash**, una alternativa que proporciona un entorno Bash y herramientas de estilo Unix dentro de Windows.

Aprenderemos:

- Qué es Git Bash.
- Qué relación tiene con Git for Windows.
- Cómo se diferencia de PowerShell.
- Qué papel cumplen Bash y MSYS2.
- Cómo funcionan las rutas.
- Qué limitaciones presenta.
- Cuándo utilizar Git Bash y cuándo WSL.

👉 [Git Bash](./04-git-bash.md)