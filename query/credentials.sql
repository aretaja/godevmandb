-- name: GetCredentials :many
SELECT *
FROM credentials
ORDER BY label
LIMIT $1
OFFSET $2;

-- name: GetCredential :one
SELECT *
FROM credentials
WHERE cred_id = $1;

-- name: CountCredentials :one
SELECT COUNT(*)
FROM credentials;

-- name: CreateCredential :one
INSERT INTO credentials (label, username, enc_secret)
VALUES ($1, $2, $3)
RETURNING *;

-- name: UpdateCredential :one
UPDATE credentials
SET label = $2,
  username = $3,
  enc_secret = $4
WHERE cred_id = $1
RETURNING *;

-- name: DeleteCredential :exec
DELETE FROM credentials
WHERE cred_id = $1;
