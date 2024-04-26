SET maintenance_work_mem = '16GB';
SET max_parallel_maintenance_workers = 80;

--CREATE INDEX tweets_full_text_idx ON public.tweets_jsonb USING gin (to_tsvector('english'::regconfig, COALESCE(((data -> 'extended_tweet'::text) ->> 'full_text'::text), (data ->> 'text'::text)
--CREATE INDEX idx_jsonb_hashtags ON public.tweets_jsonb USING gin ((((data -> 'entities'::text) -> 'hashtags'::text)))
--CREATE INDEX tweets_jsonb_expr_idx1 ON public.tweets_jsonb USING gin (((((data -> 'extended_tweet'::text) -> 'entities'::text) -> 'hashtags'::text)))

CREATE INDEX ON tweet_tags (tag, id_tweets);
CREATE INDEX ON tweets USING GIN (to_tsvector('english', text));
CREATE INDEX ON tweets (lang);
CREATE INDEX ON tweets (id_tweets, lang);
