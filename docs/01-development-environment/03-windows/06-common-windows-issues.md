# Common Windows Issues

## Introducción

Configurar un entorno de desarrollo en Windows implica coordinar diferentes componentes:

- Windows como sistema operativo.
- Windows Terminal como aplicación de Terminal.
- PowerShell, CMD o Bash como Shells.
- Git y otras herramientas de desarrollo.
- Runtimes como Node.js.
- Package Managers como npm y pnpm.
- Variables de entorno.
- Configuraciones del usuario y del proyecto.
- WSL, cuando necesitamos trabajar con Linux.
- Redes, proxies y servicios corporativos.

Estos componentes no funcionan de manera aislada.

Una herramienta puede estar correctamente instalada, pero no encontrarse mediante `PATH`. Un comando puede funcionar en PowerShell y fallar en Git Bash. Una aplicación puede ejecutarse en Windows y no funcionar dentro de WSL.

El objetivo de este documento es desarrollar una habilidad fundamental para cualquier Software Engineer:

**Diagnosticar problemas de entorno de manera sistemática, identificando la causa antes de modificar la configuración.**

---

## 🎯 Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Aplicar una metodología sistemática de Troubleshooting.
2. Identificar en qué capa del entorno aparece un problema.
3. Diferenciar errores de instalación, configuración y ejecución.
4. Diagnosticar problemas relacionados con `PATH`.
5. Investigar conflictos entre diferentes versiones de herramientas.
6. Comprender errores relacionados con PowerShell y Execution Policy.
7. Diagnosticar problemas frecuentes de Git Bash.
8. Reconocer errores de WSL y de integración Windows–Linux.
9. Investigar problemas de permisos sin recurrir inmediatamente a privilegios elevados.
10. Identificar problemas relacionados con Node.js y Package Managers.
11. Diferenciar errores de herramientas y errores de conectividad.
12. Documentar diagnósticos y soluciones reproducibles.

---

# 1. El problema: un comando falla, pero ¿por qué?

Imagina que intentamos ejecutar:

```powershell
node --version
```

Y recibimos un mensaje indicando que `node` no se reconoce como comando.

Una reacción frecuente sería:

> Node.js está mal instalado. Voy a desinstalarlo y volverlo a instalar.

Pero esa conclusión es prematura.

El problema podría encontrarse en diferentes lugares.

```text
Developer
    │
    ▼
Windows Terminal
    │
    ▼
PowerShell
    │
    ▼
Command Resolution
    │
    ▼
PATH
    │
    ▼
Node.js Executable
    │
    ▼
Process Execution
```

Si el comando falla, debemos identificar qué componente no está funcionando como esperamos.

### Posibles causas

- Node.js no está instalado.
- Node.js está instalado, pero no aparece en `PATH`.
- Existen varias instalaciones de Node.js.
- Un gestor de versiones no está configurado correctamente.
- La Terminal conserva variables de entorno antiguas.
- Estamos ejecutando el comando en un entorno diferente.
- Existen restricciones de permisos o ejecución.

Todas estas situaciones pueden producir síntomas similares.

Sin embargo, sus soluciones son diferentes.

### Principio fundamental

**Un mismo síntoma puede tener múltiples causas. No debemos confundir el síntoma con el diagnóstico.**

---

# 2. Metodología profesional de Troubleshooting

Antes de estudiar casos concretos, estableceremos un procedimiento reutilizable.

## 2.1 Paso 1: identificar el síntoma

Debemos describir exactamente qué ocurre.

No es suficiente decir:

> Node.js no funciona.

Una descripción más útil sería:

> Al ejecutar `node --version` desde PowerShell, el sistema indica que no reconoce el comando. Sin embargo, ayer funcionaba desde Windows Terminal.

Esta descripción proporciona información relevante:

- Comando ejecutado.
- Shell utilizado.
- Mensaje recibido.
- Comportamiento anterior.

## 2.2 Paso 2: identificar el entorno

Necesitamos saber dónde estamos ejecutando el comando.

Podría ser:

```text
Windows
├── PowerShell
├── CMD
├── Git Bash
└── WSL
    └── Ubuntu
```

Cada entorno puede utilizar:

- Diferentes ejecutables.
- Diferentes variables.
- Diferentes rutas.
- Diferentes configuraciones.
- Diferentes permisos.

## 2.3 Paso 3: reproducir el problema

Debemos comprobar si el problema ocurre siempre.

Preguntas importantes:

- ¿Falla en una Terminal nueva?
- ¿Falla en todos los Shells?
- ¿Falla únicamente dentro de VS Code?
- ¿Falla en todos los proyectos?
- ¿Falla solamente en una carpeta?
- ¿Falla en Windows, WSL o ambos?

La reproducción nos permite delimitar el problema.

## 2.4 Paso 4: inspeccionar sin modificar

Primero utilizaremos comandos de consulta.

Por ejemplo:

```powershell
Get-Command node -All
```

O:

```powershell
$env:Path -split ';'
```

Todavía no necesitamos reinstalar nada.

## 2.5 Paso 5: formular una hipótesis

Ejemplo:

> Es posible que Node.js esté instalado, pero la sesión actual no tenga actualizado PATH.

Esta hipótesis debe poder comprobarse.

## 2.6 Paso 6: validar la hipótesis

Podemos abrir una nueva Terminal y repetir:

```powershell
Get-Command node -All
```

Si ahora funciona, tenemos evidencia de que el entorno de la sesión anterior era diferente.

## 2.7 Paso 7: aplicar un cambio mínimo

Si confirmamos una causa, debemos aplicar la solución menos invasiva.

Por ejemplo:

- Reiniciar una sesión de Terminal.
- Corregir una ruta concreta.
- Seleccionar la versión apropiada.
- Ajustar una configuración específica.

## 2.8 Paso 8: verificar y documentar

Después del cambio:

1. Repetimos el comando original.
2. Comprobamos que el problema desapareció.
3. Verificamos que no introdujimos otro problema.
4. Documentamos la causa y la solución.

### Flujo completo

```text
Observe Symptom
       │
       ▼
Identify Environment
       │
       ▼
Reproduce Problem
       │
       ▼
Inspect Configuration
       │
       ▼
Form Hypothesis
       │
       ▼
Validate Hypothesis
       │
       ▼
Apply Minimal Fix
       │
       ▼
Verify and Document
```

Este procedimiento es más importante que memorizar una colección de comandos.

---

# 3. Identificar correctamente el entorno

Antes de diagnosticar herramientas, debemos saber qué sistema y qué Shell estamos utilizando.

