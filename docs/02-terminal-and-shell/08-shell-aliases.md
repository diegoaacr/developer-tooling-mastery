# Shell Aliases

> **Developer Tooling Mastery 2026 — Module 02**
>
> **Topic 08:** Shell Aliases  
> **Level:** Beginner → Professional Foundations  
> **Prerequisites:** [07 — Shell Configuration Files](./07-shell-configuration-files.md)

---

## 1. Introducción

Imagina que trabajas diariamente con Git.

Durante tu jornada ejecutas repetidamente comandos como:

```bash
git status
git branch
git log --oneline
```

También navegas frecuentemente entre directorios:

```bash
cd ~/projects
```

Escribir estos comandos no es complicado, pero algunas operaciones repetitivas pueden simplificarse.

Por ejemplo, ¿qué pasaría si pudiéramos escribir:

```bash
gs
```

en lugar de:

```bash
git status
```

O:

```bash
cprojects
```

en lugar de:

```bash
cd ~/projects
```

Los Shells ofrecen mecanismos para crear estas personalizaciones.

Los más importantes son:

- **Aliases:** nombres alternativos para comandos.
- **Functions:** bloques reutilizables de instrucciones.
- **Scripts:** archivos que contienen instrucciones ejecutables.

Aunque pueden parecer similares, tienen responsabilidades y comportamientos diferentes.

En este documento aprenderemos a utilizarlos correctamente, evitando convertir nuestra terminal en un entorno difícil de comprender o mantener.

---

# 2. Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Explicar qué es un Shell Alias.
2. Comprender por qué existen los Aliases.
3. Crear, consultar y eliminar Aliases.
4. Diferenciar Aliases temporales y persistentes.
5. Comprender cómo se expanden los Aliases.
6. Reconocer sus limitaciones.
7. Explicar qué es una Shell Function.
8. Crear funciones que reciben argumentos.
9. Diferenciar Alias, Function y Script.
10. Comprender diferencias entre Bash, Zsh y PowerShell.
11. Evitar conflictos con comandos existentes.
12. Reconocer los riesgos de seguridad.
13. Organizar personalizaciones profesionales.
14. Identificar cuándo no utilizar Aliases.
15. Aplicar lo aprendido mediante ejercicios prácticos.

---

# 3. El problema: comandos repetitivos

Supongamos que tenemos este flujo de trabajo:

```text
Developer
    │
    ├── git status
    ├── git branch
    ├── git log --oneline
    ├── git status
    ├── git branch
    └── git status
```

Podemos ejecutar estos comandos directamente.

Sin embargo, si los utilizamos constantemente, puede resultar conveniente crear abreviaturas.

Ejemplo:

```text
git status          → gs
git branch          → gb
git log --oneline   → gl
```

Ahora nuestro flujo sería:

```text
Developer
    │
    ├── gs
    ├── gb
    ├── gl
    ├── gs
    ├── gb
    └── gs
```

La finalidad no es reemplazar el conocimiento de los comandos originales.

La finalidad es **reducir fricción en operaciones conocidas y repetitivas**.

### Idea clave

Un Alias debe simplificar una operación que ya comprendemos, no ocultar un comando cuyo comportamiento desconocemos.

---

# 4. ¿Qué es un Shell Alias?

Un **Shell Alias** es un nombre alternativo que el Shell puede expandir a otra secuencia de texto durante la interpretación de comandos.

Ejemplo en Bash o Zsh:

```bash
alias gs='git status'
```

Después podemos ejecutar:

```bash
gs
```

El Shell interpreta el Alias y ejecuta la instrucción correspondiente.

## 4.1 Modelo conceptual

```text
User Input
    │
    ▼
   gs
    │
    ▼
Alias Expansion
    │
    ▼
git status
    │
    ▼
Command Execution
```

## 4.2 ¿El Alias crea un nuevo programa?

No.

No estamos compilando ni instalando un nuevo ejecutable.

Estamos configurando un mecanismo de interpretación del Shell.

## 4.3 ¿El Alias existe fuera del Shell?

No necesariamente.

Por ejemplo, un Alias definido en Zsh no se convierte automáticamente en un comando disponible para PowerShell o para cualquier proceso.

## 4.4 ¿Un Alias modifica Git?

No.

Git sigue funcionando exactamente como antes.

Solamente cambiamos la forma en que invocamos una instrucción desde nuestro Shell.

### Idea clave

**Un Alias es una personalización del Shell, no una nueva herramienta instalada en el sistema.**

---

# 5. Crear Aliases en Bash y Zsh

La sintaxis básica es:

```bash
alias name='command'
```

Ejemplo:

```bash
alias gs='git status'
```

## 5.1 Alias para Git

