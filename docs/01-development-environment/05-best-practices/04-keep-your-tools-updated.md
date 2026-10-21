# Keep Your Tools Updated

## Introducción

Imagina que llevas varios meses trabajando en una aplicación React con Node.js.

Todo funciona correctamente.

Un día descubres que existen nuevas versiones de:

- Node.js.
- npm.
- pnpm.
- Git.
- TypeScript.
- ESLint.
- Vite.
- Docker.
- Tu sistema operativo.

Decides actualizar absolutamente todo.

Después de hacerlo, el proyecto deja de compilar.

Aparecen errores que nunca habías visto.

¿Qué ocurrió?

Posiblemente introdujiste cambios incompatibles en varias capas del entorno al mismo tiempo.

Ahora imagina el escenario contrario.

Nunca actualizas ninguna herramienta porque tienes miedo de romper algo.

Con el tiempo aparecen:

- Vulnerabilidades de seguridad.
- Versiones sin soporte.
- Incompatibilidades con herramientas modernas.
- Dependencias obsoletas.
- Problemas de mantenimiento.

Ambos extremos son problemáticos.

La solución profesional no consiste en actualizar siempre ni en evitar todas las actualizaciones.

Consiste en aplicar una estrategia de **Controlled Updates**.

En este documento aprenderemos a mantener nuestras herramientas actualizadas de forma segura, planificada y verificable.

Nuestra metodología será:

**Problema → Versiones → Compatibilidad → Riesgos → Estrategia → Validación → Mantenimiento.**

---

## 🎯 Objetivos de aprendizaje

Al finalizar este documento deberías poder:

1. Explicar por qué debemos mantener actualizadas las herramientas.
2. Diferenciar Update, Upgrade y Migration.
3. Comprender el concepto de Software Lifecycle.
4. Identificar versiones soportadas y obsoletas.
5. Comprender Semantic Versioning.
6. Diferenciar Major, Minor y Patch.
7. Reconocer cambios incompatibles.
8. Comprender las políticas LTS.
9. Identificar los diferentes niveles de actualización.
10. Distinguir herramientas globales y dependencias del proyecto.
11. Comprender el papel de los Lockfiles.
12. Planificar actualizaciones controladas.
13. Aplicar estrategias de validación.
14. Comprender Rollback y Recovery.
15. Reconocer riesgos de seguridad.
16. Diseñar una rutina de mantenimiento profesional.
17. Preparar una política de actualizaciones para un equipo.

---

# 1. ¿Por qué debemos actualizar nuestras herramientas?

El software evoluciona constantemente.

Sus desarrolladores publican nuevas versiones para introducir:

- Correcciones de errores.
- Mejoras de rendimiento.
- Actualizaciones de seguridad.
- Nuevas funcionalidades.
- Compatibilidad con otros sistemas.
- Mejoras de mantenimiento.

## 1.1 Ejemplo

Supongamos que utilizamos una herramienta:

```text
Tool Version 1
      │
      ▼
Tool Version 2
      │
      ▼
Tool Version 3
```

Cada versión puede introducir cambios.

Algunos serán compatibles.

Otros podrían requerir modificaciones.

## 1.2 ¿Qué sucede si nunca actualizamos?

Podemos acumular **Technical Debt**.

La deuda técnica representa el coste futuro asociado a determinadas decisiones técnicas.

Utilizar versiones antiguas no siempre constituye deuda técnica por sí mismo.

Pero puede convertirse en un problema cuando esas versiones dejan de recibir soporte o dificultan la evolución del proyecto.

## 1.3 ¿Qué sucede si actualizamos sin control?

Podemos introducir:

- Breaking Changes.
- Incompatibilidades.
- Fallos de compilación.
- Errores en pruebas.
- Cambios de configuración.
- Problemas de infraestructura.

### Idea clave

**Actualizar herramientas es una actividad de mantenimiento que debe equilibrar seguridad, compatibilidad y estabilidad.**

---

# 2. Update vs Upgrade vs Migration

Estos términos suelen utilizarse de manera similar, pero conviene distinguirlos conceptualmente.

Sus significados exactos pueden variar entre herramientas.

## 2.1 Update

Generalmente se refiere a actualizar información, componentes o versiones.

En algunos gestores, `update` solamente actualiza los índices de paquetes.

En otros, actualiza paquetes instalados.

## 2.2 Upgrade

Suele referirse a pasar a una versión más reciente de software.

Puede incluir cambios importantes.

## 2.3 Migration

Implica adaptar una aplicación, configuración o infraestructura a un nuevo sistema, versión o arquitectura.

## 2.4 Ejemplo

```text
Current Tool
     │
     ▼
New Version Available
     │
     ├── Compatible Update
     │
     └── Breaking Change
              │
              ▼
          Migration
```

## 2.5 Comparación

| Concepto | Enfoque |
|---|---|
| Update | Actualización de información o software |
| Upgrade | Paso a una versión más reciente |
| Migration | Adaptación a nuevos requisitos |
| Rollback | Regreso a un estado anterior |
| Patch | Corrección o cambio de alcance limitado |

## 2.6 Ejemplo con APT

En distribuciones Debian y derivadas:

```bash
sudo apt update
```

Actualiza la información local sobre los paquetes disponibles.

Mientras que:

```bash
sudo apt upgrade
```

Intenta actualizar paquetes instalados según las reglas de APT.

Ambos comandos modifican el entorno o sus metadatos y no deben ejecutarse automáticamente durante una auditoría de solo lectura.

### Principio

**Nunca debemos asumir que un comando llamado `update` realiza exactamente la misma operación en todas las herramientas.**

---

# 3. Software Lifecycle

Todo software atraviesa un ciclo de vida.

Podemos representarlo conceptualmente así:

```text
Development
     │
     ▼
Release
     │
     ▼
Active Maintenance
     │
     ▼
Limited Maintenance
     │
     ▼
End of Support
```

No todos los proyectos utilizan estas etapas ni los mismos nombres.

## 3.1 Active Maintenance

