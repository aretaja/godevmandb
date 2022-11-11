-- name: GetSites :many
SELECT *
FROM sites
ORDER BY descr
LIMIT $1
OFFSET $2;

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
