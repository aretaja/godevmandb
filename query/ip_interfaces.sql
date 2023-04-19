-- name: GetIpInterfaces :many
SELECT *
FROM ip_interfaces
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
    sqlc.narg('ifindex_f')::text IS NULL
    OR (sqlc.narg('ifindex_f')::text = 'isnull' AND ifindex IS NULL)
    OR (sqlc.narg('ifindex_f')::text = 'isempty' AND CAST(ifindex AS text) = '')
    OR CAST(ifindex AS text) LIKE sqlc.narg('ifindex_f')
  )
  AND (
    sqlc.narg('descr_f')::text IS NULL
    OR (sqlc.narg('descr_f')::text = 'isnull' AND descr IS NULL)
    OR (sqlc.narg('descr_f')::text = 'isempty' AND descr = '')
    OR descr ILIKE sqlc.narg('descr_f')
  )
  AND (
    sqlc.narg('alias_f')::text IS NULL
    OR (sqlc.narg('alias_f')::text = 'isnull' AND alias IS NULL)
    OR (sqlc.narg('alias_f')::text = 'isempty' AND alias = '')
    OR alias ILIKE sqlc.narg('alias_f')
  )
  AND (
    @ip_addr_f::inet IS NULL
    OR ip_addr <<= @ip_addr_f
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

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
