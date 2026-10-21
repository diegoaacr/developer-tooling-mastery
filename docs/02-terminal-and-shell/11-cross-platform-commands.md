# Cross-platform Commands

> **Developer Tooling Mastery 2026 — Module 02**
>
> **Topic 11:** Cross-platform Commands  
> **Level:** Beginner → Professional Foundations  
> **Prerequisites:** [10 — Command Chaining and Pipes](./10-command-chaining-and-pipes.md)

---

## 1. Introduction

Imagina que desarrollamos una aplicación utilizando React, TypeScript y Node.js.

Nuestro equipo tiene tres desarrolladores:

- Developer A utiliza macOS con Zsh.
- Developer B utiliza Windows con PowerShell.
- Developer C utiliza Ubuntu con Bash.

Todos trabajan sobre el mismo repositorio.

Sin embargo, cuando intentan ejecutar determinados comandos, aparecen diferencias.

En macOS:

```bash
ls -la
```

En PowerShell:

```powershell
Get-ChildItem -Force
```

Ambos permiten inspeccionar archivos, pero no utilizan exactamente el mismo modelo de comandos.

Ahora imaginemos que incorporamos un script a `package.json`:

```json
{
  "scripts": {
    "clean": "rm -rf dist"
  }
}
```

Este script puede funcionar en macOS o Linux, pero fallar en un entorno Windows donde `rm` no esté disponible como ejecutable del Shell utilizado por el gestor de paquetes.

Aquí aparece un problema importante:

**Una aplicación puede ser multiplataforma, pero sus scripts de desarrollo no necesariamente lo son.**

Nuestro objetivo será comprender estas diferencias y aprender a construir entornos de desarrollo reproducibles.

---

## 2. Learning Objectives

Al finalizar este documento podrás:

1. Diferenciar Operating System, Terminal y Shell.
2. Comprender qué significa Cross-platform Compatibility.
3. Identificar diferencias entre Bash, Zsh y PowerShell.
4. Reconocer comandos equivalentes para operaciones habituales.
5. Comprender las particularidades de Git Bash y WSL.
6. Identificar diferencias entre rutas de Windows y Unix.
7. Comprender diferencias en Environment Variables.
8. Reconocer problemas de portabilidad en scripts.
9. Utilizar Node.js para operaciones multiplataforma.
10. Comprender la relación entre Shell y Package Managers.
11. Identificar problemas de Line Endings y File Permissions.
12. Aplicar buenas prácticas para proyectos compartidos.

---

# 3. The Problem: Different Development Environments

Un proyecto puede ejecutarse en diferentes sistemas operativos.

```text
                    Software Project
                           │
              ┌────────────┼────────────┐
              │            │            │
              ▼            ▼            ▼
            macOS        Windows       Linux
              │            │            │
              ▼            ▼            ▼
             Zsh        PowerShell      Bash
              │            │            │
              └────────────┼────────────┘
                           │
                           ▼
                  Development Tools
```

Aunque todos utilicen Node.js y Git, sus Shells pueden interpretar los comandos de manera diferente.

Por ejemplo, consideremos:

```bash
export NODE_ENV=development
```

Es una sintaxis habitual de Bash/Zsh.

En PowerShell utilizaríamos:

```powershell
$env:NODE_ENV = "development"
```

La intención es similar, pero la sintaxis es diferente.

### Key Idea

**Cross-platform Development requiere distinguir entre el comportamiento de la aplicación y el comportamiento de las herramientas utilizadas para desarrollarla.**

---

# 4. Operating System vs Terminal vs Shell

Antes de continuar, recordemos tres conceptos.

## 4.1 Operating System

El sistema operativo administra recursos como:

- Procesos.
- Memoria.
- Sistema de archivos.
- Dispositivos.
- Redes.
- Permisos.

Ejemplos:

- macOS.
- Windows.
- Linux.

## 4.2 Terminal

La terminal proporciona una interfaz para interactuar con programas de línea de comandos.

Ejemplos:

- Terminal.app.
- iTerm2.
- Windows Terminal.
- Terminal integrada de VS Code.

## 4.3 Shell

El Shell interpreta las instrucciones que escribimos.

Ejemplos:

- Bash.
- Zsh.
- PowerShell.

## 4.4 Relación conceptual

```text
Developer
    │
    ▼
Terminal Emulator
    │
    ▼
Shell
    │
    ▼
Operating System
    │
    ▼
Programs and Resources
```

Este diagrama es una simplificación de la interacción.

### Key Idea

**El sistema operativo, la terminal y el Shell son componentes diferentes; conocerlos evita atribuir problemas al componente equivocado.**

---

# 5. What Is Cross-platform Compatibility?

**Cross-platform Compatibility** es la capacidad de una herramienta, aplicación o procedimiento para funcionar correctamente en diferentes plataformas compatibles.

Por ejemplo, una aplicación Node.js puede ejecutarse en:

