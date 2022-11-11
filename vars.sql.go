// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.15.0
// source: vars.sql

package godevmandb

import (
	"context"
	"database/sql"
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
	Descr   string         `json:"descr"`
	Content sql.NullString `json:"content"`
	Notes   sql.NullString `json:"notes"`
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
ORDER BY descr
LIMIT $1
OFFSET $2
`

type GetVarsParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) GetVars(ctx context.Context, arg GetVarsParams) ([]Var, error) {
	rows, err := q.db.Query(ctx, GetVars, arg.Limit, arg.Offset)
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
	Descr   string         `json:"descr"`
	Content sql.NullString `json:"content"`
	Notes   sql.NullString `json:"notes"`
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
