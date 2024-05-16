-- Create the table
CREATE TABLE IF NOT EXISTS public.request (
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    api_name VARCHAR(10) NOT NULL CHECK (api_name IN ('node', 'go'))
);

-- -- Optionally, insert initial data
-- INSERT INTO view (api_name) VALUES ('node');
-- INSERT INTO view (api_name) VALUES ('go');
-- INSERT INTO view (api_name) VALUES ('go');