El software recibe mantenimiento activo.

Puede incluir:

- Correcciones.
- Nuevas funcionalidades.
- Actualizaciones de seguridad.

## 3.2 Maintenance Mode

Algunos proyectos limitan los cambios a correcciones importantes.

## 3.3 End of Support

Una versión deja de recibir soporte oficial.

También podemos encontrar el término:

**End of Life (EOL).**

## 3.4 ¿Por qué importa?

Porque utilizar una versión sin soporte puede aumentar los riesgos de seguridad y mantenimiento.

## 3.5 ¿Debemos abandonar inmediatamente toda versión antigua?

Debemos evaluar:

- Estado de soporte.
- Riesgos conocidos.
- Requisitos empresariales.
- Compatibilidad.
- Posibilidades de migración.

### Idea clave

**La edad de una versión importa menos que su estado de soporte, compatibilidad y seguridad.**

---

# 4. Semantic Versioning

**Semantic Versioning**, conocido como **SemVer**, es una convención para representar versiones de software.

Utiliza normalmente tres componentes:

```text
MAJOR.MINOR.PATCH
```

Ejemplo:

```text
2.5.3
```

Donde:

```text
2 → MAJOR
5 → MINOR
3 → PATCH
```

## 4.1 MAJOR

Se incrementa cuando se introducen cambios incompatibles con la API pública bajo las reglas de SemVer.

Ejemplo:

```text
2.5.3 → 3.0.0
```

## 4.2 MINOR

Se incrementa cuando se añaden funcionalidades compatibles hacia atrás.

Ejemplo:

```text
2.5.3 → 2.6.0
```

## 4.3 PATCH

Se incrementa cuando se introducen correcciones compatibles hacia atrás.

Ejemplo:

```text
2.5.3 → 2.5.4
```

## 4.4 Modelo

```text
MAJOR.MINOR.PATCH
  │     │     │
  │     │     └── Compatible Fix
  │     │
  │     └──────── Compatible Feature
  │
  └────────────── Breaking Change
```

## 4.5 ¿Todas las herramientas siguen SemVer?

No.

Algunas utilizan:

- Versionado por fecha.
- Versionado específico del proveedor.
- Esquemas personalizados.

Además, que un proyecto declare utilizar SemVer no garantiza que nunca publique cambios inesperados.

## 4.6 Versiones 0.x

En SemVer, las versiones anteriores a `1.0.0` representan desarrollo inicial y la API pública puede cambiar con mayor libertad.

### Idea clave

**SemVer ayuda a interpretar la intención de los cambios, pero no sustituye la lectura de Release Notes ni las pruebas de compatibilidad.**

---

# 5. Breaking Changes

Un **Breaking Change** es un cambio que puede hacer que una integración, configuración o uso previamente válido deje de funcionar.

## 5.1 Ejemplo conceptual

Versión anterior:

```javascript
createApplication({
  mode: "development"
});
```

Versión nueva:

```javascript
createApplication({
  environment: "development"
});
```

Si una herramienta elimina o modifica una opción utilizada por nuestro proyecto, podríamos necesitar adaptar el código.

Este ejemplo es hipotético.

## 5.2 ¿Dónde aparecen Breaking Changes?

- APIs.
- Configuraciones.
- Opciones CLI.
- Formatos de archivos.
- Comportamiento del Runtime.
- Plugins.
- Dependencias.

## 5.3 ¿Cómo identificarlos?

Consultar:

- Release Notes.
- Changelog.
- Migration Guides.
- Deprecation Notices.
- Documentación oficial.

## 5.4 ¿Qué es Deprecation?

Es el proceso por el cual una funcionalidad se marca como desaconsejada o destinada a desaparecer.

No significa necesariamente que haya dejado de funcionar inmediatamente.

### Principio

**Antes de actualizar una versión importante debemos comprender qué comportamientos podrían cambiar.**

---

# 6. Long-Term Support (LTS)

Algunos proyectos ofrecen versiones **Long-Term Support**.

LTS significa soporte a largo plazo.

## 6.1 ¿Para qué sirve?

Permite disponer de versiones mantenidas durante períodos definidos por el proyecto.

## 6.2 Ejemplo conceptual

```text
Version A
├── Active Support
└── Maintenance Support

Version B
├── Active Support
└── Maintenance Support
```

## 6.3 ¿Por qué es importante en Node.js?

Porque Node.js publica versiones con ciclos de soporte definidos.

Los equipos suelen preferir versiones soportadas y apropiadas para producción.

## 6.4 ¿Debemos utilizar siempre la última versión disponible?

No necesariamente.

Una versión reciente puede tener un estado de soporte diferente al de una versión LTS.

## 6.5 ¿Qué debemos verificar?

- Estado actual de soporte.
- Fecha de EOL.
- Compatibilidad con dependencias.
- Requisitos del proyecto.
- Políticas de la organización.

Las fechas concretas deben consultarse en la documentación oficial, porque cambian con el tiempo.

### Idea clave

**Elegir un Runtime profesionalmente implica considerar su ciclo de soporte, no solamente su número de versión.**

---

# 7. Capas de actualización

No todas las actualizaciones afectan al mismo nivel.

## 7.1 Operating System

Ejemplos:

- macOS.
- Windows.
- Linux.

## 7.2 System Tools

Ejemplos:

- Git.
- Compiladores.
- Utilidades del sistema.

## 7.3 Runtime

Ejemplo:

- Node.js.

## 7.4 Package Manager

Ejemplos:

- npm.
- pnpm.
- Yarn.

## 7.5 Project Dependencies

Ejemplos:

- React.
- TypeScript.
- ESLint.
- Vite.
- Vitest.

## 7.6 Infrastructure

Ejemplos:

- PostgreSQL.
- Redis.
- Docker.
- Herramientas Cloud.

## 7.7 Modelo

```text
Development Environment
│
├── Operating System
│
├── System Tools
│
├── Runtime
│
├── Package Manager
│
├── Project Dependencies
│
└── Infrastructure
```

## 7.8 ¿Por qué separar?

