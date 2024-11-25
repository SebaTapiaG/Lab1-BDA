-- Poblar Categoria
INSERT INTO Categoria (nombre) VALUES
                                   ('Electrónica'),
                                   ('Ropa'),
                                   ('Hogar'),
                                   ('Juguetes'),
                                   ('Deportes');

-- Poblar Cliente
INSERT INTO Cliente (nombre, contrasena, direccion, email, telefono) VALUES
                                                                         ('Juan Pérez', 'password123', 'Calle Falsa 123', 'juan.perez@example.com', '123456789'),
                                                                         ('Ana Gómez', 'securepass456', 'Av. Siempre Viva 456', 'ana.gomez@example.com', '987654321'),
                                                                         ('Carlos Ruiz', 'mypassword789', 'Calle Principal 789', 'carlos.ruiz@example.com', '555666777');

-- Poblar Producto
INSERT INTO Producto (nombre, descripcion, precio, stock, estado, id_categoria) VALUES
                                                                                    ('Smartphone', 'Teléfono inteligente de última generación', 699.99, 50, 'disponible', 1),
                                                                                    ('Camiseta', 'Camiseta 100% algodón', 19.99, 200, 'disponible', 2),
                                                                                    ('Sofá', 'Sofá de 3 plazas', 499.99, 10, 'disponible', 3),
                                                                                    ('Pelota de fútbol', 'Pelota oficial tamaño 5', 29.99, 100, 'disponible', 5),
                                                                                    ('Muñeca', 'Muñeca interactiva con accesorios', 39.99, 25, 'disponible', 4);

-- Poblar Orden
INSERT INTO Orden (fecha_orden, estado, id_cliente, total) VALUES
                                                               ('2024-11-01 14:30:00', 'no completada', 1, 749.98), -- Orden aún no completada
                                                               ('2024-11-02 10:15:00', 'completada', 2, 29.99),     -- Orden completada
                                                               ('2024-11-03 18:45:00', 'no completada', 1, 29.99);    -- Orden completada

-- Poblar Detalle_Orden
INSERT INTO Detalle_Orden (id_orden, id_producto, cantidad, precio_unitario, estado) VALUES
                                                                                         (1, 1, 1, 699.99, 'por enviar'),  -- Smartphone en orden 1, por enviar
                                                                                         (1, 2, 2, 19.99, 'por enviar'),   -- Camisetas en orden 1, por enviar
                                                                                         (2, 4, 1, 29.99, 'enviado'),      -- Pelota de fútbol en orden 2, ya enviada
                                                                                         (3, 4, 1, 29.99, 'enviado');      -- Pelota de fútbol en orden 2, ya enviada
