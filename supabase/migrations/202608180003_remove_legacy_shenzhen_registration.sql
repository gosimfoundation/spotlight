-- The authenticated account flow replaces the earlier anonymous interest form.
-- The legacy table only contains the organizer's test row and is no longer used
-- by the application page.
drop view if exists public.spotlight_shenzhen_2026_registration_funnel;
drop table if exists public.spotlight_shenzhen_2026_registrations;

comment on table public.spotlight_shenzhen_2026_accounts is
  'Registered Spotlight Shenzhen 2026 accounts. Open this table to see who signed up.';

comment on table public.spotlight_shenzhen_2026_drafts is
  'Internal autosaved questionnaires that registered applicants have started but not submitted.';

comment on table public.spotlight_shenzhen_2026_applications is
  'Completed Spotlight Shenzhen 2026 applications. Open this table for review.';

comment on view public.spotlight_shenzhen_2026_account_funnel is
  'One-row organizer summary: registered, confirmed, started, submitted, and conversion rates.';
