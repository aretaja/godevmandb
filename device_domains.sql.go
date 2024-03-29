// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.17.0
// source: device_domains.sql

package godevmandb

import (
	"context"
	"time"
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
WHERE (
    $1::TIMESTAMPTZ = '0001-01-01 00:00:00+00'
    OR updated_on >= $1
  )
  AND (
    $2::TIMESTAMPTZ = '0001-01-01 00:00:00+00'
    OR updated_on <= $2
  )
  AND (
    $3::TIMESTAMPTZ = '0001-01-01 00:00:00+00'
    OR created_on >= $3
  )
  AND (
    $4::TIMESTAMPTZ = '0001-01-01 00:00:00+00'
    OR created_on <= $4
  )
  AND (
    $5::text = ''
    OR descr ILIKE $5
  )
ORDER BY created_on
LIMIT NULLIF($7::int, 0) OFFSET NULLIF($6::int, 0)
`

type GetDeviceDomainsParams struct {
	UpdatedGe time.Time `json:"updated_ge"`
	UpdatedLe time.Time `json:"updated_le"`
	CreatedGe time.Time `json:"created_ge"`
	CreatedLe time.Time `json:"created_le"`
	DescrF    string    `json:"descr_f"`
	OffsetQ   int32     `json:"offset_q"`
	LimitQ    int32     `json:"limit_q"`
}

func (q *Queries) GetDeviceDomains(ctx context.Context, arg GetDeviceDomainsParams) ([]DeviceDomain, error) {
	rows, err := q.db.Query(ctx, GetDeviceDomains,
		arg.UpdatedGe,
		arg.UpdatedLe,
		arg.CreatedGe,
		arg.CreatedLe,
		arg.DescrF,
		arg.OffsetQ,
		arg.LimitQ,
	)
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
