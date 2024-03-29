// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.17.0
// source: user_graphs.sql

package godevmandb

import (
	"context"
	"time"
)

const CountUserGraphs = `-- name: CountUserGraphs :one
SELECT COUNT(*)
FROM user_graphs
`

func (q *Queries) CountUserGraphs(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountUserGraphs)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateUserGraph = `-- name: CreateUserGraph :one
INSERT INTO user_graphs (username, uri, descr, shared)
VALUES ($1, $2, $3, $4)
RETURNING graph_id, username, uri, descr, shared, updated_on, created_on
`

type CreateUserGraphParams struct {
	Username string `json:"username"`
	Uri      string `json:"uri"`
	Descr    string `json:"descr"`
	Shared   bool   `json:"shared"`
}

func (q *Queries) CreateUserGraph(ctx context.Context, arg CreateUserGraphParams) (UserGraph, error) {
	row := q.db.QueryRow(ctx, CreateUserGraph,
		arg.Username,
		arg.Uri,
		arg.Descr,
		arg.Shared,
	)
	var i UserGraph
	err := row.Scan(
		&i.GraphID,
		&i.Username,
		&i.Uri,
		&i.Descr,
		&i.Shared,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteUserGraph = `-- name: DeleteUserGraph :exec
DELETE FROM user_graphs
WHERE graph_id = $1
`

func (q *Queries) DeleteUserGraph(ctx context.Context, graphID int64) error {
	_, err := q.db.Exec(ctx, DeleteUserGraph, graphID)
	return err
}

const GetUserGraph = `-- name: GetUserGraph :one
SELECT graph_id, username, uri, descr, shared, updated_on, created_on
FROM user_graphs
WHERE graph_id = $1
`

func (q *Queries) GetUserGraph(ctx context.Context, graphID int64) (UserGraph, error) {
	row := q.db.QueryRow(ctx, GetUserGraph, graphID)
	var i UserGraph
	err := row.Scan(
		&i.GraphID,
		&i.Username,
		&i.Uri,
		&i.Descr,
		&i.Shared,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetUserGraphUser = `-- name: GetUserGraphUser :one
SELECT t2.username, t2.userlevel, t2.notes, t2.updated_on, t2.created_on
FROM user_graphs t1
  INNER JOIN users t2 ON t2.username = t1.username
WHERE t1.graph_id = $1
`

// Foreign keys
func (q *Queries) GetUserGraphUser(ctx context.Context, graphID int64) (User, error) {
	row := q.db.QueryRow(ctx, GetUserGraphUser, graphID)
	var i User
	err := row.Scan(
		&i.Username,
		&i.Userlevel,
		&i.Notes,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetUserGraphs = `-- name: GetUserGraphs :many
SELECT graph_id, username, uri, descr, shared, updated_on, created_on
FROM user_graphs
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
    OR username = $5
  )
  AND (
    $6::text = ''
    OR descr = $6
  )
  AND (
    $7::text = ''
    OR ($7::text = 'true' AND shared = true)
    OR ($7::text = 'false' AND shared = false)
  )
ORDER BY created_on
LIMIT NULLIF($9::int, 0) OFFSET NULLIF($8::int, 0)
`

type GetUserGraphsParams struct {
	UpdatedGe time.Time `json:"updated_ge"`
	UpdatedLe time.Time `json:"updated_le"`
	CreatedGe time.Time `json:"created_ge"`
	CreatedLe time.Time `json:"created_le"`
	UsernameF string    `json:"username_f"`
	DescrF    string    `json:"descr_f"`
	SharedF   string    `json:"shared_f"`
	OffsetQ   int32     `json:"offset_q"`
	LimitQ    int32     `json:"limit_q"`
}

func (q *Queries) GetUserGraphs(ctx context.Context, arg GetUserGraphsParams) ([]UserGraph, error) {
	rows, err := q.db.Query(ctx, GetUserGraphs,
		arg.UpdatedGe,
		arg.UpdatedLe,
		arg.CreatedGe,
		arg.CreatedLe,
		arg.UsernameF,
		arg.DescrF,
		arg.SharedF,
		arg.OffsetQ,
		arg.LimitQ,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []UserGraph
	for rows.Next() {
		var i UserGraph
		if err := rows.Scan(
			&i.GraphID,
			&i.Username,
			&i.Uri,
			&i.Descr,
			&i.Shared,
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

const UpdateUserGraph = `-- name: UpdateUserGraph :one
UPDATE user_graphs
SET username = $2,
  uri = $3,
  descr = $4,
  shared = $5
WHERE graph_id = $1
RETURNING graph_id, username, uri, descr, shared, updated_on, created_on
`

type UpdateUserGraphParams struct {
	GraphID  int64  `json:"graph_id"`
	Username string `json:"username"`
	Uri      string `json:"uri"`
	Descr    string `json:"descr"`
	Shared   bool   `json:"shared"`
}

func (q *Queries) UpdateUserGraph(ctx context.Context, arg UpdateUserGraphParams) (UserGraph, error) {
	row := q.db.QueryRow(ctx, UpdateUserGraph,
		arg.GraphID,
		arg.Username,
		arg.Uri,
		arg.Descr,
		arg.Shared,
	)
	var i UserGraph
	err := row.Scan(
		&i.GraphID,
		&i.Username,
		&i.Uri,
		&i.Descr,
		&i.Shared,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
