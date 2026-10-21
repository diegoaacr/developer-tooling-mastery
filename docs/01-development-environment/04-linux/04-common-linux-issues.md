# Common Linux Issues

## Introducción

Aprender Linux no significa memorizar cientos de comandos.

Significa comprender cómo funciona el sistema y desarrollar la capacidad de investigar problemas de manera ordenada.

Durante el desarrollo profesional encontraremos situaciones como:

- Un comando que no existe.
- Una herramienta instalada que no se ejecuta.
- Un error de permisos.
- Una versión incorrecta de Node.js.
- Un paquete que no puede instalarse.
- Un puerto ocupado.
- Un servicio que no responde.
- Un Script que funciona localmente, pero falla en CI.
- Un problema de DNS.
- Un archivo que aparentemente existe, pero no puede ejecutarse.

Muchos desarrolladores intentan resolver estas situaciones copiando comandos de Internet.

Esto puede funcionar ocasionalmente, pero no construye un conocimiento sólido.

Peor aún, algunas soluciones improvisadas pueden modificar permisos, eliminar archivos, desactivar controles de seguridad o deteriorar el entorno.

Nuestro objetivo será desarrollar una metodología profesional de **Troubleshooting**.

No estudiaremos solamente errores individuales.

Aprenderemos a identificar qué componente es responsable de un problema y cómo comprobar nuestras hipótesis.

La metodología será:

**Síntoma → Contexto → Evidencia → Hipótesis → Verificación → Solución → Validación → Documentación.**

---

## 🎯 Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Explicar qué es Troubleshooting.
2. Diferenciar síntomas y causas raíz.
3. Aplicar una metodología de diagnóstico.
4. Identificar problemas relacionados con PATH.
5. Diagnosticar errores de permisos.
6. Comprender errores de archivos y directorios.
7. Reconocer problemas de Shell Configuration.
8. Diagnosticar conflictos de versiones.
9. Investigar errores de gestores de paquetes.
10. Diferenciar problemas de red, DNS y conectividad.
11. Identificar procesos y puertos ocupados.
12. Investigar problemas de almacenamiento.
13. Reconocer diferencias entre arquitecturas.
14. Comprender errores frecuentes de Scripts.
15. Identificar diferencias entre entornos locales, remotos y CI.
16. Utilizar comandos de inspección sin modificar el sistema.
17. Documentar incidentes y sus soluciones.
18. Construir hábitos profesionales de diagnóstico.

---

# 1. ¿Qué es Troubleshooting?

**Troubleshooting** es el proceso sistemático de investigar, identificar y resolver problemas técnicos.

No consiste únicamente en encontrar un comando que elimine un error.

Consiste en comprender:

- Qué está fallando.
- En qué condiciones ocurre.
- Qué componente está involucrado.
- Qué evidencia tenemos.
- Cuál es la causa.
- Cómo validar la solución.

## 1.1 Ejemplo

Ejecutamos:

```bash
node --version
```

Y recibimos:

```text
node: command not found
```

Una reacción impulsiva sería instalar Node.js inmediatamente.

Pero el error no demuestra por sí solo que Node.js no esté instalado.

También podría suceder que:

- PATH no incluya su ubicación.
- El gestor de versiones no esté inicializado.
- Estemos utilizando otro usuario.
- La Terminal utilice otro Shell.
- El ejecutable tenga otro nombre o ubicación.

## 1.2 Modelo profesional

```text
Observed Error
      │
      ▼
Collect Context
      │
      ▼
Gather Evidence
      │
      ▼
Form Hypotheses
      │
      ▼
Test Hypotheses
      │
      ▼
Identify Root Cause
      │
      ▼
Apply Controlled Fix
      │
      ▼
Validate Result
      │
      ▼
Document Learning
```

### Idea clave

**Un buen diagnóstico comienza investigando, no modificando.**

---

# 2. Síntoma vs Root Cause

Es fundamental diferenciar el síntoma de la causa raíz.

## 2.1 Síntoma

Es el comportamiento observable que indica un problema.

Ejemplo:

```text
npm: command not found
```

## 2.2 Root Cause

Es la causa subyacente que explica el problema.

Por ejemplo:

```text
Runtime Manager Initialization Missing
```

## 2.3 Ejemplo completo

```text
Symptom
   │
   ▼
npm: command not found
   │
   ▼
Investigation
   │
   ├── Node installed?
   ├── PATH correct?
   ├── Shell initialized?
   └── Runtime manager active?
   │
   ▼
Root Cause
   │
   ▼
Shell did not load runtime configuration
```

## 2.4 ¿Por qué importa?

Porque corregir el síntoma sin comprender la causa puede provocar que el problema reaparezca.

### Principio

**La solución correcta debe actuar sobre la causa identificada, no sobre una suposición.**

---

# 3. Metodología profesional de diagnóstico

Utilizaremos ocho etapas.

## Step 1 — Identificar el síntoma

¿Qué sucede exactamente?

Ejemplo:

```text
Command not found
```

## Step 2 — Comprender el contexto

Preguntamos:

- ¿Qué sistema operativo utilizamos?
- ¿Qué distribución?
- ¿Qué Shell?
- ¿Qué usuario?
- ¿Qué herramienta?
- ¿Qué versión?
- ¿Dónde ocurre?

## Step 3 — Recolectar evidencia

Utilizamos comandos de inspección.

Por ejemplo:

```bash
command -v node
```

```bash
echo "$PATH"
```

## Step 4 — Formular hipótesis

Ejemplo:

```text
Hypothesis A: Node.js is not installed

Hypothesis B: PATH is incorrect

Hypothesis C: Runtime manager is not initialized
```

## Step 5 — Verificar hipótesis

Comprobamos cada posibilidad utilizando evidencia.

## Step 6 — Aplicar una solución controlada

Elegimos la modificación más pequeña que resuelva la causa.

## Step 7 — Validar

Confirmamos que el problema desapareció y que no introdujimos efectos secundarios.

## Step 8 — Documentar

Registramos el problema, su causa y la solución.

### Principio

**El diagnóstico debe ser reproducible y explicable.**

---

# 4. Identificar el entorno antes de diagnosticar

Antes de investigar un error necesitamos saber dónde estamos trabajando.

## 4.1 Identificar distribución

```bash
cat /etc/os-release
```

Permite consultar información de la distribución.

## 4.2 Identificar Kernel

```bash
uname -r
```

## 4.3 Identificar arquitectura