```text
macOS
Windows
Linux
```

Pero eso no significa que cualquier comando de terminal funcione de la misma manera.

Consideremos:

```bash
rm -rf dist
```

Es una instrucción habitual en Shells Unix-like.

En PowerShell existe:

```powershell
Remove-Item -Recurse -Force dist
```

Aunque ambas operaciones pueden eliminar un directorio, no tienen sintaxis ni semántica idénticas.

Además, ambas son destructivas y deben utilizarse únicamente cuando conocemos el destino.

### Key Idea

**Compatibilidad multiplataforma no significa que todos los sistemas utilicen los mismos comandos.**

---

# 6. Bash vs Zsh vs PowerShell

Estos son tres de los Shells más relevantes para nuestro aprendizaje.

| Characteristic | Bash | Zsh | PowerShell |
|---|---|---|---|
| Uso habitual | Linux, macOS, WSL | macOS, Linux | Windows, macOS, Linux |
| Modelo principal de Pipeline | Texto/bytes | Texto/bytes | Objetos entre Cmdlets |
| Variables de Shell | `name=value` | `name=value` | `$name = value` |
| Variables de entorno | `export NAME=value` | `export NAME=value` | `$env:NAME = "value"` |
| Listar directorios | `ls` | `ls` | `Get-ChildItem` |
| Navegación | `cd` | `cd` | `Set-Location` |
| Funciones | Sintaxis de Shell Unix | Sintaxis de Shell Unix | Sintaxis PowerShell |

PowerShell es multiplataforma en sus versiones modernas, aunque algunos comandos y módulos dependen del sistema operativo.

### Key Idea

**El Shell determina la sintaxis y parte del comportamiento de los comandos, incluso cuando utilizamos el mismo sistema operativo.**

---

# 7. Cross-platform Command Reference

Veamos equivalencias habituales.

| Operation | Bash / Zsh | PowerShell |
|---|---|---|
| Mostrar directorio actual | `pwd` | `Get-Location` |
| Listar archivos | `ls` | `Get-ChildItem` |
| Cambiar directorio | `cd folder` | `Set-Location folder` |
| Crear directorio | `mkdir folder` | `New-Item -ItemType Directory folder` |
| Crear archivo vacío | `touch file.txt` | `New-Item -ItemType File file.txt` |
| Leer archivo | `cat file.txt` | `Get-Content file.txt` |
| Copiar archivo | `cp a.txt b.txt` | `Copy-Item a.txt b.txt` |
| Mover archivo | `mv a.txt b.txt` | `Move-Item a.txt b.txt` |
| Eliminar archivo | `rm file.txt` | `Remove-Item file.txt` |
| Buscar texto | `grep "text" file.txt` | `Select-String -Pattern "text" -Path file.txt` |
| Buscar archivos | `find . -name "*.js"` | `Get-ChildItem -Recurse -Filter "*.js"` |
| Mostrar procesos | `ps aux` | `Get-Process` |
| Detener proceso | `kill PID` | `Stop-Process -Id PID` |
| Mostrar variable de entorno | `echo "$PATH"` | `$env:Path` |
| Consultar ubicación de comando | `command -v node` | `Get-Command node` |

**Importante:** esta tabla representa equivalencias de propósito, no sustituciones exactas. Las opciones, el tratamiento de errores y los tipos de resultados pueden variar.

---

# 8. Navigation Commands

Navegar por el sistema de archivos es una operación común.

## Bash / Zsh

```bash
pwd
ls
cd projects
```

## PowerShell

```powershell
Get-Location
Get-ChildItem
Set-Location projects
```

PowerShell también ofrece Alias como:

```powershell
pwd
ls
cd
```

Sin embargo, debemos comprender que estos nombres pueden resolver a Cmdlets de PowerShell.

Por ejemplo:

```powershell
Get-Command ls
```

Puede mostrar que `ls` es un Alias de `Get-ChildItem`.

Esto no significa que acepte todas las opciones del ejecutable `ls` de Unix.

### Key Idea

**Dos comandos pueden compartir nombre y producir resultados similares sin tener la misma implementación.**

---

# 9. File Operations

Las operaciones de archivos también presentan diferencias.

## Create Directory

Bash/Zsh:

```bash
mkdir my-project
```

PowerShell:

```powershell
New-Item -ItemType Directory -Path my-project
```

## Copy File

Bash/Zsh:

```bash
cp source.txt destination.txt
```

PowerShell:

```powershell
Copy-Item source.txt destination.txt
```

## Move File

Bash/Zsh:

```bash
mv source.txt destination.txt
```

PowerShell:

```powershell
Move-Item source.txt destination.txt
```

## Delete File

Bash/Zsh:

```bash
rm example.txt
```

PowerShell:

```powershell
Remove-Item example.txt
```

## Professional Consideration

En proyectos compartidos, debemos evitar introducir comandos destructivos dependientes de una plataforma cuando existen alternativas más seguras y portables.

