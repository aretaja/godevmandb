-- name: GetConTypes :many
SELECT *
FROM con_types
ORDER BY descr
LIMIT $1
OFFSET $2;

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