## 3.1 Consultar Windows

Desde PowerShell:

```powershell
Get-ComputerInfo |
    Select-Object WindowsProductName, WindowsVersion, OsBuildNumber
```

Este comando consulta información del sistema y puede tardar unos segundos.

También podemos utilizar:

```powershell
[System.Environment]::OSVersion
```

## 3.2 Consultar PowerShell

```powershell
$PSVersionTable
```

Nos permite identificar:

- Versión de PowerShell.
- Edición.
- Plataforma.
- Información de compatibilidad.

## 3.3 Consultar el proceso actual

```powershell
Get-Process -Id $PID |
    Select-Object ProcessName, Id, Path
```

`$PID` representa el identificador del proceso PowerShell actual.

## 3.4 Consultar Git Bash

Dentro de Git Bash:

```bash
echo "$BASH_VERSION"
```

```bash
uname -s
```

## 3.5 Consultar WSL

Desde PowerShell:

```powershell
wsl --list --verbose
```

Dentro de una distribución Linux:

```bash
cat /etc/os-release
```

### Idea importante

Antes de preguntar por qué falla una herramienta, debemos responder:

**¿En qué entorno exacto estoy ejecutándola?**

---

# 4. Problema: Command Not Found

Este es uno de los errores más frecuentes.

## 4.1 Síntoma

Ejecutamos:

```powershell
git --version
```

Pero PowerShell indica que no reconoce el comando.

## 4.2 ¿Qué significa?

Significa que PowerShell no consiguió resolver ese nombre como un comando ejecutable en el contexto actual.

No demuestra necesariamente que Git no esté instalado.

## 4.3 Diagnóstico

Primero:

```powershell
Get-Command git -All -ErrorAction SilentlyContinue
```

Si no obtenemos resultados, podemos consultar las rutas disponibles:

```powershell
$env:Path -split ';'
```

Después podemos revisar si Git for Windows aparece entre las aplicaciones instaladas utilizando los mecanismos de administración de Windows.

## 4.4 Posibles causas

| Causa | Explicación |
|---|---|
| No instalado | No existe una instalación utilizable |
| PATH incorrecto | El ejecutable no está en las rutas de búsqueda |
| Sesión antigua | La Terminal conserva un entorno anterior |
| Instalación incompleta | Faltan componentes |
| Restricciones | El entorno impide utilizar la herramienta |

## 4.5 Solución progresiva

1. Confirmar si la herramienta está instalada.
2. Identificar la ubicación del ejecutable.
3. Revisar `PATH`.
4. Abrir una nueva sesión.
5. Verificar nuevamente.

No debemos reinstalar la herramienta sin haber realizado estas comprobaciones.

---

# 5. Problema: PATH incorrecto

`PATH` es una variable de entorno que contiene directorios donde el sistema y las herramientas pueden buscar ejecutables.

## 5.1 Ejemplo conceptual

```text
PATH
│
├── C:\Windows\System32
├── C:\Program Files\Git\cmd
└── Other Directories
```

Cuando ejecutamos:

```powershell
git
```

PowerShell puede buscar un ejecutable correspondiente mediante los mecanismos de resolución de comandos.

## 5.2 Consultar PATH

```powershell
$env:Path
```

Para visualizarlo mejor:

```powershell
$env:Path -split ';'
```

## 5.3 Consultar PATH del usuario

```powershell
[Environment]::GetEnvironmentVariable(
    "Path",
    "User"
)
```

## 5.4 Consultar PATH del sistema

```powershell
[Environment]::GetEnvironmentVariable(
    "Path",
    "Machine"
)
```

### ¿Por qué son importantes estas diferencias?

Porque Windows puede construir el entorno de un proceso utilizando configuraciones de diferentes ámbitos.

```text
Machine Environment
        +
User Environment
        ↓
Process Environment
```

La composición exacta depende del proceso que inicia la sesión y de las reglas de Windows.

## 5.5 Errores frecuentes

- Eliminar entradas necesarias.
- Sobrescribir completamente PATH.
- Añadir rutas inexistentes.
- Duplicar rutas repetidamente.
- Mezclar instalaciones incompatibles.
- Configurar rutas en un ámbito incorrecto.

### Buena práctica

**Antes de modificar PATH, debemos conocer su valor actual y comprender qué entrada necesitamos cambiar.**

---

# 6. Problema: múltiples versiones de una herramienta

Imagina que tenemos dos instalaciones de Node.js.

```text
Node.js Installation A
        │
        └── Version 20

Node.js Installation B
        │
        └── Version 22
```

Ejecutamos:

```powershell
node --version
```

Y obtenemos una versión diferente de la esperada.

## 6.1 Diagnóstico

```powershell
Get-Command node -All
```

También podemos consultar:

```powershell
where.exe node
```

### Diferencia importante

En PowerShell, `where` puede ser un Alias de `Where-Object`.

Por eso utilizamos explícitamente:

```powershell
where.exe
```

cuando queremos invocar la utilidad externa de Windows.

## 6.2 ¿Qué debemos comprobar?

- Ubicación de cada ejecutable.
- Orden de resolución.
- Versión activa.
- Gestor de versiones utilizado.
- Requisitos del proyecto.

## 6.3 ¿Qué no debemos hacer?

No debemos eliminar instalaciones inmediatamente.

Primero debemos determinar cuál debería utilizar el proyecto.

### Principio

**Tener múltiples versiones instaladas no es necesariamente un problema; el problema aparece cuando no controlamos cuál se utiliza.**

---

# 7. Problema: funciona en PowerShell, pero no en Git Bash

Supongamos que Node.js funciona en PowerShell.

```powershell
node --version
```

Pero falla dentro de Git Bash.

## 7.1 ¿Por qué puede suceder?

Porque ambos Shells pueden construir o interpretar su entorno de manera diferente.

### PowerShell

```text
Windows
   ↓
PowerShell
   ↓
Windows PATH
   ↓
Node.js
```

### Git Bash

```text
Windows
   ↓
Git Bash
   ↓
Bash Environment
   ↓
PATH
   ↓
Node.js
```

## 7.2 Diagnóstico en PowerShell

```powershell
Get-Command node -All
```

## 7.3 Diagnóstico en Git Bash

```bash
command -v node
```

```bash
type -a node
```

```bash
echo "$PATH"
```

## 7.4 ¿Qué debemos comparar?

- Ruta del ejecutable.
- Versión utilizada.
- Variables de entorno.
- Configuración del Shell.
- Configuración del gestor de versiones.