```bash
alias gs='git status'
alias gb='git branch'
alias gl='git log --oneline'
```

Podemos ejecutar:

```bash
gs
```

```bash
gb
```

```bash
gl
```

## 5.2 Alias para navegación

```bash
alias cprojects='cd "$HOME/projects"'
```

Después:

```bash
cprojects
```

Este Alias presupone que el directorio existe.

## 5.3 Alias para mostrar archivos

```bash
alias ll='ls -la'
```

Después:

```bash
ll
```

## 5.4 ¿Por qué utilizamos comillas?

Las comillas permiten definir el texto que formará parte del Alias.

Por ejemplo:

```bash
alias gs='git status'
```

No debemos confundir las comillas utilizadas al definir el Alias con los argumentos que pasaremos posteriormente.

### Idea clave

**La definición de un Alias establece qué texto sustituirá al nombre abreviado.**

---

# 6. Consultar Aliases existentes

Antes de crear nuevas abreviaturas, conviene revisar las existentes.

## 6.1 Mostrar todos los Aliases

En Bash y Zsh:

```bash
alias
```

## 6.2 Consultar uno específico

```bash
alias gs
```

Si existe, podremos inspeccionar su definición.

## 6.3 ¿Por qué es importante?

Porque un Alias puede haber sido definido por:

- Nosotros.
- Un archivo de configuración.
- Un Framework del Shell.
- Una herramienta de desarrollo.
- Una configuración corporativa.

## 6.4 Identificar qué representa un comando

En Bash y Zsh:

```bash
type gs
```

Esto permite investigar cómo se interpreta el nombre.

### Idea clave

**Antes de modificar una abreviatura, debemos comprobar si ya existe y qué comportamiento tiene.**

---

# 7. Eliminar un Alias

En Bash y Zsh podemos utilizar:

```bash
unalias gs
```

Esto elimina la definición del Alias en la sesión actual.

## 7.1 ¿Elimina también la configuración persistente?

No.

Si tenemos:

```bash
alias gs='git status'
```

dentro de `.zshrc`, una nueva sesión interactiva puede volver a crear el Alias.

## 7.2 ¿Cómo eliminarlo permanentemente?

Debemos modificar el archivo donde está definido y eliminar o comentar esa instrucción.

Ejemplo:

```bash
# alias gs='git status'
```

## 7.3 ¿Por qué importa?

Porque eliminar una configuración del estado actual no significa eliminar su origen persistente.

### Idea clave

**Los Aliases temporales y las definiciones persistentes pertenecen a ámbitos diferentes.**

---

# 8. Aliases temporales vs persistentes

Podemos definir un Alias directamente en la terminal:

```bash
alias gs='git status'
```

En ese caso, normalmente estará disponible en la sesión actual.

Si cerramos esa sesión, la definición desaparecerá, salvo que exista otro mecanismo que vuelva a crearla.

## 8.1 Persistencia en Zsh

Podemos definir el Alias en:

```text
~/.zshrc
```

## 8.2 Persistencia en Bash

Podemos definirlo en:

```text
~/.bashrc
```

Recordemos que los archivos cargados dependen del modo de inicialización.

## 8.3 Ejemplo de organización

```bash
# Git aliases
alias gs='git status'
alias gb='git branch'
alias gl='git log --oneline'

# Navigation aliases
alias cprojects='cd "$HOME/projects"'
```

## 8.4 ¿Es recomendable guardar todos los Aliases?

No necesariamente.

Primero conviene probarlos temporalmente y comprobar que realmente mejoran nuestro flujo de trabajo.

### Idea clave

**Experimenta con Aliases temporales antes de convertirlos en configuraciones permanentes.**

---

# 9. ¿Cómo funciona Alias Expansion?

Un Alias no funciona exactamente igual que una función.

En Bash y Zsh, su mecanismo principal consiste en sustituir un nombre por el texto asociado durante la interpretación de una instrucción.

Ejemplo:

```bash
alias gs='git status'
```

Cuando escribimos:

```bash
gs
```

el Shell puede expandirlo a:

```bash
git status
```

## 9.1 ¿Qué ocurre con argumentos adicionales?

Supongamos:

```bash
alias gl='git log --oneline'
```

Ejecutamos:

```bash
gl -5
```

El resultado equivale a ejecutar:

```bash
git log --oneline -5
```

El argumento adicional queda después del texto expandido.

## 9.2 ¿Podemos colocar argumentos en cualquier posición?

No de forma general.

Por ejemplo, si queremos construir una operación que utilice parámetros en diferentes posiciones, una función suele ser más apropiada.

## 9.3 Limitación importante

La expansión de Aliases depende de reglas sintácticas específicas del Shell.

