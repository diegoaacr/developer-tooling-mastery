# Windows Terminal

Windows Terminal es una aplicación moderna de Terminal desarrollada por Microsoft para trabajar con diferentes entornos de línea de comandos desde una interfaz unificada.

Permite utilizar PowerShell, Command Prompt, distribuciones Linux mediante WSL y otros entornos compatibles, organizándolos mediante pestañas, paneles y perfiles.

Sin embargo, **Windows Terminal no es un Shell, un Runtime ni un Package Manager**.

Comprender esta diferencia es fundamental para configurar correctamente nuestro Development Environment y evitar confusiones cuando trabajemos con Node.js, Git, Docker o herramientas de automatización.

---

## 🎯 Objetivo

Al finalizar este documento deberías poder:

- Explicar qué es Windows Terminal y qué problema resuelve.
- Diferenciar Terminal Emulator, Shell y Runtime.
- Comprender la arquitectura de una sesión de Terminal.
- Identificar qué son los Profiles.
- Diferenciar PowerShell, CMD, Git Bash y WSL dentro de Windows Terminal.
- Utilizar Tabs y Panes para organizar sesiones.
- Comprender la configuración de Startup Directory.
- Identificar cómo se relacionan los perfiles con `PATH` y las Environment Variables.
- Conocer las opciones de personalización más importantes.
- Comprender cuándo utilizar Windows Terminal frente a la Terminal integrada de VS Code.
- Diagnosticar problemas frecuentes.
- Configurar un entorno de trabajo ordenado sin introducir complejidad innecesaria.

---

## 🧠 1. El problema: múltiples entornos de línea de comandos

Imagina que desarrollamos una aplicación Full Stack en Windows.

Necesitamos ejecutar:

```text
Frontend Development Server
Backend Development Server
Git Commands
Build Scripts
System Commands
```

Podríamos abrir diferentes ventanas de PowerShell o CMD.

Por ejemplo:

```text
PowerShell Window 1 → Frontend

PowerShell Window 2 → Backend

PowerShell Window 3 → Git

PowerShell Window 4 → System Tools
```

Esto funciona, pero puede resultar incómodo cuando administramos varias sesiones.

También podríamos necesitar trabajar con diferentes Shells.

Por ejemplo:

```text
PowerShell
CMD
Git Bash
WSL Ubuntu
```

Aquí aparecen dos necesidades:

1. Organizar múltiples sesiones de Terminal.
2. Acceder a diferentes entornos desde una interfaz común.

**Windows Terminal ayuda a resolver estas necesidades.**

---

## 💻 2. ¿Qué es Windows Terminal?

Windows Terminal es una aplicación de Terminal que permite interactuar con diferentes programas de línea de comandos.

Su responsabilidad principal es proporcionar una interfaz para las sesiones.

Entre sus capacidades encontramos:

- Pestañas o Tabs.
- Paneles o Panes.
- Profiles.
- Personalización visual.
- Atajos de teclado.
- Compatibilidad con diferentes Shells.
- Integración con entornos WSL.
- Soporte para secuencias de control de Terminal.

### Modelo conceptual

```text
Developer
    ↓
Windows Terminal
    │
    ├── PowerShell Session
    │
    ├── CMD Session
    │
    ├── Git Bash Session
    │
    └── WSL Session
```

Windows Terminal no interpreta por sí mismo todos los comandos que escribimos.

Esa responsabilidad corresponde al Shell o programa ejecutado dentro de la sesión.

---

## 🧩 3. Terminal Emulator vs Shell vs Runtime

Esta distinción es esencial.

### Terminal Emulator

Un **Terminal Emulator** es una aplicación que proporciona una interfaz para interactuar con programas de línea de comandos.

Ejemplos:

- Windows Terminal.
- Terminal.app en macOS.
- Terminal integrada de VS Code.

### Shell

Un **Shell** interpreta comandos y permite interactuar con el entorno de ejecución.

Ejemplos:

- PowerShell.
- CMD.
- Bash.
- Zsh.

### Runtime

Un **Runtime** proporciona capacidades para ejecutar programas desarrollados para una plataforma determinada.

Por ejemplo:

- Node.js.
- Java Runtime.
- .NET Runtime.

### Comparación

