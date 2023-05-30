WITH player_totals AS (
    SELECT Player, SUM(rush_td) as total_rush_td
    FROM (
        SELECT Player, rush_td FROM tbl_2020
        UNION ALL
        SELECT Player, rush_td FROM tbl_2021
        UNION ALL
        SELECT Player, rush_td FROM tbl_2022
    ) AS combined
    GROUP BY Player
)
SELECT 
    pt.Player,
    SUM(CASE WHEN year = 2020 THEN rush_td ELSE 0 END) AS rush_td_2020,
    SUM(CASE WHEN year = 2021 THEN rush_td ELSE 0 END) AS rush_td_2021,
    SUM(CASE WHEN year = 2022 THEN rush_td ELSE 0 END) AS rush_td_2022,
    pt.total_rush_td
FROM (
    SELECT Player, rush_td, 2020 AS year FROM tbl_2020
    UNION ALL
    SELECT Player, rush_td, 2021 AS year FROM tbl_2021
    UNION ALL
    SELECT Player, rush_td, 2022 AS year FROM tbl_2022
) AS combined
JOIN player_totals pt ON combined.Player = pt.Player
GROUP BY pt.Player, pt.total_rush_td
ORDER BY pt.total_rush_td DESC
LIMIT 5;



