# Clean Development Machine

## Introducción

Una computadora de desarrollo puede comenzar funcionando perfectamente y, con el tiempo, convertirse en un entorno difícil de mantener.

Imaginemos que durante varios años instalamos:

- Diferentes versiones de Node.js.
- Varios gestores de paquetes.
- Herramientas de compilación.
- Editores.
- Extensiones.
- Bases de datos.
- Contenedores.
- Herramientas de Cloud.
- Utilidades de Terminal.
- Configuraciones personales.

Cada instalación puede ser razonable individualmente.

Sin embargo, cuando no existe una estrategia, pueden aparecer problemas:

- Comandos duplicados.
- Versiones inesperadas.
- Conflictos en PATH.
- Configuraciones olvidadas.
- Procesos que consumen recursos.
- Herramientas obsoletas.
- Instalaciones difíciles de reproducir.
- Dependencias entre proyectos que no están documentadas.

En este documento aprenderemos a construir y mantener una **Clean Development Machine**.

El objetivo no es tener la menor cantidad posible de software.

El objetivo es disponer de un entorno **comprensible, controlado, seguro, mantenible y reproducible**.

Nuestra metodología será:

**Problema → Concepto → Responsabilidad → Organización → Diagnóstico → Mantenimiento → Estandarización.**

---

## 🎯 Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Explicar qué significa mantener una máquina de desarrollo limpia.
2. Diferenciar limpieza, organización y reproducibilidad.
3. Identificar las capas de software de un entorno profesional.
4. Comprender qué herramientas pertenecen al sistema, al usuario y al proyecto.
5. Diferenciar herramientas globales y dependencias locales.
6. Reconocer instalaciones duplicadas.
7. Comprender cómo se acumula deuda técnica en una computadora.
8. Organizar proyectos, configuraciones y herramientas.
9. Identificar procesos y servicios innecesarios.
10. Reconocer los riesgos de una limpieza indiscriminada.
11. Aplicar una metodología segura de auditoría.
12. Diseñar una estrategia de mantenimiento.
13. Preparar un entorno que pueda reconstruirse.
14. Documentar las decisiones importantes de configuración.

---

# 1. El problema: una computadora que acumula herramientas

Imaginemos a un desarrollador que comienza utilizando JavaScript.

Inicialmente instala:

```text
VS Code
Git
Node.js
npm
```

Posteriormente aprende React:

```text
Vite
TypeScript
ESLint
Prettier
```

Después comienza con Backend:

```text
PostgreSQL
Redis
Docker
```

Más adelante estudia Cloud:

```text
AWS CLI
Terraform
kubectl
```

Y finalmente trabaja en diferentes proyectos empresariales:

```text
Node.js 18
Node.js 20
Node.js 22
npm
pnpm
Yarn
Private Registries
Corporate VPN
```

La computadora puede terminar con múltiples instalaciones y configuraciones que se superponen.

## 1.1 ¿Es incorrecto tener muchas herramientas?

No.

Un ingeniero de software puede necesitar una cantidad considerable de herramientas.

El problema aparece cuando desconocemos:

- Qué está instalado.
- Por qué está instalado.
- Qué proyecto lo necesita.
- Cómo se actualiza.
- Cómo se elimina.
- Qué versión está activa.
- Qué configuraciones modifica.

## 1.2 Ejemplo de un entorno desorganizado

```text
Development Machine
│
├── Node.js installed manually
├── Node.js installed with Homebrew
├── Node.js managed with nvm
├── npm global packages
├── pnpm installed globally
├── pnpm managed with Corepack
├── Old PATH entries
├── Multiple Git installations
├── Unused background services
└── Undocumented configurations
```

Este entorno no necesariamente fallará de inmediato.

Pero será más difícil de comprender y mantener.

## 1.3 Ejemplo de un entorno organizado

```text
Development Machine
│
├── Operating System
│
├── System Package Manager
│
├── Runtime Version Manager
│   └── Required Runtime Versions
│
├── Development Tools
│   ├── Git
│   ├── Editor
│   └── Terminal
│
├── Project Workspaces
│   ├── Project A
│   └── Project B
│
└── Documented Configuration
```

La diferencia principal no es la cantidad de software.

Es la claridad de sus responsabilidades.

### Idea clave

**Una máquina limpia no es una máquina vacía; es una máquina cuyo entorno podemos comprender y administrar.**

---

# 2. ¿Qué es una Clean Development Machine?

Una **Clean Development Machine** es una computadora preparada para desarrollar software con una configuración organizada, controlada y mantenible.

Sus características principales son:

- Herramientas necesarias y justificadas.
- Responsabilidades claras.
- Versiones controladas.
- Configuraciones comprensibles.
- Instalaciones verificables.
- Seguridad razonable.
- Mantenimiento periódico.
- Posibilidad de reconstrucción.

## 2.1 Limpieza no significa eliminar todo

No buscamos:

```text
Clean Machine = Minimum Software
```

Buscamos:

```text
Clean Machine =
  Necessary Tools
+ Clear Ownership
+ Controlled Versions
+ Documented Configuration
+ Predictable Behavior
```

## 2.2 ¿Qué beneficios obtenemos?

**Productividad:** menos tiempo investigando conflictos.

**Estabilidad:** menor probabilidad de ejecutar versiones inesperadas.

**Seguridad:** menos software abandonado y configuraciones desconocidas.

**Mantenimiento:** actualizaciones más controladas.

**Reproducibilidad:** posibilidad de reconstruir el entorno.

**Colaboración:** requisitos más fáciles de comunicar al equipo.

---

# 3. Cleanliness vs Reproducibility vs Consistency

Estos conceptos están relacionados, pero no son idénticos.

## 3.1 Cleanliness

Se refiere a mantener el entorno organizado y comprensible.

Pregunta principal:

> ¿Entendemos qué tenemos instalado y por qué?