No debemos pensar que un Alias reemplaza cualquier aparición de su nombre dentro de cualquier texto.

### Idea clave

**Un Alias sirve principalmente para sustituciones sencillas; para lógica y argumentos estructurados, normalmente conviene una función.**

---

# 10. ¿Qué es una Shell Function?

Una **Shell Function** es una secuencia reutilizable de instrucciones definida dentro del Shell.

A diferencia de un Alias, puede incorporar lógica y manejar argumentos de forma más explícita.

Ejemplo en Bash/Zsh:

```bash
greet() {
  echo "Hello, developer"
}
```

Después:

```bash
greet
```

Resultado:

```text
Hello, developer
```

## 10.1 Modelo conceptual

```text
Function Call
     │
     ▼
Function Body
     │
     ├── Command A
     ├── Command B
     └── Command C
     │
     ▼
Return Control
```

## 10.2 ¿Una función crea un ejecutable independiente?

No.

La función pertenece al entorno del Shell que la define, salvo mecanismos explícitos de exportación o transmisión compatibles.

## 10.3 ¿Para qué sirve?

Para encapsular operaciones que requieren:

- Argumentos.
- Validaciones.
- Condiciones.
- Varias instrucciones.
- Reutilización.

### Idea clave

**Una función permite construir comportamiento reutilizable dentro del Shell.**

---

# 11. Argumentos en Shell Functions

Supongamos que queremos crear una función que salude a una persona.

```bash
greet() {
  echo "Hello, $1"
}
```

Ejecutamos:

```bash
greet Diego
```

Resultado:

```text
Hello, Diego
```

## 11.1 ¿Qué significa `$1`?

En Bash y Zsh, dentro de una función representa el primer argumento posicional.

Otros argumentos pueden consultarse mediante:

```text
$1 → First argument
$2 → Second argument
$3 → Third argument
```

## 11.2 Ejemplo con dos argumentos

```bash
introduce() {
  echo "Name: $1"
  echo "Role: $2"
}
```

Ejecutamos:

```bash
introduce Diego Developer
```

Resultado:

```text
Name: Diego
Role: Developer
```

## 11.3 ¿Qué ocurre con valores que contienen espacios?

Debemos utilizar comillas al invocar la función:

```bash
introduce "Diego Cueva" "Software Engineer"
```

De esta manera cada cadena se transmite como un argumento.

### Idea clave

**Las funciones permiten trabajar explícitamente con argumentos, algo que las hace más flexibles que los Aliases.**

---

# 12. Ejemplo práctico: función para navegar

Imaginemos que queremos crear un directorio y entrar en él.

Sin función:

```bash
mkdir -p my-project
cd my-project
```

Podemos encapsular ambas instrucciones.

```bash
mkcd() {
  mkdir -p -- "$1" && cd -- "$1"
}
```

Después:

```bash
mkcd my-project
```

## 12.1 ¿Qué hace?

Primero:

```bash
mkdir -p -- "$1"
```

Intenta crear el directorio.

Después:

```bash
cd -- "$1"
```

Cambia al directorio.

## 12.2 ¿Qué significa `&&`?

Permite ejecutar la segunda operación solamente si la primera termina correctamente.

Estudiaremos los operadores de encadenamiento con mayor profundidad en el documento 10.

## 12.3 ¿Qué significa `--`?

En muchos comandos indica el final de las opciones.

Es útil cuando un argumento podría comenzar con un guion.

Su compatibilidad depende del comando concreto.

## 12.4 ¿Qué podría mejorarse?

Validar que el usuario proporcione un argumento.

```bash
mkcd() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: mkcd <directory>" >&2
    return 2
  fi

  mkdir -p -- "$1" && cd -- "$1"
}
```

Esta versión es más clara y segura para el uso previsto.

### Idea clave

**Cuando una operación necesita parámetros, validaciones o varias instrucciones, una función suele ser mejor opción que un Alias.**

---

# 13. Alias vs Function vs Script

Estos tres mecanismos permiten reutilizar operaciones, pero tienen diferencias importantes.

| Característica | Alias | Function | Script |
|---|---|---|---|
| Objetivo principal | Abreviar instrucciones | Reutilizar lógica en el Shell | Automatizar instrucciones en un archivo |
| Argumentos | Se agregan al texto expandido | Posicionales y estructurados | Dependen del intérprete |
| Condiciones | No es su propósito principal | Sí | Sí |
| Varias instrucciones | Limitado y poco recomendable | Sí | Sí |
| Persistencia | Mediante configuración | Mediante configuración o archivos cargados | Como archivo |
| Portabilidad | Dependiente del Shell | Dependiente del Shell y sintaxis | Dependiente del intérprete y entorno |
| Uso habitual | Productividad personal | Operaciones reutilizables | Automatización y tareas compartidas |

