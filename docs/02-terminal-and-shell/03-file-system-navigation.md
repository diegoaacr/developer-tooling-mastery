# File System Navigation

> **Developer Tooling Mastery 2026 — Module 02**
>
> **Topic 03:** File System Navigation  
> **Level:** Beginner → Professional Foundations  
> **Prerequisites:** [01 — Terminal vs Shell](./01-terminal-vs-shell.md) · [02 — Command Line Basics](./02-command-line-basics.md)

---

## 1. Introducción

Hasta ahora hemos aprendido qué es una terminal, cómo funciona un Shell y cómo interpretar los comandos que ejecutamos.

Pero todavía necesitamos desarrollar una habilidad fundamental:

**Mover nuestros archivos y directorios desde la línea de comandos con seguridad y autonomía.**

Cuando trabajamos como ingenieros de software, constantemente necesitamos:

- Localizar proyectos.
- Navegar por carpetas.
- Inspeccionar archivos.
- Crear estructuras de directorios.
- Consultar configuraciones.
- Copiar recursos.
- Mover o renombrar archivos.
- Buscar archivos dentro de un repositorio.
- Comprender dónde se está ejecutando un comando.

Por ejemplo, imaginemos que tenemos este proyecto:

```text
my-application/
├── package.json
├── README.md
├── src/
│   ├── index.ts
│   ├── components/
│   └── services/
├── tests/
└── public/
```

¿Cómo podemos entrar en `src`?

¿Cómo regresamos a la raíz del proyecto?

¿Cómo verificamos que existe `package.json`?

¿Cómo consultamos un archivo sin abrir Visual Studio Code?

¿Cómo creamos un nuevo directorio?

Y, especialmente:

**¿Cómo evitamos modificar o eliminar archivos equivocados?**

Estas preguntas serán el centro de este documento.

---

## 2. Objetivos de aprendizaje

Al finalizar deberías poder:

1. Explicar qué es un File System.
2. Diferenciar File y Directory.
3. Comprender qué es una estructura jerárquica.
4. Identificar Root Directory.
5. Identificar Home Directory.
6. Comprender Current Working Directory.
7. Navegar utilizando `pwd`, `ls` y `cd`.
8. Utilizar sus equivalentes principales en PowerShell.
9. Comprender los símbolos `.` y `..`.
10. Reconocer archivos ocultos.
11. Listar archivos con información adicional.
12. Crear archivos y directorios.
13. Inspeccionar contenido de archivos.
14. Copiar, mover y renombrar archivos.
15. Comprender las operaciones de eliminación.
16. Diferenciar operaciones Read-only y Mutating.
17. Identificar errores frecuentes de navegación.
18. Trabajar con una estructura de proyecto desde la terminal.

---

# 3. ¿Qué es un File System?

Un **File System** es el mecanismo mediante el cual un sistema operativo organiza, almacena y permite acceder a archivos y directorios en un medio de almacenamiento.

Gracias a él podemos trabajar con:

- Archivos.
- Directorios.
- Rutas.
- Metadatos.
- Permisos.
- Nombres.
- Jerarquías.

Desde nuestra perspectiva, el sistema de archivos suele presentarse como una estructura de directorios.

### Ejemplo

```text
/
├── home/
│   └── developer/
│       ├── documents/
│       └── projects/
├── etc/
├── usr/
└── var/
```

Esta representación es habitual en sistemas Unix-like.

En Windows podemos encontrar una estructura diferente:

```text
C:\
├── Users\
│   └── Developer\
│       ├── Documents\
│       └── Projects\
├── Program Files\
└── Windows\
```

Aunque sus convenciones son diferentes, ambos sistemas permiten organizar archivos mediante directorios.

## 3.1 File System vs File Explorer

No debemos confundirlos.

| Concepto | Responsabilidad |
|---|---|
| File System | Organizar y permitir el acceso a archivos y directorios |
| File Explorer / Finder | Proporcionar una interfaz gráfica para navegar |
| Terminal | Proporcionar una interfaz de texto |
| Shell | Interpretar las instrucciones utilizadas para navegar |

**Finder o File Explorer no son el File System. Son aplicaciones que permiten interactuar con él.**

---

# 4. ¿Qué es un File?

Un **File** es una unidad de información almacenada y administrada mediante el sistema de archivos.

Puede contener:

- Código fuente.
- Texto.
- Imágenes.
- Vídeos.
- Configuraciones.
- Datos.
- Programas.

Por ejemplo:

```text
README.md
index.ts
package.json
logo.png
config.yaml
```

## 4.1 File Name

Es el nombre utilizado para identificar un archivo dentro de un directorio.

Ejemplo:

```text
index.ts
```

## 4.2 File Extension

Es la parte del nombre que, por convención, aparece después de un punto final.

Ejemplos:

| Archivo | Extensión habitual |
|---|---|
| `README.md` | `.md` |
| `index.ts` | `.ts` |
| `package.json` | `.json` |
| `styles.css` | `.css` |
| `photo.png` | `.png` |

La extensión ayuda a identificar el formato o propósito del archivo.

Sin embargo, **la extensión no determina por sí sola el contenido real ni garantiza cómo debe ejecutarse**.

## 4.3 Archivos sin extensión

También podemos encontrar:

```text
Dockerfile
Makefile
LICENSE
```