| Componente | Responsabilidad |
|---|---|
| Windows Terminal | Mostrar e interactuar con sesiones |
| PowerShell | Interpretar comandos y automatizar tareas |
| Node.js | Ejecutar aplicaciones JavaScript |
| Git | Administrar versiones de código |
| pnpm | Administrar dependencias JavaScript |

### Ejemplo

```text
Windows Terminal
       ↓
PowerShell
       ↓
node server.js
       ↓
Node.js Runtime
       ↓
Application
```

### Idea importante

**Cambiar de Windows Terminal a otra aplicación de Terminal no implica necesariamente cambiar de Shell ni de Runtime.**

---

## ⚙️ 4. ¿Cómo funciona una sesión de Windows Terminal?

Cuando abrimos un Profile, Windows Terminal inicia o conecta una sesión con el programa configurado.

De manera simplificada:

```text
Windows Terminal
       ↓
Profile Configuration
       ↓
Shell Process
       ↓
Command
       ↓
Operating System
       ↓
Result
```

Por ejemplo:

```text
Windows Terminal
       ↓
PowerShell Profile
       ↓
PowerShell
       ↓
git status
       ↓
Git
       ↓
Command Output
```

Windows Terminal presenta la salida y permite interactuar con el proceso.

### ¿Qué sucede si cerramos una pestaña?

Normalmente, cerrar una pestaña termina o desconecta la sesión asociada.

Si dentro de esa sesión ejecutábamos un servidor de desarrollo, el proceso puede detenerse.

Por eso debemos distinguir entre:

- Cerrar una pestaña.
- Detener un proceso.
- Mantener un proceso ejecutándose mediante un mecanismo independiente.

Estudiaremos la gestión de procesos en `02-terminal-and-shell`.

---

## 🗂️ 5. Profiles

Un **Profile** define cómo Windows Terminal debe iniciar una sesión determinada.

Por ejemplo:

```text
Windows Terminal
│
├── PowerShell Profile
├── Command Prompt Profile
├── Ubuntu Profile
└── Git Bash Profile
```

Cada Profile puede tener propiedades como:

- Nombre.
- Comando de inicio.
- Directorio inicial.
- Icono.
- Apariencia.
- Configuración de entorno.
- Otras opciones compatibles.

### Ejemplo conceptual

```text
Profile: PowerShell
    ↓
Launch PowerShell
    ↓
Open Session
```

Otro ejemplo:

```text
Profile: Ubuntu
    ↓
Launch WSL Distribution
    ↓
Open Linux Shell
```

### ¿Un Profile instala el Shell?

No.

Un Profile configura cómo iniciar un programa o entorno.

Para utilizar un Shell determinado, este debe estar disponible en el sistema.

**Crear un Profile para Git Bash no instala Git Bash.**

---

## 🔎 6. Profiles dinámicos y perfiles personalizados

Windows Terminal puede detectar determinados entornos instalados y generar perfiles dinámicos.

Por ejemplo, dependiendo de la configuración:

```text
PowerShell
Command Prompt
WSL Distributions
```

También podemos crear perfiles personalizados.

### ¿Cuándo crear uno?

Por ejemplo, si queremos abrir Git Bash directamente desde Windows Terminal.

O si necesitamos una configuración específica para un entorno de desarrollo.

### ¿Debemos crear perfiles para cada proyecto?

No necesariamente.

Para muchos desarrolladores es suficiente utilizar un Profile de PowerShell y navegar entre proyectos.

Los Profiles adicionales resultan útiles cuando necesitamos comportamientos de inicio diferentes.

---

## 🐚 7. PowerShell dentro de Windows Terminal

PowerShell es una de las opciones más habituales para trabajar en Windows Terminal.

### Ejemplo

Abrimos un Profile de PowerShell.

Después ejecutamos:

```powershell
Get-Location
```

Este comando muestra la ubicación actual.

Podemos consultar Git:

```powershell
git --version
```

O Node.js:

```powershell
node --version
```

### ¿Qué aporta Windows Terminal?

Nos permite trabajar con PowerShell mediante una interfaz moderna.

Pero los comandos y su comportamiento siguen dependiendo de PowerShell y del entorno disponible.

### Diferencia importante

**Windows Terminal no convierte un comando de Bash en un comando válido de PowerShell.**

Cada Shell conserva su propia sintaxis.

---

## 🪟 8. CMD dentro de Windows Terminal

CMD es el intérprete tradicional de comandos de Windows.

Podemos utilizarlo dentro de Windows Terminal mediante su Profile correspondiente.