```bash
uname -m
```

## 4.4 Identificar usuario

```bash
whoami
```

## 4.5 Identificar directorio actual

```bash
pwd
```

## 4.6 Identificar Shell configurado

```bash
echo "$SHELL"
```

Esta variable suele indicar el Shell configurado para el usuario, pero no demuestra necesariamente cuál es el proceso Shell actual.

## 4.7 Identificar proceso Shell

```bash
ps -p $$ -o comm=
```

En Shells que interpretan `$$` como el identificador del proceso actual, este comando permite consultar su nombre.

## 4.8 ¿Por qué es importante?

Porque una solución para Ubuntu puede no ser apropiada para Arch Linux.

Una solución para Bash puede no funcionar en Fish.

Y una solución para Linux x86-64 puede no ser compatible con ARM64.

### Idea clave

**Nunca diagnostiques un problema sin identificar primero el entorno donde ocurre.**

---

# 5. Issue: Command Not Found

Este es uno de los errores más habituales.

## 5.1 Síntoma

```text
command not found
```

Ejemplo:

```bash
git --version
```

El Shell no consigue resolver el comando.

## 5.2 Posibles causas

- La herramienta no está instalada.
- El ejecutable no está incluido en PATH.
- La configuración del Shell no se cargó.
- Existe un error tipográfico.
- Estamos utilizando otro entorno.
- La herramienta está instalada para otro usuario.

## 5.3 Diagnóstico

```bash
command -v git
```

En Bash:

```bash
type -a git
```

Consultar PATH:

```bash
echo "$PATH"
```

## 5.4 Modelo

```text
Command Not Found
       │
       ▼
Check Command Name
       │
       ▼
Check Command Resolution
       │
       ▼
Inspect PATH
       │
       ▼
Check Installation
       │
       ▼
Check Shell Configuration
```

## 5.5 ¿Qué debemos evitar?

No instalar repetidamente la misma herramienta sin comprobar si ya existe.

### Aprendizaje

**Un comando no encontrado puede ser un problema de resolución, no necesariamente de instalación.**

---

# 6. Issue: Wrong Tool Version

## 6.1 Síntoma

El proyecto necesita una versión concreta de Node.js.

Pero:

```bash
node --version
```

Devuelve otra.

## 6.2 Posibles causas

- Varias instalaciones.
- PATH con prioridad incorrecta.
- Gestor de versiones no inicializado.
- Versión activa diferente.
- Configuración del proyecto no aplicada.

## 6.3 Diagnóstico

```bash
node --version
```

```bash
command -v node
```

En Bash:

```bash
type -a node
```

## 6.4 Ejemplo conceptual

```text
PATH
│
├── /usr/local/bin/node
│
└── /home/developer/.local/share/.../node
```

La primera coincidencia aplicable puede determinar la versión utilizada.

## 6.5 ¿Cuál es la solución?

Depende de la causa.

Podría ser necesario:

- Seleccionar la versión correcta.
- Inicializar el gestor de versiones.
- Corregir PATH.
- Eliminar una configuración obsoleta.

No debemos realizar ninguna de estas acciones sin verificar primero el origen del conflicto.

### Principio

**Tener instalada la versión correcta no garantiza que sea la versión activa.**

---

# 7. Issue: Permission Denied

## 7.1 Síntoma

```text
Permission denied
```

Puede aparecer al:

- Leer archivos.
- Modificar directorios.
- Ejecutar programas.
- Acceder a recursos.

## 7.2 Modelo básico de permisos

En Linux encontramos permisos asociados a:

```text
Read
Write
Execute
```

Y categorías como:

```text
Owner
Group
Others
```

## 7.3 Consultar permisos

```bash
ls -l
```

Ejemplo ilustrativo:

```text
-rwxr-xr-- 1 developer developers 1200 script.sh
```

## 7.4 Interpretación

```text
- rwx r-x r--
  │   │   │
  │   │   └── Others
  │   └────── Group
  └────────── Owner
```

Los permisos efectivos también pueden depender de ACL, atributos adicionales, sistema de archivos y otros mecanismos.

## 7.5 Posibles causas

- El usuario no tiene permisos.
- El archivo pertenece a otro usuario.
- El directorio no permite acceso.
- El archivo no tiene permiso de ejecución.
- Existe una restricción adicional del sistema.

## 7.6 ¿Debemos utilizar sudo?

No automáticamente.

Primero debemos comprender qué recurso está protegido y por qué.

### Advertencia

Evita soluciones indiscriminadas como:

```bash
sudo chmod -R 777 .
```

Este comando puede alterar masivamente los permisos y crear riesgos de seguridad.

**No debe utilizarse como solución genérica a problemas de permisos.**

---

# 8. Issue: Script Cannot Execute

## 8.1 Síntoma

Intentamos ejecutar:

```bash
./script.sh
```

Y aparece un error.

## 8.2 Posibles causas

- Permiso de ejecución ausente.
- Intérprete inexistente.
- Shebang incorrecto.
- Archivo con finales de línea incompatibles.
- Ruta incorrecta.
- Sistema de archivos con restricciones.

## 8.3 Consultar permisos

```bash
ls -l script.sh
```

## 8.4 Consultar primera línea

```bash
head -n 1 script.sh
```

Podríamos encontrar:

```bash
#!/usr/bin/env bash
```

Esta línea se conoce como **Shebang**.

## 8.5 ¿Qué hace?

Indica qué intérprete debe utilizarse al ejecutar el archivo directamente, siempre que el sistema y el contexto soporten ese mecanismo.

## 8.6 ¿Es lo mismo ejecutar con Bash?

No exactamente.

```bash
bash script.sh
```

Invoca Bash explícitamente para interpretar el archivo.

Mientras que:

```bash
./script.sh
```

Solicita la ejecución directa del archivo y depende de los permisos y del mecanismo de ejecución correspondiente.

### Idea clave

**Los problemas de ejecución pueden deberse al intérprete, los permisos o el formato del archivo.**

---

# 9. Issue: No Such File or Directory

## 9.1 Síntoma

```text
No such file or directory
```

## 9.2 Posibles causas

- Ruta incorrecta.
- Archivo inexistente.
- Diferencias entre mayúsculas y minúsculas.
- Directorio actual incorrecto.
- Enlace simbólico roto.
- Intérprete indicado en el Shebang inexistente.
- Dependencias de ejecución ausentes.

## 9.3 Diagnóstico

