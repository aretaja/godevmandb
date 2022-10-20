-- name: GetUsers :many
SELECT *
FROM users
ORDER BY username;

-- name: GetUser :one
SELECT *
FROM users
WHERE username = $1;

-- name: CountUsers :one
SELECT COUNT(*)
FROM users;

-- name: CreateUser :one
INSERT INTO users (username, userlevel, notes)
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateUser :one
UPDATE users
SET userlevel = $2,
    notes = $3
WHERE username = $1
RETURNING *;

-- name: DeleteUser :exec
DELETE FROM users
WHERE username = $1;

-- Relations
-- name: GetUserUserAuthzs :many
SELECT *
FROM user_authzs
WHERE username = $1
ORDER BY username;

-- Relations
-- name: GetUserUserGraps :many
SELECT *
FROM user_graphs
WHERE username = $1
ORDER BY username;
