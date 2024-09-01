CREATE TABLE movies
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

INSERT INTO movies (name)
SELECT 'movie_' || s::text
FROM generate_series(1, 100000) AS s;