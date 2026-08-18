create table if not exists public.spotlight_shenzhen_2026_accounts (
  user_id uuid primary key references auth.users(id) on delete cascade,
  public_reference text not null unique default (
    'SZ26-' || upper(substr(replace(gen_random_uuid()::text, '-', ''), 1, 12))
  ),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  submitted_at timestamptz,
  application_language text not null,
  applicant_name text not null,
  applicant_email text not null,
  contact_handle text,
  country_region text not null,
  privacy_consent boolean not null,
  source_path text not null default '/shenzhen2026/apply',
  constraint spotlight_sz26_account_reference_format
    check (public_reference ~ '^SZ26-[A-F0-9]{12}$'),
  constraint spotlight_sz26_account_language_values
    check (application_language in ('en', 'zh')),
  constraint spotlight_sz26_account_name_length
    check (char_length(applicant_name) between 2 and 120),
  constraint spotlight_sz26_account_email_format
    check (
      char_length(applicant_email) <= 320
      and applicant_email ~* '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$'
    ),
  constraint spotlight_sz26_account_contact_length
    check (contact_handle is null or char_length(contact_handle) <= 200),
  constraint spotlight_sz26_account_country_length
    check (char_length(country_region) between 2 and 120),
  constraint spotlight_sz26_account_privacy_required
    check (privacy_consent),
  constraint spotlight_sz26_account_source_path_length
    check (char_length(source_path) <= 200)
);

create index if not exists spotlight_sz26_accounts_created_at_idx
  on public.spotlight_shenzhen_2026_accounts (created_at desc);
create index if not exists spotlight_sz26_accounts_email_idx
  on public.spotlight_shenzhen_2026_accounts (lower(applicant_email));

alter table public.spotlight_shenzhen_2026_accounts enable row level security;
revoke all on table public.spotlight_shenzhen_2026_accounts from anon, authenticated;
grant usage on schema public to authenticated;
grant select on table public.spotlight_shenzhen_2026_accounts to authenticated;
grant update (
  application_language,
  applicant_name,
  contact_handle,
  country_region,
  updated_at,
  source_path
) on table public.spotlight_shenzhen_2026_accounts to authenticated;

drop policy if exists "Applicants can read their Shenzhen account"
  on public.spotlight_shenzhen_2026_accounts;
create policy "Applicants can read their Shenzhen account"
  on public.spotlight_shenzhen_2026_accounts
  for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Applicants can update their Shenzhen account"
  on public.spotlight_shenzhen_2026_accounts;
create policy "Applicants can update their Shenzhen account"
  on public.spotlight_shenzhen_2026_accounts
  for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create or replace function public.create_spotlight_shenzhen_2026_account()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if new.raw_user_meta_data ->> 'spotlight_program' = 'shenzhen2026' then
    insert into public.spotlight_shenzhen_2026_accounts (
      user_id,
      application_language,
      applicant_name,
      applicant_email,
      contact_handle,
      country_region,
      privacy_consent,
      source_path
    ) values (
      new.id,
      coalesce(nullif(new.raw_user_meta_data ->> 'application_language', ''), 'en'),
      new.raw_user_meta_data ->> 'applicant_name',
      new.email,
      nullif(new.raw_user_meta_data ->> 'contact_handle', ''),
      new.raw_user_meta_data ->> 'country_region',
      new.raw_user_meta_data ->> 'privacy_consent' = 'true',
      coalesce(nullif(new.raw_user_meta_data ->> 'source_path', ''), '/shenzhen2026/apply')
    );
  end if;
  return new;
end;
$$;

drop trigger if exists create_spotlight_shenzhen_2026_account_on_signup on auth.users;
create trigger create_spotlight_shenzhen_2026_account_on_signup
  after insert on auth.users
  for each row execute procedure public.create_spotlight_shenzhen_2026_account();

create table if not exists public.spotlight_shenzhen_2026_drafts (
  user_id uuid primary key references public.spotlight_shenzhen_2026_accounts(user_id) on delete cascade,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  draft_data jsonb not null default '{}'::jsonb,
  constraint spotlight_sz26_draft_is_object
    check (jsonb_typeof(draft_data) = 'object')
);

alter table public.spotlight_shenzhen_2026_drafts enable row level security;
revoke all on table public.spotlight_shenzhen_2026_drafts from anon, authenticated;
grant select, insert, update, delete on table public.spotlight_shenzhen_2026_drafts to authenticated;

drop policy if exists "Applicants can read their Shenzhen draft"
  on public.spotlight_shenzhen_2026_drafts;
create policy "Applicants can read their Shenzhen draft"
  on public.spotlight_shenzhen_2026_drafts
  for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Applicants can create their Shenzhen draft"
  on public.spotlight_shenzhen_2026_drafts;
create policy "Applicants can create their Shenzhen draft"
  on public.spotlight_shenzhen_2026_drafts
  for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Applicants can update their Shenzhen draft"
  on public.spotlight_shenzhen_2026_drafts;
