-- name: GetXconnects :many
SELECT *
FROM xconnects
ORDER BY dev_id, if_id
LIMIT $1
OFFSET $2;

-- name: GetXconnect :one
SELECT *
FROM xconnects
WHERE xc_id = $1;

-- name: CountXconnects :one
SELECT COUNT(*)
FROM xconnects;

-- name: CreateXconnect :one
INSERT INTO xconnects (
        dev_id,
        peer_dev_id,
        if_id,
        vc_idx,
        vc_id,
        peer_ip,
        peer_ifalias,
        xname,
        descr,
        op_stat,
        op_stat_in,
        op_stat_out
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
        $12
    )
RETURNING *;

-- name: UpdateXconnect :one
UPDATE xconnects
SET dev_id = $2,
    peer_dev_id = $3,
    if_id = $4,
    vc_idx = $5,
    vc_id = $6,
    peer_ip = $7,
    peer_ifalias = $8,
    xname = $9,
    descr = $10,
    op_stat = $11,
    op_stat_in = $12,
    op_stat_out = $13
WHERE xc_id = $1
RETURNING *;

-- name: DeleteXconnect :exec
DELETE FROM xconnects
WHERE xc_id = $1;

-- Foreign keys
-- name: GetXconnectDevice :one
SELECT t2.*
FROM xconnects t1
    INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.xc_id = $1;

-- Foreign keys
-- name: GetXconnectPeerDevice :one
SELECT t2.*
FROM xconnects t1
    INNER JOIN devices t2 ON t2.dev_id = t1.peer_dev_id
WHERE t1.xc_id = $1;

-- Foreign keys
-- name: GetXconnectInterface :one
SELECT t2.*
FROM xconnects t1
    INNER JOIN interfaces t2 ON t2.if_id = t1.if_id
WHERE t1.xc_id = $1;
