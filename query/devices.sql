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
    @source_f::text = ''
    OR source ILIKE @source_f
  )
  AND (
    sqlc.narg('sw_version_f')::text IS NULL
    OR (sqlc.narg('sw_version_f')::text = 'isnull' AND sw_version IS NULL)
    OR (sqlc.narg('sw_version_f')::text = 'isempty' AND sw_version = '')
    OR sw_version ILIKE sqlc.narg('sw_version_f')
  )
  AND (
    sqlc.narg('notes_f')::text IS NULL
    OR (sqlc.narg('notes_f')::text = 'isnull' AND notes IS NULL)
    OR (sqlc.narg('notes_f')::text = 'isempty' AND notes = '')
    OR notes ILIKE sqlc.narg('notes_f')
  )
  AND (
    sqlc.narg('sys_name_f')::text IS NULL
    OR (sqlc.narg('sys_name_f')::text = 'isnull' AND sys_name IS NULL)
    OR (sqlc.narg('sys_name_f')::text = 'isempty' AND sys_name = '')
    OR sys_name ILIKE sqlc.narg('sys_name_f')
  )
  AND (
    sqlc.narg('ext_model_f')::text IS NULL
    OR (sqlc.narg('ext_model_f')::text = 'isnull' AND ext_model IS NULL)
    OR (sqlc.narg('ext_model_f')::text = 'isempty' AND ext_model = '')
    OR ext_model ILIKE sqlc.narg('ext_model_f')
  )
  AND (
    @ip4_addr_f::inet IS NULL
    OR ip4_addr <<= @ip4_addr_f
  )
  AND (
    @ip6_addr_f::inet IS NULL
    OR ip6_addr <<= @ip6_addr_f
  )
  AND (
    @installed_f::text = ''
    OR (@installed_f::text = 'true' AND installed = true)
    OR (@installed_f::text = 'false' AND installed = false)
  )
  AND (
    @monitor_f::text = ''
    OR (@monitor_f::text = 'true' AND monitor = true)
    OR (@monitor_f::text = 'false' AND monitor = false)
  )
  AND (
    @graph_f::text = ''
    OR (@graph_f::text = 'true' AND graph = true)
    OR (@graph_f::text = 'false' AND graph = false)
  )
  AND (
    @backup_f::text = ''
    OR (@backup_f::text = 'true' AND backup = true)
    OR (@backup_f::text = 'false' AND backup = false)
  )
  AND (
    @type_changed_f::text = ''
    OR (@type_changed_f::text = 'true' AND type_changed = true)
    OR (@type_changed_f::text = 'false' AND type_changed = false)
  )
  AND (
    @backup_failed_f::text = ''
    OR (@backup_failed_f::text = 'true' AND backup_failed = true)
    OR (@backup_failed_f::text = 'false' AND backup_failed = false)
  )
  AND (
    @validation_failed_f::text = ''
    OR (@validation_failed_f::text = 'true' AND validation_failed = true)
    OR (@validation_failed_f::text = 'false' AND validation_failed = false)
  )
  AND (
    @unresponsive_f::text = ''
    OR (@unresponsive_f::text = 'true' AND unresponsive = true)
    OR (@unresponsive_f::text = 'false' AND unresponsive = false)
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
