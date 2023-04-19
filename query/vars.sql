-- name: GetVars :many
SELECT *
FROM vars
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
    sqlc.narg('content_f')::text IS NULL
    OR (sqlc.narg('content_f')::text = 'isnull' AND content IS NULL)
    OR (sqlc.narg('content_f')::text = 'isempty' AND content = '')
    OR content ILIKE sqlc.narg('content_f')
  )
  AND (
    sqlc.narg('notes_f')::text IS NULL
    OR (sqlc.narg('notes_f')::text = 'isnull' AND notes IS NULL)
    OR (sqlc.narg('notes_f')::text = 'isempty' AND notes = '')
    OR notes ILIKE sqlc.narg('notes_f')
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetVar :one
SELECT *
FROM vars
WHERE descr = $1;

-- name: CountVars :one
SELECT COUNT(*)
FROM vars;

-- name: CreateVar :one
INSERT INTO vars (descr, content, notes)
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateVar :one
UPDATE vars
SET content = $2,
    notes = $3
WHERE descr = $1
RETURNING *;

-- name: DeleteVar :exec
DELETE FROM vars
WHERE descr = $1;
