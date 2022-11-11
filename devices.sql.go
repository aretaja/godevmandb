// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.15.0
// source: devices.sql

package godevmandb

import (
	"context"
	"database/sql"

	"github.com/jackc/pgtype"
)

const CountDevices = `-- name: CountDevices :one
SELECT COUNT(*)
FROM devices
`

func (q *Queries) CountDevices(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountDevices)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateDevice = `-- name: CreateDevice :one
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
RETURNING dev_id, site_id, dom_id, snmp_main_id, snmp_ro_id, parent, sys_id, ip4_addr, ip6_addr, host_name, sys_name, sys_location, sys_contact, sw_version, ext_model, installed, monitor, graph, backup, source, type_changed, backup_failed, validation_failed, unresponsive, notes, updated_on, created_on
`

type CreateDeviceParams struct {
	SiteID           sql.NullInt64  `json:"site_id"`
	DomID            int64          `json:"dom_id"`
	SnmpMainID       sql.NullInt64  `json:"snmp_main_id"`
	SnmpRoID         sql.NullInt64  `json:"snmp_ro_id"`
	Parent           sql.NullInt64  `json:"parent"`
	SysID            string         `json:"sys_id"`
	Ip4Addr          pgtype.Inet    `json:"ip4_addr"`
	Ip6Addr          pgtype.Inet    `json:"ip6_addr"`
	HostName         string         `json:"host_name"`
	SysName          sql.NullString `json:"sys_name"`
	SysLocation      sql.NullString `json:"sys_location"`
	SysContact       sql.NullString `json:"sys_contact"`
	SwVersion        sql.NullString `json:"sw_version"`
	ExtModel         sql.NullString `json:"ext_model"`
	Installed        bool           `json:"installed"`
	Monitor          bool           `json:"monitor"`
	Graph            bool           `json:"graph"`
	Backup           bool           `json:"backup"`
	Source           string         `json:"source"`
	TypeChanged      bool           `json:"type_changed"`
	BackupFailed     bool           `json:"backup_failed"`
	ValidationFailed bool           `json:"validation_failed"`
	Unresponsive     bool           `json:"unresponsive"`
	Notes            sql.NullString `json:"notes"`
}

