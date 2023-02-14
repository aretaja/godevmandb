// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.17.0
// source: user_authzs.sql

package godevmandb

import (
	"context"
)

const CountUserAuthzs = `-- name: CountUserAuthzs :one
SELECT COUNT(*)
FROM user_authzs
`

func (q *Queries) CountUserAuthzs(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountUserAuthzs)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateUserAuthz = `-- name: CreateUserAuthz :one
INSERT INTO user_authzs (username, dom_id, userlevel)
VALUES ($1, $2, $3)
RETURNING username, dom_id, userlevel, updated_on, created_on
`

type CreateUserAuthzParams struct {
	Username  string `json:"username"`
	DomID     int64  `json:"dom_id"`
	Userlevel int16  `json:"userlevel"`
}

func (q *Queries) CreateUserAuthz(ctx context.Context, arg CreateUserAuthzParams) (UserAuthz, error) {
	row := q.db.QueryRow(ctx, CreateUserAuthz, arg.Username, arg.DomID, arg.Userlevel)
	var i UserAuthz
	err := row.Scan(
		&i.Username,
		&i.DomID,
		&i.Userlevel,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteUserAuthz = `-- name: DeleteUserAuthz :exec
DELETE FROM user_authzs
WHERE username = $1
  AND dom_id = $2
`

type DeleteUserAuthzParams struct {
	Username string `json:"username"`
	DomID    int64  `json:"dom_id"`
}

func (q *Queries) DeleteUserAuthz(ctx context.Context, arg DeleteUserAuthzParams) error {
	_, err := q.db.Exec(ctx, DeleteUserAuthz, arg.Username, arg.DomID)
	return err
}

const GetUserAuthz = `-- name: GetUserAuthz :one
SELECT username, dom_id, userlevel, updated_on, created_on
FROM user_authzs
WHERE username = $1
  AND dom_id = $2
`

type GetUserAuthzParams struct {
	Username string `json:"username"`
	DomID    int64  `json:"dom_id"`
}

func (q *Queries) GetUserAuthz(ctx context.Context, arg GetUserAuthzParams) (UserAuthz, error) {
	row := q.db.QueryRow(ctx, GetUserAuthz, arg.Username, arg.DomID)
	var i UserAuthz
	err := row.Scan(
		&i.Username,
		&i.DomID,
		&i.Userlevel,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetUserAuthzDeviceDomain = `-- name: GetUserAuthzDeviceDomain :one
SELECT t2.dom_id, t2.descr, t2.updated_on, t2.created_on
FROM user_authzs t1
  INNER JOIN device_domains t2 ON t2.dom_id = t1.dom_id
WHERE t1.username = $1
  AND t1.dom_id = $2
`

type GetUserAuthzDeviceDomainParams struct {
	Username string `json:"username"`
	DomID    int64  `json:"dom_id"`
}

// Foreign keys
func (q *Queries) GetUserAuthzDeviceDomain(ctx context.Context, arg GetUserAuthzDeviceDomainParams) (DeviceDomain, error) {
	row := q.db.QueryRow(ctx, GetUserAuthzDeviceDomain, arg.Username, arg.DomID)
	var i DeviceDomain
	err := row.Scan(
		&i.DomID,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetUserAuthzUser = `-- name: GetUserAuthzUser :one
SELECT t2.username, t2.userlevel, t2.notes, t2.updated_on, t2.created_on
FROM user_authzs t1
  INNER JOIN users t2 ON t2.username = t1.username
WHERE t1.username = $1
  AND t1.dom_id = $2
`

type GetUserAuthzUserParams struct {
	Username string `json:"username"`
	DomID    int64  `json:"dom_id"`
}

// Foreign keys
func (q *Queries) GetUserAuthzUser(ctx context.Context, arg GetUserAuthzUserParams) (User, error) {
	row := q.db.QueryRow(ctx, GetUserAuthzUser, arg.Username, arg.DomID)
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

const GetUserAuthzs = `-- name: GetUserAuthzs :many
SELECT username, dom_id, userlevel, updated_on, created_on
FROM user_authzs
ORDER BY username
LIMIT $1
OFFSET $2
`

type GetUserAuthzsParams struct {
	Limit  int32 `json:"limit"`
	Offset int32 `json:"offset"`
}

func (q *Queries) GetUserAuthzs(ctx context.Context, arg GetUserAuthzsParams) ([]UserAuthz, error) {
	rows, err := q.db.Query(ctx, GetUserAuthzs, arg.Limit, arg.Offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []UserAuthz
	for rows.Next() {
		var i UserAuthz
		if err := rows.Scan(
			&i.Username,
			&i.DomID,
			&i.Userlevel,
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

const UpdateUserAuthz = `-- name: UpdateUserAuthz :one
UPDATE user_authzs
SET userlevel = $3
WHERE username = $1
  AND dom_id = $2
RETURNING username, dom_id, userlevel, updated_on, created_on
`

type UpdateUserAuthzParams struct {
	Username  string `json:"username"`
	DomID     int64  `json:"dom_id"`
	Userlevel int16  `json:"userlevel"`
}

func (q *Queries) UpdateUserAuthz(ctx context.Context, arg UpdateUserAuthzParams) (UserAuthz, error) {
	row := q.db.QueryRow(ctx, UpdateUserAuthz, arg.Username, arg.DomID, arg.Userlevel)
	var i UserAuthz
	err := row.Scan(
		&i.Username,
		&i.DomID,
		&i.Userlevel,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
