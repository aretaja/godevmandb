// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.16.0
// source: con_types.sql

package godevmandb

import (
	"context"
	"database/sql"
	"time"
)

const CountConTypes = `-- name: CountConTypes :one
SELECT COUNT(*)
FROM con_types
`

func (q *Queries) CountConTypes(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountConTypes)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateConType = `-- name: CreateConType :one
INSERT INTO con_types (descr, notes)
VALUES ($1, $2)
RETURNING con_type_id, descr, notes, updated_on, created_on
`

type CreateConTypeParams struct {
	Descr string         `json:"descr"`
	Notes sql.NullString `json:"notes"`
}

func (q *Queries) CreateConType(ctx context.Context, arg CreateConTypeParams) (ConType, error) {
	row := q.db.QueryRow(ctx, CreateConType, arg.Descr, arg.Notes)
	var i ConType
	err := row.Scan(
		&i.ConTypeID,
		&i.Descr,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteConType = `-- name: DeleteConType :exec
DELETE FROM con_types
WHERE con_type_id = $1
`

func (q *Queries) DeleteConType(ctx context.Context, conTypeID int64) error {
	_, err := q.db.Exec(ctx, DeleteConType, conTypeID)
	return err
}

const GetConType = `-- name: GetConType :one
SELECT con_type_id, descr, notes, updated_on, created_on
FROM con_types
WHERE con_type_id = $1
`

func (q *Queries) GetConType(ctx context.Context, conTypeID int64) (ConType, error) {
	row := q.db.QueryRow(ctx, GetConType, conTypeID)
	var i ConType
	err := row.Scan(
		&i.ConTypeID,
		&i.Descr,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetConTypeConnections = `-- name: GetConTypeConnections :many
SELECT con_id, site_id, con_prov_id, con_type_id, con_cap_id, con_class_id, hint, notes, in_use, updated_on, created_on
FROM connections
WHERE con_type_id = $1
`

// Relations
func (q *Queries) GetConTypeConnections(ctx context.Context, conTypeID int64) ([]Connection, error) {
	rows, err := q.db.Query(ctx, GetConTypeConnections, conTypeID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Connection
	for rows.Next() {
		var i Connection
		if err := rows.Scan(
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

const GetConTypes = `-- name: GetConTypes :many
SELECT con_type_id, descr, notes, updated_on, created_on
FROM con_types
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

type GetConTypesParams struct {
	UpdatedGe time.Time `json:"updated_ge"`
	UpdatedLe time.Time `json:"updated_le"`
	CreatedGe time.Time `json:"created_ge"`
	CreatedLe time.Time `json:"created_le"`
	DescrF    string    `json:"descr_f"`
	OffsetQ   int32     `json:"offset_q"`
	LimitQ    int32     `json:"limit_q"`
}

func (q *Queries) GetConTypes(ctx context.Context, arg GetConTypesParams) ([]ConType, error) {
	rows, err := q.db.Query(ctx, GetConTypes,
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
	var items []ConType
	for rows.Next() {
		var i ConType
		if err := rows.Scan(
			&i.ConTypeID,
			&i.Descr,
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

const UpdateConType = `-- name: UpdateConType :one
UPDATE con_types
SET descr = $2,
  notes = $3
WHERE con_type_id = $1
RETURNING con_type_id, descr, notes, updated_on, created_on
`

type UpdateConTypeParams struct {
	ConTypeID int64          `json:"con_type_id"`
	Descr     string         `json:"descr"`
	Notes     sql.NullString `json:"notes"`
}

func (q *Queries) UpdateConType(ctx context.Context, arg UpdateConTypeParams) (ConType, error) {
	row := q.db.QueryRow(ctx, UpdateConType, arg.ConTypeID, arg.Descr, arg.Notes)
	var i ConType
	err := row.Scan(
		&i.ConTypeID,
		&i.Descr,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
