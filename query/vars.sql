-- name: GetVars :many
SELECT *
FROM vars
ORDER BY descr
LIMIT $1
OFFSET $2;

-- name: GetVar :one
SELECT *
FROM vars
WHERE descr = $1;

-- name: CountVars :one
SELECT COUNT(*)
FROM vars;

-- name: CreateVar :one
INSERT INTO vars (descr, content, notes)
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateVar :one
UPDATE vars
SET content = $2,
    notes = $3
WHERE descr = $1
RETURNING *;

-- name: DeleteVar :exec
DELETE FROM vars
WHERE descr = $1;
