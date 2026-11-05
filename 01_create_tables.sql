-- AI Synapse (AIDASH) schema for SQLite / SQLite Cloud
-- Exported 2026-11-05 07:48 from aidash.db
-- Run this first, then 02_insert_data.sql.

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS bg (id INTEGER PRIMARY KEY, name TEXT UNIQUE NOT NULL, spoc_name TEXT, spoc_email TEXT, spoc_emp_no TEXT);

CREATE TABLE IF NOT EXISTS isu (id INTEGER PRIMARY KEY, bg_id INTEGER NOT NULL REFERENCES bg(id),
    name TEXT NOT NULL, spoc_name TEXT, spoc_email TEXT, spoc_emp_no TEXT, UNIQUE(bg_id, name));

CREATE TABLE IF NOT EXISTS customer (id INTEGER PRIMARY KEY, isu_id INTEGER NOT NULL REFERENCES isu(id),
    name TEXT NOT NULL, spoc_name TEXT, spoc_email TEXT, spoc_emp_no TEXT);

CREATE TABLE IF NOT EXISTS lookup (id INTEGER PRIMARY KEY, category TEXT NOT NULL, value TEXT NOT NULL,
    UNIQUE(category, value));

CREATE TABLE IF NOT EXISTS app_user (
    id INTEGER PRIMARY KEY, username TEXT UNIQUE NOT NULL COLLATE NOCASE,
    password_hash TEXT NOT NULL, full_name TEXT, is_admin INTEGER NOT NULL DEFAULT 0, scope_bg TEXT, scope_isu TEXT);

CREATE TABLE IF NOT EXISTS autonomy (
    customer_id INTEGER PRIMARY KEY REFERENCES customer(id),
    workshop_completed TEXT, mega_ai_journey TEXT, headcount_band TEXT,
    target_level TEXT, target_quarter TEXT);

CREATE TABLE IF NOT EXISTS plan_item (
    id INTEGER PRIMARY KEY, customer_id INTEGER NOT NULL REFERENCES customer(id),
    item TEXT NOT NULL, owner TEXT, due_date TEXT, status TEXT);

CREATE TABLE IF NOT EXISTS assessment (
    id INTEGER PRIMARY KEY, customer_id INTEGER NOT NULL REFERENCES customer(id),
    type TEXT NOT NULL, score REAL, level TEXT NOT NULL, assessment_date TEXT NOT NULL);

CREATE TABLE IF NOT EXISTS deal (
    id INTEGER PRIMARY KEY, customer_id INTEGER NOT NULL REFERENCES customer(id),
    opportunity_id TEXT, opportunity_type TEXT, deal_name TEXT, description TEXT, status TEXT,
    client_context TEXT, past_failure_reasons TEXT, deal_size TEXT, deal_value REAL,
    pursuit_lead TEXT, pitch_focus TEXT, resonated TEXT, not_resonated TEXT,
    entry_date TEXT, reporting_month TEXT, win_team TEXT, competitor TEXT);

CREATE TABLE IF NOT EXISTS touchpoint (
    id INTEGER PRIMARY KEY, customer_id INTEGER NOT NULL REFERENCES customer(id),
    engagement_type TEXT, customer_participants TEXT, tcs_participants TEXT,
    focus_areas TEXT, reporting_month TEXT);

CREATE TABLE IF NOT EXISTS engineer (
    id INTEGER PRIMARY KEY, customer_id INTEGER NOT NULL REFERENCES customer(id),
    associate_name TEXT NOT NULL, employee_number TEXT NOT NULL UNIQUE, location TEXT,
    role_type TEXT, month_added TEXT);

CREATE TABLE IF NOT EXISTS asset (
    id INTEGER PRIMARY KEY, customer_id INTEGER NOT NULL REFERENCES customer(id),
    asset_name TEXT, description TEXT, status TEXT, contribution_month TEXT,
    asset_count INTEGER, contributor TEXT, core_platform TEXT);

