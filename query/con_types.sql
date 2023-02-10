-- name: GetConTypes :many
SELECT *
FROM con_types
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
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetConType :one
SELECT *
FROM con_types
WHERE con_type_id = $1;

-- name: CountConTypes :one
SELECT COUNT(*)
FROM con_types;

-- name: CreateConType :one
INSERT INTO con_types (descr, notes)
VALUES ($1, $2)
RETURNING *;

-- name: UpdateConType :one
UPDATE con_types
SET descr = $2,
  notes = $3
WHERE con_type_id = $1
RETURNING *;

-- name: DeleteConType :exec
DELETE FROM con_types
WHERE con_type_id = $1;

-- Relations
-- name: GetConTypeConnections :many
SELECT *
FROM connections
WHERE con_type_id = $1;