No todos los archivos necesitan una extensión.

---

# 5. ¿Qué es un Directory?

Un **Directory** es una estructura del sistema de archivos utilizada para organizar y localizar entradas como archivos y otros directorios.

También suele llamarse *Folder*.

Ejemplo:

```text
projects/
├── frontend/
├── backend/
└── tooling/
```

Aquí `projects` contiene tres subdirectorios.

## 5.1 Directory vs Folder

En el lenguaje cotidiano, ambos términos suelen utilizarse como equivalentes.

Sin embargo:

- **Directory** es el término técnico habitual en sistemas de archivos y herramientas CLI.
- **Folder** es muy común en interfaces gráficas.

## 5.2 Parent Directory

Es el directorio que contiene a otro directorio.

Ejemplo:

```text
projects/
└── frontend/
```

`projects` es el directorio padre de `frontend`.

## 5.3 Child Directory

Es un directorio contenido dentro de otro.

En el ejemplo anterior, `frontend` es un subdirectorio de `projects`.

## 5.4 Directory Tree

Es la representación jerárquica de directorios y archivos.

```text
project/
├── src/
│   ├── components/
│   └── services/
├── tests/
└── README.md
```

Esta representación será habitual en nuestro Mastery.

---

# 6. Root Directory

El **Root Directory** representa el punto superior de una jerarquía de directorios.

## 6.1 macOS y Linux

En sistemas Unix-like, la raíz se representa mediante:

```text
/
```

Ejemplo:

```text
/
├── home/
├── usr/
├── etc/
└── var/
```

## 6.2 Windows

Windows utiliza habitualmente rutas basadas en unidades.

Ejemplo:

```text
C:\
```

También pueden existir:

```text
D:\
E:\
```

Y rutas de red o ubicaciones proporcionadas por otros mecanismos.

## 6.3 ¿Root es lo mismo que Home?

No.

Root Directory y Home Directory tienen responsabilidades diferentes.

| Concepto | Significado |
|---|---|
| Root Directory | Inicio de una jerarquía de directorios |
| Home Directory | Directorio personal de un usuario |

### Idea clave

**Root identifica una raíz de navegación; Home identifica el directorio personal de un usuario.**

---

# 7. Home Directory

El **Home Directory** es el directorio personal asociado a un usuario.

Suele utilizarse para almacenar:

- Documentos personales.
- Configuraciones del usuario.
- Proyectos.
- Archivos de aplicaciones.
- Datos de herramientas.

## 7.1 macOS

Ejemplo habitual:

```text
/Users/developer
```

## 7.2 Linux

Ejemplo habitual:

```text
/home/developer
```

## 7.3 Windows

Ejemplo habitual:

```text
C:\Users\Developer
```

## 7.4 Símbolo `~`

En Bash y Zsh, `~` normalmente representa el Home Directory del usuario actual cuando se utiliza en contextos donde el Shell realiza Tilde Expansion.

Ejemplo:

```bash
cd ~
```

En PowerShell también podemos utilizar:

```powershell
Set-Location ~
```

## 7.5 ¿Home siempre tiene la misma ubicación?

No.

Depende de:

- Sistema operativo.
- Usuario.
- Configuración.
- Entorno corporativo.
- Contenedor.
- Máquina virtual.
- WSL.

**Nunca debemos asumir que todos los desarrolladores tienen el mismo Home Directory.**

---

# 8. Current Working Directory

El **Current Working Directory (CWD)** es el directorio de trabajo actual de un proceso.

Cuando utilizamos un Shell interactivo, normalmente tenemos un directorio desde el cual se interpretan las rutas relativas.

## 8.1 Ejemplo

Imagina que estamos en:

```text
/home/developer/projects
```

Y ejecutamos:

```bash
pwd
```

Obtendremos una ruta que identifica nuestro directorio actual.

## 8.2 ¿Por qué importa?

Porque muchos comandos utilizan el directorio actual como contexto.

Por ejemplo:

```bash
git status
```

Git normalmente busca el repositorio correspondiente a la ubicación desde la que ejecutamos el comando.

Otro ejemplo:

```bash
cat README.md
```

Este comando intenta leer `README.md` utilizando una ruta relativa al directorio actual.

Si estamos en otra ubicación, el resultado puede cambiar.

## 8.3 Modelo

```text
Shell Session
     │
     ▼
Current Working Directory
     │
     ▼
Relative File Operations
```

### Idea clave

**Antes de ejecutar comandos que trabajan con archivos, debemos saber en qué directorio estamos.**

---

# 9. Comando `pwd`

En Bash y Zsh, `pwd` significa:

**Print Working Directory.**

Permite consultar el directorio actual.

```bash
pwd
```

Ejemplo de resultado:

```text
/Users/developer/projects
```

## 9.1 ¿Modifica información?

No modifica intencionalmente los archivos del proyecto.

Es una operación de consulta.

## 9.2 Equivalente en PowerShell

```powershell
Get-Location
```

También suele existir el alias:

```powershell
pwd
```

Pero debemos recordar que un Alias de PowerShell puede resolver a un Cmdlet, no necesariamente al mismo ejecutable utilizado en Unix.

## 9.3 Cuándo utilizarlo

Especialmente antes de:

