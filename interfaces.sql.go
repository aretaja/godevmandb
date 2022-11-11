// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.15.0
// source: interfaces.sql

package godevmandb

import (
	"context"
	"database/sql"

	"github.com/jackc/pgtype"
)

const CountInterfaces = `-- name: CountInterfaces :one
SELECT COUNT(*)
FROM interfaces
`

func (q *Queries) CountInterfaces(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountInterfaces)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateInterface = `-- name: CreateInterface :one
INSERT INTO interfaces (
    con_id,
    parent,
    otn_if_id,
    dev_id,
    ent_id,
    ifindex,
    descr,
    alias,
    oper,
    adm,
    speed,
    minspeed,
    type_enum,
    mac,
    monstatus,
    monerrors,
    monload,
    montraffic
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
    $18
  )
RETURNING if_id, con_id, parent, otn_if_id, dev_id, ent_id, ifindex, descr, alias, oper, adm, speed, minspeed, type_enum, mac, monstatus, monerrors, monload, updated_on, created_on, montraffic
`

type CreateInterfaceParams struct {
	ConID      sql.NullInt64  `json:"con_id"`
	Parent     sql.NullInt64  `json:"parent"`
	OtnIfID    sql.NullInt64  `json:"otn_if_id"`
	DevID      int64          `json:"dev_id"`
	EntID      sql.NullInt64  `json:"ent_id"`
	Ifindex    sql.NullInt64  `json:"ifindex"`
	Descr      string         `json:"descr"`
	Alias      sql.NullString `json:"alias"`
	Oper       sql.NullInt16  `json:"oper"`
	Adm        sql.NullInt16  `json:"adm"`
	Speed      sql.NullInt64  `json:"speed"`
	Minspeed   sql.NullInt64  `json:"minspeed"`
	TypeEnum   sql.NullInt16  `json:"type_enum"`
	Mac        pgtype.Macaddr `json:"mac"`
	Monstatus  int16          `json:"monstatus"`
	Monerrors  int16          `json:"monerrors"`
	Monload    int16          `json:"monload"`
	Montraffic int16          `json:"montraffic"`
}

func (q *Queries) CreateInterface(ctx context.Context, arg CreateInterfaceParams) (Interface, error) {
	row := q.db.QueryRow(ctx, CreateInterface,
		arg.ConID,
		arg.Parent,
		arg.OtnIfID,
		arg.DevID,
		arg.EntID,
		arg.Ifindex,
		arg.Descr,
		arg.Alias,
		arg.Oper,
		arg.Adm,
		arg.Speed,
		arg.Minspeed,
		arg.TypeEnum,
		arg.Mac,
		arg.Monstatus,
		arg.Monerrors,
		arg.Monload,
		arg.Montraffic,
	)
	var i Interface
	err := row.Scan(
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
	)
	return i, err
}

const DeleteInterface = `-- name: DeleteInterface :exec
DELETE FROM interfaces
WHERE if_id = $1
`

func (q *Queries) DeleteInterface(ctx context.Context, ifID int64) error {
	_, err := q.db.Exec(ctx, DeleteInterface, ifID)
	return err
}

const GetInterface = `-- name: GetInterface :one
SELECT if_id, con_id, parent, otn_if_id, dev_id, ent_id, ifindex, descr, alias, oper, adm, speed, minspeed, type_enum, mac, monstatus, monerrors, monload, updated_on, created_on, montraffic
FROM interfaces
WHERE if_id = $1
`

func (q *Queries) GetInterface(ctx context.Context, ifID int64) (Interface, error) {
	row := q.db.QueryRow(ctx, GetInterface, ifID)
	var i Interface
	err := row.Scan(
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
	)
	return i, err
}

const GetInterfaceChilds = `-- name: GetInterfaceChilds :many
SELECT t2.if_id, t2.con_id, t2.parent, t2.otn_if_id, t2.dev_id, t2.ent_id, t2.ifindex, t2.descr, t2.alias, t2.oper, t2.adm, t2.speed, t2.minspeed, t2.type_enum, t2.mac, t2.monstatus, t2.monerrors, t2.monload, t2.updated_on, t2.created_on, t2.montraffic
FROM interfaces t1
  INNER JOIN interfaces t2 ON t2.parent = t1.if_id
WHERE t1.if_id = $1
`

