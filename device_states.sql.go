// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.15.0
// source: device_states.sql

package godevmandb

import (
	"context"
	"database/sql"
)

const CountDeviceStates = `-- name: CountDeviceStates :one
SELECT COUNT(*)
FROM device_states
`

func (q *Queries) CountDeviceStates(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountDeviceStates)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateDeviceState = `-- name: CreateDeviceState :one
INSERT INTO device_states (dev_id, up_time, down_time, method)
VALUES ($1, $2, $3, $4)
RETURNING dev_id, up_time, down_time, method, updated_on, created_on
`

type CreateDeviceStateParams struct {
	DevID    int64        `json:"dev_id"`
	UpTime   sql.NullTime `json:"up_time"`
	DownTime sql.NullTime `json:"down_time"`
	Method   string       `json:"method"`
}

func (q *Queries) CreateDeviceState(ctx context.Context, arg CreateDeviceStateParams) (DeviceState, error) {
	row := q.db.QueryRow(ctx, CreateDeviceState,
		arg.DevID,
		arg.UpTime,
		arg.DownTime,
		arg.Method,
	)
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

const DeleteDeviceState = `-- name: DeleteDeviceState :exec
DELETE FROM device_states
WHERE dev_id = $1
`

func (q *Queries) DeleteDeviceState(ctx context.Context, devID int64) error {
	_, err := q.db.Exec(ctx, DeleteDeviceState, devID)
	return err
}

const GetDeviceState = `-- name: GetDeviceState :one
SELECT dev_id, up_time, down_time, method, updated_on, created_on
FROM device_states
WHERE dev_id = $1
`

func (q *Queries) GetDeviceState(ctx context.Context, devID int64) (DeviceState, error) {
	row := q.db.QueryRow(ctx, GetDeviceState, devID)
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

const GetDeviceStateDevice = `-- name: GetDeviceStateDevice :one
SELECT t2.dev_id, t2.site_id, t2.dom_id, t2.snmp_main_id, t2.snmp_ro_id, t2.parent, t2.sys_id, t2.ip4_addr, t2.ip6_addr, t2.host_name, t2.sys_name, t2.sys_location, t2.sys_contact, t2.sw_version, t2.ext_model, t2.installed, t2.monitor, t2.graph, t2.backup, t2.source, t2.type_changed, t2.backup_failed, t2.validation_failed, t2.unresponsive, t2.notes, t2.updated_on, t2.created_on
FROM device_states t1
  INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.dev_id = $1
`

// Foreign keys
func (q *Queries) GetDeviceStateDevice(ctx context.Context, devID int64) (Device, error) {
	row := q.db.QueryRow(ctx, GetDeviceStateDevice, devID)
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

const GetDeviceStates = `-- name: GetDeviceStates :many
SELECT dev_id, up_time, down_time, method, updated_on, created_on
FROM device_states
ORDER BY updated_on
`

func (q *Queries) GetDeviceStates(ctx context.Context) ([]DeviceState, error) {
	rows, err := q.db.Query(ctx, GetDeviceStates)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []DeviceState
	for rows.Next() {
		var i DeviceState
		if err := rows.Scan(
			&i.DevID,
			&i.UpTime,
			&i.DownTime,
			&i.Method,
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

const UpdateDeviceState = `-- name: UpdateDeviceState :one
UPDATE device_states
SET up_time = $2,
  down_time = $3,
  method = $4
WHERE dev_id = $1
RETURNING dev_id, up_time, down_time, method, updated_on, created_on
`

type UpdateDeviceStateParams struct {
	DevID    int64        `json:"dev_id"`
	UpTime   sql.NullTime `json:"up_time"`
	DownTime sql.NullTime `json:"down_time"`
	Method   string       `json:"method"`
}

func (q *Queries) UpdateDeviceState(ctx context.Context, arg UpdateDeviceStateParams) (DeviceState, error) {
	row := q.db.QueryRow(ctx, UpdateDeviceState,
		arg.DevID,
		arg.UpTime,
		arg.DownTime,
		arg.Method,
	)
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
