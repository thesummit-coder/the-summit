# THE SUMMIT

iPhone-first human competition app.

## Stack
- Static frontend: plain HTML/CSS/JavaScript
- Auth + Postgres + RLS: Supabase
- Atomic fight recording: Supabase Edge Function + Postgres RPC
- Hosting target: Cloudflare Workers/Pages
- Source of truth: GitHub

No AI app builder is required to develop or deploy this app.

## Product rules
- One account can create unlimited fighters.
- Every fighter is human.
- STR / INT / DUR / SPD are uniform random integers from 1–10.
- Stats stay permanent after confirmation.
- Random Fight and Choose Fighters are supported.
- The user taps the fighter card itself to choose the winner.
- Winner +1 W, loser +1 L.
- Rematches are allowed.
- Owners can delete their own fighters.
- All authenticated users can see and fight any fighter in the shared arena.

## Supabase
Project ref: `ixpvkbbivzpdcdjhfdwu`

The production database already contains the core schema and the migrations in this repository document the shared-league changes.

The frontend uses only the Supabase publishable key. The service-role key is used only inside the Edge Function and is never shipped to the browser.
