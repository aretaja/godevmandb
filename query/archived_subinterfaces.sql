-- name: GetArchivedSubInterfaces :many
SELECT *
FROM archived_subinterfaces
ORDER BY descr
LIMIT $1
OFFSET $2;

-- name: GetArchivedSubInterface :one
SELECT *
FROM archived_subinterfaces
WHERE sifa_id = $1;

-- name: CountArchivedSubInterfaces :one
SELECT COUNT(*)
FROM archived_subinterfaces;

-- name: CreateArchivedSubInterface :one
INSERT INTO archived_subinterfaces (
    ifindex,
    descr,
    parent_descr,
    alias,
    type_enum,
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

-- name: UpdateArchivedSubInterface :one
UPDATE archived_subinterfaces
SET ifindex = $2,
  descr = $3,
  parent_descr = $4,
  alias = $5,
  type_enum = $6,
  mac = $7,
  hostname = $8,
  host_ip4 = $9,
  host_ip6 = $10,
  notes = $11
WHERE sifa_id = $1
RETURNING *;

-- name: DeleteArchivedSubInterface :exec
DELETE FROM archived_subinterfaces
WHERE sifa_id = $1;
