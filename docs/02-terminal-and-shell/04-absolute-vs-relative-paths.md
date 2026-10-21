# Absolute vs Relative Paths

> **Developer Tooling Mastery 2026 — Module 02**
>
> **Topic 04:** Absolute vs Relative Paths  
> **Level:** Beginner → Professional Foundations  
> **Prerequisites:** [03 — File System Navigation](./03-file-system-navigation.md)

---

## 1. Introducción

En el documento anterior aprendimos a navegar por el sistema de archivos utilizando comandos como:

```bash
pwd
ls
cd
```

También conocimos los conceptos de **Root Directory**, **Home Directory** y **Current Working Directory**.

Ahora necesitamos profundizar en un concepto que utilizaremos constantemente durante nuestra carrera como ingenieros de software: **las rutas de archivos, conocidas como Paths**.

Observa estas tres rutas:

```text
/Users/developer/projects/my-app/src/index.ts
```

```text
src/index.ts
```

```text
../shared/index.ts
```

Las tres pueden identificar archivos, pero no funcionan de la misma manera.

La primera es una ruta absoluta de estilo Unix.

Las otras dos son rutas relativas.

Para entender su diferencia, debemos responder:

- ¿Desde dónde comienza una ruta?
- ¿Qué significa resolver una ruta?
- ¿Por qué algunas rutas dependen del directorio actual?
- ¿Qué ocurre cuando ejecutamos un Script desde otra carpeta?
- ¿Por qué una ruta funciona en macOS, pero falla en Windows?
- ¿Cómo podemos construir rutas portables?
- ¿Qué relación tienen las rutas con Node.js y los Monorepos?

**El objetivo de este documento es aprender a razonar sobre rutas, no simplemente memorizar cómo escribirlas.**

---

## 2. Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Explicar qué es un Path.
2. Diferenciar Absolute Path y Relative Path.
3. Comprender cómo se resuelve una ruta.
4. Identificar el papel del Current Working Directory.
5. Utilizar correctamente `.` y `..`.
6. Comprender Root Directory y Home Directory.
7. Diferenciar Path Separators entre sistemas operativos.
8. Reconocer las particularidades de las rutas en Windows.
9. Comprender Tilde Expansion.
10. Trabajar con rutas que contienen espacios.
11. Identificar rutas normalizadas.
12. Comprender los conceptos de Path Joining y Path Resolution.
13. Diferenciar Working Directory y Script Directory.
14. Reconocer problemas de portabilidad.
15. Comprender cómo se utilizan las rutas en proyectos JavaScript y TypeScript.
16. Aplicar buenas prácticas profesionales para evitar errores.

---

# 3. ¿Qué es un Path?

Un **Path** es una representación utilizada para identificar una ubicación dentro de un sistema de archivos.

Puede identificar:

- Un archivo.
- Un directorio.
- Un enlace simbólico.
- Otro tipo de entrada del sistema de archivos.

Ejemplo:

```text
projects/my-app/src/index.ts
```

Podemos interpretar sus componentes:

```text
projects/
    │
    └── my-app/
          │
          └── src/
                │
                └── index.ts
```

Cada segmento representa una parte del recorrido hacia el recurso.

## 3.1 Path Components

Una ruta puede contener diferentes componentes.

Por ejemplo:

```text
/home/developer/projects/app/src/index.ts
```

| Componente | Significado |
|---|---|
| `/` | Root Directory |
| `home` | Directorio |
| `developer` | Directorio |
| `projects` | Directorio |
| `app` | Directorio |
| `src` | Directorio |
| `index.ts` | Archivo |

## 3.2 ¿Una ruta garantiza que el archivo existe?

No.

Podemos escribir:

```text
/home/developer/projects/non-existent-file.ts
```

Aunque no exista ningún archivo en esa ubicación.

Una ruta es una representación de una ubicación; su existencia debe comprobarse.

## 3.3 ¿Una ruta siempre identifica un único recurso?

No necesariamente en todos los contextos.

Su interpretación puede depender de:

- Sistema operativo.
- Sistema de archivos.
- Directorio de trabajo.
- Enlaces simbólicos.
- Configuración.
- Permisos.
- Reglas de resolución de la herramienta.

### Idea clave

**Un Path describe una ubicación; el entorno determina cómo se interpreta y si puede accederse a ella.**

---

# 4. Absolute Path

Un **Absolute Path** es una ruta que identifica una ubicación desde una raíz reconocida por el sistema.

No depende del Current Working Directory para determinar su ubicación.

## 4.1 Ejemplo en macOS

```text
/Users/developer/projects/my-app/src/index.ts
```

## 4.2 Ejemplo en Linux

```text
/home/developer/projects/my-app/src/index.ts
```

## 4.3 Ejemplo en Windows

```text
C:\Users\Developer\Projects\my-app\src\index.ts
```

## 4.4 Modelo conceptual

```text
Root
 │
 └── Users
      │
      └── developer
           │
           └── projects
                │
                └── my-app
                     │
                     └── src
                          │
                          └── index.ts
```

## 4.5 ¿Por qué se llama Absolute?

Porque identifica la ubicación desde una raíz, sin necesitar conocer el directorio de trabajo actual.

Por ejemplo, en macOS:

```bash
cd /Users/developer/projects/my-app
```

Si esa ruta existe y tenemos permisos, el comando puede utilizarla independientemente de nuestro directorio actual.

## 4.6 Ventajas

- Identifica una ubicación concreta dentro del entorno.
- No depende del CWD.
- Facilita ciertos diagnósticos.
- Resulta útil para inspeccionar configuraciones locales.

## 4.7 Desventajas

- Puede contener nombres de usuario.
- Puede depender de una máquina específica.
- Puede cambiar entre sistemas operativos.
- Puede dificultar la portabilidad de proyectos.

### Idea clave

**Absolute no significa Portable.**

Una ruta absoluta puede ser válida en tu computadora y no existir en la de otro desarrollador.