### Ejemplo

En CMD:

```cmd
cd
```

Muestra el directorio actual.

También podemos ejecutar:

```cmd
dir
```

Para listar archivos.

### Diferencia con PowerShell

En PowerShell podemos utilizar:

```powershell
Get-ChildItem
```

Aunque PowerShell ofrece Alias compatibles con determinados comandos tradicionales, su lenguaje y sus capacidades son diferentes.

### ¿Cuándo utilizar CMD?

Puede resultar útil para:

- Scripts heredados.
- Herramientas que esperan CMD.
- Compatibilidad con procesos existentes.
- Diagnóstico de comportamientos específicos de Windows.

Para nuevos flujos de automatización, PowerShell suele ofrecer capacidades más amplias.

---

## 🐧 9. WSL dentro de Windows Terminal

Windows Terminal puede utilizarse para abrir sesiones de distribuciones Linux instaladas mediante WSL.

Por ejemplo:

```text
Windows Terminal
       ↓
Ubuntu Profile
       ↓
WSL
       ↓
Linux Shell
```

### ¿Qué cambia?

Al ingresar a una distribución WSL, trabajamos dentro de un entorno Linux.

Por ejemplo:

```bash
pwd
```

Podría mostrar:

```text
/home/developer
```

### Diferencia importante

Dentro de WSL utilizamos herramientas y convenciones propias de Linux.

Por ejemplo:

```text
Linux File System
Linux Executables
Linux Package Managers
Linux Environment Variables
```

### ¿Windows Terminal se convierte en Linux?

No.

Windows Terminal sigue siendo una aplicación de Windows.

El entorno Linux es proporcionado por WSL.

### Ejemplo

```text
Windows
   ↓
Windows Terminal
   ↓
WSL
   ↓
Ubuntu
   ↓
Bash
   ↓
Linux Commands
```

Estudiaremos WSL en profundidad en `05-wsl.md`.

---

## 🔧 10. Git Bash dentro de Windows Terminal

Git Bash también puede utilizarse desde Windows Terminal si está instalado y configuramos un Profile adecuado.

### Modelo conceptual

```text
Windows Terminal
       ↓
Git Bash Profile
       ↓
Bash Environment
       ↓
Git Commands
```

### ¿Por qué puede resultar útil?

Porque permite trabajar con comandos familiares de entornos Unix-like.

Por ejemplo:

```bash
pwd
ls
git status
```

### ¿Es equivalente a WSL?

No.

Git Bash utiliza herramientas y mecanismos de compatibilidad sobre Windows.

WSL proporciona un entorno Linux.

### ¿Debemos utilizar Git Bash y WSL al mismo tiempo?

No es obligatorio.

Podemos elegir el entorno que mejor se adapte a nuestros proyectos.

Tener más Shells instalados no significa automáticamente mejorar nuestro flujo de trabajo.

---

## 🗃️ 11. Tabs

Las **Tabs** permiten abrir varias sesiones dentro de una misma ventana.

Por ejemplo:

```text
Windows Terminal
│
├── Tab 1 — PowerShell
├── Tab 2 — PowerShell
└── Tab 3 — Ubuntu
```

### Caso práctico

Imagina un proyecto Full Stack:

```text
Tab 1 → Frontend

Tab 2 → Backend

Tab 3 → Git
```

Podemos mantener varias sesiones disponibles sin abrir una ventana independiente para cada una.

### ¿Cada Tab tiene su propio entorno?

Cada pestaña puede ejecutar su propio proceso y disponer de un entorno diferente.

Por ejemplo:

```text
Tab 1
    ↓
PowerShell
    ↓
Node.js for Windows
```

```text
Tab 2
    ↓
Ubuntu
    ↓
Node.js for Linux
```

No debemos asumir que ambas sesiones utilizan las mismas instalaciones.

---

## 🧱 12. Panes

Los **Panes** permiten dividir una pestaña en varias regiones.

Por ejemplo:

```text
┌───────────────────────────────┐
│         Windows Terminal      │
├───────────────┬───────────────┤
│               │               │
│   Frontend    │    Backend    │
│               │               │
│               │               │
└───────────────┴───────────────┘
```

Cada Pane puede contener una sesión independiente.

### Ejemplo práctico

Podemos ejecutar:

```text
Left Pane
    ↓
Frontend Development Server
```

```text
Right Pane
    ↓
Backend Development Server
```

