-- ==============================================================================
-- 2. TABLA DE SUBCATEGORÍAS (Nivel 2 - La lista de 35)
-- ==============================================================================
CREATE TABLE food_subcategories (
    id SERIAL PRIMARY KEY,
    category_id INT NOT NULL REFERENCES food_categories(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    examples TEXT
);

INSERT INTO food_subcategories (id, category_id, name, examples) VALUES
-- Carnes y derivados (Cat 1)
(1, 1, 'Carnes frescas', 'Ternera, cerdo, cordero, cabrito, conejo, carne picada'),
(2, 1, 'Aves y caza', 'Pollo, pavo, pato, oca, pichón, perdiz, liebre, ciervo, avestruz'),
(3, 1, 'Despojos y vísceras', 'Hígado, riñón, corazón, lengua, sesos, callos, molleja, pulmón, rabo de toro'),
(4, 1, 'Embutidos, fiambres y carnes curadas', 'Bacon, chorizo, salchichas, jamón serrano/cocido, paté, foie gras, morcilla, fiambre de pavo'),

-- Pescados y mariscos (Cat 2)
(5, 2, 'Pescados', 'Atún, salmón, merluza, dorada, caballa, lenguado, anguila (frescos o congelados)'),
(6, 2, 'Pescado en conserva, ahumado y salazón', 'Atún en aceite, sardinas en lata, anchoas, bacalao salado, salmón ahumado, arenque, surimi, caviar'),
(7, 2, 'Crustáceos', 'Gambas, langostinos, cangrejos, cigalas, percebes, bogavante'),
(8, 2, 'Moluscos', 'Pulpo, calamar, sepia, mejillones, almejas, berberechos, ostras, caracoles'),

-- Huevos y lácteos (Cat 3)
(9, 3, 'Huevos y derivados', 'Huevo de gallina/codorniz/pato, yema, clara'),
(10, 3, 'Leches y lácteos fermentados', 'Leche de vaca/cabra/oveja/materna, yogures, kéfir, nata, leche condensada'),
(11, 3, 'Quesos', 'Manchego, cabrales, mozzarella, queso fresco, requesón, quesos para untar'),
(12, 3, 'Postres lácteos y helados', 'Flan, natillas, cuajada, arroz con leche, mousse, helados, batidos lácteos, petit suisse'),
(13, 3, 'Alternativas y derivados vegetales', 'Tofu, seitán, bebida de soja, leche de almendra, leche de coco'),

-- Vegetales (Cat 4)
(14, 4, 'Frutas', 'Manzana, plátano, aguacate, aceitunas, pasas, dátiles, fruta en almíbar o congelada'),
(15, 4, 'Verduras, hortalizas y algas', 'Tomate, lechuga, cebolla, espinacas, zanahoria, remolacha, ajo, verdura en conserva o congelada'),
(16, 4, 'Setas y hongos', 'Champiñones, níscalos, trufa, setas'),
(17, 4, 'Tubérculos y raíces amiláceas', 'Patata, boniato, tapioca, chufa, puré de patata en copos'),
(18, 4, 'Legumbres', 'Lentejas, garbanzos, alubias, guisantes, habas, soja, altramuces'),
(19, 4, 'Frutos secos', 'Almendras, nueces, avellanas, cacahuetes, pistachos, castañas, coco, cremas de frutos secos'),
(20, 4, 'Semillas', 'Sésamo, lino, pipas de girasol y calabaza, chía'),

-- Cereales y derivados (Cat 5)
(21, 5, 'Cereales, granos, harinas y almidones', 'Arroz, avena, maíz, trigo, cebada, quinoa, mijo, sémola, harinas, almidones, salvado, gofio'),
(22, 5, 'Cereales de desayuno y barritas', 'Copos de maíz, muesli, cereales azucarados, arroz hinchado, barritas de cereales'),
(23, 5, 'Panes, pastas y masas', 'Pan blanco/integral, pan rallado, pasta, hojaldre'),
(24, 5, 'Snacks salados y aperitivos', 'Patatas chips, palomitas, gusanitos, fritos de maíz, galletas saladas'),

-- Grasas (Cat 6)
(25, 6, 'Grasas y aceites vegetales', 'Aceite de oliva, girasol, soja, coco, palma, margarinas'),
(26, 6, 'Grasas animales y mantequilla', 'Mantequilla, manteca de cerdo, grasa de pollo, tocino, aceite de hígado de bacalao'),

-- Condimentos (Cat 7)
(27, 7, 'Especias, hierbas y sal', 'Pimienta, pimentón, orégano, perejil, azafrán, canela, curry, sal'),
(28, 7, 'Salsas, condimentos y vinagres', 'Mayonesa, ketchup, mostaza, alioli, tomate frito, salsa de soja, boloñesa, bechamel, vinagres, miso'),

-- Dulces (Cat 8)
(29, 8, 'Azúcares, miel y mermeladas', 'Azúcar, miel, fructosa, mermeladas, confituras, pasta de fruta'),
(30, 8, 'Chocolates, cacao y confitería', 'Chocolate, cacao en polvo, cremas de cacao, bombones, caramelos, gominolas, regaliz, turrón, chicles, gelatina'),
(31, 8, 'Galletas, bollería y pastelería', 'Galletas, croissant, donuts, magdalenas, bizcochos, churros, pasteles, ensaimada'),

-- Preparados y bebidas (Cat 9)
(32, 9, 'Platos preparados, sopas y caldos', 'Croquetas, pizzas, paella, lasaña, empanadillas, rollitos, gazpacho, sopas de sobre, cubitos de caldo'),
(33, 9, 'Bebidas no alcohólicas', 'Agua, zumos, néctares, café, té, infusiones, refrescos, bebidas energéticas, horchata, cerveza sin alcohol'),
(34, 9, 'Bebidas alcohólicas', 'Vino, cerveza, cava, sidra, licores, ron, vodka, ginebra, whisky, sangría'),

-- Otros (Cat 10)
(35, 10, 'Suplementos y productos dietéticos', 'Suplemento proteico, complejo vitamínico, lecitina de soja, jalea real');

SELECT setval(pg_get_serial_sequence('food_subcategories', 'id'), (SELECT MAX(id) FROM food_subcategories));