- Crear archivos.
- Mover directorios.
- Eliminar recursos.
- Ejecutar Scripts.
- Instalar dependencias.
- Modificar configuraciones.

---

# 10. Comando `ls`

En Bash/Zsh sobre macOS y Linux, `ls` permite listar el contenido de un directorio.

```bash
ls
```

Ejemplo:

```text
README.md  package.json  src  tests
```

## 10.1 Listar otro directorio

```bash
ls src
```

## 10.2 Listado detallado

```bash
ls -l
```

Puede mostrar información como:

- Tipo de entrada.
- Permisos.
- Propietario.
- Grupo.
- Tamaño.
- Fecha de modificación.
- Nombre.

## 10.3 Mostrar archivos ocultos

```bash
ls -a
```

## 10.4 Combinar opciones

```bash
ls -la
```

En las implementaciones habituales de `ls` en macOS y Linux, combina el listado detallado con la inclusión de entradas ocultas.

## 10.5 PowerShell

El equivalente principal es:

```powershell
Get-ChildItem
```

Para mostrar elementos ocultos:

```powershell
Get-ChildItem -Force
```

Para consultar una ubicación:

```powershell
Get-ChildItem -Path .
```

## 10.6 ¿`ls` funciona en PowerShell?

Habitualmente sí, como Alias de `Get-ChildItem`.

Pero eso no significa que todas las opciones de Unix funcionen igual.

Por ejemplo:

```bash
ls -la
```

No debe asumirse portable a PowerShell.

### Idea clave

**Podemos realizar operaciones similares en diferentes Shells, pero la sintaxis y el comportamiento no siempre coinciden.**

---

# 11. Comando `cd`

`cd` significa:

**Change Directory.**

Permite cambiar el directorio de trabajo actual del Shell.

## 11.1 Entrar en un directorio

```bash
cd projects
```

## 11.2 Entrar en un subdirectorio

```bash
cd projects/frontend
```

## 11.3 Regresar al directorio padre

```bash
cd ..
```

## 11.4 Regresar al Home Directory

```bash
cd ~
```

En Bash y Zsh, `cd` sin argumentos también suele llevarnos al Home Directory.

```bash
cd
```

## 11.5 Ir a la raíz en macOS/Linux

```bash
cd /
```

## 11.6 PowerShell

Podemos utilizar:

```powershell
Set-Location projects
```

O el alias habitual:

```powershell
cd projects
```

## 11.7 ¿Por qué `cd` suele ser un Built-in?

Porque necesita modificar el directorio actual del propio Shell.

Si ejecutáramos un programa externo que cambiara solamente su propio directorio, no cambiaría automáticamente el directorio del Shell que lo inició.

### Modelo

```text
Shell Session
    │
    ├── CWD: projects/
    │
    ▼
cd frontend
    │
    ▼
Shell Session
    │
    └── CWD: projects/frontend/
```

### Idea clave

**`cd` cambia el contexto de navegación de la sesión actual.**

---

# 12. Los símbolos `.` y `..`

Dos elementos fundamentales de navegación son:

```text
.
..
```

## 12.1 `.` — Current Directory

Representa el directorio actual en una ruta.

Ejemplo:

```bash
ls .
```

Consulta el contenido del directorio actual.

## 12.2 `..` — Parent Directory

Representa el directorio padre.

Ejemplo:

```bash
cd ..
```

## 12.3 Ejemplo visual

```text
projects/
└── frontend/
    └── src/
```

Si estamos en:

```text
projects/frontend/src
```

Entonces:

```text
.
```

representa:

```text
projects/frontend/src
```

Y:

```text
..
```

representa:

```text
projects/frontend
```

## 12.4 Subir dos niveles

```bash
cd ../..
```

Desde `src`, en el ejemplo anterior, llegaríamos a `projects`.

## 12.5 ¿Por qué debemos comprenderlos?

Porque aparecen constantemente en:

- Comandos.
- Configuraciones.
- Scripts.
- Imports.
- Rutas de archivos.
- Herramientas de desarrollo.

Estudiaremos las rutas con mayor profundidad en el siguiente documento.

---

# 13. Rutas básicas

Una **Path** identifica una ubicación dentro del sistema de archivos.

Por ejemplo:

```text
/home/developer/projects/app
```

O:

```text
C:\Users\Developer\Projects\App
```

## 13.1 Absolute Path

Identifica una ubicación desde una raíz.

Ejemplo Unix-like:

```text
/home/developer/projects
```

Ejemplo Windows:

```text
C:\Users\Developer\Projects
```

## 13.2 Relative Path

Se interpreta tomando como referencia una ubicación, normalmente el Current Working Directory.

Ejemplo:

```text
src/components
```

## 13.3 ¿Por qué importa?

Porque:

```bash
cd src
```

depende del directorio donde estamos.

En cambio:

```bash
cd /home/developer/projects/app/src
```

utiliza una ruta absoluta en un sistema Unix-like.

## 13.4 Precaución

No debemos copiar rutas de ejemplo literalmente si no existen en nuestra computadora.

El próximo documento estará dedicado completamente a este tema:

[04 — Absolute vs Relative Paths](./04-absolute-vs-relative-paths.md)

---

# 14. Archivos ocultos

En sistemas Unix-like, los nombres que comienzan con un punto suelen considerarse ocultos por convención.

Ejemplos:

