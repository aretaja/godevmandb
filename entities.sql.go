// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.17.0
// source: entities.sql

package godevmandb

import (
	"context"
	"time"
)

const CountEntities = `-- name: CountEntities :one
SELECT COUNT(*)
FROM entities
`

func (q *Queries) CountEntities(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountEntities)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateEntity = `-- name: CreateEntity :one
INSERT INTO entities (
    parent_ent_id,
    snmp_ent_id,
    dev_id,
    slot,
    descr,
    model,
    hw_product,
    hw_revision,
    serial_nr,
    sw_product,
    sw_revision,
    manufacturer,
    physical
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
    $13
  )
RETURNING ent_id, parent_ent_id, snmp_ent_id, dev_id, slot, descr, model, hw_product, hw_revision, serial_nr, sw_product, sw_revision, manufacturer, physical, updated_on, created_on
`

type CreateEntityParams struct {
	ParentEntID  *int64  `json:"parent_ent_id"`
	SnmpEntID    *int64  `json:"snmp_ent_id"`
	DevID        int64   `json:"dev_id"`
	Slot         *string `json:"slot"`
	Descr        *string `json:"descr"`
	Model        *string `json:"model"`
	HwProduct    *string `json:"hw_product"`
	HwRevision   *string `json:"hw_revision"`
	SerialNr     *string `json:"serial_nr"`
	SwProduct    *string `json:"sw_product"`
	SwRevision   *string `json:"sw_revision"`
	Manufacturer *string `json:"manufacturer"`
	Physical     bool    `json:"physical"`
}

