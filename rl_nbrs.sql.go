// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.15.0
// source: rl_nbrs.sql

package godevmandb

import (
	"context"
	"database/sql"
)

const CountRlfNbrs = `-- name: CountRlfNbrs :one
SELECT COUNT(*)
FROM rl_nbrs
`

func (q *Queries) CountRlfNbrs(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountRlfNbrs)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateRlfNbr = `-- name: CreateRlfNbr :one
INSERT INTO rl_nbrs (
        dev_id,
        nbr_ent_id,
        nbr_sysname
    )
VALUES ($1, $2, $3)
RETURNING nbr_id, dev_id, nbr_ent_id, nbr_sysname, updated_on, created_on
`

type CreateRlfNbrParams struct {
	DevID      int64         `json:"dev_id"`
	NbrEntID   sql.NullInt64 `json:"nbr_ent_id"`
	NbrSysname string        `json:"nbr_sysname"`
}

func (q *Queries) CreateRlfNbr(ctx context.Context, arg CreateRlfNbrParams) (RlNbr, error) {
	row := q.db.QueryRow(ctx, CreateRlfNbr, arg.DevID, arg.NbrEntID, arg.NbrSysname)
	var i RlNbr
	err := row.Scan(
		&i.NbrID,
		&i.DevID,
		&i.NbrEntID,
		&i.NbrSysname,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteRlfNbr = `-- name: DeleteRlfNbr :exec
DELETE FROM rl_nbrs
WHERE nbr_id = $1
`

func (q *Queries) DeleteRlfNbr(ctx context.Context, nbrID int64) error {
	_, err := q.db.Exec(ctx, DeleteRlfNbr, nbrID)
	return err
}

const GetRlfNbr = `-- name: GetRlfNbr :one
SELECT nbr_id, dev_id, nbr_ent_id, nbr_sysname, updated_on, created_on
FROM rl_nbrs
WHERE nbr_id = $1
`

func (q *Queries) GetRlfNbr(ctx context.Context, nbrID int64) (RlNbr, error) {
	row := q.db.QueryRow(ctx, GetRlfNbr, nbrID)
	var i RlNbr
	err := row.Scan(
		&i.NbrID,
		&i.DevID,
		&i.NbrEntID,
		&i.NbrSysname,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetRlfNbrDevice = `-- name: GetRlfNbrDevice :one
SELECT t2.dev_id, t2.site_id, t2.dom_id, t2.snmp_main_id, t2.snmp_ro_id, t2.parent, t2.sys_id, t2.ip4_addr, t2.ip6_addr, t2.host_name, t2.sys_name, t2.sys_location, t2.sys_contact, t2.sw_version, t2.ext_model, t2.installed, t2.monitor, t2.graph, t2.backup, t2.source, t2.type_changed, t2.backup_failed, t2.validation_failed, t2.unresponsive, t2.notes, t2.updated_on, t2.created_on
FROM rl_nbrs t1
    INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.nbr_id = $1
`

// Foreign keys
func (q *Queries) GetRlfNbrDevice(ctx context.Context, nbrID int64) (Device, error) {
	row := q.db.QueryRow(ctx, GetRlfNbrDevice, nbrID)
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

const GetRlfNbrEntity = `-- name: GetRlfNbrEntity :one
SELECT t2.ent_id, t2.parent_ent_id, t2.snmp_ent_id, t2.dev_id, t2.slot, t2.descr, t2.model, t2.hw_product, t2.hw_revision, t2.serial_nr, t2.sw_product, t2.sw_revision, t2.manufacturer, t2.physical, t2.updated_on, t2.created_on
FROM rl_nbrs t1
    INNER JOIN entities t2 ON t2.ent_id = t1.nbr_ent_id
WHERE t1.nbr_id = $1
`

// Foreign keys
func (q *Queries) GetRlfNbrEntity(ctx context.Context, nbrID int64) (Entity, error) {
	row := q.db.QueryRow(ctx, GetRlfNbrEntity, nbrID)
	var i Entity
	err := row.Scan(
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
	)
	return i, err
}

const GetRlfNbrs = `-- name: GetRlfNbrs :many
SELECT nbr_id, dev_id, nbr_ent_id, nbr_sysname, updated_on, created_on
FROM rl_nbrs
ORDER BY nbr_sysname
LIMIT $1
OFFSET $2
`

type GetRlfNbrsParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) GetRlfNbrs(ctx context.Context, arg GetRlfNbrsParams) ([]RlNbr, error) {
	rows, err := q.db.Query(ctx, GetRlfNbrs, arg.Limit, arg.Offset)
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

const UpdateRlfNbr = `-- name: UpdateRlfNbr :one
UPDATE rl_nbrs
SET dev_id = $2,
    nbr_ent_id = $3,
    nbr_sysname = $4
WHERE nbr_id = $1
RETURNING nbr_id, dev_id, nbr_ent_id, nbr_sysname, updated_on, created_on
`

type UpdateRlfNbrParams struct {
	NbrID      int64         `json:"nbr_id"`
	DevID      int64         `json:"dev_id"`
	NbrEntID   sql.NullInt64 `json:"nbr_ent_id"`
	NbrSysname string        `json:"nbr_sysname"`
}

func (q *Queries) UpdateRlfNbr(ctx context.Context, arg UpdateRlfNbrParams) (RlNbr, error) {
	row := q.db.QueryRow(ctx, UpdateRlfNbr,
		arg.NbrID,
		arg.DevID,
		arg.NbrEntID,
		arg.NbrSysname,
	)
	var i RlNbr
	err := row.Scan(
		&i.NbrID,
		&i.DevID,
		&i.NbrEntID,
		&i.NbrSysname,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