```text
.gitignore
.env
.npmrc
.zshrc
```

## 14.1 ¿Por qué existen?

Muchos se utilizan para:

- Configuraciones.
- Preferencias.
- Metadatos.
- Herramientas de desarrollo.

## 14.2 ¿Son archivos especiales?

No necesariamente.

El punto inicial es una convención de nombres utilizada por muchas herramientas.

## 14.3 Consultarlos en Bash/Zsh

```bash
ls -a
```

## 14.4 Consultarlos en PowerShell

```powershell
Get-ChildItem -Force
```

## 14.5 Precaución importante

Algunos archivos ocultos pueden contener información sensible.

Por ejemplo:

```text
.env
```

Podría contener credenciales o tokens.

No debemos compartir su contenido sin revisarlo.

### Idea clave

**Oculto no significa seguro ni cifrado.**

---

# 15. Inspeccionar información de archivos

Además de listar archivos, necesitamos poder consultar sus propiedades.

## 15.1 Bash/Zsh

```bash
ls -l
```

Ejemplo ilustrativo:

```text
-rw-r--r--  1 developer staff  245 README.md
```

La salida puede incluir:

- Permisos.
- Número de enlaces.
- Propietario.
- Grupo.
- Tamaño.
- Fecha.
- Nombre.

El formato exacto depende del sistema y de la implementación de `ls`.

## 15.2 PowerShell

```powershell
Get-Item README.md
```

También podemos consultar propiedades concretas:

```powershell
Get-Item README.md | Select-Object Name, Length, LastWriteTime
```

## 15.3 ¿Por qué importa?

Porque nos permite investigar:

- Si un archivo existe.
- Cuánto ocupa.
- Cuándo se modificó.
- Qué permisos presenta.
- Qué tipo de entrada representa.

### Idea clave

**Inspeccionar un archivo no es lo mismo que modificarlo.**

---

# 16. Leer archivos desde la terminal

No siempre necesitamos abrir un editor para consultar el contenido de un archivo.

## 16.1 `cat`

En macOS/Linux:

```bash
cat README.md
```

Muestra el contenido del archivo en la salida estándar.

## 16.2 `less`

```bash
less README.md
```

Permite consultar contenido de forma paginada.

En una configuración habitual:

- Flechas: desplazamiento.
- `/`: búsqueda.
- `q`: salir.

## 16.3 `head`

```bash
head README.md
```

Muestra las primeras líneas de un archivo.

## 16.4 `tail`

```bash
tail README.md
```

Muestra las últimas líneas.

## 16.5 PowerShell

```powershell
Get-Content README.md
```

Primeras líneas:

```powershell
Get-Content README.md -TotalCount 10
```

Últimas líneas:

```powershell
Get-Content README.md -Tail 10
```

## 16.6 ¿Cuándo utilizar cada uno?

| Necesidad | Unix-like | PowerShell |
|---|---|---|
| Mostrar contenido | `cat` | `Get-Content` |
| Consultar primeras líneas | `head` | `Get-Content -TotalCount` |
| Consultar últimas líneas | `tail` | `Get-Content -Tail` |
| Navegar contenido largo | `less` | Depende de las herramientas disponibles |

### Precaución

Antes de mostrar el contenido de archivos de configuración, debemos comprobar si contienen secretos.

---

# 17. Crear directorios

Ahora comenzaremos con operaciones que modifican el sistema de archivos.

Para practicar utilizaremos una carpeta creada específicamente para ejercicios.

## 17.1 Bash/Zsh

```bash
mkdir terminal-practice
```

Crea un directorio llamado:

```text
terminal-practice
```

## 17.2 PowerShell

```powershell
New-Item -ItemType Directory -Name terminal-practice
```

## 17.3 Entrar en el directorio

Bash/Zsh:

```bash
cd terminal-practice
```

PowerShell:

```powershell
Set-Location terminal-practice
```

## 17.4 Crear subdirectorios

Bash/Zsh:

```bash
mkdir docs
```

```bash
mkdir src
```

PowerShell:

```powershell
New-Item -ItemType Directory -Name docs
```

```powershell
New-Item -ItemType Directory -Name src
```

## 17.5 Resultado

```text
terminal-practice/
├── docs/
└── src/
```

### Buena práctica

Realiza estas operaciones en un directorio de práctica, no en carpetas importantes del sistema.

---

# 18. Crear archivos

## 18.1 Bash/Zsh

Podemos utilizar:

```bash
touch README.md
```

Si el archivo no existe, normalmente lo crea vacío.

Si existe, `touch` puede actualizar sus marcas de tiempo.

Por lo tanto, no debemos asumir que es una operación sin efectos sobre archivos existentes.

## 18.2 PowerShell

```powershell
New-Item -ItemType File -Name README.md
```

## 18.3 Crear un archivo dentro de un directorio

Bash/Zsh:

```bash
touch docs/notes.md
```

PowerShell:

```powershell
New-Item -ItemType File -Path docs/notes.md
```

## 18.4 Resultado

```text
terminal-practice/
├── README.md
├── docs/
│   └── notes.md
└── src/
```

### Idea clave

**Crear un archivo es una operación de modificación y debemos conocer previamente la ruta de destino.**

---

# 19. Copiar archivos

Copiar significa crear otra entrada con el contenido del archivo de origen.

