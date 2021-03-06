copy 
(select
g.year as year,
g.game_date as game_date,
g.team_name as team,
t.division as team_div,
g.opponent_name as opponent,
o.division as opponent_div,
(case when g.location='@' then 'team_home'
      when g.location='vs.' then 'neutral'
      else 'missing' end)
as site,
g.team_score,
g.opponent_score,
(case when g.team_score>g.opponent_score then 1.0
      when g.team_score<g.opponent_score then 0.0
      when g.team_score=g.opponent_score then 0.5
end) as outcome
from uscho.games g
join uscho.teams t
  on (t.team_id,t.year)=(g.team_id,g.year)
join uscho.teams o
  on (o.team_id,o.year)=(g.opponent_id,g.year)
where
    TRUE
--and g.year=2015
--and t.division='I'
--and o.division='I'
and g.team_score is not null
and g.opponent_score is not null
order by game_date)
to '/tmp/uscho_games.csv'
csv header;
