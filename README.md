# Sistema Médico (beta)

Panel de gestión para consultorio médico: pacientes, agenda, cirugías, honorarios, aseguradoras, brokers, proveedores,
metas de ahorro y tareas.

## Cómo funciona

- Es un solo archivo `index.html`, sin servidor ni base de datos.
- **Los datos se guardan solo en el navegador del dispositivo** (`localStorage`).
  No se envían a GitHub ni a ningún otro servidor. Este repositorio contiene
  únicamente el código.
- Cada dispositivo/navegador tiene sus propios datos; no se sincronizan.

## Cuentas de usuario

Cada médico crea su cuenta dentro de la app (nombre, especialidad, correo,
contraseña). La cuenta queda **pendiente** hasta que el administrador la aprueba.

- Las cuentas viven en **Supabase**; los expedientes **no**: se quedan en el
  dispositivo de cada médico. El administrador nunca tiene acceso a ellos.
- Si una cuenta se suspende, el médico no puede entrar (sus datos siguen en su
  dispositivo y vuelve a verlos si se reactiva).
- Sin internet se puede entrar hasta 7 días desde la última verificación.
- Si varios médicos usan el mismo dispositivo, cada cuenta ve solo sus datos.

### Configuración inicial de Supabase (una sola vez)

1. Crear cuenta y proyecto en https://supabase.com (plan gratuito).
2. **SQL Editor** → pegar y ejecutar [`supabase/setup.sql`](supabase/setup.sql).
3. **Project Settings → API**: copiar *Project URL* y la clave *anon / publishable*
   en [`config.js`](config.js). (Nunca la clave *service_role / secret*.)
4. **Authentication → URL Configuration**: *Site URL* = la URL de GitHub Pages
   (ej. `https://TU_USUARIO.github.io/sistema-medico/`).

### Administrar cuentas

**Table Editor → perfiles**:
- Aprobar: marcar `activo` ✔
- Suspender / cancelar suscripción: desmarcar `activo`
- `notas`: notas internas (pagos, fechas, etc.)

El cambio se aplica la próxima vez que el médico abre la app (o en máx. 30 min).
Para borrar una cuenta: **Authentication → Users → Delete user**.

## Uso

Abrir la URL de GitHub Pages (Settings → Pages) o abrir `index.html` directamente.

## Instalar para conservar los datos (obligatorio en la beta)

Usar siempre la app **instalada** y siempre en el mismo dispositivo:

- **iPhone / iPad (Safari):** abrir la URL → Compartir → **Agregar a pantalla de inicio**.
  Usar siempre el ícono, no Safari (Safari puede borrar los datos tras 7 días sin uso).
- **Android (Chrome):** menú ⋮ → **Instalar app**.
- **Computadora (Chrome / Edge):** ícono de instalar en la barra de direcciones.

Verificar en Configuración → *Datos y respaldo*: debe decir
**"Datos protegidos en este dispositivo"**.

Los datos se pierden solo si se desinstala la app, se borran los datos del
navegador o cambia la URL (no renombrar el repositorio).

## Respaldo (recomendado)

Configuración → **Exportar datos (.json)** de vez en cuando, guardando el archivo
fuera de este repositorio. Para restaurar: Configuración → **Importar datos**.

## Privacidad

Los expedientes clínicos son datos personales sensibles (LFPDPPP).
- No subir archivos `.json` exportados a este repositorio (`.gitignore` los bloquea).
- Usar el sistema solo en dispositivos personales con bloqueo de pantalla.