## 3.2 Reproducibility

Se refiere a la capacidad de reconstruir un entorno suficientemente equivalente para obtener resultados esperados.

Pregunta principal:

> ¿Podemos preparar otra máquina siguiendo requisitos documentados?

## 3.3 Consistency

Se refiere a mantener comportamientos y configuraciones coherentes entre entornos.

Pregunta principal:

> ¿Los integrantes del equipo trabajan con requisitos compatibles?

## 3.4 Comparación

| Concepto | Objetivo |
|---|---|
| Cleanliness | Organización y control |
| Reproducibility | Reconstrucción confiable |
| Consistency | Comportamiento coherente |
| Maintainability | Facilidad de mantenimiento |
| Portability | Adaptación a otros entornos |

## 3.5 Ejemplo

Podemos tener una computadora muy ordenada, pero no disponer de ninguna documentación para reconstruirla.

En ese caso tenemos organización, pero una reproducibilidad limitada.

También podemos tener un entorno reproducible mediante automatización, aunque incluya herramientas innecesarias.

### Principio

**Un entorno profesional debe buscar organización, reproducibilidad y consistencia al mismo tiempo.**

---

# 4. Las capas de una máquina de desarrollo

Para mantener el entorno organizado debemos identificar sus capas.

```text
┌─────────────────────────────────┐
│        Project Workspace        │
├─────────────────────────────────┤
│     Project Dependencies        │
├─────────────────────────────────┤
│    Runtimes / Version Managers  │
├─────────────────────────────────┤
│      Development Tools          │
├─────────────────────────────────┤
│      System Package Manager     │
├─────────────────────────────────┤
│        Operating System         │
├─────────────────────────────────┤
│           Hardware              │
└─────────────────────────────────┘
```

Cada capa tiene una responsabilidad diferente.

## 4.1 Operating System

Administra:

- Procesos.
- Memoria.
- Sistema de archivos.
- Dispositivos.
- Usuarios.
- Permisos.
- Recursos del sistema.

## 4.2 System Package Manager

Permite administrar software a nivel del sistema o del usuario, dependiendo de la herramienta.

Ejemplos:

- Homebrew.
- winget.
- apt.
- dnf.
- pacman.

## 4.3 Development Tools

Incluye herramientas generales como:

- Git.
- VS Code.
- Terminales.
- Utilidades de diagnóstico.

## 4.4 Runtime Managers

Administran versiones de entornos de ejecución.

Ejemplos:

- nvm.
- mise.

## 4.5 Project Dependencies

Son las dependencias necesarias para un proyecto.

Por ejemplo:

```text
react
typescript
vite
eslint
vitest
```

## 4.6 Project Workspace

Incluye:

- Código fuente.
- Configuraciones.
- Scripts.
- Documentación.
- Dependencias declaradas.
- Archivos de bloqueo.

### Principio

**Cuando cada herramienta tiene una responsabilidad definida, el entorno resulta más sencillo de administrar.**

---

# 5. System Tools vs User Tools vs Project Tools

Una de las decisiones más importantes consiste en determinar dónde debe administrarse una herramienta.

## 5.1 System Tools

Son herramientas que forman parte del sistema o se administran mediante mecanismos del sistema.

Ejemplos:

```text
Git
Compilers
System Utilities
```

No todas las herramientas del sistema deben instalarse manualmente.

Muchas vienen incluidas con el sistema operativo.

## 5.2 User Tools

Son herramientas administradas para un usuario.

Ejemplos:

```text
Runtime Version Manager
Personal CLI Utilities
Editor Extensions
```

## 5.3 Project Tools

Son herramientas declaradas y utilizadas por un proyecto.

Ejemplos:

```text
TypeScript
ESLint
Vite
Vitest
```

## 5.4 Comparación

| Nivel | Responsable habitual | Ejemplo |
|---|---|---|
| Sistema | Sistema operativo / administrador | Compiladores |
| Usuario | Desarrollador | Runtime Manager |
| Proyecto | Repositorio / equipo | ESLint |
| Automatización | Proyecto / plataforma CI | Build Scripts |

## 5.5 ¿Por qué importa?

Porque instalar todas las herramientas globalmente puede dificultar el control de versiones por proyecto.

### Idea clave

**Una herramienta debe instalarse en el nivel adecuado a su responsabilidad.**

---

# 6. El problema de las instalaciones duplicadas

Supongamos que tenemos Node.js instalado de tres maneras:

```text
Node.js
│
├── Manual Installer
├── System Package Manager
└── Runtime Version Manager
```

No significa automáticamente que el sistema esté dañado.

Pero debemos saber cuál instalación utilizamos.

## 6.1 ¿Qué problema puede aparecer?

Ejecutamos:

```bash
node --version
```

Y obtenemos una versión diferente a la esperada.

## 6.2 ¿Por qué?

Porque la resolución del comando puede depender de PATH y del Shell.

## 6.3 Diagnóstico en Bash

```bash
type -a node
```

```bash
command -v node
```

```bash
node --version
```

## 6.4 Diagnóstico en PowerShell

```powershell
Get-Command node -All
```

```powershell
node --version
```

## 6.5 ¿Qué debemos hacer si encontramos duplicados?

Primero identificar:

1. Quién instaló cada versión.
2. Qué proyectos la necesitan.
3. Cuál está activa.
4. Qué mecanismo la administra.
5. Qué ocurriría si eliminamos alguna.

No debemos desinstalar automáticamente una versión porque aparezca duplicada.

### Principio

**La duplicación es una señal para investigar, no una orden inmediata de eliminar.**

---

# 7. Runtime Version Management

Los proyectos pueden necesitar versiones diferentes de un Runtime.

Por ejemplo:

```text
Project A
    └── Node.js 20
```

```text
Project B
    └── Node.js 22
```

## 7.1 ¿Debemos instalar y desinstalar Node.js constantemente?

