-- name: GetDeviceTypes :many
SELECT *
FROM device_types
ORDER BY manufacturer, model
LIMIT $1
OFFSET $2;

-- name: GetDeviceType :one
SELECT *
FROM device_types
WHERE sys_id = $1;

-- name: CountDeviceTypes :one
SELECT COUNT(*)
FROM device_types;

-- name: CreateDeviceType :one
INSERT INTO device_types (
    sys_id,
    class_id,
    manufacturer,
    model,
    hc,
    snmp_ver
  )
VALUES ($1, $2, $3, $4, $5, $6)
RETURNING *;

-- name: UpdateDeviceType :one
UPDATE device_types
SET class_id = $2,
  manufacturer = $3,
  model = $4,
  hc = $5,
  snmp_ver = $6
WHERE sys_id = $1
RETURNING *;

-- name: DeleteDeviceType :exec
DELETE FROM device_types
WHERE sys_id = $1;

-- Foreign keys
-- name: GetDeviceTypeDeviceClass :one
SELECT t2.*
FROM device_types t1
  INNER JOIN device_classes t2 ON t2.class_id = t1.class_id
WHERE t1.sys_id = $1;

-- Relations
-- name: GetDeviceTypeDevices :many
SELECT *
FROM devices
WHERE sys_id = $1
ORDER BY host_name;
