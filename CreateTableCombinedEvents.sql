Create TABLE CombinedEvents(
    pitcher int,
    pitcher_name text,
    batter int,
    batter_name text,
    estimated_ba DOUBLE,
    actual_ba DOUBLE,
    PA INT,
    AB INT,
    Hits INT
)
select
    pitcher,
    batter,
    player_name as batter_name,
    avg(estimated_ba_using_speedangle) as estimated_ba,
    count(batter) as PA,
    sum(babip_value) as Hits
from
    DatabaseBatterEvents
group by
    batter,
    pitcher;

Update CombinedEvents c
	Inner JOIN(
select batter, pitcher, count(batter) as AB from DatabaseBatterEvents 
where description = 'hit_into_play' OR description = 'swinging_strike' OR description = 'swinging_strike_blocked' OR description = 'called_strike' or description = 'foul_tip'
group by batter, pitcher) b
	on c.batter = b.batter and c.pitcher = b.pitcher
Set c.AB = b.AB;

update
    CombinedEvents C
    inner join MLBIDs ID on
    C.pitcher = ID.player
set
    C.pitcher_name = P.PlayerName
where C.pitcher_name is NULL;

update CombinedEvents set actual_ba = Hits/AB;