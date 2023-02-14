// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.17.0
// source: vlans.sql

package godevmandb

import (
	"context"
	"database/sql"
)

const CountVlans = `-- name: CountVlans :one
SELECT COUNT(*)
FROM vlans
`

func (q *Queries) CountVlans(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountVlans)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateVlan = `-- name: CreateVlan :one
INSERT INTO vlans (dev_id, vlan, descr)
VALUES ($1, $2, $3)
RETURNING v_id, dev_id, vlan, descr, updated_on, created_on
`

type CreateVlanParams struct {
	DevID int64          `json:"dev_id"`
	Vlan  int64          `json:"vlan"`
	Descr sql.NullString `json:"descr"`
}

func (q *Queries) CreateVlan(ctx context.Context, arg CreateVlanParams) (Vlan, error) {
	row := q.db.QueryRow(ctx, CreateVlan, arg.DevID, arg.Vlan, arg.Descr)
	var i Vlan
	err := row.Scan(
		&i.VID,
		&i.DevID,
		&i.Vlan,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteVlan = `-- name: DeleteVlan :exec
DELETE FROM vlans
WHERE v_id = $1
`

func (q *Queries) DeleteVlan(ctx context.Context, vID int64) error {
	_, err := q.db.Exec(ctx, DeleteVlan, vID)
	return err
}

const GetVlan = `-- name: GetVlan :one
SELECT v_id, dev_id, vlan, descr, updated_on, created_on
FROM vlans
WHERE v_id = $1
`

func (q *Queries) GetVlan(ctx context.Context, vID int64) (Vlan, error) {
	row := q.db.QueryRow(ctx, GetVlan, vID)
	var i Vlan
	err := row.Scan(
		&i.VID,
		&i.DevID,
		&i.Vlan,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetVlanDevice = `-- name: GetVlanDevice :one
SELECT t2.dev_id, t2.site_id, t2.dom_id, t2.snmp_main_id, t2.snmp_ro_id, t2.parent, t2.sys_id, t2.ip4_addr, t2.ip6_addr, t2.host_name, t2.sys_name, t2.sys_location, t2.sys_contact, t2.sw_version, t2.ext_model, t2.installed, t2.monitor, t2.graph, t2.backup, t2.source, t2.type_changed, t2.backup_failed, t2.validation_failed, t2.unresponsive, t2.notes, t2.updated_on, t2.created_on
FROM vlans t1
  INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.v_id = $1
`

// Foreign keys
func (q *Queries) GetVlanDevice(ctx context.Context, vID int64) (Device, error) {
	row := q.db.QueryRow(ctx, GetVlanDevice, vID)
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

const GetVlanInterfaces = `-- name: GetVlanInterfaces :many
SELECT t3.if_id, t3.con_id, t3.parent, t3.otn_if_id, t3.dev_id, t3.ent_id, t3.ifindex, t3.descr, t3.alias, t3.oper, t3.adm, t3.speed, t3.minspeed, t3.type_enum, t3.mac, t3.monstatus, t3.monerrors, t3.monload, t3.updated_on, t3.created_on, t3.montraffic
FROM vlans t1
  INNER JOIN interfaces2vlans t2 ON t2.v_id = t1.v_id
  INNER JOIN interfaces t3 ON t3.if_id = t2.if_id
WHERE t1.v_id = $1
ORDER BY dev_id
`

// Relations
func (q *Queries) GetVlanInterfaces(ctx context.Context, vID int64) ([]Interface, error) {
	rows, err := q.db.Query(ctx, GetVlanInterfaces, vID)
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

const GetVlans = `-- name: GetVlans :many
SELECT v_id, dev_id, vlan, descr, updated_on, created_on
FROM vlans
ORDER BY dev_id, vlan
LIMIT $1
OFFSET $2
`

type GetVlansParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) GetVlans(ctx context.Context, arg GetVlansParams) ([]Vlan, error) {
	rows, err := q.db.Query(ctx, GetVlans, arg.Limit, arg.Offset)
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

const UpdateVlan = `-- name: UpdateVlan :one
UPDATE vlans
SET dev_id = $2,
  vlan = $3,
  descr = $4
WHERE v_id = $1
RETURNING v_id, dev_id, vlan, descr, updated_on, created_on
`

type UpdateVlanParams struct {
	VID   int64          `json:"v_id"`
	DevID int64          `json:"dev_id"`
	Vlan  int64          `json:"vlan"`
	Descr sql.NullString `json:"descr"`
}

func (q *Queries) UpdateVlan(ctx context.Context, arg UpdateVlanParams) (Vlan, error) {
	row := q.db.QueryRow(ctx, UpdateVlan,
		arg.VID,
		arg.DevID,
		arg.Vlan,
		arg.Descr,
	)
	var i Vlan
	err := row.Scan(
		&i.VID,
		&i.DevID,
		&i.Vlan,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