create policy "Applicants can update their Shenzhen draft"
  on public.spotlight_shenzhen_2026_drafts
  for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Applicants can delete their Shenzhen draft"
  on public.spotlight_shenzhen_2026_drafts;
create policy "Applicants can delete their Shenzhen draft"
  on public.spotlight_shenzhen_2026_drafts
  for delete
  to authenticated
  using ((select auth.uid()) = user_id);

alter table public.spotlight_shenzhen_2026_applications
  add column if not exists user_id uuid references auth.users(id) on delete set null;
create unique index if not exists spotlight_sz26_applications_user_idx
  on public.spotlight_shenzhen_2026_applications (user_id)
  where user_id is not null;

revoke insert on table public.spotlight_shenzhen_2026_applications from anon;
grant insert (
  user_id,
  public_reference,
  application_language,
  applicant_name,
  applicant_email,
  contact_handle,
  country_region,
  team_size,
  team_members_and_roles,
  project_name,
  product_form,
  one_liner,
  target_users,
  problem_statement,
  category_thesis,
  agent_core,
  current_stage,
  prototype_url,
  demo_video_url,
  repository_url,
  technology_summary,
  open_source_status,
  shenzhen_attendance,
  sprint_goal,
  support_needs,
  privacy_consent,
  code_of_conduct_consent,
  submission_declaration,
  source_path
) on table public.spotlight_shenzhen_2026_applications to authenticated;

drop policy if exists "Public can submit Spotlight Shenzhen 2026 applications"
  on public.spotlight_shenzhen_2026_applications;
drop policy if exists "Applicants can submit their Shenzhen application"
  on public.spotlight_shenzhen_2026_applications;
create policy "Applicants can submit their Shenzhen application"
  on public.spotlight_shenzhen_2026_applications
  for insert
  to authenticated
  with check (
    (select auth.uid()) = user_id
    and exists (
      select 1
      from public.spotlight_shenzhen_2026_accounts as account
      where account.user_id = (select auth.uid())
        and account.public_reference = spotlight_shenzhen_2026_applications.public_reference
        and lower(account.applicant_email) = lower(spotlight_shenzhen_2026_applications.applicant_email)
    )
    and privacy_consent
    and code_of_conduct_consent
    and submission_declaration
    and review_status = 'received'
  );

create or replace function public.complete_spotlight_shenzhen_2026_account()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  update public.spotlight_shenzhen_2026_accounts
  set submitted_at = new.created_at,
      updated_at = now()
  where user_id = new.user_id;

  delete from public.spotlight_shenzhen_2026_drafts
  where user_id = new.user_id;

  return new;
end;
$$;

drop trigger if exists complete_spotlight_shenzhen_2026_account_on_submit
  on public.spotlight_shenzhen_2026_applications;
create trigger complete_spotlight_shenzhen_2026_account_on_submit
  after insert on public.spotlight_shenzhen_2026_applications
  for each row execute procedure public.complete_spotlight_shenzhen_2026_account();

create or replace view public.spotlight_shenzhen_2026_account_funnel
with (security_invoker = on)
as
select
  count(*)::bigint as registered_accounts,
  count(*) filter (where auth_user.email_confirmed_at is not null)::bigint as confirmed_accounts,
  count(*) filter (
    where draft.user_id is not null or account.submitted_at is not null
  )::bigint as questionnaire_started,
  count(*) filter (where account.submitted_at is not null)::bigint as completed_applications,
  case
    when count(*) = 0 then 0::numeric
    else round(
      100.0 * count(*) filter (
        where draft.user_id is not null or account.submitted_at is not null
      ) / count(*),
      1
    )
  end as questionnaire_start_rate_percent,
  case
    when count(*) = 0 then 0::numeric
    else round(
      100.0 * count(*) filter (where account.submitted_at is not null) / count(*),
      1
    )
  end as registration_completion_rate_percent,
  case
    when count(*) filter (
      where draft.user_id is not null or account.submitted_at is not null
    ) = 0 then 0::numeric
    else round(
      100.0 * count(*) filter (where account.submitted_at is not null)
      / count(*) filter (
        where draft.user_id is not null or account.submitted_at is not null
      ),
      1
    )
  end as started_completion_rate_percent
from public.spotlight_shenzhen_2026_accounts as account
join auth.users as auth_user on auth_user.id = account.user_id
left join public.spotlight_shenzhen_2026_drafts as draft on draft.user_id = account.user_id;

revoke all on public.spotlight_shenzhen_2026_account_funnel from anon, authenticated;
grant select on public.spotlight_shenzhen_2026_account_funnel to service_role;

comment on table public.spotlight_shenzhen_2026_accounts is
  'Authenticated accounts registered specifically for Spotlight Shenzhen 2026.';
comment on table public.spotlight_shenzhen_2026_drafts is
  'Private per-user application drafts used to continue the questionnaire across devices.';
comment on view public.spotlight_shenzhen_2026_account_funnel is
  'Private account funnel: registered, email-confirmed, questionnaire started, submitted, and conversion rates.';
