BEGIN;
ALTER TABLE iccdmt.profiles ADD COLUMN IF NOT EXISTS avatar_url text;
ALTER TABLE iccdmt.profiles ADD COLUMN IF NOT EXISTS bio text;
ALTER TABLE iccdmt.profiles ADD COLUMN IF NOT EXISTS updated_at timestamptz NOT NULL DEFAULT now();
CREATE INDEX IF NOT EXISTS course_memberships_role_status_idx ON iccdmt.course_memberships(course_id,role,status);
COMMIT;
