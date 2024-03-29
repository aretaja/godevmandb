-- name: GetConnections :many
SELECT *
FROM connections
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
    sqlc.narg('hint_f')::text IS NULL
    OR (sqlc.narg('hint_f')::text = 'isnull' AND hint IS NULL)
    OR (sqlc.narg('hint_f')::text = 'isempty' AND hint = '')
    OR hint ILIKE sqlc.narg('hint_f')
  )
  AND (
    sqlc.narg('notes_f')::text IS NULL
    OR (sqlc.narg('notes_f')::text = 'isnull' AND notes IS NULL)
    OR (sqlc.narg('notes_f')::text = 'isempty' AND notes = '')
    OR notes ILIKE sqlc.narg('notes_f')
  )
  AND (
    @in_use_f::text = ''
    OR (@in_use_f::text = 'true' AND in_use = true)
    OR (@in_use_f::text = 'false' AND in_use = false)
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetConnection :one
SELECT *
FROM connections
WHERE con_id = $1;

-- name: CountConnections :one
SELECT COUNT(*)
FROM connections;

-- name: CreateConnection :one
INSERT INTO connections (
    site_id,
    con_prov_id,
    con_type_id,
    con_cap_id,
    con_class_id,
    hint,
    notes,
    in_use
  )
VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
RETURNING *;

-- name: UpdateConnection :one
UPDATE connections
SET site_id = $2,
  con_prov_id = $3,
  con_type_id = $4,
  con_cap_id = $5,
  con_class_id = $6,
  hint = $7,
  notes = $8,
  in_use = $9
WHERE con_id = $1
RETURNING *;

-- name: DeleteConnection :exec
DELETE FROM connections
WHERE con_id = $1;

-- Foreign keys
-- name: GetConnectionSite :one
SELECT t2.*
FROM connections t1
  INNER JOIN sites t2 ON t2.site_id = t1.site_id
WHERE t1.con_id = $1;

-- Foreign keys
-- name: GetConnectionConProvider :one
SELECT t2.*
FROM connections t1
  INNER JOIN con_providers t2 ON t2.con_prov_id = t1.con_prov_id
WHERE t1.con_id = $1;

-- Foreign keys
-- name: GetConnectionConType :one
SELECT t2.*
FROM connections t1
  INNER JOIN con_types t2 ON t2.con_type_id = t1.con_type_id
WHERE t1.con_id = $1;

-- Foreign keys
-- name: GetConnectionConCapacitiy :one
SELECT t2.*
FROM connections t1
  INNER JOIN con_capacities t2 ON t2.con_cap_id = t1.con_cap_id
WHERE t1.con_id = $1;

-- Foreign keys
-- name: GetConnectionConClass :one
SELECT t2.*
FROM connections t1
  INNER JOIN con_classes t2 ON t2.con_class_id = t1.con_class_id
WHERE t1.con_id = $1;

-- Relations
-- name: GetConnectionInterfaces :many
SELECT *
FROM interfaces
WHERE con_id = $1;
