// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.16.0
// source: int_bw_stats.sql

package godevmandb

import (
	"context"
	"database/sql"
)

const CountIntBwStats = `-- name: CountIntBwStats :one
SELECT COUNT(*)
FROM int_bw_stats
`

func (q *Queries) CountIntBwStats(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountIntBwStats)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateIntBwStat = `-- name: CreateIntBwStat :one
INSERT INTO int_bw_stats (
    if_id,
    to50in,
    to75in,
    to90in,
    to100in,
    to50out,
    to75out,
    to90out,
    to100out,
    if_group
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
    $10
  )
RETURNING bw_id, if_id, to50in, to75in, to90in, to100in, to50out, to75out, to90out, to100out, if_group, updated_on, created_on
`

type CreateIntBwStatParams struct {
	IfID     int64         `json:"if_id"`
	To50in   sql.NullInt16 `json:"to50in"`
	To75in   sql.NullInt16 `json:"to75in"`
	To90in   sql.NullInt16 `json:"to90in"`
	To100in  sql.NullInt16 `json:"to100in"`
	To50out  sql.NullInt16 `json:"to50out"`
	To75out  sql.NullInt16 `json:"to75out"`
	To90out  sql.NullInt16 `json:"to90out"`
	To100out sql.NullInt16 `json:"to100out"`
	IfGroup  string        `json:"if_group"`
}

func (q *Queries) CreateIntBwStat(ctx context.Context, arg CreateIntBwStatParams) (IntBwStat, error) {
	row := q.db.QueryRow(ctx, CreateIntBwStat,
		arg.IfID,
		arg.To50in,
		arg.To75in,
		arg.To90in,
		arg.To100in,
		arg.To50out,
		arg.To75out,
		arg.To90out,
		arg.To100out,
		arg.IfGroup,
	)
	var i IntBwStat
	err := row.Scan(
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
	)
	return i, err
}

const DeleteIntBwStat = `-- name: DeleteIntBwStat :exec
DELETE FROM int_bw_stats
WHERE bw_id = $1
`

func (q *Queries) DeleteIntBwStat(ctx context.Context, bwID int64) error {
	_, err := q.db.Exec(ctx, DeleteIntBwStat, bwID)
	return err
}

const GetIntBwStat = `-- name: GetIntBwStat :one
SELECT bw_id, if_id, to50in, to75in, to90in, to100in, to50out, to75out, to90out, to100out, if_group, updated_on, created_on
FROM int_bw_stats
WHERE bw_id = $1
`

func (q *Queries) GetIntBwStat(ctx context.Context, bwID int64) (IntBwStat, error) {
	row := q.db.QueryRow(ctx, GetIntBwStat, bwID)
	var i IntBwStat
	err := row.Scan(
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
	)
	return i, err
}

const GetIntBwStatInterface = `-- name: GetIntBwStatInterface :one
SELECT t2.if_id, t2.con_id, t2.parent, t2.otn_if_id, t2.dev_id, t2.ent_id, t2.ifindex, t2.descr, t2.alias, t2.oper, t2.adm, t2.speed, t2.minspeed, t2.type_enum, t2.mac, t2.monstatus, t2.monerrors, t2.monload, t2.updated_on, t2.created_on, t2.montraffic
FROM int_bw_stats t1
  INNER JOIN interfaces t2 ON t2.if_id = t1.if_id
WHERE t1.bw_id = $1
`

// Foreign keys
func (q *Queries) GetIntBwStatInterface(ctx context.Context, bwID int64) (Interface, error) {
	row := q.db.QueryRow(ctx, GetIntBwStatInterface, bwID)
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

const GetIntBwStats = `-- name: GetIntBwStats :many
SELECT bw_id, if_id, to50in, to75in, to90in, to100in, to50out, to75out, to90out, to100out, if_group, updated_on, created_on
FROM int_bw_stats
ORDER BY bw_id
LIMIT $1
OFFSET $2
`

type GetIntBwStatsParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) GetIntBwStats(ctx context.Context, arg GetIntBwStatsParams) ([]IntBwStat, error) {
	rows, err := q.db.Query(ctx, GetIntBwStats, arg.Limit, arg.Offset)
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

const UpdateIntBwStat = `-- name: UpdateIntBwStat :one
UPDATE int_bw_stats
SET if_id = $2,
  to50in = $3,
  to75in = $4,
  to90in = $5,
  to100in = $6,
  to50out = $7,
  to75out = $8,
  to90out = $9,
  to100out = $10,
  if_group = $11
WHERE bw_id = $1
RETURNING bw_id, if_id, to50in, to75in, to90in, to100in, to50out, to75out, to90out, to100out, if_group, updated_on, created_on
`

type UpdateIntBwStatParams struct {
	BwID     int64         `json:"bw_id"`
	IfID     int64         `json:"if_id"`
	To50in   sql.NullInt16 `json:"to50in"`
	To75in   sql.NullInt16 `json:"to75in"`
	To90in   sql.NullInt16 `json:"to90in"`
	To100in  sql.NullInt16 `json:"to100in"`
	To50out  sql.NullInt16 `json:"to50out"`
	To75out  sql.NullInt16 `json:"to75out"`
	To90out  sql.NullInt16 `json:"to90out"`
	To100out sql.NullInt16 `json:"to100out"`
	IfGroup  string        `json:"if_group"`
}

func (q *Queries) UpdateIntBwStat(ctx context.Context, arg UpdateIntBwStatParams) (IntBwStat, error) {
	row := q.db.QueryRow(ctx, UpdateIntBwStat,
		arg.BwID,
		arg.IfID,
		arg.To50in,
		arg.To75in,
		arg.To90in,
		arg.To100in,
		arg.To50out,
		arg.To75out,
		arg.To90out,
		arg.To100out,
		arg.IfGroup,
	)
	var i IntBwStat
	err := row.Scan(
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
	)
	return i, err
}
