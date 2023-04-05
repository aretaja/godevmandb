-- name: GetDeviceExtensions :many
SELECT *
FROM device_extensions
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
    @field_f::text = ''
    OR (@field_f = 'isempty' AND field = '')
    OR field ILIKE @field_f
  )
  AND (
    sqlc.narg('content_f')::text IS NULL
    OR (sqlc.narg('content_f')::text = 'isnull' AND content IS NULL)
    OR (sqlc.narg('content_f')::text = 'isempty' AND content = '')
    OR content ILIKE sqlc.narg('content_f')
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

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
