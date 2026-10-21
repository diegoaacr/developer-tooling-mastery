# Processes and Ports

> **Developer Tooling Mastery 2026 — Module 02**
>
> **Topic 09:** Processes and Ports  
> **Level:** Beginner → Professional Foundations  
> **Prerequisites:** [08 — Shell Aliases](./08-shell-aliases.md)

---

## 1. Introducción

Imagina que estás desarrollando una aplicación React con Vite.

Abres la terminal y ejecutas:

```bash
pnpm dev
```

Aparece un mensaje similar a:

```text
VITE ready

Local: http://localhost:5173/
```

Abres el navegador y puedes visualizar tu aplicación.

Pero ahora surgen varias preguntas:

- ¿Qué está ocurriendo mientras la terminal permanece abierta?
- ¿Por qué la aplicación deja de funcionar cuando detenemos el comando?
- ¿Qué significa `localhost:5173`?
- ¿Qué es exactamente el puerto `5173`?
- ¿Por qué otro servidor no siempre puede utilizar el mismo puerto?
- ¿Cómo sabemos qué programa está ocupando un puerto?
- ¿Qué ocurre cuando presionamos `Ctrl + C`?

Para responder estas preguntas necesitamos comprender dos conceptos fundamentales:

**Processes** y **Ports**.

Los procesos pertenecen al funcionamiento del sistema operativo.

Los puertos pertenecen al mecanismo de comunicación de red.

Ambos conceptos se relacionan cuando ejecutamos aplicaciones que necesitan recibir conexiones, como servidores web, APIs o bases de datos.

---

# 2. Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Explicar qué es un Program.
2. Diferenciar Program y Process.
3. Comprender qué es un PID.
4. Explicar qué es un Parent Process.
5. Comprender los conceptos Foreground y Background.
6. Diferenciar Process y Thread a nivel conceptual.
7. Comprender qué son los Signals.
8. Saber qué ocurre al utilizar `Ctrl + C`.
9. Identificar procesos activos en macOS, Linux y Windows.
10. Comprender qué es un Network Port.
11. Diferenciar IP Address y Port.
12. Comprender `localhost` y `127.0.0.1`.
13. Diferenciar TCP y UDP a nivel introductorio.
14. Comprender qué significa Listening.
15. Diagnosticar un puerto ocupado.
16. Identificar qué proceso utiliza un puerto.
17. Detener procesos de manera segura.
18. Comprender la relación con Node.js, Vite y servidores de desarrollo.

---

# 3. El problema: ejecutar no significa instalar

En documentos anteriores aprendimos que un Executable es un recurso que el sistema puede ejecutar.

Por ejemplo:

```bash
node --version
```

Este comando utiliza Node.js para consultar su versión.

Pero cuando ejecutamos:

```bash
node server.js
```

podemos iniciar un programa que permanece activo esperando solicitudes.

La diferencia es importante.

En el primer caso, el programa normalmente termina rápidamente.

En el segundo, puede continuar ejecutándose durante minutos u horas.

## Modelo conceptual

```text
Executable
    │
    ▼
Execution
    │
    ▼
Process
    │
    ├── Uses CPU
    ├── Uses Memory
    ├── Has an Identifier
    └── Performs Work
```

Un ejecutable almacenado en el disco no equivale a un proceso en ejecución.

### Idea clave

**Instalar un programa significa disponer de él; ejecutarlo puede crear un proceso que utiliza recursos del sistema.**

---

# 4. Program vs Process

Son conceptos relacionados, pero diferentes.

## 4.1 Program

Un **Program** es un conjunto de instrucciones que pueden ejecutarse.

Por ejemplo:

```text
node
```

Es un programa que permite ejecutar JavaScript fuera del navegador.

## 4.2 Process

Un **Process** es una instancia de ejecución de un programa, administrada por el sistema operativo.

Por ejemplo:

```bash
node server.js
```

puede iniciar un proceso de Node.js.

## 4.3 ¿Un programa puede tener varios procesos?

Sí.

Podemos ejecutar dos instancias del mismo programa.

```text
Node.js Program
      │
      ├── Process A
      │
      └── Process B
```

Cada proceso puede tener:

- Un identificador propio.
- Memoria.
- Recursos abiertos.
- Estado de ejecución.
- Variables de entorno.
- Relaciones con otros procesos.

## 4.4 Ejemplo real

Podemos tener:

```text
VS Code
├── Main Process
├── Extension Host Process
└── Other Supporting Processes
```

Las aplicaciones modernas pueden utilizar múltiples procesos.

### Idea clave

**Program es el código que puede ejecutarse; Process es una instancia de ese código en ejecución.**

---

# 5. ¿Qué es un PID?

**PID** significa **Process Identifier**.

Es un identificador numérico que el sistema operativo asigna a un proceso.

Ejemplo:

```text
PID: 14285
```

## 5.1 ¿Para qué sirve?

Permite identificar un proceso dentro del sistema.

Podemos utilizarlo para:

- Inspeccionar procesos.
- Consultar su estado.
- Investigar consumo de recursos.
- Enviar señales.
- Solicitar su finalización.

## 5.2 Ejemplo conceptual

```text
Operating System
│
├── PID 1024 → Terminal
├── PID 14285 → Node.js
├── PID 15320 → Browser
└── PID 16240 → Git
```

Los números son ilustrativos.

## 5.3 ¿El PID es permanente?

No.

Los PIDs pueden reutilizarse después de que los procesos terminen.

## 5.4 ¿Es igual en todos los sistemas operativos?

El concepto existe en macOS, Linux y Windows, aunque las herramientas para gestionarlo son diferentes.

### Idea clave

**El PID identifica una instancia de proceso, no una instalación permanente de un programa.**

---

# 6. Parent Process y Child Process

Los procesos pueden crear otros procesos.

El proceso que inicia otro se conoce como **Parent Process**.

El proceso creado se conoce como **Child Process**.

## Ejemplo conceptual

```text
Terminal
   │
   ▼
Shell
   │
   ▼
pnpm
   │
   ▼
Development Tooling
   │
   ▼
Development Server
```

Este diagrama representa una posible cadena de ejecución. Los procesos reales dependen de la herramienta y de su implementación.

## 6.1 ¿Por qué importa?

Porque un comando puede iniciar varios procesos.