### Key Idea

**La equivalencia de operaciones no garantiza compatibilidad de opciones, rutas ni comportamiento ante errores.**

---

# 10. Path Differences

Los sistemas operativos utilizan diferentes convenciones para representar rutas.

## Unix-like Systems

```text
/home/developer/projects
```

```text
/Users/developer/projects
```

## Windows

```text
C:\Users\Developer\projects
```

## Main Difference

Unix utiliza habitualmente:

```text
/
```

Windows utiliza tradicionalmente:

```text
\
```

Aunque muchas herramientas de Windows también aceptan `/` en determinados contextos.

## Example

macOS:

```bash
cd ~/projects
```

PowerShell:

```powershell
Set-Location "$HOME\projects"
```

### Key Idea

**No debemos construir rutas multiplataforma suponiendo que todos los sistemas utilizan los mismos separadores.**

---

# 11. Case Sensitivity

Otro aspecto importante es la sensibilidad a mayúsculas y minúsculas.

Consideremos:

```text
Components/
```

Y:

```text
components/
```

En sistemas de archivos sensibles a mayúsculas, pueden representar directorios diferentes.

En otros, pueden referirse al mismo directorio.

## 11.1 ¿Por qué importa?

Imaginemos un import:

```javascript
import Button from "./Components/Button.js";
```

Pero el directorio real se llama:

```text
components/
```

Puede funcionar en un entorno y fallar en otro.

## 11.2 ¿Qué recomendamos?

Utilizar nombres consistentes y respetar exactamente las mayúsculas y minúsculas.

## 11.3 ¿Todos los macOS son case-insensitive?

No.

Depende del sistema de archivos y su configuración.

### Key Idea

**La sensibilidad a mayúsculas es una propiedad del sistema de archivos, no una regla universal del sistema operativo.**

---

# 12. Environment Variables

Las variables de entorno son fundamentales para configurar aplicaciones.

Pero su sintaxis cambia según el Shell.

## Bash / Zsh

```bash
export NODE_ENV=development
```

Consultar:

```bash
echo "$NODE_ENV"
```

## PowerShell

```powershell
$env:NODE_ENV = "development"
```

Consultar:

```powershell
$env:NODE_ENV
```

## 12.1 Inline Environment Variables

En Bash/Zsh podemos ejecutar:

```bash
NODE_ENV=development node app.js
```

Esto proporciona la variable al comando invocado.

La misma sintaxis no funciona de manera equivalente en PowerShell.

## 12.2 ¿Por qué importa?

Porque muchos scripts de Node.js utilizan variables de entorno.

### Key Idea

**Las variables de entorno son un concepto multiplataforma, pero su sintaxis de asignación depende del Shell.**

---

# 13. PATH Across Platforms

Recordemos que `PATH` permite localizar ejecutables.

Pero también presenta diferencias.

## Unix-like

Las entradas suelen separarse mediante:

```text
:
```

Ejemplo:

```text
/usr/local/bin:/usr/bin:/bin
```

## Windows

Las entradas suelen separarse mediante:

```text
;
```

Ejemplo:

```text
C:\Program Files\nodejs;C:\Windows\System32
```

## 13.1 ¿Por qué importa?

Porque copiar directamente una configuración de `PATH` entre sistemas puede producir errores.

## 13.2 ¿Debemos modificar PATH constantemente?

No.

Los gestores de versiones y herramientas de instalación suelen proporcionar mecanismos específicos para configurar sus ejecutables.

### Key Idea

**PATH cumple una responsabilidad similar en diferentes plataformas, pero sus convenciones y mecanismos de configuración varían.**

---

# 14. Git Bash

**Git Bash** es un entorno para Windows que proporciona Bash y un conjunto de herramientas compatibles con un estilo de trabajo Unix-like.

Suele instalarse junto con Git for Windows.

Permite ejecutar comandos como:

```bash
ls
```

```bash
pwd
```

```bash
grep
```

## 14.1 ¿Git Bash convierte Windows en Linux?

No.

Seguimos trabajando sobre Windows.

## 14.2 ¿Qué ventajas ofrece?

- Familiaridad con Bash.
- Comandos Unix-like.
- Integración con Git.
- Uso de scripts Bash compatibles con el entorno disponible.

## 14.3 ¿Qué limitaciones existen?

No todos los comportamientos de Linux están disponibles.

Pueden aparecer diferencias relacionadas con:

- Rutas.
- Permisos.
- Procesos.
- Herramientas del sistema.
- Conversión de argumentos.
- Dependencias nativas.

### Key Idea

**Git Bash proporciona una experiencia Bash sobre Windows, pero no equivale a ejecutar una distribución Linux completa.**

---

# 15. Windows Subsystem for Linux — WSL

**WSL** permite ejecutar un entorno Linux en Windows.

Con WSL 2, las distribuciones utilizan un kernel Linux dentro de una arquitectura virtualizada ligera.

