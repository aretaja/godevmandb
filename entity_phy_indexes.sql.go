// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.17.0
// source: entity_phy_indexes.sql

package godevmandb

import (
	"context"
	"time"
)

const CountEntityPhyIndexes = `-- name: CountEntityPhyIndexes :one
SELECT COUNT(*)
FROM entity_phy_indexes
`

func (q *Queries) CountEntityPhyIndexes(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountEntityPhyIndexes)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateEntityPhyIndex = `-- name: CreateEntityPhyIndex :one
INSERT INTO entity_phy_indexes (ent_id, phy_index, descr)
VALUES ($1, $2, $3)
RETURNING ei_id, ent_id, phy_index, descr, updated_on, created_on
`

type CreateEntityPhyIndexParams struct {
	EntID    int64  `json:"ent_id"`
	PhyIndex int64  `json:"phy_index"`
	Descr    string `json:"descr"`
}

func (q *Queries) CreateEntityPhyIndex(ctx context.Context, arg CreateEntityPhyIndexParams) (EntityPhyIndex, error) {
	row := q.db.QueryRow(ctx, CreateEntityPhyIndex, arg.EntID, arg.PhyIndex, arg.Descr)
	var i EntityPhyIndex
	err := row.Scan(
		&i.EiID,
		&i.EntID,
		&i.PhyIndex,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteEntityPhyIndex = `-- name: DeleteEntityPhyIndex :exec
DELETE FROM entity_phy_indexes
WHERE ei_id = $1
`

func (q *Queries) DeleteEntityPhyIndex(ctx context.Context, eiID int64) error {
	_, err := q.db.Exec(ctx, DeleteEntityPhyIndex, eiID)
	return err
}

const GetEntityPhyIndex = `-- name: GetEntityPhyIndex :one
SELECT ei_id, ent_id, phy_index, descr, updated_on, created_on
FROM entity_phy_indexes
WHERE ei_id = $1
`

func (q *Queries) GetEntityPhyIndex(ctx context.Context, eiID int64) (EntityPhyIndex, error) {
	row := q.db.QueryRow(ctx, GetEntityPhyIndex, eiID)
	var i EntityPhyIndex
	err := row.Scan(
		&i.EiID,
		&i.EntID,
		&i.PhyIndex,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetEntityPhyIndexEntity = `-- name: GetEntityPhyIndexEntity :one
SELECT t2.ent_id, t2.parent_ent_id, t2.snmp_ent_id, t2.dev_id, t2.slot, t2.descr, t2.model, t2.hw_product, t2.hw_revision, t2.serial_nr, t2.sw_product, t2.sw_revision, t2.manufacturer, t2.physical, t2.updated_on, t2.created_on
FROM entity_phy_indexes t1
  INNER JOIN entities t2 ON t2.ent_id = t1.ent_id
WHERE t1.ei_id = $1
`

// Foreign keys
func (q *Queries) GetEntityPhyIndexEntity(ctx context.Context, eiID int64) (Entity, error) {
	row := q.db.QueryRow(ctx, GetEntityPhyIndexEntity, eiID)
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

const GetEntityPhyIndexes = `-- name: GetEntityPhyIndexes :many
SELECT ei_id, ent_id, phy_index, descr, updated_on, created_on
FROM entity_phy_indexes
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
    OR phy_index = $5
  )
  AND (
    $6::text = ''
    OR descr ILIKE $6
  )
ORDER BY created_on
LIMIT NULLIF($8::int, 0) OFFSET NULLIF($7::int, 0)
`

type GetEntityPhyIndexesParams struct {
	UpdatedGe time.Time `json:"updated_ge"`
	UpdatedLe time.Time `json:"updated_le"`
	CreatedGe time.Time `json:"created_ge"`
	CreatedLe time.Time `json:"created_le"`
	PhyIndexF string    `json:"phy_index_f"`
	DescrF    string    `json:"descr_f"`
	OffsetQ   int32     `json:"offset_q"`
	LimitQ    int32     `json:"limit_q"`
}

func (q *Queries) GetEntityPhyIndexes(ctx context.Context, arg GetEntityPhyIndexesParams) ([]EntityPhyIndex, error) {
	rows, err := q.db.Query(ctx, GetEntityPhyIndexes,
		arg.UpdatedGe,
		arg.UpdatedLe,
		arg.CreatedGe,
		arg.CreatedLe,
		arg.PhyIndexF,
		arg.DescrF,
		arg.OffsetQ,
		arg.LimitQ,
	)
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

const UpdateEntityPhyIndex = `-- name: UpdateEntityPhyIndex :one
UPDATE entity_phy_indexes
SET ent_id = $2,
  phy_index = $3,
  descr = $4
WHERE ei_id = $1
RETURNING ei_id, ent_id, phy_index, descr, updated_on, created_on
`

type UpdateEntityPhyIndexParams struct {
	EiID     int64  `json:"ei_id"`
	EntID    int64  `json:"ent_id"`
	PhyIndex int64  `json:"phy_index"`
	Descr    string `json:"descr"`
}

func (q *Queries) UpdateEntityPhyIndex(ctx context.Context, arg UpdateEntityPhyIndexParams) (EntityPhyIndex, error) {
	row := q.db.QueryRow(ctx, UpdateEntityPhyIndex,
		arg.EiID,
		arg.EntID,
		arg.PhyIndex,
		arg.Descr,
	)
	var i EntityPhyIndex
	err := row.Scan(
		&i.EiID,
		&i.EntID,
		&i.PhyIndex,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