Por ejemplo:

```bash
pnpm dev
```

no significa necesariamente que solamente exista un proceso llamado `pnpm`.

El Package Manager puede iniciar otros programas.

## 6.2 ¿Qué es PPID?

**PPID** significa **Parent Process Identifier**.

En sistemas Unix-like permite identificar el proceso padre.

## 6.3 ¿Qué ocurre cuando termina el padre?

Depende del sistema operativo, del proceso y de cómo se haya iniciado.

No debemos asumir que todos los procesos hijos terminan automáticamente.

### Idea clave

**Un comando puede iniciar una jerarquía de procesos, y conocer esa relación ayuda a diagnosticar aplicaciones que siguen ejecutándose.**

---

# 7. Process Lifecycle

Un proceso pasa por diferentes estados durante su existencia.

Modelo simplificado:

```text
Process Created
       │
       ▼
Ready
       │
       ▼
Running
       │
       ├── Waiting
       │      │
       │      └── Ready
       │
       ▼
Terminated
```

## 7.1 Created

El sistema operativo prepara el proceso.

## 7.2 Ready

El proceso está preparado para utilizar CPU cuando el planificador se lo permita.

## 7.3 Running

El proceso está ejecutando instrucciones.

## 7.4 Waiting

El proceso espera algún evento o recurso.

Por ejemplo:

- Datos de red.
- Lectura de archivos.
- Una operación de entrada/salida.

## 7.5 Terminated

El proceso finalizó.

Los estados exactos y su representación varían según el sistema operativo.

### Idea clave

**Un proceso activo no necesita utilizar CPU continuamente; puede permanecer esperando eventos.**

---

# 8. Process vs Thread

Otro concepto importante es **Thread**.

Un Thread representa una unidad de ejecución dentro de un proceso.

## Modelo conceptual

```text
Process
│
├── Thread A
├── Thread B
└── Thread C
```

Los Threads de un mismo proceso pueden compartir recursos, como parte de su memoria.

## 8.1 ¿Todos los procesos tienen varios Threads?

No necesariamente.

## 8.2 ¿Node.js utiliza Threads?

Node.js utiliza un modelo de ejecución de JavaScript basado principalmente en un Event Loop, pero también puede utilizar Threads y otros mecanismos internos.

Por eso sería incorrecto afirmar que Node.js nunca utiliza múltiples Threads.

## 8.3 ¿Necesitamos dominar concurrencia ahora?

No.

Estudiaremos estos conceptos con mayor profundidad cuando avancemos hacia Runtime Management, Backend y Arquitectura.

### Idea clave

**Process y Thread son conceptos distintos: un proceso administra un contexto de ejecución y puede contener múltiples Threads.**

---

# 9. Foreground Processes

Un **Foreground Process** es un proceso o trabajo que está asociado al control interactivo actual de la terminal.

Por ejemplo:

```bash
pnpm dev
```

Mientras se ejecuta, podemos observar mensajes:

```text
Server running...
```

La terminal queda ocupada por ese trabajo hasta que termina, se suspende o recuperamos el control de otra manera.

## 9.1 ¿Significa que no podemos hacer nada más?

No.

Podemos abrir otra terminal.

## 9.2 ¿Por qué es útil?

Porque podemos observar:

- Logs.
- Errores.
- Solicitudes.
- Mensajes de compilación.
- Reinicios automáticos.

### Idea clave

**Un proceso en Foreground mantiene una relación directa con la sesión interactiva desde la que lo ejecutamos.**

---

# 10. Background Processes

Un **Background Process** es un proceso que puede continuar ejecutándose sin ocupar el trabajo en primer plano de la terminal.

En Bash y Zsh podemos iniciar un trabajo en segundo plano utilizando:

```bash
some-command &
```

Por ejemplo:

```bash
sleep 60 &
```

## 10.1 ¿Qué significa `&`?

En este contexto, solicita al Shell ejecutar el trabajo de forma asíncrona.

## 10.2 ¿Esto convierte el proceso en un servicio permanente?

No.

El proceso puede seguir asociado a la sesión y verse afectado por su cierre.

## 10.3 ¿Es lo mismo que un Daemon?

No necesariamente.

Un **Daemon** es un proceso de servicio que suele ejecutarse sin interacción directa con el usuario.

## 10.4 ¿Y en Windows?

PowerShell dispone de mecanismos como `Start-Process` y los sistemas Windows ofrecen sus propios mecanismos para administrar servicios y procesos.

### Idea clave

**Background no significa automáticamente independiente, permanente ni administrado como servicio.**

---

# 11. Job Control

En Shells interactivos Unix-like existe el concepto de **Job Control**.

Permite administrar trabajos asociados a una sesión.

Comandos habituales:

```bash
jobs
```

Muestra trabajos administrados por el Shell actual.

```bash
fg
```

Puede llevar un trabajo al Foreground.

```bash
bg
```

Puede reanudar un trabajo suspendido en Background.

## 11.1 ¿Qué hace `Ctrl + Z`?

En terminales Unix-like, normalmente suspende el trabajo en primer plano mediante una señal de suspensión.

No equivale a terminarlo.

## 11.2 ¿Qué hace `Ctrl + C`?

Normalmente provoca el envío de una señal de interrupción al grupo de procesos en primer plano.

Lo estudiaremos a continuación.

## 11.3 ¿Es igual en PowerShell?

No.

El modelo de Job Control de Bash/Zsh no debe confundirse con los mecanismos de Jobs de PowerShell.

### Idea clave

**Job Control permite gestionar trabajos asociados al Shell, pero no reemplaza la administración de procesos del sistema operativo.**

---

# 12. ¿Qué son Process Signals?

En sistemas Unix-like, los **Signals** son mecanismos que permiten notificar determinados eventos a los procesos.

Algunas señales habituales son:

| Signal | Significado habitual |
|---|---|
| `SIGINT` | Solicitud de interrupción |
| `SIGTERM` | Solicitud de terminación |
| `SIGKILL` | Terminación forzada |
| `SIGSTOP` | Suspensión |
| `SIGCONT` | Continuación |

## 12.1 ¿Todas las señales se comportan igual?

No.

Por ejemplo, `SIGTERM` puede permitir que un proceso realice tareas de limpieza si tiene implementado el manejo correspondiente.