## 7.5 Posibles soluciones

Dependerán del diagnóstico.

Podría ser suficiente iniciar una nueva sesión.

En otros casos será necesario corregir una configuración específica del entorno.

### Importante

No debemos asumir que una configuración de PowerShell se aplica automáticamente a Bash.

---

# 8. Problema: funciona en Windows Terminal, pero no en VS Code

Este problema puede resultar confuso.

Imagina que abrimos PowerShell desde Windows Terminal:

```powershell
node --version
```

Funciona.

Después abrimos la Terminal integrada de VS Code y ejecutamos el mismo comando.

Falla.

## 8.1 Posibles causas

- VS Code estaba abierto antes de modificar PATH.
- Utilizamos diferentes Shells.
- El perfil de Terminal es distinto.
- VS Code heredó otro entorno.
- Existe una configuración específica de la Terminal integrada.

## 8.2 Diagnóstico

Primero debemos identificar el Shell activo en ambas aplicaciones.

Después comparar:

```powershell
$PSVersionTable.PSVersion
```

```powershell
$env:Path -split ';'
```

```powershell
Get-Command node -All
```

## 8.3 ¿Qué debemos comprobar?

1. ¿Ambas sesiones utilizan PowerShell?
2. ¿Utilizan la misma versión?
3. ¿Tienen el mismo PATH?
4. ¿VS Code se abrió antes de instalar Node.js?
5. ¿Existe alguna configuración específica del Workspace?

## 8.4 Posible solución

Si el problema se debe a un entorno heredado antes de un cambio, cerrar y volver a abrir completamente VS Code puede actualizar el entorno disponible.

Pero debemos verificarlo antes de aplicar cambios adicionales.

### Principio

**La Terminal integrada de VS Code no garantiza por sí sola que todas las variables coincidan con las de otra sesión.**

---

# 9. Problema: PowerShell Execution Policy

## 9.1 Síntoma

Intentamos ejecutar:

```powershell
.\check-environment.ps1
```

Y PowerShell informa que el Script no puede cargarse debido a restricciones de ejecución.

## 9.2 ¿Qué significa?

PowerShell dispone de mecanismos de Execution Policy que pueden afectar la ejecución de Scripts.

## 9.3 Diagnóstico

```powershell
Get-ExecutionPolicy
```

Para revisar los distintos ámbitos:

```powershell
Get-ExecutionPolicy -List
```

## 9.4 Ámbitos relevantes

Podemos encontrar:

- MachinePolicy.
- UserPolicy.
- Process.
- CurrentUser.
- LocalMachine.

Estos ámbitos participan en la determinación de la política efectiva según su precedencia.

## 9.5 ¿Qué debemos evitar?

No debemos cambiar indiscriminadamente la política del sistema para conseguir ejecutar cualquier Script.

Especialmente en entornos corporativos, pueden existir políticas administradas centralmente.

## 9.6 Procedimiento recomendado

1. Identificar el Script.
2. Verificar su procedencia.
3. Consultar la política efectiva.
4. Determinar si existe una restricción corporativa.
5. Evaluar una solución autorizada y de alcance mínimo.

### Recordatorio

Execution Policy no constituye una frontera de seguridad completa.

---

# 10. Problema: npm.ps1 Cannot Be Loaded

Este es un caso particular del problema anterior.

## 10.1 Síntoma

Ejecutamos:

```powershell
npm --version
```

Y recibimos un error relacionado con:

```text
npm.ps1
```

## 10.2 ¿Por qué sucede?

En determinadas instalaciones de Node.js para Windows existen diferentes archivos que permiten invocar npm.

Por ejemplo:

```text
npm
npm.cmd
npm.ps1
```

PowerShell puede resolver el comando mediante el Script `npm.ps1`, que podría estar sujeto a Execution Policy.

## 10.3 Diagnóstico

```powershell
Get-Command npm -All
```

Después:

```powershell
Get-ExecutionPolicy -List
```

## 10.4 Alternativa específica

Cuando existe el archivo correspondiente, podemos comprobar:

```powershell
npm.cmd --version
```

### ¿Por qué puede funcionar?

Porque `npm.cmd` utiliza un mecanismo de ejecución diferente del Script PowerShell `npm.ps1`.

## 10.5 ¿Es la solución definitiva?

No necesariamente.

Depende de los requisitos del entorno.

En un equipo corporativo debemos respetar las políticas establecidas.

### Idea clave

**El problema puede estar en el mecanismo de invocación del comando, no en npm ni en Node.js.**

---

# 11. Problema: permisos insuficientes

## 11.1 Síntomas habituales

Podemos encontrar errores como:

```text
Access is denied
```

O:

```text
EACCES
```

O:

```text
EPERM
```

Aunque estos mensajes pueden aparecer en contextos distintos, frecuentemente están relacionados con operaciones no permitidas sobre determinados recursos.

## 11.2 Posibles causas

- Falta de permisos.
- Archivo bloqueado por otro proceso.
- Directorio protegido.
- Restricciones corporativas.
- Configuración incorrecta de la herramienta.
- Software de seguridad.
- Problemas de propiedad o permisos.

## 11.3 Diagnóstico

Identificar primero:

- Archivo o directorio afectado.
- Operación que falló.
- Usuario que ejecuta el proceso.
- Herramienta que realizó la operación.

### Consultar identidad

```powershell
whoami
```

### Consultar permisos de un recurso

```powershell
Get-Acl . |
    Format-List
```

Este ejemplo consulta información de control de acceso del directorio actual.

## 11.4 ¿Debemos ejecutar todo como administrador?

No.

Ejecutar herramientas con privilegios elevados puede ocultar problemas de configuración y aumentar el impacto de errores.

### Recomendación

Utilizar permisos elevados únicamente cuando una operación concreta los requiera y esté autorizada.

---

# 12. Problema: npm install requiere permisos de administrador

Imagina que ejecutamos:

```powershell
npm install
```

Y aparece un error de permisos.

## 12.1 ¿Qué debemos investigar?

Primero debemos identificar dónde intenta escribir npm.

Podría ser:

```text
Project Directory
Global Package Directory
Cache Directory
Temporary Directory
```

## 12.2 Consultar configuración

```powershell
npm config get prefix
```

```powershell
npm config get cache
```

Estos comandos requieren que npm esté disponible.

## 12.3 Posibles causas

- Directorio del proyecto protegido.
- Archivos creados con otro usuario.
- Configuración global incorrecta.
- Caché inaccesible.
- Bloqueos de archivos.

## 12.4 ¿Qué no debemos hacer?