---

# 5. Relative Path

Un **Relative Path** es una ruta cuya interpretación depende de una ubicación de referencia.

En operaciones habituales del Shell, esa referencia es el **Current Working Directory**.

Ejemplo:

```text
src/index.ts
```

Esta ruta no nos indica por sí sola dónde se encuentra el archivo.

Necesitamos conocer desde dónde se está interpretando.

## 5.1 Ejemplo

Supongamos que estamos en:

```text
/home/developer/projects/my-app
```

Y utilizamos:

```text
src/index.ts
```

La ruta se interpreta como:

```text
/home/developer/projects/my-app/src/index.ts
```

## 5.2 Otro contexto

Ahora supongamos que estamos en:

```text
/home/developer/projects
```

La misma ruta:

```text
src/index.ts
```

se interpretaría respecto a ese directorio:

```text
/home/developer/projects/src/index.ts
```

No necesariamente existe allí.

## 5.3 Modelo

```text
Current Working Directory
          │
          ▼
       my-app/
          │
          ▼
        src/
          │
          ▼
       index.ts
```

## 5.4 Ventajas

- Favorece la portabilidad cuando se utiliza una referencia estable.
- Evita codificar rutas personales.
- Facilita la organización de proyectos.
- Es habitual en Scripts y configuraciones.

## 5.5 Desventajas

- Depende del contexto de resolución.
- Puede fallar si cambia el directorio de trabajo.
- Puede resultar confusa en estructuras profundas.
- Diferentes herramientas pueden utilizar referencias diferentes.

### Idea clave

**Una Relative Path solo tiene sentido completo cuando conocemos desde dónde se resuelve.**

---

# 6. Absolute vs Relative Paths

Veamos una comparación directa.

| Característica | Absolute Path | Relative Path |
|---|---|---|
| Punto de referencia | Raíz | Ubicación de referencia |
| Depende del CWD | No, si es completamente absoluta | Habitualmente sí en comandos del Shell |
| Portabilidad | Generalmente menor | Potencialmente mayor |
| Ejemplo Unix | `/home/dev/app/src` | `src` |
| Ejemplo Windows | `C:\Users\Dev\App` | `src` |
| Uso habitual | Diagnóstico y ubicaciones concretas | Proyectos, Scripts y configuraciones |

## 6.1 ¿Cuál deberíamos utilizar?

No existe una respuesta universal.

Depende de la responsabilidad.

Por ejemplo:

**Para navegar a una ubicación concreta del sistema:**

Una ruta absoluta puede ser conveniente.

**Para referenciar archivos dentro de un proyecto:**

Una ruta relativa suele ser más apropiada, siempre que conozcamos y controlemos su referencia.

**Para construir rutas en código:**

Conviene utilizar mecanismos de resolución adecuados para el lenguaje y el entorno.

### Regla profesional

**La elección no debe basarse únicamente en qué ruta es más corta, sino en qué referencia necesita la operación.**

---

# 7. Current Working Directory y resolución de rutas

Recordemos que **CWD** significa *Current Working Directory*.

Es el directorio de trabajo actual de un proceso.

## 7.1 Ejemplo

Tenemos:

```text
my-app/
├── README.md
├── package.json
└── src/
    └── index.ts
```

Estamos en:

```text
my-app/
```

Ejecutamos:

```bash
cat README.md
```

El Shell inicia la operación desde el directorio actual, y el programa utiliza la ruta relativa para localizar el archivo.

## 7.2 Cambiamos de directorio

```bash
cd src
```

Ahora:

```bash
cat README.md
```

intentará acceder a un archivo llamado `README.md` dentro de `src`.

Si no existe, la operación fallará.

## 7.3 Solución relativa

Desde `src`:

```bash
cat ../README.md
```

Aquí `..` permite referirse al directorio padre.

## 7.4 Modelo

```text
my-app/
├── README.md
└── src/
    └── Current Working Directory
```

```text
../README.md
 │     │
 │     └── File
 │
 └──────── Parent Directory
```

### Idea clave

**Muchos errores de rutas no se deben a archivos inexistentes, sino a referencias incorrectas.**

---

# 8. El símbolo `.`

El símbolo:

```text
.
```

representa el directorio actual dentro de una ruta.

## 8.1 Ejemplo

```bash
ls .
```

Consulta el directorio actual.

## 8.2 Ruta relativa explícita

```text
./src/index.ts
```

Indica una ruta que comienza desde el directorio actual.

## 8.3 ¿`src/index.ts` y `./src/index.ts` son equivalentes?

En muchos contextos de acceso a archivos, sí.

Ambas pueden identificar el mismo recurso.

Sin embargo, algunas herramientas distinguen sintácticamente las rutas que comienzan por `./`.

Por ejemplo, en Shells Unix-like:

```bash
./script.sh
```

solicita ejecutar un archivo ubicado en el directorio actual, sujeto a permisos y demás requisitos.

En cambio:

```bash
script.sh
```

se resuelve como un nombre de comando, utilizando las reglas del Shell y su entorno.

No debemos asumir que el directorio actual forma parte de `PATH`.

### Idea clave

**`./` puede ser importante para distinguir una ruta explícita de un nombre de comando.**

---

# 9. El símbolo `..`

El símbolo:

```text
..
```

representa el directorio padre.

## 9.1 Ejemplo

```text
projects/
└── my-app/
    └── src/
```

Si estamos en:

```text
projects/my-app/src
```

Ejecutamos:

```bash
cd ..
```

Llegamos a:

```text
projects/my-app
```

## 9.2 Subir dos niveles

```bash
cd ../..
```

Llegamos a:

```text
projects
```

## 9.3 Acceder a un archivo del directorio padre

```text
../package.json
```

## 9.4 Acceder a un directorio hermano

Supongamos:

```text
my-app/
├── src/
└── tests/
```

Estamos en:

```text
my-app/src
```

