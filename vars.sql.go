// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.17.0
// source: vars.sql

package godevmandb

import (
	"context"
	"time"
)

const CountVars = `-- name: CountVars :one
SELECT COUNT(*)
FROM vars
`

func (q *Queries) CountVars(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountVars)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateVar = `-- name: CreateVar :one
INSERT INTO vars (descr, content, notes)
VALUES ($1, $2, $3)
RETURNING descr, content, notes, updated_on, created_on
`

type CreateVarParams struct {
	Descr   string  `json:"descr"`
	Content *string `json:"content"`
	Notes   *string `json:"notes"`
}

func (q *Queries) CreateVar(ctx context.Context, arg CreateVarParams) (Var, error) {
	row := q.db.QueryRow(ctx, CreateVar, arg.Descr, arg.Content, arg.Notes)
	var i Var
	err := row.Scan(
		&i.Descr,
		&i.Content,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteVar = `-- name: DeleteVar :exec
DELETE FROM vars
WHERE descr = $1
`

func (q *Queries) DeleteVar(ctx context.Context, descr string) error {
	_, err := q.db.Exec(ctx, DeleteVar, descr)
	return err
}

const GetVar = `-- name: GetVar :one
SELECT descr, content, notes, updated_on, created_on
FROM vars
WHERE descr = $1
`

func (q *Queries) GetVar(ctx context.Context, descr string) (Var, error) {
	row := q.db.QueryRow(ctx, GetVar, descr)
	var i Var
	err := row.Scan(
		&i.Descr,
		&i.Content,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetVars = `-- name: GetVars :many
SELECT descr, content, notes, updated_on, created_on
FROM vars
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
  AND (
    $6::text IS NULL
    OR ($6::text = 'isnull' AND content IS NULL)
    OR ($6::text = 'isempty' AND content = '')
    OR content ILIKE $6
  )
  AND (
    $7::text IS NULL
    OR ($7::text = 'isnull' AND notes IS NULL)
    OR ($7::text = 'isempty' AND notes = '')
    OR notes ILIKE $7
  )
ORDER BY created_on
LIMIT NULLIF($9::int, 0) OFFSET NULLIF($8::int, 0)
`

type GetVarsParams struct {
	UpdatedGe time.Time `json:"updated_ge"`
	UpdatedLe time.Time `json:"updated_le"`
	CreatedGe time.Time `json:"created_ge"`
	CreatedLe time.Time `json:"created_le"`
	DescrF    string    `json:"descr_f"`
	ContentF  *string   `json:"content_f"`
	NotesF    *string   `json:"notes_f"`
	OffsetQ   int32     `json:"offset_q"`
	LimitQ    int32     `json:"limit_q"`
}

func (q *Queries) GetVars(ctx context.Context, arg GetVarsParams) ([]Var, error) {
	rows, err := q.db.Query(ctx, GetVars,
		arg.UpdatedGe,
		arg.UpdatedLe,
		arg.CreatedGe,
		arg.CreatedLe,
		arg.DescrF,
		arg.ContentF,
		arg.NotesF,
		arg.OffsetQ,
		arg.LimitQ,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Var
	for rows.Next() {
		var i Var
		if err := rows.Scan(
			&i.Descr,
			&i.Content,
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

const UpdateVar = `-- name: UpdateVar :one
UPDATE vars
SET content = $2,
    notes = $3
WHERE descr = $1
RETURNING descr, content, notes, updated_on, created_on
`

type UpdateVarParams struct {
	Descr   string  `json:"descr"`
	Content *string `json:"content"`
	Notes   *string `json:"notes"`
}

func (q *Queries) UpdateVar(ctx context.Context, arg UpdateVarParams) (Var, error) {
	row := q.db.QueryRow(ctx, UpdateVar, arg.Descr, arg.Content, arg.Notes)
	var i Var
	err := row.Scan(
		&i.Descr,
		&i.Content,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
