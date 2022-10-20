-- name: GetCustomEntities :many
SELECT *
FROM custom_entities
ORDER BY label;

-- name: GetCustomEntity :one
SELECT *
FROM custom_entities
WHERE cent_id = $1;

-- name: CountCustomEntities :one
SELECT COUNT(*)
FROM custom_entities;

-- name: CreateCustomEntity :one
INSERT INTO custom_entities (manufacturer, serial_nr, part, descr)
VALUES ($1, $2, $3, $4)
RETURNING *;

-- name: UpdateCustomEntity :one
UPDATE custom_entities
SET manufacturer = $2,
  serial_nr = $3,
  part = $4,
  descr = $5
WHERE cent_id = $1
RETURNING *;

-- name: DeleteCustomEntity :exec
DELETE FROM custom_entities
WHERE cent_id = $1;
