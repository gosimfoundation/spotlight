create table if not exists public.spotlight_shenzhen_2026_applications (
  id uuid primary key default gen_random_uuid(),
  public_reference text not null unique,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  application_language text not null,
  applicant_name text not null,
  applicant_email text not null,
  contact_handle text,
  country_region text not null,
  team_organization text,
  team_size smallint not null,
  team_members_and_roles text not null,
  project_name text not null,
  project_url text,
  product_form text not null,
  one_liner text not null,
  target_users text not null,
  problem_statement text not null,
  category_thesis text not null,
  agent_core text not null,
  current_stage text not null,
  prototype_url text not null,
  demo_video_url text,
  repository_url text,
  technology_summary text not null,
  traction text,
  open_source_status text not null,
  license_name text,
  shenzhen_attendance text not null,
  sprint_goal text not null,
  support_needs text[] not null default '{}',
  support_details text,
  privacy_consent boolean not null,
  code_of_conduct_consent boolean not null,
  submission_declaration boolean not null,
  source_path text not null default '/shenzhen2026/apply',
  review_status text not null default 'received',
  internal_tags text[] not null default '{}',
  internal_notes text,
  reviewer_score jsonb,
  constraint spotlight_sz26_reference_format check (public_reference ~ '^SZ26-[A-F0-9]{12}$'),
  constraint spotlight_sz26_language_values check (application_language in ('en', 'zh', 'fr')),
  constraint spotlight_sz26_applicant_name_length check (char_length(applicant_name) between 2 and 120),
  constraint spotlight_sz26_applicant_email_format check (char_length(applicant_email) <= 320 and applicant_email ~* '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$'),
  constraint spotlight_sz26_contact_handle_length check (contact_handle is null or char_length(contact_handle) <= 200),
  constraint spotlight_sz26_country_region_length check (char_length(country_region) between 2 and 120),
  constraint spotlight_sz26_team_organization_length check (team_organization is null or char_length(team_organization) <= 200),
  constraint spotlight_sz26_team_size_range check (team_size between 1 and 100),
  constraint spotlight_sz26_team_members_length check (char_length(team_members_and_roles) between 5 and 2000),
  constraint spotlight_sz26_project_name_length check (char_length(project_name) between 2 and 160),
  constraint spotlight_sz26_project_url_format check (project_url is null or (char_length(project_url) <= 500 and project_url ~* '^https?://')),
  constraint spotlight_sz26_product_form_values check (product_form in ('new_hardware', 'adapted_device', 'software', 'cross_device', 'other')),
  constraint spotlight_sz26_one_liner_length check (char_length(one_liner) between 10 and 240),
  constraint spotlight_sz26_target_users_length check (char_length(target_users) between 20 and 1500),
  constraint spotlight_sz26_problem_length check (char_length(problem_statement) between 30 and 2500),
  constraint spotlight_sz26_category_thesis_length check (char_length(category_thesis) between 30 and 2500),
  constraint spotlight_sz26_agent_core_length check (char_length(agent_core) between 30 and 3000),
  constraint spotlight_sz26_current_stage_values check (current_stage in ('concept', 'prototype', 'pilot', 'launched')),
  constraint spotlight_sz26_prototype_url_format check (char_length(prototype_url) <= 500 and prototype_url ~* '^https?://'),
  constraint spotlight_sz26_demo_video_url_format check (demo_video_url is null or (char_length(demo_video_url) <= 500 and demo_video_url ~* '^https?://')),
  constraint spotlight_sz26_repository_url_format check (repository_url is null or (char_length(repository_url) <= 500 and repository_url ~* '^https?://')),
  constraint spotlight_sz26_technology_length check (char_length(technology_summary) between 20 and 3000),
  constraint spotlight_sz26_traction_length check (traction is null or char_length(traction) <= 2000),
  constraint spotlight_sz26_open_source_values check (open_source_status in ('already_open', 'planning_core', 'planning_partial', 'request_exemption')),
  constraint spotlight_sz26_license_length check (license_name is null or char_length(license_name) <= 120),
  constraint spotlight_sz26_attendance_values check (shenzhen_attendance in ('yes', 'likely', 'need_support', 'no')),
  constraint spotlight_sz26_sprint_goal_length check (char_length(sprint_goal) between 20 and 2500),
  constraint spotlight_sz26_support_values check (support_needs <@ array['product', 'ai_engineering', 'hardware', 'fabrication', 'demo_story', 'travel', 'other']::text[]),
  constraint spotlight_sz26_support_details_length check (support_details is null or char_length(support_details) <= 2000),
  constraint spotlight_sz26_privacy_required check (privacy_consent),
  constraint spotlight_sz26_code_required check (code_of_conduct_consent),
  constraint spotlight_sz26_declaration_required check (submission_declaration),
  constraint spotlight_sz26_source_path_length check (char_length(source_path) <= 200),
  constraint spotlight_sz26_review_status_values check (review_status in ('received', 'screening', 'shortlisted', 'waitlisted', 'declined', 'selected', 'withdrawn'))
);

create index if not exists spotlight_sz26_applications_created_at_idx
  on public.spotlight_shenzhen_2026_applications (created_at desc);
create index if not exists spotlight_sz26_applications_review_status_idx
  on public.spotlight_shenzhen_2026_applications (review_status, created_at desc);
create index if not exists spotlight_sz26_applications_email_idx
  on public.spotlight_shenzhen_2026_applications (lower(applicant_email));

alter table public.spotlight_shenzhen_2026_applications enable row level security;

revoke all on table public.spotlight_shenzhen_2026_applications from anon, authenticated;
grant usage on schema public to anon;
grant insert (
  public_reference,
  application_language,
  applicant_name,
  applicant_email,
  contact_handle,
  country_region,
  team_organization,
  team_size,
  team_members_and_roles,
  project_name,
  project_url,
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
  traction,
  open_source_status,
  license_name,
  shenzhen_attendance,
  sprint_goal,
  support_needs,
  support_details,
  privacy_consent,
  code_of_conduct_consent,
  submission_declaration,
  source_path
) on table public.spotlight_shenzhen_2026_applications to anon;

drop policy if exists "Public can submit Spotlight Shenzhen 2026 applications"
  on public.spotlight_shenzhen_2026_applications;
create policy "Public can submit Spotlight Shenzhen 2026 applications"
  on public.spotlight_shenzhen_2026_applications
  for insert
  to anon
  with check (
    privacy_consent
    and code_of_conduct_consent
    and submission_declaration
    and review_status = 'received'
  );

comment on table public.spotlight_shenzhen_2026_applications is
  'Public applications for GOSIM Spotlight Shenzhen 2026. Public API access is insert-only; review fields remain private.';
