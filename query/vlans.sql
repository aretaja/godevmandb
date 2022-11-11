-- name: GetVlans :many
SELECT *
FROM vlans
ORDER BY dev_id, vlan
LIMIT $1
OFFSET $2;

-- name: GetVlan :one
SELECT *
FROM vlans
WHERE v_id = $1;

-- name: CountVlans :one
SELECT COUNT(*)
FROM vlans;

-- name: CreateVlan :one
INSERT INTO vlans (dev_id, vlan, descr)
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateVlan :one
UPDATE vlans
SET dev_id = $2,
  vlan = $3,
  descr = $4
WHERE v_id = $1
RETURNING *;

-- name: DeleteVlan :exec
DELETE FROM vlans
WHERE v_id = $1;

-- Foreign keys
-- name: GetVlanDevice :one
SELECT t2.*
FROM vlans t1
  INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.v_id = $1;

-- Relations
-- name: GetVlanInterfaces :many
SELECT t3.*
FROM vlans t1
  INNER JOIN interfaces2vlans t2 ON t2.v_id = t1.v_id
  INNER JOIN interfaces t3 ON t3.if_id = t2.if_id
WHERE t1.v_id = $1
ORDER BY dev_id;
