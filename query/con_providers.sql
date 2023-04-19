-- name: GetConProviders :many
SELECT *
FROM con_providers
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
    OR (@descr_f = 'isempty' AND descr = '')
    OR descr ILIKE @descr_f
  )
  AND (
    sqlc.narg('notes_f')::text IS NULL
    OR (sqlc.narg('notes_f')::text = 'isnull' AND notes IS NULL)
    OR (sqlc.narg('notes_f')::text = 'isempty' AND notes = '')
    OR notes ILIKE sqlc.narg('notes_f')
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetConProvider :one
SELECT *
FROM con_providers
WHERE con_prov_id = $1;

-- name: CountConProviders :one
SELECT COUNT(*)
FROM con_providers;

-- name: CreateConProvider :one
INSERT INTO con_providers (descr, notes)
VALUES ($1, $2)
RETURNING *;

-- name: UpdateConProvider :one
UPDATE con_providers
SET descr = $2,
  notes = $3
WHERE con_prov_id = $1
RETURNING *;

-- name: DeleteConProvider :exec
DELETE FROM con_providers
WHERE con_prov_id = $1;

-- Relations
-- name: GetConProviderConnections :many
SELECT *
FROM connections
WHERE con_prov_id = $1;
