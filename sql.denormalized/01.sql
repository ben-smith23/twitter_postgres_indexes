SELECT count(DISTINCT data->>'id') AS tweet_count
FROM tweets_jsonb, 
     jsonb_array_elements(
         COALESCE(data->'entities'->'hashtags', '[]') || 
         COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]')
     ) AS hashtags
WHERE hashtags->>'text' = 'coronavirus';

