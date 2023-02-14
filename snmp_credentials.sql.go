// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.17.0
// source: snmp_credentials.sql

package godevmandb

import (
	"context"
	"database/sql"
	"time"
)

const CountSnmpCredentials = `-- name: CountSnmpCredentials :one
SELECT COUNT(*)
FROM snmp_credentials
`

func (q *Queries) CountSnmpCredentials(ctx context.Context) (int64, error) {
	row := q.db.QueryRow(ctx, CountSnmpCredentials)
	var count int64
	err := row.Scan(&count)
	return count, err
}

const CreateSnmpCredential = `-- name: CreateSnmpCredential :one
INSERT INTO snmp_credentials (
    label,
    variant,
    auth_name,
    auth_proto,
    auth_pass,
    sec_level,
    priv_proto,
    priv_pass
  )
VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
RETURNING snmp_cred_id, label, variant, auth_name, auth_proto, auth_pass, sec_level, priv_proto, priv_pass, updated_on, created_on
`

type CreateSnmpCredentialParams struct {
	Label     string            `json:"label"`
	Variant   int32             `json:"variant"`
	AuthName  string            `json:"auth_name"`
	AuthProto NullSnmpAuthProto `json:"auth_proto"`
	AuthPass  sql.NullString    `json:"auth_pass"`
	SecLevel  NullSnmpSecLevel  `json:"sec_level"`
	PrivProto NullSnmpPrivProto `json:"priv_proto"`
	PrivPass  sql.NullString    `json:"priv_pass"`
}

