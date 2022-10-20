-- name: GetConClasses :many
SELECT *
FROM con_classes
ORDER BY descr;

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