### ¿Por qué es útil?

Porque podemos observar simultáneamente las salidas de diferentes procesos.

Esto resulta especialmente conveniente cuando trabajamos con:

- Frontend y Backend.
- Servidores de desarrollo.
- Procesos de Testing.
- Herramientas de observación.
- Logs.

### Precaución

No debemos abrir procesos innecesarios solamente porque podamos dividir la Terminal.

El objetivo es mejorar la visibilidad y organización.

---

## 📁 13. Startup Directory

El **Startup Directory** define la ubicación inicial de una sesión.

Por ejemplo, podríamos configurar un Profile para comenzar en:

```text
C:\Users\developer\Projects
```

### ¿Por qué importa?

Porque muchos comandos dependen del directorio de trabajo actual.

Por ejemplo:

```powershell
Get-Location
```

Podría mostrar:

```text
Path
----
C:\Users\developer\Projects
```

### Ejemplo

Si ejecutamos:

```powershell
git status
```

Git buscará un Repository según el directorio actual y sus directorios superiores.

Por eso importa saber desde dónde estamos ejecutando los comandos.

### Recomendación

Utiliza un directorio inicial comprensible.

Por ejemplo:

```text
User Home Directory
```

O:

```text
Projects Directory
```

No necesitamos configurar un Startup Directory diferente para cada proyecto.

---

## 🌍 14. Windows Terminal y Environment Variables

Windows Terminal inicia sesiones que reciben un entorno de ejecución.

Ese entorno puede incluir variables como:

```text
PATH
USERPROFILE
TEMP
```

### Ejemplo

En PowerShell:

```powershell
$env:Path
```

### ¿De dónde proviene el entorno?

Puede depender de:

- Variables del sistema.
- Variables del usuario.
- Entorno heredado por la aplicación.
- Configuración del Profile.
- Inicialización del Shell.

### Modelo conceptual

```text
Windows Environment
        ↓
Windows Terminal Process
        ↓
Profile / Shell Startup
        ↓
Shell Environment
        ↓
Commands
```

### Importante

Windows Terminal no administra automáticamente las versiones de Node.js.

Tampoco instala dependencias de proyectos.

Solamente proporciona el entorno de Terminal desde el cual utilizamos esas herramientas.

---

## 🔍 15. ¿Por qué dos Tabs pueden comportarse diferente?

Imagina que abrimos dos pestañas.

En la primera:

```powershell
node --version
```

Funciona.

En la segunda:

```bash
node --version
```

No funciona.

### ¿Qué podría estar sucediendo?

Tal vez:

```text
Tab 1 → PowerShell

Tab 2 → WSL Ubuntu
```

Cada entorno utiliza instalaciones diferentes.

Otra posibilidad es que los perfiles tengan configuraciones de inicio distintas.

### Diagnóstico

En PowerShell:

```powershell
Get-Command node -All
```

En WSL:

```bash
command -v node
```

Después comprobamos las versiones.

### Principio

**Dos sesiones abiertas en la misma aplicación de Terminal no necesariamente comparten el mismo entorno de ejecución.**

---

## ⚙️ 16. Windows Terminal Settings

Windows Terminal permite configurar diferentes aspectos de su comportamiento.

Podemos acceder a sus Settings desde la interfaz.

Entre las opciones habituales encontramos:

- Default Profile.
- Startup Behavior.
- Appearance.
- Color Schemes.
- Fonts.
- Keyboard Shortcuts.
- Profiles.
- Tabs.
- Panes.

### ¿Debemos personalizar todo?

No.

Primero debemos conseguir un entorno funcional.

Después podemos incorporar mejoras que faciliten nuestro trabajo.

### Orden recomendado

```text
Functional Environment
        ↓
Correct Shell
        ↓
Correct Tools
        ↓
Organized Sessions
        ↓
Optional Personalization
```

La apariencia no debe sustituir la comprensión del entorno.

---

## 📄 17. settings.json

Windows Terminal permite configurar numerosas opciones mediante un archivo JSON.

Normalmente podemos acceder a él desde las opciones de configuración de la propia aplicación.

### ¿Por qué utilizar JSON?

Porque permite representar configuraciones estructuradas.

Ejemplo conceptual:

```json
{
  "defaultProfile": "{PROFILE-GUID}",
  "profiles": {
    "list": []
  }
}
```

Este fragmento es ilustrativo y no representa una configuración completa lista para reemplazar nuestro archivo.

