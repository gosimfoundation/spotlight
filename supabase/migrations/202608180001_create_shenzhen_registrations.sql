create table if not exists public.spotlight_shenzhen_2026_registrations (
  id uuid primary key default gen_random_uuid(),
  public_reference text not null unique,
  created_at timestamptz not null default now(),
  application_language text not null,
  applicant_name text not null,
  applicant_email text not null,
  contact_handle text,
  country_region text not null,
  privacy_consent boolean not null,
  source_path text not null default '/shenzhen2026/apply',
  constraint spotlight_sz26_registration_reference_format
    check (public_reference ~ '^SZ26-[A-F0-9]{12}$'),
  constraint spotlight_sz26_registration_language_values
    check (application_language in ('en', 'zh')),
  constraint spotlight_sz26_registration_name_length
    check (char_length(applicant_name) between 2 and 120),
  constraint spotlight_sz26_registration_email_format
    check (
      char_length(applicant_email) <= 320
      and applicant_email ~* '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$'
    ),
  constraint spotlight_sz26_registration_contact_length
    check (contact_handle is null or char_length(contact_handle) <= 200),
  constraint spotlight_sz26_registration_country_length
    check (char_length(country_region) between 2 and 120),
  constraint spotlight_sz26_registration_privacy_required
    check (privacy_consent),
  constraint spotlight_sz26_registration_source_path_length
    check (char_length(source_path) <= 200)
);

create index if not exists spotlight_sz26_registrations_created_at_idx
  on public.spotlight_shenzhen_2026_registrations (created_at desc);
create index if not exists spotlight_sz26_registrations_email_idx
  on public.spotlight_shenzhen_2026_registrations (lower(applicant_email));

alter table public.spotlight_shenzhen_2026_registrations enable row level security;

revoke all on table public.spotlight_shenzhen_2026_registrations from anon, authenticated;
grant usage on schema public to anon;
grant insert (
  public_reference,
  application_language,
  applicant_name,
  applicant_email,
  contact_handle,
  country_region,
  privacy_consent,
  source_path
) on table public.spotlight_shenzhen_2026_registrations to anon;

drop policy if exists "Public can start Spotlight Shenzhen 2026 registrations"
  on public.spotlight_shenzhen_2026_registrations;
create policy "Public can start Spotlight Shenzhen 2026 registrations"
  on public.spotlight_shenzhen_2026_registrations
  for insert
  to anon
  with check (privacy_consent);

comment on table public.spotlight_shenzhen_2026_registrations is
  'Started Spotlight Shenzhen 2026 applications. A matching public_reference in spotlight_shenzhen_2026_applications means the questionnaire was completed.';

create or replace view public.spotlight_shenzhen_2026_registration_funnel
with (security_invoker = on)
as
select
  count(*)::bigint as started_registrations,
  count(distinct lower(registration.applicant_email))::bigint as unique_emails_started,
  count(application.public_reference)::bigint as completed_applications,
  count(*) filter (where application.public_reference is null)::bigint as incomplete_registrations,
  case
    when count(*) = 0 then 0::numeric
    else round(100.0 * count(application.public_reference) / count(*), 1)
  end as completion_rate_percent
from public.spotlight_shenzhen_2026_registrations as registration
left join public.spotlight_shenzhen_2026_applications as application
  using (public_reference);

revoke all on public.spotlight_shenzhen_2026_registration_funnel from anon, authenticated;
grant select on public.spotlight_shenzhen_2026_registration_funnel to service_role;

comment on view public.spotlight_shenzhen_2026_registration_funnel is
  'Private registration funnel summary: started, unique, completed, incomplete, and completion rate.';