`SIGKILL` no puede ser capturada ni ignorada por el proceso.

## 12.2 ¿Qué significa Graceful Shutdown?

Es una finalización ordenada donde la aplicación puede intentar:

- Dejar de aceptar nuevas solicitudes.
- Cerrar conexiones.
- Liberar recursos.
- Completar operaciones pendientes cuando sea apropiado.

## 12.3 ¿Debemos utilizar siempre `SIGKILL`?

No.

La terminación forzada debe reservarse para situaciones justificadas.

### Idea clave

**Siempre que sea posible, debemos permitir que los procesos terminen de forma controlada.**

---

# 13. ¿Qué ocurre al presionar Ctrl + C?

Imagina que ejecutamos:

```bash
pnpm dev
```

El servidor permanece activo.

Después presionamos:

```text
Ctrl + C
```

En una terminal Unix-like, esta combinación normalmente provoca el envío de `SIGINT` al grupo de procesos en primer plano.

La aplicación puede responder a esa señal y finalizar.

## Modelo conceptual

```text
Developer
    │
    ▼
Ctrl + C
    │
    ▼
Terminal / OS
    │
    ▼
SIGINT
    │
    ▼
Foreground Process Group
    │
    ▼
Application Handles Signal
    │
    ▼
Process Terminates
```

## 13.1 ¿Siempre termina?

No necesariamente.

Un proceso puede manejar o ignorar ciertas señales, o encontrarse en un estado que retrase su finalización.

## 13.2 ¿Qué ocurre en Windows?

La gestión de eventos de consola y procesos es diferente.

Aunque `Ctrl + C` suele utilizarse para interrumpir comandos, no debemos asumir que funciona internamente de manera idéntica a Unix.

### Idea clave

**`Ctrl + C` es el mecanismo habitual para solicitar la interrupción de un comando interactivo, no una garantía universal de terminación inmediata.**

---

# 14. Inspeccionar procesos en macOS y Linux

Una herramienta habitual es:

```bash
ps
```

Para consultar una lista más amplia:

```bash
ps aux
```

En macOS y Linux, esta forma es ampliamente utilizada.

## 14.1 Buscar procesos de Node.js

```bash
ps aux | grep node
```

Este comando también puede mostrar el propio proceso de búsqueda.

## 14.2 Consultar un PID específico

```bash
ps -p 12345
```

Reemplaza `12345` por un PID real.

## 14.3 Monitorización interactiva

En muchos sistemas podemos utilizar:

```bash
top
```

En Linux también puede estar disponible:

```bash
htop
```

`htop` no está necesariamente instalado por defecto.

## 14.4 ¿Qué podemos observar?

Dependiendo de la herramienta:

- PID.
- Usuario.
- Consumo de CPU.
- Consumo de memoria.
- Estado.
- Comando.

### Idea clave

**Inspeccionar procesos permite comprender qué aplicaciones están ejecutándose y qué recursos utilizan.**

---

# 15. Inspeccionar procesos en PowerShell

PowerShell proporciona:

```powershell
Get-Process
```

## 15.1 Buscar Node.js

```powershell
Get-Process -Name node
```

Si no existe un proceso con ese nombre, puede producir un error informativo.

Podemos evitarlo:

```powershell
Get-Process -Name node -ErrorAction SilentlyContinue
```

## 15.2 Consultar un PID

```powershell
Get-Process -Id 12345
```

## 15.3 Consultar propiedades

```powershell
Get-Process -Name node |
    Select-Object Id, ProcessName, CPU
```

## 15.4 ¿Es lo mismo que `ps aux`?

El objetivo es similar, pero las herramientas y los objetos de salida son diferentes.

PowerShell trabaja con objetos estructurados.

### Idea clave

**PowerShell permite inspeccionar procesos mediante comandos que devuelven objetos, no solamente texto.**

---

# 16. ¿Qué es un Network Port?

Hasta ahora estudiamos procesos.

Ahora necesitamos comprender cómo se relacionan con la comunicación de red.

Un **Network Port** es un identificador numérico utilizado por protocolos de transporte como TCP y UDP para distinguir puntos de comunicación dentro de un dispositivo.

Por ejemplo:

```text
5173
```

O:

```text
3000
```

## 16.1 ¿Un puerto es un componente físico?

No.

En este contexto, hablamos de puertos lógicos de red.

## 16.2 ¿Para qué sirven?

Permiten que el sistema operativo dirija el tráfico de red hacia los endpoints correspondientes.

## 16.3 Ejemplo conceptual

```text
Computer
│
├── TCP Port 3000 → API Server
├── TCP Port 5173 → Vite Server
└── TCP Port 5432 → PostgreSQL
```

Los números representan configuraciones habituales, no obligaciones universales.

### Idea clave

**Un puerto permite distinguir comunicaciones de red, mientras que un PID identifica un proceso.**

---

# 17. IP Address vs Port

Son conceptos diferentes.

Una **IP Address** identifica una interfaz o destino de red dentro de un contexto de comunicación IP.

Un **Port** identifica un punto de comunicación asociado a un protocolo de transporte.

Ejemplo:

```text
127.0.0.1:3000
```

Podemos dividirlo:

```text
127.0.0.1   :   3000
    │              │
    │              └── Port
    │
    └───────────────── IP Address
```

## 17.1 ¿Qué significa la combinación?

En un contexto TCP, identifica una dirección y un puerto donde puede estar disponible un servicio.

## 17.2 ¿El puerto identifica por sí solo a un proceso?

No.

La asociación depende de factores como:

- Dirección local.
- Protocolo.
- Configuración de los Sockets.
- Sistema operativo.
- Estado de la conexión.

### Idea clave

**IP y Port cumplen responsabilidades diferentes y normalmente se utilizan juntos para identificar endpoints de red.**

---

# 18. ¿Qué es localhost?

**localhost** es un nombre que normalmente se resuelve hacia direcciones de Loopback.

Las más conocidas son:

```text
127.0.0.1
```

para IPv4, y:

```text
::1
```

para IPv6.

## 18.1 ¿Qué significa Loopback?

Es un mecanismo de comunicación hacia el propio equipo.

## 18.2 Ejemplo

```text
http://localhost:5173
```

Normalmente representa una conexión desde el navegador hacia un servidor accesible en el propio entorno de red local de la máquina.

