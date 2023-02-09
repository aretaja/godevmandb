-- name: GetDeviceClasses :many
SELECT *
FROM device_classes
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


-- name: GetDeviceClass :one
SELECT *
FROM device_classes
WHERE class_id = $1;

-- name: CountDeviceClasses :one
SELECT COUNT(*)
FROM device_classes;

-- name: CreateDeviceClass :one
INSERT INTO device_classes (descr)
VALUES ($1)
RETURNING *;

-- name: UpdateDeviceClass :one
UPDATE device_classes
SET descr = $2
WHERE class_id = $1
RETURNING *;

-- name: DeleteDeviceClass :exec
DELETE FROM device_classes
WHERE class_id = $1;

-- Relations
-- name: GetDeviceClassDeviceTypes :many
SELECT *
FROM device_types
WHERE class_id = $1
ORDER BY manufacturer,
  model;