## 19.1 Bash/Zsh

```bash
cp README.md docs/README-copy.md
```

## 19.2 PowerShell

```powershell
Copy-Item README.md docs/README-copy.md
```

## 19.3 Resultado

```text
terminal-practice/
├── README.md
├── docs/
│   ├── notes.md
│   └── README-copy.md
└── src/
```

## 19.4 Precaución

Algunas operaciones de copia pueden sobrescribir destinos existentes, dependiendo del comando y sus opciones.

Antes de copiar debemos comprobar:

1. Que el origen existe.
2. Que el destino es correcto.
3. Si el destino ya contiene un archivo.
4. Qué comportamiento tendrá la herramienta.

### Idea clave

**Copiar no significa mover: el archivo original permanece disponible.**

---

# 20. Mover y renombrar archivos

Mover permite cambiar la ubicación de un archivo.

En muchos sistemas, también podemos utilizar una operación de movimiento para renombrarlo.

## 20.1 Bash/Zsh

```bash
mv docs/README-copy.md docs/guide.md
```

## 20.2 PowerShell

Para renombrar:

```powershell
Rename-Item docs/README-copy.md guide.md
```

## 20.3 Resultado

```text
terminal-practice/
├── README.md
├── docs/
│   ├── notes.md
│   └── guide.md
└── src/
```

## 20.4 Mover a otro directorio

Bash/Zsh:

```bash
mv docs/guide.md src/guide.md
```

PowerShell:

```powershell
Move-Item docs/guide.md src/guide.md
```

## 20.5 Resultado

```text
terminal-practice/
├── README.md
├── docs/
│   └── notes.md
└── src/
    └── guide.md
```

### Precaución

Los comandos de movimiento y renombrado pueden tener comportamientos diferentes si el destino ya existe.

No debemos asumir que siempre nos pedirán confirmación.

---

# 21. Eliminar archivos y directorios

Eliminar es una operación potencialmente destructiva.

Por eso la estudiaremos conceptualmente antes de utilizarla.

## 21.1 Bash/Zsh

Para eliminar un archivo:

```bash
rm archivo.txt
```

Para eliminar un directorio vacío:

```bash
rmdir directorio-vacio
```

## 21.2 PowerShell

Para eliminar un archivo:

```powershell
Remove-Item archivo.txt
```

Para eliminar un directorio vacío:

```powershell
Remove-Item directorio-vacio
```

Estos comandos son ejemplos de sintaxis, no instrucciones para ejecutarlos sobre archivos existentes.

## 21.3 Riesgos

Dependiendo de la herramienta y el entorno:

- La eliminación puede no pasar por la papelera.
- Puede no existir confirmación.
- Los archivos pueden perderse.
- Una ruta equivocada puede afectar información importante.

## 21.4 Regla profesional

Antes de eliminar:

```text
Identify Target
      │
      ▼
Verify Current Directory
      │
      ▼
Inspect Target
      │
      ▼
Understand Command
      │
      ▼
Confirm Scope
      │
      ▼
Execute
```

## 21.5 ¿Utilizaremos eliminación recursiva?

No es necesaria para esta primera práctica.

Más adelante podremos estudiar sus implicaciones dentro de los ejercicios de seguridad y Troubleshooting.

**No utilizaremos comandos de eliminación recursiva indiscriminadamente.**

---

# 22. Buscar archivos

En proyectos reales podemos tener cientos o miles de archivos.

Necesitamos mecanismos para localizarlos.

## 22.1 Bash/Zsh — `find`

Ejemplo:

```bash
find . -name "README.md"
```

Busca entradas llamadas `README.md` desde el directorio actual.

## 22.2 Buscar archivos TypeScript

```bash
find . -name "*.ts"
```

Las comillas son importantes para que el patrón sea interpretado por `find`, en lugar de expandirse previamente por el Shell.

## 22.3 PowerShell

```powershell
Get-ChildItem -Path . -Filter README.md -Recurse -File
```

Para archivos TypeScript:

```powershell
Get-ChildItem -Path . -Filter *.ts -Recurse -File
```

## 22.4 ¿Por qué es útil?

Podemos localizar:

- Configuraciones.
- Archivos de código.
- Documentación.
- Recursos.
- Tests.

## 22.5 Precaución

Las búsquedas recursivas sobre directorios grandes pueden tardar o recorrer ubicaciones que no necesitamos.

En proyectos profesionales conviene limitar el alcance cuando sea posible.

---

# 23. ¿Qué es un Symbolic Link?

Un **Symbolic Link (Symlink)** es una entrada del sistema de archivos que referencia otra ruta.

Ejemplo conceptual:

```text
current-config
      │
      ▼
configs/config-v2.json
```

No representa necesariamente una copia independiente del contenido.

## 23.1 ¿Por qué existe?

Puede utilizarse para:

- Referenciar archivos.
- Compartir ubicaciones.
- Organizar instalaciones.
- Gestionar herramientas.
- Resolver rutas de programas.

## 23.2 ¿Por qué importa para Tooling?

Porque herramientas como gestores de paquetes y administradores de versiones pueden utilizar enlaces simbólicos.

## 23.3 Precaución

Un Symlink puede apuntar a una ruta inexistente.

También puede provocar confusión cuando una herramienta sigue enlaces y otra no.