## 13.1 ¿Cuándo utilizar Alias?

Cuando necesitamos una abreviatura sencilla.

```bash
alias gs='git status'
```

## 13.2 ¿Cuándo utilizar Function?

Cuando necesitamos lógica o argumentos.

```bash
cproject() {
  cd "$HOME/projects/$1"
}
```

Esta versión es ilustrativa; una función de producción debería validar entradas y manejar errores.

## 13.3 ¿Cuándo utilizar Script?

Cuando necesitamos una operación más independiente, versionable o compartida.

Ejemplo:

```text
scripts/
└── setup.sh
```

## 13.4 ¿Qué deberíamos priorizar en proyectos?

Scripts y configuraciones declaradas dentro del repositorio, cuando el objetivo es que todo el equipo pueda reproducir el comportamiento.

### Idea clave

**Alias para abreviar, Function para encapsular y Script para automatizar de forma más independiente.**

---

# 14. Aliases en PowerShell

PowerShell también dispone de Aliases, pero su modelo es diferente al de Bash y Zsh.

## 14.1 Crear un Alias

```powershell
Set-Alias -Name gstatus -Value Get-Status
```

Este ejemplo presupone que existe un comando o función llamado `Get-Status`.

## 14.2 Ejemplo con un comando existente

```powershell
Set-Alias -Name g -Value git
```

Después:

```powershell
g status
```

Equivale a invocar Git con el argumento `status`.

## 14.3 Diferencia importante

Los Aliases de PowerShell representan nombres alternativos de comandos.

No funcionan como sustituciones generales de texto con argumentos incorporados al estilo de Bash.

Por ejemplo, no deberíamos esperar que esto funcione como un Alias de Bash:

```powershell
Set-Alias gs "git status"
```

Para representar `git status`, conviene utilizar una función.

### Idea clave

**PowerShell Aliases y Bash/Zsh Aliases comparten la idea de abreviación, pero no el mismo mecanismo de expansión.**

---

# 15. Functions en PowerShell

Podemos crear una función:

```powershell
function gs {
    git status
}
```

Después:

```powershell
gs
```

## 15.1 Función con argumento

```powershell
function Show-GitLog {
    param(
        [int]$Count = 5
    )

    git log --oneline -n $Count
}
```

Ejecutamos:

```powershell
Show-GitLog -Count 10
```

## 15.2 ¿Qué es `param`?

Permite declarar parámetros de una función o Script de PowerShell.

## 15.3 ¿Qué significa `[int]`?

Indica que el parámetro espera un valor entero.

## 15.4 ¿Por qué es útil?

Porque PowerShell ofrece un sistema de parámetros estructurado y capacidades de validación.

### Idea clave

**En PowerShell, las Functions son el mecanismo apropiado para encapsular comandos con argumentos y lógica.**

---

# 16. Persistencia en PowerShell

Podemos definir funciones dentro de nuestro PowerShell Profile.

Por ejemplo:

```powershell
function gs {
    git status
}
```

Si el perfil correspondiente se carga, la función estará disponible.

## 16.1 Consultar el Profile

```powershell
$PROFILE
```

## 16.2 Editarlo

Si VS Code está disponible:

```powershell
code $PROFILE
```

## 16.3 ¿Todos los Hosts utilizan el mismo Profile?

No necesariamente.

Como vimos en el documento anterior, existen perfiles para diferentes ámbitos.

## 16.4 ¿Debemos compartir nuestro Profile con el proyecto?

No como requisito obligatorio.

Los proyectos deben declarar sus propias operaciones compartidas.

### Idea clave

**Las funciones del Profile pertenecen a la configuración personal del entorno, no automáticamente a todos los proyectos.**

---

# 17. Aliases y Command Resolution

Recordemos nuestro modelo anterior:

```text
User Command
     │
     ▼
Shell Parsing
     │
     ▼
Command Resolution
     │
     ├── Alias
     ├── Function
     ├── Builtin
     └── External Executable
```

Este diagrama es conceptual: el orden exacto depende del Shell.

## 17.1 ¿Qué ocurre si un Alias utiliza el nombre de un comando existente?

Podemos modificar la interpretación del nombre.

Ejemplo en Bash/Zsh:

```bash
alias git='git --no-pager'
```

Ahora algunas invocaciones de `git` realizadas desde esa sesión pueden verse afectadas por la expansión.

## 17.2 ¿Es recomendable?

Generalmente conviene evitar sobrescribir nombres de comandos fundamentales sin una razón clara.

## 17.3 ¿Cómo investigar?

En Bash/Zsh:

