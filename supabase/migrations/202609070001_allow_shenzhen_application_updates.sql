-- Let signed-in applicants reopen and replace their own submission while keeping
-- review-only fields private and immutable.
grant select (
  id,
  user_id,
  public_reference,
  created_at,
  updated_at,
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

grant update (
  application_language,
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

drop policy if exists "Applicants can read their Shenzhen application"
  on public.spotlight_shenzhen_2026_applications;
create policy "Applicants can read their Shenzhen application"
  on public.spotlight_shenzhen_2026_applications
  for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Applicants can update their Shenzhen application"
  on public.spotlight_shenzhen_2026_applications;
create policy "Applicants can update their Shenzhen application"
  on public.spotlight_shenzhen_2026_applications
  for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check (
    (select auth.uid()) = user_id
    and privacy_consent
    and code_of_conduct_consent
    and submission_declaration
  );

create or replace function public.set_spotlight_shenzhen_2026_application_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_spotlight_shenzhen_2026_application_updated_at
  on public.spotlight_shenzhen_2026_applications;
create trigger set_spotlight_shenzhen_2026_application_updated_at
  before update on public.spotlight_shenzhen_2026_applications
  for each row execute procedure public.set_spotlight_shenzhen_2026_application_updated_at();

comment on table public.spotlight_shenzhen_2026_applications is
  'Completed Spotlight Shenzhen 2026 applications. Applicants can read and replace their own submission; review fields remain private.';
