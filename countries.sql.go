// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.15.0
// source: countries.sql

package godevmandb

import (
	"context"
	"database/sql"
)

const CountCountries = `-- name: CountCountries :one
SELECT COUNT(*)
FROM countries
`

func (q *Queries) CountCountries(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountCountries)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateCountry = `-- name: CreateCountry :one
INSERT INTO countries (code, descr)
VALUES ($1, $2)
RETURNING country_id, code, descr, updated_on, created_on
`

type CreateCountryParams struct {
	Code  string `json:"code"`
	Descr string `json:"descr"`
}

func (q *Queries) CreateCountry(ctx context.Context, arg CreateCountryParams) (Country, error) {
	row := q.db.QueryRow(ctx, CreateCountry, arg.Code, arg.Descr)
	var i Country
	err := row.Scan(
		&i.CountryID,
		&i.Code,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteCountry = `-- name: DeleteCountry :exec
DELETE FROM countries
WHERE country_id = $1
`

func (q *Queries) DeleteCountry(ctx context.Context, countryID int64) error {
	_, err := q.db.Exec(ctx, DeleteCountry, countryID)
	return err
}

const GetCountries = `-- name: GetCountries :many
SELECT country_id, code, descr, updated_on, created_on
FROM countries
ORDER BY descr
`

func (q *Queries) GetCountries(ctx context.Context) ([]Country, error) {
	rows, err := q.db.Query(ctx, GetCountries)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Country
	for rows.Next() {
		var i Country
		if err := rows.Scan(
			&i.CountryID,
			&i.Code,
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

const GetCountry = `-- name: GetCountry :one
SELECT country_id, code, descr, updated_on, created_on
FROM countries
WHERE country_id = $1
`

func (q *Queries) GetCountry(ctx context.Context, countryID int64) (Country, error) {
	row := q.db.QueryRow(ctx, GetCountry, countryID)
	var i Country
	err := row.Scan(
		&i.CountryID,
		&i.Code,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetCountrySites = `-- name: GetCountrySites :many
SELECT site_id, country_id, uident, descr, latitude, longitude, area, addr, notes, ext_id, ext_name, updated_on, created_on
FROM sites
WHERE country_id = $1
ORDER BY descr
`

// Relations
func (q *Queries) GetCountrySites(ctx context.Context, countryID sql.NullInt64) ([]Site, error) {
	rows, err := q.db.Query(ctx, GetCountrySites, countryID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Site
	for rows.Next() {
		var i Site
		if err := rows.Scan(
			&i.SiteID,
			&i.CountryID,
			&i.Uident,
			&i.Descr,
			&i.Latitude,
			&i.Longitude,
			&i.Area,
			&i.Addr,
			&i.Notes,
			&i.ExtID,
			&i.ExtName,
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

const UpdateCountry = `-- name: UpdateCountry :one
UPDATE countries
SET code = $2,
  descr = $3
WHERE country_id = $1
RETURNING country_id, code, descr, updated_on, created_on
`

type UpdateCountryParams struct {
	CountryID int64  `json:"country_id"`
	Code      string `json:"code"`
	Descr     string `json:"descr"`
}

func (q *Queries) UpdateCountry(ctx context.Context, arg UpdateCountryParams) (Country, error) {
	row := q.db.QueryRow(ctx, UpdateCountry, arg.CountryID, arg.Code, arg.Descr)
	var i Country
	err := row.Scan(
		&i.CountryID,
		&i.Code,
		&i.Descr,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