### ¿Qué es defaultProfile?

Es una configuración que permite indicar qué Profile debe utilizar Windows Terminal de manera predeterminada.

### ¿Qué es un GUID?

Un **GUID** es un identificador utilizado para distinguir determinados elementos.

En Windows Terminal, los Profiles pueden identificarse mediante GUIDs.

### Precaución

No debemos reemplazar todo nuestro `settings.json` copiando configuraciones desconocidas.

Podríamos eliminar perfiles u opciones existentes.

Antes de editar:

1. Inspecciona la configuración.
2. Identifica qué propiedad necesitas modificar.
3. Realiza una copia de seguridad.
4. Aplica un cambio mínimo.
5. Verifica el resultado.

---

## 🎨 18. Appearance y personalización

Windows Terminal permite personalizar su apariencia.

Por ejemplo:

- Tipografía.
- Tamaño del texto.
- Esquemas de color.
- Transparencia.
- Fondo.
- Cursor.
- Apariencia de pestañas.

### ¿Qué recomendamos?

Priorizar:

1. Legibilidad.
2. Contraste adecuado.
3. Tamaño de texto cómodo.
4. Identificación clara de perfiles.
5. Configuración sencilla.

### Ejemplo de organización

```text
PowerShell → Development

Ubuntu → Linux Environment

CMD → Legacy Tools
```

Podemos utilizar nombres y apariencias diferentes para identificar rápidamente cada sesión.

### Importante

La personalización visual no modifica las capacidades del Shell.

Cambiar una fuente o un esquema de colores no afecta directamente a Node.js, Git o pnpm.

---

## ⌨️ 19. Keyboard Shortcuts

Windows Terminal ofrece atajos para administrar sesiones.

Entre las acciones más útiles encontramos:

- Abrir una pestaña.
- Cerrar una pestaña.
- Cambiar entre pestañas.
- Dividir paneles.
- Cambiar el foco.
- Buscar texto.
- Abrir Settings.

Algunos atajos predeterminados habituales incluyen:

| Acción | Atajo habitual |
|---|---|
| New Tab | `Ctrl + Shift + T` |
| Close Tab | `Ctrl + Shift + W` |
| Settings | `Ctrl + ,` |
| New Pane | Depende de la configuración y acción |
| Switch Tabs | Atajos configurables |

Los atajos pueden variar según la versión y la configuración personalizada.

Podemos consultar y modificarlos desde Settings.

### Recomendación

No necesitamos memorizar todos los atajos.

Comienza utilizando aquellos que resuelven necesidades frecuentes.

---

## 🧪 20. Práctica: explorar Windows Terminal

Esta práctica no requiere modificar configuraciones permanentes.

### Step 1 — Open Windows Terminal

Abre Windows Terminal desde el menú de inicio.

### Step 2 — Identify Available Profiles

Observa los perfiles disponibles.

Por ejemplo:

```text
PowerShell
Command Prompt
Ubuntu
```

Los perfiles reales dependerán de las herramientas instaladas.

### Step 3 — Open PowerShell

Selecciona PowerShell.

Ejecuta:

```powershell
$PSVersionTable.PSVersion
```

### Step 4 — Inspect Current Directory

```powershell
Get-Location
```

### Step 5 — Inspect Git

```powershell
Get-Command git -ErrorAction SilentlyContinue
```

Si está disponible:

```powershell
git --version
```

### Step 6 — Inspect Node.js

```powershell
Get-Command node -ErrorAction SilentlyContinue
```

Si está disponible:

```powershell
node --version
```

### Step 7 — Open Another Tab

Abre una nueva pestaña de PowerShell.

Comprueba:

```powershell
Get-Location
```

### Step 8 — Compare Sessions

Comprueba si ambas sesiones tienen el mismo directorio de trabajo.

Después consulta:

```powershell
$env:Path
```

### Step 9 — Explore Panes

Utiliza la opción de dividir paneles desde la interfaz.

Abre una segunda sesión y observa cómo funcionan ambas.

### Step 10 — Document Results

| Component | Result |
|---|---|
| Windows Terminal Available | |
| Default Profile | |
| Available Profiles | |
| PowerShell Version | |
| Startup Directory | |
| Git Available | |
| Node.js Available | |
| Tabs Tested | |
| Panes Tested | |

### Reflexión

Responde:

