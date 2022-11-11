-- name: GetDeviceExtensions :many
SELECT *
FROM device_extensions
ORDER BY dev_id, field
LIMIT $1
OFFSET $2;

-- name: GetDeviceExtension :one
SELECT *
FROM device_extensions
WHERE ext_id = $1;

-- name: CountDeviceExtensions :one
SELECT COUNT(*)
FROM device_extensions;

-- name: CreateDeviceExtension :one
INSERT INTO device_extensions (dev_id, field, content)
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateDeviceExtension :one
UPDATE device_extensions
SET dev_id = $2,
  field = $3,
  content = $4
WHERE ext_id = $1
RETURNING *;

-- name: DeleteDeviceExtension :exec
DELETE FROM device_extensions
WHERE ext_id = $1;

-- Foreign keys
-- name: GetDeviceExtensionDevice :one
SELECT t2.*
FROM device_extensions t1
  INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.ext_id = $1;
