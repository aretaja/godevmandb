-- name: GetRlfNbrs :many
SELECT *
FROM rl_nbrs
ORDER BY nbr_sysname
LIMIT $1
OFFSET $2;

-- name: GetRlfNbr :one
SELECT *
FROM rl_nbrs
WHERE nbr_id = $1;

-- name: CountRlfNbrs :one
SELECT COUNT(*)
FROM rl_nbrs;

-- name: CreateRlfNbr :one
INSERT INTO rl_nbrs (
        dev_id,
        nbr_ent_id,
        nbr_sysname
    )
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateRlfNbr :one
UPDATE rl_nbrs
SET dev_id = $2,
    nbr_ent_id = $3,
    nbr_sysname = $4
WHERE nbr_id = $1
RETURNING *;

-- name: DeleteRlfNbr :exec
DELETE FROM rl_nbrs
WHERE nbr_id = $1;

-- Foreign keys
-- name: GetRlfNbrDevice :one
SELECT t2.*
FROM rl_nbrs t1
    INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.nbr_id = $1;

-- Foreign keys
-- name: GetRlfNbrEntity :one
SELECT t2.*
FROM rl_nbrs t1
    INNER JOIN entities t2 ON t2.ent_id = t1.nbr_ent_id
WHERE t1.nbr_id = $1;
