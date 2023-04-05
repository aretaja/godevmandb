-- name: GetInterfaces2vlans :many
SELECT *
FROM interfaces2vlans
ORDER BY v_id;

-- name: CreateInterface2vlan :one
INSERT INTO interfaces2vlans (v_id, if_id)
VALUES ($1, $2)
RETURNING *;

-- name: DeleteInterface2vlan :exec
DELETE FROM interfaces2vlans
WHERE v_id = $1
  AND if_id = $2;
