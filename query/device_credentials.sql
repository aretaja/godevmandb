-- name: GetDeviceCredentials :many
SELECT *
FROM device_credentials
ORDER BY username;

-- name: GetDeviceCredential :one
SELECT *
FROM device_credentials
WHERE cred_id = $1;

-- name: CountDeviceCredentials :one
SELECT COUNT(*)
FROM device_credentials;

-- name: CreateDeviceCredential :one
INSERT INTO device_credentials (dev_id, username, enc_secret)
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateDeviceCredential :one
UPDATE device_credentials
SET dev_id = $2,
  username = $3,
  enc_secret = $4
WHERE cred_id = $1
RETURNING *;

-- name: DeleteDeviceCredential :exec
DELETE FROM device_credentials
WHERE cred_id = $1;

-- Foreign keys
-- name: GetDeviceCredentialDevice :one
SELECT t2.*
FROM device_credentials t1
  INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.cred_id = $1;
