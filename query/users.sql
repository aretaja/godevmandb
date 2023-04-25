-- name: GetUsers :many
SELECT *
FROM users
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
    @username_f::text = ''
    OR username = @username_f
  )
  AND (
    @userlevel_le::text = ''
    OR userlevel <= CAST(@userlevel_le AS integer)
  )
  AND (
    @userlevel_ge::text = ''
    OR userlevel >= CAST(@userlevel_ge AS integer)
  )
  AND (
    sqlc.narg('notes_f')::text IS NULL
    OR (sqlc.narg('notes_f')::text = 'isnull' AND notes IS NULL)
    OR (sqlc.narg('notes_f')::text = 'isempty' AND notes = '')
    OR notes ILIKE sqlc.narg('notes_f')
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetUser :one
SELECT *
FROM users
WHERE username = $1;

-- name: CountUsers :one
SELECT COUNT(*)
FROM users;

-- name: CreateUser :one
INSERT INTO users (username, userlevel, notes)
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateUser :one
UPDATE users
SET userlevel = $2,
    notes = $3
WHERE username = $1
RETURNING *;

-- name: DeleteUser :exec
DELETE FROM users
WHERE username = $1;

-- Relations
-- name: GetUserUserAuthzs :many
SELECT *
FROM user_authzs
WHERE username = $1
ORDER BY username;

-- Relations
-- name: GetUserUserGraphs :many
SELECT *
FROM user_graphs
WHERE username = $1
ORDER BY username;
