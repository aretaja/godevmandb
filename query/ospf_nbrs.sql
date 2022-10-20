-- name: GetOspfNbrs :many
SELECT *
FROM ospf_nbrs
ORDER BY descr;

-- name: GetOspfNbr :one
SELECT *
FROM ospf_nbrs
WHERE nbr_id = $1;

-- name: CountOspfNbrs :one
SELECT COUNT(*)
FROM ospf_nbrs;

-- name: CreateOspfNbr :one
INSERT INTO ospf_nbrs (
        dev_id,
        nbr_ip,
        condition
    )
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateOspfNbr :one
UPDATE ospf_nbrs
SET dev_id = $2,
    nbr_ip = $3,
    condition = $4
WHERE nbr_id = $1
RETURNING *;

-- name: DeleteOspfNbr :exec
DELETE FROM ospf_nbrs
WHERE nbr_id = $1;

-- Foreign keys
-- name: GetOspfNbrDevice :one
SELECT t2.*
FROM ospf_nbrs t1
    INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.nbr_id = $1;
