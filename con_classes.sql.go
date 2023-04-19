// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.17.0
// source: con_classes.sql

package godevmandb

import (
	"context"
	"time"
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
	Descr string  `json:"descr"`
	Notes *string `json:"notes"`
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
    OR ($5 = 'isempty' AND descr = '')
    OR descr ILIKE $5
  )
  AND (
    $6::text IS NULL
    OR ($6::text = 'isnull' AND notes IS NULL)
    OR ($6::text = 'isempty' AND notes = '')
    OR notes ILIKE $6
  )
ORDER BY created_on
LIMIT NULLIF($8::int, 0) OFFSET NULLIF($7::int, 0)
`

type GetConClassesParams struct {
	UpdatedGe time.Time `json:"updated_ge"`
	UpdatedLe time.Time `json:"updated_le"`
	CreatedGe time.Time `json:"created_ge"`
	CreatedLe time.Time `json:"created_le"`
	DescrF    string    `json:"descr_f"`
	NotesF    *string   `json:"notes_f"`
	OffsetQ   int32     `json:"offset_q"`
	LimitQ    int32     `json:"limit_q"`
}

func (q *Queries) GetConClasses(ctx context.Context, arg GetConClassesParams) ([]ConClass, error) {
	rows, err := q.db.Query(ctx, GetConClasses,
		arg.UpdatedGe,
		arg.UpdatedLe,
		arg.CreatedGe,
		arg.CreatedLe,
		arg.DescrF,
		arg.NotesF,
		arg.OffsetQ,
		arg.LimitQ,
	)
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
	ConClassID int64   `json:"con_class_id"`
	Descr      string  `json:"descr"`
	Notes      *string `json:"notes"`
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