```bash
pwd
```

```bash
ls -la
```

```bash
ls -l nombre-del-archivo
```

## 9.4 Rutas absolutas y relativas

Ruta absoluta:

```text
/home/developer/project
```

Ruta relativa:

```text
./project
```

## 9.5 Problema habitual

Un Script funciona cuando se ejecuta desde la raíz del proyecto, pero falla desde otro directorio.

Esto puede indicar que depende del directorio de trabajo actual.

### Principio

**La ubicación del Script y el directorio desde el que se ejecuta no son necesariamente lo mismo.**

---

# 10. Issue: Case Sensitivity

En muchos sistemas de archivos utilizados con Linux, los nombres distinguen mayúsculas de minúsculas.

## 10.1 Ejemplo

```text
UserService.ts
```

No necesariamente es el mismo archivo que:

```text
userservice.ts
```

## 10.2 Problema habitual

Una importación funciona en un entorno con un sistema de archivos que no distingue mayúsculas, pero falla en Linux.

Ejemplo:

```ts
import { UserService } from "./userservice";
```

Mientras el archivo real se llama:

```text
UserService.ts
```

## 10.3 ¿Por qué importa?

Porque podemos trabajar en:

- Windows.
- macOS.
- Linux.
- CI.
- Contenedores.

Y encontrar diferencias de comportamiento.

## 10.4 Buena práctica

Mantener nombres e importaciones consistentes.

### Aprendizaje

**La portabilidad también depende de respetar las reglas del sistema de archivos.**

---

# 11. Issue: Broken Symbolic Link

## 11.1 ¿Qué es un Symbolic Link?

Es una referencia que apunta a otra ruta del sistema de archivos.

## 11.2 Modelo

```text
Shortcut Path
     │
     ▼
Symbolic Link
     │
     ▼
Target Path
```

## 11.3 ¿Qué sucede si el destino desaparece?

El enlace puede quedar roto.

## 11.4 Diagnóstico

```bash
ls -l
```

Para consultar el destino textual de un enlace:

```bash
readlink nombre-del-enlace
```

Para intentar resolver su destino final:

```bash
readlink -f nombre-del-enlace
```

La disponibilidad y el comportamiento de las opciones pueden variar entre implementaciones.

## 11.5 Problema habitual

Una herramienta parece existir en una ubicación, pero el enlace apunta a un ejecutable que ya no está disponible.

### Principio

**La existencia de una ruta no garantiza que su destino sea válido.**

---

# 12. Issue: Package Not Found

## 12.1 Síntoma

El gestor de paquetes no encuentra una herramienta.

## 12.2 Posibles causas

- Nombre incorrecto.
- Repositorio no configurado.
- Metadatos desactualizados.
- Distribución incompatible.
- Arquitectura no soportada.
- Paquete no disponible.

## 12.3 Diagnóstico en Debian/Ubuntu

```bash
apt search nombre-del-paquete
```

```bash
apt-cache policy nombre-del-paquete
```

## 12.4 Diagnóstico en Fedora

```bash
dnf search nombre-del-paquete
```

## 12.5 Diagnóstico en Arch

```bash
pacman -Ss nombre-del-paquete
```

## 12.6 ¿Qué debemos evitar?

Añadir inmediatamente repositorios desconocidos.

### Recomendación

Comprobar primero el nombre, la distribución, la arquitectura y las fuentes oficiales disponibles.

---

# 13. Issue: Dependency Conflict

## 13.1 Síntoma

Un gestor de paquetes no puede resolver una instalación o actualización.

## 13.2 Posibles causas

- Restricciones incompatibles.
- Repositorios mezclados.
- Versiones retenidas.
- Paquetes incompatibles.
- Estado incompleto de operaciones anteriores.

## 13.3 Modelo

```text
Application A
    │
    └── Requires Library B v2
```

Mientras:

```text
Application C
    │
    └── Requires Library B v1
```

El sistema puede necesitar una estrategia específica para resolver estas restricciones.

## 13.4 ¿Qué debemos hacer?

- Leer el error completo.
- Identificar los paquetes implicados.
- Consultar versiones.
- Revisar repositorios.
- Comprender las restricciones.

## 13.5 ¿Qué debemos evitar?

Forzar instalaciones sin comprender las consecuencias.

### Principio

**Un conflicto de dependencias es un problema de compatibilidad que requiere análisis, no solamente insistir en la instalación.**

---

# 14. Issue: Repository or Certificate Error

## 14.1 Síntoma

El gestor no puede descargar o verificar paquetes.

## 14.2 Posibles causas

- Repositorio no disponible.
- URL incorrecta.
- Problemas de DNS.
- Proxy.
- Certificados.
- Claves de firma.
- Configuración de confianza.

## 14.3 Modelo conceptual

```text
Package Manager
      │
      ▼
Network
      │
      ▼
Repository
      │
      ▼
Metadata / Packages
      │
      ▼
Verification
```

## 14.4 ¿Qué no debemos hacer?

No desactivar automáticamente:

- Verificación TLS.
- Comprobaciones de firmas.
- Controles de autenticidad.

## 14.5 Recomendación

Investigar qué verificación está fallando y por qué.

### Idea clave

**Un error de confianza es una señal para investigar, no una invitación a eliminar controles de seguridad.**

---

# 15. Issue: Network Unreachable

## 15.1 Síntoma

Una aplicación no puede conectarse a un servicio.

## 15.2 Posibles causas

- Interfaz de red sin conectividad.
- Ruta de red incorrecta.
- Firewall.
- VPN.
- Proxy.
- Servidor remoto no disponible.
- Configuración de red.

## 15.3 Consultar interfaces y direcciones

En sistemas con `iproute2`:

```bash
ip addr
```

## 15.4 Consultar rutas

```bash
ip route
```

## 15.5 Consultar conectividad

```bash
ping -c 4 1.1.1.1
```

Este comando envía paquetes ICMP.

Su resultado debe interpretarse con cuidado: algunas redes bloquean ICMP aunque otros protocolos funcionen.

## 15.6 ¿Qué debemos investigar?

```text
Application
     │
     ▼
Local Network
     │
     ▼
Routing
     │
     ▼
Remote Network
     │
     ▼
Destination Service
```

### Principio

**No todos los problemas de conexión tienen la misma causa ni se diagnostican con una única herramienta.**

---

# 16. Issue: DNS Resolution Failed

## 16.1 ¿Qué es DNS?

