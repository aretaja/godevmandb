// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.15.0
// source: con_classes.sql

package godevmandb

import (
	"context"
	"database/sql"
)

const CountConClasses = `-- name: CountConClasses :one
SELECT COUNT(*)
FROM con_classes
`

func (q *Queries) CountConClasses(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountConClasses)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateConClass = `-- name: CreateConClass :one
INSERT INTO con_classes (descr, notes)
VALUES ($1, $2)
RETURNING con_class_id, descr, notes, updated_on, created_on
`

type CreateConClassParams struct {
	Descr string         `json:"descr"`
	Notes sql.NullString `json:"notes"`
}

func (q *Queries) CreateConClass(ctx context.Context, arg CreateConClassParams) (ConClass, error) {
	row := q.db.QueryRow(ctx, CreateConClass, arg.Descr, arg.Notes)
	var i ConClass
	err := row.Scan(
		&i.ConClassID,
		&i.Descr,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteConClass = `-- name: DeleteConClass :exec
DELETE FROM con_classes
WHERE con_class_id = $1
`

func (q *Queries) DeleteConClass(ctx context.Context, conClassID int64) error {
	_, err := q.db.Exec(ctx, DeleteConClass, conClassID)
	return err
}

const GetConClass = `-- name: GetConClass :one
SELECT con_class_id, descr, notes, updated_on, created_on
FROM con_classes
WHERE con_class_id = $1
`

func (q *Queries) GetConClass(ctx context.Context, conClassID int64) (ConClass, error) {
	row := q.db.QueryRow(ctx, GetConClass, conClassID)
	var i ConClass
	err := row.Scan(
		&i.ConClassID,
		&i.Descr,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetConClassConnections = `-- name: GetConClassConnections :many
SELECT con_id, site_id, con_prov_id, con_type_id, con_cap_id, con_class_id, hint, notes, in_use, updated_on, created_on
FROM connections
WHERE con_class_id = $1
`

// Relations
func (q *Queries) GetConClassConnections(ctx context.Context, conClassID int64) ([]Connection, error) {
	rows, err := q.db.Query(ctx, GetConClassConnections, conClassID)
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

const GetConClasses = `-- name: GetConClasses :many
SELECT con_class_id, descr, notes, updated_on, created_on
FROM con_classes
ORDER BY descr
`

func (q *Queries) GetConClasses(ctx context.Context) ([]ConClass, error) {
	rows, err := q.db.Query(ctx, GetConClasses)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []ConClass
	for rows.Next() {
		var i ConClass
		if err := rows.Scan(
			&i.ConClassID,
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

const UpdateConClass = `-- name: UpdateConClass :one
UPDATE con_classes
SET descr = $2,
  notes = $3
WHERE con_class_id = $1
RETURNING con_class_id, descr, notes, updated_on, created_on
`

type UpdateConClassParams struct {
	ConClassID int64          `json:"con_class_id"`
	Descr      string         `json:"descr"`
	Notes      sql.NullString `json:"notes"`
}

func (q *Queries) UpdateConClass(ctx context.Context, arg UpdateConClassParams) (ConClass, error) {
	row := q.db.QueryRow(ctx, UpdateConClass, arg.ConClassID, arg.Descr, arg.Notes)
	var i ConClass
	err := row.Scan(
		&i.ConClassID,
		&i.Descr,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
