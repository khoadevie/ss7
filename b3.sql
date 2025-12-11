CREATE TABLE post (
    post_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    tags TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_public BOOLEAN DEFAULT TRUE
);

CREATE TABLE post_like (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, post_id)
);

CREATE INDEX idx_post_content_lower ON post (LOWER(content));

EXPLAIN ANALYZE
SELECT * FROM post
WHERE is_public = TRUE AND content ILIKE '%fun%';

CREATE INDEX idx_post_tags_gin ON post USING GIN (tags);

EXPLAIN ANALYZE
SELECT * FROM post WHERE tags && ARRAY['travel'];

CREATE INDEX idx_post_recent_public
ON post(created_at)
WHERE is_public = TRUE;

EXPLAIN ANALYZE
SELECT * FROM post
WHERE is_public = TRUE
  AND created_at >= NOW() - INTERVAL '7 days';

CREATE INDEX idx_post_user_created_at_desc
ON post(user_id, created_at DESC);
