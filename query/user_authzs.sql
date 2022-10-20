-- name: GetUserAuthzs :many
SELECT *
FROM user_authzs
ORDER BY username;

-- name: GetUserAuthz :one
SELECT *
FROM user_authzs
WHERE username = $1
  AND dom_id = $2;

-- name: CountUserAuthzs :one
SELECT COUNT(*)
FROM user_authzs;

-- name: CreateUserAuthz :one
INSERT INTO user_authzs (username, dom_id, userlevel)
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateUserAuthz :one
UPDATE user_authzs
SET userlevel = $3
WHERE username = $1
  AND dom_id = $2
RETURNING *;

-- name: DeleteUserAuthz :exec
DELETE FROM user_authzs
WHERE username = $1
  AND dom_id = $2;

-- Foreign keys
-- name: GetUserAuthzUser :one
SELECT t2.*
FROM user_authzs t1
  INNER JOIN users t2 ON t2.username = t1.username
WHERE t1.username = $1
  AND t1.dom_id = $2;

-- Foreign keys
-- name: GetUserAuthzDeviceDomain :one
SELECT t2.*
FROM user_authzs t1
  INNER JOIN device_domains t2 ON t2.dom_id = t1.dom_id
WHERE t1.username = $1
  AND t1.dom_id = $2;
