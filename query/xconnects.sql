-- name: GetXconnects :many
SELECT *
FROM xconnects
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
    @vc_idx_f::text = ''
    OR CAST(vc_idx AS text) = @vc_idx_f
  )
  AND (
    @vc_id_f::text = ''
    OR CAST(vc_id AS text) = @vc_id_f
  )
  AND (
    @peer_ip_f::inet IS NULL
    OR peer_ip <<= @peer_ip_f
  )
  AND (
    sqlc.narg('peer_ifalias_f')::text IS NULL
    OR (sqlc.narg('peer_ifalias_f')::text = 'isnull' AND peer_ifalias IS NULL)
    OR (sqlc.narg('peer_ifalias_f')::text = 'isempty' AND peer_ifalias = '')
    OR peer_ifalias ILIKE sqlc.narg('peer_ifalias_f')
  )
  AND (
    sqlc.narg('xname_f')::text IS NULL
    OR (sqlc.narg('xname_f')::text = 'isnull' AND xname IS NULL)
    OR (sqlc.narg('xname_f')::text = 'isempty' AND xname = '')
    OR xname ILIKE sqlc.narg('xname_f')
  )
  AND (
    sqlc.narg('descr_f')::text IS NULL
    OR (sqlc.narg('descr_f')::text = 'isnull' AND descr IS NULL)
    OR (sqlc.narg('descr_f')::text = 'isempty' AND descr = '')
    OR descr ILIKE sqlc.narg('descr_f')
  )
  AND (
    sqlc.narg('op_stat_f')::text IS NULL
    OR (sqlc.narg('op_stat_f')::text = 'isnull' AND op_stat IS NULL)
    OR (sqlc.narg('op_stat_f')::text = 'isempty' AND op_stat = '')
    OR op_stat ILIKE sqlc.narg('op_stat_f')
  )
  AND (
    sqlc.narg('op_stat_in_f')::text IS NULL
    OR (sqlc.narg('op_stat_in_f')::text = 'isnull' AND op_stat_in IS NULL)
    OR (sqlc.narg('op_stat_in_f')::text = 'isempty' AND op_stat_in = '')
    OR op_stat_in ILIKE sqlc.narg('op_stat_in_f')
  )
  AND (
    sqlc.narg('op_stat_out_f')::text IS NULL
    OR (sqlc.narg('op_stat_out_f')::text = 'isnull' AND op_stat_out IS NULL)
    OR (sqlc.narg('op_stat_out_f')::text = 'isempty' AND op_stat_out = '')
    OR op_stat_out ILIKE sqlc.narg('op_stat_out_f')
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

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