DNS permite resolver nombres de dominio utilizando información del sistema de nombres.

## 16.2 Ejemplo conceptual

```text
example.com
     │
     ▼
DNS Resolution
     │
     ▼
IP Address
```

## 16.3 Síntoma

Una herramienta no puede resolver el nombre del servidor.

## 16.4 Diagnóstico

Si está disponible:

```bash
getent hosts example.com
```

También podemos consultar con herramientas como:

```bash
dig example.com
```

`dig` no está necesariamente instalado en todas las distribuciones.

## 16.5 ¿Qué debemos diferenciar?

- Resolución DNS.
- Conectividad IP.
- Conexión TCP.
- Respuesta HTTP.
- Autenticación de la aplicación.

## 16.6 Ejemplo

Podemos resolver correctamente un dominio y, aun así, no conseguir conectarnos al servicio.

### Idea clave

**Resolver un nombre no garantiza que el servicio remoto esté disponible.**

---

# 17. Issue: HTTP Request Failed

## 17.1 Síntoma

Una aplicación no consigue consumir una API.

## 17.2 Posibles causas

- DNS.
- Red.
- TLS.
- Proxy.
- Autenticación.
- URL incorrecta.
- Servicio caído.
- Error de aplicación.

## 17.3 Herramienta de diagnóstico

Si `curl` está disponible:

```bash
curl -I https://example.com
```

Solicita las cabeceras mediante una petición HEAD.

Algunos servicios no admiten HEAD o responden de forma diferente a GET.

## 17.4 Modelo

```text
Application
    │
    ▼
DNS
    │
    ▼
Network
    │
    ▼
TLS
    │
    ▼
HTTP
    │
    ▼
Application Response
```

## 17.5 ¿Qué debemos observar?

- Código de estado HTTP.
- Errores de conexión.
- Errores de certificado.
- Redirecciones.
- Respuesta del servidor.

### Advertencia

No debemos desactivar la validación TLS mediante opciones inseguras como solución permanente.

---

# 18. Issue: Port Already in Use

Este problema aparece frecuentemente al levantar aplicaciones Backend.

## 18.1 Síntoma

```text
EADDRINUSE
```

En Node.js puede indicar que la dirección y el puerto solicitados ya están en uso.

## 18.2 Ejemplo

Nuestra aplicación intenta escuchar en:

```text
localhost:3000
```

Pero otro proceso ya utiliza esa combinación de dirección y puerto.

## 18.3 Modelo

```text
Process A
    │
    ▼
Port 3000
```

```text
Process B
    │
    ▼
Attempts Port 3000
    │
    ▼
EADDRINUSE
```

## 18.4 Diagnóstico

En Linux, si está disponible:

```bash
ss -ltnp
```

Muestra sockets TCP en escucha y puede incluir información de procesos cuando existen permisos suficientes.

Para filtrar por el puerto 3000:

```bash
ss -ltnp '( sport = :3000 )'
```

## 18.5 Alternativa

Si `lsof` está instalado:

```bash
lsof -iTCP:3000 -sTCP:LISTEN
```

## 18.6 ¿Debemos finalizar el proceso?

No inmediatamente.

Primero debemos identificar:

- Qué proceso es.
- Quién lo inició.
- Qué servicio representa.
- Si podemos detenerlo.
- Si debemos utilizar otro puerto.

### Principio

**Un puerto ocupado no significa necesariamente que exista un proceso incorrecto.**

---

# 19. Issue: Process Not Running

## 19.1 Síntoma

Esperamos que una aplicación esté activa, pero no responde.

## 19.2 Posibles causas

- El proceso terminó.
- Falló durante el inicio.
- Se cerró por un error.
- No está escuchando en el puerto esperado.
- Se ejecuta bajo otro usuario.
- Está administrado por otro mecanismo.

## 19.3 Consultar procesos

```bash
ps aux
```

La salida puede ser extensa.

Para buscar procesos relacionados con Node.js:

```bash
ps aux | grep '[n]ode'
```

Este comando realiza una búsqueda textual; no identifica de forma infalible todos los procesos relacionados.

## 19.4 ¿Qué debemos comprobar?

- Proceso.
- Estado.
- Argumentos.
- Usuario.
- Logs.
- Puerto.

## 19.5 Importante

No debemos finalizar procesos que no comprendemos.

---

# 20. Issue: Service Failed

En muchas distribuciones Linux se utiliza systemd para administrar servicios.

## 20.1 ¿Qué es un Service?

Es una unidad de software que puede ejecutarse y administrarse como parte del sistema.

## 20.2 ¿Qué es systemd?

Es un conjunto de componentes para la inicialización y administración de servicios y otras unidades del sistema.

No todas las distribuciones utilizan systemd.

## 20.3 Consultar estado

En un sistema que utiliza systemd:

```bash
systemctl status nombre-del-servicio
```

## 20.4 Consultar logs

```bash
journalctl -u nombre-del-servicio
```

## 20.5 ¿Qué debemos observar?

- Estado.
- Errores de inicio.
- Configuración.
- Dependencias.
- Permisos.
- Recursos.

## 20.6 Advertencia

No debemos reiniciar servicios críticos sin autorización ni comprender su impacto.

### Idea clave

**Un servicio puede fallar por problemas de configuración, dependencias o recursos, aunque su ejecutable esté instalado correctamente.**

---

# 21. Issue: Disk Space Full

## 21.1 Síntoma

```text
No space left on device
```

## 21.2 Posibles causas

- Sistema de archivos lleno.
- Inodos agotados.
- Cuotas.
- Logs acumulados.
- Archivos temporales.
- Cachés.
- Artefactos de Build.

## 21.3 Consultar espacio

```bash
df -h
```

## 21.4 Consultar inodos

```bash
df -i
```

## 21.5 Consultar tamaño de un directorio

```bash
du -sh .
```

## 21.6 ¿Qué debemos evitar?

Eliminar directorios indiscriminadamente.

Por ejemplo, no debemos borrar carpetas del sistema, cachés o directorios de proyectos sin comprender qué contienen.

## 21.7 Procedimiento

```text
Disk Error
    │
    ▼
Identify Filesystem
    │
    ▼
Check Available Space
    │
    ▼
Check Inodes / Quotas
    │
    ▼
Identify Large Directories
    │
    ▼
Review Safe Cleanup Options
```

### Principio

**Liberar espacio debe ser una operación informada y controlada.**

---