Porque cada capa tiene riesgos y procedimientos de actualización distintos.

### Principio

**Las actualizaciones deben planificarse según la responsabilidad y el impacto de cada capa.**

---

# 8. Actualizaciones del sistema operativo

Actualizar el sistema operativo puede introducir:

- Correcciones de seguridad.
- Cambios de compatibilidad.
- Nuevas APIs.
- Modificaciones en herramientas del sistema.
- Cambios en permisos.

## 8.1 ¿Qué debemos evaluar?

- Compatibilidad del hardware.
- Requisitos corporativos.
- Compatibilidad de herramientas.
- Disponibilidad de Backups.
- Impacto en proyectos activos.

## 8.2 ¿Debemos evitar las actualizaciones?

No.

Especialmente las actualizaciones de seguridad requieren una evaluación oportuna.

## 8.3 Entornos corporativos

Algunas actualizaciones pueden estar administradas por el departamento de IT.

Debemos respetar esas políticas.

### Idea clave

**El sistema operativo es la base del entorno; sus actualizaciones pueden afectar a todas las capas superiores.**

---

# 9. Actualizaciones de herramientas del sistema

Consideremos Git.

Una actualización puede introducir:

- Correcciones.
- Mejoras.
- Nuevas opciones.
- Cambios de comportamiento.

## 9.1 ¿Cómo identificamos la versión?

```bash
git --version
```

## 9.2 ¿Cómo sabemos quién administra Git?

Depende del sistema operativo.

Podría ser:

- Homebrew.
- winget.
- apt.
- dnf.
- Instalador oficial.
- Herramientas del sistema.

## 9.3 ¿Por qué importa?

Porque el procedimiento correcto de actualización depende del mecanismo de instalación.

## 9.4 Error frecuente

Intentar actualizar una herramienta mediante un gestor distinto del que administra su instalación.

### Principio

**Antes de actualizar una herramienta debemos identificar quién administra su instalación.**

---

# 10. Actualizaciones de Node.js

Node.js es especialmente importante en nuestro Mastery.

## 10.1 Escenario

Tenemos:

```text
Project A
└── Node.js Version A
```

```text
Project B
└── Node.js Version B
```

## 10.2 ¿Qué sucede si cambiamos la versión global?

Podríamos afectar a proyectos que requieren versiones diferentes.

## 10.3 Mejor estrategia

Utilizar un mecanismo de gestión de versiones cuando corresponda.

Ejemplos:

- nvm.
- mise.

## 10.4 Modelo

```text
Runtime Version Manager
│
├── Node.js Version A
│   └── Project A
│
└── Node.js Version B
    └── Project B
```

## 10.5 ¿Actualizar Node.js significa actualizar las dependencias?

No.

Son responsabilidades distintas.

## 10.6 ¿Qué debemos validar?

- Versión activa.
- Compatibilidad con el proyecto.
- Instalación de dependencias.
- Build.
- Testing.
- Ejecución.

### Idea clave

**Actualizar el Runtime no debe implicar modificar indiscriminadamente las versiones de todos nuestros proyectos.**

---

# 11. Actualizaciones del Package Manager

Los gestores JavaScript también evolucionan.

Ejemplos:

- npm.
- pnpm.
- Yarn.

## 11.1 ¿Qué puede cambiar?

- Resolución de dependencias.
- Formato del Lockfile.
- Comportamiento de Workspaces.
- Opciones CLI.
- Compatibilidad con Node.js.
- Políticas de seguridad.

## 11.2 Ejemplo

```text
Project
│
├── Node.js Requirement
├── Package Manager Requirement
└── Lockfile
```

## 11.3 ¿Por qué no debemos actualizar pnpm sin evaluar?

Porque una versión diferente podría introducir cambios relevantes en el comportamiento del proyecto.

## 11.4 Estrategia

1. Consultar la versión requerida.
2. Revisar compatibilidad.
3. Leer cambios relevantes.
4. Probar la nueva versión.
5. Validar Lockfile y Scripts.
6. Documentar la decisión.

### Idea clave

**El gestor de paquetes es parte del entorno de ejecución de las operaciones del proyecto.**

---

# 12. Actualizaciones de dependencias

Un proyecto puede utilizar decenas o cientos de dependencias directas y transitivas.

## 12.1 Direct Dependencies

Son dependencias declaradas directamente por el proyecto.

## 12.2 Transitive Dependencies

Son dependencias utilizadas por otras dependencias.

## 12.3 Modelo

```text
Application
│
├── Dependency A
│   ├── Dependency C
│   └── Dependency D
│
└── Dependency B
    └── Dependency E
```

## 12.4 ¿Qué significa actualizar una dependencia?

Modificar la versión utilizada o resuelta, según el gestor y la operación.

## 12.5 Riesgos

- Cambios incompatibles.
- Problemas de tipos.
- Plugins incompatibles.
- Modificaciones de configuración.
- Cambios en el árbol de dependencias.

## 12.6 ¿Debemos actualizar todas las dependencias juntas?

No necesariamente.

Agrupar actualizaciones relacionadas puede ser útil, pero actualizar demasiadas herramientas simultáneamente dificulta identificar qué cambio produjo un problema.

### Principio

**Las dependencias deben actualizarse mediante cambios comprensibles y verificables.**

---

# 13. El papel de los Lockfiles

Un Lockfile registra información sobre la resolución de dependencias.

Ejemplos:

```text
package-lock.json
pnpm-lock.yaml
yarn.lock
```

## 13.1 ¿Por qué es importante durante una actualización?

Porque permite revisar cómo cambió el árbol de dependencias.

## 13.2 Ejemplo

```text
Before Update
│
└── Dependency Graph A
```

```text
After Update
│
└── Dependency Graph B
```

## 13.3 ¿Qué debemos revisar?

- Cambios esperados.
- Nuevas dependencias.
- Dependencias eliminadas.
- Actualizaciones transitivas.
- Modificaciones importantes.

## 13.4 ¿Debemos eliminar el Lockfile antes de actualizar?

