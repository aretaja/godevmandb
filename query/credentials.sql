-- name: GetCredentials :many
SELECT *
FROM credentials
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
    @label_f::text = ''
    OR label LIKE @label_f
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

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
