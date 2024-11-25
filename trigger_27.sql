-- Crear o reemplazar la función del trigger
CREATE OR REPLACE FUNCTION status_trigger()
    RETURNS TRIGGER AS $$
BEGIN
    -- Verificar si todos los detalles de la orden tienen estado "enviado"
    IF (
        SELECT COUNT(*)
        FROM Detalle_Orden
        WHERE id_orden = NEW.id_orden AND estado != 'enviado'
    ) = 0 THEN
        -- Si no hay detalles con estado distinto de "enviado", actualizar el estado de la orden
        UPDATE Orden
        SET estado = 'completada'
        WHERE id_orden = NEW.id_orden;
    ELSE
        -- Si hay al menos un detalle no enviado, mantener el estado como está
        UPDATE Orden
        SET estado = 'pendiente'
        WHERE id_orden = NEW.id_orden;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger asociado a la tabla Detalle_Orden
CREATE TRIGGER status_orden_trigger
AFTER INSERT OR UPDATE OR DELETE ON Detalle_Orden
FOR EACH ROW
EXECUTE FUNCTION status_trigger();