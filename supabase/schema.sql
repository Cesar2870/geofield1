-- GeoField: schema inicial do Supabase.
-- Execute este arquivo uma vez no SQL Editor do seu projeto Supabase.

begin;

-- Resolve conflitos entre dispositivos: a atualização mais antiga é descartada.
create or replace function public.discard_older_updates()
returns trigger
language plpgsql
as $$
begin
  if new.updated_at <= old.updated_at then
    return null;
  end if;
  return new;
end;
$$;

create table if not exists public.surveys (
  id uuid not null,
  user_id uuid not null references auth.users (id) on delete cascade,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted boolean not null default false,
  name text not null,
  description text,
  primary key (id, user_id)
);

create table if not exists public.points (
  id uuid not null,
  user_id uuid not null references auth.users (id) on delete cascade,
  survey_id uuid not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted boolean not null default false,
  latitude double precision not null,
  longitude double precision not null,
  accuracy double precision,
  source text not null check (source in ('manual', 'automatic')),
  captured_at timestamptz not null,
  primary key (id, user_id)
);

create index if not exists surveys_user_id_idx on public.surveys (user_id);
create index if not exists points_user_id_idx on public.points (user_id);
create index if not exists points_survey_id_idx on public.points (survey_id);

drop trigger if exists handle_conflicts on public.surveys;
create trigger handle_conflicts
before update on public.surveys
for each row execute function public.discard_older_updates();

drop trigger if exists handle_conflicts on public.points;
create trigger handle_conflicts
before update on public.points
for each row execute function public.discard_older_updates();

alter table public.surveys enable row level security;
alter table public.points enable row level security;

drop policy if exists "Users can work with own surveys" on public.surveys;
create policy "Users can work with own surveys"
on public.surveys
for all
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can work with own points" on public.points;
create policy "Users can work with own points"
on public.points
for all
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

grant all on public.surveys to authenticated;
grant all on public.points to authenticated;

-- Realtime exigido pelo syncable.
do $$
begin
  if not exists (select 1 from pg_publication where pubname = 'supabase_realtime') then
    create publication supabase_realtime;
  end if;
end
$$;

do $$
declare
  t text;
begin
  foreach t in array array['surveys', 'points'] loop
    if not exists (
      select 1
      from pg_publication_tables
      where pubname = 'supabase_realtime'
        and schemaname = 'public'
        and tablename = t
    ) then
      execute format('alter publication supabase_realtime add table public.%I', t);
    end if;
  end loop;
end
$$;

commit;