## Conceptual Model

```text
Windows
   │
   ▼
WSL 2
   │
   ▼
Linux Distribution
   │
   ▼
Bash / Linux Tools
   │
   ▼
Development Applications
```

## 15.1 ¿Para qué sirve?

Permite trabajar con:

- Herramientas Linux.
- Bash.
- Node.js instalado en Linux.
- Gestores de paquetes Linux.
- Utilidades de desarrollo.
- Entornos similares a servidores Linux.

## 15.2 ¿WSL es lo mismo que Git Bash?

No.

Git Bash proporciona herramientas Bash sobre Windows.

WSL ejecuta un entorno Linux.

## 15.3 ¿Por qué es importante para Backend y DevOps?

Porque muchas herramientas e infraestructuras de producción se ejecutan sobre Linux.

### Key Idea

**WSL proporciona un entorno Linux real dentro de Windows, mientras que Git Bash ofrece una capa de herramientas Unix-like.**

---

# 16. Windows Paths in WSL

Dentro de WSL encontramos rutas Linux.

Por ejemplo:

```bash
/home/developer/projects
```

Pero también podemos acceder a unidades de Windows mediante rutas como:

```bash
/mnt/c/Users/Developer
```

En configuraciones habituales de WSL.

## 16.1 ¿Dónde conviene guardar proyectos?

Cuando trabajamos principalmente con herramientas Linux dentro de WSL, suele ser recomendable mantener los proyectos dentro del sistema de archivos Linux.

Por ejemplo:

```text
/home/developer/projects
```

Esto puede evitar determinados problemas de rendimiento y compatibilidad.

## 16.2 ¿Podemos acceder a archivos de Windows?

Sí.

Pero debemos comprender que las operaciones entre ambos sistemas de archivos pueden tener características diferentes.

### Key Idea

**En WSL debemos elegir conscientemente dónde almacenamos los proyectos y desde qué entorno ejecutamos las herramientas.**

---

# 17. Native Windows vs WSL Tooling

Imaginemos que tenemos Node.js instalado en Windows y también dentro de WSL.

```text
Windows
   │
   └── Node.js Installation A

WSL
   │
   └── Node.js Installation B
```

Son entornos de ejecución diferentes.

## 17.1 ¿Qué ocurre si ejecutamos node?

Dependerá del Shell y del `PATH` correspondiente.

## 17.2 ¿Comparten automáticamente las mismas dependencias globales?

No debemos asumirlo.

## 17.3 ¿Podemos mezclar node_modules entre ambos entornos?

No es una práctica recomendable.

Algunas dependencias incluyen binarios nativos o archivos específicos de la plataforma.

## 17.4 ¿Qué recomendamos?

Mantener consistente el entorno utilizado para:

- Instalar dependencias.
- Ejecutar Scripts.
- Compilar.
- Ejecutar pruebas.

### Key Idea

**Windows y WSL pueden coexistir en una misma computadora, pero debemos tratarlos como entornos de desarrollo diferenciados.**

---

# 18. Line Endings — LF vs CRLF

Los archivos de texto contienen caracteres que representan los saltos de línea.

Dos convenciones conocidas son:

```text
LF
```

Y:

```text
CRLF
```

## 18.1 LF

Utiliza Line Feed.

Es habitual en Unix-like.

## 18.2 CRLF

Utiliza Carriage Return + Line Feed.

Es tradicional en Windows.

## 18.3 ¿Por qué importa?

Porque determinadas herramientas y scripts pueden verse afectados.

Por ejemplo, un Script Bash con finales de línea incompatibles puede presentar errores.

## 18.4 ¿Qué herramientas ayudan?

- Git.
- EditorConfig.
- VS Code.
- Prettier, cuando corresponde.

## 18.5 Ejemplo de EditorConfig

```ini
root = true

[*]
end_of_line = lf
insert_final_newline = true
```

Esto establece una convención para los archivos compatibles con EditorConfig.

### Key Idea

**Los Line Endings forman parte de la consistencia técnica de un repositorio multiplataforma.**

---

# 19. File Permissions

En sistemas Unix-like existen permisos como:

```text
Read
Write
Execute
```

Podemos consultar permisos con:

```bash
ls -l
```

Y, cuando corresponde, modificar el permiso de ejecución:

```bash
chmod +x script.sh
```

## 19.1 ¿Qué ocurre en Windows?

Windows utiliza un modelo de permisos diferente, basado principalmente en ACLs y otros mecanismos.

## 19.2 ¿Por qué importa?

Porque un Script puede tener permiso de ejecución en Linux, pero no en otro entorno.

## 19.3 ¿Qué relación tiene con Git?

Git puede registrar el bit de ejecutabilidad de archivos compatibles.

## 19.4 ¿Qué recomendamos?

Definir correctamente los permisos de los scripts versionados y comprobar su funcionamiento en los sistemas de destino.