```bash
type git
```

En PowerShell:

```powershell
Get-Command git -All
```

## 17.4 ¿Por qué importa?

Porque un comportamiento inesperado puede deberse a una personalización del Shell y no al programa original.

### Idea clave

**Los Aliases pueden alterar la resolución de comandos, por lo que debemos elegir nombres claros y evitar conflictos.**

---

# 18. Naming Conventions

Una configuración profesional necesita nombres comprensibles.

## 18.1 Buenos ejemplos

```bash
alias gs='git status'
alias gb='git branch'
alias gl='git log --oneline'
```

Son abreviaturas reconocibles.

## 18.2 Ejemplos menos claros

```bash
alias x='git status'
alias y='git branch'
alias z='git log --oneline'
```

Funcionan técnicamente, pero son menos expresivos.

## 18.3 ¿Siempre necesitamos nombres largos?

No.

La idea es equilibrar:

- Brevedad.
- Claridad.
- Consistencia.
- Facilidad de recordar.

## 18.4 Convenciones sugeridas

```text
g* → Git-related shortcuts
c* → Navigation helpers
```

Son convenciones personales, no estándares universales.

### Idea clave

**Un buen Alias debe ahorrar escritura sin introducir confusión.**

---

# 19. Organización de Aliases

Cuando tenemos pocas personalizaciones, podemos mantenerlas directamente en `.zshrc` o `.bashrc`.

Ejemplo:

```bash
# Git
alias gs='git status'
alias gb='git branch'

# Navigation
alias cprojects='cd "$HOME/projects"'
```

Si crecen, podemos organizarlas en un archivo separado.

Ejemplo:

```text
~/
├── .zshrc
└── .config/
    └── shell/
        └── aliases.sh
```

En `.zshrc`:

```bash
if [ -f "$HOME/.config/shell/aliases.sh" ]; then
  source "$HOME/.config/shell/aliases.sh"
fi
```

## 19.1 ¿Es obligatorio?

No.

Para comenzar, una configuración pequeña y clara es suficiente.

## 19.2 ¿Cuándo conviene separar archivos?

Cuando mejora realmente la organización y el mantenimiento.

## 19.3 Precaución

El archivo cargado debe contener sintaxis compatible con el Shell que lo ejecutará.

### Idea clave

**Organiza tus Aliases cuando sea necesario, pero evita crear una arquitectura compleja para unas pocas abreviaturas.**

---

# 20. Aliases y productividad profesional

Los Aliases pueden mejorar el flujo de trabajo cuando representan operaciones frecuentes.

Sin embargo, existen límites.

## 20.1 Beneficios

- Menos escritura.
- Acceso rápido a operaciones conocidas.
- Personalización del entorno.
- Menor repetición.

## 20.2 Riesgos

- Olvidar comandos originales.
- Depender excesivamente de personalizaciones.
- Crear conflictos.
- Ocultar operaciones peligrosas.
- Dificultar el trabajo en otras computadoras.

## 20.3 Recomendación

Aprender primero el comando original.

Después, si lo utilizamos frecuentemente, considerar un Alias.

### Idea clave

**La productividad profesional consiste en reducir fricción sin sacrificar comprensión.**

---

# 21. Aliases y seguridad

No todos los comandos deberían abreviarse.

Especialmente aquellos que pueden modificar o eliminar información.

## 21.1 Ejemplo peligroso

```bash
alias cleanup='rm -rf ~/projects'
```

Este Alias podría eliminar una gran cantidad de archivos si se ejecuta.

No lo utilices.

## 21.2 ¿Por qué es problemático?

Porque un nombre aparentemente inocente puede ocultar una operación destructiva.

## 21.3 Buenas prácticas

- Utilizar nombres explícitos.
- Evitar ocultar operaciones destructivas.
- No ejecutar configuraciones desconocidas.
- Revisar Aliases copiados de Internet.
- Mantener respaldos cuando corresponda.
- No depender de Aliases de seguridad como única protección.

## 21.4 ¿Qué ocurre con Scripts compartidos?

También deben revisarse antes de ejecutarse.

### Idea clave

**Un Alias puede ahorrar tiempo, pero también ocultar operaciones cuyo impacto debemos comprender.**

---

# 22. Aliases en equipos de desarrollo

Supongamos que trabajamos en un equipo de cinco desarrolladores.

Cada persona tiene sus propios Aliases.

```text
Developer A → gs
Developer B → gst
Developer C → git-status
Developer D → No aliases
Developer E → Custom functions
```

Esto es perfectamente válido como personalización.

El problema aparece cuando un proyecto depende de ellos.

## 22.1 Ejemplo incorrecto

Documentar:

```text
Run: startproject
```