No debemos convertir la ejecución como administrador en nuestra estrategia habitual.

Tampoco debemos cambiar permisos recursivamente sin identificar el recurso afectado.

### Principio

**La solución correcta consiste en identificar por qué la herramienta necesita escribir en una ubicación no autorizada.**

---

# 13. Problema: Git Bash interpreta incorrectamente una ruta

## 13.1 Síntoma

Un comando funciona desde PowerShell, pero falla en Git Bash al recibir una ruta.

### Ruta Windows

```text
C:\Users\developer\Projects
```

### Ruta Git Bash

```text
/c/Users/developer/Projects
```

## 13.2 ¿Qué ocurre?

Git Bash utiliza convenciones Unix-like y determinados mecanismos de conversión de rutas.

## 13.3 Diagnóstico

```bash
pwd
```

```bash
ls -la
```

Si `cygpath` está disponible:

```bash
cygpath -w "$PWD"
```

## 13.4 Posibles causas

- Ruta con formato inesperado.
- Espacios sin proteger.
- Conversión automática de argumentos.
- Herramienta externa que espera sintaxis Windows.

## 13.5 Buenas prácticas

Utilizar comillas cuando una ruta pueda contener espacios.

Por ejemplo:

```bash
cd "/c/Users/developer/My Projects"
```

La ruta debe existir.

### Precaución

No debemos modificar globalmente el comportamiento de conversión de rutas sin comprender qué aplicación está fallando.

---

# 14. Problema: errores de LF y CRLF

## 14.1 Síntoma

Un Script Bash funciona en Linux, pero falla después de editarlo desde Windows.

Podemos encontrar mensajes relacionados con caracteres inesperados o con `\r`.

## 14.2 Causa posible

Diferencias entre finales de línea.

```text
LF
\n
```

```text
CRLF
\r\n
```

## 14.3 ¿Por qué importa?

Algunas herramientas esperan una convención determinada.

## 14.4 Diagnóstico

Revisar:

- Formato del archivo en el editor.
- Configuración de Git.
- Archivo `.gitattributes`.
- Convenciones del proyecto.

### Consultar configuración Git

```powershell
git config --show-origin --get core.autocrlf
```

Si no existe un valor explícito, el comando puede no mostrar resultado.

## 14.5 Solución profesional

Definir una política consistente para los archivos del proyecto.

Por ejemplo, mediante `.gitattributes`, cuando corresponda.

No debemos cambiar indiscriminadamente todos los archivos del repositorio.

---

# 15. Problema: Git utiliza una identidad incorrecta

Este problema no pertenece directamente a PATH, pero aparece frecuentemente al preparar entornos Windows.

## 15.1 Síntoma

Realizamos un Commit y observamos un nombre o correo diferente del esperado.

## 15.2 Diagnóstico

Consultar configuración global:

```powershell
git config --global --get user.name
```

```powershell
git config --global --get user.email
```

Consultar configuración efectiva dentro del repositorio:

```powershell
git config --get user.name
```

```powershell
git config --get user.email
```

### Investigar origen

```powershell
git config --show-origin --get user.email
```

## 15.3 ¿Por qué puede suceder?

Git admite diferentes ámbitos de configuración.

```text
System
   ↓
Global
   ↓
Local Repository
```

También pueden intervenir configuraciones condicionales y otras fuentes.

## 15.4 Buena práctica

En equipos con varias identidades profesionales, debemos comprender qué identidad corresponde a cada repositorio.

No debemos modificar la identidad global si el problema afecta solamente a un proyecto.

---

# 16. Problema: WSL no inicia

## 16.1 Síntoma

Intentamos ejecutar:

```powershell
wsl
```

Pero recibimos un error relacionado con la infraestructura de WSL.

## 16.2 Posibles causas

- WSL no está instalado.
- Faltan componentes.
- Virtualización no disponible.
- Configuración incompatible.
- Restricciones corporativas.
- Distribución dañada o con problemas de inicio.

## 16.3 Diagnóstico

```powershell
wsl --status
```

```powershell
wsl --list --verbose
```

## 16.4 ¿Qué debemos comprobar?

1. ¿WSL está disponible?
2. ¿Existe una distribución instalada?
3. ¿Utiliza WSL 1 o WSL 2?
4. ¿La virtualización es compatible?
5. ¿Estamos dentro de una máquina virtual?
6. ¿Existen políticas corporativas?

## 16.5 ¿Qué debemos evitar?

No debemos eliminar una distribución como primer intento de solución.

En particular, `wsl --unregister` puede provocar la pérdida de los datos asociados a esa distribución.

---

# 17. Problema: WSL 2 y virtualización

WSL 2 utiliza tecnología de virtualización ligera.

Por ello, requiere determinadas capacidades del sistema.

## 17.1 Posibles escenarios

```text
Physical Windows Machine
        ↓
Virtualization Available
        ↓
WSL 2
```

Pero también podemos encontrarnos con:

```text
Corporate Virtual Machine
        ↓
Nested Virtualization Restrictions
        ↓
WSL 2 Cannot Start
```

## 17.2 Diagnóstico

Debemos comprobar:

- Requisitos de Windows.
- Capacidades de virtualización.
- Configuración de la máquina.
- Restricciones del entorno corporativo.

## 17.3 Recomendación

Si trabajamos en una VM corporativa, debemos consultar con el equipo de infraestructura antes de modificar configuraciones relacionadas con virtualización.

### Principio

**Un error de WSL dentro de una VM puede deberse a la infraestructura anfitriona y no a la distribución Linux.**

---

# 18. Problema: Node.js funciona en Windows, pero no en WSL

## 18.1 Síntoma

En PowerShell:

```powershell
node --version
```

Funciona.

En Ubuntu:

```bash
node --version
```

No funciona.

## 18.2 Explicación

Windows y WSL son entornos de ejecución diferentes.

Podemos tener:

```text
Windows
   └── Node.js for Windows
```

Y:

```text
WSL
   └── Node.js for Linux
```

## 18.3 Diagnóstico

Dentro de WSL:

```bash
command -v node
```

```bash
echo "$PATH"
```

## 18.4 ¿Qué debemos determinar?

Si nuestro flujo de trabajo requiere Node.js para Linux.

En ese caso debemos utilizar una instalación adecuada para ese entorno.

### Importante

No debemos asumir que encontrar un ejecutable Windows desde WSL equivale a disponer de una instalación Linux.

---

# 19. Problema: dependencias incompatibles entre Windows y WSL

## 19.1 Síntoma

