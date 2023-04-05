-- name: GetCustomEntities :many
SELECT *
FROM custom_entities
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
    @manufacturer_f::text = ''
    OR (@manufacturer_f = 'isempty' AND manufacturer = '')
    OR manufacturer ILIKE @manufacturer_f
  )
  AND (
    @serial_nr_f::text = ''
    OR (@serial_nr_f = 'isempty' AND serial_nr = '')
    OR serial_nr ILIKE @serial_nr_f
  )
  AND (
    sqlc.narg('part_f')::text IS NULL
    OR (sqlc.narg('part_f')::text = 'isnull' AND part IS NULL)
    OR (sqlc.narg('part_f')::text = 'isempty' AND part = '')
    OR part ILIKE sqlc.narg('part_f')
  )
  AND (
    sqlc.narg('descr_f')::text IS NULL
    OR (sqlc.narg('descr_f')::text = 'isnull' AND descr IS NULL)
    OR (sqlc.narg('descr_f')::text = 'isempty' AND descr = '')
    OR descr ILIKE sqlc.narg('descr_f')
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

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
