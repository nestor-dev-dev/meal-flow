-- ==============================================================================
-- 1. TABLA MAESTRA DE CATEGORÍAS PRINCIPALES (Nivel 1)
-- ==============================================================================
CREATE TABLE food_categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    examples TEXT
);

INSERT INTO food_categories (id, name, examples) VALUES
(1, 'Carnes y derivados', 'Pollo, ternera, cerdo, jamón, salchichas, vísceras, aves de caza'),
(2, 'Pescados y mariscos', 'Atún, salmón, gambas, pulpo, almejas, pescado en conserva o salazón'),
(3, 'Huevos y lácteos', 'Huevos, leche, todos los quesos, yogures, y alternativas vegetales (tofu, bebida de soja)'),
(4, 'Vegetales', 'Frutas, verduras, setas, patatas, legumbres, frutos secos, semillas'),
(5, 'Cereales y derivados', 'Arroz, avena, pan, pasta, harinas, cereales de desayuno, snacks salados'),
(6, 'Grasas', 'Aceite de oliva, girasol, mantequilla animal, margarina, manteca'),
(7, 'Condimentos', 'Sal, pimienta, orégano, mayonesa, ketchup, vinagre, salsas preparadas'),
(8, 'Dulces', 'Azúcar, chocolate, galletas, mermeladas, bollería, caramelos'),
(9, 'Preparados y bebidas', 'Croquetas, pizzas precocinadas, agua, zumos, café, refrescos, vino, cerveza'),
(10, 'Otros', 'Suplementos proteicos, complejos vitamínicos, jalea real');

SELECT setval(pg_get_serial_sequence('food_categories', 'id'), (SELECT MAX(id) FROM food_categories));