### Key Idea

**Los permisos de ejecución y sus representaciones no son idénticos entre Windows y Unix-like.**

---

# 20. Executable Extensions

Windows utiliza extensiones como:

```text
.exe
.cmd
.bat
.ps1
```

Los sistemas Unix-like no dependen de una extensión específica para determinar si un archivo puede ejecutarse.

## 20.1 Ejemplo

En Windows podemos encontrar:

```text
node.exe
```

Mientras que en macOS/Linux podemos encontrar:

```text
node
```

## 20.2 ¿Qué es PATHEXT?

En Windows, `PATHEXT` participa en la resolución de determinados tipos de archivos ejecutables.

## 20.3 ¿Qué ocurre con los Scripts?

Su ejecución depende del intérprete, los permisos y el entorno.

### Key Idea

**La identificación y ejecución de programas depende de convenciones específicas de cada plataforma.**

---

# 21. Shebang

En sistemas Unix-like, los scripts pueden comenzar con una línea llamada **Shebang**.

Ejemplo:

```bash
#!/usr/bin/env bash
```

Esta línea permite indicar el intérprete que debe utilizarse cuando el sistema ejecuta el archivo mediante los mecanismos compatibles.

## 21.1 Ejemplo completo

```bash
#!/usr/bin/env bash

echo "Hello Developer"
```

## 21.2 ¿Por qué utilizar `/usr/bin/env bash`?

Permite localizar `bash` mediante el entorno disponible, en lugar de fijar directamente una ruta concreta al intérprete.

## 21.3 ¿Garantiza compatibilidad con Windows?

No.

Depende del entorno desde el cual ejecutamos el Script.

### Key Idea

**El Shebang ayuda a seleccionar un intérprete en sistemas compatibles, pero no convierte automáticamente un Script en multiplataforma.**

---

# 22. Package Scripts and Portability

En proyectos Node.js utilizamos scripts declarados en `package.json`.

Ejemplo:

```json
{
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "test": "vitest"
  }
}
```

Podemos ejecutarlos mediante:

```bash
pnpm dev
```

```bash
pnpm build
```

```bash
pnpm test
```

## 22.1 ¿Son siempre multiplataforma?

No necesariamente.

Depende de los comandos que contienen.

Por ejemplo:

```json
{
  "scripts": {
    "clean": "rm -rf dist"
  }
}
```

Puede depender de herramientas Unix-like.

## 22.2 ¿Qué ventaja ofrecen los Package Scripts?

Proporcionan una interfaz de comandos documentada dentro del proyecto.

## 22.3 ¿Qué debemos revisar?

- Sintaxis del Shell.
- Variables de entorno.
- Rutas.
- Dependencias.
- Herramientas externas.
- Versiones de Node.js.

### Key Idea

**Un Package Script proporciona una interfaz compartida, pero su portabilidad depende de su implementación.**

---

# 23. Node.js as a Cross-platform Tool

Node.js proporciona APIs que permiten realizar muchas operaciones sin depender directamente de comandos específicos del Shell.

Por ejemplo, podemos utilizar:

```javascript
import { mkdir } from "node:fs/promises";

await mkdir("dist", { recursive: true });
```

Esto permite crear un directorio mediante una API de Node.js.

## 23.1 Ejemplo con rutas

```javascript
import path from "node:path";

const outputPath = path.join("dist", "assets");

console.log(outputPath);
```

`path.join()` utiliza convenciones de rutas apropiadas para la plataforma donde se ejecuta Node.js.

## 23.2 ¿Por qué es útil?

Porque podemos encapsular operaciones de archivos utilizando APIs multiplataforma.

## 23.3 ¿Significa que todo Script Node.js es portable?

No.

Podemos introducir dependencias específicas del sistema operativo incluso utilizando Node.js.

### Key Idea

**Node.js ofrece APIs multiplataforma, pero debemos utilizarlas correctamente y evitar dependencias innecesarias del sistema.**

---

# 24. Example: Cross-platform Clean Script

Imaginemos que queremos eliminar el directorio generado por un Build.

Una alternativa es crear un Script Node.js.

Archivo:

```text
scripts/clean.mjs
```

Contenido:

```javascript
import { rm } from "node:fs/promises";

await rm("dist", {
  recursive: true,
  force: true,
});

console.log("Build output removed");
```

En `package.json`:

```json
{
  "scripts": {
    "clean": "node scripts/clean.mjs"
  }
}
```

Después:

```bash
pnpm clean
```

## 24.1 ¿Qué ventaja ofrece?

No necesitamos depender de `rm -rf` como comando externo.

## 24.2 Precaución

El Script elimina el directorio `dist` relativo al directorio de trabajo del proceso.

Debemos ejecutarlo únicamente en el contexto esperado y validar las rutas cuando se utilicen entradas variables.

## 24.3 ¿Es la única alternativa?

No.

También existen herramientas especializadas para operaciones multiplataforma.

