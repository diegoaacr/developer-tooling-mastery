# 01 — Install VS Code

## Overview

**Visual Studio Code (VS Code)** está disponible para macOS, Windows y Linux. Su instalación es relativamente sencilla, pero existen diferencias entre plataformas que conviene conocer para evitar problemas de compatibilidad, actualizaciones y acceso desde la terminal.

Al finalizar este documento podrás:

- Instalar VS Code utilizando el paquete adecuado para tu sistema operativo.
- Diferenciar los canales **Stable** e **Insiders**.
- Verificar que el editor inicia correctamente.
- Ejecutar el comando `code` desde una terminal.
- Identificar y resolver problemas habituales de instalación y `PATH`.

No configuraremos todavía extensiones, perfiles ni preferencias avanzadas del editor.

## 1. Installation Channels

VS Code dispone de dos canales principales de distribución.

| Característica | Stable | Insiders |
|---|---|---|
| Propósito | Uso habitual y profesional | Acceso anticipado a funcionalidades |
| Actualizaciones | Generalmente mensuales, con correcciones adicionales cuando corresponde | Generalmente diarias |
| Estabilidad | Versión publicada para uso general | Puede incluir funcionalidades experimentales o regresiones |
| Instalación simultánea | Sí | Sí |
| Comando CLI habitual | `code` | `code-insiders` |

### ¿Cuál utilizar?

**Stable** es la opción recomendada para trabajar en proyectos profesionales y seguir este Mastery.

**Insiders** puede resultar útil cuando necesitamos probar una funcionalidad reciente, validar compatibilidad o investigar un problema que podría estar corregido en una versión de desarrollo.

Ambas versiones pueden coexistir en el mismo equipo. Mantienen instalaciones y datos de usuario diferenciados por defecto, aunque determinadas herramientas externas y configuraciones del sistema pueden seguir siendo compartidas.

**Para este módulo utilizaremos VS Code Stable.**

## 2. Install VS Code

Descarga VS Code desde su sitio oficial:

**https://code.visualstudio.com/download**

Selecciona el instalador correspondiente a tu sistema operativo y arquitectura.

### macOS

VS Code ofrece distribuciones para:

- **Apple Silicon (ARM64):** equipos con procesadores Apple M1, M2, M3 y posteriores.
- **Intel (x64):** equipos Mac con procesadores Intel.
- **Universal:** distribución compatible con ambas arquitecturas, cuando esté disponible.

**Instalación:**

1. Descarga el paquete adecuado desde la web oficial.
2. Descomprime el archivo descargado, si corresponde.
3. Mueve `Visual Studio Code.app` a la carpeta `Applications`.
4. Abre VS Code desde `Applications` o Spotlight.

Para verificar la arquitectura de tu Mac, ejecuta:

```bash
uname -m
```

| Resultado | Arquitectura |
|---|---|
| `arm64` | Apple Silicon |
| `x86_64` | Intel, o un entorno que esté ejecutándose bajo traducción |

Si utilizas un Mac con Apple Silicon, prioriza la distribución ARM64 o Universal.

### Windows

En Windows, VS Code ofrece diferentes modalidades de instalación.

| Instalador | Características | Uso recomendado |
|---|---|---|
| User Installer | Instalación para el usuario actual, normalmente sin permisos de administrador | Equipo personal o entorno corporativo con permisos limitados |
| System Installer | Instalación para todos los usuarios, normalmente requiere permisos de administrador | Equipo administrado o instalación compartida |
| ZIP | Distribución comprimida que permite una instalación manual | Entornos donde no se utiliza el instalador tradicional |

**Instalación recomendada:**

1. Descarga **User Installer** para la arquitectura correspondiente.
2. Ejecuta el instalador.
3. Revisa las opciones de integración con Windows.
4. Mantén habilitada la opción de agregar VS Code al `PATH`, si aparece.
5. Finaliza la instalación y abre VS Code.

En Windows, la arquitectura más habitual es x64, aunque también existen equipos ARM64.

**Nota:** si trabajas en una máquina virtual corporativa, verifica las políticas de instalación antes de utilizar instaladores o modificar variables del sistema.

### Linux

En Linux, el procedimiento depende de la distribución y del gestor de paquetes.

VS Code ofrece paquetes como:

