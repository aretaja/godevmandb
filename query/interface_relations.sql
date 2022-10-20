-- name: GetInterfaceRelations :many
SELECT *
FROM interface_relations;

-- name: GetInterfaceRelation :one
SELECT *
FROM interface_relations
WHERE ir_id = $1;

-- name: CountInterfaceRelations :one
SELECT COUNT(*)
FROM interface_relations;

-- name: CreateInterfaceRelation :one
INSERT INTO interface_relations (if_id, if_id_up, if_id_down)
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateInterfaceRelation :one
UPDATE interface_relations
SET if_id = $2,
  if_id_up = $3,
  if_id_down = $4
WHERE ir_id = $1
RETURNING *;

-- name: DeleteInterfaceRelation :exec
DELETE FROM interface_relations
WHERE ir_id = $1;

-- Foreign keys
-- name: GetInterfaceRelationInterface :one
SELECT t2.*
FROM interface_relations t1
  INNER JOIN interfaces t2 ON t2.if_id = t1.if_id
WHERE t1.ir_id = $1;

-- Foreign keys
-- name: GetInterfaceRelationInterfaceUp :one
SELECT t2.*
FROM interface_relations t1
  INNER JOIN interfaces t2 ON t2.if_id = t1.if_id_up
WHERE t1.ir_id = $1;

-- Foreign keys
-- name: GetInterfaceRelationInterfaceDown :one
SELECT t2.*
FROM interface_relations t1
  INNER JOIN interfaces t2 ON t2.if_id = t1.if_id_down
WHERE t1.ir_id = $1;