## 18.3 ¿localhost siempre significa la misma máquina física?

Debemos considerar el contexto.

Por ejemplo, dentro de:

- Una VM.
- Un contenedor.
- WSL.
- Un entorno remoto.

`localhost` se interpreta respecto al entorno de red desde el cual se realiza la conexión.

## 18.4 ¿Por qué importa?

Porque un servidor que funciona en `localhost` dentro de una VM no necesariamente estará accesible de la misma manera desde el sistema anfitrión.

### Idea clave

**localhost representa el entorno de Loopback del contexto desde el que se realiza la conexión.**

---

# 19. ¿Qué significa Listening?

Cuando un servidor TCP está preparado para aceptar conexiones entrantes, decimos que está **Listening**.

Por ejemplo:

```text
Server listening on port 3000
```

Significa que el servidor ha configurado un Socket para aceptar conexiones bajo determinadas condiciones.

## Modelo conceptual

```text
Browser
   │
   ▼
localhost:3000
   │
   ▼
TCP Connection
   │
   ▼
Listening Socket
   │
   ▼
Server Process
```

## 19.1 ¿Listening significa que la aplicación funciona correctamente?

No necesariamente.

Un puerto puede estar abierto mientras la aplicación presenta errores.

## 19.2 ¿Listening significa que es accesible desde Internet?

No.

Depende de la dirección de enlace, la red, el Firewall y otros factores.

### Idea clave

**Listening significa que existe un endpoint preparado para recibir conexiones; no garantiza que el servicio esté funcionando correctamente ni que sea públicamente accesible.**

---

# 20. ¿Qué es un Socket?

Un **Socket** es una abstracción utilizada por los programas para comunicarse mediante mecanismos de red u otros mecanismos compatibles del sistema operativo.

En el caso de TCP, un Socket permite establecer o recibir conexiones.

## Modelo simplificado

```text
Application
     │
     ▼
Socket API
     │
     ▼
Operating System
     │
     ▼
Network Stack
     │
     ▼
Network
```

## 20.1 ¿Un Socket es lo mismo que un puerto?

No.

El Socket representa un endpoint de comunicación administrado por el sistema.

El puerto es uno de los identificadores que pueden intervenir en esa comunicación.

## 20.2 ¿Necesitamos programar Sockets ahora?

No.

Nuestro objetivo es comprender por qué un servidor puede escuchar en un puerto.

### Idea clave

**El Socket es el mecanismo de comunicación; el puerto es parte de la información utilizada para identificar el endpoint.**

---

# 21. TCP vs UDP

Los puertos se utilizan en diferentes protocolos de transporte.

Dos de los más conocidos son TCP y UDP.

## 21.1 TCP

**Transmission Control Protocol** proporciona una comunicación orientada a conexión, con mecanismos de entrega fiable y ordenada de datos.

Se utiliza ampliamente para:

- HTTP/1.1.
- HTTP/2.
- Conexiones a bases de datos.
- Otros servicios de red.

## 21.2 UDP

**User Datagram Protocol** permite enviar datagramas sin establecer una conexión fiable como TCP.

Se utiliza en diferentes protocolos y aplicaciones.

Por ejemplo, HTTP/3 utiliza QUIC, que funciona sobre UDP.

## 21.3 ¿Comparten los mismos puertos?

TCP y UDP tienen espacios de puertos diferenciados.

Por eso debemos identificar también el protocolo cuando investigamos un puerto.

### Idea clave

**El número de puerto por sí solo no describe completamente una comunicación de red.**

---

# 22. ¿Qué es Bind Address?

Cuando iniciamos un servidor, normalmente configuramos una dirección y un puerto donde debe aceptar conexiones.

Esto se conoce como **Binding**.

Ejemplo:

```text
127.0.0.1:3000
```

## 22.1 Binding a 127.0.0.1

El servidor queda asociado a la interfaz de Loopback IPv4.

Normalmente no acepta conexiones directas desde otras máquinas mediante interfaces de red externas.

## 22.2 Binding a 0.0.0.0

```text
0.0.0.0:3000
```

Significa que el servidor utiliza la dirección comodín de IPv4 para escuchar en las interfaces IPv4 disponibles.

No significa que `0.0.0.0` sea una dirección de destino que debamos proporcionar a otros equipos.

## 22.3 ¿0.0.0.0 significa acceso público?

No necesariamente.

La accesibilidad depende de:

- Interfaces.
- Rutas.
- Firewall.
- NAT.
- Configuración de red.
- Infraestructura.

## 22.4 ¿Por qué importa en desarrollo?

Porque podemos tener un servidor funcionando correctamente en `localhost`, pero necesitar una configuración diferente para acceder desde otro dispositivo o entorno.

### Idea clave

**El puerto determina una parte del endpoint; la Bind Address influye en las interfaces donde el servidor acepta conexiones.**

---

# 23. ¿Qué es un Port Conflict?

Un **Port Conflict** ocurre cuando un programa intenta utilizar una combinación de dirección, puerto y protocolo que no puede compartir bajo las reglas y opciones de Socket aplicables.

Ejemplo:

```text
Server A
   │
   ▼
127.0.0.1:3000
```

Después:

```text
Server B
   │
   ▼
127.0.0.1:3000
   │
   ▼
Bind Error
```

## 23.1 ¿Por qué ocurre?

Porque el sistema operativo debe respetar las reglas de uso de los Sockets.

## 23.2 ¿Significa que solamente puede existir un proceso por número de puerto?

No de forma absoluta.

Existen diferencias entre protocolos, direcciones, familias IP y opciones de reutilización de Sockets.

Pero para un servidor de desarrollo convencional, intentar utilizar exactamente el mismo endpoint TCP ocupado suele producir un error.

### Idea clave

**Un conflicto de puerto debe analizarse considerando el endpoint completo, no únicamente el número.**

---

# 24. ¿Qué significa EADDRINUSE?

En Node.js podemos encontrar:

```text
Error: listen EADDRINUSE: address already in use
```

Ejemplo:

```text
Error: listen EADDRINUSE: address already in use :::3000
```

## 24.1 ¿Qué significa?

La aplicación intentó utilizar una dirección de Socket que ya estaba ocupada o no podía compartirse.

## 24.2 Causas habituales