### Key Idea

**Para automatizaciones compartidas, las APIs de Node.js pueden reducir diferencias entre Shells.**

---

# 25. Cross-platform Environment Variables in Scripts

Consideremos:

```json
{
  "scripts": {
    "start": "NODE_ENV=production node server.js"
  }
}
```

Esta sintaxis es habitual en entornos Unix-like.

Pero puede fallar cuando el gestor de paquetes ejecuta scripts mediante `cmd.exe` en Windows.

## 25.1 Alternativa: cross-env

Una herramienta conocida es `cross-env`.

Permite expresar asignaciones de variables de entorno de manera más portable.

Ejemplo conceptual:

```json
{
  "scripts": {
    "start": "cross-env NODE_ENV=production node server.js"
  }
}
```

Esto requiere instalar y declarar la dependencia correspondiente.

## 25.2 ¿Siempre necesitamos cross-env?

No.

Depende de:

- Versión de Node.js.
- Herramientas utilizadas.
- Shell.
- Necesidades del proyecto.

## 25.3 ¿Qué recomendamos?

Preferir mecanismos nativos o herramientas declaradas que resuelvan el problema real de portabilidad.

### Key Idea

**Las variables de entorno suelen ser una de las principales fuentes de incompatibilidad en Package Scripts.**

---

# 26. Shell Dependencies

Un Script puede depender de programas externos.

Por ejemplo:

```bash
grep
```

```bash
sed
```

```bash
awk
```

Estas herramientas son habituales en Unix-like, pero no debemos asumir que estarán disponibles en todos los entornos Windows.

## 26.1 ¿Qué ocurre con Git Bash?

Puede proporcionar algunas de estas herramientas.

## 26.2 ¿Qué ocurre con WSL?

Podemos utilizarlas si están disponibles dentro de la distribución Linux.

## 26.3 ¿Qué ocurre con PowerShell?

Ofrece herramientas propias que pueden cumplir funciones equivalentes.

### Key Idea

**La portabilidad también depende de las herramientas instaladas, no solamente de la sintaxis del Shell.**

---

# 27. Cross-platform Development Strategy

Podemos establecer una estrategia profesional.

## Level 1 — Understand the Environment

Identificar:

- Sistema operativo.
- Shell.
- Versión de Node.js.
- Package Manager.
- Herramientas instaladas.

## Level 2 — Standardize Versions

Utilizar mecanismos para definir versiones compatibles.

Por ejemplo:

- `.nvmrc`.
- `.node-version`.
- `packageManager` en `package.json`.
- Gestores como Mise.

Los estudiaremos en módulos posteriores.

## Level 3 — Prefer Portable Scripts

Evitar dependencias innecesarias del Shell.

## Level 4 — Document Requirements

Explicar cómo preparar y ejecutar el proyecto.

## Level 5 — Validate Multiple Platforms

Cuando el proyecto lo requiera, ejecutar pruebas en los sistemas operativos soportados.

### Key Idea

**La compatibilidad multiplataforma se diseña y valida; no debe asumirse automáticamente.**

---

# 28. CI/CD and Cross-platform Testing

En proyectos profesionales podemos utilizar sistemas de CI/CD.

Por ejemplo, GitHub Actions permite ejecutar trabajos en diferentes sistemas operativos.

Modelo conceptual:

```text
Git Repository
      │
      ▼
CI Pipeline
      │
      ├── Linux Runner
      ├── Windows Runner
      └── macOS Runner
      │
      ▼
Build and Tests
```

## 28.1 ¿Por qué es útil?

Porque podemos detectar problemas que no aparecen en nuestra computadora.

## 28.2 ¿Debemos probar siempre en los tres sistemas?

No necesariamente.

Depende de las plataformas oficialmente soportadas por el proyecto.

## 28.3 ¿Qué problemas podemos detectar?

- Diferencias de rutas.
- Line Endings.
- Dependencias nativas.
- Comandos incompatibles.
- Permisos.
- Sensibilidad a mayúsculas.

### Key Idea

**La automatización permite verificar la compatibilidad en lugar de depender únicamente de pruebas manuales.**

---

# 29. Common Mistakes

### Mistake 1 — Confundir Terminal con Shell

La terminal proporciona la interfaz; el Shell interpreta comandos.

### Mistake 2 — Pensar que todos los comandos funcionan igual

La sintaxis y las opciones pueden cambiar.

### Mistake 3 — Suponer que Git Bash es Linux

Es un entorno Bash sobre Windows.

### Mistake 4 — Suponer que WSL es lo mismo que Git Bash

WSL proporciona un entorno Linux.

### Mistake 5 — Mezclar instalaciones de Node.js

Puede producir diferencias de versiones y dependencias.

### Mistake 6 — Compartir node_modules entre plataformas

Puede causar incompatibilidades con dependencias nativas.

### Mistake 7 — Ignorar Case Sensitivity