| Distribución | Formato habitual |
|---|---|
| Ubuntu / Debian | `.deb` |
| Fedora / RHEL | `.rpm` |
| Otras distribuciones | Según los formatos y métodos disponibles oficialmente |

**Ubuntu / Debian**

Descarga el paquete `.deb` oficial y, desde la carpeta donde se encuentre, ejecuta:

```bash
sudo apt install ./code_*.deb
```

Este comando utiliza el gestor de paquetes para instalar el archivo descargado y resolver las dependencias disponibles.

**Fedora / RHEL**

Descarga el paquete `.rpm` correspondiente y ejecuta:

```bash
sudo dnf install ./code-*.rpm
```

En ambos casos, comprueba que el archivo descargado corresponde a tu arquitectura y que el patrón identifica únicamente el paquete que deseas instalar.

Dependiendo del método de instalación y la distribución, también puedes configurar un repositorio oficial para recibir actualizaciones mediante el gestor de paquetes.

Para otros métodos, consulta la documentación oficial:

https://code.visualstudio.com/docs/setup/linux

---

## 3. Verify the Installation

Después de instalar VS Code, debemos verificar dos cosas:

1. Que la aplicación gráfica funciona.
2. Que podemos invocarla desde la terminal.

### Verificación gráfica

Abre VS Code desde el menú de aplicaciones de tu sistema operativo.

Comprueba que:

- La ventana principal se abre correctamente.
- Puedes utilizar **File → Open Folder**.
- Puedes crear, editar y guardar un archivo de texto.

También puedes consultar la versión instalada desde **Help → About** o la opción equivalente en macOS.

### Verificación desde la terminal

Abre una terminal nueva y ejecuta:

```bash
code --version
```

Si el comando está disponible, verás una salida similar a:

```text
1.xx.x
<commit-id>
<architecture>
```

Los valores concretos dependerán de la versión instalada.

Para abrir la carpeta actual en VS Code:

```bash
code .
```

El punto (`.`) representa el directorio de trabajo actual.

También puedes abrir un archivo:

```bash
code README.md
```

Si el archivo no existe, VS Code puede abrir un documento nuevo con ese nombre, que deberás guardar para crearlo físicamente.

**Importante:** ejecutar `code .` abre el directorio en el editor. No ejecuta automáticamente el código contenido en él.

---

## 4. Configure the `code` Command

El comando `code` permite iniciar VS Code desde la terminal sin buscar manualmente la aplicación.

Su disponibilidad depende de la instalación y de la configuración de `PATH`.

### macOS

En macOS, el comando puede requerir habilitación manual.

1. Abre VS Code.
2. Abre la **Command Palette** con `Cmd + Shift + P`.
3. Busca:

   `Shell Command: Install 'code' command in PATH`

4. Ejecuta el comando.
5. Cierra y vuelve a abrir la terminal.

Verifica:

```bash
code --version
```

Para comprobar dónde se resuelve el ejecutable:

```bash
command -v code
```

Si utilizas Zsh, Bash u otro Shell, recuerda que cada uno puede tener configuraciones de entorno diferentes.

### Windows

En Windows, el instalador normalmente permite agregar VS Code al `PATH`.

Después de instalarlo, abre una nueva sesión de PowerShell:

```powershell
code --version
```

Para localizar el comando:

```powershell
Get-Command code
```

En PowerShell, el comando puede resolverse mediante `code.cmd`.

Si no se encuentra, verifica que la instalación agregó su directorio `bin` al `PATH`.

Las ubicaciones habituales son:

**User Installer**

```text
%LOCALAPPDATA%\Programs\Microsoft VS Code\bin
```

**System Installer**

```text
C:\Program Files\Microsoft VS Code\bin
```

Estas rutas pueden variar según el método y la ubicación de instalación.

### Linux

Los paquetes oficiales `.deb` y `.rpm` normalmente permiten utilizar `code` desde la terminal después de la instalación.

Verifica:

```bash
command -v code
code --version
```

Si el comando no existe, comprueba primero que la instalación terminó correctamente y que el ejecutable está disponible en los directorios incluidos en `PATH`.

No es recomendable crear enlaces simbólicos manuales sin verificar previamente cómo se instaló VS Code.

---

## 5. Common Installation Issues

