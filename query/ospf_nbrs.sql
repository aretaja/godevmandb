-- name: GetOspfNbrs :many
SELECT *
FROM ospf_nbrs
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
    sqlc.narg('condition_f')::text IS NULL
    OR (sqlc.narg('condition_f')::text = 'isnull' AND condition IS NULL)
    OR (sqlc.narg('condition_f')::text = 'isempty' AND condition = '')
    OR condition ILIKE sqlc.narg('condition_f')
  )
  AND (
    @nbr_ip_f::inet IS NULL
    OR nbr_ip <<= @nbr_ip_f
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

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
