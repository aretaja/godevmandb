-- name: GetConCapacities :many
SELECT *
FROM con_capacities
ORDER BY descr;

-- name: GetConCapacity :one
SELECT *
FROM con_capacities
WHERE con_cap_id = $1;

-- name: CountConCapacities :one
SELECT COUNT(*)
FROM con_capacities;

-- name: CreateConCapacity :one
INSERT INTO con_capacities (descr, notes)
VALUES ($1, $2)
RETURNING *;

-- name: UpdateConCapacity :one
UPDATE con_capacities
SET descr = $2,
  notes = $3
WHERE con_cap_id = $1
RETURNING *;

-- name: DeleteConCapacity :exec
DELETE FROM con_capacities
WHERE con_cap_id = $1;

-- Relations
-- name: GetConCapacitiyConnections :many
SELECT *
FROM connections
WHERE con_cap_id = $1;
