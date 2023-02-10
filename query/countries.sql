-- name: GetCountries :many
SELECT *
FROM countries
WHERE (
    @updated_ge::TIMESTAMPTZ = '0001-01-01 00:00:00+00'
    OR updated_on >= @updated_ge
  )
  AND (
    @updated_le::TIMESTAMPTZ = '0001-01-01 00:00:00+00'
    OR updated_on <= @updated_le
  )
  AND (
    @created_ge::TIMESTAMPTZ = '0001-01-01 00:00:00+00'
    OR created_on >= @created_ge
  )
  AND (
    @created_le::TIMESTAMPTZ = '0001-01-01 00:00:00+00'
    OR created_on <= @created_le
  )
  AND (
    @descr_f::text = ''
    OR descr ILIKE @descr_f
  )
  AND (
    @code_f::text = ''
    OR code ILIKE @code_f
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

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
