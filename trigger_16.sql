-- Crear o reemplazar la función del trigger
CREATE OR REPLACE FUNCTION query_log()
RETURNS TRIGGER AS $$
BEGIN

    DECLARE date DATE; 
    DECLARE time TIME;
    DECLARE query_type TEXT;

    BEGIN
        date := CURRENT_DATE;
	    time := CURRENT_TIME;

        IF TG_OP == 'INSERT' THEN
            query_type := 'INSERT'
        ELSE IF TG_OP == 'UPDATE' THEN
            query_type := 'UPDATE'
        ELSE TG_OP == 'DELETE' THEN
            query_type := 'DELETE'

        INSERT INTO Query_Log (name, call_date, call_time, query_type, query_statement)
	    VALUES (CURRENT_USER, date, time, query_tipe, CURRENT_QUERY());

END;
$$ LANGUAGE plpgsql;

-- Crear el trigger asociado a la tabla Categoria
CREATE TRIGGER query_log_categoria
AFTER INSERT OR UPDATE OR DELETE ON Categoria
FOR EACH STATEMENT
EXECUTE FUNCTION query_log();

-- Crear el trigger asociado a la tabla Cliente
CREATE TRIGGER query_log_cliente
AFTER INSERT OR UPDATE OR DELETE ON Cliente
FOR EACH STATEMENT
EXECUTE FUNCTION query_log();

-- Crear el trigger asociado a la tabla Orden
CREATE TRIGGER query_log_orden
AFTER INSERT OR UPDATE OR DELETE ON Orden
FOR EACH STATEMENT
EXECUTE FUNCTION query_log();

-- Crear el trigger asociado a la tabla Categoria
CREATE TRIGGER query_log_producto
AFTER INSERT OR UPDATE OR DELETE ON Producto
FOR EACH STATEMENT
EXECUTE FUNCTION query_log();

-- Crear el trigger asociado a la tabla Detalle_Orden
CREATE TRIGGER query_log_detalle_orden
AFTER INSERT OR UPDATE OR DELETE ON Detalle_Orden
FOR EACH STATEMENT
EXECUTE FUNCTION query_log();