Puede provocar errores de imports.

### Mistake 8 — Ignorar Line Endings

Puede afectar scripts y herramientas.

### Mistake 9 — Suponer que un Package Script es automáticamente portable

Depende de los comandos internos.

### Mistake 10 — Utilizar rutas absolutas personales

Dificulta la reproducción del proyecto.

### Mistake 11 — Ignorar permisos de ejecución

Puede impedir ejecutar scripts en Unix-like.

### Mistake 12 — No documentar requisitos

Complica la incorporación de nuevos desarrolladores.

---

# 30. Practice 01 — Identify Your Environment

**Objective:** reconocer el sistema operativo y Shell.

## Bash / Zsh

```bash
echo "$SHELL"
```

```bash
uname -s
```

La variable `SHELL` suele indicar el Shell configurado para el usuario, no necesariamente el proceso de Shell actual.

## PowerShell

```powershell
$PSVersionTable
```

```powershell
[System.Runtime.InteropServices.RuntimeInformation]::OSDescription
```

## Questions

1. ¿Qué sistema operativo utilizas?
2. ¿Qué Shell estás ejecutando?
3. ¿Qué versión de PowerShell tienes, si corresponde?
4. ¿Qué diferencias existen entre estos conceptos?

---

# 31. Practice 02 — Compare Commands

Realiza las siguientes operaciones en tu Shell:

1. Mostrar el directorio actual.
2. Listar archivos.
3. Crear un directorio.
4. Crear un archivo.
5. Leer el archivo.
6. Copiarlo.
7. Renombrarlo.
8. Eliminar únicamente los archivos de práctica.

Utiliza la tabla de equivalencias de este documento.

## Reflection

- ¿Qué comandos tienen el mismo nombre?
- ¿Cuáles utilizan sintaxis diferente?
- ¿Qué operaciones requieren especial cuidado?
- ¿Qué comandos son propios de tu Shell?

---

# 32. Practice 03 — Environment Variables

## Bash / Zsh

```bash
export MASTERY_ENV=development
```

```bash
echo "$MASTERY_ENV"
```

## PowerShell

```powershell
$env:MASTERY_ENV = "development"
```

```powershell
$env:MASTERY_ENV
```

## Questions

1. ¿Qué diferencia existe entre las sintaxis?
2. ¿La variable persiste después de cerrar la sesión?
3. ¿Qué ocurre cuando iniciamos un proceso hijo?
4. ¿Por qué es importante para Node.js?

---

# 33. Practice 04 — Node.js Cross-platform Script

**Requirement:** Node.js instalado.

Crea:

```text
cross-platform-practice/
├── package.json
└── scripts/
    └── create-directory.mjs
```

Contenido de `create-directory.mjs`:

```javascript
import { mkdir } from "node:fs/promises";
import path from "node:path";

const target = path.join("output", "assets");

await mkdir(target, {
  recursive: true,
});

console.log(`Created: ${target}`);
```

En `package.json`:

```json
{
  "scripts": {
    "prepare:directory": "node scripts/create-directory.mjs"
  }
}
```

Ejecuta:

```bash
npm run prepare:directory
```

## Questions

1. ¿Qué hace `mkdir()`?
2. ¿Qué hace `path.join()`?
3. ¿Por qué no utilizamos directamente `mkdir -p`?
4. ¿Qué ventaja tiene declarar el Script en `package.json`?

---

# 34. Practice 05 — Evaluate Script Portability

Analiza estos scripts:

```json
{
  "scripts": {
    "clean": "rm -rf dist",
    "build": "vite build",
    "start": "NODE_ENV=production node server.js",
    "test": "vitest"
  }
}
```

Para cada uno, responde:

1. ¿Depende de un comando externo?
2. ¿Depende de una sintaxis específica del Shell?
3. ¿Requiere una dependencia instalada?
4. ¿Funcionará igual en Windows y macOS?
5. ¿Cómo mejorarías su portabilidad?

## Expected Learning

Comprender que una interfaz compartida no garantiza por sí sola un comportamiento multiplataforma.

---

# 35. Real-world Engineering Scenarios

## Scenario 1 — macOS and Windows Developers

Un equipo utiliza el mismo repositorio, pero diferentes Shells.

**Solution:** documentar comandos compatibles y declarar scripts reproducibles.

## Scenario 2 — Node.js Native Dependencies

Una dependencia funciona en macOS pero falla en Windows.

**Solution:** revisar compatibilidad de plataforma y reinstalar dependencias en el entorno correspondiente.

## Scenario 3 — WSL Development

Un desarrollador utiliza Node.js dentro de WSL.

**Solution:** mantener consistentes la instalación, los scripts y el sistema de archivos utilizado.

## Scenario 4 — CI Fails on Linux

Una aplicación funciona localmente pero falla por diferencias de mayúsculas en imports.

**Solution:** corregir rutas y validar el repositorio en el entorno de destino.

