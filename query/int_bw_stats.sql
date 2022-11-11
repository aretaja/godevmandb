-- name: GetIntBwStats :many
SELECT *
FROM int_bw_stats
ORDER BY bw_id
LIMIT $1
OFFSET $2;

-- name: GetIntBwStat :one
SELECT *
FROM int_bw_stats
WHERE bw_id = $1;

-- name: CountIntBwStats :one
SELECT COUNT(*)
FROM int_bw_stats;

-- name: CreateIntBwStat :one
INSERT INTO int_bw_stats (
    if_id,
    to50in,
    to75in,
    to90in,
    to100in,
    to50out,
    to75out,
    to90out,
    to100out,
    if_group
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

-- name: UpdateIntBwStat :one
UPDATE int_bw_stats
SET if_id = $2,
  to50in = $3,
  to75in = $4,
  to90in = $5,
  to100in = $6,
  to50out = $7,
  to75out = $8,
  to90out = $9,
  to100out = $10,
  if_group = $11
WHERE bw_id = $1
RETURNING *;

-- name: DeleteIntBwStat :exec
DELETE FROM int_bw_stats
WHERE bw_id = $1;

-- Foreign keys
-- name: GetIntBwStatInterface :one
SELECT t2.*
FROM int_bw_stats t1
  INNER JOIN interfaces t2 ON t2.if_id = t1.if_id
WHERE t1.bw_id = $1;