func (q *Queries) CreateDevice(ctx context.Context, arg CreateDeviceParams) (Device, error) {
	row := q.db.QueryRow(ctx, CreateDevice,
		arg.SiteID,
		arg.DomID,
		arg.SnmpMainID,
		arg.SnmpRoID,
		arg.Parent,
		arg.SysID,
		arg.Ip4Addr,
		arg.Ip6Addr,
		arg.HostName,
		arg.SysName,
		arg.SysLocation,
		arg.SysContact,
		arg.SwVersion,
		arg.ExtModel,
		arg.Installed,
		arg.Monitor,
		arg.Graph,
		arg.Backup,
		arg.Source,
		arg.TypeChanged,
		arg.BackupFailed,
		arg.ValidationFailed,
		arg.Unresponsive,
		arg.Notes,
	)
	var i Device
	err := row.Scan(
		&i.DevID,
		&i.SiteID,
		&i.DomID,
		&i.SnmpMainID,
		&i.SnmpRoID,
		&i.Parent,
		&i.SysID,
		&i.Ip4Addr,
		&i.Ip6Addr,
		&i.HostName,
		&i.SysName,
		&i.SysLocation,
		&i.SysContact,
		&i.SwVersion,
		&i.ExtModel,
		&i.Installed,
		&i.Monitor,
		&i.Graph,
		&i.Backup,
		&i.Source,
		&i.TypeChanged,
		&i.BackupFailed,
		&i.ValidationFailed,
		&i.Unresponsive,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteDevice = `-- name: DeleteDevice :exec
DELETE FROM devices
WHERE dev_id = $1
`

func (q *Queries) DeleteDevice(ctx context.Context, devID int64) error {
	_, err := q.db.Exec(ctx, DeleteDevice, devID)
	return err
}

const GetDevice = `-- name: GetDevice :one
SELECT dev_id, site_id, dom_id, snmp_main_id, snmp_ro_id, parent, sys_id, ip4_addr, ip6_addr, host_name, sys_name, sys_location, sys_contact, sw_version, ext_model, installed, monitor, graph, backup, source, type_changed, backup_failed, validation_failed, unresponsive, notes, updated_on, created_on
FROM devices
WHERE dev_id = $1
`

func (q *Queries) GetDevice(ctx context.Context, devID int64) (Device, error) {
	row := q.db.QueryRow(ctx, GetDevice, devID)
	var i Device
	err := row.Scan(
		&i.DevID,
		&i.SiteID,
		&i.DomID,
		&i.SnmpMainID,
		&i.SnmpRoID,
		&i.Parent,
		&i.SysID,
		&i.Ip4Addr,
		&i.Ip6Addr,
		&i.HostName,
		&i.SysName,
		&i.SysLocation,
		&i.SysContact,
		&i.SwVersion,
		&i.ExtModel,
		&i.Installed,
		&i.Monitor,
		&i.Graph,
		&i.Backup,
		&i.Source,
		&i.TypeChanged,
		&i.BackupFailed,
		&i.ValidationFailed,
		&i.Unresponsive,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetDeviceChilds = `-- name: GetDeviceChilds :many
SELECT t2.dev_id, t2.site_id, t2.dom_id, t2.snmp_main_id, t2.snmp_ro_id, t2.parent, t2.sys_id, t2.ip4_addr, t2.ip6_addr, t2.host_name, t2.sys_name, t2.sys_location, t2.sys_contact, t2.sw_version, t2.ext_model, t2.installed, t2.monitor, t2.graph, t2.backup, t2.source, t2.type_changed, t2.backup_failed, t2.validation_failed, t2.unresponsive, t2.notes, t2.updated_on, t2.created_on
FROM devices t1
  INNER JOIN devices t2 ON t2.parent = t1.dev_id
WHERE t1.dev_id = $1
`

// Relations
func (q *Queries) GetDeviceChilds(ctx context.Context, devID int64) ([]Device, error) {
	rows, err := q.db.Query(ctx, GetDeviceChilds, devID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Device
	for rows.Next() {
		var i Device
		if err := rows.Scan(
			&i.DevID,
			&i.SiteID,
			&i.DomID,
			&i.SnmpMainID,
			&i.SnmpRoID,
			&i.Parent,
			&i.SysID,
			&i.Ip4Addr,
			&i.Ip6Addr,
			&i.HostName,
			&i.SysName,
			&i.SysLocation,
			&i.SysContact,
			&i.SwVersion,
			&i.ExtModel,
			&i.Installed,
			&i.Monitor,
			&i.Graph,
			&i.Backup,
			&i.Source,
			&i.TypeChanged,
			&i.BackupFailed,
			&i.ValidationFailed,
			&i.Unresponsive,
			&i.Notes,
			&i.UpdatedOn,
			&i.CreatedOn,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const GetDeviceDeviceCredentials = `-- name: GetDeviceDeviceCredentials :many
SELECT cred_id, dev_id, username, enc_secret, updated_on, created_on
FROM device_credentials
WHERE dev_id = $1
ORDER BY user
`

// Relations
func (q *Queries) GetDeviceDeviceCredentials(ctx context.Context, devID int64) ([]DeviceCredential, error) {
	rows, err := q.db.Query(ctx, GetDeviceDeviceCredentials, devID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []DeviceCredential
	for rows.Next() {
		var i DeviceCredential
		if err := rows.Scan(
			&i.CredID,
			&i.DevID,
			&i.Username,
			&i.EncSecret,
			&i.UpdatedOn,
			&i.CreatedOn,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const GetDeviceDeviceDomain = `-- name: GetDeviceDeviceDomain :one
SELECT t2.dom_id, t2.descr, t2.updated_on, t2.created_on
FROM devices t1
  INNER JOIN device_domains t2 ON t2.dom_id = t1.dom_id
WHERE t1.dev_id = $1
`

// Foreign keys
func (q *Queries) GetDeviceDeviceDomain(ctx context.Context, devID int64) (DeviceDomain, error) {
	row := q.db.QueryRow(ctx, GetDeviceDeviceDomain, devID)
	var i DeviceDomain
	err := row.Scan(
		&i.DomID,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetDeviceDeviceExtensions = `-- name: GetDeviceDeviceExtensions :many
SELECT ext_id, dev_id, field, content, updated_on, created_on
FROM device_extensions
WHERE dev_id = $1
ORDER BY dev_id,
  field
`

// Relations
func (q *Queries) GetDeviceDeviceExtensions(ctx context.Context, devID int64) ([]DeviceExtension, error) {
	rows, err := q.db.Query(ctx, GetDeviceDeviceExtensions, devID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []DeviceExtension
	for rows.Next() {
		var i DeviceExtension
		if err := rows.Scan(
			&i.ExtID,
			&i.DevID,
			&i.Field,
			&i.Content,
			&i.UpdatedOn,
			&i.CreatedOn,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const GetDeviceDeviceLicenses = `-- name: GetDeviceDeviceLicenses :many
SELECT lic_id, dev_id, product, descr, installed, unlocked, tot_inst, used, condition, updated_on, created_on
FROM device_licenses
WHERE dev_id = $1
ORDER BY descr
`

// Relations
func (q *Queries) GetDeviceDeviceLicenses(ctx context.Context, devID int64) ([]DeviceLicense, error) {
	rows, err := q.db.Query(ctx, GetDeviceDeviceLicenses, devID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []DeviceLicense
	for rows.Next() {
		var i DeviceLicense
		if err := rows.Scan(
			&i.LicID,
			&i.DevID,
			&i.Product,
			&i.Descr,
			&i.Installed,
			&i.Unlocked,
			&i.TotInst,
			&i.Used,
			&i.Condition,
			&i.UpdatedOn,
			&i.CreatedOn,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const GetDeviceDeviceState = `-- name: GetDeviceDeviceState :one
SELECT dev_id, up_time, down_time, method, updated_on, created_on
FROM device_states
WHERE dev_id = $1
`

// Relations
func (q *Queries) GetDeviceDeviceState(ctx context.Context, devID int64) (DeviceState, error) {
	row := q.db.QueryRow(ctx, GetDeviceDeviceState, devID)
	var i DeviceState
	err := row.Scan(
		&i.DevID,
		&i.UpTime,
		&i.DownTime,
		&i.Method,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetDeviceDeviceType = `-- name: GetDeviceDeviceType :one
SELECT t2.sys_id, t2.class_id, t2.manufacturer, t2.model, t2.hc, t2.snmp_ver, t2.updated_on, t2.created_on
FROM devices t1
  INNER JOIN device_types t2 ON t2.sys_id = t1.sys_id
WHERE t1.dev_id = $1
`

// Foreign keys
func (q *Queries) GetDeviceDeviceType(ctx context.Context, devID int64) (DeviceType, error) {
	row := q.db.QueryRow(ctx, GetDeviceDeviceType, devID)
	var i DeviceType
	err := row.Scan(
		&i.SysID,
		&i.ClassID,
		&i.Manufacturer,
		&i.Model,
		&i.Hc,
		&i.SnmpVer,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetDeviceEntities = `-- name: GetDeviceEntities :many
SELECT ent_id, parent_ent_id, snmp_ent_id, dev_id, slot, descr, model, hw_product, hw_revision, serial_nr, sw_product, sw_revision, manufacturer, physical, updated_on, created_on
FROM entities
WHERE dev_id = $1
ORDER BY position
`

// Relations
func (q *Queries) GetDeviceEntities(ctx context.Context, devID int64) ([]Entity, error) {
	rows, err := q.db.Query(ctx, GetDeviceEntities, devID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Entity
	for rows.Next() {
		var i Entity
		if err := rows.Scan(
			&i.EntID,
			&i.ParentEntID,
			&i.SnmpEntID,
			&i.DevID,
			&i.Slot,
			&i.Descr,
			&i.Model,
			&i.HwProduct,
			&i.HwRevision,
			&i.SerialNr,
			&i.SwProduct,
			&i.SwRevision,
			&i.Manufacturer,
			&i.Physical,
			&i.UpdatedOn,
			&i.CreatedOn,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const GetDeviceInterfaces = `-- name: GetDeviceInterfaces :many
SELECT if_id, con_id, parent, otn_if_id, dev_id, ent_id, ifindex, descr, alias, oper, adm, speed, minspeed, type_enum, mac, monstatus, monerrors, monload, updated_on, created_on, montraffic
FROM interfaces
WHERE dev_id = $1
ORDER BY ifindex
`

// Relations
func (q *Queries) GetDeviceInterfaces(ctx context.Context, devID int64) ([]Interface, error) {
	rows, err := q.db.Query(ctx, GetDeviceInterfaces, devID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Interface
	for rows.Next() {
		var i Interface
		if err := rows.Scan(
			&i.IfID,
			&i.ConID,
			&i.Parent,
			&i.OtnIfID,
			&i.DevID,
			&i.EntID,
			&i.Ifindex,
			&i.Descr,
			&i.Alias,
			&i.Oper,
			&i.Adm,
			&i.Speed,
			&i.Minspeed,
			&i.TypeEnum,
			&i.Mac,
			&i.Monstatus,
			&i.Monerrors,
			&i.Monload,
			&i.UpdatedOn,
			&i.CreatedOn,
			&i.Montraffic,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const GetDeviceIpInterfaces = `-- name: GetDeviceIpInterfaces :many
SELECT ip_id, dev_id, ifindex, ip_addr, descr, alias, updated_on, created_on
FROM ip_interfaces
WHERE dev_id = $1
ORDER BY dev_id,
  descr
`

// Relations
func (q *Queries) GetDeviceIpInterfaces(ctx context.Context, devID int64) ([]IpInterface, error) {
	rows, err := q.db.Query(ctx, GetDeviceIpInterfaces, devID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []IpInterface
	for rows.Next() {
		var i IpInterface
		if err := rows.Scan(
			&i.IpID,
			&i.DevID,
			&i.Ifindex,
			&i.IpAddr,
			&i.Descr,
			&i.Alias,
			&i.UpdatedOn,
			&i.CreatedOn,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const GetDeviceOspfNbrs = `-- name: GetDeviceOspfNbrs :many
SELECT nbr_id, dev_id, nbr_ip, condition, updated_on, created_on
FROM ospf_nbrs
WHERE dev_id = $1
ORDER BY nbr_ip
`

// Relations
func (q *Queries) GetDeviceOspfNbrs(ctx context.Context, devID int64) ([]OspfNbr, error) {
	rows, err := q.db.Query(ctx, GetDeviceOspfNbrs, devID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []OspfNbr
	for rows.Next() {
		var i OspfNbr
		if err := rows.Scan(
			&i.NbrID,
			&i.DevID,
			&i.NbrIp,
			&i.Condition,
			&i.UpdatedOn,
			&i.CreatedOn,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const GetDeviceParent = `-- name: GetDeviceParent :one
SELECT t2.dev_id, t2.site_id, t2.dom_id, t2.snmp_main_id, t2.snmp_ro_id, t2.parent, t2.sys_id, t2.ip4_addr, t2.ip6_addr, t2.host_name, t2.sys_name, t2.sys_location, t2.sys_contact, t2.sw_version, t2.ext_model, t2.installed, t2.monitor, t2.graph, t2.backup, t2.source, t2.type_changed, t2.backup_failed, t2.validation_failed, t2.unresponsive, t2.notes, t2.updated_on, t2.created_on
FROM devices t1
  INNER JOIN devices t2 ON t2.dev_id = t1.parent
WHERE t1.dev_id = $1
`

// Foreign keys
func (q *Queries) GetDeviceParent(ctx context.Context, devID int64) (Device, error) {
	row := q.db.QueryRow(ctx, GetDeviceParent, devID)
	var i Device
	err := row.Scan(
		&i.DevID,
		&i.SiteID,
		&i.DomID,
		&i.SnmpMainID,
		&i.SnmpRoID,
		&i.Parent,
		&i.SysID,
		&i.Ip4Addr,
		&i.Ip6Addr,
		&i.HostName,
		&i.SysName,
		&i.SysLocation,
		&i.SysContact,
		&i.SwVersion,
		&i.ExtModel,
		&i.Installed,
		&i.Monitor,
		&i.Graph,
		&i.Backup,
		&i.Source,
		&i.TypeChanged,
		&i.BackupFailed,
		&i.ValidationFailed,
		&i.Unresponsive,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetDevicePeerXconnects = `-- name: GetDevicePeerXconnects :many
SELECT xc_id, dev_id, peer_dev_id, if_id, vc_idx, vc_id, peer_ip, peer_ifalias, xname, descr, op_stat, op_stat_in, op_stat_out, updated_on, created_on
FROM xconnects
WHERE peer_dev_id = $1
ORDER BY vc_id
`

// Relations
func (q *Queries) GetDevicePeerXconnects(ctx context.Context, peerDevID sql.NullInt64) ([]Xconnect, error) {
	rows, err := q.db.Query(ctx, GetDevicePeerXconnects, peerDevID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Xconnect
	for rows.Next() {
		var i Xconnect
		if err := rows.Scan(
			&i.XcID,
			&i.DevID,
			&i.PeerDevID,
			&i.IfID,
			&i.VcIdx,
			&i.VcID,
			&i.PeerIp,
			&i.PeerIfalias,
			&i.Xname,
			&i.Descr,
			&i.OpStat,
			&i.OpStatIn,
			&i.OpStatOut,
			&i.UpdatedOn,
			&i.CreatedOn,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const GetDeviceRlNbrs = `-- name: GetDeviceRlNbrs :many
SELECT nbr_id, dev_id, nbr_ent_id, nbr_sysname, updated_on, created_on
FROM rl_nbrs
WHERE dev_id = $1
ORDER BY nbr_sysname
`

// Relations
func (q *Queries) GetDeviceRlNbrs(ctx context.Context, devID int64) ([]RlNbr, error) {
	rows, err := q.db.Query(ctx, GetDeviceRlNbrs, devID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []RlNbr
	for rows.Next() {
		var i RlNbr
		if err := rows.Scan(
			&i.NbrID,
			&i.DevID,
			&i.NbrEntID,
			&i.NbrSysname,
			&i.UpdatedOn,
			&i.CreatedOn,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const GetDeviceSite = `-- name: GetDeviceSite :one
SELECT t2.site_id, t2.country_id, t2.uident, t2.descr, t2.latitude, t2.longitude, t2.area, t2.addr, t2.notes, t2.ext_id, t2.ext_name, t2.updated_on, t2.created_on
FROM devices t1
  INNER JOIN sites t2 ON t2.site_id = t1.site_id
WHERE t1.dev_id = $1
`

// Foreign keys
func (q *Queries) GetDeviceSite(ctx context.Context, devID int64) (Site, error) {
	row := q.db.QueryRow(ctx, GetDeviceSite, devID)
	var i Site
	err := row.Scan(
		&i.SiteID,
		&i.CountryID,
		&i.Uident,
		&i.Descr,
		&i.Latitude,
		&i.Longitude,
		&i.Area,
		&i.Addr,
		&i.Notes,
		&i.ExtID,
		&i.ExtName,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetDeviceSnmpCredentialsMain = `-- name: GetDeviceSnmpCredentialsMain :one
SELECT t2.snmp_cred_id, t2.label, t2.variant, t2.auth_name, t2.auth_proto, t2.auth_pass, t2.sec_level, t2.priv_proto, t2.priv_pass, t2.updated_on, t2.created_on
FROM devices t1
  INNER JOIN snmp_credentials t2 ON t2.snmp_cred_id = t1.snmp_main_id
WHERE t1.dev_id = $1
`

// Foreign keys
func (q *Queries) GetDeviceSnmpCredentialsMain(ctx context.Context, devID int64) (SnmpCredential, error) {
	row := q.db.QueryRow(ctx, GetDeviceSnmpCredentialsMain, devID)
	var i SnmpCredential
	err := row.Scan(
		&i.SnmpCredID,
		&i.Label,
		&i.Variant,
		&i.AuthName,
		&i.AuthProto,
		&i.AuthPass,
		&i.SecLevel,
		&i.PrivProto,
		&i.PrivPass,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetDeviceSnmpCredentialsRo = `-- name: GetDeviceSnmpCredentialsRo :one
SELECT t2.snmp_cred_id, t2.label, t2.variant, t2.auth_name, t2.auth_proto, t2.auth_pass, t2.sec_level, t2.priv_proto, t2.priv_pass, t2.updated_on, t2.created_on
FROM devices t1
  INNER JOIN snmp_credentials t2 ON t2.snmp_cred_id = t1.snmp_ro_id
WHERE t1.dev_id = $1
`

// Foreign keys
func (q *Queries) GetDeviceSnmpCredentialsRo(ctx context.Context, devID int64) (SnmpCredential, error) {
	row := q.db.QueryRow(ctx, GetDeviceSnmpCredentialsRo, devID)
	var i SnmpCredential
	err := row.Scan(
		&i.SnmpCredID,
		&i.Label,
		&i.Variant,
		&i.AuthName,
		&i.AuthProto,
		&i.AuthPass,
		&i.SecLevel,
		&i.PrivProto,
		&i.PrivPass,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetDeviceVlans = `-- name: GetDeviceVlans :many
SELECT v_id, dev_id, vlan, descr, updated_on, created_on
FROM vlans
WHERE dev_id = $1
ORDER BY vlan
`

// Relations
func (q *Queries) GetDeviceVlans(ctx context.Context, devID int64) ([]Vlan, error) {
	rows, err := q.db.Query(ctx, GetDeviceVlans, devID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Vlan
	for rows.Next() {
		var i Vlan
		if err := rows.Scan(
			&i.VID,
			&i.DevID,
			&i.Vlan,
			&i.Descr,
			&i.UpdatedOn,
			&i.CreatedOn,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const GetDeviceXconnects = `-- name: GetDeviceXconnects :many
SELECT xc_id, dev_id, peer_dev_id, if_id, vc_idx, vc_id, peer_ip, peer_ifalias, xname, descr, op_stat, op_stat_in, op_stat_out, updated_on, created_on
FROM xconnects
WHERE dev_id = $1
ORDER BY vc_id
`

// Relations
func (q *Queries) GetDeviceXconnects(ctx context.Context, devID int64) ([]Xconnect, error) {
	rows, err := q.db.Query(ctx, GetDeviceXconnects, devID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Xconnect
	for rows.Next() {
		var i Xconnect
		if err := rows.Scan(
			&i.XcID,
			&i.DevID,
			&i.PeerDevID,
			&i.IfID,
			&i.VcIdx,
			&i.VcID,
			&i.PeerIp,
			&i.PeerIfalias,
			&i.Xname,
			&i.Descr,
			&i.OpStat,
			&i.OpStatIn,
			&i.OpStatOut,
			&i.UpdatedOn,
			&i.CreatedOn,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const GetDevices = `-- name: GetDevices :many
SELECT dev_id, site_id, dom_id, snmp_main_id, snmp_ro_id, parent, sys_id, ip4_addr, ip6_addr, host_name, sys_name, sys_location, sys_contact, sw_version, ext_model, installed, monitor, graph, backup, source, type_changed, backup_failed, validation_failed, unresponsive, notes, updated_on, created_on
FROM devices
ORDER BY host_name
LIMIT $1
OFFSET $2
`

type GetDevicesParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) GetDevices(ctx context.Context, arg GetDevicesParams) ([]Device, error) {
	rows, err := q.db.Query(ctx, GetDevices, arg.Limit, arg.Offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Device
	for rows.Next() {
		var i Device
		if err := rows.Scan(
			&i.DevID,
			&i.SiteID,
			&i.DomID,
			&i.SnmpMainID,
			&i.SnmpRoID,
			&i.Parent,
			&i.SysID,
			&i.Ip4Addr,
			&i.Ip6Addr,
			&i.HostName,
			&i.SysName,
			&i.SysLocation,
			&i.SysContact,
			&i.SwVersion,
			&i.ExtModel,
			&i.Installed,
			&i.Monitor,
			&i.Graph,
			&i.Backup,
			&i.Source,
			&i.TypeChanged,
			&i.BackupFailed,
			&i.ValidationFailed,
			&i.Unresponsive,
			&i.Notes,
			&i.UpdatedOn,
			&i.CreatedOn,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const UpdateDevice = `-- name: UpdateDevice :one
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
RETURNING dev_id, site_id, dom_id, snmp_main_id, snmp_ro_id, parent, sys_id, ip4_addr, ip6_addr, host_name, sys_name, sys_location, sys_contact, sw_version, ext_model, installed, monitor, graph, backup, source, type_changed, backup_failed, validation_failed, unresponsive, notes, updated_on, created_on
`

type UpdateDeviceParams struct {
	DevID            int64          `json:"dev_id"`
	SiteID           sql.NullInt64  `json:"site_id"`
	DomID            int64          `json:"dom_id"`
	SnmpMainID       sql.NullInt64  `json:"snmp_main_id"`
	SnmpRoID         sql.NullInt64  `json:"snmp_ro_id"`
	Parent           sql.NullInt64  `json:"parent"`
	SysID            string         `json:"sys_id"`
	Ip4Addr          pgtype.Inet    `json:"ip4_addr"`
	Ip6Addr          pgtype.Inet    `json:"ip6_addr"`
	HostName         string         `json:"host_name"`
	SysName          sql.NullString `json:"sys_name"`
	SysLocation      sql.NullString `json:"sys_location"`
	SysContact       sql.NullString `json:"sys_contact"`
	SwVersion        sql.NullString `json:"sw_version"`
	ExtModel         sql.NullString `json:"ext_model"`
	Installed        bool           `json:"installed"`
	Monitor          bool           `json:"monitor"`
	Graph            bool           `json:"graph"`
	Backup           bool           `json:"backup"`
	Source           string         `json:"source"`
	TypeChanged      bool           `json:"type_changed"`
	BackupFailed     bool           `json:"backup_failed"`
	ValidationFailed bool           `json:"validation_failed"`
	Unresponsive     bool           `json:"unresponsive"`
	Notes            sql.NullString `json:"notes"`
}

func (q *Queries) UpdateDevice(ctx context.Context, arg UpdateDeviceParams) (Device, error) {
	row := q.db.QueryRow(ctx, UpdateDevice,
		arg.DevID,
		arg.SiteID,
		arg.DomID,
		arg.SnmpMainID,
		arg.SnmpRoID,
		arg.Parent,
		arg.SysID,
		arg.Ip4Addr,
		arg.Ip6Addr,
		arg.HostName,
		arg.SysName,
		arg.SysLocation,
		arg.SysContact,
		arg.SwVersion,
		arg.ExtModel,
		arg.Installed,
		arg.Monitor,
		arg.Graph,
		arg.Backup,
		arg.Source,
		arg.TypeChanged,
		arg.BackupFailed,
		arg.ValidationFailed,
		arg.Unresponsive,
		arg.Notes,
	)
	var i Device
	err := row.Scan(
		&i.DevID,
		&i.SiteID,
		&i.DomID,
		&i.SnmpMainID,
		&i.SnmpRoID,
		&i.Parent,
		&i.SysID,
		&i.Ip4Addr,
		&i.Ip6Addr,
		&i.HostName,
		&i.SysName,
		&i.SysLocation,
		&i.SysContact,
		&i.SwVersion,
		&i.ExtModel,
		&i.Installed,
		&i.Monitor,
		&i.Graph,
		&i.Backup,
		&i.Source,
		&i.TypeChanged,
		&i.BackupFailed,
		&i.ValidationFailed,
		&i.Unresponsive,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
