-- name: GetConProviders :many
SELECT *
FROM con_providers
ORDER BY descr
LIMIT $1
OFFSET $2;

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
