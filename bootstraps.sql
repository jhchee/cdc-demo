CREATE TABLE movies
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT INTO movies (name)
SELECT 'movie_' || s::text
FROM generate_series(1, 1000) AS s;

ALTER TABLE movies ADD COLUMN metadata JSONB;

INSERT INTO movies (name, metadata)
SELECT 'movie_' || s::text, '{"year": 2020, "rating": 5}'::jsonb
FROM generate_series(1, 1000) AS s;