# 22. Issue: Memory Pressure

## 22.1 Síntoma

Una aplicación se ralentiza, falla o termina inesperadamente.

## 22.2 Posibles causas

- Memoria insuficiente.
- Consumo excesivo.
- Límites de contenedor.
- Procesos concurrentes.
- Configuración de la aplicación.

## 22.3 Consultar memoria

```bash
free -h
```

## 22.4 Consultar procesos

```bash
ps aux
```

## 22.5 Herramienta interactiva

```bash
top
```

Para salir de `top`, normalmente podemos presionar `q`.

## 22.6 ¿Qué debemos interpretar con cuidado?

Linux utiliza memoria para cachés y otros mecanismos de optimización.

Por eso, observar poca memoria completamente libre no demuestra automáticamente un problema.

### Idea clave

**El diagnóstico de memoria requiere interpretar el uso de recursos, no solamente mirar una cifra aislada.**

---

# 23. Issue: Architecture Mismatch

## 23.1 Síntoma

Un ejecutable no puede iniciarse correctamente.

Podríamos encontrar errores como:

```text
Exec format error
```

## 23.2 Posibles causas

- Binario para otra arquitectura.
- Formato incompatible.
- Intérprete no disponible.
- Archivo que no corresponde a un ejecutable válido para el entorno.

## 23.3 Consultar arquitectura

```bash
uname -m
```

Ejemplos habituales:

```text
x86_64
aarch64
```

## 23.4 Consultar archivo

Si está disponible:

```bash
file ruta-del-ejecutable
```

## 23.5 Modelo

```text
Operating System
      │
      └── Architecture A
```

```text
Downloaded Binary
      │
      └── Architecture B
```

Si son incompatibles, el programa puede no ejecutarse sin mecanismos adicionales.

## 23.6 ¿Por qué importa?

Porque los desarrolladores pueden trabajar con:

- Linux x86-64.
- Linux ARM64.
- Máquinas virtuales.
- Contenedores.
- Diferentes plataformas de CI.

### Principio

**Antes de descargar un binario, debemos verificar su compatibilidad con el sistema de destino.**

---

# 24. Issue: Missing Shared Library

## 24.1 Síntoma

Una aplicación no puede iniciarse porque falta una biblioteca compartida.

## 24.2 Ejemplo conceptual

```text
Application
    │
    └── Requires Library X
              │
              ▼
         Not Available
```

## 24.3 ¿Qué es una Shared Library?

Es una biblioteca que puede ser utilizada por programas durante su ejecución.

## 24.4 Diagnóstico

En determinados entornos Linux podemos utilizar:

```bash
ldd ruta-del-ejecutable
```

**Advertencia:** no utilices `ldd` indiscriminadamente con ejecutables desconocidos o no confiables; dependiendo del entorno y del binario, puede implicar riesgos de ejecución.

Para inspección inicial de archivos no confiables, es preferible utilizar herramientas de análisis estático apropiadas.

## 24.5 ¿Qué debemos comprobar?

- Arquitectura.
- Dependencias.
- Bibliotecas disponibles.
- Compatibilidad.
- Procedencia del binario.

### Aprendizaje

**Un programa puede existir y tener permisos correctos, pero fallar por dependencias de ejecución.**

---

# 25. Issue: Incorrect Line Endings

Este problema es frecuente en equipos que trabajan con Windows y Linux.

## 25.1 LF

En entornos Unix es habitual utilizar:

```text
LF
```

## 25.2 CRLF

En Windows es habitual encontrar:

```text
CRLF
```

## 25.3 Problema típico

Un Script creado con CRLF puede producir errores relacionados con el intérprete.

Por ejemplo:

```text
bad interpreter
```

En algunos casos aparece un carácter `^M` en el mensaje.

## 25.4 Diagnóstico

Si está disponible:

```bash
file script.sh
```

También podemos inspeccionar caracteres de control mediante herramientas adecuadas.

## 25.5 ¿Qué debemos hacer?

Identificar el formato y establecer una política coherente para el repositorio.

## 25.6 Relación con Git

Git permite administrar comportamientos relacionados con finales de línea.

Por ejemplo, mediante `.gitattributes`.

Estudiaremos estos estándares con mayor profundidad en módulos posteriores.

### Principio

**Los finales de línea forman parte de la compatibilidad entre entornos.**

---

# 26. Issue: Shell Script Works Locally but Fails in CI

## 26.1 Síntoma

Un Script funciona en nuestra Terminal, pero falla en un Pipeline.

## 26.2 Posibles causas

- Shell diferente.
- Variables ausentes.
- PATH diferente.
- Runtime incorrecto.
- Directorio de trabajo distinto.
- Dependencias no instaladas.
- Permisos.
- Diferencias de sistema operativo.

## 26.3 Modelo

```text
Local Environment
│
├── Bash
├── Node.js
├── PATH
├── Environment Variables
└── Working Directory
```

```text
CI Environment
│
├── Shell
├── Runtime
├── PATH
├── Environment Variables
└── Working Directory
```

## 26.4 ¿Qué debemos hacer?

Comparar explícitamente ambos entornos.

## 26.5 ¿Qué debemos evitar?

Depender de:

- Alias personales.
- Funciones locales.
- Herramientas globales no documentadas.
- Variables configuradas manualmente.

### Principio

**Un Script profesional debe funcionar en un entorno que cumpla requisitos declarados, no solamente en la computadora de su autor.**

---

# 27. Issue: Different Behavior in Docker

## 27.1 Síntoma

Una aplicación funciona en Linux local, pero falla dentro de un contenedor.

## 27.2 Posibles causas

- Imagen base diferente.
- Bibliotecas diferentes.
- Arquitectura.
- Usuario.
- Permisos.
- Variables.
- Red.
- Sistema de archivos.
- Dependencias nativas.

## 27.3 Modelo

```text
Linux Host
    │
    ▼
Container Runtime
    │
    ▼
Container Environment
    │
    ├── Base Image
    ├── Filesystem
    ├── Libraries
    ├── Environment
    └── Application
```

## 27.4 ¿Un contenedor es idéntico al Host?

No.

Los contenedores comparten mecanismos del Kernel del Host, pero pueden tener entornos de usuario, sistemas de archivos y configuraciones diferentes.

## 27.5 ¿Qué debemos comprobar?

- Imagen base.
- Arquitectura.
- Usuario.
- Dependencias.
- Variables.
- Puertos.
- Montajes.