Un proyecto funciona desde PowerShell, pero falla al ejecutarlo dentro de WSL.

Los errores pueden mencionar binarios o módulos incompatibles.

## 19.2 Posible causa

Las dependencias fueron instaladas para otro entorno.

Por ejemplo:

```text
Windows
   ↓
npm install
   ↓
Windows Native Dependencies
```

Después:

```text
WSL
   ↓
node application.js
   ↓
Linux Runtime
   ↓
Potential Incompatibility
```

## 19.3 ¿Por qué sucede?

Algunos paquetes utilizan:

- Binarios específicos.
- Módulos compilados.
- Dependencias del sistema operativo.
- Componentes asociados a una arquitectura.

## 19.4 Diagnóstico

Debemos identificar:

- Dónde se instalaron las dependencias.
- Qué Runtime se utilizó.
- Qué sistema operativo ejecuta el proyecto.
- Qué paquete produce el error.

## 19.5 Buena práctica

Elegir un entorno principal para instalar y ejecutar las dependencias del proyecto.

No debemos compartir indiscriminadamente directorios de dependencias generados para diferentes plataformas.

---

# 20. Problema: WSL funciona lentamente

## 20.1 Síntoma

Un proyecto tarda demasiado en instalar dependencias, ejecutar pruebas o compilar.

## 20.2 Posible causa

El proyecto está almacenado en Windows, pero se ejecuta mediante herramientas Linux dentro de WSL.

### Ejemplo

```text
/mnt/c/Users/developer/Projects/my-app
```

## 20.3 ¿Por qué importa?

Las operaciones que cruzan la frontera entre los sistemas de archivos pueden tener un coste adicional.

Esto resulta relevante para herramientas que realizan numerosas operaciones sobre archivos.

Por ejemplo:

```text
npm install
pnpm install
Build
Testing
File Watching
```

## 20.4 Diagnóstico

Dentro de WSL:

```bash
pwd
```

## 20.5 Posible solución

Si trabajamos principalmente con herramientas Linux, podemos evaluar almacenar el proyecto dentro del sistema de archivos Linux.

Por ejemplo:

```text
/home/developer/projects/my-app
```

### Precaución

Antes de mover un proyecto debemos considerar:

- Cambios sin confirmar.
- Archivos ignorados.
- Configuración local.
- Dependencias.
- Respaldos.

No debemos mover o eliminar directorios sin verificar su contenido.

---

# 21. Problema: localhost funciona en Windows, pero no en WSL

## 21.1 Síntoma

Tenemos una aplicación ejecutándose en un entorno, pero no podemos acceder desde el otro.

## 21.2 Conceptos relevantes

Debemos distinguir:

```text
127.0.0.1
```

Dirección Loopback IPv4.

Y:

```text
0.0.0.0
```

Dirección utilizada habitualmente para escuchar en todas las interfaces IPv4 disponibles.

## 21.3 Posibles causas

- Servidor no iniciado.
- Puerto incorrecto.
- Interfaz de escucha inadecuada.
- Configuración de red de WSL.
- Firewall.
- VPN.
- Conflicto de puertos.

## 21.4 Diagnóstico

Primero comprobar que la aplicación funciona dentro del entorno donde se ejecuta.

Después verificar:

1. Puerto.
2. Dirección de escucha.
3. Acceso local.
4. Integración entre Windows y WSL.
5. Restricciones de red.

## 21.5 Precaución

No debemos cambiar la aplicación para escuchar en todas las interfaces ni desactivar el Firewall sin evaluar los riesgos.

---

# 22. Problema: un puerto está ocupado

## 22.1 Síntoma

Intentamos iniciar una aplicación en el puerto 3000.

Recibimos un error como:

```text
EADDRINUSE
```

## 22.2 ¿Qué significa?

La dirección y el puerto solicitados ya están ocupados o no pueden vincularse en las condiciones solicitadas.

## 22.3 Diagnóstico desde PowerShell

```powershell
Get-NetTCPConnection -LocalPort 3000 -ErrorAction SilentlyContinue
```

Podemos observar información como:

- LocalAddress.
- LocalPort.
- State.
- OwningProcess.

## 22.4 Identificar proceso

Si obtenemos un identificador de proceso válido:

```powershell
Get-Process -Id 1234
```

Sustituimos `1234` por el identificador real.

## 22.5 ¿Qué debemos hacer?

Determinar qué aplicación utiliza el puerto.

Podríamos:

- Utilizar otro puerto.
- Detener correctamente la aplicación anterior.
- Corregir la configuración del proyecto.

### Precaución

No debemos terminar procesos desconocidos solamente porque utilizan un puerto.

---

# 23. Problema: errores de red, VPN o Proxy

## 23.1 Síntoma

Intentamos instalar dependencias:

```powershell
npm install
```

Pero la operación falla por conectividad.

## 23.2 Posibles causas

- Sin conexión a Internet.
- DNS.
- Proxy corporativo.
- VPN.
- Certificados TLS.
- Registry incorrecto.
- Problemas de autenticación.
- Servicio remoto no disponible.

## 23.3 Modelo conceptual

```text
Developer Machine
        ↓
Network Configuration
        ↓
DNS
        ↓
Proxy / VPN
        ↓
Package Registry
```

## 23.4 Diagnóstico inicial

Consultar el Registry configurado:

```powershell
npm config get registry
```

Consultar DNS de un dominio público:

```powershell
Resolve-DnsName registry.npmjs.org
```

Consultar conectividad HTTPS:

```powershell
Test-NetConnection registry.npmjs.org -Port 443
```

### ¿Qué significa cada prueba?

| Prueba | Qué investiga |
|---|---|
| Registry | Destino configurado para npm |
| DNS | Resolución del nombre |
| TCP 443 | Posibilidad de establecer una conexión TCP |

Una conexión TCP exitosa no garantiza que TLS, autenticación o descarga de paquetes funcionen correctamente.

## 23.5 En entornos corporativos

Podemos utilizar registries privados, como servicios de artefactos de la organización.

Debemos comprobar que el Registry configurado corresponde al proyecto.

### Precaución

Nunca debemos publicar Tokens, contraseñas, claves de suscripción ni archivos `.npmrc` que contengan credenciales.

Tampoco debemos desactivar la verificación TLS como solución genérica.

---

# 24. Problema: certificados TLS

## 24.1 Síntoma

Una herramienta informa errores relacionados con certificados.

Por ejemplo:

```text
CERTIFICATE_VERIFY_FAILED
```

O mensajes equivalentes.