No es una estrategia recomendable.

## 7.2 ¿Qué podemos utilizar?

Un gestor de versiones.

Por ejemplo:

- nvm.
- mise.

## 7.3 Modelo

```text
Development Machine
       │
       ▼
Runtime Version Manager
       │
       ├── Node.js 20
       └── Node.js 22
              │
              ▼
         Active Project
```

## 7.4 Beneficio

Permite administrar diferentes versiones de manera más organizada.

## 7.5 Precaución

No debemos asumir que todos los gestores de versiones funcionan igual ni que utilizan las mismas rutas o archivos de configuración.

Estudiaremos estos mecanismos en profundidad en:

`04-runtime-management`

---

# 8. Global Packages vs Local Dependencies

Este concepto es especialmente importante para JavaScript y TypeScript.

## 8.1 Global Packages

Son paquetes instalados para su utilización fuera del contexto de un único proyecto, según el gestor y la configuración.

Ejemplo conceptual:

```text
Developer Environment
    │
    └── Global CLI Tool
```

## 8.2 Local Dependencies

Son dependencias declaradas dentro de un proyecto.

Ejemplo:

```json
{
  "devDependencies": {
    "typescript": "^5.0.0",
    "vite": "^6.0.0"
  }
}
```

Las versiones son únicamente ilustrativas.

## 8.3 ¿Qué problema aparece con demasiadas herramientas globales?

El proyecto puede depender de una versión instalada en nuestra computadora que no está declarada en el repositorio.

## 8.4 Ejemplo

```text
Developer A
    └── Global TypeScript Version X
```

```text
Developer B
    └── Global TypeScript Version Y
```

Si el proyecto depende de esas instalaciones, pueden aparecer diferencias.

## 8.5 Mejor enfoque

Declarar las herramientas del proyecto como dependencias cuando corresponda.

## 8.6 ¿Todas las herramientas deben ser locales?

No.

Algunas utilidades generales pueden administrarse a nivel del usuario o del sistema.

### Principio

**Las herramientas que afectan directamente al comportamiento del proyecto deben estar controladas por el proyecto siempre que sea posible.**

---

# 9. El papel de los Package Managers

No debemos confundir gestores de paquetes de diferentes capas.

## 9.1 System Package Managers

Ejemplos:

```text
Homebrew
winget
apt
dnf
pacman
```

Administran software según el sistema y su ecosistema.

## 9.2 JavaScript Package Managers

Ejemplos:

```text
npm
pnpm
Yarn
```

Administran dependencias del ecosistema JavaScript.

## 9.3 Runtime Managers

Ejemplos:

```text
nvm
mise
```

Administran versiones de Runtimes y, en algunos casos, otras herramientas.

## 9.4 Comparación

| Herramienta | Responsabilidad principal |
|---|---|
| Homebrew | Software del sistema/usuario en plataformas compatibles |
| winget | Gestión de paquetes en Windows |
| apt | Paquetes de distribuciones Debian y derivadas |
| nvm | Versiones de Node.js |
| mise | Versiones de herramientas y Runtimes |
| npm | Dependencias y paquetes JavaScript |
| pnpm | Dependencias y Workspaces JavaScript |
| Yarn | Dependencias y Workspaces JavaScript |

## 9.5 ¿Por qué importa?

Porque una herramienta puede instalarse mediante mecanismos distintos.

Debemos evitar mezclarlos sin comprender las consecuencias.

### Aprendizaje

**La limpieza comienza asignando a cada gestor una responsabilidad clara.**

---

# 10. Organizar los proyectos

Una máquina profesional necesita una organización comprensible de sus repositorios.

## 10.1 Ejemplo

```text
workspace/
│
├── personal/
│   ├── portfolio/
│   └── experiments/
│
├── learning/
│   ├── developer-tooling-mastery/
│   └── javascript-mastery/
│
└── work/
    ├── client-a/
    └── client-b/
```

Esta estructura es solamente una propuesta.

No existe una ubicación universal obligatoria.

## 10.2 ¿Qué buscamos?

- Encontrar proyectos fácilmente.
- Separar contextos.
- Reducir confusiones.
- Mantener rutas comprensibles.
- Facilitar copias de seguridad.

## 10.3 ¿Dónde guardar los proyectos?

Depende del sistema operativo y del entorno.

En macOS:

```text
~/Developer/
```

En Linux:

```text
~/projects/
```

En Windows:

```text
C:\Users\Developer\source\
```

Son ejemplos, no requisitos.

## 10.4 ¿Qué debemos evitar?

Crear múltiples copias del mismo repositorio sin comprender su propósito.

Ejemplo:

```text
project/
project-new/
project-final/
project-final-v2/
```

Esto puede dificultar saber qué copia contiene el trabajo vigente.

### Principio

**La organización de los repositorios debe permitir identificar fácilmente qué proyecto estamos utilizando.**

---

# 11. Separar proyectos personales y corporativos

En entornos profesionales podemos trabajar con:

- Repositorios personales.
- Repositorios empresariales.
- Clientes diferentes.
- Cuentas Git diferentes.
- Registries privados.
- VPN.
- Certificados.
- Configuraciones corporativas.

## 11.1 ¿Por qué conviene separarlos?

Para reducir el riesgo de:

- Utilizar credenciales equivocadas.
- Publicar código en un repositorio incorrecto.
- Mezclar configuraciones.
- Exponer información corporativa.
- Confundir identidades Git.

## 11.2 Ejemplo conceptual

```text
Development Machine
│
├── Personal Workspace
│   ├── Personal Git Identity
│   └── Personal Repositories
│
└── Corporate Workspace
    ├── Corporate Git Identity
    ├── Private Registries
    └── Corporate Repositories
```

## 11.3 ¿La separación de carpetas garantiza seguridad?

No.

