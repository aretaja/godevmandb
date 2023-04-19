-- name: GetConClasses :many
SELECT *
FROM con_classes
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

-- name: GetConClass :one
SELECT *
FROM con_classes
WHERE con_class_id = $1;

-- name: CountConClasses :one
SELECT COUNT(*)
FROM con_classes;

-- name: CreateConClass :one
INSERT INTO con_classes (descr, notes)
VALUES ($1, $2)
RETURNING *;

-- name: UpdateConClass :one
UPDATE con_classes
SET descr = $2,
  notes = $3
WHERE con_class_id = $1
RETURNING *;

-- name: DeleteConClass :exec
DELETE FROM con_classes
WHERE con_class_id = $1;

-- Relations
-- name: GetConClassConnections :many
SELECT *
FROM connections
WHERE con_class_id = $1;
