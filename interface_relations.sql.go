// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.16.0
// source: interface_relations.sql

package godevmandb

import (
	"context"
	"database/sql"
)

const CountInterfaceRelations = `-- name: CountInterfaceRelations :one
SELECT COUNT(*)
FROM interface_relations
`

func (q *Queries) CountInterfaceRelations(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountInterfaceRelations)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateInterfaceRelation = `-- name: CreateInterfaceRelation :one
INSERT INTO interface_relations (if_id, if_id_up, if_id_down)
VALUES ($1, $2, $3)
RETURNING ir_id, if_id, if_id_up, if_id_down, updated_on, created_on
`

type CreateInterfaceRelationParams struct {
	IfID     int64         `json:"if_id"`
	IfIDUp   sql.NullInt64 `json:"if_id_up"`
	IfIDDown sql.NullInt64 `json:"if_id_down"`
}

func (q *Queries) CreateInterfaceRelation(ctx context.Context, arg CreateInterfaceRelationParams) (InterfaceRelation, error) {
	row := q.db.QueryRow(ctx, CreateInterfaceRelation, arg.IfID, arg.IfIDUp, arg.IfIDDown)
	var i InterfaceRelation
	err := row.Scan(
		&i.IrID,
		&i.IfID,
		&i.IfIDUp,
		&i.IfIDDown,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteInterfaceRelation = `-- name: DeleteInterfaceRelation :exec
DELETE FROM interface_relations
WHERE ir_id = $1
`

func (q *Queries) DeleteInterfaceRelation(ctx context.Context, irID int64) error {
	_, err := q.db.Exec(ctx, DeleteInterfaceRelation, irID)
	return err
}

const GetInterfaceRelation = `-- name: GetInterfaceRelation :one
SELECT ir_id, if_id, if_id_up, if_id_down, updated_on, created_on
FROM interface_relations
WHERE ir_id = $1
`

func (q *Queries) GetInterfaceRelation(ctx context.Context, irID int64) (InterfaceRelation, error) {
	row := q.db.QueryRow(ctx, GetInterfaceRelation, irID)
	var i InterfaceRelation
	err := row.Scan(
		&i.IrID,
		&i.IfID,
		&i.IfIDUp,
		&i.IfIDDown,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetInterfaceRelationInterface = `-- name: GetInterfaceRelationInterface :one
SELECT t2.if_id, t2.con_id, t2.parent, t2.otn_if_id, t2.dev_id, t2.ent_id, t2.ifindex, t2.descr, t2.alias, t2.oper, t2.adm, t2.speed, t2.minspeed, t2.type_enum, t2.mac, t2.monstatus, t2.monerrors, t2.monload, t2.updated_on, t2.created_on, t2.montraffic
FROM interface_relations t1
  INNER JOIN interfaces t2 ON t2.if_id = t1.if_id
WHERE t1.ir_id = $1
`

// Foreign keys
func (q *Queries) GetInterfaceRelationInterface(ctx context.Context, irID int64) (Interface, error) {
	row := q.db.QueryRow(ctx, GetInterfaceRelationInterface, irID)
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

const GetInterfaceRelationInterfaceDown = `-- name: GetInterfaceRelationInterfaceDown :one
SELECT t2.if_id, t2.con_id, t2.parent, t2.otn_if_id, t2.dev_id, t2.ent_id, t2.ifindex, t2.descr, t2.alias, t2.oper, t2.adm, t2.speed, t2.minspeed, t2.type_enum, t2.mac, t2.monstatus, t2.monerrors, t2.monload, t2.updated_on, t2.created_on, t2.montraffic
FROM interface_relations t1
  INNER JOIN interfaces t2 ON t2.if_id = t1.if_id_down
WHERE t1.ir_id = $1
`

// Foreign keys
func (q *Queries) GetInterfaceRelationInterfaceDown(ctx context.Context, irID int64) (Interface, error) {
	row := q.db.QueryRow(ctx, GetInterfaceRelationInterfaceDown, irID)
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

const GetInterfaceRelationInterfaceUp = `-- name: GetInterfaceRelationInterfaceUp :one
SELECT t2.if_id, t2.con_id, t2.parent, t2.otn_if_id, t2.dev_id, t2.ent_id, t2.ifindex, t2.descr, t2.alias, t2.oper, t2.adm, t2.speed, t2.minspeed, t2.type_enum, t2.mac, t2.monstatus, t2.monerrors, t2.monload, t2.updated_on, t2.created_on, t2.montraffic
FROM interface_relations t1
  INNER JOIN interfaces t2 ON t2.if_id = t1.if_id_up
WHERE t1.ir_id = $1
`

// Foreign keys
func (q *Queries) GetInterfaceRelationInterfaceUp(ctx context.Context, irID int64) (Interface, error) {
	row := q.db.QueryRow(ctx, GetInterfaceRelationInterfaceUp, irID)
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

const GetInterfaceRelations = `-- name: GetInterfaceRelations :many
SELECT ir_id, if_id, if_id_up, if_id_down, updated_on, created_on
FROM interface_relations
ORDER BY ir_id
LIMIT $1
OFFSET $2
`

type GetInterfaceRelationsParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) GetInterfaceRelations(ctx context.Context, arg GetInterfaceRelationsParams) ([]InterfaceRelation, error) {
	rows, err := q.db.Query(ctx, GetInterfaceRelations, arg.Limit, arg.Offset)
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

const UpdateInterfaceRelation = `-- name: UpdateInterfaceRelation :one
UPDATE interface_relations
SET if_id = $2,
  if_id_up = $3,
  if_id_down = $4
WHERE ir_id = $1
RETURNING ir_id, if_id, if_id_up, if_id_down, updated_on, created_on
`

type UpdateInterfaceRelationParams struct {
	IrID     int64         `json:"ir_id"`
	IfID     int64         `json:"if_id"`
	IfIDUp   sql.NullInt64 `json:"if_id_up"`
	IfIDDown sql.NullInt64 `json:"if_id_down"`
}

func (q *Queries) UpdateInterfaceRelation(ctx context.Context, arg UpdateInterfaceRelationParams) (InterfaceRelation, error) {
	row := q.db.QueryRow(ctx, UpdateInterfaceRelation,
		arg.IrID,
		arg.IfID,
		arg.IfIDUp,
		arg.IfIDDown,
	)
	var i InterfaceRelation
	err := row.Scan(
		&i.IrID,
		&i.IfID,
		&i.IfIDUp,
		&i.IfIDDown,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