La separación física de directorios ayuda a organizar, pero no constituye por sí sola un aislamiento de seguridad.

Las credenciales, permisos y políticas deben gestionarse correctamente.

## 11.4 Buenas prácticas

- Utilizar identidades Git adecuadas.
- Proteger credenciales.
- Revisar remotos antes de publicar.
- Respetar políticas corporativas.
- No versionar Tokens.

### Idea clave

**La organización del entorno también ayuda a prevenir errores operativos y de seguridad.**

---

# 12. Mantener limpio PATH

PATH es una de las configuraciones más importantes de una máquina de desarrollo.

## 12.1 Problemas frecuentes

- Rutas duplicadas.
- Directorios inexistentes.
- Instalaciones antiguas.
- Prioridades inesperadas.
- Configuraciones añadidas repetidamente.

## 12.2 Modelo

```text
PATH
│
├── Runtime Manager Paths
├── User Tools
├── System Tools
└── Other Directories
```

## 12.3 ¿Qué debemos comprobar?

- Qué directorios contiene.
- En qué orden aparecen.
- Cuáles existen.
- Qué herramientas se resuelven.
- Qué configuraciones añaden rutas.

## 12.4 Bash

```bash
echo "$PATH"
```

```bash
type -a git
```

## 12.5 PowerShell

```powershell
$env:Path
```

```powershell
Get-Command git -All
```

## 12.6 ¿Debemos eliminar entradas manualmente?

No sin identificar quién las administra.

Algunas herramientas necesitan configurar PATH para funcionar.

### Principio

**PATH debe ser comprensible, pero sus modificaciones deben realizarse con conocimiento de su origen.**

---

# 13. Mantener organizada la configuración del Shell

Los archivos de configuración pueden crecer con el tiempo.

Por ejemplo:

```text
~/.bashrc
~/.zshrc
~/.profile
```

## 13.1 Problema habitual

Copiamos configuraciones de diferentes tutoriales.

Después de meses encontramos:

```text
PATH modifications
Aliases
Runtime initialization
Prompt customization
Old tool configuration
Duplicated exports
```

## 13.2 ¿Qué debemos hacer?

Revisar periódicamente:

- Qué líneas siguen siendo necesarias.
- Qué herramienta administra cada configuración.
- Qué bloques están duplicados.
- Qué instrucciones ya no corresponden.
- Qué configuraciones son personales.

## 13.3 ¿Debemos reescribir todo desde cero?

No.

Una modificación controlada y documentada es preferible a reemplazar una configuración que funciona.

## 13.4 Buena práctica

Mantener comentarios breves cuando una configuración no resulte evidente.

Ejemplo conceptual:

```bash
# Runtime manager initialization
# Configuration managed according to official tool documentation.
```

### Idea clave

**Una configuración fácil de comprender suele ser más valiosa que una configuración excesivamente personalizada.**

---

# 14. Dotfiles

Los **Dotfiles** son archivos de configuración cuyos nombres suelen comenzar con un punto en sistemas Unix.

Ejemplos:

```text
.bashrc
.zshrc
.gitconfig
```

## 14.1 ¿Para qué sirven?

Permiten almacenar preferencias y configuraciones de herramientas.

## 14.2 ¿Podemos versionarlos?

Sí, en determinados casos.

Algunos desarrolladores mantienen repositorios personales de Dotfiles.

## 14.3 ¿Qué beneficio ofrece?

Facilita reconstruir preferencias entre computadoras.

## 14.4 ¿Qué riesgos existen?

Podríamos publicar accidentalmente:

- Tokens.
- Credenciales.
- Rutas privadas.
- Información interna.
- Configuraciones corporativas.

## 14.5 Recomendación

Versionar solamente configuraciones que sean seguras y apropiadas para compartir.

### Principio

**Los Dotfiles pueden mejorar la reproducibilidad personal, pero requieren especial cuidado con la información sensible.**

---

# 15. Procesos y servicios en segundo plano

No todas las herramientas consumen recursos solamente cuando las utilizamos.

Algunas pueden iniciar:

- Servicios.
- Daemons.
- Agentes.
- Procesos residentes.
- Sincronizadores.
- Servidores locales.

## 15.1 Ejemplo

```text
Development Machine
│
├── Database Service
├── Container Runtime
├── Background Agent
├── Editor
└── Development Server
```

## 15.2 ¿Es incorrecto tener servicios activos?

No.

Pueden ser necesarios.

## 15.3 ¿Qué debemos conocer?

- Qué proceso está activo.
- Qué herramienta lo inició.
- Qué recursos consume.
- Si debe iniciarse automáticamente.
- Cómo detenerlo de forma segura.

## 15.4 Diagnóstico en Linux

```bash
ps aux
```

## 15.5 Diagnóstico en macOS

```bash
ps aux
```

## 15.6 Diagnóstico en Windows PowerShell

```powershell
Get-Process
```

## 15.7 ¿Qué debemos evitar?

Finalizar procesos desconocidos o servicios corporativos sin comprender su responsabilidad.

### Principio

**Un entorno limpio incluye procesos controlados, no solamente archivos organizados.**

---

# 16. Cachés, archivos temporales y artefactos

Las herramientas de desarrollo pueden generar archivos automáticamente.

Ejemplos:

```text
node_modules/
dist/
build/
coverage/
.cache/
```

Su significado y ubicación dependen del proyecto y de las herramientas utilizadas.

## 16.1 ¿Son archivos innecesarios?

No necesariamente.

Algunos son esenciales para trabajar.

Otros pueden regenerarse.

## 16.2 ¿Por qué existen?

Pueden mejorar:

- Velocidad de instalación.
- Rendimiento.
- Compilación.
- Ejecución de pruebas.
- Experiencia de desarrollo.

## 16.3 ¿Debemos borrarlos periódicamente?

No como regla general.

Eliminar cachés puede provocar descargas o compilaciones costosas.

