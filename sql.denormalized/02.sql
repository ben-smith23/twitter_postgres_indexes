WITH hashtag_expansions AS (
    SELECT 
        data->>'id' AS id_tweets,
        LOWER('#' || jsonb->>'text') AS tag
    FROM tweets_jsonb, 
    jsonb_array_elements(
        COALESCE(data->'entities'->'hashtags', '[]') || 
        COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]')
    ) AS jsonb
),
coronavirus_tweets AS (
    SELECT DISTINCT id_tweets
    FROM hashtag_expansions
    WHERE tag = '#coronavirus'
)
SELECT
    e2.tag,
    COUNT(*) AS count
FROM coronavirus_tweets ct
JOIN hashtag_expansions e1 ON ct.id_tweets = e1.id_tweets
JOIN hashtag_expansions e2 ON e1.id_tweets = e2.id_tweets
WHERE e2.tag != '#coronavirus'
GROUP BY e2.tag
ORDER BY count DESC, e2.tag
LIMIT 1000;

