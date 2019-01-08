SELECT COUNT(DISTINCT utm_campaign) AS 'Campaigns'
FROM page_visits;


SELECT COUNT(DISTINCT utm_source) AS 'Sources'
FROM page_visits;


SELECT DISTINCT utm_campaign, utm_source
FROM page_visits;


SELECT DISTINCT utm_campaign, COUNT(DISTINCT 	utm_source) AS 'Sources'
FROM page_visits
GROUP BY utm_campaign;


SELECT DISTINCT page_name
FROM page_visits;


WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign, 
    COUNT(*) AS 'first_touch_total'
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY 2;


WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign, 
    COUNT(*)
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY 2;


SELECT COUNT(DISTINCT user_id) AS ‘Purchasers'
FROM page_visits
WHERE page_name = '4 - purchase';


SELECT COUNT(DISTINCT user_id) AS 'Users'
FROM page_visits;


WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT pv.utm_campaign,
    COUNT(*) AS 'Purchases'
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY 2;

