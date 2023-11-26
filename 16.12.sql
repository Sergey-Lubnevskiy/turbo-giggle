CREATE FUNCTION get_database_info(db_name VARCHAR(255))
RETURNS TABLE(table_name VARCHAR(255), record_count INT, size_in_bytes BIGINT)
DECLARE
    _table_name VARCHAR(255);
BEGIN
    FOR _table_name IN (SELECT table_name FROM information_schema.tables WHERE table_schema = db_name)
    LOOP
        RETURN QUERY EXECUTE format('SELECT %I, COUNT(*), pg_total_relation_size(%L)', _table_name, _table_name);
    END LOOP;
END; 
------------------------------
CREATE FUNCTION get_table_fields(table_name VARCHAR(255))
RETURNS TABLE(column_name VARCHAR(255), data_type VARCHAR(255))
BEGIN
    RETURN QUERY SELECT column_name, data_type FROM information_schema.columns WHERE table_name = table_name;
END; 
------------------------------
CREATE FUNCTION get_connected_users()
RETURNS INT 
BEGIN
    RETURN (SELECT COUNT(*) FROM pg_stat_activity);
END; 