- Otro servidor está utilizando el endpoint.
- Una instancia anterior sigue activa.
- Ejecutamos el comando dos veces.
- Una herramienta inició un proceso adicional.
- Existe una configuración de red incompatible.

## 24.3 ¿Cómo solucionarlo?

Primero debemos identificar el proceso que utiliza el puerto.

Después decidir si corresponde:

1. Detenerlo.
2. Reutilizar el servidor existente.
3. Cambiar el puerto de nuestra aplicación.
4. Corregir la configuración.

### Idea clave

**EADDRINUSE es un problema de disponibilidad del endpoint, no necesariamente un error en el código de negocio de la aplicación.**

---

# 25. Identificar un puerto ocupado en macOS

En macOS podemos utilizar `lsof`.

Ejemplo para TCP 3000:

```bash
lsof -nP -iTCP:3000 -sTCP:LISTEN
```

## 25.1 ¿Qué significa?

- `lsof`: lista archivos y recursos abiertos.
- `-n`: evita resolver nombres de host.
- `-P`: evita convertir números de puerto a nombres de servicio.
- `-iTCP:3000`: filtra por TCP y puerto 3000.
- `-sTCP:LISTEN`: filtra Sockets TCP en estado Listening.

## 25.2 Ejemplo ilustrativo

```text
COMMAND   PID    USER   NAME
node      14285  user   TCP *:3000 (LISTEN)
```

## 25.3 ¿Qué identificamos?

El proceso `node` con PID `14285`.

## 25.4 ¿Podemos detenerlo inmediatamente?

No deberíamos hacerlo sin comprobar que corresponde a una aplicación que controlamos.

### Idea clave

**Antes de liberar un puerto, identifica el proceso y verifica que sea seguro detenerlo.**

---

# 26. Identificar un puerto ocupado en Linux

En Linux podemos utilizar:

```bash
ss -ltnp
```

## 26.1 ¿Qué significan las opciones?

- `-l`: Listening.
- `-t`: TCP.
- `-n`: mostrar valores numéricos.
- `-p`: mostrar información de procesos cuando esté disponible.

Para filtrar el puerto 3000:

```bash
ss -ltnp '( sport = :3000 )'
```

Dependiendo de los permisos, puede que no se muestre toda la información del proceso.

## 26.2 ¿Podemos utilizar lsof?

Sí, si está instalado:

```bash
lsof -nP -iTCP:3000 -sTCP:LISTEN
```

## 26.3 ¿Qué recomendamos?

Utilizar las herramientas disponibles en la distribución y comprender la información que devuelven.

### Idea clave

**Linux dispone de herramientas como `ss` y `lsof` para investigar endpoints de red y procesos asociados.**

---

# 27. Identificar un puerto ocupado en Windows

En PowerShell podemos utilizar:

```powershell
Get-NetTCPConnection -LocalPort 3000 -State Listen
```

Este comando consulta conexiones TCP en estado Listening para ese puerto.

## 27.1 Consultar el proceso asociado

```powershell
Get-NetTCPConnection -LocalPort 3000 -State Listen |
    Select-Object LocalAddress, LocalPort, OwningProcess
```

La propiedad `OwningProcess` contiene el PID.

## 27.2 Identificar el proceso

Supongamos que obtenemos:

```text
OwningProcess: 14285
```

Ejecutamos:

```powershell
Get-Process -Id 14285
```

## 27.3 Alternativa con netstat

```powershell
netstat -ano
```

Podemos filtrar resultados, pero debemos verificar que el puerto coincida exactamente y que el estado corresponda al que investigamos.

### Idea clave

**En Windows podemos relacionar un puerto TCP con un PID y después identificar el proceso mediante PowerShell.**

---

# 28. Detener procesos en macOS y Linux

Si tenemos un proceso que controlamos y necesitamos detenerlo, podemos utilizar:

```bash
kill 14285
```

Por defecto, `kill` envía normalmente `SIGTERM`.

## 28.1 ¿Qué debemos comprobar primero?

- Que el PID sea correcto.
- Que el proceso corresponda a nuestra aplicación.
- Que no esté realizando una operación importante.
- Que tengamos autorización para detenerlo.

## 28.2 ¿Qué ocurre si no termina?

Podemos investigar su estado y su comportamiento.

En casos excepcionales:

```bash
kill -9 14285
```

Envía `SIGKILL`.

## 28.3 ¿Por qué no comenzar con `kill -9`?

Porque no permite que el proceso maneje la señal para realizar una limpieza ordenada.

## 28.4 ¿Cuál es la mejor primera opción para un servidor iniciado por nosotros?

Si sigue en Foreground, normalmente utilizaremos:

```text
Ctrl + C
```

### Idea clave

**Detener un proceso de manera profesional significa identificarlo y utilizar el mecanismo menos agresivo que resulte apropiado.**

---

# 29. Detener procesos en PowerShell

Podemos utilizar:

```powershell
Stop-Process -Id 14285
```

## 29.1 ¿Qué ocurre con `-Force`?

PowerShell permite solicitar una finalización forzada:

```powershell
Stop-Process -Id 14285 -Force
```

No debemos asumir que `Stop-Process` proporciona el mismo manejo de señales o limpieza ordenada que `SIGTERM` en Unix.

## 29.2 ¿Qué recomendamos?

Cuando sea posible, detener la aplicación mediante su propio mecanismo de cierre.

Por ejemplo, desde la terminal donde está ejecutándose.

## 29.3 ¿Cuándo utilizar Stop-Process?

Cuando identificamos correctamente el proceso y necesitamos finalizarlo desde PowerShell.

### Idea clave

**PowerShell permite detener procesos por PID, pero debemos considerar el impacto de su finalización.**

---

# 30. Ejemplo real: React + Vite

Imaginemos esta estructura:

```text
my-react-app/
├── package.json
├── index.html
└── src/
```

Dentro de `package.json`:

```json
{
  "scripts": {
    "dev": "vite"
  }
}
```

Ejecutamos:

```bash
pnpm dev
```

Vite puede mostrar:

```text
Local: http://localhost:5173/
```

## 30.1 ¿Qué ocurre internamente?

Modelo simplificado:

```text
Developer
    │
    ▼
pnpm dev
    │
    ▼
Package Script
    │
    ▼
Vite
    │
    ▼
Development Server
    │
    ▼
Listening Endpoint
    │
    ▼
Browser Connection
```