## 16.4 ¿Cuándo investigar?

Cuando encontramos:

- Problemas de almacenamiento.
- Cachés corruptas.
- Resultados inesperados.
- Artefactos obsoletos.

## 16.5 Buena práctica

Comprender qué herramienta genera cada directorio antes de eliminarlo.

### Idea clave

**No todo archivo generado es basura; muchos forman parte del funcionamiento normal de las herramientas.**

---

# 17. Uninstall vs Disable vs Keep

Al auditar una máquina podemos encontrar herramientas que ya no utilizamos.

Tenemos varias opciones.

## 17.1 Keep

Mantener la herramienta.

Apropiado cuando sigue siendo necesaria.

## 17.2 Disable

Desactivar un servicio o comportamiento automático, cuando la herramienta lo permite y es seguro hacerlo.

## 17.3 Uninstall

Desinstalar una herramienta que ya no necesitamos.

## 17.4 Comparación

| Acción | Cuándo considerarla |
|---|---|
| Keep | Herramienta necesaria |
| Disable | Servicio no requerido permanentemente |
| Uninstall | Herramienta obsoleta o innecesaria |
| Investigate | No conocemos su responsabilidad |

## 17.5 ¿Cuál es la mejor opción ante una herramienta desconocida?

**Investigate.**

### Principio

**No debemos eliminar aquello cuya función todavía desconocemos.**

---

# 18. Actualizaciones y estabilidad

Una máquina limpia también necesita mantenimiento.

Pero actualizar todo indiscriminadamente puede introducir incompatibilidades.

## 18.1 Tipos de actualizaciones

- Sistema operativo.
- Gestores de paquetes.
- Herramientas generales.
- Runtimes.
- Dependencias del proyecto.
- Extensiones.

## 18.2 ¿Debemos utilizar siempre la versión más reciente?

No necesariamente.

Un proyecto puede exigir una versión específica.

## 18.3 Ejemplo

```text
Project Requirement
       │
       ▼
Node.js 22.x
```

Actualizar a otra versión mayor sin verificar compatibilidad puede causar problemas.

## 18.4 Estrategia

1. Identificar la versión actual.
2. Revisar requisitos.
3. Consultar compatibilidad.
4. Evaluar riesgos.
5. Actualizar de manera controlada.
6. Validar.

## 18.5 Seguridad

Las actualizaciones de seguridad merecen atención prioritaria, considerando las políticas del entorno y las pruebas necesarias.

### Idea clave

**Mantener actualizado no significa cambiar versiones sin planificación.**

---

# 19. La importancia de las herramientas oficiales

Durante el desarrollo podemos encontrar múltiples tutoriales y Scripts de instalación.

## 19.1 Riesgo

Una instrucción puede:

- Estar desactualizada.
- Corresponder a otra arquitectura.
- Modificar PATH incorrectamente.
- Requerir privilegios innecesarios.
- Descargar software no confiable.

## 19.2 Recomendación

Priorizar:

1. Documentación oficial.
2. Gestores confiables.
3. Procedimientos verificables.
4. Requisitos del proyecto.
5. Políticas de la organización.

## 19.3 Comandos descargados de Internet

Debemos tener especial cuidado con instrucciones que descargan y ejecutan Scripts directamente.

Por ejemplo, patrones del tipo:

```text
Download remote script → Execute immediately
```

## 19.4 ¿Por qué?

Porque pueden ejecutar instrucciones que no hemos inspeccionado.

### Principio

**Una instalación profesional debe ser comprensible y provenir de una fuente confiable.**

---

# 20. Seguridad y privilegios

La limpieza del entorno también implica respetar los límites de seguridad.

## 20.1 Principle of Least Privilege

El principio de mínimo privilegio indica que un usuario o proceso debería disponer solamente de los permisos necesarios para su responsabilidad.

## 20.2 Ejemplo

No todas las instalaciones requieren privilegios administrativos.

## 20.3 Riesgos de utilizar privilegios innecesarios

- Modificación accidental de archivos del sistema.
- Instalaciones con propietarios inesperados.
- Cambios difíciles de revertir.
- Mayor impacto de instrucciones incorrectas.

## 20.4 Entornos corporativos

Pueden existir:

- Políticas de seguridad.
- Software administrado.
- Restricciones de instalación.
- Herramientas obligatorias.
- Certificados empresariales.

## 20.5 Recomendación

No intentar eludir controles corporativos para instalar herramientas.

### Idea clave

**Un entorno profesional debe ser mantenible sin comprometer la seguridad.**

---

# 21. Backups y recuperación

Una computadora puede fallar.

También podemos necesitar:

- Cambiar de equipo.
- Reinstalar el sistema.
- Migrar a otra plataforma.
- Recuperar configuraciones.

## 21.1 ¿Qué deberíamos poder recuperar?

- Código fuente.
- Configuraciones importantes.
- Documentación.
- Requisitos de herramientas.
- Datos locales que no puedan regenerarse.

## 21.2 ¿Qué suele poder reconstruirse?

Dependiendo del proyecto:

- Dependencias instaladas.
- Artefactos de compilación.
- Cachés.
- Herramientas obtenibles de fuentes confiables.

## 21.3 Modelo

```text
Development Machine
│
├── Source Code
│   └── Version Control / Backup
│
├── Project Configuration
│   └── Repository
│
├── Environment Documentation
│   └── Setup Guide
│
└── Rebuildable Tools
    └── Package / Runtime Managers
```

## 21.4 ¿Git es un Backup completo?

No.

Git administra versiones de archivos incluidos en el repositorio.

No reemplaza una estrategia de copias de seguridad para todos los datos importantes.

### Principio

**Una máquina bien preparada debe poder recuperarse sin depender exclusivamente de su estado actual.**

---

# 22. Documentar el entorno

No necesitamos documentar cada preferencia visual.

