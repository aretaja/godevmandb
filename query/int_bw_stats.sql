-- name: GetIntBwStats :many
SELECT *
FROM int_bw_stats
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
    sqlc.narg('to50in_le')::text IS NULL
    OR (sqlc.narg('to50in_le')::text = 'isnull' AND to50in IS NULL)
    OR to50in <= CAST(sqlc.narg('to50in_le') AS integer)
  )
  AND (
    sqlc.narg('to50in_ge')::text IS NULL
    OR (sqlc.narg('to50in_ge')::text = 'isnull' AND to50in IS NULL)
    OR to50in >= CAST(sqlc.narg('to50in_ge') AS integer)
  )
  AND (
    sqlc.narg('to75in_le')::text IS NULL
    OR (sqlc.narg('to75in_le')::text = 'isnull' AND to75in IS NULL)
    OR to75in <= CAST(sqlc.narg('to75in_le') AS integer)
  )
  AND (
    sqlc.narg('to75in_ge')::text IS NULL
    OR (sqlc.narg('to75in_ge')::text = 'isnull' AND to75in IS NULL)
    OR to75in >= CAST(sqlc.narg('to75in_ge') AS integer)
  )
  AND (
    sqlc.narg('to90in_le')::text IS NULL
    OR (sqlc.narg('to90in_le')::text = 'isnull' AND to90in IS NULL)
    OR to90in <= CAST(sqlc.narg('to90in_le') AS integer)
  )
  AND (
    sqlc.narg('to90in_ge')::text IS NULL
    OR (sqlc.narg('to90in_ge')::text = 'isnull' AND to90in IS NULL)
    OR to90in >= CAST(sqlc.narg('to90in_ge') AS integer)
  )
  AND (
    sqlc.narg('to100in_le')::text IS NULL
    OR (sqlc.narg('to100in_le')::text = 'isnull' AND to100in IS NULL)
    OR to100in <= CAST(sqlc.narg('to100in_le') AS integer)
  )
  AND (
    sqlc.narg('to100in_ge')::text IS NULL
    OR (sqlc.narg('to100in_ge')::text = 'isnull' AND to100in IS NULL)
    OR to100in >= CAST(sqlc.narg('to100in_ge') AS integer)
  )
  AND (
    sqlc.narg('to50out_le')::text IS NULL
    OR (sqlc.narg('to50out_le')::text = 'isnull' AND to50out IS NULL)
    OR to50out <= CAST(sqlc.narg('to50out_le') AS integer)
  )
  AND (
    sqlc.narg('to50out_ge')::text IS NULL
    OR (sqlc.narg('to50out_ge')::text = 'isnull' AND to50out IS NULL)
    OR to50out >= CAST(sqlc.narg('to50out_ge') AS integer)
  )
  AND (
    sqlc.narg('to75out_le')::text IS NULL
    OR (sqlc.narg('to75out_le')::text = 'isnull' AND to75out IS NULL)
    OR to75out <= CAST(sqlc.narg('to75out_le') AS integer)
  )
  AND (
    sqlc.narg('to75out_ge')::text IS NULL
    OR (sqlc.narg('to75out_ge')::text = 'isnull' AND to75out IS NULL)
    OR to75out >= CAST(sqlc.narg('to75out_ge') AS integer)
  )
  AND (
    sqlc.narg('to90out_le')::text IS NULL
    OR (sqlc.narg('to90out_le')::text = 'isnull' AND to90out IS NULL)
    OR to90out <= CAST(sqlc.narg('to90out_le') AS integer)
  )
  AND (
    sqlc.narg('to90out_ge')::text IS NULL
    OR (sqlc.narg('to90out_ge')::text = 'isnull' AND to90out IS NULL)
    OR to90out >= CAST(sqlc.narg('to90out_ge') AS integer)
  )
  AND (
    sqlc.narg('to100out_le')::text IS NULL
    OR (sqlc.narg('to100out_le')::text = 'isnull' AND to100out IS NULL)
    OR to100out <= CAST(sqlc.narg('to100out_le') AS integer)
  )
  AND (
    sqlc.narg('to100out_ge')::text IS NULL
    OR (sqlc.narg('to100out_ge')::text = 'isnull' AND to100out IS NULL)
    OR to100out >= CAST(sqlc.narg('to100out_ge') AS integer)
  )
  AND (
    @if_group_f::text = ''
    OR if_group ILIKE @if_group_f
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

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