// Relations
func (q *Queries) GetInterfaceChilds(ctx context.Context, ifID int64) ([]Interface, error) {
	rows, err := q.db.Query(ctx, GetInterfaceChilds, ifID)
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

const GetInterfaceConnection = `-- name: GetInterfaceConnection :one
SELECT t2.con_id, t2.site_id, t2.con_prov_id, t2.con_type_id, t2.con_cap_id, t2.con_class_id, t2.hint, t2.notes, t2.in_use, t2.updated_on, t2.created_on
FROM interfaces t1
  INNER JOIN connections t2 ON t2.con_id = t1.con_id
WHERE t1.if_id = $1
`

// Foreign keys
func (q *Queries) GetInterfaceConnection(ctx context.Context, ifID int64) (Connection, error) {
	row := q.db.QueryRow(ctx, GetInterfaceConnection, ifID)
	var i Connection
	err := row.Scan(
		&i.ConID,
		&i.SiteID,
		&i.ConProvID,
		&i.ConTypeID,
		&i.ConCapID,
		&i.ConClassID,
		&i.Hint,
		&i.Notes,
		&i.InUse,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetInterfaceDevice = `-- name: GetInterfaceDevice :one
SELECT t2.dev_id, t2.site_id, t2.dom_id, t2.snmp_main_id, t2.snmp_ro_id, t2.parent, t2.sys_id, t2.ip4_addr, t2.ip6_addr, t2.host_name, t2.sys_name, t2.sys_location, t2.sys_contact, t2.sw_version, t2.ext_model, t2.installed, t2.monitor, t2.graph, t2.backup, t2.source, t2.type_changed, t2.backup_failed, t2.validation_failed, t2.unresponsive, t2.notes, t2.updated_on, t2.created_on
FROM interfaces t1
  INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.if_id = $1
`

// Foreign keys
func (q *Queries) GetInterfaceDevice(ctx context.Context, ifID int64) (Device, error) {
	row := q.db.QueryRow(ctx, GetInterfaceDevice, ifID)
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

const GetInterfaceEntity = `-- name: GetInterfaceEntity :one
SELECT t2.ent_id, t2.parent_ent_id, t2.snmp_ent_id, t2.dev_id, t2.slot, t2.descr, t2.model, t2.hw_product, t2.hw_revision, t2.serial_nr, t2.sw_product, t2.sw_revision, t2.manufacturer, t2.physical, t2.updated_on, t2.created_on
FROM interfaces t1
  INNER JOIN entities t2 ON t2.ent_id = t1.ent_id
WHERE t1.if_id = $1
`

// Foreign keys
func (q *Queries) GetInterfaceEntity(ctx context.Context, ifID int64) (Entity, error) {
	row := q.db.QueryRow(ctx, GetInterfaceEntity, ifID)
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

const GetInterfaceIntBwStats = `-- name: GetInterfaceIntBwStats :many
SELECT bw_id, if_id, to50in, to75in, to90in, to100in, to50out, to75out, to90out, to100out, if_group, updated_on, created_on
FROM int_bw_stats
WHERE if_id = $1
ORDER BY updated_on
`

// Relations
func (q *Queries) GetInterfaceIntBwStats(ctx context.Context, ifID int64) ([]IntBwStat, error) {
	rows, err := q.db.Query(ctx, GetInterfaceIntBwStats, ifID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []IntBwStat
	for rows.Next() {
		var i IntBwStat
		if err := rows.Scan(
			&i.BwID,
			&i.IfID,
			&i.To50in,
			&i.To75in,
			&i.To90in,
			&i.To100in,
			&i.To50out,
			&i.To75out,
			&i.To90out,
			&i.To100out,
			&i.IfGroup,
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

const GetInterfaceInterfaceRelations = `-- name: GetInterfaceInterfaceRelations :many
SELECT ir_id, if_id, if_id_up, if_id_down, updated_on, created_on
FROM interface_relations
WHERE if_id = $1
`

// Relations
func (q *Queries) GetInterfaceInterfaceRelations(ctx context.Context, ifID int64) ([]InterfaceRelation, error) {
	rows, err := q.db.Query(ctx, GetInterfaceInterfaceRelations, ifID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []InterfaceRelation
	for rows.Next() {
		var i InterfaceRelation
		if err := rows.Scan(
			&i.IrID,
			&i.IfID,
			&i.IfIDUp,
			&i.IfIDDown,
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

const GetInterfaceInterfaceRelationsHigherFor = `-- name: GetInterfaceInterfaceRelationsHigherFor :many
SELECT t2.ir_id, t2.if_id, t2.if_id_up, t2.if_id_down, t2.updated_on, t2.created_on
FROM interfaces t1
  INNER JOIN interface_relations t2 ON t2.if_id_up = t1.if_id
WHERE t1.if_id = $1
`

// Relations
func (q *Queries) GetInterfaceInterfaceRelationsHigherFor(ctx context.Context, ifID int64) ([]InterfaceRelation, error) {
	rows, err := q.db.Query(ctx, GetInterfaceInterfaceRelationsHigherFor, ifID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []InterfaceRelation
	for rows.Next() {
		var i InterfaceRelation
		if err := rows.Scan(
			&i.IrID,
			&i.IfID,
			&i.IfIDUp,
			&i.IfIDDown,
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

const GetInterfaceInterfaceRelationsLowerFor = `-- name: GetInterfaceInterfaceRelationsLowerFor :many
SELECT t2.ir_id, t2.if_id, t2.if_id_up, t2.if_id_down, t2.updated_on, t2.created_on
FROM interfaces t1
  INNER JOIN interface_relations t2 ON t2.if_id_down = t1.if_id
WHERE t1.if_id = $1
`

// Relations
func (q *Queries) GetInterfaceInterfaceRelationsLowerFor(ctx context.Context, ifID int64) ([]InterfaceRelation, error) {
	rows, err := q.db.Query(ctx, GetInterfaceInterfaceRelationsLowerFor, ifID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []InterfaceRelation
	for rows.Next() {
		var i InterfaceRelation
		if err := rows.Scan(
			&i.IrID,
			&i.IfID,
			&i.IfIDUp,
			&i.IfIDDown,
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

const GetInterfaceInterfaceSubinterfaces = `-- name: GetInterfaceInterfaceSubinterfaces :many
SELECT sif_id, if_id, ifindex, descr, alias, oper, adm, speed, type_enum, mac, notes, updated_on, created_on
FROM subinterfaces
WHERE if_id = $1
ORDER BY descr
`

// Relations
func (q *Queries) GetInterfaceInterfaceSubinterfaces(ctx context.Context, ifID sql.NullInt64) ([]Subinterface, error) {
	rows, err := q.db.Query(ctx, GetInterfaceInterfaceSubinterfaces, ifID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Subinterface
	for rows.Next() {
		var i Subinterface
		if err := rows.Scan(
			&i.SifID,
			&i.IfID,
			&i.Ifindex,
			&i.Descr,
			&i.Alias,
			&i.Oper,
			&i.Adm,
			&i.Speed,
			&i.TypeEnum,
			&i.Mac,
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

const GetInterfaceOtnIfId = `-- name: GetInterfaceOtnIfId :one
SELECT t2.if_id, t2.con_id, t2.parent, t2.otn_if_id, t2.dev_id, t2.ent_id, t2.ifindex, t2.descr, t2.alias, t2.oper, t2.adm, t2.speed, t2.minspeed, t2.type_enum, t2.mac, t2.monstatus, t2.monerrors, t2.monload, t2.updated_on, t2.created_on, t2.montraffic
FROM interfaces t1
  INNER JOIN interfaces t2 ON t2.if_id = t1.otn_if_id
WHERE t1.if_id = $1
`

// Foreign keys
func (q *Queries) GetInterfaceOtnIfId(ctx context.Context, ifID int64) (Interface, error) {
	row := q.db.QueryRow(ctx, GetInterfaceOtnIfId, ifID)
	var i Interface
	err := row.Scan(
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
	)
	return i, err
}

const GetInterfaceParent = `-- name: GetInterfaceParent :one
SELECT t2.if_id, t2.con_id, t2.parent, t2.otn_if_id, t2.dev_id, t2.ent_id, t2.ifindex, t2.descr, t2.alias, t2.oper, t2.adm, t2.speed, t2.minspeed, t2.type_enum, t2.mac, t2.monstatus, t2.monerrors, t2.monload, t2.updated_on, t2.created_on, t2.montraffic
FROM interfaces t1
  INNER JOIN interfaces t2 ON t2.if_id = t1.parent
WHERE t1.if_id = $1
`

// Foreign keys
func (q *Queries) GetInterfaceParent(ctx context.Context, ifID int64) (Interface, error) {
	row := q.db.QueryRow(ctx, GetInterfaceParent, ifID)
	var i Interface
	err := row.Scan(
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
	)
	return i, err
}

const GetInterfaceVlans = `-- name: GetInterfaceVlans :many
SELECT t3.v_id, t3.dev_id, t3.vlan, t3.descr, t3.updated_on, t3.created_on
FROM interfaces t1
  INNER JOIN interfaces2vlans t2 ON t2.if_id = t1.if_id
  INNER JOIN vlans t3 ON t3.v_id = t2.v_id
WHERE t1.if_id = $1
ORDER BY vlan
`

// Relations
func (q *Queries) GetInterfaceVlans(ctx context.Context, ifID int64) ([]Vlan, error) {
	rows, err := q.db.Query(ctx, GetInterfaceVlans, ifID)
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

const GetInterfaces = `-- name: GetInterfaces :many
SELECT if_id, con_id, parent, otn_if_id, dev_id, ent_id, ifindex, descr, alias, oper, adm, speed, minspeed, type_enum, mac, monstatus, monerrors, monload, updated_on, created_on, montraffic
FROM interfaces
ORDER BY dev_id, ifindex
LIMIT $1
OFFSET $2
`

type GetInterfacesParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) GetInterfaces(ctx context.Context, arg GetInterfacesParams) ([]Interface, error) {
	rows, err := q.db.Query(ctx, GetInterfaces, arg.Limit, arg.Offset)
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

const GetterfaceInterfaceXconnects = `-- name: GetterfaceInterfaceXconnects :many
SELECT xc_id, dev_id, peer_dev_id, if_id, vc_idx, vc_id, peer_ip, peer_ifalias, xname, descr, op_stat, op_stat_in, op_stat_out, updated_on, created_on
FROM xconnects
WHERE if_id = $1
ORDER BY vc_id
`

// Relations
func (q *Queries) GetterfaceInterfaceXconnects(ctx context.Context, ifID sql.NullInt64) ([]Xconnect, error) {
	rows, err := q.db.Query(ctx, GetterfaceInterfaceXconnects, ifID)
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

const UpdateInterface = `-- name: UpdateInterface :one
UPDATE interfaces
SET con_id = $2,
  parent = $3,
  otn_if_id = $4,
  dev_id = $5,
  ent_id = $6,
  ifindex = $7,
  descr = $8,
  alias = $9,
  oper = $10,
  adm = $11,
  speed = $12,
  minspeed = $13,
  type_enum = $14,
  mac = $15,
  monstatus = $16,
  monerrors = $17,
  monload = $18,
  montraffic = $19
WHERE if_id = $1
RETURNING if_id, con_id, parent, otn_if_id, dev_id, ent_id, ifindex, descr, alias, oper, adm, speed, minspeed, type_enum, mac, monstatus, monerrors, monload, updated_on, created_on, montraffic
`

type UpdateInterfaceParams struct {
	IfID       int64          `json:"if_id"`
	ConID      sql.NullInt64  `json:"con_id"`
	Parent     sql.NullInt64  `json:"parent"`
	OtnIfID    sql.NullInt64  `json:"otn_if_id"`
	DevID      int64          `json:"dev_id"`
	EntID      sql.NullInt64  `json:"ent_id"`
	Ifindex    sql.NullInt64  `json:"ifindex"`
	Descr      string         `json:"descr"`
	Alias      sql.NullString `json:"alias"`
	Oper       sql.NullInt16  `json:"oper"`
	Adm        sql.NullInt16  `json:"adm"`
	Speed      sql.NullInt64  `json:"speed"`
	Minspeed   sql.NullInt64  `json:"minspeed"`
	TypeEnum   sql.NullInt16  `json:"type_enum"`
	Mac        pgtype.Macaddr `json:"mac"`
	Monstatus  int16          `json:"monstatus"`
	Monerrors  int16          `json:"monerrors"`
	Monload    int16          `json:"monload"`
	Montraffic int16          `json:"montraffic"`
}

func (q *Queries) UpdateInterface(ctx context.Context, arg UpdateInterfaceParams) (Interface, error) {
	row := q.db.QueryRow(ctx, UpdateInterface,
		arg.IfID,
		arg.ConID,
		arg.Parent,
		arg.OtnIfID,
		arg.DevID,
		arg.EntID,
		arg.Ifindex,
		arg.Descr,
		arg.Alias,
		arg.Oper,
		arg.Adm,
		arg.Speed,
		arg.Minspeed,
		arg.TypeEnum,
		arg.Mac,
		arg.Monstatus,
		arg.Monerrors,
		arg.Monload,
		arg.Montraffic,
	)
	var i Interface
	err := row.Scan(
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
	)
	return i, err
}
