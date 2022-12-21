// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.16.0
// source: device_domains.sql

package godevmandb

import (
	"context"
)

const CountDeviceDomains = `-- name: CountDeviceDomains :one
SELECT COUNT(*)
FROM device_domains
`

func (q *Queries) CountDeviceDomains(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountDeviceDomains)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateDeviceDomain = `-- name: CreateDeviceDomain :one
INSERT INTO device_domains (descr)
VALUES ($1)
RETURNING dom_id, descr, updated_on, created_on
`

func (q *Queries) CreateDeviceDomain(ctx context.Context, descr string) (DeviceDomain, error) {
	row := q.db.QueryRow(ctx, CreateDeviceDomain, descr)
	var i DeviceDomain
	err := row.Scan(
		&i.DomID,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteDeviceDomain = `-- name: DeleteDeviceDomain :exec
DELETE FROM device_domains
WHERE dom_id = $1
`

func (q *Queries) DeleteDeviceDomain(ctx context.Context, domID int64) error {
	_, err := q.db.Exec(ctx, DeleteDeviceDomain, domID)
	return err
}

const GetDeviceDomain = `-- name: GetDeviceDomain :one
SELECT dom_id, descr, updated_on, created_on
FROM device_domains
WHERE dom_id = $1
`

func (q *Queries) GetDeviceDomain(ctx context.Context, domID int64) (DeviceDomain, error) {
	row := q.db.QueryRow(ctx, GetDeviceDomain, domID)
	var i DeviceDomain
	err := row.Scan(
		&i.DomID,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetDeviceDomainDevices = `-- name: GetDeviceDomainDevices :many
SELECT dev_id, site_id, dom_id, snmp_main_id, snmp_ro_id, parent, sys_id, ip4_addr, ip6_addr, host_name, sys_name, sys_location, sys_contact, sw_version, ext_model, installed, monitor, graph, backup, source, type_changed, backup_failed, validation_failed, unresponsive, notes, updated_on, created_on
FROM devices
WHERE dom_id = $1
ORDER BY host_name
`

// Relations
func (q *Queries) GetDeviceDomainDevices(ctx context.Context, domID int64) ([]Device, error) {
	rows, err := q.db.Query(ctx, GetDeviceDomainDevices, domID)
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

const GetDeviceDomainUserAuthzs = `-- name: GetDeviceDomainUserAuthzs :many
SELECT username, dom_id, userlevel, updated_on, created_on
FROM user_authzs
WHERE dom_id = $1
ORDER BY username
`

func (q *Queries) GetDeviceDomainUserAuthzs(ctx context.Context, domID int64) ([]UserAuthz, error) {
	rows, err := q.db.Query(ctx, GetDeviceDomainUserAuthzs, domID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []UserAuthz
	for rows.Next() {
		var i UserAuthz
		if err := rows.Scan(
			&i.Username,
			&i.DomID,
			&i.Userlevel,
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

const GetDeviceDomains = `-- name: GetDeviceDomains :many
SELECT dom_id, descr, updated_on, created_on
FROM device_domains
ORDER BY descr
LIMIT $1
OFFSET $2
`

type GetDeviceDomainsParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) GetDeviceDomains(ctx context.Context, arg GetDeviceDomainsParams) ([]DeviceDomain, error) {
	rows, err := q.db.Query(ctx, GetDeviceDomains, arg.Limit, arg.Offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []DeviceDomain
	for rows.Next() {
		var i DeviceDomain
		if err := rows.Scan(
			&i.DomID,
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

const UpdateDeviceDomain = `-- name: UpdateDeviceDomain :one
UPDATE device_domains
SET descr = $2
WHERE dom_id = $1
RETURNING dom_id, descr, updated_on, created_on
`

type UpdateDeviceDomainParams struct {
	DomID int64  `json:"dom_id"`
	Descr string `json:"descr"`
}

func (q *Queries) UpdateDeviceDomain(ctx context.Context, arg UpdateDeviceDomainParams) (DeviceDomain, error) {
	row := q.db.QueryRow(ctx, UpdateDeviceDomain, arg.DomID, arg.Descr)
	var i DeviceDomain
	err := row.Scan(
		&i.DomID,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