Para acceder a `tests`:

```bash
cd ../tests
```

## 9.5 Modelo

```text
my-app/
├── src/       ← Current Directory
└── tests/     ← Destination
```

```text
src
 │
 ▼
..
 │
 ▼
my-app
 │
 ▼
tests
```

### Idea clave

**`..` permite navegar por la jerarquía sin conocer una ruta absoluta completa.**

---

# 10. Root Directory y rutas absolutas

En macOS y Linux, la raíz del sistema de archivos se representa como:

```text
/
```

Por eso:

```text
/etc
```

y:

```text
/usr/local
```

son rutas absolutas.

## 10.1 Una barra inicial cambia el significado

Comparemos:

```text
projects/app
```

y:

```text
/projects/app
```

La primera es relativa.

La segunda es absoluta en sistemas Unix-like.

## 10.2 Ejemplo

Si estamos en:

```text
/home/developer
```

Entonces:

```bash
cd projects
```

intenta acceder a:

```text
/home/developer/projects
```

Pero:

```bash
cd /projects
```

intenta acceder a un directorio ubicado directamente bajo `/`.

No son equivalentes.

### Idea clave

**En sistemas Unix-like, una barra inicial normalmente indica que la ruta comienza desde Root Directory.**

---

# 11. Home Directory y Tilde Expansion

En Bash y Zsh, el símbolo:

```text
~
```

puede utilizarse para representar el Home Directory.

Por ejemplo:

```bash
cd ~
```

O:

```bash
cd ~/projects
```

## 11.1 ¿`~` es una ruta absoluta?

No exactamente.

`~` es una sintaxis que el Shell puede expandir a una ruta de directorio personal.

Por ejemplo:

```text
~/projects
```

puede expandirse a:

```text
/Users/developer/projects
```

## 11.2 Tilde Expansion

Este mecanismo se denomina:

**Tilde Expansion.**

Lo realiza el Shell en determinados contextos.

## 11.3 ¿Qué ocurre con las comillas?

En Bash y Zsh:

```bash
echo ~
```

normalmente muestra el Home Directory.

Pero:

```bash
echo "~"
```

muestra:

```text
~
```

porque las comillas impiden esa expansión en este contexto.

## 11.4 PowerShell

PowerShell también permite utilizar `~` en contextos de rutas del sistema de archivos:

```powershell
Set-Location ~
```

Sin embargo, sus reglas de interpretación no son idénticas a las de Bash o Zsh.

### Idea clave

**No debemos confundir una sintaxis de expansión del Shell con una ruta literal del sistema de archivos.**

---

# 12. Path Separators

Los **Path Separators** permiten separar los componentes de una ruta.

## 12.1 macOS y Linux

Utilizan habitualmente:

```text
/
```

Ejemplo:

```text
/home/developer/projects/app
```

## 12.2 Windows

Utiliza habitualmente:

```text
\
```

Ejemplo:

```text
C:\Users\Developer\Projects\App
```

Muchas APIs de Windows también aceptan `/` en determinados contextos, pero no debemos asumir que todas las herramientas lo interpretan igual.

## 12.3 Comparación