func (q *Queries) CreateEntity(ctx context.Context, arg CreateEntityParams) (Entity, error) {
	row := q.db.QueryRow(ctx, CreateEntity,
		arg.ParentEntID,
		arg.SnmpEntID,
		arg.DevID,
		arg.Slot,
		arg.Descr,
		arg.Model,
		arg.HwProduct,
		arg.HwRevision,
		arg.SerialNr,
		arg.SwProduct,
		arg.SwRevision,
		arg.Manufacturer,
		arg.Physical,
	)
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

const DeleteEntity = `-- name: DeleteEntity :exec
DELETE FROM entities
WHERE ent_id = $1
`

func (q *Queries) DeleteEntity(ctx context.Context, entID int64) error {
	_, err := q.db.Exec(ctx, DeleteEntity, entID)
	return err
}

const GetEntities = `-- name: GetEntities :many
SELECT ent_id, parent_ent_id, snmp_ent_id, dev_id, slot, descr, model, hw_product, hw_revision, serial_nr, sw_product, sw_revision, manufacturer, physical, updated_on, created_on
FROM entities
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
    $5::text IS NULL
    OR ($5::text = 'isnull' AND snmp_ent_id IS NULL)
    OR snmp_ent_id = $5
  )
  AND (
    $6::text IS NULL
    OR ($6::text = 'isnull' AND slot IS NULL)
    OR ($6::text = 'isempty' AND slot = '')
    OR slot ILIKE $6
  )
  AND (
    $7::text IS NULL
    OR ($7::text = 'isnull' AND descr IS NULL)
    OR ($7::text = 'isempty' AND descr = '')
    OR descr ILIKE $7
  )
  AND (
    $8::text IS NULL
    OR ($8::text = 'isnull' AND model IS NULL)
    OR ($8::text = 'isempty' AND model = '')
    OR model ILIKE $8
  )
  AND (
    $9::text IS NULL
    OR ($9::text = 'isnull' AND hw_product IS NULL)
    OR ($9::text = 'isempty' AND hw_product = '')
    OR hw_product ILIKE $9
  )
  AND (
    $10::text IS NULL
    OR ($10::text = 'isnull' AND hw_revision IS NULL)
    OR ($10::text = 'isempty' AND hw_revision = '')
    OR hw_revision ILIKE $10
  )
  AND (
    $11::text IS NULL
    OR ($11::text = 'isnull' AND serial_nr IS NULL)
    OR ($11::text = 'isempty' AND serial_nr = '')
    OR serial_nr ILIKE $11
  )
  AND (
    $12::text IS NULL
    OR ($12::text = 'isnull' AND sw_product IS NULL)
    OR ($12::text = 'isempty' AND sw_product = '')
    OR sw_product ILIKE $12
  )
  AND (
    $13::text IS NULL
    OR ($13::text = 'isnull' AND sw_revision IS NULL)
    OR ($13::text = 'isempty' AND sw_revision = '')
    OR sw_revision ILIKE $13
  )
  AND (
    $14::text IS NULL
    OR ($14::text = 'isnull' AND manufacturer IS NULL)
    OR ($14::text = 'isempty' AND manufacturer = '')
    OR manufacturer ILIKE $14
  )
  AND (
    $15::text = ''
    OR ($15::text = 'true' AND physical = true)
    OR ($15::text = 'false' AND physical = false)
  )
ORDER BY created_on
LIMIT NULLIF($17::int, 0) OFFSET NULLIF($16::int, 0)
`

type GetEntitiesParams struct {
	UpdatedGe     time.Time `json:"updated_ge"`
	UpdatedLe     time.Time `json:"updated_le"`
	CreatedGe     time.Time `json:"created_ge"`
	CreatedLe     time.Time `json:"created_le"`
	SnmpEntIDF    *string   `json:"snmp_ent_id_f"`
	SlotF         *string   `json:"slot_f"`
	DescrF        *string   `json:"descr_f"`
	ModelF        *string   `json:"model_f"`
	HwProductF    *string   `json:"hw_product_f"`
	HwRevisionF   *string   `json:"hw_revision_f"`
	SerialNrF     *string   `json:"serial_nr_f"`
	SwProductF    *string   `json:"sw_product_f"`
	SwRevisionF   *string   `json:"sw_revision_f"`
	ManufacturerF *string   `json:"manufacturer_f"`
	PhysicalF     string    `json:"physical_f"`
	OffsetQ       int32     `json:"offset_q"`
	LimitQ        int32     `json:"limit_q"`
}

func (q *Queries) GetEntities(ctx context.Context, arg GetEntitiesParams) ([]Entity, error) {
	rows, err := q.db.Query(ctx, GetEntities,
		arg.UpdatedGe,
		arg.UpdatedLe,
		arg.CreatedGe,
		arg.CreatedLe,
		arg.SnmpEntIDF,
		arg.SlotF,
		arg.DescrF,
		arg.ModelF,
		arg.HwProductF,
		arg.HwRevisionF,
		arg.SerialNrF,
		arg.SwProductF,
		arg.SwRevisionF,
		arg.ManufacturerF,
		arg.PhysicalF,
		arg.OffsetQ,
		arg.LimitQ,
	)
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

const GetEntity = `-- name: GetEntity :one
SELECT ent_id, parent_ent_id, snmp_ent_id, dev_id, slot, descr, model, hw_product, hw_revision, serial_nr, sw_product, sw_revision, manufacturer, physical, updated_on, created_on
FROM entities
WHERE ent_id = $1
`

func (q *Queries) GetEntity(ctx context.Context, entID int64) (Entity, error) {
	row := q.db.QueryRow(ctx, GetEntity, entID)
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

const GetEntityChilds = `-- name: GetEntityChilds :many
SELECT t2.ent_id, t2.parent_ent_id, t2.snmp_ent_id, t2.dev_id, t2.slot, t2.descr, t2.model, t2.hw_product, t2.hw_revision, t2.serial_nr, t2.sw_product, t2.sw_revision, t2.manufacturer, t2.physical, t2.updated_on, t2.created_on
FROM entities t1
  INNER JOIN entities t2 ON t2.parent_ent_id = t1.ent_id
WHERE t1.ent_id = $1
`

// Relations
func (q *Queries) GetEntityChilds(ctx context.Context, entID int64) ([]Entity, error) {
	rows, err := q.db.Query(ctx, GetEntityChilds, entID)
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

const GetEntityDevice = `-- name: GetEntityDevice :one
SELECT t2.dev_id, t2.site_id, t2.dom_id, t2.snmp_main_id, t2.snmp_ro_id, t2.parent, t2.sys_id, t2.ip4_addr, t2.ip6_addr, t2.host_name, t2.sys_name, t2.sys_location, t2.sys_contact, t2.sw_version, t2.ext_model, t2.installed, t2.monitor, t2.graph, t2.backup, t2.source, t2.type_changed, t2.backup_failed, t2.validation_failed, t2.unresponsive, t2.notes, t2.updated_on, t2.created_on
FROM entities t1
  INNER JOIN devices t2 ON t2.dev_id = t1.dev_id
WHERE t1.ent_id = $1
`

// Foreign keys
func (q *Queries) GetEntityDevice(ctx context.Context, entID int64) (Device, error) {
	row := q.db.QueryRow(ctx, GetEntityDevice, entID)
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

const GetEntityEntityPhyIndexes = `-- name: GetEntityEntityPhyIndexes :many
SELECT ei_id, ent_id, phy_index, descr, updated_on, created_on
FROM entity_phy_indexes
WHERE ent_id = $1
ORDER BY descr
`

// Relations
func (q *Queries) GetEntityEntityPhyIndexes(ctx context.Context, entID int64) ([]EntityPhyIndex, error) {
	rows, err := q.db.Query(ctx, GetEntityEntityPhyIndexes, entID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []EntityPhyIndex
	for rows.Next() {
		var i EntityPhyIndex
		if err := rows.Scan(
			&i.EiID,
			&i.EntID,
			&i.PhyIndex,
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

const GetEntityInterfaces = `-- name: GetEntityInterfaces :many
SELECT if_id, con_id, parent, otn_if_id, dev_id, ent_id, ifindex, descr, alias, oper, adm, speed, minspeed, type_enum, mac, monstatus, monerrors, monload, updated_on, created_on, montraffic
FROM interfaces
WHERE ent_id = $1
ORDER BY ifindex
`

// Relations
func (q *Queries) GetEntityInterfaces(ctx context.Context, entID *int64) ([]Interface, error) {
	rows, err := q.db.Query(ctx, GetEntityInterfaces, entID)
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

const GetEntityParent = `-- name: GetEntityParent :one
SELECT t2.ent_id, t2.parent_ent_id, t2.snmp_ent_id, t2.dev_id, t2.slot, t2.descr, t2.model, t2.hw_product, t2.hw_revision, t2.serial_nr, t2.sw_product, t2.sw_revision, t2.manufacturer, t2.physical, t2.updated_on, t2.created_on
FROM entities t1
  INNER JOIN entities t2 ON t2.ent_id = t1.parent_ent_id
WHERE t1.ent_id = $1
`

// Foreign keys
func (q *Queries) GetEntityParent(ctx context.Context, entID int64) (Entity, error) {
	row := q.db.QueryRow(ctx, GetEntityParent, entID)
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

const GetEntityRlfNbrs = `-- name: GetEntityRlfNbrs :many
SELECT t2.nbr_id, t2.dev_id, t2.nbr_ent_id, t2.nbr_sysname, t2.updated_on, t2.created_on
FROM entities t1
  INNER JOIN rl_nbrs t2 ON t2.nbr_ent_id = t1.ent_id
WHERE t1.ent_id = $1
ORDER BY nbr_sysname
`

// Relations
func (q *Queries) GetEntityRlfNbrs(ctx context.Context, entID int64) ([]RlNbr, error) {
	rows, err := q.db.Query(ctx, GetEntityRlfNbrs, entID)
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

const UpdateEntity = `-- name: UpdateEntity :one
UPDATE entities
SET parent_ent_id = $2,
  snmp_ent_id = $3,
  dev_id = $4,
  slot = $5,
  descr = $6,
  model = $7,
  hw_product = $8,
  hw_revision = $9,
  serial_nr = $10,
  sw_product = $11,
  sw_revision = $12,
  manufacturer = $13,
  physical = $14
WHERE ent_id = $1
RETURNING ent_id, parent_ent_id, snmp_ent_id, dev_id, slot, descr, model, hw_product, hw_revision, serial_nr, sw_product, sw_revision, manufacturer, physical, updated_on, created_on
`

type UpdateEntityParams struct {
	EntID        int64   `json:"ent_id"`
	ParentEntID  *int64  `json:"parent_ent_id"`
	SnmpEntID    *int64  `json:"snmp_ent_id"`
	DevID        int64   `json:"dev_id"`
	Slot         *string `json:"slot"`
	Descr        *string `json:"descr"`
	Model        *string `json:"model"`
	HwProduct    *string `json:"hw_product"`
	HwRevision   *string `json:"hw_revision"`
	SerialNr     *string `json:"serial_nr"`
	SwProduct    *string `json:"sw_product"`
	SwRevision   *string `json:"sw_revision"`
	Manufacturer *string `json:"manufacturer"`
	Physical     bool    `json:"physical"`
}

func (q *Queries) UpdateEntity(ctx context.Context, arg UpdateEntityParams) (Entity, error) {
	row := q.db.QueryRow(ctx, UpdateEntity,
		arg.EntID,
		arg.ParentEntID,
		arg.SnmpEntID,
		arg.DevID,
		arg.Slot,
		arg.Descr,
		arg.Model,
		arg.HwProduct,
		arg.HwRevision,
		arg.SerialNr,
		arg.SwProduct,
		arg.SwRevision,
		arg.Manufacturer,
		arg.Physical,
	)
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
