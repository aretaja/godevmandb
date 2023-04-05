-- name: GetArchivedInterfaces :many
SELECT *
FROM archived_interfaces
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
    sqlc.narg('otn_if_id_f')::text IS NULL
    OR (sqlc.narg('otn_if_id_f')::text = 'isnull' AND otn_if_id IS NULL)
    OR (sqlc.narg('otn_if_id_f')::text = 'isempty' AND CAST(otn_if_id AS text) = '')
    OR CAST(otn_if_id AS text) LIKE sqlc.narg('otn_if_id_f')
  )
  AND (
    sqlc.narg('cisco_opt_power_index_f')::text IS NULL
    OR (sqlc.narg('cisco_opt_power_index_f')::text = 'isnull' AND cisco_opt_power_index IS NULL)
    OR (sqlc.narg('cisco_opt_power_index_f')::text = 'isempty' AND cisco_opt_power_index = '')
    OR cisco_opt_power_index ILIKE sqlc.narg('cisco_opt_power_index_f')
  )
  AND (
    @hostname_f::text = ''
    OR (@hostname_f  = 'isempty' AND hostname = '')
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
    @manufacturer_f::text = ''
    OR (@manufacturer_f = 'isempty' AND manufacturer = '')
    OR manufacturer ILIKE @manufacturer_f
  )
  AND (
    @model_f::text = ''
    OR (@model_f  = 'isempty' AND model = '')
    OR model ILIKE @model_f
  )
  AND (
    @descr_f::text = ''
    OR (@descr_f  = 'isempty' AND descr = '')
    OR descr ILIKE @descr_f
  )
  AND (
    sqlc.narg('alias_f')::text IS NULL
    OR (sqlc.narg('alias_f')::text = 'isnull' AND alias IS NULL)
    OR (sqlc.narg('alias_f')::text = 'isempty' AND alias = '')
    OR alias ILIKE sqlc.narg('alias_f')
  )
  AND (
    sqlc.narg('type_enum_f')::text IS NULL
    OR (sqlc.narg('type_enum_f')::text = 'isnull' AND type_enum IS NULL)
    OR (sqlc.narg('type_enum_f')::text = 'isempty' AND CAST(type_enum AS text) = '')
    OR CAST(type_enum AS text) LIKE sqlc.narg('type_enum_f')
  )
  AND (
    @mac_f::macaddr IS NULL
    OR mac = @mac_f
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetArchivedInterface :one
SELECT *
FROM archived_interfaces
WHERE ifa_id = $1;

-- name: CountArchivedInterfaces :one
SELECT COUNT(*)
FROM archived_interfaces;

-- name: CreateArchivedInterface :one
INSERT INTO archived_interfaces (
    ifindex,
    otn_if_id,
    cisco_opt_power_index,
    hostname,
    host_ip4,
    host_ip6,
    manufacturer,
    model,
    descr,
    alias,
    type_enum,
    mac
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

-- name: UpdateArchivedInterface :one
UPDATE archived_interfaces
SET ifindex = $2,
  otn_if_id = $3,
  cisco_opt_power_index = $4,
  hostname = $5,
  host_ip4 = $6,
  host_ip6 = $7,
  manufacturer = $8,
  model = $9,
  descr = $10,
  alias = $11,
  type_enum = $12,
  mac = $13
WHERE ifa_id = $1
RETURNING *;

-- name: DeleteArchivedInterface :exec
DELETE FROM archived_interfaces
WHERE ifa_id = $1;
