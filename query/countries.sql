-- name: GetCountries :many
SELECT *
FROM countries
ORDER BY descr
LIMIT $1
OFFSET $2;

-- name: GetCountry :one
SELECT *
FROM countries
WHERE country_id = $1;

-- name: CountCountries :one
SELECT COUNT(*)
FROM countries;

-- name: CreateCountry :one
INSERT INTO countries (code, descr)
VALUES ($1, $2)
RETURNING *;

-- name: UpdateCountry :one
UPDATE countries
SET code = $2,
  descr = $3
WHERE country_id = $1
RETURNING *;

-- name: DeleteCountry :exec
DELETE FROM countries
WHERE country_id = $1;

-- Relations
-- name: GetCountrySites :many
SELECT *
FROM sites
WHERE country_id = $1
ORDER BY descr;