1. ¿Qué Profile utiliza Windows Terminal por defecto?
2. ¿Qué Shell se ejecuta dentro de ese Profile?
3. ¿Qué directorio inicial utiliza?
4. ¿Git está disponible?
5. ¿Node.js está disponible?
6. ¿Qué diferencia observaste entre Tabs y Panes?
7. ¿Necesitas perfiles adicionales?
8. ¿Qué configuración mejoraría realmente tu flujo de trabajo?

---

## 🛠️ 21. Troubleshooting: problemas frecuentes

### Problema A — Windows Terminal Not Installed

No encontramos Windows Terminal en nuestra computadora.

**Posibles causas:**

- No está instalado.
- La instalación fue restringida.
- La versión de Windows o el entorno administrado tiene limitaciones.

**Solución:**

Verificar los requisitos y consultar los canales oficiales de Microsoft.

En un equipo corporativo, debemos respetar las políticas de instalación.

---

### Problema B — Profile Does Not Open

Seleccionamos un Profile y la sesión no inicia.

**Posibles causas:**

- El ejecutable configurado no existe.
- El Shell fue desinstalado.
- La ruta configurada es incorrecta.
- Existe una restricción de permisos.

**Diagnóstico:**

Inspeccionar la configuración del Profile y comprobar que el programa correspondiente esté disponible.

Por ejemplo, en PowerShell:

```powershell
Get-Command pwsh -ErrorAction SilentlyContinue
```

Este comando comprueba si PowerShell 7 o posterior está disponible mediante `pwsh`.

**Importante:** Windows PowerShell 5.1 utiliza habitualmente `powershell.exe`, mientras que PowerShell moderno utiliza `pwsh.exe`.

---

### Problema C — Command Works in One Profile but Not Another

Un comando funciona en PowerShell, pero no en WSL.

**Posible causa:**

Los Profiles utilizan entornos diferentes.

**Diagnóstico:**

Comparar:

- Shell.
- Sistema de ejecución.
- `PATH`.
- Instalaciones.
- Versiones.

No debemos asumir que una instalación de Node.js para Windows está disponible automáticamente como instalación Linux dentro de WSL.

---

### Problema D — Wrong Startup Directory

Abrimos una sesión y aparece en un directorio inesperado.

**Posible causa:**

El Profile tiene configurado un Startup Directory diferente.

**Diagnóstico:**

En PowerShell:

```powershell
Get-Location
```

Después revisamos la configuración del Profile.

---

### Problema E — Environment Variables Not Updated

Modificamos una variable de entorno, pero una sesión abierta no refleja el cambio.

**Posible causa:**

Los procesos existentes no necesariamente reciben automáticamente cambios realizados posteriormente en la configuración del entorno.

**Solución:**

Comprobar cómo se inició la aplicación y abrir una nueva sesión cuando corresponda.

En algunos casos puede ser necesario reiniciar la aplicación que hereda el entorno.

No debemos modificar repetidamente `PATH` sin comprobar el origen del problema.

---

### Problema F — Git Bash Profile Not Available

Instalamos Git for Windows, pero Git Bash no aparece entre los Profiles.

**Posible causa:**

No existe un Profile configurado o no fue detectado automáticamente.

**Solución:**

Comprobar primero que Git Bash esté instalado.

Después podemos crear un Profile personalizado con el comando de inicio apropiado.

No necesitamos reinstalar Git automáticamente.

---

## 🏢 22. Windows Terminal en equipos profesionales

En un equipo profesional podemos utilizar Windows Terminal para organizar diferentes tareas.

Por ejemplo:

```text
Windows Terminal
│
├── Tab 1 — Frontend
│
├── Tab 2 — Backend
│
├── Tab 3 — Git
│
└── Tab 4 — WSL
```

Sin embargo, la organización depende del flujo de trabajo.

### Ejemplo Full Stack

```text
Frontend
    ↓
pnpm dev
```

```text
Backend
    ↓
pnpm start:dev
```

```text
Git
    ↓
git status
```

Estos comandos son ejemplos y requieren que los proyectos correspondientes estén configurados.

### ¿Es obligatorio utilizar Windows Terminal?

No.

Podemos utilizar otras aplicaciones de Terminal compatibles con nuestras necesidades.

La elección puede depender de:

- Preferencias.
- Requisitos corporativos.
- Integración con herramientas.
- Accesibilidad.
- Flujos de trabajo.

