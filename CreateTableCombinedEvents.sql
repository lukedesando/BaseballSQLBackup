Create TABLE CombinedEvents(
    pitcher int,
    pitcher_name text,
    batter int,
    batter_name text,
    estimated_ba DOUBLE,
    actual_ba DOUBLE,
    PA INT
)
select
    pitcher,
    batter,
    player_name as batter_name,
    avg(estimated_ba_using_speedangle) as estimated_ba,
    count(batter) as PA
from
    DatabaseBatterEvents
group by
    batter,
    pitcher;

update
    CombinedEvents C
    inner join strippedPitchers P on
    C.pitcher = P.pitcher
set
    C.pitcher_name = P.pitcher_name
where C.pitcher_name is NULL;

UPDATE
    CombinedEvents
set
    actual_ba = AVG(babip_value)
from
    DatabaseBatterEvents
WHERE
    description = 'hit_into_play'
    group by batter,pitcher;

select avg(babip_value) as BA, pitcher, batter, count(batter) as PA from DatabaseBatterEvents where description = 'hit_into_play' group by batter, pitcher;