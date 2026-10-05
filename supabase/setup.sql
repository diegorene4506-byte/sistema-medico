-- Ejecutar una sola vez en Supabase → SQL Editor.
-- Crea la tabla de perfiles: una fila por médico registrado.
-- Solo contiene datos de la cuenta; los expedientes NUNCA llegan aquí.

create table public.perfiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  nombre text,
  especialidad text,
  activo boolean not null default false,  -- marcar en el panel para aprobar / desmarcar para suspender
  notas text,                             -- notas internas del administrador (pagos, etc.)
  creado timestamptz not null default now()
);

alter table public.perfiles enable row level security;

-- Cada médico solo puede leer su propio perfil, y no puede modificarlo
-- (así nadie se puede auto-activar). El administrador lo edita desde el panel.
create policy "Cada usuario lee su perfil"
  on public.perfiles for select to authenticated
  using ((select auth.uid()) = id);

revoke insert, update, delete on public.perfiles from anon, authenticated;

-- Al registrarse, se crea su perfil automáticamente como INACTIVO (pendiente de aprobación).
create or replace function public.crear_perfil()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  insert into public.perfiles (id, email, nombre, especialidad)
  values (new.id, new.email, new.raw_user_meta_data->>'nombre', new.raw_user_meta_data->>'especialidad');
  return new;
end;
$$;

create trigger al_registrarse
  after insert on auth.users
  for each row execute function public.crear_perfil();