| Sistema | Separador habitual |
|---|---|
| macOS | `/` |
| Linux | `/` |
| Windows | `\` |

## 12.4 ¿Por qué importa?

Porque un Script que construye rutas concatenando separadores manualmente puede presentar problemas de portabilidad.

Ejemplo conceptual:

```javascript
const filePath = baseDirectory + "/src/index.ts";
```

En determinados contextos puede funcionar, pero no representa la estrategia más robusta para construir rutas del sistema de archivos.

Más adelante aprenderemos a utilizar APIs específicas para este propósito.

### Idea clave

**Los separadores de rutas son una característica del entorno y de la interfaz que interpreta la ruta.**

---

# 13. Particularidades de Windows Paths

Windows introduce conceptos adicionales.

## 13.1 Drive Letters

Ejemplo:

```text
C:\Users\Developer
```

La letra `C:` identifica una unidad o volumen mediante la convención habitual de Windows.

## 13.2 Otras unidades

Podemos encontrar:

```text
D:\Projects
```

O:

```text
E:\Backups
```

## 13.3 UNC Paths

Windows también admite rutas de red mediante convenciones UNC.

Ejemplo:

```text
\\server\shared\project
```

Estas rutas identifican recursos compartidos de red.

## 13.4 Drive-relative Paths

Existe una diferencia importante entre:

```text
C:\Projects
```

y:

```text
C:Projects
```

La primera es una ruta absoluta dentro de la unidad `C:`.

La segunda es una ruta relativa al directorio actual asociado a esa unidad en los contextos que admiten esta sintaxis.

## 13.5 Root-relative Paths

Una ruta como:

```text
\Projects
```

puede referirse a la raíz de la unidad actual, sin especificar una unidad concreta.

Por eso no todas las rutas que comienzan con una barra invertida son completamente absolutas e independientes del contexto.

### Idea clave

**En Windows debemos distinguir rutas completamente calificadas, rutas relativas a una unidad y rutas relativas a la raíz de la unidad actual.**

---

# 14. Windows, Git Bash y WSL

En Windows podemos trabajar con diferentes entornos de línea de comandos.

Cada uno puede representar las rutas de manera distinta.

## 14.1 PowerShell en Windows

Ejemplo:

```text
C:\Users\Developer\Projects
```

## 14.2 Git Bash

Una representación habitual de la unidad `C:` es:

```text
/c/Users/Developer/Projects
```

## 14.3 WSL

Una unidad Windows montada dentro de WSL suele encontrarse en:

```text
/mnt/c/Users/Developer/Projects
```

La ubicación depende de la configuración de montaje.

## 14.4 Comparación

| Entorno | Ruta de ejemplo |
|---|---|
| PowerShell Windows | `C:\Users\Developer\Projects` |
| Git Bash | `/c/Users/Developer/Projects` |
| WSL | `/mnt/c/Users/Developer/Projects` |

## 14.5 ¿Son exactamente la misma ruta?

Pueden representar ubicaciones correspondientes del almacenamiento Windows, pero los mecanismos de acceso y sus comportamientos pueden diferir.

Por ejemplo:

- Permisos.
- Rendimiento.
- Case Sensitivity.
- Herramientas disponibles.
- Interpretación de rutas.

## 14.6 Recomendación profesional

Cuando trabajamos en WSL con herramientas Linux, suele ser preferible mantener los proyectos Linux dentro del sistema de archivos de la distribución, especialmente si contienen muchas dependencias o archivos pequeños.

Ejemplo:

```text
/home/developer/projects
```

Esto ayuda a evitar determinados problemas de rendimiento e interoperabilidad.

### Idea clave

**La ruta correcta depende del entorno donde se ejecuta el programa, no únicamente del sistema operativo anfitrión.**

---

# 15. Rutas con espacios

Consideremos:

```text
My Projects/
```

En Bash o Zsh, escribir:

```bash
cd My Projects
```

no representa correctamente una única ruta.

El Shell puede interpretarlo como dos argumentos.

## 15.1 Utilizar comillas

```bash
cd "My Projects"
```

## 15.2 Escapar el espacio

En Bash/Zsh:

```bash
cd My\ Projects
```

## 15.3 PowerShell

```powershell
Set-Location "My Projects"
```

## 15.4 ¿Por qué es importante?

Porque los nombres de usuario, directorios corporativos y carpetas compartidas pueden contener espacios.

Ejemplo:

```text
C:\Users\Developer\My Projects
```

## 15.5 Buena práctica

**No debemos asumir que las rutas nunca contendrán espacios.**

En Scripts, debemos utilizar correctamente los mecanismos de Quoting y las APIs del lenguaje.

---

# 16. Caracteres especiales en rutas

Los nombres de archivos pueden contener caracteres que tienen significado especial para el Shell.

Por ejemplo, en Bash y Zsh:

```text
*
?
$
&
|
;
```

Algunos participan en:

- Globbing.
- Variable Expansion.
- Command Chaining.
- Pipes.
- Control de procesos.

## 16.1 Ejemplo

Supongamos que tenemos un archivo llamado:

```text
report final.txt
```

Para consultarlo:

```bash
cat "report final.txt"
```

## 16.2 Otro ejemplo

Si un nombre contiene caracteres especiales, puede ser necesario utilizar comillas o mecanismos de Escape.

## 16.3 ¿Todas las reglas son iguales?

No.

Bash, Zsh y PowerShell interpretan determinados caracteres de manera diferente.

## 16.4 Buena práctica

Cuando una ruta proviene de datos externos o de un usuario, debemos tratarla como información, no como código del Shell.

### Idea clave

**Una ruta válida para el sistema de archivos puede necesitar un tratamiento especial al utilizarse dentro de una línea de comandos.**

---

# 17. Path Normalization

La **Path Normalization** es el proceso de transformar una ruta a una representación más consistente según determinadas reglas.

Por ejemplo:

```text
projects/./app
```

puede simplificarse a:

```text
projects/app
```

Otro ejemplo:

```text
projects/app/../shared
```

puede simplificarse conceptualmente a:

```text
projects/shared
```

## 17.1 ¿Qué puede implicar?

Dependiendo de la implementación:

- Eliminar segmentos `.`.
- Procesar segmentos `..`.
- Normalizar separadores.
- Reducir separadores repetidos.
- Ajustar detalles sintácticos.

## 17.2 ¿Normalization significa que el archivo existe?

No.

Podemos normalizar una ruta hacia un archivo inexistente.

## 17.3 ¿Normalization resuelve Symlinks?

No necesariamente.

Una normalización puramente sintáctica no necesita consultar el sistema de archivos.

Resolver enlaces simbólicos requiere mecanismos adicionales.

### Idea clave

**Normalizar una ruta no equivale a verificar su existencia ni a determinar necesariamente su ubicación física final.**

---

# 18. Path Joining

**Path Joining** significa combinar segmentos de una ruta utilizando reglas apropiadas.

Ejemplo conceptual:

```text
Base Directory: /home/developer/projects
Child Path:     my-app/src
```

Resultado:

```text
/home/developer/projects/my-app/src
```

## 18.1 ¿Por qué no concatenar cadenas manualmente?

Porque podemos introducir errores como:

```text
/home/developer/projectsmy-app
```

O:

```text
/home/developer/projects//my-app
```

Algunas APIs pueden tolerar o normalizar ciertos casos, pero es mejor construir rutas de manera deliberada.

## 18.2 Ejemplo con Node.js

Node.js proporciona un módulo llamado `node:path`.

```javascript
import path from "node:path";

const filePath = path.join("src", "components", "Button.tsx");

console.log(filePath);
```

El resultado utiliza las convenciones del sistema operativo donde se ejecuta Node.js.

## 18.3 ¿Debemos aprender Node.js ahora?

No.

Este ejemplo es solamente una introducción conceptual.

Estudiaremos Node.js en el módulo:

```text
04-runtime-management
```

### Idea clave

**Path Joining permite construir rutas a partir de segmentos sin depender de concatenaciones manuales.**

---

# 19. Path Resolution

**Path Resolution** es el proceso de interpretar una ruta y determinar una ubicación resultante según determinadas reglas y un contexto.

## 19.1 Ejemplo conceptual

Tenemos:

```text
Base:     /home/developer/projects/app
Relative: ../shared
```

Resultado:

```text
/home/developer/projects/shared
```

## 19.2 Ejemplo con Node.js

```javascript
import path from "node:path";

const absolutePath = path.resolve("src", "index.ts");

