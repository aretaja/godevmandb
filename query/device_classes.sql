-- name: GetDeviceClasses :many
SELECT *
FROM device_classes
ORDER BY descr
LIMIT $1
OFFSET $2;

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