## 24.2 Posibles causas

- Cadena de confianza incompleta.
- Certificado corporativo no reconocido.
- Proxy de inspección HTTPS.
- Configuración incorrecta de la herramienta.
- Fecha u hora incorrectas.
- Servidor remoto mal configurado.

## 24.3 ¿Qué debemos investigar?

- Herramienta afectada.
- URL del servicio.
- Entorno de red.
- Configuración corporativa.
- Certificados confiables.
- Configuración específica del Runtime.

## 24.4 ¿Qué debemos evitar?

No debemos utilizar indiscriminadamente configuraciones como:

```text
strict-ssl=false
```

Tampoco debemos desactivar verificaciones de certificados del Runtime.

### Principio

**La solución correcta consiste en establecer una cadena de confianza válida, no eliminar la verificación de confianza.**

---

# 25. Problema: antivirus o protección corporativa

En algunos equipos administrados, las herramientas de seguridad pueden bloquear operaciones.

Por ejemplo:

- Ejecución de determinados programas.
- Escritura en directorios protegidos.
- Descarga de archivos.
- Scripts.
- Procesos desconocidos.

## 25.1 ¿Cómo reconocerlo?

Debemos revisar:

- Mensaje de error.
- Registros de seguridad disponibles.
- Aplicación afectada.
- Política corporativa.
- Momento del bloqueo.

## 25.2 ¿Qué no debemos hacer?

No debemos desactivar herramientas de seguridad corporativas para conseguir ejecutar un proyecto.

## 25.3 Solución profesional

Documentar:

1. Operación bloqueada.
2. Herramienta.
3. Ruta o recurso.
4. Mensaje de error.
5. Necesidad técnica.

Después solicitar la autorización o excepción correspondiente mediante los canales de la organización.

---

# 26. Problema: herramientas instaladas globalmente

Una fuente frecuente de conflictos es instalar herramientas de forma global sin una estrategia.

Imagina:

```text
Windows
│
├── Global Node.js
├── Global npm
├── Global pnpm
├── Global TypeScript
├── Global ESLint
└── Global Build Tools
```

Después encontramos un proyecto que requiere versiones específicas.

## 26.1 ¿Qué puede ocurrir?

- Diferencias de versiones.
- Comandos que resuelven herramientas inesperadas.
- Configuraciones incompatibles.
- Resultados distintos entre desarrolladores.

## 26.2 ¿Qué debemos aprender?

Diferenciar:

```text
Machine Tools
```

de:

```text
Project Dependencies
```

Y:

```text
Runtime Management
```

de:

```text
Package Management
```

## 26.3 Recomendación

No instalar globalmente herramientas de proyecto sin una razón concreta.

En módulos posteriores aprenderemos a utilizar versiones y configuraciones declaradas por el repositorio.

---

# 27. Problema: configuración del proyecto vs configuración personal

Imagina que una aplicación funciona en nuestra computadora, pero falla en la de otro desarrollador.

## 27.1 Posibles causas

- Versiones diferentes.
- Variables de entorno faltantes.
- Herramientas globales.
- Configuración no documentada.
- Dependencias no declaradas.
- Rutas absolutas.
- Configuración personal que el proyecto presupone.

## 27.2 Modelo conceptual

```text
Developer A
    │
    └── Personal Configuration
               ↓
           Project Works
```

```text
Developer B
    │
    └── Different Configuration
               ↓
           Project Fails
```

## 27.3 ¿Cuál es el problema de fondo?

La reproducibilidad del entorno.

Un proyecto profesional debe declarar y documentar los requisitos necesarios para ejecutarlo.

## 27.4 Buena práctica

Distinguir:

- Preferencias personales.
- Requisitos compartidos.
- Configuración del proyecto.
- Secretos y credenciales.
- Dependencias del sistema.

Esto conecta directamente con los conceptos estudiados al inicio de nuestro módulo.

---

# 28. Herramientas básicas para diagnóstico

A continuación, reunimos algunos comandos útiles.

No necesitamos memorizarlos todos.

Lo importante es comprender qué información proporciona cada uno.

| Objetivo | PowerShell |
|---|---|
| Versión de PowerShell | `$PSVersionTable` |
| Directorio actual | `Get-Location` |
| Identidad actual | `whoami` |
| PATH | `$env:Path -split ';'` |
| Resolver comando | `Get-Command git -All` |
| Localizar ejecutable | `where.exe git` |
| Consultar proceso | `Get-Process` |
| Consultar puerto TCP | `Get-NetTCPConnection` |
| Consultar DNS | `Resolve-DnsName` |
| Consultar conexión TCP | `Test-NetConnection` |
| Consultar WSL | `wsl --status` |
| Listar distribuciones | `wsl -l -v` |
| Consultar política | `Get-ExecutionPolicy -List` |

### Git Bash y Linux

| Objetivo | Comando |
|---|---|
| Directorio actual | `pwd` |
| Usuario | `whoami` |
| PATH | `echo "$PATH"` |
| Resolver comando | `command -v git` |
| Mostrar coincidencias | `type -a git` |
| Consultar Shell | `echo "$BASH_VERSION"` |
| Consultar sistema | `uname -a` |
| Listar archivos | `ls -la` |
| Consultar disco | `df -h` |

### Importante

Algunos comandos dependen de:

- Versión del sistema.
- Herramientas instaladas.
- Permisos.
- Módulos disponibles.

No debemos asumir que todos están disponibles en cualquier entorno.

---

# 29. Árbol de decisiones para diagnosticar problemas

Podemos utilizar el siguiente modelo:

```text
A Development Command Fails
              │
              ▼
What Is the Error?
              │
       ┌──────┼─────────────┐
       │      │             │
       ▼      ▼             ▼
Command    Permission    Network
Not Found    Error        Error
       │      │             │
       ▼      ▼             ▼
Check      Check         Check
PATH       Identity      DNS
       │      │             │
       ▼      ▼             ▼
Check      Check         Check
Install    Resource      Registry
       │      │             │
       ▼      ▼             ▼
Check      Check         Check
Version    Policies      Proxy/TLS
       │      │             │
       └──────┼─────────────┘
              │
              ▼
       Validate Cause
              │
              ▼
       Apply Minimal Fix
              │
              ▼
       Verify and Document
```

Este árbol es una simplificación.

En problemas reales puede haber más de una causa.

Pero nos proporciona una estructura inicial para investigar.

---

# 30. Práctica: Windows Development Environment Audit

Vamos a construir un diagnóstico básico de nuestro entorno Windows.

