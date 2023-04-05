-- name: GetSubinterfaces :many
SELECT *
FROM subinterfaces
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
    sqlc.narg('ifindex_f')::text IS NULL
    OR (sqlc.narg('ifindex_f')::text = 'isnull' AND ifindex IS NULL)
    OR (sqlc.narg('ifindex_f')::text = 'isempty' AND CAST(ifindex AS text) = '')
    OR CAST(ifindex AS text) LIKE sqlc.narg('ifindex_f')
  )
  AND (
    @descr_f::text = ''
    OR (@descr_f = 'isempty' AND descr = '')
    OR descr ILIKE @descr_f
  )
  AND (
    sqlc.narg('alias_f')::text IS NULL
    OR (sqlc.narg('alias_f')::text = 'isnull' AND alias IS NULL)
    OR (sqlc.narg('alias_f')::text = 'isempty' AND alias = '')
    OR alias ILIKE sqlc.narg('alias_f')
  )
  AND (
    sqlc.narg('oper_f')::text IS NULL
    OR (sqlc.narg('oper_f')::text = 'isnull' AND oper IS NULL)
    OR (sqlc.narg('oper_f')::text = 'isempty' AND CAST(oper AS text) = '')
    OR CAST(oper AS text) LIKE sqlc.narg('oper_f')
  )
  AND (
    sqlc.narg('adm_f')::text IS NULL
    OR (sqlc.narg('adm_f')::text = 'isnull' AND adm IS NULL)
    OR (sqlc.narg('adm_f')::text = 'isempty' AND CAST(adm AS text) = '')
    OR CAST(adm AS text) LIKE sqlc.narg('adm_f')
  )
  AND (
    sqlc.narg('speed_f')::text IS NULL
    OR (sqlc.narg('speed_f')::text = 'isnull' AND speed IS NULL)
    OR (sqlc.narg('speed_f')::text = 'isempty' AND CAST(speed AS text) = '')
    OR CAST(speed AS text) LIKE sqlc.narg('speed_f')
  )
  AND (
    sqlc.narg('type_enum_f')::text IS NULL
    OR (sqlc.narg('type_enum_f')::text = 'isnull' AND type_enum IS NULL)
    OR (sqlc.narg('type_enum_f')::text = 'isempty' AND CAST(type_enum AS text) = '')
    OR CAST(type_enum AS text) LIKE sqlc.narg('type_enum_f')
  )
  AND (
    @mac_f::macaddr IS NULL
    OR mac = @mac_f
  )
  AND (
    sqlc.narg('notes_f')::text IS NULL
    OR (sqlc.narg('notes_f')::text = 'isnull' AND notes IS NULL)
    OR (sqlc.narg('notes_f')::text = 'isempty' AND notes = '')
    OR notes ILIKE sqlc.narg('notes_f')
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetSubinterface :one
SELECT *
FROM subinterfaces
WHERE sif_id = $1;

-- name: CountSubinterfaces :one
SELECT COUNT(*)
FROM subinterfaces;

-- name: CreateSubinterface :one
INSERT INTO subinterfaces (
    if_id,
    ifindex,
    descr,
    alias,
    oper,
    adm,
    speed,
    type_enum,
    mac,
    notes
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

-- name: UpdateSubinterface :one
UPDATE subinterfaces
SET if_id = $2,
  ifindex = $3,
  descr = $4,
  alias = $5,
  oper = $6,
  adm = $7,
  speed = $8,
  type_enum = $9,
  mac = $10,
  notes = $11
WHERE sif_id = $1
RETURNING *;

-- name: DeleteSubinterface :exec
DELETE FROM subinterfaces
WHERE sif_id = $1;

-- Foreign keys
-- name: GetSubinterfaceInterface :one
SELECT t2.*
FROM subinterfaces t1
  INNER JOIN interfaces t2 ON t2.if_id = t1.if_id
WHERE t1.sif_id = $1;