Debemos documentar aquello que afecte al funcionamiento.

## 22.1 Ejemplos

- Sistema operativo soportado.
- Versión de Runtime.
- Gestor de paquetes.
- Herramientas requeridas.
- Variables necesarias.
- Servicios locales.
- Comandos de instalación.
- Comandos de validación.

## 22.2 Ejemplo conceptual

```markdown
# Development Environment

## Requirements

- Git
- Supported Node.js version
- Project package manager

## Setup

1. Install required tools.
2. Select the supported runtime.
3. Install project dependencies.
4. Configure required environment variables.
5. Run validation commands.

## Validation

- Check Git version.
- Check Node.js version.
- Check package manager version.
- Run project checks.
```

## 22.3 ¿Por qué importa?

Porque reduce la dependencia del conocimiento informal.

### Idea clave

**La documentación convierte un entorno personal en un proceso que otras personas pueden reproducir.**

---

# 23. Machine Setup vs Project Setup

No debemos mezclar ambas responsabilidades.

## 23.1 Machine Setup

Prepara herramientas generales.

Ejemplos:

```text
Git
Terminal
Editor
Runtime Manager
```

## 23.2 Project Setup

Prepara un repositorio específico.

Ejemplos:

```text
Required Runtime Version
Dependencies
Environment Variables
Development Scripts
```

## 23.3 Modelo

```text
Machine Setup
      │
      ▼
General Development Capabilities
      │
      ▼
Project Setup
      │
      ▼
Project-specific Requirements
      │
      ▼
Application Ready
```

## 23.4 ¿Por qué separar?

Porque diferentes proyectos pueden necesitar configuraciones distintas sobre una misma computadora.

### Principio

**La máquina proporciona capacidades generales; el proyecto declara sus necesidades particulares.**

---

# 24. Auditoría profesional de una máquina

Antes de modificar cualquier configuración debemos realizar una auditoría.

La auditoría debe responder:

- ¿Qué sistema tenemos?
- ¿Qué Shell utilizamos?
- ¿Qué herramientas existen?
- ¿Qué versiones están activas?
- ¿Dónde se encuentran?
- ¿Qué gestores administran esas herramientas?
- ¿Qué procesos están activos?
- ¿Qué configuraciones afectan al entorno?

## 24.1 Audit Model

```text
Development Machine Audit
│
├── Operating System
├── Architecture
├── Shell
├── PATH
├── Git
├── Runtime
├── Package Managers
├── Editor
├── Active Processes
├── Project Workspaces
└── Configuration Documentation
```

## 24.2 ¿Debemos auditar todo diariamente?

No.

Una auditoría inicial y revisiones periódicas suelen ser suficientes, ajustándose a las necesidades del entorno.

---

# 25. Práctica: Environment Inventory

Esta práctica será de inspección.

No instalaremos ni eliminaremos software.

## Step 1 — Identificar sistema operativo

### macOS

```bash
sw_vers
```

### Linux

```bash
cat /etc/os-release
```

### Windows PowerShell

```powershell
Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsArchitecture
```

## Step 2 — Identificar arquitectura

### macOS / Linux

```bash
uname -m
```

### Windows PowerShell

```powershell
$env:PROCESSOR_ARCHITECTURE
```

En Windows, esta variable describe la arquitectura reportada para el contexto del proceso y no siempre basta para identificar todas las características de la arquitectura del sistema.

## Step 3 — Identificar Shell

### Bash / Zsh

```bash
echo "$SHELL"
```

### PowerShell

```powershell
$PSVersionTable
```

## Step 4 — Identificar Git

```bash
git --version
```

Si está disponible.

## Step 5 — Identificar Node.js

```bash
node --version
```

Si está disponible.

## Step 6 — Identificar npm

```bash
npm --version
```

Si está disponible.

## Step 7 — Identificar pnpm

```bash
pnpm --version
```

Si está disponible.

## Step 8 — Identificar Yarn

```bash
yarn --version
```

Si está disponible.

## Step 9 — Identificar rutas de ejecutables

### Bash

```bash
type -a git
```

```bash
type -a node
```

### PowerShell

```powershell
Get-Command git -All
```

```powershell
Get-Command node -All
```

## Step 10 — Consultar PATH

### Bash / Zsh

```bash
echo "$PATH"
```

### PowerShell

```powershell
$env:Path
```

## Step 11 — Registrar resultados

| Componente | Versión | Ubicación | Administrado por |
|---|---|---|---|
| Git | | | |
| Node.js | | | |
| npm | | | |
| pnpm | | | |
| Yarn | | | |
| Editor | | | |
| Runtime Manager | | | |

No es necesario tener todas estas herramientas instaladas.

---

# 26. Práctica: identificar herramientas duplicadas

El objetivo será identificar posibles conflictos, no eliminar instalaciones.

## Step 1 — Consultar Git

En Bash:

```bash
type -a git
```

En PowerShell:

```powershell
Get-Command git -All
```

## Step 2 — Consultar Node.js

En Bash:

```bash
type -a node
```

En PowerShell:

```powershell
Get-Command node -All
```

## Step 3 — Interpretar

Si encontramos varias rutas:

1. Identificar su origen.
2. Determinar cuál se utiliza.
3. Consultar versiones.
4. Revisar requisitos de proyectos.
5. Documentar posibles conflictos.

## Step 4 — Registrar

| Herramienta | Instalaciones detectadas | Instalación activa | ¿Requiere revisión? |
|---|---|---|---|
| Git | | | |
| Node.js | | | |

### Aprendizaje

**La auditoría permite tomar decisiones informadas sin modificar innecesariamente el entorno.**

---

# 27. Práctica: diseñar nuestra máquina profesional

Ahora realizaremos un ejercicio de arquitectura.

Imaginemos que necesitamos trabajar con:

