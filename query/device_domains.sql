-- name: GetDeviceDomains :many
SELECT *
FROM device_domains
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
    OR descr ILIKE @descr_f
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

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
