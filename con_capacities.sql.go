// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.17.0
// source: con_capacities.sql

package godevmandb

import (
	"context"
	"time"
)

const CountConCapacities = `-- name: CountConCapacities :one
SELECT COUNT(*)
FROM con_capacities
`

func (q *Queries) CountConCapacities(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountConCapacities)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateConCapacity = `-- name: CreateConCapacity :one
INSERT INTO con_capacities (descr, notes)
VALUES ($1, $2)
RETURNING con_cap_id, descr, notes, updated_on, created_on
`

type CreateConCapacityParams struct {
	Descr string  `json:"descr"`
	Notes *string `json:"notes"`
}

func (q *Queries) CreateConCapacity(ctx context.Context, arg CreateConCapacityParams) (ConCapacity, error) {
	row := q.db.QueryRow(ctx, CreateConCapacity, arg.Descr, arg.Notes)
	var i ConCapacity
	err := row.Scan(
		&i.ConCapID,
		&i.Descr,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteConCapacity = `-- name: DeleteConCapacity :exec
DELETE FROM con_capacities
WHERE con_cap_id = $1
`

func (q *Queries) DeleteConCapacity(ctx context.Context, conCapID int64) error {
	_, err := q.db.Exec(ctx, DeleteConCapacity, conCapID)
	return err
}

const GetConCapacities = `-- name: GetConCapacities :many
SELECT con_cap_id, descr, notes, updated_on, created_on
FROM con_capacities
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

type GetConCapacitiesParams struct {
	UpdatedGe time.Time `json:"updated_ge"`
	UpdatedLe time.Time `json:"updated_le"`
	CreatedGe time.Time `json:"created_ge"`
	CreatedLe time.Time `json:"created_le"`
	DescrF    string    `json:"descr_f"`
	OffsetQ   int32     `json:"offset_q"`
	LimitQ    int32     `json:"limit_q"`
}

func (q *Queries) GetConCapacities(ctx context.Context, arg GetConCapacitiesParams) ([]ConCapacity, error) {
	rows, err := q.db.Query(ctx, GetConCapacities,
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
	var items []ConCapacity
	for rows.Next() {
		var i ConCapacity
		if err := rows.Scan(
			&i.ConCapID,
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

const GetConCapacity = `-- name: GetConCapacity :one
SELECT con_cap_id, descr, notes, updated_on, created_on
FROM con_capacities
WHERE con_cap_id = $1
`

func (q *Queries) GetConCapacity(ctx context.Context, conCapID int64) (ConCapacity, error) {
	row := q.db.QueryRow(ctx, GetConCapacity, conCapID)
	var i ConCapacity
	err := row.Scan(
		&i.ConCapID,
		&i.Descr,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetConCapacityConnections = `-- name: GetConCapacityConnections :many
SELECT con_id, site_id, con_prov_id, con_type_id, con_cap_id, con_class_id, hint, notes, in_use, updated_on, created_on
FROM connections
WHERE con_cap_id = $1
`

// Relations
func (q *Queries) GetConCapacityConnections(ctx context.Context, conCapID int64) ([]Connection, error) {
	rows, err := q.db.Query(ctx, GetConCapacityConnections, conCapID)
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

const UpdateConCapacity = `-- name: UpdateConCapacity :one
UPDATE con_capacities
SET descr = $2,
  notes = $3
WHERE con_cap_id = $1
RETURNING con_cap_id, descr, notes, updated_on, created_on
`

type UpdateConCapacityParams struct {
	ConCapID int64   `json:"con_cap_id"`
	Descr    string  `json:"descr"`
	Notes    *string `json:"notes"`
}

func (q *Queries) UpdateConCapacity(ctx context.Context, arg UpdateConCapacityParams) (ConCapacity, error) {
	row := q.db.QueryRow(ctx, UpdateConCapacity, arg.ConCapID, arg.Descr, arg.Notes)
	var i ConCapacity
	err := row.Scan(
		&i.ConCapID,
		&i.Descr,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
