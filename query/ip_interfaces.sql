-- name: GetIpInterfaces :many
SELECT *
FROM ip_interfaces
ORDER BY dev_id, descr
LIMIT $1
OFFSET $2;

-- name: GetIpInterface :one
SELECT *
FROM ip_interfaces
WHERE ip_id = $1;

-- name: CountIpInterfaces :one
SELECT COUNT(*)
FROM ip_interfaces;

-- name: CreateIpInterface :one
INSERT INTO ip_interfaces (
        dev_id,
        ifindex,
        ip_addr,
        descr,
        alias
    )
VALUES ($1, $2, $3, $4, $5)
RETURNING *;

-- name: UpdateIpInterface :one
UPDATE ip_interfaces
SET dev_id = $2,
    ifindex = $3,
    ip_addr = $4,
    descr = $5,
    alias = $6
WHERE ip_id = $1
RETURNING *;

-- name: DeleteIpInterface :exec
DELETE FROM ip_interfaces
WHERE ip_id = $1;

-- Foreign keys
-- name: GetIpInterfaceDevice :one
SELECT t2.*
FROM ip_interfaces t1
    INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.ip_id = $1;
