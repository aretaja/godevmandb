-- name: GetArchivedInterfaces :many
SELECT *
FROM archived_interfaces
ORDER BY descr;

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
