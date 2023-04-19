-- name: GetEntityPhyIndexes :many
SELECT *
FROM entity_phy_indexes
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
    @phy_index_f::text = ''
    OR phy_index = @phy_index_f
  )
  AND (
    @descr_f::text = ''
    OR descr ILIKE @descr_f
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetEntityPhyIndex :one
SELECT *
FROM entity_phy_indexes
WHERE ei_id = $1;

-- name: CountEntityPhyIndexes :one
SELECT COUNT(*)
FROM entity_phy_indexes;

-- name: CreateEntityPhyIndex :one
INSERT INTO entity_phy_indexes (ent_id, phy_index, descr)
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateEntityPhyIndex :one
UPDATE entity_phy_indexes
SET ent_id = $2,
  phy_index = $3,
  descr = $4
WHERE ei_id = $1
RETURNING *;

-- name: DeleteEntityPhyIndex :exec
DELETE FROM entity_phy_indexes
WHERE ei_id = $1;

-- Foreign keys
-- name: GetEntityPhyIndexEntity :one
SELECT t2.*
FROM entity_phy_indexes t1
  INNER JOIN entities t2 ON t2.ent_id = t1.ent_id
WHERE t1.ei_id = $1;
