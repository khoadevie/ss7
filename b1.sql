CREATE TABLE book (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(10,2),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_book_author_lower ON book (LOWER(author));
CREATE INDEX idx_book_genre ON book (genre);
CREATE INDEX idx_book_genre_btree ON book USING BTREE (genre);
CREATE INDEX idx_book_fulltext_gin ON book USING GIN (to_tsvector('english', title || ' ' || description));
CREATE INDEX idx_book_genre_cluster ON book (genre);
CLUSTER book USING idx_book_genre_cluster;

EXPLAIN ANALYZE SELECT * FROM book WHERE author ILIKE '%rowling%';
EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';
