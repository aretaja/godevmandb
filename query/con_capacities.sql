-- name: GetConCapacities :many
SELECT *
FROM con_capacities
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
    @descr_f::text = ''
    OR descr LIKE @descr_f
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

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
-- name: GetConCapacityConnections :many
SELECT *
FROM connections
WHERE con_cap_id = $1;