No necesitamos crear Symlinks todavía.

### Idea clave

**Una ruta puede identificar un enlace hacia otro recurso, no necesariamente el recurso final.**

---

# 24. Case Sensitivity

Los sistemas de archivos pueden diferenciar o no entre mayúsculas y minúsculas.

Consideremos:

```text
README.md
readme.md
```

En un sistema Case-sensitive pueden representar dos nombres diferentes.

En uno Case-insensitive pueden referirse a la misma entrada.

## 24.1 Linux

Los sistemas de archivos Linux utilizados habitualmente suelen ser Case-sensitive.

## 24.2 macOS

Las instalaciones habituales de macOS suelen utilizar configuraciones Case-insensitive, aunque existen opciones Case-sensitive.

## 24.3 Windows

Las configuraciones habituales de Windows suelen ser Case-insensitive, aunque pueden existir excepciones.

## 24.4 ¿Por qué importa?

Un proyecto puede funcionar localmente y fallar en CI si utiliza rutas con diferencias de mayúsculas y minúsculas.

Ejemplo conceptual:

```typescript
import { Button } from "./components/Button";
```

Pero el archivo real se llama:

```text
button.tsx
```

El resultado puede variar según el sistema de archivos y las herramientas.

### Buena práctica

**Mantener nombres y referencias consistentes, respetando exactamente las mayúsculas y minúsculas.**

---

# 25. Navegación en proyectos profesionales

Imagina esta estructura:

```text
my-workspace/
├── README.md
├── package.json
├── apps/
│   ├── web/
│   └── api/
├── packages/
│   └── shared/
└── docs/
```

## 25.1 Consultar la ubicación

```bash
pwd
```

## 25.2 Listar el contenido

```bash
ls
```

## 25.3 Entrar en una aplicación

```bash
cd apps/web
```

## 25.4 Consultar el contenido

```bash
ls
```

## 25.5 Regresar a la raíz del Workspace

```bash
cd ../..
```

## 25.6 Consultar documentación

```bash
cat README.md
```

Este es un ejemplo conceptual de navegación.

No necesitamos tener este proyecto creado.

### Aprendizaje

En un repositorio profesional debemos comprender en qué nivel de la estructura estamos trabajando.

Esto será especialmente importante cuando estudiemos Monorepos.

---

# 26. Práctica guiada — Nuestro primer Workspace

Ahora construiremos una pequeña estructura de práctica.

No utilizaremos Node.js, npm ni pnpm.

Solo comandos del sistema de archivos.

## Objetivo

Crear esta estructura:

```text
terminal-practice/
├── README.md
├── docs/
│   └── notes.md
└── src/
    └── index.txt
```

## Paso 1 — Elegir una ubicación segura

Sitúate en un directorio personal donde tengas permiso para crear archivos.

Por ejemplo, una carpeta de proyectos o ejercicios.

Consulta tu ubicación.

Bash/Zsh:

```bash
pwd
```

PowerShell:

```powershell
Get-Location
```

## Paso 2 — Crear el directorio principal

Bash/Zsh:

```bash
mkdir terminal-practice
```

PowerShell:

```powershell
New-Item -ItemType Directory -Name terminal-practice
```

Si ya existe un directorio con ese nombre, no lo sobrescribas ni lo elimines.

Elige otro nombre para la práctica.

## Paso 3 — Entrar en el directorio

Bash/Zsh:

```bash
cd terminal-practice
```

PowerShell:

```powershell
Set-Location terminal-practice
```

## Paso 4 — Crear subdirectorios

Bash/Zsh:

```bash
mkdir docs
mkdir src
```

PowerShell:

```powershell
New-Item -ItemType Directory -Name docs
New-Item -ItemType Directory -Name src
```

## Paso 5 — Crear archivos

Bash/Zsh:

```bash
touch README.md
touch docs/notes.md
touch src/index.txt
```

PowerShell:

```powershell
New-Item -ItemType File -Name README.md
New-Item -ItemType File -Path docs/notes.md
New-Item -ItemType File -Path src/index.txt
```

## Paso 6 — Verificar la estructura

Bash/Zsh:

```bash
ls
```

```bash
ls docs
```

```bash
ls src
```

PowerShell:

```powershell
Get-ChildItem
```

```powershell
Get-ChildItem docs
```

```powershell
Get-ChildItem src
```

## Paso 7 — Navegar

Entra en `src`.

```bash
cd src
```

Consulta tu ubicación.

```bash
pwd
```

Regresa al directorio padre.

```bash
cd ..
```

## Paso 8 — Reflexión

Responde:

1. ¿Qué directorio creamos?
2. ¿Qué archivos contiene?
3. ¿Qué comando utilizamos para navegar?
4. ¿Qué representa `..`?
5. ¿Cómo verificamos que los archivos existen?
6. ¿Qué operaciones modificaron el sistema?
7. ¿Qué operaciones fueron de consulta?

### Resultado esperado

Haber creado y recorrido una estructura de directorios sencilla.

---

# 27. Práctica guiada — Copiar y renombrar

Continuaremos dentro de `terminal-practice`.

## Paso 1 — Verificar la ubicación

Bash/Zsh:

```bash
pwd
```

PowerShell:

```powershell
Get-Location
```

Comprueba que estás en el directorio de práctica.

## Paso 2 — Copiar un archivo