**Esta práctica es de inspección. No requiere instalar ni modificar herramientas.**

## Step 1 — Identificar PowerShell

```powershell
$PSVersionTable
```

Anota:

- Versión.
- Edición.

## Step 2 — Identificar usuario

```powershell
whoami
```

## Step 3 — Consultar directorio actual

```powershell
Get-Location
```

## Step 4 — Consultar PATH

```powershell
$env:Path -split ';'
```

## Step 5 — Consultar Git

```powershell
Get-Command git -All -ErrorAction SilentlyContinue
```

Si está disponible:

```powershell
git --version
```

## Step 6 — Consultar Node.js

```powershell
Get-Command node -All -ErrorAction SilentlyContinue
```

Si está disponible:

```powershell
node --version
```

## Step 7 — Consultar npm

```powershell
Get-Command npm -All -ErrorAction SilentlyContinue
```

Si está disponible:

```powershell
npm.cmd --version
```

El comando anterior presupone que existe el lanzador `npm.cmd`, habitual en instalaciones de Node.js para Windows.

## Step 8 — Consultar pnpm

```powershell
Get-Command pnpm -All -ErrorAction SilentlyContinue
```

Si está disponible, identifica el mecanismo de ejecución antes de invocarlo.

## Step 9 — Consultar Execution Policy

```powershell
Get-ExecutionPolicy -List
```

## Step 10 — Consultar WSL

```powershell
wsl --list --verbose
```

Si WSL no está instalado, documenta ese resultado.

No necesitas instalarlo para completar la práctica.

## Step 11 — Consultar configuración Git

```powershell
git config --show-origin --get user.name
```

```powershell
git config --show-origin --get user.email
```

Estos comandos requieren que Git esté disponible.

## Step 12 — Documentar resultados

| Componente | Resultado | Estado |
|---|---|---|
| Windows | | |
| PowerShell | | |
| Usuario | | |
| PATH | | |
| Git | | |
| Node.js | | |
| npm | | |
| pnpm | | |
| Execution Policy | | |
| WSL | | |
| Git Identity | | |

### Interpretación

No debemos marcar automáticamente como error una herramienta que no está instalada.

Por ejemplo:

- No tener WSL puede ser perfectamente válido.
- No tener pnpm todavía puede ser correcto.
- Utilizar PowerShell 5.1 puede responder a restricciones corporativas.

El estado debe evaluarse según los requisitos reales del proyecto.

---

# 31. Práctica: diagnóstico de un problema simulado

Analicemos este escenario:

> Un desarrollador instaló Node.js. El comando funciona en PowerShell, pero no dentro de la Terminal integrada de VS Code.

## Paso 1 — Identificar el síntoma

```text
PowerShell → Works
VS Code Terminal → Fails
```

## Paso 2 — Formular hipótesis

Posibles explicaciones:

1. VS Code utiliza otro Shell.
2. VS Code heredó un PATH antiguo.
3. La configuración de Terminal es diferente.
4. Se utiliza otro ejecutable.

## Paso 3 — Recopilar evidencia

En ambas Terminales:

```powershell
$PSVersionTable
```

```powershell
$env:Path -split ';'
```

```powershell
Get-Command node -All
```

## Paso 4 — Comparar resultados

Si las sesiones utilizan el mismo Shell, pero sus valores de PATH son diferentes, tenemos una pista relevante.

## Paso 5 — Aplicar un cambio mínimo

Podemos cerrar completamente VS Code y abrirlo nuevamente para comprobar si actualiza su entorno heredado.

## Paso 6 — Verificar

```powershell
node --version
```

## Paso 7 — Documentar

```text
Symptom:
Node.js unavailable in VS Code Terminal.

Environment:
Windows + PowerShell.

Observed Difference:
PATH differed between sessions.

Hypothesis:
VS Code inherited an older environment.

Action:
Restarted VS Code.

Verification:
node --version resolved successfully.
```

### Aprendizaje

El problema no requería necesariamente reinstalar Node.js.

Requería comprender la relación entre procesos y variables de entorno.

---

# 32. Práctica: diagnóstico de WSL

Analicemos otro escenario.

> Un proyecto Node.js funciona en Windows, pero falla dentro de Ubuntu mediante WSL.

## Paso 1 — Identificar entornos

```text
Windows
   ↓
Node.js for Windows
```

```text
WSL
   ↓
Ubuntu
   ↓
Node.js for Linux
```

## Paso 2 — Consultar versiones

En Windows:

```powershell
node --version
```

En WSL:

```bash
node --version
```

## Paso 3 — Consultar ejecutables

En Windows:

```powershell
Get-Command node -All
```

En WSL:

```bash
type -a node
```

## Paso 4 — Consultar ubicación del proyecto

Dentro de WSL:

```bash
pwd
```

## Paso 5 — Formular hipótesis

Podría existir:

- Diferencia de versiones.
- Dependencia nativa incompatible.
- Instalación incompleta.
- Proyecto ubicado en un sistema de archivos poco adecuado.
- Script dependiente del sistema operativo.

## Paso 6 — Validar

Inspeccionar el error concreto.

No debemos asumir que todas las fallas dentro de WSL se deben a WSL.

## Paso 7 — Resolver

Aplicar una corrección específica según la causa.

### Aprendizaje

**La integración Windows–Linux no elimina las diferencias entre Runtimes, binarios y sistemas de archivos.**

---

# 33. Buenas prácticas profesionales

## 33.1 Inspeccionar antes de instalar

Antes de instalar una herramienta:

- Comprobar si existe.
- Consultar su versión.
- Identificar su ubicación.
- Revisar los requisitos del proyecto.

## 33.2 Evitar configuraciones duplicadas

No debemos mantener varias instalaciones sin conocer cuál utiliza cada entorno.

## 33.3 Separar configuraciones personales y del proyecto

Las preferencias individuales no deberían convertirse en dependencias ocultas del repositorio.

## 33.4 Documentar requisitos

Por ejemplo:

```text
Required Node.js Version
Required Package Manager
Required Environment Variables
Required Operating System Tools
```

## 33.5 No utilizar privilegios elevados innecesariamente

Los permisos administrativos deben utilizarse cuando estén justificados.

## 33.6 Proteger credenciales

Nunca debemos compartir:

```text
Access Tokens
Passwords
Private Keys
Registry Credentials
API Keys
```

Los diagnósticos pueden revelar información sensible.

Debemos revisar y ocultar estos valores antes de compartir Logs.

## 33.7 No desactivar mecanismos de seguridad

Evitar soluciones como:

