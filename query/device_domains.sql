-- name: GetDeviceDomains :many
SELECT *
FROM device_domains
ORDER BY descr;

-- name: GetDeviceDomain :one
SELECT *
FROM device_domains
WHERE dom_id = $1;

-- name: CountDeviceDomains :one
SELECT COUNT(*)
FROM device_domains;

-- name: CreateDeviceDomain :one
INSERT INTO device_domains (descr)
VALUES ($1)
RETURNING *;

-- name: UpdateDeviceDomain :one
UPDATE device_domains
SET descr = $2
WHERE dom_id = $1
RETURNING *;

-- name: DeleteDeviceDomain :exec
DELETE FROM device_domains
WHERE dom_id = $1;

-- Relations
-- name: GetDeviceDomainDevices :many
SELECT *
FROM devices
WHERE dom_id = $1
ORDER BY host_name;

-- name: GetDeviceDomainUserAuthzs :many
SELECT *
FROM user_authzs
WHERE dom_id = $1
ORDER BY username;
