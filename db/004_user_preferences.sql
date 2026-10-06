BEGIN;
ALTER TABLE iccdmt.profiles ADD COLUMN IF NOT EXISTS preferred_language text NOT NULL DEFAULT 'ko' CHECK (preferred_language IN ('ko','en','rw'));
COMMIT;
