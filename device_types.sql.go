// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.16.0
// source: device_types.sql

package godevmandb

import (
	"context"
)

const CountDeviceTypes = `-- name: CountDeviceTypes :one
SELECT COUNT(*)
FROM device_types
`

func (q *Queries) CountDeviceTypes(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountDeviceTypes)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateDeviceType = `-- name: CreateDeviceType :one
INSERT INTO device_types (
    sys_id,
    class_id,
    manufacturer,
    model,
    hc,
    snmp_ver
  )
VALUES ($1, $2, $3, $4, $5, $6)
RETURNING sys_id, class_id, manufacturer, model, hc, snmp_ver, updated_on, created_on
`

type CreateDeviceTypeParams struct {
	SysID        string `json:"sys_id"`
	ClassID      int32  `json:"class_id"`
	Manufacturer string `json:"manufacturer"`
	Model        string `json:"model"`
	Hc           bool   `json:"hc"`
	SnmpVer      int16  `json:"snmp_ver"`
}

func (q *Queries) CreateDeviceType(ctx context.Context, arg CreateDeviceTypeParams) (DeviceType, error) {
	row := q.db.QueryRow(ctx, CreateDeviceType,
		arg.SysID,
		arg.ClassID,
		arg.Manufacturer,
		arg.Model,
		arg.Hc,
		arg.SnmpVer,
	)
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

const DeleteDeviceType = `-- name: DeleteDeviceType :exec
DELETE FROM device_types
WHERE sys_id = $1
`

func (q *Queries) DeleteDeviceType(ctx context.Context, sysID string) error {
	_, err := q.db.Exec(ctx, DeleteDeviceType, sysID)
	return err
}

const GetDeviceType = `-- name: GetDeviceType :one
SELECT sys_id, class_id, manufacturer, model, hc, snmp_ver, updated_on, created_on
FROM device_types
WHERE sys_id = $1
`

func (q *Queries) GetDeviceType(ctx context.Context, sysID string) (DeviceType, error) {
	row := q.db.QueryRow(ctx, GetDeviceType, sysID)
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

const GetDeviceTypeDeviceClass = `-- name: GetDeviceTypeDeviceClass :one
SELECT t2.class_id, t2.descr, t2.updated_on, t2.created_on
FROM device_types t1
  INNER JOIN device_classes t2 ON t2.class_id = t1.class_id
WHERE t1.sys_id = $1
`

// Foreign keys
func (q *Queries) GetDeviceTypeDeviceClass(ctx context.Context, sysID string) (DeviceClass, error) {
	row := q.db.QueryRow(ctx, GetDeviceTypeDeviceClass, sysID)
	var i DeviceClass
	err := row.Scan(
		&i.ClassID,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetDeviceTypeDevices = `-- name: GetDeviceTypeDevices :many
SELECT dev_id, site_id, dom_id, snmp_main_id, snmp_ro_id, parent, sys_id, ip4_addr, ip6_addr, host_name, sys_name, sys_location, sys_contact, sw_version, ext_model, installed, monitor, graph, backup, source, type_changed, backup_failed, validation_failed, unresponsive, notes, updated_on, created_on
FROM devices
WHERE sys_id = $1
ORDER BY host_name
`

// Relations
func (q *Queries) GetDeviceTypeDevices(ctx context.Context, sysID string) ([]Device, error) {
	rows, err := q.db.Query(ctx, GetDeviceTypeDevices, sysID)
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

const GetDeviceTypes = `-- name: GetDeviceTypes :many
SELECT sys_id, class_id, manufacturer, model, hc, snmp_ver, updated_on, created_on
FROM device_types
ORDER BY manufacturer, model
LIMIT $1
OFFSET $2
`

type GetDeviceTypesParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) GetDeviceTypes(ctx context.Context, arg GetDeviceTypesParams) ([]DeviceType, error) {
	rows, err := q.db.Query(ctx, GetDeviceTypes, arg.Limit, arg.Offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []DeviceType
	for rows.Next() {
		var i DeviceType
		if err := rows.Scan(
			&i.SysID,
			&i.ClassID,
			&i.Manufacturer,
			&i.Model,
			&i.Hc,
			&i.SnmpVer,
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

const UpdateDeviceType = `-- name: UpdateDeviceType :one
UPDATE device_types
SET class_id = $2,
  manufacturer = $3,
  model = $4,
  hc = $5,
  snmp_ver = $6
WHERE sys_id = $1
RETURNING sys_id, class_id, manufacturer, model, hc, snmp_ver, updated_on, created_on
`

type UpdateDeviceTypeParams struct {
	SysID        string `json:"sys_id"`
	ClassID      int32  `json:"class_id"`
	Manufacturer string `json:"manufacturer"`
	Model        string `json:"model"`
	Hc           bool   `json:"hc"`
	SnmpVer      int16  `json:"snmp_ver"`
}

func (q *Queries) UpdateDeviceType(ctx context.Context, arg UpdateDeviceTypeParams) (DeviceType, error) {
	row := q.db.QueryRow(ctx, UpdateDeviceType,
		arg.SysID,
		arg.ClassID,
		arg.Manufacturer,
		arg.Model,
		arg.Hc,
		arg.SnmpVer,
	)
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