### Idea clave

**El entorno del contenedor debe diagnosticarse como un contexto de ejecución propio.**

---

# 28. Issue: Different Behavior in WSL

WSL permite trabajar con entornos Linux dentro de Windows.

## 28.1 Síntoma

Una herramienta funciona en Windows, pero no en WSL.

O funciona en WSL, pero no en PowerShell.

## 28.2 ¿Por qué?

Porque Windows y la distribución Linux de WSL tienen entornos diferentes.

## 28.3 Modelo

```text
Windows
│
├── PowerShell
│   └── Windows Tools
│
└── WSL
    └── Linux Distribution
        └── Linux Tools
```

## 28.4 ¿Qué puede variar?

- PATH.
- Sistema de archivos.
- Instalaciones.
- Arquitectura de herramientas.
- Variables.
- Gestores de paquetes.
- Permisos.

## 28.5 Recomendación

Identificar dónde está instalado cada Runtime y desde qué entorno se ejecuta.

### Principio

**Una herramienta instalada en Windows no equivale automáticamente a una instalación nativa dentro de Linux.**

---

# 29. Issue: Time or Certificate Validation Problems

## 29.1 Síntoma

Una conexión segura o validación falla inesperadamente.

## 29.2 Posibles causas

- Fecha incorrecta.
- Hora incorrecta.
- Certificado expirado.
- Cadena de confianza incompleta.
- Configuración TLS.
- Proxy corporativo.

## 29.3 Consultar fecha y hora

```bash
date
```

## 29.4 En sistemas con systemd

```bash
timedatectl status
```

## 29.5 ¿Por qué importa?

Los certificados tienen periodos de validez.

Una configuración incorrecta del reloj puede afectar determinadas verificaciones.

## 29.6 Advertencia

No debemos desactivar verificaciones de certificados para compensar problemas de hora o confianza.

---

# 30. Issue: Environment Variable Missing

## 30.1 Síntoma

Una aplicación necesita una variable de entorno, pero no la encuentra.

Ejemplo conceptual:

```text
DATABASE_URL is not defined
```

## 30.2 Posibles causas

- Variable no definida.
- Variable no exportada.
- Archivo de configuración no cargado.
- Proceso iniciado desde otro contexto.
- CI no configurado.
- Nombre incorrecto.

## 30.3 Consultar presencia sin mostrar el valor

En Bash:

```bash
if [ -n "${DATABASE_URL+x}" ]; then
  echo "DATABASE_URL is defined"
else
  echo "DATABASE_URL is not defined"
fi
```

Este ejemplo comprueba si la variable está definida en el Shell actual.

No demuestra por sí solo que esté exportada hacia procesos hijos.

## 30.4 ¿Qué debemos evitar?

No imprimir credenciales ni Tokens en logs.

## 30.5 Recomendación

Documentar nombres y responsabilidades de las variables sin publicar sus valores sensibles.

### Principio

**Las variables de entorno son parte del contrato de ejecución de una aplicación.**

---

# 31. Herramientas fundamentales de diagnóstico

Estas herramientas son habituales en Linux, aunque su disponibilidad puede variar según la distribución.

| Herramienta | Responsabilidad |
|---|---|
| `uname` | Información del Kernel y arquitectura |
| `whoami` | Usuario efectivo actual |
| `pwd` | Directorio de trabajo |
| `ls` | Listar archivos |
| `stat` | Información de archivos |
| `file` | Identificar tipo de archivo |
| `command -v` | Consultar resolución de comandos |
| `type` | Inspeccionar comandos en Shells compatibles |
| `ps` | Consultar procesos |
| `top` | Observar procesos y recursos |
| `ss` | Inspeccionar sockets |
| `lsof` | Consultar archivos abiertos y recursos asociados |
| `ip` | Información de red |
| `getent` | Consultar bases de datos del sistema |
| `curl` | Realizar solicitudes de red |
| `df` | Consultar sistemas de archivos |
| `du` | Consultar uso de almacenamiento |
| `free` | Consultar memoria |
| `systemctl` | Administrar o consultar unidades systemd |
| `journalctl` | Consultar Journal de systemd |

### Importante

No debemos instalar todas estas herramientas automáticamente.

Primero debemos comprobar cuáles existen y cuáles necesitamos realmente.

---

# 32. Cómo interpretar mensajes de error

Un mensaje de error suele contener información útil.

## 32.1 Identificar la operación

¿Qué intentábamos hacer?

```text
Start Node.js Server
```

## 32.2 Identificar el recurso

¿Qué recurso estaba involucrado?

```text
Port 3000
```

## 32.3 Identificar el tipo de fallo

Ejemplo:

```text
EADDRINUSE
```

## 32.4 Formular hipótesis

```text
Another process is listening on the requested address/port.
```

## 32.5 Verificar

Consultar los sockets en escucha.

## 32.6 Validar

Después de una solución autorizada, comprobar que la aplicación inicia correctamente.

### Modelo

```text
Error Message
     │
     ├── Operation
     ├── Resource
     ├── Error Type
     └── Context
             │
             ▼
        Hypothesis
             │
             ▼
         Evidence
```

### Idea clave

**Los errores deben leerse como información diagnóstica, no como obstáculos que debemos ocultar.**

---

# 33. Práctica: Linux Environment Audit

Realizaremos una auditoría de solo lectura.

No instalaremos, eliminaremos ni modificaremos herramientas.

## Step 1 — Distribution

```bash
cat /etc/os-release
```

## Step 2 — Kernel

```bash
uname -r
```

## Step 3 — Architecture

```bash
uname -m
```

## Step 4 — User

```bash
whoami
```

## Step 5 — Working Directory

```bash
pwd
```

## Step 6 — Shell

```bash
echo "$SHELL"
```

## Step 7 — PATH

```bash
echo "$PATH"
```

## Step 8 — Git

```bash
command -v git
```

Si existe:

```bash
git --version
```

## Step 9 — Node.js

```bash
command -v node
```

Si existe:

```bash
node --version
```

## Step 10 — Storage

```bash
df -h
```

## Step 11 — Memory

```bash
free -h
```

Si la herramienta está disponible.

## Step 12 — Network Interfaces

```bash
ip addr
```

Si `ip` está disponible.

## Step 13 — Listening Ports

```bash
ss -ltn
```

Si `ss` está disponible.

## Step 14 — Processes

```bash
ps aux
```

## Step 15 — Documentar

