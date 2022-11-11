// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.15.0
// source: device_extensions.sql

package godevmandb

import (
	"context"
	"database/sql"
)

const CountDeviceExtensions = `-- name: CountDeviceExtensions :one
SELECT COUNT(*)
FROM device_extensions
`

func (q *Queries) CountDeviceExtensions(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountDeviceExtensions)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateDeviceExtension = `-- name: CreateDeviceExtension :one
INSERT INTO device_extensions (dev_id, field, content)
VALUES ($1, $2, $3)
RETURNING ext_id, dev_id, field, content, updated_on, created_on
`

type CreateDeviceExtensionParams struct {
	DevID   int64          `json:"dev_id"`
	Field   string         `json:"field"`
	Content sql.NullString `json:"content"`
}

func (q *Queries) CreateDeviceExtension(ctx context.Context, arg CreateDeviceExtensionParams) (DeviceExtension, error) {
	row := q.db.QueryRow(ctx, CreateDeviceExtension, arg.DevID, arg.Field, arg.Content)
	var i DeviceExtension
	err := row.Scan(
		&i.ExtID,
		&i.DevID,
		&i.Field,
		&i.Content,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteDeviceExtension = `-- name: DeleteDeviceExtension :exec
DELETE FROM device_extensions
WHERE ext_id = $1
`

func (q *Queries) DeleteDeviceExtension(ctx context.Context, extID int64) error {
	_, err := q.db.Exec(ctx, DeleteDeviceExtension, extID)
	return err
}

const GetDeviceExtension = `-- name: GetDeviceExtension :one
SELECT ext_id, dev_id, field, content, updated_on, created_on
FROM device_extensions
WHERE ext_id = $1
`

func (q *Queries) GetDeviceExtension(ctx context.Context, extID int64) (DeviceExtension, error) {
	row := q.db.QueryRow(ctx, GetDeviceExtension, extID)
	var i DeviceExtension
	err := row.Scan(
		&i.ExtID,
		&i.DevID,
		&i.Field,
		&i.Content,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetDeviceExtensionDevice = `-- name: GetDeviceExtensionDevice :one
SELECT t2.dev_id, t2.site_id, t2.dom_id, t2.snmp_main_id, t2.snmp_ro_id, t2.parent, t2.sys_id, t2.ip4_addr, t2.ip6_addr, t2.host_name, t2.sys_name, t2.sys_location, t2.sys_contact, t2.sw_version, t2.ext_model, t2.installed, t2.monitor, t2.graph, t2.backup, t2.source, t2.type_changed, t2.backup_failed, t2.validation_failed, t2.unresponsive, t2.notes, t2.updated_on, t2.created_on
FROM device_extensions t1
  INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.ext_id = $1
`

// Foreign keys
func (q *Queries) GetDeviceExtensionDevice(ctx context.Context, extID int64) (Device, error) {
	row := q.db.QueryRow(ctx, GetDeviceExtensionDevice, extID)
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

const GetDeviceExtensions = `-- name: GetDeviceExtensions :many
SELECT ext_id, dev_id, field, content, updated_on, created_on
FROM device_extensions
ORDER BY dev_id, field
LIMIT $1
OFFSET $2
`

type GetDeviceExtensionsParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) GetDeviceExtensions(ctx context.Context, arg GetDeviceExtensionsParams) ([]DeviceExtension, error) {
	rows, err := q.db.Query(ctx, GetDeviceExtensions, arg.Limit, arg.Offset)
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

const UpdateDeviceExtension = `-- name: UpdateDeviceExtension :one
UPDATE device_extensions
SET dev_id = $2,
  field = $3,
  content = $4
WHERE ext_id = $1
RETURNING ext_id, dev_id, field, content, updated_on, created_on
`

type UpdateDeviceExtensionParams struct {
	ExtID   int64          `json:"ext_id"`
	DevID   int64          `json:"dev_id"`
	Field   string         `json:"field"`
	Content sql.NullString `json:"content"`
}

func (q *Queries) UpdateDeviceExtension(ctx context.Context, arg UpdateDeviceExtensionParams) (DeviceExtension, error) {
	row := q.db.QueryRow(ctx, UpdateDeviceExtension,
		arg.ExtID,
		arg.DevID,
		arg.Field,
		arg.Content,
	)
	var i DeviceExtension
	err := row.Scan(
		&i.ExtID,
		&i.DevID,
		&i.Field,
		&i.Content,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