console.log(absolutePath);
```

Si todos los segmentos son relativos, `path.resolve()` utiliza el directorio de trabajo actual del proceso como referencia.

## 19.3 Diferencia entre `join()` y `resolve()`

| Función | Responsabilidad principal |
|---|---|
| `path.join()` | Combinar y normalizar segmentos |
| `path.resolve()` | Resolver segmentos para producir una ruta absoluta |

## 19.4 Precaución

`path.resolve()` no garantiza que el archivo exista.

Tampoco equivale necesariamente a resolver Symlinks.

## 19.5 Otro detalle importante

En Node.js, un segmento absoluto posterior puede cambiar cómo `path.resolve()` interpreta los segmentos anteriores.

Por eso no debemos considerar `join()` y `resolve()` como funciones intercambiables.

### Idea clave

**Joining combina segmentos; Resolution determina una ruta resultante desde un contexto.**

---

# 20. Working Directory vs Script Directory

Este es uno de los conceptos más importantes para futuros proyectos.

Imagina:

```text
my-app/
├── README.md
├── scripts/
│   └── report.js
└── data/
    └── input.json
```

Tenemos un Script ubicado en:

```text
my-app/scripts/report.js
```

Pero lo ejecutamos desde:

```text
my-app/
```

## 20.1 Current Working Directory

Es el directorio desde el cual se está ejecutando el proceso.

En este caso:

```text
my-app/
```

## 20.2 Script Directory

Es el directorio donde está ubicado el archivo del Script.

En este caso:

```text
my-app/scripts/
```

## 20.3 ¿Son iguales?

No necesariamente.

## 20.4 Ejemplo conceptual

```text
Current Working Directory
          │
          ▼
        my-app/
          │
          └── scripts/
                │
                └── report.js
```

## 20.5 ¿Por qué importa?

Porque una ruta relativa como:

```text
data/input.json
```

puede resolverse desde el CWD si el Script utiliza una API que interpreta rutas relativas respecto a él.

No necesariamente se resolverá desde la ubicación del Script.

## 20.6 Caso con Node.js

```javascript
console.log(process.cwd());
```

Esta expresión consulta el Current Working Directory del proceso.

En Node.js, la ubicación del módulo puede obtenerse mediante otros mecanismos, que dependen del sistema de módulos utilizado.

No profundizaremos todavía en CommonJS y ES Modules.

### Idea clave

**El directorio donde está un Script y el directorio desde el cual se ejecuta son conceptos diferentes.**

---

# 21. ¿Por qué una ruta funciona localmente y falla en CI?

Imaginemos que un desarrollador utiliza:

```text
/Users/developer/projects/my-app/config.json
```

dentro de una configuración.

En su computadora funciona.

Pero el proyecto se ejecuta en CI dentro de:

```text
/home/runner/work/my-app
```

La ruta original no existe.

## 21.1 ¿Cuál es el problema?

La configuración depende de una ubicación específica de una máquina.

## 21.2 Solución conceptual

Utilizar rutas construidas a partir de referencias estables.

Por ejemplo:

- Raíz del proyecto.
- Directorio del Script.
- Directorio de trabajo controlado.
- Variables de configuración documentadas.

## 21.3 ¿Todas las rutas relativas son seguras?

No.

Una ruta relativa puede fallar si depende de un CWD que no está garantizado.

## 21.4 Regla profesional

**Una ruta portable necesita una referencia estable y conocida.**

No basta con que sea relativa.

---

# 22. Rutas en proyectos JavaScript y TypeScript

En proyectos JavaScript y TypeScript encontraremos rutas en diferentes contextos.

## 22.1 Imports

Ejemplo:

```typescript
import { Button } from "./components/Button";
```

Aquí `./components/Button` es un especificador relativo de módulo.

Su resolución normalmente se relaciona con la ubicación del módulo que realiza el Import, según las reglas del sistema de módulos y las herramientas.

No debemos confundirlo con una ruta de archivo resuelta automáticamente desde el CWD.

## 22.2 Archivos de configuración

Ejemplo conceptual:

```json
{
  "include": ["src"]
}
```

En TypeScript, las rutas de `include` se interpretan según las reglas de configuración de `tsconfig.json`, no simplemente según el directorio desde el cual se ejecuta cualquier comando.

## 22.3 Scripts

Ejemplo:

```json
{
  "scripts": {
    "dev": "vite",
    "build": "tsc"
  }
}
```

El comportamiento de las rutas dependerá de la herramienta y de cómo se invoque.

## 22.4 Variables de entorno

Podemos encontrar configuraciones que identifican directorios o archivos mediante variables de entorno.

## 22.5 Monorepos

En un Monorepo podemos tener:

```text
workspace/
├── apps/
│   ├── web/
│   └── api/
├── packages/
│   └── shared/
└── package.json
```

Una ruta relativa desde `apps/web` no significa lo mismo que una ruta relativa desde la raíz del Workspace.

### Idea clave

**Cada herramienta define desde qué referencia interpreta sus rutas. No todas utilizan el Current Working Directory.**

---

# 23. Paths y Environment Variables

En algunos casos necesitamos construir rutas utilizando variables del entorno.

## 23.1 Bash/Zsh

Ejemplo:

```bash
echo "$HOME"
```

Podemos utilizar:

```bash
cd "$HOME"
```

## 23.2 PowerShell

```powershell
$HOME
```

O:

```powershell
Set-Location $HOME
```

## 23.3 ¿Por qué utilizar variables?

Porque evitan codificar determinados valores específicos de una máquina.

Por ejemplo, el Home Directory puede variar entre usuarios.

## 23.4 Precaución

Una variable de entorno puede:

- No existir.
- Estar vacía.
- Contener espacios.
- Contener una ruta inválida.
- Tener un valor diferente entre sesiones.

### Idea clave

**Utilizar variables puede mejorar la flexibilidad, pero debemos validar sus valores y comprender su alcance.**

---

# 24. Paths y Symlinks

Recordemos que un **Symbolic Link** referencia otra ruta.

Ejemplo:

```text
workspace/
├── current-config -> configs/config-v2.json
└── configs/
    └── config-v2.json
