create table strippedPitchers(pitcher int, pitcher_name text)
select
    pitcher,
    player_name as pitcher_name
from
    DatabasePitcherEvents
group by
    pitcher;
update
    CombinedEvents C
    inner join strippedPitchers P on
    C.pitcher = P.pitcher
set
    C.pitcher_name = P.pitcher_name
where C.pitcher_name is NULL;

    drop table strippedPitchers;