| Componente | Resultado |
|---|---|
| Distribución | |
| Versión | |
| Kernel | |
| Arquitectura | |
| Usuario | |
| Shell | |
| Directorio actual | |
| Git | |
| Node.js | |
| Estado de almacenamiento | |
| Estado de memoria | |
| Herramientas de red disponibles | |

**Antes de compartir el resultado, revisa nombres de usuario, rutas internas, direcciones de red y otros datos que puedan ser sensibles.**

---

# 34. Práctica: diagnosticar un comando inexistente

Vamos a simular un problema sin modificar el sistema.

## Step 1 — Ejecutar un nombre inexistente

```bash
tooling-mastery-command-that-does-not-exist
```

Resultado esperado:

```text
command not found
```

El texto exacto depende del Shell.

## Step 2 — Consultar resolución

```bash
command -v tooling-mastery-command-that-does-not-exist
```

Normalmente no devolverá una ruta.

## Step 3 — Consultar PATH

```bash
echo "$PATH"
```

## Step 4 — Interpretar

Preguntas:

1. ¿El Shell conoce el comando?
2. ¿Existe un ejecutable accesible?
3. ¿Qué directorios busca?
4. ¿Sería correcto instalar algo?
5. ¿Qué evidencia necesitaríamos antes de hacerlo?

## Aprendizaje

**No todo error `command not found` requiere instalar software.**

---

# 35. Práctica: investigar un puerto

Supongamos que una aplicación necesita el puerto 3000.

No iniciaremos ni detendremos ningún proceso.

## Step 1 — Consultar sockets

```bash
ss -ltnp
```

## Step 2 — Filtrar el puerto

```bash
ss -ltnp '( sport = :3000 )'
```

## Step 3 — Interpretar

Preguntas:

- ¿Existe algún proceso escuchando?
- ¿En qué dirección?
- ¿En qué puerto?
- ¿Podemos identificar el proceso?
- ¿Tenemos permisos para consultar su información?

## Step 4 — Decidir

Si el puerto está ocupado, debemos determinar si corresponde:

- Utilizar otro puerto.
- Revisar la configuración.
- Detener un proceso propio de forma controlada.

No realizaremos ninguna de estas operaciones durante esta práctica.

---

# 36. Práctica: construir un diagnóstico profesional

Imagina el siguiente escenario:

> Un proyecto Node.js funciona en una computadora Linux, pero falla en otra. El equipo asegura que ambas tienen Node.js instalado.

## 36.1 Hipótesis iniciales

```text
Different Node.js Versions
Different PATH
Different Package Installation
Different Shell
Missing Environment Variables
Different Architecture
```

## 36.2 Evidencia necesaria

En ambas máquinas:

```bash
node --version
```

```bash
command -v node
```

```bash
echo "$PATH"
```

```bash
uname -m
```

```bash
pwd
```

También sería necesario revisar los requisitos del proyecto.

## 36.3 Comparación

| Elemento | Machine A | Machine B |
|---|---|---|
| Distribución | | |
| Arquitectura | | |
| Shell | | |
| Node.js | | |
| Ruta de Node.js | | |
| Package Manager | | |
| Directorio de trabajo | | |
| Variables necesarias | | |

## 36.4 Conclusión

No debemos decidir una solución hasta encontrar una diferencia relevante y comprobar que explica el fallo.

### Aprendizaje

**Comparar entornos es una de las técnicas más útiles para diagnosticar problemas de desarrollo.**

---

# 37. Incident Report Template

Cuando resolvamos un problema importante, podemos documentarlo.

```markdown
# Incident Report

## Summary

Describe the observed problem.

## Environment

- Operating System:
- Distribution:
- Architecture:
- Shell:
- Runtime:
- Tool Version:

## Symptoms

Describe the error and observed behavior.

## Reproduction Steps

1.
2.
3.

## Evidence

List relevant commands and sanitized outputs.

## Root Cause

Explain the verified underlying cause.

## Resolution

Describe the applied change.

## Validation

Explain how the fix was confirmed.

## Prevention

Describe actions to avoid recurrence.

## References

Link to relevant documentation.
```

## 37.1 ¿Por qué documentar?

Porque un problema resuelto puede reaparecer en:

- Otra computadora.
- Otro desarrollador.
- CI.
- Un servidor.
- Un contenedor.

## 37.2 Beneficio profesional

La documentación convierte una solución individual en conocimiento reutilizable.

---

# 38. Buenas prácticas profesionales

## 38.1 Investigar antes de modificar

No ejecutar comandos destructivos como primera reacción.

## 38.2 Identificar el entorno

Conocer distribución, arquitectura, Shell y versiones.

## 38.3 Leer el error completo

No diagnosticar únicamente por la última línea.

## 38.4 Formular hipótesis

Evitar soluciones basadas en suposiciones.

## 38.5 Utilizar comandos de inspección

Priorizar operaciones no destructivas.

## 38.6 Cambiar una cosa a la vez

Permite identificar qué modificación resolvió el problema.

## 38.7 Evitar permisos excesivos

No utilizar `chmod 777` como solución genérica.

## 38.8 Evitar privilegios innecesarios

No utilizar `sudo` sin comprender la operación.

## 38.9 No desactivar mecanismos de seguridad

Los errores de certificados y firmas requieren investigación.

## 38.10 No eliminar procesos indiscriminadamente

Primero identificar su responsabilidad.

## 38.11 Comparar entornos

Especialmente cuando algo funciona en una máquina y falla en otra.

## 38.12 Documentar soluciones

Registrar causas y validaciones.

## 38.13 Proteger información sensible

No compartir Tokens, credenciales o configuraciones privadas en logs.

## 38.14 Validar después de corregir

Comprobar que la solución funciona y no genera efectos secundarios.

## 38.15 Convertir problemas repetidos en estándares

Si un error ocurre frecuentemente, evaluar mejoras en documentación, configuración o automatización.

---

# 39. Errores comunes al diagnosticar Linux

### Error 1 — Reinstalar inmediatamente

Puede ocultar el problema real.

### Error 2 — Utilizar sudo para todo

Introduce riesgos y puede crear archivos con propietarios inesperados.

### Error 3 — Cambiar permisos masivamente

Puede comprometer la seguridad del sistema.

### Error 4 — Ignorar PATH

Muchas herramientas instaladas no se encuentran por problemas de resolución.

### Error 5 — Confundir versiones instaladas y activas