```

## 24.1 ¿Por qué importa?

Porque una ruta puede atravesar uno o varios enlaces simbólicos.

## 24.2 Ruta lógica vs ubicación real

En determinados entornos, podemos distinguir:

- Una representación lógica de la ruta.
- Una ubicación obtenida tras resolver enlaces simbólicos.

## 24.3 ¿`pwd` siempre muestra la ruta física?

No necesariamente.

En Bash, por ejemplo, existen mecanismos para consultar rutas lógicas o físicas, sujetos al contexto y al comportamiento del comando.

## 24.4 Precaución

No debemos asumir que normalizar `..` mediante manipulación de texto siempre equivale a recorrer físicamente el sistema de archivos cuando intervienen Symlinks.

### Idea clave

**Los enlaces simbólicos pueden hacer que la estructura lógica de una ruta difiera del recorrido físico real.**

---

# 25. Seguridad: Path Traversal

Un concepto importante para el desarrollo Backend es **Path Traversal**.

Ocurre cuando una aplicación permite que una ruta proporcionada por una fuente no confiable acceda a ubicaciones fuera del directorio previsto.

Ejemplo conceptual:

```text
uploads/
```

La aplicación espera acceder únicamente a archivos dentro de ese directorio.

Pero recibe una entrada como:

```text
../private/config.json
```

Si la aplicación concatena o resuelve rutas sin controles adecuados, podría intentar acceder a recursos fuera de `uploads`.

## 25.1 ¿Por qué sucede?

Porque `..` permite navegar hacia directorios padres.

## 25.2 ¿Cómo prevenirlo conceptualmente?

- No confiar en rutas proporcionadas por usuarios.
- Definir directorios permitidos.
- Validar y restringir las ubicaciones resultantes.
- Considerar Symlinks y otros mecanismos de redirección.
- Aplicar permisos mínimos.
- Utilizar APIs seguras y controles adecuados.

## 25.3 ¿Basta con eliminar `../` de una cadena?

No.

Los problemas de Path Traversal pueden involucrar diferentes representaciones, normalizaciones y mecanismos de resolución.

Una simple sustitución de texto no es una estrategia de seguridad suficiente.

### Idea clave

**Comprender rutas también es importante para proteger aplicaciones y sistemas de archivos.**

---

# 26. Buenas prácticas profesionales

## 26.1 No codificar rutas personales en proyectos compartidos

Evitar dependencias como:

```text
/Users/developer/Desktop/project
```

cuando el proyecto necesita ejecutarse en otros entornos.

## 26.2 Identificar la referencia de resolución

Antes de utilizar una ruta relativa, preguntarnos:

**¿Relativa a qué?**

## 26.3 Utilizar APIs de rutas

En lenguajes como Node.js, preferir APIs diseñadas para construir y resolver rutas.

## 26.4 No asumir separadores universales

Especialmente cuando construimos herramientas multiplataforma.

## 26.5 Considerar espacios

Las rutas pueden contener nombres con espacios.

## 26.6 Respetar Case Sensitivity

Utilizar exactamente los nombres reales de los archivos.

## 26.7 Verificar existencia y permisos

Una ruta válida sintácticamente no garantiza que el recurso pueda utilizarse.

## 26.8 No confiar en rutas externas

Especialmente en aplicaciones que reciben rutas desde usuarios o sistemas externos.

## 26.9 Documentar referencias importantes

Por ejemplo:

- Desde qué directorio ejecutar Scripts.
- Dónde se encuentran configuraciones.
- Qué directorios utiliza una herramienta.

## 26.10 Evitar depender del CWD accidentalmente

Si una herramienta necesita una ubicación concreta, debemos establecer y documentar una referencia estable.

---

# 27. Práctica 01 — Absolute vs Relative

Utilizaremos la estructura creada en el documento anterior:

```text
terminal-practice/
├── README.md
├── docs/
│   └── notes.md
└── src/
    └── index.txt
```

Si también realizaste la práctica de copia y renombrado, puedes tener un archivo adicional llamado `guide.md`.

## Paso 1 — Entrar en el directorio de práctica

Navega hasta `terminal-practice` utilizando la ruta correspondiente a tu computadora.

## Paso 2 — Consultar el CWD

Bash/Zsh:

```bash
pwd
```

PowerShell:

```powershell
Get-Location
```

## Paso 3 — Consultar una ruta relativa

Bash/Zsh:

```bash
ls docs
```

PowerShell:

```powershell
Get-ChildItem docs
```

## Paso 4 — Entrar en `src`

```bash
cd src
```

## Paso 5 — Acceder al directorio hermano

Bash/Zsh:

```bash
ls ../docs
```

PowerShell:

```powershell
Get-ChildItem ../docs
```

## Reflexión

1. ¿Cuál era el CWD inicial?
2. ¿Qué significa `docs` desde la raíz de práctica?
3. ¿Por qué necesitamos `../docs` desde `src`?
4. ¿Qué ruta absoluta corresponde a `notes.md` en tu computadora?

---

# 28. Práctica 02 — Comprender `.` y `..`

Supongamos:

```text
workspace/
├── apps/
│   └── web/
│       └── src/
└── packages/
    └── shared/