- React.
- TypeScript.
- Node.js.
- PostgreSQL.
- Docker.
- Git.
- CI/CD.
- AWS.

## 27.1 Clasificar herramientas

| Herramienta | Nivel principal | Justificación |
|---|---|---|
| Git | Sistema/usuario | Control de versiones general |
| VS Code | Usuario | Editor |
| Node.js | Runtime | Ejecución JavaScript |
| Runtime Manager | Usuario | Administración de versiones |
| pnpm | Usuario/proyecto | Gestión de paquetes según estrategia |
| TypeScript | Proyecto | Compilación y comprobación de tipos |
| ESLint | Proyecto | Análisis estático |
| PostgreSQL | Servicio/entorno | Base de datos |
| Docker | Sistema/usuario | Entornos de contenedores |
| AWS CLI | Usuario/entorno | Interacción con AWS |

La clasificación puede variar según la arquitectura del equipo y las políticas corporativas.

## 27.2 Modelo propuesto

```text
Professional Development Machine
│
├── Operating System
│
├── Essential Tools
│   ├── Git
│   ├── Terminal
│   └── VS Code
│
├── Runtime Management
│   └── Node.js Versions
│
├── Development Infrastructure
│   ├── Containers
│   └── Database Services
│
├── Cloud Tools
│   └── AWS CLI
│
└── Projects
    │
    ├── React Application
    │   ├── TypeScript
    │   ├── ESLint
    │   └── Build Tool
    │
    └── Node.js API
        ├── TypeScript
        ├── Testing
        └── Project Dependencies
```

## 27.3 Reflexión

¿Por qué no instalar TypeScript, ESLint y todas las herramientas de Build globalmente como única fuente para todos los proyectos?

Porque cada proyecto puede necesitar versiones y configuraciones diferentes.

### Aprendizaje

**La arquitectura de nuestro entorno debe respetar los límites entre herramientas generales y dependencias del proyecto.**

---

# 28. Maintenance Routine

Una máquina profesional necesita mantenimiento periódico.

No tiene que convertirse en una actividad diaria.

## 28.1 Weekly Review

Revisión ligera:

- ¿Existe algún problema reciente?
- ¿Hay procesos de desarrollo olvidados?
- ¿Aparecieron herramientas que ya no necesitamos?
- ¿Tenemos configuraciones nuevas sin documentar?

## 28.2 Monthly Review

Revisión más amplia:

- Actualizaciones relevantes.
- Versiones de herramientas.
- Espacio disponible.
- Instalaciones duplicadas.
- Extensiones.
- Servicios.
- Documentación.

## 28.3 Project Transition Review

Al terminar un proyecto:

- Identificar herramientas exclusivas de ese proyecto.
- Revisar servicios locales.
- Verificar datos que deban conservarse.
- Documentar requisitos importantes.
- Decidir qué configuraciones mantener.

## 28.4 Machine Migration Review

Antes de cambiar de computadora:

- Verificar repositorios.
- Verificar Backups.
- Documentar herramientas.
- Revisar credenciales.
- Preparar instrucciones de instalación.
- Comprobar acceso a servicios necesarios.

### Principio

**El mantenimiento periódico es más seguro y sencillo que una limpieza masiva después de años de acumulación.**

---

# 29. Clean Machine Checklist

## Operating System

- [ ] Conozco mi sistema operativo.
- [ ] Conozco su arquitectura.
- [ ] Mantengo actualizaciones de seguridad apropiadas.
- [ ] Comprendo las políticas de mi entorno.

## Development Tools

- [ ] Sé qué herramientas esenciales tengo instaladas.
- [ ] Conozco sus versiones.
- [ ] Sé qué mecanismo las administra.
- [ ] No mantengo instalaciones duplicadas sin justificación.

## Runtime Management

- [ ] Conozco qué Runtime utiliza cada proyecto.
- [ ] Puedo identificar la versión activa.
- [ ] Comprendo cómo se selecciona una versión.
- [ ] Evito conflictos de instalaciones.

## Package Management

- [ ] Distingo gestores del sistema y del proyecto.
- [ ] Conozco el gestor de paquetes de cada repositorio.
- [ ] Evito dependencias globales innecesarias.
- [ ] Respeto los Lockfiles del proyecto.

## Shell Configuration

- [ ] Comprendo qué Shell utilizo.
- [ ] Sé dónde están sus archivos de configuración.
- [ ] Puedo consultar PATH.
- [ ] Evito configuraciones duplicadas.
- [ ] No almaceno secretos en archivos compartidos.

## Projects

- [ ] Mantengo una organización comprensible.
- [ ] Distingo proyectos personales y corporativos.
- [ ] Conozco los repositorios activos.
- [ ] Evito copias ambiguas.
- [ ] Documento los requisitos importantes.

## Maintenance

- [ ] Conozco los servicios de desarrollo activos.
- [ ] Reviso herramientas obsoletas.
- [ ] No elimino archivos sin identificar su función.
- [ ] Mantengo copias de seguridad apropiadas.
- [ ] Puedo reconstruir los componentes esenciales de mi entorno.

---

# 30. Errores comunes

### 1. Instalar todas las herramientas disponibles

Más herramientas no significan necesariamente mayor productividad.

### 2. Confundir limpieza con desinstalación masiva

Eliminar software indiscriminadamente puede romper proyectos.

### 3. Instalar Node.js mediante múltiples mecanismos sin comprenderlos

Puede generar conflictos de resolución.

### 4. Instalar todas las herramientas JavaScript globalmente

Puede ocultar dependencias reales del proyecto.

### 5. Modificar PATH repetidamente

Puede introducir duplicaciones y prioridades inesperadas.

### 6. Copiar configuraciones de Shell sin comprenderlas

Dificulta el mantenimiento.

### 7. Mantener servicios desconocidos en segundo plano

Reduce la visibilidad sobre el consumo de recursos.

