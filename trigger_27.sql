CREATE OR REPLACE FUNCTION status_trigger()
    RETURNS TRIGGER AS $$
BEGIN
    IF (
        SELECT COUNT(*)
        FROM Detalle_Orden
        WHERE id_orden = NEW.id_orden AND estado != 'enviado'
    ) = 0 THEN
        UPDATE Orden
        SET estado = 'completada'
        WHERE id_orden = NEW.id_orden;
    ELSE
        UPDATE Orden
        SET estado = 'pendiente'
        WHERE id_orden = NEW.id_orden;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER status_orden_trigger
AFTER INSERT OR UPDATE ON Detalle_Orden
FOR EACH ROW
EXECUTE FUNCTION status_trigger();




