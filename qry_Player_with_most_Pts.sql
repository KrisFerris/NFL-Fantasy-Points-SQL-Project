WITH player_totals AS (
    SELECT Player, SUM(Pts) as total_pts
    FROM (
        SELECT Player, Pts FROM tbl_2020
        UNION ALL
        SELECT Player, Pts FROM tbl_2021
        UNION ALL
        SELECT Player, Pts FROM tbl_2022
    ) AS combined
    GROUP BY Player
)
SELECT 
    pt.Player,
    SUM(CASE WHEN year = 2020 THEN Pts ELSE 0 END) AS Pts_2020,
    SUM(CASE WHEN year = 2021 THEN Pts ELSE 0 END) AS Pts_2021,
    SUM(CASE WHEN year = 2022 THEN Pts ELSE 0 END) AS Pts_2022,
    pt.total_pts
FROM (
    SELECT Player, Pts, 2020 AS year FROM tbl_2020
    UNION ALL
    SELECT Player, Pts, 2021 AS year FROM tbl_2021
    UNION ALL
    SELECT Player, Pts, 2022 AS year FROM tbl_2022
) AS combined
JOIN player_totals pt ON combined.Player = pt.Player
GROUP BY pt.Player, pt.total_pts
ORDER BY pt.total_pts DESC
LIMIT 5;


