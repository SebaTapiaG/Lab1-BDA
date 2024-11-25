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
        name AS user_name,               -- Nombre del usuario
        query_type,                      -- Tipo de consulta
        query_statement,                 -- Declaración SQL
        COUNT(*) AS query_count          -- Cantidad de veces que la consulta fue ejecutada
    FROM Query_Log
    WHERE query_type IN ('INSERT', 'UPDATE', 'DELETE') -- Filtrar solo consultas relevantes
    GROUP BY name, query_type, query_statement         -- Agrupar por usuario, tipo y consulta
    ORDER BY query_count DESC;                         -- Ordenar por número de consultas
END;
$$ LANGUAGE plpgsql;