sin explicar qué significa `startproject` ni proporcionar una alternativa reproducible.

## 22.2 Mejor enfoque

Documentar:

```bash
pnpm dev
```

Si el proyecto declara ese Script.

## 22.3 ¿Podemos ofrecer Aliases opcionales?

Sí.

Pero deben presentarse como ayudas personales, no como requisitos ocultos.

### Idea clave

**Los Aliases mejoran la experiencia individual; los Scripts de proyecto proporcionan una interfaz compartida para el equipo.**

---

# 23. Troubleshooting: Alias Not Found

## Problema

Creamos:

```bash
alias gs='git status'
```

Pero al abrir una nueva terminal:

```text
command not found: gs
```

## Posibles causas

1. El Alias era temporal.
2. Está definido en otro archivo.
3. Estamos utilizando otro Shell.
4. El archivo no se cargó.
5. Existe un error de sintaxis.
6. La sesión no es interactiva.

## Diagnóstico en Bash/Zsh

```bash
alias gs
```

```bash
type gs
```

Revisar después el archivo de configuración correspondiente.

## Diagnóstico en PowerShell

```powershell
Get-Command gs -All
```

### Idea clave

**Cuando un Alias desaparece, debemos investigar dónde se definió y qué configuración se cargó.**

---

# 24. Troubleshooting: Alias Works Interactively but Not in a Script

## Problema

Un Alias funciona al escribirlo manualmente, pero falla dentro de un Script.

## ¿Por qué?

Porque los Aliases suelen depender de la interpretación interactiva y de las reglas específicas del Shell.

Por ejemplo, Bash no expande Aliases en Shells no interactivos de forma predeterminada.

## ¿Qué recomendamos?

No diseñar Scripts que dependan de Aliases personales.

Utilizar:

- Comandos explícitos.
- Funciones definidas apropiadamente.
- Scripts versionados.
- Herramientas declaradas como dependencias.

### Idea clave

**Los Aliases son una herramienta de productividad del Shell, no una base sólida para automatizaciones compartidas.**

---

# 25. Troubleshooting: Command Behaves Differently

## Problema

Ejecutamos:

```bash
git status
```

Pero observamos un comportamiento inesperado.

## Posible causa

Existe un Alias o una función que utiliza el nombre `git`.

## Diagnóstico

En Bash/Zsh:

```bash
type git
```

```bash
type -a git
```

En PowerShell:

```powershell
Get-Command git -All
```

## ¿Qué deberíamos hacer?

Identificar la personalización antes de modificar instalaciones o PATH.

### Idea clave

**No todos los problemas de comandos se deben al ejecutable: algunos provienen de personalizaciones del Shell.**

---

# 26. Práctica 01 — Crear tus primeros Aliases

**Entorno:** Bash o Zsh.

## Paso 1

Comprueba que Git esté disponible:

```bash
git --version
```

## Paso 2

Crea un Alias:

```bash
alias gs='git status'
```

## Paso 3

Consulta su definición:

```bash
alias gs
```

## Paso 4

Entra en un repositorio Git y ejecútalo:

```bash
gs
```

## Paso 5

Elimina el Alias:

```bash
unalias gs
```

## Preguntas

1. ¿Qué ocurrió al ejecutar `gs`?
2. ¿Se creó un programa nuevo?
3. ¿Qué diferencia existe entre Alias y Executable?
4. ¿El Alias seguirá existiendo en una nueva sesión?

---

# 27. Práctica 02 — Crear una Shell Function

**Entorno:** Bash o Zsh.

## Paso 1

Define:

```bash
greet() {
  echo "Hello, $1"
}
```

## Paso 2

Ejecuta:

```bash
greet Developer
```

## Paso 3

Ejecuta:

```bash
greet "Software Engineer"
```

## Paso 4

Modifica la función:

```bash
greet() {
  if [ "$#" -eq 0 ]; then
    echo "Usage: greet <name>" >&2
    return 2
  fi

  echo "Hello, $1"
}
```

## Paso 5

Prueba:

```bash
greet
```

Y:

```bash
greet Developer
```

## Preguntas

1. ¿Qué representa `$1`?
2. ¿Qué representa `$#`?
3. ¿Por qué utilizamos comillas?
4. ¿Qué ventaja tiene la función frente a un Alias?

---

# 28. Práctica 03 — Alias vs Function

Queremos crear una abreviatura para:

```bash
git log --oneline
```

Podemos utilizar:

```bash
alias gl='git log --oneline'
```

Ahora queremos una operación que reciba el número de commits.

Podemos crear:

```bash
glog() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: glog <count>" >&2
    return 2
  fi

  git log --oneline -n "$1"
}
```

Ejemplo:

