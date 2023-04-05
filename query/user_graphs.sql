-- name: GetUserGraphs :many
SELECT *
FROM user_graphs
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
    @descr_f::text = ''
    OR descr = @descr_f
  )
  AND (
    @shared_f::text = ''
    OR (@shared_f::text = 'true' AND shared = true)
    OR (@shared_f::text = 'false' AND shared = false)
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetUserGraph :one
SELECT *
FROM user_graphs
WHERE graph_id = $1;

-- name: CountUserGraphs :one
SELECT COUNT(*)
FROM user_graphs;

-- name: CreateUserGraph :one
INSERT INTO user_graphs (username, uri, descr, shared)
VALUES ($1, $2, $3, $4)
RETURNING *;

-- name: UpdateUserGraph :one
UPDATE user_graphs
SET username = $2,
  uri = $3,
  descr = $4,
  shared = $5
WHERE graph_id = $1
RETURNING *;

-- name: DeleteUserGraph :exec
DELETE FROM user_graphs
WHERE graph_id = $1;

-- Foreign keys
-- name: GetUserGraphUser :one
SELECT t2.*
FROM user_graphs t1
  INNER JOIN users t2 ON t2.username = t1.username
WHERE t1.graph_id = $1;