```

Estamos en:

```text
workspace/apps/web/src
```

Sin ejecutar comandos, determina qué ubicación representan:

### Ejercicio A

```text
.
```

### Ejercicio B

```text
..
```

### Ejercicio C

```text
../..
```

### Ejercicio D

```text
../../../packages/shared
```

## Respuestas

| Ejercicio | Ubicación |
|---|---|
| A | `workspace/apps/web/src` |
| B | `workspace/apps/web` |
| C | `workspace/apps` |
| D | `workspace/packages/shared` |

### Aprendizaje

**Podemos razonar sobre rutas relativas siguiendo la jerarquía de directorios.**

---

# 29. Práctica 03 — Quoting

Esta práctica utiliza únicamente operaciones de consulta.

## Bash/Zsh

Ejecuta:

```bash
echo ~
```

Después:

```bash
echo "~"
```

Y:

```bash
echo "$HOME"
```

## PowerShell

Ejecuta:

```powershell
$HOME
```

Después:

```powershell
Write-Output '$HOME'
```

Y:

```powershell
Write-Output "$HOME"
```

## Reflexión

1. ¿Qué diferencias observas?
2. ¿Qué realiza Tilde Expansion?
3. ¿Qué diferencias existen entre comillas simples y dobles?
4. ¿Por qué no debemos asumir que una ruta se interpreta siempre literalmente?

---

# 30. Práctica 04 — Resolver rutas mentalmente

Supongamos que el CWD es:

```text
/home/developer/projects/my-app
```

Resuelve las siguientes rutas sin ejecutar comandos.

| Ruta | Resultado esperado |
|---|---|
| `src/index.ts` | `/home/developer/projects/my-app/src/index.ts` |
| `./README.md` | `/home/developer/projects/my-app/README.md` |
| `../shared` | `/home/developer/projects/shared` |
| `../../documents` | `/home/developer/documents` |
| `/etc` | `/etc` |

## Preguntas

1. ¿Cuáles son rutas relativas?
2. ¿Cuál es absoluta?
3. ¿Cuál depende del CWD?
4. ¿Qué sucede si cambiamos el CWD?
5. ¿Alguna de estas rutas garantiza que el recurso existe?

---

# 31. Práctica 05 — Working Directory vs Script Directory

Imagina esta estructura:

```text
project/
├── data/
│   └── input.json
└── scripts/
    └── process.js
