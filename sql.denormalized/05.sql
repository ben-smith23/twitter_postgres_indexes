WITH filtered_tweets AS (
    SELECT
        data->>'id' AS id_tweets,
        LOWER(data->>'lang') AS lang,
        COALESCE(data->'extended_tweet'->>'full_text', data->>'text') AS text
    FROM tweets_jsonb
    WHERE LOWER(data->>'lang') = 'en'
      AND to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')) @@ to_tsquery('english','coronavirus')
), hashtags_expanded AS (
    SELECT
        ft.id_tweets,
        LOWER('#' || jsonb->>'text') AS tag
    FROM filtered_tweets ft, 
    jsonb_array_elements(
        COALESCE(ft.data->'entities'->'hashtags', '[]') ||
        COALESCE(ft.data->'extended_tweet'->'entities'->'hashtags', '[]')
    ) AS jsonb
)
SELECT
    tag,
    COUNT(*) AS count
FROM hashtags_expanded
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;