## 30.2 ¿Por qué la terminal permanece ocupada?

Porque el servidor sigue ejecutándose.

## 30.3 ¿Por qué se detiene con Ctrl + C?

Porque solicitamos la interrupción del trabajo asociado a esa terminal.

## 30.4 ¿Por qué podría utilizar otro puerto?

Porque el puerto predeterminado podría estar ocupado y la herramienta puede intentar utilizar otro, según su configuración.

### Idea clave

**Un Development Server es un programa en ejecución que normalmente mantiene un endpoint disponible para recibir solicitudes.**

---

# 31. Ejemplo real: Node.js HTTP Server

Veamos un ejemplo mínimo.

Archivo:

```text
server.js
```

Contenido:

```javascript
const http = require("node:http");

const server = http.createServer((request, response) => {
  response.writeHead(200, {
    "Content-Type": "text/plain",
  });

  response.end("Hello from Node.js");
});

server.listen(3000, "127.0.0.1", () => {
  console.log("Server running at http://127.0.0.1:3000");
});
```

Ejecutamos:

```bash
node server.js
```

## 31.1 ¿Qué ocurre?

Node.js inicia un proceso que ejecuta nuestro programa.

El programa crea un servidor HTTP.

El servidor intenta escuchar en:

```text
127.0.0.1:3000
```

## 31.2 ¿Qué ocurre cuando abrimos el navegador?

El navegador intenta establecer una conexión con el endpoint.

Si el servidor está disponible, recibe la solicitud y devuelve una respuesta.

## 31.3 ¿Qué ocurre si iniciamos otra instancia?

Si la primera sigue utilizando el mismo endpoint, la segunda normalmente recibirá un error de dirección en uso.

## 31.4 ¿Qué ocurre al detener el servidor?

El proceso deja de prestar el servicio y el endpoint deja de estar disponible cuando sus recursos se liberan.

### Idea clave

**Un servidor HTTP conecta los conceptos Process, Socket, IP Address y Port.**

---

# 32. Ports y seguridad

Un servidor puede escuchar en diferentes direcciones.

Por ejemplo:

```text
127.0.0.1:3000
```

o:

```text
0.0.0.0:3000
```

Estas configuraciones no tienen el mismo alcance potencial.

## 32.1 ¿Por qué importa?

Porque una aplicación de desarrollo puede contener:

- Datos de prueba.
- Interfaces administrativas.
- APIs sin autenticación.
- Información sensible.
- Herramientas de depuración.

## 32.2 Buenas prácticas

- Utilizar Loopback cuando solamente necesitamos acceso local.
- No exponer servidores de desarrollo innecesariamente.
- Comprender las opciones de Host y Port.
- Revisar las reglas de Firewall.
- Evitar publicar servicios sin autenticación.
- No asumir que un puerto abierto es seguro.

## 32.3 ¿Cambiar el puerto mejora la seguridad?

No constituye por sí solo una medida de seguridad suficiente.

### Idea clave

**La configuración de red de un servidor forma parte de la seguridad del entorno de desarrollo.**

---

# 33. Troubleshooting: Port Already in Use

## Situación

Ejecutamos:

```bash
node server.js
```

Y recibimos:

```text
EADDRINUSE
```

## Procedimiento profesional

### Paso 1 — Identificar el endpoint

¿Qué dirección y puerto intenta utilizar la aplicación?

### Paso 2 — Consultar qué proceso escucha

macOS:

```bash
lsof -nP -iTCP:3000 -sTCP:LISTEN
```

Linux:

```bash
ss -ltnp '( sport = :3000 )'
```

Windows:

```powershell
Get-NetTCPConnection -LocalPort 3000 -State Listen
```

### Paso 3 — Identificar el proceso

Consultar el PID y el programa asociado.

### Paso 4 — Determinar si debe continuar

No detener procesos desconocidos.

### Paso 5 — Resolver

Podemos:

- Detener nuestra instancia anterior.
- Cambiar el puerto.
- Reutilizar el servidor existente.
- Corregir la configuración.

### Idea clave

**Primero diagnosticamos; después actuamos.**

---

# 34. Troubleshooting: Server Running but Browser Cannot Connect

## Situación

La terminal muestra:

```text
Server running on port 3000
```

Pero el navegador no puede acceder.

## Posibles causas

1. Dirección incorrecta.
2. Puerto incorrecto.
3. Servidor detenido.
4. Error de aplicación.
5. Firewall.
6. Diferencia entre Host y VM.
7. Diferencia entre Host y contenedor.
8. Binding a una interfaz diferente.
9. Problemas de red.
10. Protocolo incorrecto.

## Diagnóstico inicial

Comprobar:

- ¿El proceso sigue activo?
- ¿El puerto está Listening?
- ¿La dirección es correcta?
- ¿El navegador está en el mismo entorno?
- ¿La aplicación utiliza HTTP o HTTPS?

### Idea clave

**Que un proceso esté ejecutándose no garantiza que el servicio sea accesible desde el navegador.**

---

# 35. Troubleshooting: Process Continues After Closing Terminal

## Situación

Cerramos la terminal, pero el servidor sigue funcionando.

## Posibles causas

- Se inició como servicio.
- Se desacopló de la sesión.
- Se ejecuta bajo un administrador de procesos.
- Se encuentra dentro de otro entorno.
- La herramienta creó procesos independientes.

## Ejemplos de herramientas relacionadas

- PM2.
- systemd.
- Windows Services.
- Docker.

Cada una administra procesos de manera diferente.

## ¿Qué debemos hacer?

Identificar quién administra el proceso antes de intentar detenerlo.

### Idea clave

**No todos los procesos dependen directamente de que una ventana de terminal permanezca abierta.**

---

# 36. Práctica 01 — Observar un proceso

**Objetivo:** comprender que un programa puede permanecer activo.

## Bash/Zsh

Ejecuta:

```bash
sleep 60
```

Durante ese tiempo, el comando permanece en Foreground.

Puedes interrumpirlo con:

```text
Ctrl + C
```

## PowerShell

Ejecuta:

```powershell
Start-Sleep -Seconds 60
```

También puedes intentar interrumpirlo mediante `Ctrl + C`.

## Preguntas

