WITH player_totals AS (
    SELECT Player, SUM(rec_td3) as total_rec_td
    FROM (
        SELECT Player, rec_td3 FROM tbl_2020
        UNION ALL
        SELECT Player, rec_td3 FROM tbl_2021
        UNION ALL
        SELECT Player, rec_td3 FROM tbl_2022
    ) AS combined
    GROUP BY Player
)
SELECT 
    pt.Player,
    SUM(CASE WHEN year = 2020 THEN rec_td3 ELSE 0 END) AS rec_td_2020,
    SUM(CASE WHEN year = 2021 THEN rec_td3 ELSE 0 END) AS rec_td_2021,
    SUM(CASE WHEN year = 2022 THEN rec_td3 ELSE 0 END) AS rec_td_2022,
    pt.total_rec_td
FROM (
    SELECT Player, rec_td3, 2020 AS year FROM tbl_2020
    UNION ALL
    SELECT Player, rec_td3, 2021 AS year FROM tbl_2021
    UNION ALL
    SELECT Player, rec_td3, 2022 AS year FROM tbl_2022
) AS combined
JOIN player_totals pt ON combined.Player = pt.Player
GROUP BY pt.Player, pt.total_rec_td
ORDER BY pt.total_rec_td DESC
LIMIT 5;




