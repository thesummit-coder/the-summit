create or replace function public.record_fight(
  p_fighter_a uuid,
  p_fighter_b uuid,
  p_winner uuid,
  p_actor uuid
)
returns table(winner_wins integer, loser_losses integer)
language plpgsql
security definer
set search_path = public
as $$
declare
  loser_id uuid;
  ww integer;
  ll integer;
begin
  if p_fighter_a = p_fighter_b then raise exception 'Fighters must be different'; end if;
  if p_winner <> p_fighter_a and p_winner <> p_fighter_b then raise exception 'Winner must be one of the fighters'; end if;
  if not exists (select 1 from public.fighters where id = p_fighter_a)
     or not exists (select 1 from public.fighters where id = p_fighter_b) then raise exception 'Fighter not found'; end if;
  loser_id := case when p_winner = p_fighter_a then p_fighter_b else p_fighter_a end;
  update public.fighters set wins = wins + 1 where id = p_winner returning wins into ww;
  update public.fighters set losses = losses + 1 where id = loser_id returning losses into ll;
  insert into public.fights(user_id, fighter_a, fighter_b, winner)
  values (p_actor, p_fighter_a, p_fighter_b, p_winner);
  return query select ww, ll;
end;
$$;

revoke all on function public.record_fight(uuid, uuid, uuid, uuid) from public, anon, authenticated;
grant execute on function public.record_fight(uuid, uuid, uuid, uuid) to service_role;