## Scenario 5 — Windows Package Script Fails

Un script utiliza una asignación Unix-like de variables de entorno.

**Solution:** adoptar un mecanismo compatible con los entornos soportados.

---

# 36. Knowledge Check

1. ¿Qué significa Cross-platform Compatibility?
2. ¿Cuál es la diferencia entre Operating System y Shell?
3. ¿Qué es Bash?
4. ¿Qué es Zsh?
5. ¿Qué es PowerShell?
6. ¿Por qué `ls` puede representar cosas diferentes?
7. ¿Qué es Git Bash?
8. ¿Qué es WSL?
9. ¿Cuál es la diferencia entre Git Bash y WSL?
10. ¿Qué diferencias existen entre rutas Windows y Unix?
11. ¿Qué significa Case Sensitivity?
12. ¿Qué son LF y CRLF?
13. ¿Qué es un File Permission?
14. ¿Qué es un Shebang?
15. ¿Qué es PATHEXT?
16. ¿Cómo se definen variables de entorno en Bash?
17. ¿Cómo se definen en PowerShell?
18. ¿Qué diferencias existen en PATH?
19. ¿Por qué un Package Script puede fallar en Windows?
20. ¿Qué ventajas ofrecen las APIs de Node.js?
21. ¿Qué hace `path.join()`?
22. ¿Por qué no debemos compartir node_modules entre plataformas?
23. ¿Qué problemas pueden aparecer con WSL?
24. ¿Por qué debemos documentar requisitos?
25. ¿Cómo puede ayudar CI/CD a validar compatibilidad?

---

# 37. Learning Checklist

## Fundamentals

- [ ] Diferencio Operating System, Terminal y Shell.
- [ ] Comprendo Cross-platform Compatibility.
- [ ] Reconozco Bash, Zsh y PowerShell.
- [ ] Comprendo diferencias de comandos.

## Windows Development

- [ ] Comprendo Git Bash.
- [ ] Comprendo WSL.
- [ ] Diferencio Git Bash y WSL.
- [ ] Reconozco instalaciones independientes de herramientas.

## Filesystem and Environment

- [ ] Comprendo diferencias de rutas.
- [ ] Reconozco Case Sensitivity.
- [ ] Comprendo LF y CRLF.
- [ ] Comprendo File Permissions.
- [ ] Comprendo diferencias de PATH.

## Project Tooling

- [ ] Reconozco scripts no portables.
- [ ] Comprendo las ventajas de Node.js.
- [ ] Sé utilizar `path.join()`.
- [ ] Comprendo la importancia de documentar requisitos.
- [ ] Reconozco el valor de las pruebas multiplataforma.

---

# 38. Mental Model

```text
                    Development Project
                            │
                            ▼
                    Shared Repository
                            │
              ┌─────────────┼─────────────┐
              │             │             │
              ▼             ▼             ▼
            macOS         Windows        Linux
              │             │             │
              ▼             ▼             ▼
             Zsh        PowerShell       Bash
              │             │             │
              └─────────────┼─────────────┘
                            │
                            ▼
                  Portable Project Scripts
                            │
                            ▼
                    Node.js / Tooling
                            │
                            ▼
                   Consistent Workflow
```

Recordemos:

```text
Operating System ≠ Shell
```

```text
Git Bash ≠ WSL
```

```text
Same Command Name ≠ Same Behavior
```

```text
Cross-platform Application ≠ Cross-platform Scripts
```

Y nuestro principio fundamental:

```text
Understand Differences
         ↓
Standardize Tooling
         ↓
Build Portable Workflows
         ↓
Validate Compatibility
```

---

# 39. Key Takeaway

**Desarrollar software multiplataforma requiere comprender las diferencias entre sistemas operativos, Shells, sistemas de archivos y herramientas de ejecución.**

No necesitamos memorizar todos los comandos de cada plataforma.

Necesitamos aprender a:

- Identificar el entorno.
- Reconocer diferencias relevantes.
- Utilizar herramientas adecuadas.
- Evitar dependencias innecesarias.
- Diseñar scripts reproducibles.
- Validar las plataformas que realmente soportamos.

Esta base será especialmente importante cuando estudiemos Runtime Management, Package Managers, Monorepos y CI/CD.

---

# 40. Next Step

El último documento de este módulo será:

**12 — Common Terminal Issues**

Aprenderemos a diagnosticar problemas frecuentes como:

- `command not found`.
- `Permission denied`.
- Problemas de PATH.
- Variables de entorno no disponibles.
- Diferencias entre terminales.
- Problemas de Shell Configuration.
- Conflictos entre instalaciones de Node.js.
- Errores de rutas y permisos.
- Problemas de ejecución de scripts.

👉 [12 — Common Terminal Issues](./12-common-terminal-issues.md)

**Con el siguiente documento cerraremos `02-terminal-and-shell` y tendremos una base sólida para continuar con las herramientas de desarrollo profesional.**