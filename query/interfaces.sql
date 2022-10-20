-- name: GetInterfaces :many
SELECT *
FROM interfaces
ORDER BY dev_id,
  ifindex;

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
