// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.15.0
// source: custom_entities.sql

package godevmandb

import (
	"context"
	"database/sql"
)

const CountCustomEntities = `-- name: CountCustomEntities :one
SELECT COUNT(*)
FROM custom_entities
`

func (q *Queries) CountCustomEntities(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountCustomEntities)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateCustomEntity = `-- name: CreateCustomEntity :one
INSERT INTO custom_entities (manufacturer, serial_nr, part, descr)
VALUES ($1, $2, $3, $4)
RETURNING cent_id, manufacturer, serial_nr, part, descr, updated_on, created_on
`

type CreateCustomEntityParams struct {
	Manufacturer string         `json:"manufacturer"`
	SerialNr     string         `json:"serial_nr"`
	Part         sql.NullString `json:"part"`
	Descr        sql.NullString `json:"descr"`
}

func (q *Queries) CreateCustomEntity(ctx context.Context, arg CreateCustomEntityParams) (CustomEntity, error) {
	row := q.db.QueryRow(ctx, CreateCustomEntity,
		arg.Manufacturer,
		arg.SerialNr,
		arg.Part,
		arg.Descr,
	)
	var i CustomEntity
	err := row.Scan(
		&i.CentID,
		&i.Manufacturer,
		&i.SerialNr,
		&i.Part,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteCustomEntity = `-- name: DeleteCustomEntity :exec
DELETE FROM custom_entities
WHERE cent_id = $1
`

func (q *Queries) DeleteCustomEntity(ctx context.Context, centID int64) error {
	_, err := q.db.Exec(ctx, DeleteCustomEntity, centID)
	return err
}

const GetCustomEntities = `-- name: GetCustomEntities :many
SELECT cent_id, manufacturer, serial_nr, part, descr, updated_on, created_on
FROM custom_entities
ORDER BY label
`

func (q *Queries) GetCustomEntities(ctx context.Context) ([]CustomEntity, error) {
	rows, err := q.db.Query(ctx, GetCustomEntities)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []CustomEntity
	for rows.Next() {
		var i CustomEntity
		if err := rows.Scan(
			&i.CentID,
			&i.Manufacturer,
			&i.SerialNr,
			&i.Part,
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

const GetCustomEntity = `-- name: GetCustomEntity :one
SELECT cent_id, manufacturer, serial_nr, part, descr, updated_on, created_on
FROM custom_entities
WHERE cent_id = $1
`

func (q *Queries) GetCustomEntity(ctx context.Context, centID int64) (CustomEntity, error) {
	row := q.db.QueryRow(ctx, GetCustomEntity, centID)
	var i CustomEntity
	err := row.Scan(
		&i.CentID,
		&i.Manufacturer,
		&i.SerialNr,
		&i.Part,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const UpdateCustomEntity = `-- name: UpdateCustomEntity :one
UPDATE custom_entities
SET manufacturer = $2,
  serial_nr = $3,
  part = $4,
  descr = $5
WHERE cent_id = $1
RETURNING cent_id, manufacturer, serial_nr, part, descr, updated_on, created_on
`

type UpdateCustomEntityParams struct {
	CentID       int64          `json:"cent_id"`
	Manufacturer string         `json:"manufacturer"`
	SerialNr     string         `json:"serial_nr"`
	Part         sql.NullString `json:"part"`
	Descr        sql.NullString `json:"descr"`
}

func (q *Queries) UpdateCustomEntity(ctx context.Context, arg UpdateCustomEntityParams) (CustomEntity, error) {
	row := q.db.QueryRow(ctx, UpdateCustomEntity,
		arg.CentID,
		arg.Manufacturer,
		arg.SerialNr,
		arg.Part,
		arg.Descr,
	)
	var i CustomEntity
	err := row.Scan(
		&i.CentID,
		&i.Manufacturer,
		&i.SerialNr,
		&i.Part,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
