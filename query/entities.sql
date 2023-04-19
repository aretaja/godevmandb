-- name: GetEntities :many
SELECT *
FROM entities
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
    sqlc.narg('snmp_ent_id_f')::text IS NULL
    OR (sqlc.narg('snmp_ent_id_f')::text = 'isnull' AND snmp_ent_id IS NULL)
    OR snmp_ent_id = sqlc.narg('snmp_ent_id_f')
  )
  AND (
    sqlc.narg('slot_f')::text IS NULL
    OR (sqlc.narg('slot_f')::text = 'isnull' AND slot IS NULL)
    OR (sqlc.narg('slot_f')::text = 'isempty' AND slot = '')
    OR slot ILIKE sqlc.narg('slot_f')
  )
  AND (
    sqlc.narg('descr_f')::text IS NULL
    OR (sqlc.narg('descr_f')::text = 'isnull' AND descr IS NULL)
    OR (sqlc.narg('descr_f')::text = 'isempty' AND descr = '')
    OR descr ILIKE sqlc.narg('descr_f')
  )
  AND (
    sqlc.narg('model_f')::text IS NULL
    OR (sqlc.narg('model_f')::text = 'isnull' AND model IS NULL)
    OR (sqlc.narg('model_f')::text = 'isempty' AND model = '')
    OR model ILIKE sqlc.narg('model_f')
  )
  AND (
    sqlc.narg('hw_product_f')::text IS NULL
    OR (sqlc.narg('hw_product_f')::text = 'isnull' AND hw_product IS NULL)
    OR (sqlc.narg('hw_product_f')::text = 'isempty' AND hw_product = '')
    OR hw_product ILIKE sqlc.narg('hw_product_f')
  )
  AND (
    sqlc.narg('hw_revision_f')::text IS NULL
    OR (sqlc.narg('hw_revision_f')::text = 'isnull' AND hw_revision IS NULL)
    OR (sqlc.narg('hw_revision_f')::text = 'isempty' AND hw_revision = '')
    OR hw_revision ILIKE sqlc.narg('hw_revision_f')
  )
  AND (
    sqlc.narg('serial_nr_f')::text IS NULL
    OR (sqlc.narg('serial_nr_f')::text = 'isnull' AND serial_nr IS NULL)
    OR (sqlc.narg('serial_nr_f')::text = 'isempty' AND serial_nr = '')
    OR serial_nr ILIKE sqlc.narg('serial_nr_f')
  )
  AND (
    sqlc.narg('sw_product_f')::text IS NULL
    OR (sqlc.narg('sw_product_f')::text = 'isnull' AND sw_product IS NULL)
    OR (sqlc.narg('sw_product_f')::text = 'isempty' AND sw_product = '')
    OR sw_product ILIKE sqlc.narg('sw_product_f')
  )
  AND (
    sqlc.narg('sw_revision_f')::text IS NULL
    OR (sqlc.narg('sw_revision_f')::text = 'isnull' AND sw_revision IS NULL)
    OR (sqlc.narg('sw_revision_f')::text = 'isempty' AND sw_revision = '')
    OR sw_revision ILIKE sqlc.narg('sw_revision_f')
  )
  AND (
    sqlc.narg('manufacturer_f')::text IS NULL
    OR (sqlc.narg('manufacturer_f')::text = 'isnull' AND manufacturer IS NULL)
    OR (sqlc.narg('manufacturer_f')::text = 'isempty' AND manufacturer = '')
    OR manufacturer ILIKE sqlc.narg('manufacturer_f')
  )
  AND (
    @physical_f::text = ''
    OR (@physical_f::text = 'true' AND physical = true)
    OR (@physical_f::text = 'false' AND physical = false)
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

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
  INNER JOIN entities t2 ON t2.ent_id = t1.parent_ent_id
WHERE t1.ent_id = $1;

-- Relations
-- name: GetEntityChilds :many
SELECT t2.*
FROM entities t1
  INNER JOIN entities t2 ON t2.parent_ent_id = t1.ent_id
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