Bash/Zsh:

```bash
cp README.md docs/README-copy.md
```

PowerShell:

```powershell
Copy-Item README.md docs/README-copy.md
```

## Paso 3 — Verificar

Bash/Zsh:

```bash
ls docs
```

PowerShell:

```powershell
Get-ChildItem docs
```

## Paso 4 — Renombrar

Bash/Zsh:

```bash
mv docs/README-copy.md docs/guide.md
```

PowerShell:

```powershell
Rename-Item docs/README-copy.md guide.md
```

## Paso 5 — Verificar nuevamente

Bash/Zsh:

```bash
ls docs
```

PowerShell:

```powershell
Get-ChildItem docs
```

## Reflexión

1. ¿Cuál fue la diferencia entre copiar y renombrar?
2. ¿El archivo original continúa existiendo?
3. ¿Qué sucedería si el destino ya existiera?
4. ¿Por qué debemos comprobar la ruta antes de ejecutar el comando?

---

# 28. Práctica guiada — Buscar archivos

Dentro de `terminal-practice`, buscaremos los archivos que creamos.

## Bash/Zsh

```bash
find . -name "*.md"
```

## PowerShell

```powershell
Get-ChildItem -Path . -Filter *.md -Recurse -File
```

## Resultado esperado

Deberíamos localizar archivos como:

```text
README.md
notes.md
guide.md
```

La representación exacta dependerá del comando y del Shell.

## Reflexión

1. ¿Qué representa `.`?
2. ¿Qué significa el patrón `*.md`?
3. ¿Por qué utilizamos comillas en el ejemplo de `find`?
4. ¿Qué significa realizar una búsqueda recursiva?

---

# 29. Casos reales de ingeniería

## Caso 1 — `package.json` no existe

### Situación

Ejecutamos un comando desde un directorio equivocado.

La herramienta indica que no encuentra `package.json`.

### Posible causa

Estamos trabajando fuera de la raíz esperada del proyecto.

### Diagnóstico

```bash
pwd
```

```bash
ls
```

### Aprendizaje

**El Current Working Directory influye directamente en el comportamiento de muchas herramientas.**

---

## Caso 2 — Un archivo existe, pero no aparece

### Situación

Buscamos:

```text
.env
```

Pero no aparece en un listado normal.

### Posible causa

Es un archivo oculto por convención.

### Diagnóstico

```bash
ls -a
```

### Aprendizaje

No todos los archivos aparecen en los listados predeterminados.

---

## Caso 3 — Una ruta funciona en Windows, pero falla en Linux

### Situación

Una herramienta utiliza una ruta con diferencias de mayúsculas y minúsculas.

### Posible causa

El sistema de archivos utiliza reglas distintas de Case Sensitivity.

### Aprendizaje

Las rutas deben escribirse de forma consistente.

---

## Caso 4 — Se copia un archivo sobre otro

### Situación

Ejecutamos una copia sin verificar el destino.

### Problema

El archivo de destino podría ser sobrescrito.

### Aprendizaje

Antes de operaciones de modificación debemos comprobar origen y destino.

---

## Caso 5 — Un proyecto funciona en la raíz, pero falla desde un subdirectorio

### Situación

Una herramienta espera archivos relativos al Current Working Directory.

### Posible causa

Estamos ejecutando el comando desde una ubicación diferente.

### Aprendizaje

No todas las herramientas resuelven rutas desde la ubicación del archivo que ejecutan.

---

# 30. Errores frecuentes

### Error 1 — Confundir Root y Home

Root es la raíz de una jerarquía; Home es el directorio personal.

### Error 2 — No verificar el Current Working Directory

Podemos ejecutar operaciones sobre una ubicación equivocada.

### Error 3 — Pensar que `cd` modifica archivos

`cd` cambia el directorio de trabajo del Shell.

### Error 4 — Pensar que `.` y `..` son nombres arbitrarios

Tienen significados especiales en la navegación.

### Error 5 — Ignorar archivos ocultos

Podemos pasar por alto configuraciones importantes.

### Error 6 — Copiar rutas de tutoriales literalmente

Las ubicaciones dependen del usuario y del sistema.

### Error 7 — Asumir que `ls -la` funciona igual en PowerShell

Las opciones no son necesariamente portables.

### Error 8 — Confundir copiar con mover

Copiar conserva el origen; mover cambia la ubicación de la entrada.

### Error 9 — Eliminar sin comprobar la ruta

Puede producir pérdida de información.

### Error 10 — Ignorar Case Sensitivity

Puede generar fallos entre entornos.

### Error 11 — Pensar que un archivo oculto es seguro

Puede contener secretos sin estar cifrado.

### Error 12 — Confundir File System con File Explorer

Uno organiza archivos; el otro permite explorarlos gráficamente.

### Error 13 — Utilizar privilegios elevados innecesariamente

No debemos recurrir a `sudo` o ejecución como administrador para operaciones normales de práctica.

### Error 14 — No comprobar si un destino existe

Podemos provocar sobrescrituras o errores.

### Error 15 — Trabajar directamente sobre archivos importantes

Los ejercicios deben realizarse en ubicaciones controladas.

---

# 31. Comprueba tu modelo mental

