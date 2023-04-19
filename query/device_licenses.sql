-- name: GetDeviceLicenses :many
SELECT *
FROM device_licenses
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
    @created_ge::TIMESTAMPTZ = '0001-01-01 00:00:00+00'
    OR created_on >= @created_ge
  )
  AND (
    sqlc.narg('installed_le')::text IS NULL
    OR (sqlc.narg('installed_le')::text = 'isnull' AND installed IS NULL)
    OR installed <= CAST(sqlc.narg('installed_le') AS integer)
  )
  AND (
    sqlc.narg('installed_ge')::text IS NULL
    OR (sqlc.narg('installed_ge')::text = 'isnull' AND installed IS NULL)
    OR installed >= CAST(sqlc.narg('installed_ge') AS integer)
  )
  AND (
    sqlc.narg('unlocked_le')::text IS NULL
    OR (sqlc.narg('unlocked_le')::text = 'isnull' AND unlocked IS NULL)
    OR unlocked <= CAST(sqlc.narg('unlocked_le') AS integer)
  )
  AND (
    sqlc.narg('unlocked_ge')::text IS NULL
    OR (sqlc.narg('unlocked_ge')::text = 'isnull' AND unlocked IS NULL)
    OR unlocked >= CAST(sqlc.narg('unlocked_ge') AS integer)
  )
  AND (
    sqlc.narg('tot_inst_le')::text IS NULL
    OR (sqlc.narg('tot_inst_le')::text = 'isnull' AND tot_inst IS NULL)
    OR tot_inst <= CAST(sqlc.narg('tot_inst_le') AS integer)
  )
  AND (
    sqlc.narg('tot_inst_ge')::text IS NULL
    OR (sqlc.narg('tot_inst_ge')::text = 'isnull' AND tot_inst IS NULL)
    OR tot_inst >= CAST(sqlc.narg('tot_inst_ge') AS integer)
  )
  AND (
    sqlc.narg('used_le')::text IS NULL
    OR (sqlc.narg('used_le')::text = 'isnull' AND used IS NULL)
    OR used <= CAST(sqlc.narg('used_le') AS integer)
  )
  AND (
    sqlc.narg('used_ge')::text IS NULL
    OR (sqlc.narg('used_ge')::text = 'isnull' AND used IS NULL)
    OR used >= CAST(sqlc.narg('used_ge') AS integer)
  )
  AND (
    sqlc.narg('product_f')::text IS NULL
    OR (sqlc.narg('product_f')::text = 'isnull' AND product IS NULL)
    OR (sqlc.narg('product_f')::text = 'isempty' AND product = '')
    OR product ILIKE sqlc.narg('product_f')
  )
  AND (
    sqlc.narg('descr_f')::text IS NULL
    OR (sqlc.narg('descr_f')::text = 'isnull' AND descr IS NULL)
    OR (sqlc.narg('descr_f')::text = 'isempty' AND descr = '')
    OR descr ILIKE sqlc.narg('descr_f')
  )
  AND (
    sqlc.narg('condition_f')::text IS NULL
    OR (sqlc.narg('condition_f')::text = 'isnull' AND condition IS NULL)
    OR (sqlc.narg('condition_f')::text = 'isempty' AND condition = '')
    OR condition ILIKE sqlc.narg('condition_f')
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

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
