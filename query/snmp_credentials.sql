-- name: GetSnmpCredentials :many
SELECT *
FROM snmp_credentials
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
    OR label ILIKE @label_f
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetSnmpCredential :one
SELECT *
FROM snmp_credentials
WHERE snmp_cred_id = $1;

-- name: CountSnmpCredentials :one
SELECT COUNT(*)
FROM snmp_credentials;

-- name: CreateSnmpCredential :one
INSERT INTO snmp_credentials (
    label,
    variant,
    auth_name,
    auth_proto,
    auth_pass,
    sec_level,
    priv_proto,
    priv_pass
  )
VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
RETURNING *;

-- name: UpdateSnmpCredential :one
UPDATE snmp_credentials
SET label = $2,
  variant = $3,
  auth_name = $4,
  auth_proto = $5,
  auth_pass = $6,
  sec_level = $7,
  priv_proto = $8,
  priv_pass = $9
WHERE snmp_cred_id = $1
RETURNING *;

-- name: DeleteSnmpCredential :exec
DELETE FROM snmp_credentials
WHERE snmp_cred_id = $1;

-- Relations
-- name: GetSnmpCredentialsMainDevices :many
SELECT t2.*
FROM snmp_credentials t1
  INNER JOIN devices t2 ON t2.snmp_main_id = t1.snmp_cred_id
WHERE t1.snmp_cred_id = $1;

-- Relations
-- name: GetSnmpCredentialsRoDevices :many
SELECT t2.*
FROM snmp_credentials t1
  INNER JOIN devices t2 ON t2.snmp_ro_id = t1.snmp_cred_id
WHERE t1.snmp_cred_id = $1;