No como práctica general.

Eliminarlo puede provocar una resolución distinta de múltiples dependencias.

## 13.5 Buena práctica

Actualizar el Lockfile mediante el gestor elegido y revisar los cambios en Git.

### Idea clave

**El Lockfile permite hacer visibles cambios de dependencias que no siempre aparecen directamente en `package.json`.**

---

# 14. Dependency Ranges

En JavaScript podemos encontrar declaraciones como:

```json
{
  "dependencies": {
    "example-package": "^2.3.0"
  }
}
```

El símbolo `^` representa una regla de compatibilidad utilizada por el ecosistema npm.

## 14.1 Caret (^)

Para versiones estables `1.0.0` o superiores, normalmente permite actualizaciones compatibles dentro del mismo Major.

Ejemplo conceptual:

```text
^2.3.0
```

Permite versiones:

```text
>=2.3.0 <3.0.0
```

## 14.2 Tilde (~)

Ejemplo:

```text
~2.3.0
```

Normalmente permite:

```text
>=2.3.0 <2.4.0
```

## 14.3 Exact Version

```text
2.3.0
```

Declara una versión exacta.

## 14.4 Precaución

Las reglas para versiones `0.x` tienen particularidades.

Además, los rangos no sustituyen el Lockfile.

## 14.5 ¿Qué estrategia elegir?

Depende de:

- Tipo de proyecto.
- Compatibilidad.
- Política del equipo.
- Necesidad de estabilidad.
- Frecuencia de actualizaciones.

### Idea clave

**Los rangos expresan versiones permitidas; el Lockfile registra la resolución utilizada.**

---

# 15. Security Updates

Las actualizaciones de seguridad merecen atención especial.

## 15.1 ¿Qué es una vulnerabilidad?

Es una debilidad que puede permitir comprometer propiedades de seguridad de un sistema.

## 15.2 ¿Qué puede verse afectado?

- Sistema operativo.
- Runtime.
- Dependencias.
- Servidores.
- Contenedores.
- Herramientas.
- Infraestructura.

## 15.3 ¿Todas las vulnerabilidades tienen el mismo riesgo?

No.

Debemos considerar:

- Severidad.
- Exposición.
- Posibilidad de explotación.
- Contexto de uso.
- Existencia de mitigaciones.
- Disponibilidad de correcciones.

## 15.4 Ejemplo

Una vulnerabilidad en una dependencia utilizada únicamente durante desarrollo puede tener un perfil de riesgo diferente al de una dependencia expuesta en producción.

Pero no debemos asumir que una dependencia de desarrollo es automáticamente segura.

## 15.5 Estrategia

```text
Security Advisory
        │
        ▼
Assess Exposure
        │
        ▼
Evaluate Severity
        │
        ▼
Identify Fix
        │
        ▼
Test Compatibility
        │
        ▼
Deploy or Apply Mitigation
        │
        ▼
Verify
```

### Idea clave

**Las actualizaciones de seguridad deben priorizarse según el riesgo real y la urgencia, no únicamente según el número de versión.**

---

# 16. Release Notes y Changelogs

Antes de actualizar una herramienta importante debemos revisar sus cambios.

## 16.1 Release Notes

Describen las novedades y modificaciones de una versión.

## 16.2 Changelog

Registra cambios a lo largo de diferentes versiones.

## 16.3 Migration Guide

Explica cómo adaptar un proyecto a nuevos requisitos.

## 16.4 ¿Qué debemos buscar?

- Breaking Changes.
- Deprecations.
- Cambios de configuración.
- Requisitos mínimos.
- Incompatibilidades conocidas.
- Correcciones de seguridad.

## 16.5 Ejemplo de análisis

```text
New Tool Version
       │
       ▼
Read Release Notes
       │
       ▼
Identify Relevant Changes
       │
       ▼
Check Compatibility
       │
       ▼
Plan Update
```

### Principio

**Actualizar profesionalmente implica comprender el cambio antes de aplicarlo.**

---

# 17. Controlled Updates

Una **Controlled Update** es una actualización realizada mediante un procedimiento planificado y verificable.

## 17.1 Proceso recomendado

```text
Identify Update
       │
       ▼
Assess Need
       │
       ▼
Review Compatibility
       │
       ▼
Prepare Recovery
       │
       ▼
Apply Change
       │
       ▼
Run Validation
       │
       ▼
Document Result
```

## 17.2 ¿Por qué preparar Recovery?

Porque una actualización puede fallar.

## 17.3 ¿Qué significa aplicar un cambio controlado?

- Conocer el estado inicial.
- Entender qué se modifica.
- Reducir cambios simultáneos.
- Validar resultados.
- Disponer de una estrategia de recuperación.

### Idea clave

**Una actualización profesional es un cambio gestionado, no una operación impulsiva.**

---

# 18. Update One Layer at a Time

Consideremos este escenario:

```text
Current Environment
│
├── Node.js A
├── pnpm A
├── TypeScript A
├── ESLint A
└── Vite A
```

Queremos actualizar todas las herramientas.

## 18.1 Estrategia de alto riesgo

Modificar todas las versiones simultáneamente sin pruebas intermedias.

## 18.2 Problema

Si aparece un error, será difícil identificar su origen.

## 18.3 Estrategia controlada

```text
Update Runtime
      │
      ▼
Validate
      │
      ▼
Update Package Manager
      │
      ▼
Validate
      │
      ▼
Update Build Tool
      │
      ▼
Validate
```

## 18.4 ¿Siempre debemos actualizar una herramienta por vez?

No.

Algunas actualizaciones relacionadas necesitan realizarse juntas.

Por ejemplo, una nueva versión de un Framework podría requerir actualizar varios paquetes compatibles.

### Principio

**Debemos agrupar los cambios según sus dependencias técnicas y mantenerlos lo suficientemente pequeños para comprenderlos.**

---

# 19. Testing Before and After Updates

Las pruebas son esenciales para detectar regresiones.

## 19.1 Before Update

Registrar el estado inicial.