1. ¿Por qué la terminal no devuelve inmediatamente el control?
2. ¿El programa utiliza CPU constantemente?
3. ¿Qué ocurrió al interrumpirlo?
4. ¿Qué diferencia existe entre un proceso activo y uno terminado?

---

# 37. Práctica 02 — Identificar procesos

**Objetivo:** reconocer procesos activos.

## macOS/Linux

```bash
ps aux
```

Si Node.js está ejecutándose:

```bash
ps aux | grep node
```

## PowerShell

```powershell
Get-Process
```

Para Node.js:

```powershell
Get-Process -Name node -ErrorAction SilentlyContinue
```

## Preguntas

1. ¿Qué procesos reconoces?
2. ¿Qué significa PID?
3. ¿Qué información de recursos puedes observar?
4. ¿Por qué podrían existir varias instancias del mismo programa?

---

# 38. Práctica 03 — Crear un servidor local

**Requisito:** tener Node.js instalado.

## Paso 1 — Crear un directorio de práctica

```bash
mkdir processes-practice
cd processes-practice
```

En PowerShell también puedes crear y acceder al directorio mediante `New-Item` y `Set-Location`.

## Paso 2 — Crear `server.js`

```javascript
const http = require("node:http");

const server = http.createServer((request, response) => {
  response.writeHead(200, {
    "Content-Type": "text/plain",
  });

  response.end("Processes and Ports Practice");
});

server.listen(3000, "127.0.0.1", () => {
  console.log("Listening on http://127.0.0.1:3000");
});
```

## Paso 3 — Ejecutar

```bash
node server.js
```

## Paso 4 — Abrir el navegador

Visita:

```text
http://127.0.0.1:3000
```

## Paso 5 — Observar

La terminal permanece ocupada mientras el servidor está activo.

## Paso 6 — Detener

Utiliza:

```text
Ctrl + C
```

## Preguntas

1. ¿Qué proceso ejecuta el servidor?
2. ¿Qué dirección utiliza?
3. ¿Qué puerto utiliza?
4. ¿Qué ocurre al detenerlo?
5. ¿Por qué el navegador ya no puede conectarse después?

---

# 39. Práctica 04 — Investigar un puerto

**Objetivo:** relacionar el servidor con su proceso.

Con el servidor anterior ejecutándose, abre otra terminal.

## macOS

```bash
lsof -nP -iTCP:3000 -sTCP:LISTEN
```

## Linux

```bash
ss -ltnp '( sport = :3000 )'
```

## Windows PowerShell

```powershell
Get-NetTCPConnection -LocalPort 3000 -State Listen
```

## Preguntas

1. ¿Aparece el puerto 3000?
2. ¿Qué PID está asociado?
3. ¿Qué proceso utiliza ese PID?
4. ¿Qué significa Listening?
5. ¿Qué ocurre después de detener el servidor?

---

# 40. Práctica 05 — Provocar un conflicto controlado

**Objetivo:** comprender `EADDRINUSE`.

## Paso 1

Inicia el servidor del ejercicio anterior.

```bash
node server.js
```

## Paso 2

Abre una segunda terminal en el mismo directorio.

## Paso 3

Ejecuta nuevamente:

```bash
node server.js
```

## Resultado esperado

La segunda instancia normalmente mostrará un error similar a:

```text
EADDRINUSE
```

## Paso 4

Regresa a la primera terminal y detén el servidor.

## Paso 5

Vuelve a ejecutar la segunda instancia.

Ahora debería poder utilizar el endpoint si ya quedó libre.

## Reflexión

1. ¿Por qué falló la segunda instancia?
2. ¿Qué recurso estaba ocupado?
3. ¿Por qué funcionó después?
4. ¿Qué diferencia existe entre PID y Port?
5. ¿Qué alternativa tendríamos si necesitáramos ejecutar ambos servidores?

---

# 41. Casos reales de ingeniería

## Caso 1 — Vite cambia de puerto

**Situación:** el puerto habitual está ocupado.

**Aprendizaje:** las herramientas de desarrollo pueden utilizar puertos alternativos según su configuración.

---

## Caso 2 — Una API Node.js muestra EADDRINUSE

**Situación:** otra instancia está utilizando el endpoint.

**Aprendizaje:** identificar el proceso antes de detenerlo.

---

## Caso 3 — Un servidor funciona en una VM, pero no desde el Host

**Situación:** existen diferencias de red y Binding.

**Aprendizaje:** comprender el contexto de `localhost`.

---

## Caso 4 — Docker publica un puerto

**Situación:** un servicio del contenedor necesita ser accesible desde otro entorno.

**Aprendizaje:** distinguir el puerto del servicio y las reglas de publicación o redirección.

---

## Caso 5 — Un servidor sigue activo después de cerrar la terminal

**Situación:** el proceso está administrado de otra manera.

**Aprendizaje:** identificar el mecanismo que controla su ciclo de vida.

---

## Caso 6 — Dos proyectos necesitan el mismo puerto

**Situación:** ambos servidores utilizan configuraciones predeterminadas.

**Aprendizaje:** utilizar puertos distintos o ejecutar los proyectos en momentos diferentes.

---

# 42. Errores frecuentes

### Error 1 — Confundir Program y Process

Un programa puede ejecutarse mediante múltiples procesos.

### Error 2 — Confundir PID y Port

Identifican conceptos diferentes.

### Error 3 — Pensar que un proceso activo siempre utiliza CPU

Puede estar esperando eventos.

### Error 4 — Pensar que Background significa servicio permanente

No necesariamente.

### Error 5 — Confundir Ctrl + Z con Ctrl + C

Suspender no es lo mismo que interrumpir.

### Error 6 — Utilizar terminación forzada como primera opción

Puede impedir una limpieza ordenada.

### Error 7 — Detener procesos sin identificarlos

Puede afectar otras aplicaciones.

### Error 8 — Pensar que localhost siempre representa el mismo entorno

Depende del contexto de red.

### Error 9 — Pensar que 0.0.0.0 es una dirección pública

Es una dirección comodín para Binding IPv4.

### Error 10 — Pensar que un puerto abierto garantiza una aplicación saludable

No necesariamente.

### Error 11 — Ignorar el protocolo de transporte

TCP y UDP son diferentes.

### Error 12 — Pensar que el número de puerto identifica completamente una conexión

