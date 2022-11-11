-- name: GetEntities :many
SELECT *
FROM entities
ORDER BY ent_id
LIMIT $1
OFFSET $2;

-- name: GetEntity :one
SELECT *
FROM entities
WHERE ent_id = $1;

-- name: CountEntities :one
SELECT COUNT(*)
FROM entities;

-- name: CreateEntity :one
INSERT INTO entities (
    parent_ent_id,
    snmp_ent_id,
    dev_id,
    slot,
    descr,
    model,
    hw_product,
    hw_revision,
    serial_nr,
    sw_product,
    sw_revision,
    manufacturer,
    physical
  )
VALUES (
    $1,
    $2,
    $3,
    $4,
    $5,
    $6,
    $7,
    $8,
    $9,
    $10,
    $11,
    $12,
    $13
  )
RETURNING *;

-- name: UpdateEntity :one
UPDATE entities
SET parent_ent_id = $2,
  snmp_ent_id = $3,
  dev_id = $4,
  slot = $5,
  descr = $6,
  model = $7,
  hw_product = $8,
  hw_revision = $9,
  serial_nr = $10,
  sw_product = $11,
  sw_revision = $12,
  manufacturer = $13,
  physical = $14
WHERE ent_id = $1
RETURNING *;

-- name: DeleteEntity :exec
DELETE FROM entities
WHERE ent_id = $1;

-- Foreign keys
-- name: GetEntityDevice :one
SELECT t2.*
FROM entities t1
  INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.ent_id = $1;

-- Foreign keys
-- name: GetEntityParent :one
SELECT t2.*
FROM entities t1
  INNER JOIN entities t2 ON t2.ent_id = t1.parent
WHERE t1.ent_id = $1;

-- Relations
-- name: GetEntityEntityPhyIndexes :many
SELECT *
FROM entity_phy_indexes
WHERE ent_id = $1
ORDER BY descr;

-- Relations
-- name: GetEntityInterfaces :many
SELECT *
FROM interfaces
WHERE ent_id = $1
ORDER BY ifindex;

-- Relations
-- name: GetEntityRlfNbrs :many
SELECT t2.*
FROM entities t1
  INNER JOIN rl_nbrs t2 ON t2.nbr_ent_id = t1.ent_id
WHERE t1.ent_id = $1
ORDER BY nbr_sysname;