Ejemplo:

```text
Current Version
Build Status
Test Status
Known Issues
```

## 19.2 Apply Update

Modificar la versión correspondiente.

## 19.3 After Update

Ejecutar las validaciones relevantes.

Ejemplos:

- Build.
- Type Checking.
- Linting.
- Unit Tests.
- Integration Tests.
- End-to-End Tests.
- Smoke Tests.

## 19.4 Modelo

```text
Baseline
   │
   ▼
Update
   │
   ▼
Validation
   │
   ├── Pass → Continue
   │
   └── Fail → Investigate
```

## 19.5 ¿Las pruebas garantizan ausencia de errores?

No.

Reducen el riesgo, pero su efectividad depende de su cobertura y calidad.

### Idea clave

**Sin una línea base y una validación posterior, es difícil saber qué efecto tuvo una actualización.**

---

# 20. Rollback y Recovery

Una actualización puede producir resultados inesperados.

Por eso necesitamos comprender dos conceptos.

## 20.1 Rollback

Consiste en regresar a una versión o estado anterior.

## 20.2 Recovery

Es el proceso de recuperar un estado operativo después de un fallo.

## 20.3 ¿Son equivalentes?

No siempre.

Un Rollback puede formar parte de una estrategia de Recovery.

## 20.4 Ejemplo conceptual

```text
Working State
      │
      ▼
Apply Update
      │
      ▼
Failure
      │
      ▼
Rollback / Recovery
      │
      ▼
Working State Restored
```

## 20.5 ¿Cómo ayuda Git?

Permite versionar y recuperar cambios del repositorio, como:

- `package.json`.
- Lockfiles.
- Configuraciones.
- Scripts.

## 20.6 ¿Git revierte automáticamente el sistema operativo?

No.

Tampoco revierte automáticamente:

- Bases de datos.
- Servicios externos.
- Paquetes del sistema.
- Configuraciones fuera del repositorio.

## 20.7 Precaución

Algunas migraciones de datos o infraestructura no pueden revertirse simplemente reinstalando una versión anterior.

### Principio

**Antes de actualizar debemos comprender qué partes del cambio pueden revertirse y cuáles requieren un plan de recuperación.**

---

# 21. Actualizaciones en entornos corporativos

Los proyectos empresariales suelen tener requisitos adicionales.

## 21.1 Ejemplos

- Versiones aprobadas.
- Restricciones de seguridad.
- Certificaciones.
- Dependencias privadas.
- Herramientas corporativas.
- Ventanas de mantenimiento.
- Procesos de Change Management.

## 21.2 ¿Podemos actualizar por nuestra cuenta?

Depende de las políticas y responsabilidades asignadas.

## 21.3 Riesgos

Una actualización local puede generar incompatibilidades con:

- CI.
- Entornos compartidos.
- APIs.
- Herramientas internas.
- Sistemas de despliegue.

## 21.4 Recomendación

Alinear los cambios importantes con el equipo responsable.

### Idea clave

**En un entorno empresarial, la versión correcta no siempre es la más reciente: es la versión aprobada, soportada y compatible con el proyecto.**

---

# 22. Update Policies

Una **Update Policy** establece criterios para mantener software actualizado.

## 22.1 ¿Qué puede definir?

- Frecuencia de revisión.
- Responsables.
- Criterios de seguridad.
- Procedimiento de pruebas.
- Aprobaciones.
- Estrategia de Rollback.
- Documentación.

## 22.2 Ejemplo conceptual

| Tipo de cambio | Tratamiento |
|---|---|
| Vulnerabilidad crítica explotable | Evaluación urgente |
| Patch compatible | Revisión periódica |
| Minor compatible | Validación planificada |
| Major con Breaking Changes | Migración controlada |
| Runtime EOL | Plan de sustitución |
| Sistema operativo | Según soporte y política IT |

Esta tabla es una guía conceptual, no una política universal.

## 22.3 ¿Por qué necesitamos una política?

Para evitar que las actualizaciones dependan exclusivamente de decisiones improvisadas.

### Idea clave

**Una política de mantenimiento convierte las actualizaciones en un proceso predecible.**

---

# 23. Automated Dependency Updates

Existen herramientas que ayudan a detectar nuevas versiones de dependencias.

Ejemplos conocidos:

- Dependabot.
- Renovate.

## 23.1 ¿Qué pueden hacer?

Según su configuración:

- Detectar actualizaciones.
- Proponer Pull Requests.
- Agrupar dependencias.
- Mostrar cambios.
- Integrarse con CI.

## 23.2 ¿Debemos aceptar todas las actualizaciones automáticamente?

No necesariamente.

## 23.3 Modelo

```text
Dependency Update Tool
          │
          ▼
Detect New Version
          │
          ▼
Create Pull Request
          │
          ▼
Run CI
          │
          ▼
Review Changes
          │
          ▼
Approve / Reject
```

## 23.4 ¿Qué beneficio ofrecen?

Reducen el esfuerzo de identificar actualizaciones y facilitan un flujo de revisión.

## 23.5 ¿Qué riesgos debemos considerar?

- Actualizaciones incompatibles.
- Cambios excesivos.
- Dependencias comprometidas.
- Pruebas insuficientes.
- Configuraciones incorrectas.

### Idea clave

**La automatización puede detectar y proponer actualizaciones; la estrategia del equipo determina cómo validarlas y aceptarlas.**

---

# 24. Version Pinning

**Version Pinning** consiste en fijar una versión concreta.

## 24.1 Ejemplo

```text
Node.js 22.16.0
```

En lugar de:

```text
Node.js 22.x
```

## 24.2 Ventajas

- Menos variaciones.
- Mayor control.
- Diagnóstico más sencillo.
- Reproducción más predecible.

## 24.3 Desventajas

- Requiere mantenimiento.
- Puede retrasar actualizaciones.
- Puede conservar versiones vulnerables si no existe una política de revisión.

## 24.4 ¿Cuándo utilizarlo?

Depende de:

