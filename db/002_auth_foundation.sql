BEGIN;
CREATE TABLE IF NOT EXISTS iccdmt.auth_sessions(id uuid PRIMARY KEY DEFAULT gen_random_uuid(),user_id uuid NOT NULL REFERENCES iccdmt.users ON DELETE CASCADE,token_hash text UNIQUE NOT NULL,expires_at timestamptz NOT NULL,created_at timestamptz NOT NULL DEFAULT now());
CREATE INDEX IF NOT EXISTS auth_sessions_user_idx ON iccdmt.auth_sessions(user_id);
CREATE INDEX IF NOT EXISTS auth_sessions_expiry_idx ON iccdmt.auth_sessions(expires_at);
CREATE TABLE IF NOT EXISTS iccdmt.courses(id uuid PRIMARY KEY DEFAULT gen_random_uuid(),slug text UNIQUE NOT NULL,title jsonb NOT NULL DEFAULT '{"ko":"ICCDMT","en":"ICCDMT","rw":"ICCDMT"}'::jsonb,active boolean NOT NULL DEFAULT true,created_at timestamptz NOT NULL DEFAULT now(),CHECK(title ?& ARRAY['ko','en','rw']));
CREATE TABLE IF NOT EXISTS iccdmt.course_memberships(course_id uuid NOT NULL REFERENCES iccdmt.courses ON DELETE CASCADE,user_id uuid NOT NULL REFERENCES iccdmt.users ON DELETE CASCADE,role text NOT NULL CHECK(role IN('student','ta','professor')),status text NOT NULL DEFAULT 'active' CHECK(status IN('invited','active','suspended','completed')),created_at timestamptz NOT NULL DEFAULT now(),PRIMARY KEY(course_id,user_id));
INSERT INTO iccdmt.courses(slug) VALUES('iccdmt') ON CONFLICT(slug) DO NOTHING;
COMMIT;