```

Ejecutamos desde la raíz del proyecto:

```bash
node scripts/process.js
```

No es necesario ejecutar realmente este ejemplo.

## Preguntas

1. ¿Cuál es el Current Working Directory?
2. ¿Cuál es el Script Directory?
3. ¿Desde dónde se resolvería `data/input.json` si el código utiliza una API relativa al CWD?
4. ¿Qué sucedería si ejecutamos el Script desde `scripts/`?
5. ¿Cómo evitaríamos depender accidentalmente del CWD?

## Respuestas

1. `project/`.
2. `project/scripts/`.
3. `project/data/input.json`.
4. La misma ruta relativa podría apuntar a otra ubicación.
5. Utilizando una referencia estable y las APIs apropiadas para construir la ruta.

### Aprendizaje

**La ubicación del Script no determina automáticamente cómo se resuelven todas sus rutas relativas.**

---

# 32. Casos reales de ingeniería

## Caso 1 — Un Script funciona desde la raíz, pero no desde otra carpeta

### Situación

Un Script utiliza:

```text
./config.json
```

### Posible causa

La ruta se resuelve desde el CWD, pero el desarrollador asumió que se resolvería desde la ubicación del Script.

### Aprendizaje

Identificar siempre la referencia utilizada.

---

## Caso 2 — Una ruta absoluta falla en otra computadora

### Situación

Un archivo de configuración contiene:

```text
/Users/developer/projects/app
```

### Posible causa

La ruta pertenece a una máquina concreta.

### Aprendizaje

Evitar dependencias innecesarias de rutas personales.

---

## Caso 3 — Un Import funciona en Windows, pero falla en Linux

### Situación

El código importa:

```typescript
import "./Components/Button";
```

Pero el directorio real se llama:

```text
components/
```

### Posible causa

Diferencias de Case Sensitivity.

### Aprendizaje

Mantener consistencia exacta entre nombres y referencias.

---

## Caso 4 — Un comando falla por espacios

### Situación

Se utiliza una ruta como:

```text
My Projects
```

sin el Quoting apropiado.

### Aprendizaje

Los espacios pueden alterar la interpretación de los argumentos.

---

## Caso 5 — Una ruta de Windows se utiliza dentro de WSL

### Situación

Una herramienta Linux recibe una ruta como:

```text
C:\Users\Developer\Projects
```

### Posible causa

La herramienta espera rutas correspondientes al entorno Linux.

### Aprendizaje

Debemos utilizar las convenciones del entorno donde se ejecuta el programa.

---

## Caso 6 — Una herramienta busca archivos fuera del proyecto

### Situación

Un proceso resuelve una ruta relativa desde un directorio inesperado.

### Riesgo

Puede leer o modificar recursos que no estaban previstos.

### Aprendizaje

Las referencias de rutas deben ser explícitas y controladas.

---

# 33. Errores frecuentes

### Error 1 — Pensar que una ruta absoluta es portable

Puede depender de una máquina o sistema operativo.

### Error 2 — Pensar que una ruta relativa siempre se resuelve desde el Script

Depende de la herramienta y de la API utilizada.

### Error 3 — Confundir `.` y `..`

`.` representa el directorio actual; `..`, el padre.

### Error 4 — Confundir `~` con `/`

Home Directory y Root Directory son diferentes.

### Error 5 — Ignorar Path Separators

Las convenciones pueden variar entre sistemas.

### Error 6 — Tratar todas las rutas Windows como completamente absolutas

Existen rutas relativas a unidades y otras variantes.

### Error 7 — Ignorar Quoting

Puede dividir incorrectamente los argumentos.

### Error 8 — Confundir Path Joining con Path Resolution

Son operaciones relacionadas, pero distintas.

### Error 9 — Pensar que Path Normalization comprueba existencia

No necesariamente accede al sistema de archivos.

### Error 10 — Ignorar Symlinks

Pueden modificar el recorrido real de una ruta.

### Error 11 — No verificar Case Sensitivity

Puede generar errores entre entornos.

### Error 12 — Codificar rutas personales en configuraciones compartidas

Reduce la portabilidad.

### Error 13 — No documentar desde dónde ejecutar Scripts

Produce dependencias implícitas del CWD.

### Error 14 — Concatenar rutas sin considerar el entorno

Puede introducir errores de separadores y segmentos.

### Error 15 — Confiar en rutas externas sin validación

Puede provocar problemas de seguridad.

---

# 34. Comprueba tu modelo mental

1. ¿Qué es un Path?
2. ¿Qué componentes puede contener una ruta?
3. ¿Qué es un Absolute Path?
4. ¿Qué es un Relative Path?
5. ¿Cuál es la diferencia principal entre ambas?
6. ¿Una ruta absoluta es necesariamente portable?
7. ¿Qué es Current Working Directory?
8. ¿Por qué afecta a las rutas relativas?
9. ¿Qué representa `.`?
10. ¿Qué representa `..`?
11. ¿Qué representa `../..`?
12. ¿Qué diferencia existe entre `src` y `./src`?
13. ¿Por qué `./script.sh` puede comportarse de manera diferente a `script.sh`?
14. ¿Qué es Root Directory?
15. ¿Qué es Home Directory?
16. ¿Qué es Tilde Expansion?
17. ¿Qué sucede con `~` dentro de comillas dobles en Bash?
18. ¿Qué separador utiliza habitualmente Linux?
19. ¿Qué separador utiliza habitualmente Windows?
20. ¿Qué es una Drive Letter?
21. ¿Qué es una UNC Path?
22. ¿Qué diferencia existe entre `C:\Projects` y `C:Projects`?
23. ¿Cómo se representa habitualmente `C:` en Git Bash?
24. ¿Cómo se representa habitualmente `C:` dentro de WSL?
25. ¿Por qué debemos considerar espacios en rutas?
26. ¿Qué es Path Normalization?
27. ¿Normalization garantiza que un archivo existe?
28. ¿Qué es Path Joining?
29. ¿Qué es Path Resolution?
30. ¿Qué diferencia existe entre `path.join()` y `path.resolve()`?
31. ¿Qué es Script Directory?
32. ¿Qué diferencia existe entre Script Directory y CWD?
33. ¿Por qué un Script puede funcionar desde una carpeta y fallar desde otra?
34. ¿Desde dónde suelen resolverse los Imports relativos de módulos?
35. ¿Todas las herramientas utilizan el CWD para resolver rutas?
36. ¿Por qué las rutas absolutas pueden fallar en CI?
37. ¿Qué es Case Sensitivity?
38. ¿Qué es un Symlink?
39. ¿Qué es Path Traversal?
40. ¿Por qué no basta con eliminar `../` para prevenir Path Traversal?
41. ¿Qué ventajas ofrecen las APIs de rutas?
42. ¿Qué referencia utilizarías para un archivo interno de un proyecto?
43. ¿Cómo documentarías una dependencia del CWD?
44. ¿Por qué las rutas serán importantes en Monorepos?
45. ¿Cuál es la pregunta fundamental antes de utilizar una ruta relativa?

---

# 35. Checklist de aprendizaje

## Fundamentals

- [ ] Comprendo qué es un Path.
- [ ] Diferencio Absolute Path y Relative Path.
- [ ] Comprendo el papel del Current Working Directory.
- [ ] Distingo Root Directory y Home Directory.
- [ ] Comprendo `.` y `..`.

## Cross-platform

- [ ] Reconozco los separadores habituales.
- [ ] Comprendo las rutas de Windows.
- [ ] Conozco las diferencias entre PowerShell, Git Bash y WSL.
- [ ] Considero espacios y caracteres especiales.
- [ ] Respeto Case Sensitivity.

## Path Operations

- [ ] Comprendo Path Normalization.
- [ ] Comprendo Path Joining.
- [ ] Comprendo Path Resolution.
- [ ] Sé que resolver una ruta no garantiza su existencia.
- [ ] Reconozco el efecto de Symlinks.

## Professional Development

- [ ] Distingo Working Directory y Script Directory.
- [ ] Evito rutas personales innecesarias.
- [ ] Utilizo referencias estables.
- [ ] Comprendo la importancia de las rutas en JavaScript y TypeScript.
- [ ] Reconozco riesgos básicos de Path Traversal.
- [ ] Puedo razonar sobre rutas en un Monorepo.

---

# 36. Resumen conceptual

```text
Path
 │
 ├── Absolute Path
 │     │
 │     └── Root-based Location
 │
 └── Relative Path
       │
       └── Reference-dependent Location
```

La interpretación de una ruta puede involucrar:

```text
Path
 │
 ▼
Reference Context
 │
 ▼
Path Resolution
 │
 ▼
Resulting Location
 │
 ▼
File System Access
```

Y debemos distinguir:

```text
Current Working Directory
          ≠
     Script Directory
          ≠
       Home Directory
          ≠
      Root Directory
```

Cada concepto tiene una responsabilidad diferente.

---

# 37. Idea clave

**Una ruta no debe interpretarse de forma aislada: necesitamos comprender su referencia, las reglas de resolución y el entorno donde se utiliza.**

Este conocimiento nos permitirá evitar errores habituales al trabajar con:

- Scripts.
- Git.
- Node.js.
- TypeScript.
- Build Tools.
- Testing.
- CI/CD.
- Monorepos.
- Nx.

La pregunta profesional más importante será siempre:

**¿Desde qué ubicación y bajo qué reglas se está resolviendo esta ruta?**

---

# 38. Siguiente paso

Ahora que comprendemos las rutas y su resolución, estudiaremos cómo el Shell utiliza variables para mantener y transmitir información sobre el entorno de ejecución.

En el siguiente documento aprenderemos:

- Shell Variables.
- Environment Variables.
- Variable Expansion.
- Scope.
- Process Inheritance.
- Variables temporales.
- Diferencias entre Bash, Zsh y PowerShell.
- Buenas prácticas de seguridad.

👉 [05 — Environment Variables](./05-environment-variables.md)

**Primero comprendimos cómo localizar recursos. Ahora aprenderemos cómo los procesos reciben información sobre su entorno.**