- Desactivar TLS.
- Desactivar el Firewall.
- Desactivar antivirus.
- Modificar políticas corporativas sin autorización.

## 33.8 Aplicar cambios pequeños

Un cambio por vez facilita comprobar qué resolvió el problema.

## 33.9 Documentar soluciones

Una solución documentada reduce el tiempo de diagnóstico para todo el equipo.

## 33.10 Priorizar reproducibilidad

El objetivo no es conseguir que el proyecto funcione únicamente en nuestra computadora.

El objetivo es construir un entorno comprensible, consistente y reproducible.

---

# 34. Checklist final de Troubleshooting

Antes de considerar que un problema está resuelto, verifica:

- [ ] Identifiqué el error exacto.
- [ ] Sé en qué sistema operativo ocurre.
- [ ] Identifiqué el Shell utilizado.
- [ ] Comprobé si la herramienta está instalada.
- [ ] Consulté la versión.
- [ ] Identifiqué el ejecutable.
- [ ] Revisé PATH cuando correspondía.
- [ ] Comparé entornos si el comportamiento era diferente.
- [ ] Revisé permisos cuando correspondía.
- [ ] Revisé configuración de red si el error era de conectividad.
- [ ] Evité modificar configuraciones no relacionadas.
- [ ] Evité utilizar privilegios elevados sin necesidad.
- [ ] No expuse credenciales.
- [ ] Validé la hipótesis antes de aplicar cambios.
- [ ] Verifiqué el resultado.
- [ ] Documenté la solución.

---

# 35. Errores de razonamiento frecuentes

## Error 1 — Reinstalar sin diagnosticar

Una reinstalación puede ocultar la causa original.

## Error 2 — Confundir síntomas con causas

`Command Not Found` no significa necesariamente que la herramienta no esté instalada.

## Error 3 — Confundir Shells

PowerShell, CMD, Git Bash y WSL pueden comportarse de manera diferente.

## Error 4 — Ignorar PATH

Una instalación correcta puede resultar inaccesible por problemas de resolución.

## Error 5 — No identificar el ejecutable

Podemos ejecutar una versión diferente de la esperada.

## Error 6 — Utilizar privilegios elevados para todo

Puede introducir riesgos y ocultar problemas.

## Error 7 — Desactivar seguridad para resolver conectividad

Puede comprometer el entorno.

## Error 8 — Mezclar dependencias Windows y Linux

Puede provocar incompatibilidades.

## Error 9 — Modificar varias configuraciones simultáneamente

Dificulta identificar qué cambio resolvió el problema.

## Error 10 — No documentar

Obliga a repetir diagnósticos en el futuro.

---

# 36. Comprueba tu modelo mental

Responde las siguientes preguntas sin revisar el documento:

1. ¿Qué diferencia existe entre un síntoma y una causa?
2. ¿Por qué no debemos reinstalar inmediatamente una herramienta?
3. ¿Qué capas intervienen al ejecutar un comando?
4. ¿Qué información debemos recopilar antes de modificar el entorno?
5. ¿Qué significa `Command Not Found`?
6. ¿Qué responsabilidad cumple PATH?
7. ¿Qué diferencia existe entre PATH de usuario, máquina y proceso?
8. ¿Cómo identificamos todas las coincidencias de un comando en PowerShell?
9. ¿Por qué utilizamos `where.exe` en lugar de asumir que `where` es un ejecutable?
10. ¿Por qué podemos tener diferentes versiones de Node.js?
11. ¿Por qué un comando puede funcionar en PowerShell y fallar en Git Bash?
12. ¿Por qué VS Code puede utilizar variables de entorno diferentes?
13. ¿Qué es Execution Policy?
14. ¿Por qué `npm.ps1` puede fallar mientras `npm.cmd` funciona?
15. ¿Qué debemos investigar ante un error `EACCES`?
16. ¿Por qué no debemos utilizar siempre permisos administrativos?
17. ¿Qué diferencia existe entre las rutas de Windows y Git Bash?
18. ¿Qué problema pueden producir LF y CRLF?
19. ¿Cómo identificamos el origen de la configuración Git?
20. ¿Por qué WSL 2 puede fallar dentro de una máquina virtual corporativa?
21. ¿Por qué Node.js de Windows y Node.js de Linux son instalaciones diferentes?
22. ¿Por qué pueden fallar dependencias nativas entre Windows y WSL?
23. ¿Por qué puede ser lento trabajar en `/mnt/c` desde WSL?
24. ¿Qué significa `EADDRINUSE`?
25. ¿Cómo investigamos qué proceso utiliza un puerto?
26. ¿Qué diferencia existe entre un problema DNS y un problema TLS?
27. ¿Por qué una conexión TCP exitosa no garantiza que npm funcione?
28. ¿Por qué no debemos desactivar verificaciones de certificados?
29. ¿Qué diferencia existe entre configuración personal y configuración del proyecto?
30. ¿Qué significa aplicar un cambio mínimo?
31. ¿Cómo comprobamos que una solución realmente funcionó?
32. ¿Por qué es importante documentar los diagnósticos?

---

# 💡 Idea clave

El Troubleshooting profesional no consiste en memorizar soluciones.

Consiste en comprender el sistema y utilizar evidencia para identificar causas.

```text
Problem
   ↓
Observation
   ↓
Environment Identification
   ↓
Evidence Collection
   ↓
Hypothesis
   ↓
Validation
   ↓
Minimal Change
   ↓
Verification
   ↓
Documentation
```

Un ingeniero de software debe ser capaz de explicar no solamente **qué cambio resolvió un problema**, sino también **por qué ese cambio era necesario**.

Esa capacidad será fundamental cuando trabajemos con proyectos complejos, equipos distribuidos, monorepos, CI/CD y entornos Cloud.

---

# 🚀 Siguiente paso

Con este documento finalizamos la sección de Windows dentro de nuestro módulo **Development Environment**.

Hemos estudiado:

1. Windows Development Setup.
2. Windows Terminal.
3. PowerShell.
4. Git Bash.
5. Windows Subsystem for Linux.
6. Common Windows Issues.

Ahora continuaremos con el entorno de desarrollo en Linux, comenzando por sus fundamentos y su configuración inicial.

👉 [Linux Development Setup](../04-linux/01-linux-development-setup.md)

**Nota:** Las secciones macOS, Windows y Linux representan rutas específicas de cada sistema operativo. No es obligatorio configurar los tres entornos. Sin embargo, comprender sus diferencias ayuda a desarrollar una visión más completa de la ingeniería de software.