**Windows Terminal mejora la organización de sesiones, pero no reemplaza una configuración correcta del entorno de desarrollo.**

---

## ⚠️ 23. Errores comunes

### 1. Confundir Windows Terminal con PowerShell

Windows Terminal proporciona la interfaz; PowerShell interpreta comandos.

### 2. Pensar que Windows Terminal instala Shells

Los Profiles necesitan programas o entornos disponibles.

### 3. Pensar que todas las Tabs comparten el mismo entorno

Cada sesión puede tener configuraciones diferentes.

### 4. Confundir Git Bash con WSL

Git Bash no proporciona un entorno Linux completo.

### 5. Instalar WSL únicamente para utilizar Windows Terminal

Windows Terminal funciona sin WSL.

### 6. Copiar comandos Bash en PowerShell sin comprobar compatibilidad

Los Shells utilizan sintaxis diferentes.

### 7. Modificar settings.json sin revisar la configuración existente

Podemos introducir errores o eliminar personalizaciones.

### 8. Personalizar excesivamente antes de comprender el entorno

La apariencia no sustituye la funcionalidad.

### 9. Suponer que Windows Terminal administra Node.js

Node.js se instala y administra mediante herramientas independientes.

### 10. Ignorar el Startup Directory

El directorio de trabajo afecta a numerosos comandos.

### 11. Reinstalar herramientas por diferencias entre Profiles

Primero debemos comprobar el entorno de cada sesión.

### 12. Mantener procesos innecesarios abiertos

Las sesiones adicionales consumen recursos y pueden complicar el diagnóstico.

---

## 🧠 24. Comprueba tu modelo mental

Intenta responder sin revisar el documento:

1. ¿Qué es Windows Terminal?
2. ¿Qué problema resuelve?
3. ¿Qué diferencia existe entre Terminal Emulator y Shell?
4. ¿Qué es un Runtime?
5. ¿Windows Terminal ejecuta directamente JavaScript?
6. ¿Qué es un Profile?
7. ¿Un Profile instala un Shell?
8. ¿Qué diferencia existe entre PowerShell y CMD?
9. ¿Qué es Git Bash?
10. ¿Qué diferencia existe entre Git Bash y WSL?
11. ¿Qué es una Tab?
12. ¿Qué es un Pane?
13. ¿Qué es Startup Directory?
14. ¿Por qué importa el directorio de trabajo?
15. ¿Qué es `settings.json`?
16. ¿Qué es `defaultProfile`?
17. ¿Qué es un GUID?
18. ¿Por qué dos Tabs pueden utilizar versiones diferentes de Node.js?
19. ¿Qué investigarías si un Profile no inicia?
20. ¿Qué investigarías si Git funciona en un Profile, pero no en otro?
21. ¿Qué diferencia existe entre Windows Terminal y la Terminal integrada de VS Code?
22. ¿Qué configuraciones conviene priorizar?
23. ¿Por qué no debemos personalizar todo inmediatamente?
24. ¿Cómo organizarías las sesiones de un proyecto Full Stack?

---

## 💡 Idea clave

Windows Terminal es una aplicación que organiza y presenta sesiones de línea de comandos.

```text
Windows Terminal
       │
       ├── Profiles
       │
       ├── Tabs
       │
       ├── Panes
       │
       └── Shell Sessions
               │
               ├── PowerShell
               ├── CMD
               ├── Git Bash
               └── WSL
```

Su principal responsabilidad es facilitar la interacción con diferentes entornos.

**La configuración del Shell, las herramientas instaladas, las versiones de Runtime y las dependencias de los proyectos siguen siendo responsabilidades independientes.**

Comprender esta separación nos permitirá construir entornos más claros y diagnosticar problemas con mayor precisión.

---

## 🚀 Siguiente paso

Ahora comprendemos qué es Windows Terminal y cómo organiza diferentes sesiones.

El siguiente paso será profundizar en **PowerShell**, uno de los Shells más importantes del ecosistema Windows.

Estudiaremos:

- Qué es PowerShell.
- Qué son los Cmdlets.
- Cómo funciona el Pipeline.
- Qué diferencia existe entre texto y objetos.
- Cómo consultar archivos, procesos y variables.
- Qué son los Scripts `.ps1`.
- Qué significa Execution Policy.
- Cómo utilizar PowerShell profesionalmente.

👉 [PowerShell](./03-powershell.md)