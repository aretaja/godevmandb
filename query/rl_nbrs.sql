-- name: GetRlNbrs :many
SELECT *
FROM rl_nbrs
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
    @nbr_sysname_f::text = ''
    OR nbr_sysname ILIKE @nbr_sysname_f
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetRlNbr :one
SELECT *
FROM rl_nbrs
WHERE nbr_id = $1;

-- name: CountRlNbrs :one
SELECT COUNT(*)
FROM rl_nbrs;

-- name: CreateRlNbr :one
INSERT INTO rl_nbrs (
        dev_id,
        nbr_ent_id,
        nbr_sysname
    )
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateRlNbr :one
UPDATE rl_nbrs
SET dev_id = $2,
    nbr_ent_id = $3,
    nbr_sysname = $4
WHERE nbr_id = $1
RETURNING *;

-- name: DeleteRlNbr :exec
DELETE FROM rl_nbrs
WHERE nbr_id = $1;

-- Foreign keys
-- name: GetRlNbrDevice :one
SELECT t2.*
FROM rl_nbrs t1
    INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.nbr_id = $1;

-- Foreign keys
-- name: GetRlNbrEntity :one
SELECT t2.*
FROM rl_nbrs t1
    INNER JOIN entities t2 ON t2.ent_id = t1.nbr_ent_id
WHERE t1.nbr_id = $1;