```bash
glog 5
```

## Reflexión

1. ¿Cuál solución es más sencilla?
2. ¿Cuál permite controlar mejor los argumentos?
3. ¿Cuál utilizarías para una operación fija?
4. ¿Cuál utilizarías para una operación parametrizada?

### Aprendizaje

**Elegir el mecanismo más simple que resuelva correctamente el problema.**

---

# 29. Práctica 04 — PowerShell Aliases y Functions

**Entorno:** PowerShell.

## Paso 1

Crea un Alias para Git:

```powershell
Set-Alias -Name g -Value git
```

## Paso 2

Ejecuta:

```powershell
g --version
```

## Paso 3

Crea una función:

```powershell
function gs {
    git status
}
```

## Paso 4

Dentro de un repositorio Git:

```powershell
gs
```

## Paso 5

Consulta el comando:

```powershell
Get-Command gs
```

## Preguntas

1. ¿Por qué utilizamos un Alias para `git`?
2. ¿Por qué utilizamos una función para `git status`?
3. ¿Qué diferencia existe respecto de Bash?
4. ¿Cómo harías persistente la función?

---

# 30. Práctica 05 — Diseñar tus propios atajos

Imagina que trabajas frecuentemente con:

```text
Git
Node.js
pnpm
Project Navigation
```

Diseña cinco personalizaciones.

Para cada una, responde:

| Pregunta | Respuesta esperada |
|---|---|
| ¿Qué operación simplifica? | Comando original |
| ¿Con qué frecuencia se utiliza? | Alta, media o baja |
| ¿Necesita argumentos? | Sí o no |
| ¿Necesita lógica? | Sí o no |
| ¿Alias o Function? | Elección justificada |
| ¿Es personal o del proyecto? | Ámbito correcto |

## Regla

No crear Aliases únicamente porque podemos hacerlo.

Crear aquellos que resuelvan una necesidad real.

---

# 31. Casos reales de ingeniería

## Caso 1 — Git shortcuts

**Necesidad:** Ejecutar operaciones frecuentes de Git.

**Solución:** Aliases sencillos.

**Aprendizaje:** Reducir escritura en operaciones conocidas.

---

## Caso 2 — Navegación entre proyectos

**Necesidad:** Entrar rápidamente en directorios frecuentes.

**Solución:** Alias para rutas fijas o función para rutas parametrizadas.

**Aprendizaje:** Elegir según la complejidad.

---

## Caso 3 — Scripts compartidos

**Necesidad:** Todos los desarrolladores deben iniciar una aplicación del mismo modo.

**Solución:** Script declarado en el proyecto.

**Aprendizaje:** No depender de configuraciones personales.

---

## Caso 4 — Diferencias entre Bash y PowerShell

**Necesidad:** Crear una abreviatura para `git status`.

**Solución:** Alias en Bash/Zsh; función en PowerShell.

**Aprendizaje:** Respetar el modelo de cada Shell.

---

## Caso 5 — Comportamiento inesperado de un comando

**Necesidad:** Diagnosticar por qué un comando no funciona como esperamos.

**Solución:** Inspeccionar Aliases, funciones y Command Resolution.

**Aprendizaje:** Investigar antes de reinstalar herramientas.

---

# 32. Errores frecuentes

### Error 1 — Crear Aliases sin comprender los comandos originales

Puede ocultar conocimientos fundamentales.

### Error 2 — Utilizar Aliases para operaciones complejas

Las funciones suelen ser más apropiadas.

### Error 3 — Pensar que los Aliases son ejecutables

Son mecanismos de interpretación del Shell.

### Error 4 — Pensar que funcionan automáticamente en todos los Shells

Dependen del entorno.

### Error 5 — Confundir Aliases de Bash con Aliases de PowerShell

Sus mecanismos son diferentes.

### Error 6 — Sobrescribir comandos fundamentales

Puede introducir comportamientos inesperados.

### Error 7 — Utilizar Aliases personales dentro de automatizaciones compartidas

Reduce la portabilidad.

### Error 8 — Ocultar comandos destructivos

Puede producir pérdida de información.

### Error 9 — Crear demasiadas abreviaturas

Puede dificultar recordarlas y mantenerlas.

### Error 10 — No documentar personalizaciones importantes

Dificulta el diagnóstico.

### Error 11 — Suponer que un Alias temporal es persistente

Desaparecerá al finalizar la sesión si no existe otra configuración que lo recree.

### Error 12 — No verificar conflictos de nombres

Puede alterar Command Resolution.

---

# 33. Comprueba tu modelo mental

