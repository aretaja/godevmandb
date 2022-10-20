-- name: GetDeviceLicenses :many
SELECT *
FROM device_licenses
ORDER BY dev_id,
  descr;

-- name: GetDeviceLicense :one
SELECT *
FROM device_licenses
WHERE lic_id = $1;

-- name: CountDeviceLicenses :one
SELECT COUNT(*)
FROM device_licenses;

-- name: CreateDeviceLicense :one
INSERT INTO device_licenses (
    dev_id,
    product,
    descr,
    installed,
    unlocked,
    tot_inst,
    used,
    condition
  )
VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
RETURNING *;

-- name: UpdateDeviceLicense :one
UPDATE device_licenses
SET dev_id = $2,
  product = $3,
  descr = $4,
  installed = $5,
  unlocked = $6,
  tot_inst = $7,
  used = $8,
  condition = $9
WHERE lic_id = $1
RETURNING *;

-- name: DeleteDeviceLicense :exec
DELETE FROM device_licenses
WHERE lic_id = $1;

-- Foreign keys
-- name: GetDeviceLicenseDevice :one
SELECT t2.*
FROM device_licenses t1
  INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.lic_id = $1;