- Compatibilidad.
- Requisitos empresariales.
- Entorno.
- Riesgos.
- Estrategia de pruebas.

## 24.5 Pinning vs Lockfile

No son lo mismo.

El Pinning fija una versión según la estrategia de configuración.

El Lockfile registra la resolución de dependencias del gestor.

### Principio

**Fijar versiones mejora el control, pero solamente es sostenible cuando existe una estrategia para revisarlas.**

---

# 25. Actualizar herramientas globales vs locales

Debemos diferenciar los dos ámbitos.

## 25.1 Global Tools

Ejemplos:

- Git.
- CLI de uso general.
- Algunas herramientas del sistema.

Su actualización puede afectar a múltiples proyectos.

## 25.2 Local Tools

Ejemplos:

- TypeScript.
- ESLint.
- Vite.
- Vitest.

Cuando están declaradas como dependencias del proyecto, pueden actualizarse de manera independiente entre repositorios.

## 25.3 Modelo

```text
Development Machine
│
├── Shared Tools
│   └── Multiple Projects
│
├── Project A
│   └── Local Dependencies A
│
└── Project B
    └── Local Dependencies B
```

## 25.4 ¿Qué actualización requiere mayor atención?

Depende del impacto.

Una herramienta compartida puede afectar a varios proyectos.

Una dependencia local puede tener un impacto profundo dentro de uno solo.

### Idea clave

**El alcance de una herramienta ayuda a determinar el impacto potencial de su actualización.**

---

# 26. Actualizar Homebrew, winget y gestores Linux

Los gestores del sistema tienen comandos y comportamientos distintos.

## 26.1 macOS — Homebrew

Consultar paquetes desactualizados:

```bash
brew outdated
```

Actualizar información de fórmulas y Casks:

```bash
brew update
```

Actualizar paquetes instalados:

```bash
brew upgrade
```

Los últimos dos comandos modifican el entorno y deben ejecutarse de forma planificada.

## 26.2 Windows — winget

Consultar paquetes que el gestor identifica como actualizables:

```powershell
winget upgrade
```

Actualizar un paquete concreto puede realizarse mediante una operación como:

```powershell
winget upgrade --id <PackageId>
```

`<PackageId>` representa el identificador real del paquete.

## 26.3 Debian / Ubuntu — APT

Consultar paquetes actualizables según los índices locales:

```bash
apt list --upgradable
```

Actualizar índices:

```bash
sudo apt update
```

Actualizar paquetes:

```bash
sudo apt upgrade
```

## 26.4 Fedora — DNF

Consultar actualizaciones:

```bash
dnf check-update
```

Este comando puede consultar repositorios y actualizar metadatos de caché según la configuración. Además, puede devolver un código de salida especial cuando existen actualizaciones.

Aplicar actualizaciones:

```bash
sudo dnf upgrade
```

## 26.5 Arch Linux — pacman

Consultar paquetes instalados:

```bash
pacman -Q
```

En Arch, la actualización completa del sistema se realiza habitualmente mediante:

```bash
sudo pacman -Syu
```

Debemos evitar las actualizaciones parciales del sistema que Arch no soporta.

## 26.6 Precaución

Estos comandos son ejemplos para comprender responsabilidades.

No debemos ejecutarlos todos.

Cada sistema requiere su gestor correspondiente.

Además, actualizar paquetes del sistema puede modificar servicios y dependencias compartidas.

### Idea clave

**La actualización correcta depende del sistema operativo, del gestor utilizado y del impacto esperado.**

---

# 27. Práctica: Environment Update Audit

Realizaremos una auditoría de solo lectura siempre que sea posible.

No actualizaremos software durante esta práctica.

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
Get-ComputerInfo |
  Select-Object WindowsProductName, OsArchitecture
```

## Step 2 — Consultar Git

```bash
git --version
```

## Step 3 — Consultar Node.js

```bash
node --version
```

## Step 4 — Consultar npm

```bash
npm --version
```

## Step 5 — Consultar pnpm

```bash
pnpm --version
```

## Step 6 — Registrar resultados

| Herramienta | Versión instalada | Versión requerida | Estado |
|---|---|---|---|
| Git | | | |
| Node.js | | | |
| npm | | | |
| pnpm | | | |
| Editor | | | |

## Step 7 — Evaluar

Para cada herramienta:

1. ¿Quién administra la instalación?
2. ¿Qué proyectos la utilizan?
3. ¿Está soportada?
4. ¿Existe una actualización relevante?
5. ¿Qué riesgos tiene actualizarla?
6. ¿Cómo validaríamos el cambio?

## Resultado esperado

Un inventario y una evaluación.

No una actualización indiscriminada.

---

# 28. Práctica: analizar una actualización de Node.js

Supongamos que tenemos:

```text
Current Runtime: Node.js A
Target Runtime: Node.js B
```

Ambas representan versiones hipotéticas.

## 28.1 Preguntas

1. ¿Qué versión requiere el proyecto?
2. ¿La versión destino está soportada?
3. ¿Qué cambios introduce?
4. ¿El gestor de paquetes es compatible?
5. ¿Las dependencias funcionan?
6. ¿Qué pruebas debemos ejecutar?
7. ¿Cómo volveríamos al estado anterior?

## 28.2 Plan

```text
Identify Current Version
          │
          ▼
Review Target Version
          │
          ▼
Check Project Compatibility
          │
          ▼
Prepare Recovery
          │
          ▼
Test Target Runtime
          │
          ▼
Run Build and Tests
          │
          ▼