func (q *Queries) CreateSnmpCredential(ctx context.Context, arg CreateSnmpCredentialParams) (SnmpCredential, error) {
	row := q.db.QueryRow(ctx, CreateSnmpCredential,
		arg.Label,
		arg.Variant,
		arg.AuthName,
		arg.AuthProto,
		arg.AuthPass,
		arg.SecLevel,
		arg.PrivProto,
		arg.PrivPass,
	)
	var i SnmpCredential
	err := row.Scan(
		&i.SnmpCredID,
		&i.Label,
		&i.Variant,
		&i.AuthName,
		&i.AuthProto,
		&i.AuthPass,
		&i.SecLevel,
		&i.PrivProto,
		&i.PrivPass,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const DeleteSnmpCredential = `-- name: DeleteSnmpCredential :exec
DELETE FROM snmp_credentials
WHERE snmp_cred_id = $1
`

func (q *Queries) DeleteSnmpCredential(ctx context.Context, snmpCredID int64) error {
	_, err := q.db.Exec(ctx, DeleteSnmpCredential, snmpCredID)
	return err
}

const GetSnmpCredential = `-- name: GetSnmpCredential :one
SELECT snmp_cred_id, label, variant, auth_name, auth_proto, auth_pass, sec_level, priv_proto, priv_pass, updated_on, created_on
FROM snmp_credentials
WHERE snmp_cred_id = $1
`

func (q *Queries) GetSnmpCredential(ctx context.Context, snmpCredID int64) (SnmpCredential, error) {
	row := q.db.QueryRow(ctx, GetSnmpCredential, snmpCredID)
	var i SnmpCredential
	err := row.Scan(
		&i.SnmpCredID,
		&i.Label,
		&i.Variant,
		&i.AuthName,
		&i.AuthProto,
		&i.AuthPass,
		&i.SecLevel,
		&i.PrivProto,
		&i.PrivPass,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}

const GetSnmpCredentials = `-- name: GetSnmpCredentials :many
SELECT snmp_cred_id, label, variant, auth_name, auth_proto, auth_pass, sec_level, priv_proto, priv_pass, updated_on, created_on
FROM snmp_credentials
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
    OR label ILIKE $5
  )
ORDER BY created_on
LIMIT NULLIF($7::int, 0) OFFSET NULLIF($6::int, 0)
`

type GetSnmpCredentialsParams struct {
	UpdatedGe time.Time `json:"updated_ge"`
	UpdatedLe time.Time `json:"updated_le"`
	CreatedGe time.Time `json:"created_ge"`
	CreatedLe time.Time `json:"created_le"`
	LabelF    string    `json:"label_f"`
	OffsetQ   int32     `json:"offset_q"`
	LimitQ    int32     `json:"limit_q"`
}

func (q *Queries) GetSnmpCredentials(ctx context.Context, arg GetSnmpCredentialsParams) ([]SnmpCredential, error) {
	rows, err := q.db.Query(ctx, GetSnmpCredentials,
		arg.UpdatedGe,
		arg.UpdatedLe,
		arg.CreatedGe,
		arg.CreatedLe,
		arg.LabelF,
		arg.OffsetQ,
		arg.LimitQ,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []SnmpCredential
	for rows.Next() {
		var i SnmpCredential
		if err := rows.Scan(
			&i.SnmpCredID,
			&i.Label,
			&i.Variant,
			&i.AuthName,
			&i.AuthProto,
			&i.AuthPass,
			&i.SecLevel,
			&i.PrivProto,
			&i.PrivPass,
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

const GetSnmpCredentialsMainDevices = `-- name: GetSnmpCredentialsMainDevices :many
SELECT t2.dev_id, t2.site_id, t2.dom_id, t2.snmp_main_id, t2.snmp_ro_id, t2.parent, t2.sys_id, t2.ip4_addr, t2.ip6_addr, t2.host_name, t2.sys_name, t2.sys_location, t2.sys_contact, t2.sw_version, t2.ext_model, t2.installed, t2.monitor, t2.graph, t2.backup, t2.source, t2.type_changed, t2.backup_failed, t2.validation_failed, t2.unresponsive, t2.notes, t2.updated_on, t2.created_on
FROM snmp_credentials t1
  INNER JOIN devices t2 ON t2.snmp_main_id = t1.snmp_cred_id
WHERE t1.snmp_cred_id = $1
`

// Relations
func (q *Queries) GetSnmpCredentialsMainDevices(ctx context.Context, snmpCredID int64) ([]Device, error) {
	rows, err := q.db.Query(ctx, GetSnmpCredentialsMainDevices, snmpCredID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Device
	for rows.Next() {
		var i Device
		if err := rows.Scan(
			&i.DevID,
			&i.SiteID,
			&i.DomID,
			&i.SnmpMainID,
			&i.SnmpRoID,
			&i.Parent,
			&i.SysID,
			&i.Ip4Addr,
			&i.Ip6Addr,
			&i.HostName,
			&i.SysName,
			&i.SysLocation,
			&i.SysContact,
			&i.SwVersion,
			&i.ExtModel,
			&i.Installed,
			&i.Monitor,
			&i.Graph,
			&i.Backup,
			&i.Source,
			&i.TypeChanged,
			&i.BackupFailed,
			&i.ValidationFailed,
			&i.Unresponsive,
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

const GetSnmpCredentialsRoDevices = `-- name: GetSnmpCredentialsRoDevices :many
SELECT t2.dev_id, t2.site_id, t2.dom_id, t2.snmp_main_id, t2.snmp_ro_id, t2.parent, t2.sys_id, t2.ip4_addr, t2.ip6_addr, t2.host_name, t2.sys_name, t2.sys_location, t2.sys_contact, t2.sw_version, t2.ext_model, t2.installed, t2.monitor, t2.graph, t2.backup, t2.source, t2.type_changed, t2.backup_failed, t2.validation_failed, t2.unresponsive, t2.notes, t2.updated_on, t2.created_on
FROM snmp_credentials t1
  INNER JOIN devices t2 ON t2.snmp_ro_id = t1.snmp_cred_id
WHERE t1.snmp_cred_id = $1
`

// Relations
func (q *Queries) GetSnmpCredentialsRoDevices(ctx context.Context, snmpCredID int64) ([]Device, error) {
	rows, err := q.db.Query(ctx, GetSnmpCredentialsRoDevices, snmpCredID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Device
	for rows.Next() {
		var i Device
		if err := rows.Scan(
			&i.DevID,
			&i.SiteID,
			&i.DomID,
			&i.SnmpMainID,
			&i.SnmpRoID,
			&i.Parent,
			&i.SysID,
			&i.Ip4Addr,
			&i.Ip6Addr,
			&i.HostName,
			&i.SysName,
			&i.SysLocation,
			&i.SysContact,
			&i.SwVersion,
			&i.ExtModel,
			&i.Installed,
			&i.Monitor,
			&i.Graph,
			&i.Backup,
			&i.Source,
			&i.TypeChanged,
			&i.BackupFailed,
			&i.ValidationFailed,
			&i.Unresponsive,
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

const UpdateSnmpCredential = `-- name: UpdateSnmpCredential :one
UPDATE snmp_credentials
SET label = $2,
  variant = $3,
  auth_name = $4,
  auth_proto = $5,
  auth_pass = $6,
  sec_level = $7,
  priv_proto = $8,
  priv_pass = $9
WHERE snmp_cred_id = $1
RETURNING snmp_cred_id, label, variant, auth_name, auth_proto, auth_pass, sec_level, priv_proto, priv_pass, updated_on, created_on
`

type UpdateSnmpCredentialParams struct {
	SnmpCredID int64             `json:"snmp_cred_id"`
	Label      string            `json:"label"`
	Variant    int32             `json:"variant"`
	AuthName   string            `json:"auth_name"`
	AuthProto  NullSnmpAuthProto `json:"auth_proto"`
	AuthPass   sql.NullString    `json:"auth_pass"`
	SecLevel   NullSnmpSecLevel  `json:"sec_level"`
	PrivProto  NullSnmpPrivProto `json:"priv_proto"`
	PrivPass   sql.NullString    `json:"priv_pass"`
}

func (q *Queries) UpdateSnmpCredential(ctx context.Context, arg UpdateSnmpCredentialParams) (SnmpCredential, error) {
	row := q.db.QueryRow(ctx, UpdateSnmpCredential,
		arg.SnmpCredID,
		arg.Label,
		arg.Variant,
		arg.AuthName,
		arg.AuthProto,
		arg.AuthPass,
		arg.SecLevel,
		arg.PrivProto,
		arg.PrivPass,
	)
	var i SnmpCredential
	err := row.Scan(
		&i.SnmpCredID,
		&i.Label,
		&i.Variant,
		&i.AuthName,
		&i.AuthProto,
		&i.AuthPass,
		&i.SecLevel,
		&i.PrivProto,
		&i.PrivPass,
		&i.UpdatedOn,
		&i.CreatedOn,
	)
	return i, err
}