Podemos ejecutar una versión distinta a la esperada.

### Error 6 — Copiar comandos de otra distribución

Las herramientas y políticas pueden ser diferentes.

### Error 7 — Forzar dependencias

Puede deteriorar el estado del sistema.

### Error 8 — Desactivar verificaciones TLS

Oculta problemas de confianza y seguridad.

### Error 9 — Finalizar procesos sin identificarlos

Puede interrumpir servicios legítimos.

### Error 10 — Borrar archivos para liberar espacio sin analizarlos

Puede eliminar datos importantes.

### Error 11 — Confundir DNS con conectividad

Son etapas diferentes.

### Error 12 — Confundir un puerto ocupado con una aplicación defectuosa

El problema puede estar en otro proceso.

### Error 13 — Ignorar arquitectura

Puede provocar errores con binarios y dependencias nativas.

### Error 14 — Ignorar finales de línea

Puede afectar Scripts entre Windows y Linux.

### Error 15 — Depender de configuraciones personales en CI

Dificulta la reproducibilidad.

### Error 16 — No documentar la solución

Obliga a resolver el mismo problema repetidamente.

---

# 40. Comprueba tu modelo mental

1. ¿Qué es Troubleshooting?
2. ¿Qué diferencia existe entre síntoma y causa raíz?
3. ¿Cuáles son las etapas de un diagnóstico profesional?
4. ¿Por qué debemos identificar la distribución?
5. ¿Qué información proporciona `uname -m`?
6. ¿Qué significa `command not found`?
7. ¿Por qué no siempre debemos reinstalar una herramienta?
8. ¿Qué papel cumple PATH?
9. ¿Cómo identificarías una versión incorrecta de Node.js?
10. ¿Qué significa `Permission denied`?
11. ¿Por qué `chmod 777` no es una solución profesional?
12. ¿Qué es un Shebang?
13. ¿Qué diferencia existe entre `bash script.sh` y `./script.sh`?
14. ¿Por qué un archivo puede producir `No such file or directory` aunque exista?
15. ¿Qué es Case Sensitivity?
16. ¿Qué es un Symbolic Link?
17. ¿Qué sucede si su destino desaparece?
18. ¿Por qué puede fallar la instalación de un paquete?
19. ¿Qué es un conflicto de dependencias?
20. ¿Por qué no debemos desactivar las verificaciones de certificados?
21. ¿Qué diferencia existe entre DNS y conectividad IP?
22. ¿Qué hace `getent hosts`?
23. ¿Qué hace `curl -I`?
24. ¿Qué significa `EADDRINUSE`?
25. ¿Cómo investigarías un puerto ocupado?
26. ¿Qué hace `ps`?
27. ¿Qué es un Service?
28. ¿Qué es systemd?
29. ¿Qué hace `systemctl status`?
30. ¿Qué hace `journalctl`?
31. ¿Qué significa `No space left on device`?
32. ¿Qué diferencia existe entre `df` y `du`?
33. ¿Qué son los inodos?
34. ¿Por qué poca memoria libre no implica necesariamente un problema?
35. ¿Qué es un Architecture Mismatch?
36. ¿Qué es una Shared Library?
37. ¿Qué diferencia existe entre LF y CRLF?
38. ¿Por qué un Script puede fallar solamente en CI?
39. ¿Por qué un contenedor puede comportarse diferente del Host?
40. ¿Por qué WSL y PowerShell pueden resolver herramientas diferentes?
41. ¿Qué relación puede existir entre hora del sistema y certificados?
42. ¿Por qué no debemos imprimir variables sensibles?
43. ¿Qué información debería contener un Incident Report?
44. ¿Por qué conviene modificar una sola cosa a la vez?
45. ¿Cómo convertirías un problema recurrente en una mejora del equipo?

---

# 41. Checklist de aprendizaje

- [ ] Comprendo qué es Troubleshooting.
- [ ] Diferencio síntomas y causas raíz.
- [ ] Puedo identificar mi distribución Linux.
- [ ] Puedo identificar arquitectura y Kernel.
- [ ] Puedo consultar el Shell y PATH.
- [ ] Sé investigar un comando inexistente.
- [ ] Sé identificar conflictos de versiones.
- [ ] Comprendo los errores de permisos.
- [ ] Comprendo el papel del Shebang.
- [ ] Reconozco problemas de rutas.
- [ ] Comprendo Case Sensitivity.
- [ ] Reconozco enlaces simbólicos rotos.
- [ ] Sé investigar problemas de paquetes.
- [ ] Comprendo los conflictos de dependencias.
- [ ] Diferencio DNS, conectividad y HTTP.
- [ ] Sé consultar puertos en escucha.
- [ ] Sé inspeccionar procesos.
- [ ] Comprendo los conceptos básicos de servicios.
- [ ] Sé consultar espacio y memoria.
- [ ] Reconozco incompatibilidades de arquitectura.
- [ ] Comprendo problemas de finales de línea.
- [ ] Sé comparar entornos locales y CI.
- [ ] Evito comandos destructivos como primera solución.
- [ ] Puedo documentar un incidente profesionalmente.

---

# 💡 Idea clave

Linux es un sistema compuesto por diferentes capas.

Un error puede originarse en cualquiera de ellas.

```text
Application
    │
    ▼
Runtime
    │
    ▼
Shell / Environment
    │
    ▼
Filesystem / Permissions
    │
    ▼
Processes / Networking
    │
    ▼
Operating System
    │
    ▼
Hardware
```

La capacidad profesional consiste en identificar qué capa está involucrada y reunir evidencia antes de modificarla.

**No necesitamos memorizar todas las soluciones posibles. Necesitamos comprender el sistema lo suficiente para investigar correctamente.**

---

# 🚀 Siguiente paso

Hemos completado la sección dedicada a Linux.

Ya estudiamos:

1. Linux Development Setup.
2. Linux Package Managers.
3. Linux Shell Configuration.
4. Common Linux Issues.

Ahora continuaremos con las **Best Practices** aplicables a cualquier entorno de desarrollo.

Aprenderemos cómo mantener una máquina organizada, evitar instalaciones innecesarias y construir configuraciones fáciles de mantener.

El siguiente documento será:

👉 [Clean Development Machine](../05-best-practices/01-clean-development-machine.md)

Este tema nos ayudará a comprender qué significa realmente tener una computadora preparada para trabajar profesionalmente, sin convertirla en una colección desordenada de herramientas y configuraciones.