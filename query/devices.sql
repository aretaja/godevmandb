-- name: GetDevices :many
SELECT *
FROM devices
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
    @sys_id_f::text = ''
    OR sys_id ILIKE @sys_id_f
  )
  AND (
    @host_name_f::text = ''
    OR host_name ILIKE @host_name_f
  )
  AND (
    sqlc.narg('sw_version_f')::text IS NULL
    OR sw_version ILIKE sqlc.narg('sw_version_f')
  )
  AND (
    sqlc.narg('notes_f')::text IS NULL
    OR notes ILIKE sqlc.narg('notes_f')
  )
  AND (
    sqlc.narg('name_f')::text IS NULL
    OR host_name ILIKE @name_f
    OR sys_name ILIKE sqlc.narg('name_f')
  )
  AND (
    @ip4_addr_f::inet IS NULL
    OR ip4_addr <<= @ip4_addr_f
  )
  AND (
    @ip6_addr_f::inet IS NULL
    OR ip6_addr <<= @ip6_addr_f
  )
ORDER BY created_on
LIMIT NULLIF(@limit_q::int, 0) OFFSET NULLIF(@offset_q::int, 0);

-- name: GetDevice :one
SELECT *
FROM devices
WHERE dev_id = $1;

-- name: CountDevices :one
SELECT COUNT(*)
FROM devices;

-- name: CreateDevice :one
INSERT INTO devices (
    site_id,
    dom_id,
    snmp_main_id,
    snmp_ro_id,
    parent,
    sys_id,
    ip4_addr,
    ip6_addr,
    host_name,
    sys_name,
    sys_location,
    sys_contact,
    sw_version,
    ext_model,
    installed,
    monitor,
    graph,
    backup,
    source,
    type_changed,
    backup_failed,
    validation_failed,
    unresponsive,
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
    $10,
    $11,
    $12,
    $13,
    $14,
    $15,
    $16,
    $17,
    $18,
    $19,
    $20,
    $21,
    $22,
    $23,
    $24
  )
RETURNING *;

-- name: UpdateDevice :one
UPDATE devices
SET site_id = $2,
  dom_id = $3,
  snmp_main_id = $4,
  snmp_ro_id = $5,
  parent = $6,
  sys_id = $7,
  ip4_addr = $8,
  ip6_addr = $9,
  host_name = $10,
  sys_name = $11,
  sys_location = $12,
  sys_contact = $13,
  sw_version = $14,
  ext_model = $15,
  installed = $16,
  monitor = $17,
  graph = $18,
  backup = $19,
  source = $20,
  type_changed = $21,
  backup_failed = $22,
  validation_failed = $23,
  unresponsive = $24,
  notes = $25
WHERE dev_id = $1
RETURNING *;

-- name: DeleteDevice :exec
DELETE FROM devices
WHERE dev_id = $1;

-- Foreign keys
-- name: GetDeviceSite :one
SELECT t2.*
FROM devices t1
  INNER JOIN sites t2 ON t2.site_id = t1.site_id
WHERE t1.dev_id = $1;

-- Foreign keys
-- name: GetDeviceDeviceDomain :one
SELECT t2.*
FROM devices t1
  INNER JOIN device_domains t2 ON t2.dom_id = t1.dom_id
WHERE t1.dev_id = $1;

-- Foreign keys
-- name: GetDeviceSnmpCredentialsMain :one
SELECT t2.*
FROM devices t1
  INNER JOIN snmp_credentials t2 ON t2.snmp_cred_id = t1.snmp_main_id
WHERE t1.dev_id = $1;

-- Foreign keys
-- name: GetDeviceSnmpCredentialsRo :one
SELECT t2.*
FROM devices t1
  INNER JOIN snmp_credentials t2 ON t2.snmp_cred_id = t1.snmp_ro_id
WHERE t1.dev_id = $1;

-- Foreign keys
-- name: GetDeviceParent :one
SELECT t2.*
FROM devices t1
  INNER JOIN devices t2 ON t2.dev_id = t1.parent
WHERE t1.dev_id = $1;

-- Foreign keys
-- name: GetDeviceDeviceType :one
SELECT t2.*
FROM devices t1
  INNER JOIN device_types t2 ON t2.sys_id = t1.sys_id
WHERE t1.dev_id = $1;

-- Relations
-- name: GetDeviceChilds :many
SELECT t2.*
FROM devices t1
  INNER JOIN devices t2 ON t2.parent = t1.dev_id
WHERE t1.dev_id = $1;

-- Relations
-- name: GetDeviceDeviceCredentials :many
SELECT *
FROM device_credentials
WHERE dev_id = $1
ORDER BY user;

-- Relations
-- name: GetDeviceDeviceExtensions :many
SELECT *
FROM device_extensions
WHERE dev_id = $1
ORDER BY dev_id,
  field;

-- Relations
-- name: GetDeviceDeviceLicenses :many
SELECT *
FROM device_licenses
WHERE dev_id = $1
ORDER BY descr;

-- Relations
-- name: GetDeviceDeviceState :one
SELECT *
FROM device_states
WHERE dev_id = $1;

-- Relations
-- name: GetDeviceEntities :many
SELECT *
FROM entities
WHERE dev_id = $1
ORDER BY position;

-- Relations
-- name: GetDeviceInterfaces :many
SELECT *
FROM interfaces
WHERE dev_id = $1
ORDER BY ifindex;

-- Relations
-- name: GetDeviceVlans :many
SELECT *
FROM vlans
WHERE dev_id = $1
ORDER BY vlan;

-- Relations
-- name: GetDeviceIpInterfaces :many
SELECT *
FROM ip_interfaces
WHERE dev_id = $1
ORDER BY dev_id,
  descr;

-- Relations
-- name: GetDeviceOspfNbrs :many
SELECT *
FROM ospf_nbrs
WHERE dev_id = $1
ORDER BY nbr_ip;

-- Relations
-- name: GetDeviceRlNbrs :many
SELECT *
FROM rl_nbrs
WHERE dev_id = $1
ORDER BY nbr_sysname;

-- Relations
-- name: GetDeviceXconnects :many
SELECT *
FROM xconnects
WHERE dev_id = $1
ORDER BY vc_id;

-- Relations
-- name: GetDevicePeerXconnects :many
SELECT *
FROM xconnects
WHERE peer_dev_id = $1
ORDER BY vc_id;