1. ¿Qué es un Shell Alias?
2. ¿Para qué sirve?
3. ¿Un Alias crea un ejecutable?
4. ¿Cómo creamos un Alias en Bash?
5. ¿Cómo consultamos un Alias existente?
6. ¿Cómo eliminamos un Alias?
7. ¿Qué diferencia existe entre Alias temporal y persistente?
8. ¿Dónde solemos guardar Aliases en Zsh?
9. ¿Dónde solemos guardarlos en Bash?
10. ¿Qué significa Alias Expansion?
11. ¿Cómo se comportan los argumentos adicionales?
12. ¿Qué limitaciones tienen los Aliases?
13. ¿Qué es una Shell Function?
14. ¿Qué representa `$1`?
15. ¿Qué representa `$#`?
16. ¿Por qué debemos utilizar comillas con argumentos?
17. ¿Qué ventaja tiene una Function frente a un Alias?
18. ¿Qué es un Script?
19. ¿Cuál es la diferencia entre Alias, Function y Script?
20. ¿Cuándo utilizarías cada uno?
21. ¿Cómo funcionan los Aliases de PowerShell?
22. ¿Por qué PowerShell necesita una Function para encapsular `git status`?
23. ¿Qué es un PowerShell Profile?
24. ¿Cómo influye un Alias en Command Resolution?
25. ¿Qué problemas puede causar sobrescribir comandos?
26. ¿Por qué los Aliases no deberían ser requisitos del proyecto?
27. ¿Qué riesgos de seguridad existen?
28. ¿Cómo organizarías diez Aliases?
29. ¿Cómo diagnosticarías un Alias que desaparece?
30. ¿Qué significa diseñar una personalización mantenible?

---

# 34. Checklist de aprendizaje

## Fundamentals

- [ ] Comprendo qué es un Shell Alias.
- [ ] Comprendo Alias Expansion.
- [ ] Diferencio Alias y Executable.
- [ ] Reconozco las limitaciones de los Aliases.

## Bash y Zsh

- [ ] Sé crear Aliases.
- [ ] Sé consultarlos.
- [ ] Sé eliminarlos.
- [ ] Comprendo su persistencia.
- [ ] Sé crear funciones.
- [ ] Comprendo argumentos posicionales.

## PowerShell

- [ ] Comprendo `Set-Alias`.
- [ ] Sé crear funciones.
- [ ] Comprendo las diferencias respecto de Bash/Zsh.
- [ ] Sé consultar comandos mediante `Get-Command`.

## Professional Practices

- [ ] Diferencio Alias, Function y Script.
- [ ] Evito conflictos de nombres.
- [ ] Evito ocultar operaciones destructivas.
- [ ] No hago depender proyectos de Aliases personales.
- [ ] Organizo personalizaciones de forma clara.
- [ ] Priorizo comprender el comando original.

---

# 35. Resumen conceptual

Nuestro modelo mental:

```text
Developer Productivity
          │
          ▼
Reusable Commands
          │
          ├── Alias
          │     │
          │     └── Simple Shortcut
          │
          ├── Function
          │     │
          │     └── Reusable Shell Logic
          │
          └── Script
                │
                └── File-based Automation
```

Recordemos:

```text
Alias ≠ Executable
```

```text
Alias ≠ Function
```

```text
Personal Shortcut ≠ Project Standard
```

Y una regla especialmente importante:

```text
Understand First → Automate Second
```

---

# 36. Idea clave

**Los Shell Aliases permiten simplificar comandos frecuentes, mientras que las Functions ofrecen mayor flexibilidad para encapsular operaciones con argumentos y lógica.**

Un desarrollador profesional debe saber cuándo utilizar cada mecanismo.

No buscamos crear cientos de abreviaturas.

Buscamos construir un entorno donde las operaciones frecuentes sean:

- Claras.
- Rápidas.
- Predecibles.
- Seguras.
- Fáciles de mantener.

Y, sobre todo, donde las personalizaciones personales no se conviertan en dependencias ocultas de nuestros proyectos.

---

# 37. Siguiente paso

Ahora que comprendemos cómo personalizar nuestro Shell, estudiaremos un concepto esencial para ejecutar aplicaciones y diagnosticar problemas de desarrollo:

**Processes and Ports.**

Aprenderemos:

- Qué es un Process.
- Qué es un PID.
- Qué significa ejecutar un proceso en Foreground o Background.
- Qué es un Network Port.
- Qué significa que un servidor escuche en un puerto.
- Cómo identificar procesos activos.
- Cómo investigar conflictos de puertos.
- Cómo detener procesos correctamente.

👉 [09 — Processes and Ports](./09-processes-and-ports.md)

**Hasta ahora aprendimos a ejecutar y personalizar comandos. Ahora comprenderemos qué ocurre con los programas mientras están ejecutándose.**