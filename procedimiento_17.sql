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
        ql.name AS user_name,                -- Nombre del usuario
        ql.query_type AS query_type,         -- Tipo de consulta
        ql.query_statement AS query_statement, -- Declaración SQL
        COUNT(*)::INTEGER AS query_count     -- Convertir a INTEGER
    FROM Query_Log ql
    WHERE ql.query_type IN ('INSERT', 'UPDATE', 'DELETE') -- Filtrar solo consultas relevantes
    GROUP BY ql.name, ql.query_type, ql.query_statement   -- Agrupar por usuario, tipo y consulta
    ORDER BY query_count DESC;                           -- Ordenar por número de consultas
END;
$$ LANGUAGE plpgsql;