Approve Change
```

## 28.3 Aprendizaje

**Cambiar de Runtime es una modificación del entorno que merece validación, incluso cuando el código fuente permanece igual.**

---

# 29. Práctica: analizar una actualización de TypeScript

Supongamos que un proyecto utiliza TypeScript y queremos actualizarlo.

## 29.1 ¿Qué debemos revisar?

- Versión actual.
- Versión destino.
- Release Notes.
- Compatibilidad del Runtime.
- Configuración `tsconfig`.
- Plugins.
- Tipos.
- Build.

## 29.2 Ejemplo de validación

Si el proyecto dispone de estos Scripts:

```bash
pnpm typecheck
```

```bash
pnpm build
```

```bash
pnpm test
```

## 29.3 ¿Qué debemos hacer si falla?

Identificar:

- El primer error relevante.
- El cambio que lo introdujo.
- Si es un problema de tipos.
- Si existe una Migration Guide.
- Si necesitamos ajustar configuración o código.

## 29.4 ¿Debemos desactivar comprobaciones para que compile?

No como solución automática.

Primero debemos comprender el problema.

### Aprendizaje

**Una actualización de herramientas de desarrollo puede revelar errores que antes no se detectaban.**

---

# 30. Práctica: diseñar una Update Policy

Imaginemos un equipo que mantiene una aplicación React y Node.js.

## 30.1 Objetivo

Diseñar una política de mantenimiento.

## 30.2 Propuesta

| Componente | Frecuencia de revisión | Validación |
|---|---|---|
| Sistema operativo | Según política y avisos | Compatibilidad general |
| Node.js | Según soporte y seguridad | Build + Tests |
| Package Manager | Revisión planificada | Instalación + Lockfile |
| TypeScript | Periódica | Typecheck + Build |
| ESLint | Periódica | Lint |
| Build Tool | Periódica | Build + Smoke Tests |
| Dependencias | Periódica y por avisos | Tests + Review |
| Infraestructura | Según riesgo y soporte | Pruebas de integración |

## 30.3 Responsabilidades

El equipo debe definir:

- Quién revisa actualizaciones.
- Quién aprueba cambios.
- Qué pruebas son obligatorias.
- Qué cambios requieren coordinación.
- Cómo se documentan.
- Qué procedimiento de recuperación existe.

## 30.4 Resultado esperado

Una política que pueda mantenerse sin depender de decisiones improvisadas.

---

# 31. Professional Update Checklist

## Before Update

- [ ] Identifiqué la versión actual.
- [ ] Identifiqué la versión destino.
- [ ] Verifiqué el estado de soporte.
- [ ] Revisé Release Notes.
- [ ] Revisé Breaking Changes.
- [ ] Evalué compatibilidad.
- [ ] Comprendo el alcance del cambio.
- [ ] Preparé una estrategia de recuperación.

## During Update

- [ ] Utilizo el gestor correcto.
- [ ] Respeto los requisitos del proyecto.
- [ ] Evito cambios no relacionados.
- [ ] Registro modificaciones relevantes.
- [ ] No expongo credenciales.
- [ ] Respeto las políticas corporativas.

## After Update

- [ ] Verifiqué versiones.
- [ ] Revisé archivos modificados.
- [ ] Validé instalación.
- [ ] Ejecuté Type Checking cuando corresponde.
- [ ] Ejecuté Linting cuando corresponde.
- [ ] Ejecuté Build.
- [ ] Ejecuté pruebas.
- [ ] Verifiqué servicios relevantes.
- [ ] Actualicé documentación.
- [ ] Confirmé que el entorno funciona.

---

# 32. Errores comunes

### Error 1 — Actualizar todo simultáneamente

Dificulta identificar la causa de los fallos.

### Error 2 — Nunca actualizar

Puede acumular riesgos de seguridad y mantenimiento.

### Error 3 — Confundir Update con Upgrade

Los comandos tienen significados diferentes según el gestor.

### Error 4 — Asumir que todas las herramientas utilizan SemVer

No es universal.

### Error 5 — Ignorar Breaking Changes

Puede romper configuraciones y APIs.

### Error 6 — Utilizar una versión sin soporte sin evaluar riesgos

Aumenta la exposición a problemas de mantenimiento.

### Error 7 — Actualizar Node.js sin revisar compatibilidad

Puede afectar dependencias y herramientas.

### Error 8 — Actualizar pnpm sin revisar el Lockfile

Puede introducir cambios inesperados.

### Error 9 — Eliminar Lockfiles indiscriminadamente

Puede modificar múltiples resoluciones.

### Error 10 — Ignorar Release Notes

Reduce nuestra comprensión del cambio.

### Error 11 — No ejecutar pruebas

Impide detectar regresiones conocidas.

### Error 12 — No preparar Rollback

Dificulta recuperar un estado operativo.

### Error 13 — Actualizar mediante el gestor incorrecto

Puede generar instalaciones duplicadas.

### Error 14 — Utilizar siempre la última versión

No garantiza compatibilidad ni soporte apropiado.

### Error 15 — Mantener versiones fijadas indefinidamente

Puede conservar vulnerabilidades y software obsoleto.

### Error 16 — Aprobar actualizaciones automáticas sin revisión adecuada

Puede introducir cambios incompatibles.

### Error 17 — No actualizar documentación

Genera instrucciones contradictorias.

### Error 18 — Ignorar políticas corporativas

Puede afectar entornos compartidos o incumplir requisitos.

---

# 33. Comprueba tu modelo mental

1. ¿Por qué debemos actualizar nuestras herramientas?
2. ¿Qué riesgos existen al no actualizar?
3. ¿Qué riesgos existen al actualizar indiscriminadamente?
4. ¿Qué diferencia conceptual existe entre Update y Upgrade?
5. ¿Qué es Migration?
6. ¿Qué es Software Lifecycle?
7. ¿Qué significa End of Life?
8. ¿Qué es Semantic Versioning?
9. ¿Qué representa MAJOR?
10. ¿Qué representa MINOR?
11. ¿Qué representa PATCH?
12. ¿Todas las herramientas utilizan SemVer?
13. ¿Qué es un Breaking Change?
14. ¿Qué es Deprecation?
15. ¿Qué significa LTS?
16. ¿Por qué debemos conocer el soporte de Node.js?
17. ¿Qué capas del entorno pueden actualizarse?
18. ¿Por qué debemos identificar el gestor de instalación?
19. ¿Qué diferencia existe entre actualizar Node.js y actualizar dependencias?
20. ¿Por qué debemos controlar la versión del Package Manager?
21. ¿Qué son las Transitive Dependencies?
22. ¿Qué papel cumple el Lockfile?
23. ¿Qué diferencia existe entre `^` y `~`?
24. ¿Qué es una Security Advisory?
25. ¿Todas las vulnerabilidades tienen el mismo riesgo?
26. ¿Qué información debemos buscar en Release Notes?
27. ¿Qué es una Controlled Update?
28. ¿Por qué conviene limitar cambios simultáneos?
29. ¿Qué significa establecer una Baseline?
30. ¿Qué es Rollback?
31. ¿Qué es Recovery?
32. ¿Git permite revertir cualquier actualización?
33. ¿Qué es una Update Policy?
34. ¿Qué hacen Dependabot y Renovate?
35. ¿Qué es Version Pinning?
36. ¿Qué diferencia existe entre actualizar herramientas globales y locales?
37. ¿Por qué debemos validar después de actualizar?
38. ¿Qué debemos documentar?
39. ¿Cómo evaluarías una actualización importante de Node.js?
40. ¿Qué caracteriza a una estrategia profesional de mantenimiento?

---

# 34. Checklist de aprendizaje

- [ ] Comprendo la importancia de actualizar herramientas.
- [ ] Diferencio Update, Upgrade y Migration.
- [ ] Comprendo Software Lifecycle.
- [ ] Reconozco versiones EOL.
- [ ] Comprendo Semantic Versioning.
- [ ] Distingo Major, Minor y Patch.
- [ ] Identifico Breaking Changes.
- [ ] Comprendo Deprecation.
- [ ] Comprendo LTS.
- [ ] Distingo las capas del entorno.
- [ ] Sé identificar quién administra una herramienta.
- [ ] Comprendo los riesgos de actualizar Node.js.
- [ ] Comprendo los riesgos de actualizar gestores de paquetes.
- [ ] Diferencio dependencias directas y transitivas.
- [ ] Comprendo el papel de los Lockfiles.
- [ ] Comprendo los rangos de versiones.
- [ ] Reconozco la importancia de Security Updates.
- [ ] Sé consultar Release Notes.
- [ ] Comprendo Controlled Updates.
- [ ] Sé preparar una Baseline.
- [ ] Comprendo Rollback y Recovery.
- [ ] Reconozco requisitos corporativos.
- [ ] Comprendo Update Policies.
- [ ] Conozco el propósito de las actualizaciones automatizadas.
- [ ] Comprendo Version Pinning.
- [ ] Puedo diseñar un plan de actualización.
- [ ] Puedo validar un entorno después de modificarlo.

---

# 💡 Idea clave

Mantener nuestras herramientas actualizadas no significa utilizar siempre la última versión disponible.

Significa mantener un entorno:

- Seguro.
- Compatible.
- Soportado.
- Estable.
- Comprensible.
- Mantenible.

```text
Uncontrolled Updates
        │
        ▼
