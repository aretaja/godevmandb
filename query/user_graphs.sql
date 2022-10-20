-- name: GetUserGraphs :many
SELECT *
FROM user_graphs
ORDER BY username;

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
