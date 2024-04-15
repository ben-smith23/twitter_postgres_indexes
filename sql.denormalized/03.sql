SELECT
    LOWER(data->>'lang') AS lang,
    COUNT(DISTINCT data->>'id') AS count
FROM tweets_jsonb, 
     jsonb_array_elements(
         COALESCE(data->'entities'->'hashtags', '[]') || 
         COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]')
     ) AS hashtags
WHERE LOWER(hashtags->>'text') = 'coronavirus'
GROUP BY lang
ORDER BY count DESC, lang;