| Problema | Causa posible | Acción recomendada |
|---|---|---|
| `code: command not found` | CLI no incorporada al `PATH` | Habilitar el comando o revisar `PATH` |
| `code` no se reconoce en PowerShell | Terminal abierta antes de instalar o `PATH` incompleto | Abrir una terminal nueva y verificar la instalación |
| VS Code no abre | Instalación incompleta, incompatibilidad o restricciones del sistema | Verificar arquitectura, permisos y paquete instalado |
| `code --version` muestra otra instalación | Varias instalaciones o rutas con prioridad diferente | Identificar el ejecutable resuelto |
| `code .` abre otra edición | Stable e Insiders o instalaciones adicionales | Verificar el comando y su ubicación |
| No se pueden instalar actualizaciones | Permisos, políticas corporativas o método de instalación | Utilizar el mecanismo de actualización correspondiente |

### Diagnosticar problemas de PATH

`PATH` es una variable de entorno que contiene directorios donde el Shell y el sistema buscan comandos ejecutables.

**macOS / Linux**

```bash
command -v code
```

Para inspeccionar el valor de `PATH`:

```bash
echo "$PATH"
```

**Windows — PowerShell**

```powershell
Get-Command code
```

Para inspeccionar `PATH`:

```powershell
$env:PATH
```

Si el comando no aparece, sigue este orden:

1. Confirma que VS Code está instalado.
2. Comprueba que existe el ejecutable o directorio `bin` correspondiente.
3. Verifica que ese directorio esté incluido en `PATH`.
4. Abre una terminal nueva.
5. Ejecuta nuevamente `code --version`.

Evita modificar `PATH` globalmente o duplicar entradas antes de identificar la causa.

La administración detallada de variables de entorno y Shells corresponde al módulo `02-terminal-and-shell/`.

---

## 6. Hands-on — Verify Your VS Code Installation

**Objetivo:** comprobar que VS Code puede abrirse desde la interfaz gráfica y desde la terminal, y que permite editar archivos.

**Requisitos:** VS Code Stable instalado.

### 1. Verificar la versión

Abre una terminal y ejecuta:

```bash
code --version
```

Comprueba que devuelve información de la instalación sin errores.

### 2. Preparar una carpeta de práctica

Crea una carpeta llamada `vscode-install-lab` mediante el explorador de archivos de tu sistema operativo.

Abre una terminal situada dentro de esa carpeta y ejecuta:

```bash
code .
```

VS Code debería abrir la carpeta como Workspace.

### 3. Crear y guardar un archivo

Desde el Explorer de VS Code, crea:

```text
vscode-install-lab/
└── hello.js
```

Escribe:

```javascript
console.log("VS Code is ready!");
```

Guarda el archivo.

No necesitamos ejecutarlo: en esta práctica estamos verificando la instalación y las capacidades básicas de edición, no el Runtime de JavaScript.

### 4. Comprobar el resultado

| Verificación | Resultado esperado |
|---|---|
| Abrir VS Code desde el sistema | La aplicación inicia correctamente |
| Ejecutar `code --version` | Muestra información de la versión |
| Ejecutar `code .` | Abre la carpeta actual |
| Crear `hello.js` | El archivo aparece en el Explorer |
| Guardar el archivo | El contenido permanece almacenado |

**Resultado de la práctica:** VS Code está instalado, su interfaz funciona y el comando `code` está disponible desde la terminal.

Puedes conservar la carpeta como laboratorio o eliminarla al finalizar.

---

## Key Takeaways

- **Stable** es el canal recomendado para el trabajo habitual; **Insiders** permite probar funcionalidades anticipadas.
- La instalación debe corresponder al sistema operativo y a la arquitectura del equipo.
- El comando `code` facilita abrir archivos y Workspaces desde la terminal.
- En macOS puede requerir habilitación manual; en Windows y Linux suele quedar disponible mediante los instaladores oficiales.
- Ante un problema de ejecución, conviene comprobar primero la instalación y la resolución del comando mediante `PATH`.
- La instalación del editor es independiente de la instalación de Runtimes, Compilers y herramientas de cada proyecto.

### 🚀 Siguiente paso

Con VS Code instalado y verificado, conoceremos su interfaz y los elementos principales del entorno de trabajo.

👉 [02 — VS Code Interface](./02-vscode-interface.md)