Unexpected Changes
        │
        ▼
Compatibility Problems
        │
        ▼
Unstable Development
```

El enfoque profesional es:

```text
Identify Update
       │
       ▼
Evaluate Risk
       │
       ▼
Review Compatibility
       │
       ▼
Plan Change
       │
       ▼
Apply Update
       │
       ▼
Validate
       │
       ▼
Document
       │
       ▼
Maintainable Environment
```

**La mejor estrategia de actualización es aquella que permite evolucionar nuestras herramientas sin perder el control sobre el comportamiento de nuestros proyectos.**

---

# 35. Cierre del módulo: Development Environment

Con este documento completamos el módulo:

**`01-development-environment`**

Durante este módulo hemos construido un modelo mental sobre:

### Foundations

- Qué es un entorno de desarrollo.
- Diferencias entre configuración local y de proyecto.
- Diferencias entre configuración personal y de equipo.
- Reproducibilidad.
- Capas del entorno.

### Operating Systems

- macOS.
- Windows.
- Linux.
- Terminales y Shells de cada plataforma.
- Gestores de paquetes del sistema.
- PATH.
- Problemas frecuentes.

### Best Practices

- Clean Development Machine.
- Avoid Global Pollution.
- Document Your Environment.
- Keep Your Tools Updated.

## ¿Qué deberíamos ser capaces de hacer ahora?

Explicar cómo está organizado nuestro entorno y responder:

1. ¿Qué sistema operativo utilizo?
2. ¿Qué Shell ejecuta mis comandos?
3. ¿Cómo encuentra el sistema los ejecutables?
4. ¿Qué gestor administra mis herramientas?
5. ¿Qué herramientas pertenecen a mi computadora?
6. ¿Qué herramientas pertenecen al proyecto?
7. ¿Cómo documento sus requisitos?
8. ¿Cómo mantengo el entorno actualizado?
9. ¿Cómo diagnostico conflictos?
10. ¿Cómo preparo otra computadora para trabajar?

## Modelo final

```text
Professional Development Environment
│
├── Operating System
│
├── Terminal and Shell
│
├── System Package Manager
│
├── Development Tools
│
├── Runtime Management
│
├── Project Dependencies
│
├── Environment Configuration
│
├── Documentation
│
└── Maintenance Strategy
```

Este modelo nos acompañará durante todo **Developer Tooling Mastery 2026**.

---

# 🚀 Siguiente módulo

Ahora que comprendemos el entorno de desarrollo, necesitamos dominar una de sus interfaces fundamentales:

**Terminal and Shell.**

En el siguiente módulo profundizaremos en:

- Terminal vs Shell.
- Bash, Zsh y PowerShell.
- Navegación por el sistema de archivos.
- Comandos.
- Pipes.
- Redirecciones.
- Variables.
- Procesos.
- Scripts.
- Automatización.
- Buenas prácticas de Terminal.

El objetivo será dejar de utilizar comandos como instrucciones que simplemente copiamos y comenzar a comprender **cómo funcionan, qué ejecutan y cómo combinarlos para resolver problemas reales**.

👉 [Terminal and Shell](../../02-terminal-and-shell/README.md)