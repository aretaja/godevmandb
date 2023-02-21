-- name: GetInterfaces :many
SELECT *
FROM interfaces
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
    sqlc.narg('minspeed_f')::text IS NULL
    OR (sqlc.narg('minspeed_f')::text = 'isnull' AND minspeed IS NULL)
    OR (sqlc.narg('minspeed_f')::text = 'isempty' AND CAST(minspeed AS text) = '')
    OR CAST(minspeed AS text) LIKE sqlc.narg('minspeed_f')
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
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetInterface :one
SELECT *
FROM interfaces
WHERE if_id = $1;

-- name: CountInterfaces :one
SELECT COUNT(*)
FROM interfaces;

-- name: CreateInterface :one
INSERT INTO interfaces (
    con_id,
    parent,
    otn_if_id,
    dev_id,
    ent_id,
    ifindex,
    descr,
    alias,
    oper,
    adm,
    speed,
    minspeed,
    type_enum,
    mac,
    monstatus,
    monerrors,
    monload,
    montraffic
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
    $10,
    $11,
    $12,
    $13,
    $14,
    $15,
    $16,
    $17,
    $18
  )
RETURNING *;

-- name: UpdateInterface :one
UPDATE interfaces
SET con_id = $2,
  parent = $3,
  otn_if_id = $4,
  dev_id = $5,
  ent_id = $6,
  ifindex = $7,
  descr = $8,
  alias = $9,
  oper = $10,
  adm = $11,
  speed = $12,
  minspeed = $13,
  type_enum = $14,
  mac = $15,
  monstatus = $16,
  monerrors = $17,
  monload = $18,
  montraffic = $19
WHERE if_id = $1
RETURNING *;

-- name: DeleteInterface :exec
DELETE FROM interfaces
WHERE if_id = $1;

-- Foreign keys
-- name: GetInterfaceConnection :one
SELECT t2.*
FROM interfaces t1
  INNER JOIN connections t2 ON t2.con_id = t1.con_id
WHERE t1.if_id = $1;

-- Foreign keys
-- name: GetInterfaceParent :one
SELECT t2.*
FROM interfaces t1
  INNER JOIN interfaces t2 ON t2.if_id = t1.parent
WHERE t1.if_id = $1;

-- Foreign keys
-- name: GetInterfaceOtnIfId :one
SELECT t2.*
FROM interfaces t1
  INNER JOIN interfaces t2 ON t2.if_id = t1.otn_if_id
WHERE t1.if_id = $1;

-- Foreign keys
-- name: GetInterfaceDevice :one
SELECT t2.*
FROM interfaces t1
  INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.if_id = $1;

-- Foreign keys
-- name: GetInterfaceEntity :one
SELECT t2.*
FROM interfaces t1
  INNER JOIN entities t2 ON t2.ent_id = t1.ent_id
WHERE t1.if_id = $1;

-- Relations
-- name: GetInterfaceChilds :many
SELECT t2.*
FROM interfaces t1
  INNER JOIN interfaces t2 ON t2.parent = t1.if_id
WHERE t1.if_id = $1;

-- Relations
-- name: GetInterfaceIntBwStats :many
SELECT *
FROM int_bw_stats
WHERE if_id = $1
ORDER BY updated_on;

-- Relations
-- name: GetInterfaceInterfaceRelations :many
SELECT *
FROM interface_relations
WHERE if_id = $1;

-- Relations
-- name: GetInterfaceInterfaceRelationsHigherFor :many
SELECT t2.*
FROM interfaces t1
  INNER JOIN interface_relations t2 ON t2.if_id_up = t1.if_id
WHERE t1.if_id = $1;

-- Relations
-- name: GetInterfaceInterfaceRelationsLowerFor :many
SELECT t2.*
FROM interfaces t1
  INNER JOIN interface_relations t2 ON t2.if_id_down = t1.if_id
WHERE t1.if_id = $1;

-- Relations
-- name: GetInterfaceVlans :many
SELECT t3.*
FROM interfaces t1
  INNER JOIN interfaces2vlans t2 ON t2.if_id = t1.if_id
  INNER JOIN vlans t3 ON t3.v_id = t2.v_id
WHERE t1.if_id = $1
ORDER BY vlan;

-- Relations
-- name: GetInterfaceInterfaceSubinterfaces :many
SELECT *
FROM subinterfaces
WHERE if_id = $1
ORDER BY descr;

-- Relations
-- name: GetterfaceInterfaceXconnects :many
SELECT *
FROM xconnects
WHERE if_id = $1
ORDER BY vc_id;
