-- name: GetDeviceStates :many
SELECT *
FROM device_states
ORDER BY updated_on;

-- name: GetDeviceState :one
SELECT *
FROM device_states
WHERE dev_id = $1;

-- name: CountDeviceStates :one
SELECT COUNT(*)
FROM device_states;

-- name: CreateDeviceState :one
INSERT INTO device_states (dev_id, up_time, down_time, method)
VALUES ($1, $2, $3, $4)
RETURNING *;

-- name: UpdateDeviceState :one
UPDATE device_states
SET up_time = $2,
  down_time = $3,
  method = $4
WHERE dev_id = $1
RETURNING *;

-- name: DeleteDeviceState :exec
DELETE FROM device_states
WHERE dev_id = $1;

-- Foreign keys
-- name: GetDeviceStateDevice :one
SELECT t2.*
FROM device_states t1
  INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.dev_id = $1;