1. ¿Qué es un File System?
2. ¿Qué diferencia existe entre File System y File Explorer?
3. ¿Qué es un File?
4. ¿Qué es un Directory?
5. ¿Qué diferencia existe entre Directory y Folder?
6. ¿Qué es un Parent Directory?
7. ¿Qué es un Child Directory?
8. ¿Qué es Root Directory?
9. ¿Qué es Home Directory?
10. ¿Root y Home son equivalentes?
11. ¿Qué es Current Working Directory?
12. ¿Qué hace `pwd`?
13. ¿Qué hace `ls`?
14. ¿Qué hace `cd`?
15. ¿Por qué `cd` suele ser un Built-in?
16. ¿Qué representa `.`?
17. ¿Qué representa `..`?
18. ¿Qué significa `../..`?
19. ¿Qué es una Path?
20. ¿Qué diferencia existe entre Absolute Path y Relative Path?
21. ¿Qué son los archivos ocultos?
22. ¿Qué hace `ls -a`?
23. ¿Qué hace `Get-ChildItem -Force`?
24. ¿Qué hace `cat`?
25. ¿Qué hace `less`?
26. ¿Qué hace `head`?
27. ¿Qué hace `tail`?
28. ¿Qué hace `mkdir`?
29. ¿Qué hace `touch`?
30. ¿Qué hace `cp`?
31. ¿Qué hace `mv`?
32. ¿Qué hace `rm`?
33. ¿Qué diferencia existe entre copiar y mover?
34. ¿Por qué debemos verificar rutas antes de eliminar?
35. ¿Qué es un Symlink?
36. ¿Qué es Case Sensitivity?
37. ¿Por qué puede fallar una ruta en Linux y funcionar en Windows?
38. ¿Cómo buscarías un archivo llamado `README.md`?
39. ¿Cómo verificarías que estás en la raíz de un proyecto?
40. ¿Por qué la navegación será importante cuando estudiemos Monorepos?

---

# 32. Checklist de aprendizaje

## File System Fundamentals

- [ ] Comprendo qué es un File System.
- [ ] Diferencio File y Directory.
- [ ] Comprendo una estructura jerárquica.
- [ ] Identifico Root Directory.
- [ ] Identifico Home Directory.
- [ ] Comprendo Current Working Directory.

## Navigation

- [ ] Sé utilizar `pwd`.
- [ ] Sé utilizar `ls`.
- [ ] Sé utilizar `cd`.
- [ ] Comprendo `.`.
- [ ] Comprendo `..`.
- [ ] Puedo navegar entre directorios.
- [ ] Conozco los equivalentes básicos de PowerShell.

## File Inspection

- [ ] Sé listar archivos ocultos.
- [ ] Sé consultar información de archivos.
- [ ] Sé leer archivos desde la terminal.
- [ ] Comprendo las diferencias entre `cat`, `less`, `head` y `tail`.

## File Operations

- [ ] Puedo crear un directorio.
- [ ] Puedo crear un archivo.
- [ ] Puedo copiar archivos.
- [ ] Puedo mover archivos.
- [ ] Puedo renombrar archivos.
- [ ] Comprendo los riesgos de eliminación.
- [ ] Verifico rutas antes de modificar información.

## Professional Practices

- [ ] Comprendo Case Sensitivity.
- [ ] Sé qué es un Symlink.
- [ ] Distingo operaciones Read-only y Mutating.
- [ ] Trabajo dentro de directorios de práctica.
- [ ] Puedo navegar por una estructura de proyecto.
- [ ] Comprendo por qué el Current Working Directory importa.

---

# 33. Resumen conceptual

Nuestro modelo mental de navegación queda así:

```text
Operating System
       │
       ▼
File System
       │
       ├── Files
       │
       ├── Directories
       │
       └── Paths
              │
              ▼
      Shell Session
              │
              ▼
   Current Working Directory
              │
              ▼
        File Operations
              │
              ├── Navigate
              ├── List
              ├── Inspect
              ├── Create
              ├── Copy
              ├── Move
              └── Delete
```

Cada operación tiene una responsabilidad.

Y no todas presentan el mismo nivel de riesgo.

---

# 34. Idea clave

**Dominar la navegación por el sistema de archivos significa comprender dónde estamos, cómo se organizan los recursos y qué consecuencias tienen nuestras operaciones.**

Antes de modificar archivos, debemos saber:

- Nuestra ubicación actual.
- La ruta del recurso.
- La operación que ejecutaremos.
- Los posibles efectos.
- Cómo verificar el resultado.

Esta habilidad será fundamental para trabajar posteriormente con:

- Git.
- Node.js.
- npm y pnpm.
- TypeScript.
- Build Tools.
- Testing.
- Monorepos.
- Nx.

---

# 35. Siguiente paso

Ahora que sabemos navegar por el sistema de archivos, necesitamos profundizar en cómo se identifican las ubicaciones.

En el siguiente documento aprenderemos:

- Absolute Paths.
- Relative Paths.
- Root Paths.
- Home Paths.
- Path Separators.
- Path Resolution.
- Espacios y caracteres especiales.
- Diferencias entre macOS, Linux y Windows.
- Errores habituales relacionados con rutas.

👉 [04 — Absolute vs Relative Paths](./04-absolute-vs-relative-paths.md)

**Primero aprendimos a navegar. Ahora comprenderemos con precisión cómo funcionan las rutas.**