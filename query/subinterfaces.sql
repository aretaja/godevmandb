-- name: GetSubinterfaces :many
SELECT *
FROM subinterfaces
ORDER BY descr
LIMIT $1
OFFSET $2;

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