### 8. Eliminar cachés constantemente

Puede empeorar el rendimiento sin resolver ningún problema.

### 9. Actualizar Runtimes sin revisar requisitos

Puede introducir incompatibilidades.

### 10. Utilizar privilegios administrativos innecesarios

Aumenta el riesgo de errores.

### 11. Mezclar credenciales personales y corporativas

Puede provocar errores de seguridad y publicación.

### 12. No documentar el entorno

Dificulta la incorporación de otros desarrolladores y la recuperación de la máquina.

### 13. Confiar exclusivamente en el estado actual de la computadora

Hace que una migración o reinstalación sea más difícil.

### 14. Instalar herramientas solo porque aparecen en un tutorial

Debemos comprender primero qué problema resuelven.

### 15. Buscar una configuración universal para todos los desarrolladores

Cada entorno tiene requisitos diferentes.

---

# 31. Comprueba tu modelo mental

1. ¿Qué significa Clean Development Machine?
2. ¿Por qué una máquina limpia no tiene que ser una máquina con poco software?
3. ¿Qué diferencia existe entre Cleanliness y Reproducibility?
4. ¿Qué es Consistency?
5. ¿Cuáles son las principales capas de una máquina de desarrollo?
6. ¿Qué herramientas deberían administrarse a nivel del sistema?
7. ¿Qué herramientas deberían administrarse a nivel del proyecto?
8. ¿Qué es una instalación duplicada?
9. ¿Por qué dos instalaciones de Node.js pueden producir conflictos?
10. ¿Qué es un Runtime Version Manager?
11. ¿Por qué un proyecto puede necesitar una versión específica de Node.js?
12. ¿Qué diferencia existe entre Global Packages y Local Dependencies?
13. ¿Por qué TypeScript suele declararse como dependencia del proyecto?
14. ¿Qué diferencia existe entre Homebrew y pnpm?
15. ¿Qué diferencia existe entre nvm y npm?
16. ¿Por qué conviene organizar los repositorios?
17. ¿Qué riesgos existen al mezclar proyectos personales y corporativos?
18. ¿Por qué PATH puede generar conflictos?
19. ¿Qué son los Dotfiles?
20. ¿Qué riesgos existen al versionar Dotfiles?
21. ¿Qué son los procesos en segundo plano?
22. ¿Por qué no debemos detener procesos desconocidos?
23. ¿Qué son los artefactos de Build?
24. ¿Por qué no debemos eliminar cachés indiscriminadamente?
25. ¿Cuándo conviene desinstalar una herramienta?
26. ¿Por qué actualizar todo automáticamente puede ser problemático?
27. ¿Qué significa Principle of Least Privilege?
28. ¿Por qué Git no reemplaza completamente a los Backups?
29. ¿Qué diferencia existe entre Machine Setup y Project Setup?
30. ¿Qué información debería contener una auditoría?
31. ¿Por qué debemos conocer el origen de cada instalación?
32. ¿Qué debemos revisar al terminar un proyecto?
33. ¿Qué debemos preparar antes de cambiar de computadora?
34. ¿Qué configuraciones deberían estar documentadas?
35. ¿Qué caracteriza a una máquina de desarrollo mantenible?

---

# 32. Checklist de aprendizaje

- [ ] Comprendo qué es una Clean Development Machine.
- [ ] Diferencio organización, consistencia y reproducibilidad.
- [ ] Identifico las capas de un entorno de desarrollo.
- [ ] Distingo herramientas del sistema, usuario y proyecto.
- [ ] Comprendo los riesgos de instalaciones duplicadas.
- [ ] Comprendo el propósito de los Runtime Managers.
- [ ] Diferencio dependencias globales y locales.
- [ ] Distingo gestores de paquetes del sistema y JavaScript.
- [ ] Sé organizar mis repositorios.
- [ ] Comprendo la importancia de separar contextos personales y corporativos.
- [ ] Puedo inspeccionar PATH.
- [ ] Reconozco configuraciones de Shell innecesarias.
- [ ] Comprendo qué son los Dotfiles.
- [ ] Reconozco procesos y servicios en segundo plano.
- [ ] Comprendo la responsabilidad de cachés y artefactos.
- [ ] Evito desinstalaciones indiscriminadas.
- [ ] Comprendo la importancia de actualizaciones controladas.
- [ ] Aplico el principio de mínimo privilegio.
- [ ] Comprendo la importancia de Backups.
- [ ] Puedo documentar un entorno.
- [ ] Puedo realizar una auditoría básica.
- [ ] Comprendo cómo mantener mi entorno a largo plazo.

---

# 💡 Idea clave

Una máquina de desarrollo profesional no se define por la cantidad de herramientas instaladas.

Se define por nuestra capacidad para comprenderlas, administrarlas y reconstruirlas.

```text
Professional Development Machine
          │
          ▼
    Clear Responsibilities
          │
          ▼
    Controlled Versions
          │
          ▼
    Organized Workspaces
          │
          ▼
    Documented Configuration
          │
          ▼
    Predictable Development
```

**La mejor configuración no es la más compleja, sino aquella que resuelve nuestras necesidades sin introducir dependencias innecesarias ni comportamientos difíciles de explicar.**

---

# 🚀 Siguiente paso

Ahora comprendemos cómo mantener una computadora de desarrollo organizada.

Sin embargo, existe un problema especialmente importante que merece estudiarse por separado:

**Global Pollution.**

En el siguiente documento aprenderemos:

- Qué significa contaminar un entorno global.
- Cómo aparecen dependencias ocultas.
- Por qué algunas herramientas deben pertenecer al proyecto.
- Cómo afectan las instalaciones globales a la reproducibilidad.
- Qué papel cumplen npm, pnpm y los gestores de versiones.
- Cómo evitar conflictos entre proyectos.

👉 [Avoid Global Pollution](./02-avoid-global-pollution.md)