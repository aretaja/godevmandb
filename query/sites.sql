-- name: GetSites :many
SELECT *
FROM sites
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
    sqlc.narg('uident_f')::text IS NULL
    OR (sqlc.narg('uident_f')::text = 'isnull' AND uident IS NULL)
    OR (sqlc.narg('uident_f')::text = 'isempty' AND uident = '')
    OR uident ILIKE sqlc.narg('uident_f')
  )
  AND (
    @descr_f::text = ''
    OR (@descr_f = 'isempty' AND descr = '')
    OR descr ILIKE @descr_f
  )
  AND (
    sqlc.narg('area_f')::text IS NULL
    OR (sqlc.narg('area_f')::text = 'isnull' AND area IS NULL)
    OR (sqlc.narg('area_f')::text = 'isempty' AND area = '')
    OR area ILIKE sqlc.narg('area_f')
  )
  AND (
    sqlc.narg('addr_f')::text IS NULL
    OR (sqlc.narg('addr_f')::text = 'isnull' AND addr IS NULL)
    OR (sqlc.narg('addr_f')::text = 'isempty' AND addr = '')
    OR addr ILIKE sqlc.narg('addr_f')
  )
  AND (
    sqlc.narg('notes_f')::text IS NULL
    OR (sqlc.narg('notes_f')::text = 'isnull' AND notes IS NULL)
    OR (sqlc.narg('notes_f')::text = 'isempty' AND notes = '')
    OR notes ILIKE sqlc.narg('notes_f')
  )
  AND (
    sqlc.narg('ext_name_f')::text IS NULL
    OR (sqlc.narg('ext_name_f')::text = 'isnull' AND ext_name IS NULL)
    OR (sqlc.narg('ext_name_f')::text = 'isempty' AND ext_name = '')
    OR ext_name ILIKE sqlc.narg('ext_name_f')
  )
  AND (
    sqlc.narg('ext_id_f')::text IS NULL
    OR (sqlc.narg('ext_id_f')::text = 'isnull' AND ext_id IS NULL)
    OR (sqlc.narg('ext_id_f')::text = 'isempty' AND CAST(ext_id AS text) = '')
    OR CAST(ext_id AS text) LIKE sqlc.narg('ext_id_f')
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetSite :one
SELECT *
FROM sites
WHERE site_id = $1;

-- name: CountSites :one
SELECT COUNT(*)
FROM sites;

-- name: CreateSite :one
INSERT INTO sites (
    country_id,
    uident,
    descr,
    latitude,
    longitude,
    area,
    addr,
    notes,
    ext_id,
    ext_name
  )
VALUES (
    $1,
    $2,
    $3,
    $4,
    $5,
    $6,
    $7,
    $8,
    $9,
    $10
  )
RETURNING *;

-- name: UpdateSite :one
UPDATE sites
SET country_id = $2,
  uident = $3,
  descr = $4,
  latitude = $5,
  longitude = $6,
  area = $7,
  addr = $8,
  notes = $9,
  ext_id = $10,
  ext_name = $11
WHERE site_id = $1
RETURNING *;

-- name: DeleteSite :exec
DELETE FROM sites
WHERE site_id = $1;

-- Foreign keys
-- name: GetSiteCountry :one
SELECT t2.*
FROM sites t1
  INNER JOIN countries t2 ON t2.country_id = t1.country_id
WHERE t1.site_id = $1;

-- Relations
-- name: GetSiteConnections :many
SELECT *
FROM connections
WHERE site_id = $1;

-- Relations
-- name: GetSiteDevices :many
SELECT *
FROM devices
WHERE site_id = $1
ORDER BY host_name;
