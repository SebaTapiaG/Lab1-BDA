CREATE OR REPLACE FUNCTION get_queries_report()
RETURNS TABLE(
    user_name VARCHAR(255),
    query_type CHAR(50),
    query_statement TEXT,
    query_count INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        ql.name AS user_name,
        ql.query_type AS query_type,
        ql.query_statement AS query_statement,
        COUNT(*)::INTEGER AS query_count
    FROM Query_Log ql
    WHERE ql.query_type IN ('INSERT', 'UPDATE', 'DELETE')
    GROUP BY ql.name, ql.query_type, ql.query_statement
    ORDER BY query_count DESC;
END;
$$ LANGUAGE plpgsql;