También intervienen direcciones, protocolo y otros datos.

### Error 13 — Exponer servidores de desarrollo innecesariamente

Puede introducir riesgos de seguridad.

### Error 14 — Reinstalar Node.js para solucionar EADDRINUSE

Normalmente no resuelve la causa del conflicto.

### Error 15 — No comprender qué procesos inicia una herramienta

Puede dificultar la administración y el diagnóstico.

---

# 43. Comprueba tu modelo mental

1. ¿Qué es un Program?
2. ¿Qué es un Process?
3. ¿Cuál es la diferencia?
4. ¿Qué es un PID?
5. ¿Qué es un PPID?
6. ¿Qué es un Parent Process?
7. ¿Qué es un Child Process?
8. ¿Un programa puede tener varios procesos?
9. ¿Qué es un Thread?
10. ¿Qué diferencia existe entre Process y Thread?
11. ¿Qué es Foreground?
12. ¿Qué es Background?
13. ¿Qué es Job Control?
14. ¿Qué hace `jobs`?
15. ¿Qué hace `fg`?
16. ¿Qué hace `bg`?
17. ¿Qué hace `Ctrl + Z`?
18. ¿Qué hace normalmente `Ctrl + C`?
19. ¿Qué es SIGINT?
20. ¿Qué es SIGTERM?
21. ¿Qué es SIGKILL?
22. ¿Qué significa Graceful Shutdown?
23. ¿Qué es un Network Port?
24. ¿Cuál es la diferencia entre IP y Port?
25. ¿Qué significa localhost?
26. ¿Qué es Loopback?
27. ¿Qué representa `127.0.0.1`?
28. ¿Qué representa `::1`?
29. ¿Qué es un Socket?
30. ¿Qué significa Listening?
31. ¿Qué diferencia existe entre TCP y UDP?
32. ¿Qué significa Bind Address?
33. ¿Qué significa `0.0.0.0` al configurar un servidor IPv4?
34. ¿Qué es un Port Conflict?
35. ¿Qué significa EADDRINUSE?
36. ¿Cómo identificas un puerto ocupado en macOS?
37. ¿Cómo lo identificas en Linux?
38. ¿Cómo lo identificas en Windows?
39. ¿Cómo consultas un proceso mediante su PID?
40. ¿Por qué debemos evitar terminar procesos desconocidos?
41. ¿Qué ocurre al ejecutar `pnpm dev`?
42. ¿Por qué Vite necesita un servidor activo?
43. ¿Por qué un servidor puede funcionar dentro de una VM y no desde el Host?
44. ¿Por qué un proceso puede continuar después de cerrar la terminal?
45. ¿Cuál es el procedimiento correcto para resolver un puerto ocupado?

---

# 44. Checklist de aprendizaje

## Process Fundamentals

- [ ] Comprendo Program vs Process.
- [ ] Comprendo PID y PPID.
- [ ] Comprendo Parent y Child Processes.
- [ ] Reconozco Process vs Thread.
- [ ] Comprendo el ciclo de vida de un proceso.

## Process Management

- [ ] Diferencio Foreground y Background.
- [ ] Comprendo Job Control.
- [ ] Comprendo `Ctrl + C` y `Ctrl + Z`.
- [ ] Reconozco SIGINT, SIGTERM y SIGKILL.
- [ ] Comprendo Graceful Shutdown.
- [ ] Sé identificar procesos activos.

## Networking Fundamentals

- [ ] Comprendo qué es un Port.
- [ ] Diferencio IP Address y Port.
- [ ] Comprendo localhost y Loopback.
- [ ] Comprendo Listening.
- [ ] Reconozco TCP y UDP.
- [ ] Comprendo Bind Address.
- [ ] Comprendo qué representa `0.0.0.0`.

## Troubleshooting

- [ ] Comprendo EADDRINUSE.
- [ ] Sé identificar qué proceso utiliza un puerto.
- [ ] Sé consultar un PID.
- [ ] Sé detener un proceso de manera segura.
- [ ] Comprendo por qué un servidor puede no ser accesible.
- [ ] Reconozco riesgos de exponer servidores.

---

# 45. Resumen conceptual

Nuestro modelo mental queda así:

```text
Developer
    │
    ▼
Terminal
    │
    ▼
Shell
    │
    ▼
Command
    │
    ▼
Executable
    │
    ▼
Process
    │
    ├── PID
    ├── Memory
    ├── CPU
    └── Resources
            │
            ▼
         Socket
            │
            ▼
      IP Address + Port
            │
            ▼
      Network Communication
```

Este diagrama representa el caso de una aplicación que utiliza comunicación de red; no todos los procesos necesitan un Socket.

Recordemos:

```text
Program ≠ Process
```

```text
PID ≠ Port
```

```text
Process Running ≠ Service Accessible
```

```text
localhost ≠ Public Internet
```

```text
Foreground ≠ Background
```

---

# 46. Idea clave

**Un proceso es una instancia de ejecución administrada por el sistema operativo, mientras que un puerto es un identificador utilizado para la comunicación de red.**

Cuando desarrollamos aplicaciones web, ambos conceptos se relacionan:

1. Ejecutamos una herramienta.
2. Se inicia uno o más procesos.
3. Un servidor crea un Socket.
4. El servidor intenta escuchar en una dirección y puerto.
5. El navegador establece una conexión.
6. El servidor procesa solicitudes.
7. Al detener el proceso, el servicio deja de estar disponible.

Comprender esta secuencia permite diagnosticar problemas reales sin depender de soluciones improvisadas.

---

# 47. Siguiente paso

Ahora que comprendemos cómo se ejecutan los procesos, aprenderemos a conectar comandos y trabajar con sus resultados.

El siguiente documento será:

**10 — Command Chaining and Pipes**

Estudiaremos:

- Standard Input.
- Standard Output.
- Standard Error.
- Exit Codes.
- `&&` y `||`.
- Pipes.
- Redirection.
- Diferencias entre Bash/Zsh y PowerShell.
- Ejemplos prácticos de automatización.

👉 [10 — Command Chaining and Pipes](./10-command-chaining-and-pipes.md)

**Primero aprendimos cómo funcionan los programas en ejecución. Ahora aprenderemos cómo combinar comandos para construir flujos de trabajo más potentes.**