-- name: GetArchivedSubinterfaces :many
SELECT *
FROM archived_subinterfaces
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
    @descr_f::text = ''
    OR (@descr_f = 'isempty' AND descr = '')
    OR descr ILIKE @descr_f
  )
  AND (
    sqlc.narg('parent_descr_f')::text IS NULL
    OR (sqlc.narg('parent_descr_f')::text = 'isnull' AND parent_descr IS NULL)
    OR (sqlc.narg('parent_descr_f')::text = 'isempty' AND parent_descr = '')
    OR parent_descr ILIKE sqlc.narg('parent_descr_f')
  )
  AND (
    sqlc.narg('alias_f')::text IS NULL
    OR (sqlc.narg('alias_f')::text = 'isnull' AND alias IS NULL)
    OR (sqlc.narg('alias_f')::text = 'isempty' AND alias = '')
    OR alias ILIKE sqlc.narg('alias_f')
  )
  AND (
    sqlc.narg('type_f')::text IS NULL
    OR (sqlc.narg('type_f')::text = 'isnull' AND type IS NULL)
    OR (sqlc.narg('type_f')::text = 'isempty' AND type = '')
    OR type ILIKE sqlc.narg('type_f')
  )
  AND (
    @mac_f::macaddr IS NULL
    OR mac = @mac_f
  )
  AND (
    @hostname_f::text = ''
    OR (@hostname_f = 'isempty' AND hostname = '')
    OR hostname ILIKE @hostname_f
  )
  AND (
    @host_ip4_f::inet IS NULL
    OR host_ip4 <<= @host_ip4_f
  )
  AND (
    @host_ip6_f::inet IS NULL
    OR host_ip6 <<= @host_ip6_f
  )
  AND (
    sqlc.narg('notes_f')::text IS NULL
    OR (sqlc.narg('notes_f')::text = 'isnull' AND notes IS NULL)
    OR (sqlc.narg('notes_f')::text = 'isempty' AND notes = '')
    OR notes ILIKE sqlc.narg('notes_f')
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetArchivedSubinterface :one
SELECT *
FROM archived_subinterfaces
WHERE sifa_id = $1;

-- name: CountArchivedSubinterfaces :one
SELECT COUNT(*)
FROM archived_subinterfaces;

-- name: CreateArchivedSubinterface :one
INSERT INTO archived_subinterfaces (
    ifindex,
    descr,
    parent_descr,
    alias,
    type,
    mac,
    hostname,
    host_ip4,
    host_ip6,
    notes
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

-- name: UpdateArchivedSubinterface :one
UPDATE archived_subinterfaces
SET ifindex = $2,
  descr = $3,
  parent_descr = $4,
  alias = $5,
  type = $6,
  mac = $7,
  hostname = $8,
  host_ip4 = $9,
  host_ip6 = $10,
  notes = $11
WHERE sifa_id = $1
RETURNING *;

-- name: DeleteArchivedSubinterface :exec
DELETE FROM archived_subinterfaces
WHERE sifa_id = $1;
