-- ==============================================================================
-- 4. TABLA N:M: SUBCATEGORÍAS SECUNDARIAS DE CADA INGREDIENTE  (VERSIÓN DEFINITIVA)
--    La subcategoría PRINCIPAL de cada ingrediente está en ingredients.subcategory_id.
--    Aquí solo se guardan las OTRAS subcategorías a las que el alimento también pertenece
--    porque contiene, en su receta típica, un ingrediente de esa subcategoría.
--    Un ingrediente no tiene fila aquí si no pertenece a ninguna otra subcategoría.
--    Al banear una subcategoría X hay que excluir los ingredientes cuya principal es X
--    Y los que la tienen como secundaria.
--
--    CRITERIO: se vincula cuando el ingrediente lo dice el nombre/definición del alimento
--    o forma parte de su receta estándar. BEDCA no publica recetas: los vínculos que
--    dependen de la receta típica de un producto genérico llevan la marca "ESTIMADO".
--    No se vinculan aditivos (lecitina de soja, sulfitos) ni trazas, ni formas procesadas de
--    la misma materia prima dentro del mismo grupo (jamón/carnes, pan/cereales, queso/leche).
--    Orden de carga: food_categories -> food_subcategories -> ingredients -> esta tabla.
-- ==============================================================================
CREATE TABLE ingrediente_subcategoria_secundaria (
    ingredient_id  INT NOT NULL REFERENCES ingredients(id) ON DELETE CASCADE,
    subcategory_id INT NOT NULL REFERENCES food_subcategories(id) ON DELETE RESTRICT,
    PRIMARY KEY (subcategory_id, ingredient_id)
);



INSERT INTO ingrediente_subcategoria_secundaria (ingredient_id, subcategory_id) VALUES
-- BLOQUE A · Prioritarias: alérgenos, gluten, origen animal, soja/cacahuete/frutos secos/sésamo y alcohol
-- Secundaria: Carnes frescas (1)
(687, 1),  -- Callos de ternera  [principal: 3]
(966, 1),  -- Corazón de cordero, crudo  [principal: 3]
(967, 1),  -- Hígado, de cerdo, crudo  [principal: 3]
(972, 1),  -- Corazón, de cerdo, crudo  [principal: 3]
(973, 1),  -- Corazón, de vaca/buey, cocido  [principal: 3]
(983, 1),  -- Lengua, de buey, cruda  [principal: 3]
(985, 1),  -- Lengua, de ternera, cruda  [principal: 3]
(1024, 1),  -- Corazón, de vaca/buey, crudo  [principal: 3]
(1047, 1),  -- Sesos, de ternera, crudos  [principal: 3]
(1053, 1),  -- Hígado, de vaca/buey, crudo  [principal: 3]
(1063, 1),  -- Riñón, de cordero, crudo  [principal: 3]
(1069, 1),  -- Riñón, de ternera, crudo  [principal: 3]
(1075, 1),  -- Sesos, de cerdo, crudos  [principal: 3]
(1077, 1),  -- Pasta alimenticia, rellena con carne, hervida  [principal: 23]
(1080, 1),  -- Sesos, de cordero, crudos  [principal: 3]
(2123, 1),  -- Kebab  [principal: 32]  · carne de cordero/ternera  · ESTIMADO
(2265, 1),  -- Corazon de vaca, crudo  [principal: 3]
(2275, 1),  -- Lengua de cerdo, cruda  [principal: 3]
(2276, 1),  -- Lengua de cordero, cruda  [principal: 3]
(2278, 1),  -- Molleja de cordero  [principal: 3]
(2284, 1),  -- Pate de higado de cerdo, 30% de grasa  [principal: 4]
(2298, 1),  -- Pulmón, de cerdo, crudo  [principal: 3]
(2299, 1),  -- Pulmón, de cordero, crudo  [principal: 3]
(2300, 1),  -- Pulmón, de ternera, crudo  [principal: 3]
(2301, 1),  -- Rabo de toro  [principal: 3]
(2317, 1),  -- Tocino  [principal: 26]  · tocino = grasa de cerdo
(2474, 1),  -- Albondigas en conserva  [principal: 32]  · ESTIMADO
(2478, 1),  -- Canelones  [principal: 32]
(2549, 1),  -- Manteca  [principal: 26]  · manteca = grasa de cerdo
(2569, 1),  -- San jacobo, congelado  [principal: 32]
(2597, 1),  -- Paella  [principal: 32]  · paella mixta, BEDCA no la detalla  · ESTIMADO
(2604, 1),  -- Lasaña  [principal: 32]
(2615, 1),  -- Flamenquín  [principal: 32]
(2616, 1),  -- Fabada  [principal: 32]
(2620, 1),  -- Empanada de carne  [principal: 32]
(2622, 1),  -- Cubito de caldo  [principal: 32]  · caldo de carne  · ESTIMADO
(2671, 1),  -- Ensaimada  [principal: 31]  · elaborada con manteca de cerdo  · ESTIMADO
-- Secundaria: Aves y caza (2)
(970, 2),  -- Corazón de pollo, crudo  [principal: 3]
(2123, 2),  -- Kebab  [principal: 32]  · carne de ave habitual  · ESTIMADO
(2268, 2),  -- Croquetas de pollo  [principal: 32]
(2269, 2),  -- Foie gras  [principal: 4]  · pato u oca
(2270, 2),  -- Higado de pollo, crudo  [principal: 3]
(2286, 2),  -- Pavo, fiambre  [principal: 4]
(2287, 2),  -- Pavo, fiambre, bajo en grasa  [principal: 4]
(2293, 2),  -- Pollo, fiambre  [principal: 4]
(2294, 2),  -- Pollo, fiambre, bajo en grasa  [principal: 4]
(2308, 2),  -- Salchicha de pollo fresca  [principal: 4]
(2547, 2),  -- Grasa de pollo  [principal: 26]
(2564, 2),  -- Sopa de sobre, sin reconstituir  [principal: 32]  · sabor gallina  · ESTIMADO
(2565, 2),  -- Sopa de sobre maravilla  [principal: 32]  · sabor gallina  · ESTIMADO
(2597, 2),  -- Paella  [principal: 32]  · paella mixta, BEDCA no la detalla  · ESTIMADO
(2622, 2),  -- Cubito de caldo  [principal: 32]  · caldo de ave  · ESTIMADO
-- Secundaria: Despojos y vísceras (3)
(968, 3),  -- Paté de pimienta  [principal: 4]
(2269, 3),  -- Foie gras  [principal: 4]
(2280, 3),  -- Morcilla  [principal: 4]  · sangre
(2281, 3),  -- Morcilla, frita  [principal: 4]  · sangre
(2284, 3),  -- Pate de higado de cerdo, 30% de grasa  [principal: 4]
(2613, 3),  -- Gelatina  [principal: 30]  · colágeno animal puro, no vegano
(2652, 3),  -- Gominola, genérica  [principal: 30]  · contiene gelatina animal  · ESTIMADO
-- Secundaria: Embutidos, fiambres y carnes curadas (4)
(858, 4),  -- Salsa carbonara  [principal: 10]
(2569, 4),  -- San jacobo, congelado  [principal: 32]
(2615, 4),  -- Flamenquín  [principal: 32]
(2616, 4),  -- Fabada  [principal: 32]
-- Secundaria: Pescados (5)
(755, 5),  -- Aceite de hígado de bacalao  [principal: 26]
(947, 5),  -- Queso para untar, con salmón  [principal: 11]
(2495, 5),  -- Preparado lácteo con omega 3  [principal: 10]  · aceite de pescado  · ESTIMADO
-- Secundaria: Pescado en conserva, ahumado y salazón (6)
(2617, 6),  -- Ensaladilla rusa  [principal: 32]  · ESTIMADO
(2619, 6),  -- Empanadilla  [principal: 32]  · relleno habitual de atún  · ESTIMADO
-- Secundaria: Crustáceos (7)
(2562, 7),  -- Surimi  [principal: 6]  · extracto/aroma de cangrejo  · ESTIMADO
(2596, 7),  -- Paella marinera  [principal: 32]
(2597, 7),  -- Paella  [principal: 32]  · paella mixta, BEDCA no la detalla  · ESTIMADO
-- Secundaria: Moluscos (8)
(2596, 8),  -- Paella marinera  [principal: 32]
(2597, 8),  -- Paella  [principal: 32]  · paella mixta, BEDCA no la detalla  · ESTIMADO
-- Secundaria: Huevos y derivados (9)
(769, 9),  -- Barra de chocolate, tipo "Mars"  [principal: 30]  · clara de huevo  · ESTIMADO
(784, 9),  -- Crema inglesa  [principal: 12]
(785, 9),  -- Turrón, tipo Alicante  [principal: 30]  · ESTIMADO
(787, 9),  -- Crema pastelera  [principal: 12]
(858, 9),  -- Salsa carbonara  [principal: 10]
(865, 9),  -- Salsa al roquefort  [principal: 11]  · base tipo mayonesa  · ESTIMADO
(876, 9),  -- Flan de huevo, bajo en calorías  [principal: 12]
(877, 9),  -- Crema de vainilla y mousse de chocolate  [principal: 12]
(913, 9),  -- Leche merengada  [principal: 12]  · merengue: clara de huevo
(1043, 9),  -- Croissant de chocolate  [principal: 31]  · ESTIMADO
(1044, 9),  -- Donut, de chocolate  [principal: 31]  · ESTIMADO
(1051, 9),  -- Galletas, con chocolate, tipo "cookies"  [principal: 31]  · cookies: huevo  · ESTIMADO
(1072, 9),  -- Pasta alimenticia, con huevo, hervida  [principal: 23]
(1078, 9),  -- Pastel de manzana  [principal: 31]  · ESTIMADO
(1086, 9),  -- Sobao  [principal: 31]  · ESTIMADO
(1115, 9),  -- Pastel con fruta confitada  [principal: 31]  · ESTIMADO
(1116, 9),  -- Pastel de chocolate  [principal: 31]  · ESTIMADO
(1118, 9),  -- Pasta alimenticia, con huevo, cruda  [principal: 23]
(2175, 9),  -- Pastas de te  [principal: 31]  · ESTIMADO
(2176, 9),  -- Rosquilla  [principal: 31]  · ESTIMADO
(2268, 9),  -- Croquetas de pollo  [principal: 32]  · ESTIMADO
(2290, 9),  -- Pollo empanado, frito  [principal: 2]  · huevo del empanado  · ESTIMADO
(2348, 9),  -- Merluza, rebozada, frita  [principal: 5]  · ESTIMADO
(2474, 9),  -- Albondigas en conserva  [principal: 32]  · ESTIMADO
(2478, 9),  -- Canelones  [principal: 32]  · pasta al huevo  · ESTIMADO
(2483, 9),  -- Crema catalana  [principal: 12]
(2486, 9),  -- Flan de huevo  [principal: 12]
(2496, 9),  -- Mousse de chocolate  [principal: 12]
(2497, 9),  -- Natillas sabor vainilla  [principal: 12]
(2562, 9),  -- Surimi  [principal: 6]  · clara de huevo  · ESTIMADO
(2569, 9),  -- San jacobo, congelado  [principal: 32]  · ESTIMADO
(2588, 9),  -- Pudding de pasas  [principal: 31]  · ESTIMADO
(2604, 9),  -- Lasaña  [principal: 32]  · láminas de pasta al huevo  · ESTIMADO
(2615, 9),  -- Flamenquín  [principal: 32]  · ESTIMADO
(2617, 9),  -- Ensaladilla rusa  [principal: 32]  · ESTIMADO
(2658, 9),  -- Pastel  [principal: 31]  · ESTIMADO
(2664, 9),  -- Bizcocho  [principal: 31]  · ESTIMADO
(2665, 9),  -- Bollería, genérico  [principal: 31]  · ESTIMADO
(2669, 9),  -- Croissant  [principal: 31]  · ESTIMADO
(2670, 9),  -- Donut  [principal: 31]  · ESTIMADO
(2671, 9),  -- Ensaimada  [principal: 31]  · ESTIMADO
(2678, 9),  -- Magdalena  [principal: 31]  · ESTIMADO
-- Secundaria: Leches y lácteos fermentados (10)
(756, 10),  -- Mantequilla salada  [principal: 26]
(761, 10),  -- Huevo de gallina, revuelto, con mantequilla  [principal: 9]
(766, 10),  -- Barra chocolate, tipo "bounty"  [principal: 30]
(769, 10),  -- Barra de chocolate, tipo "Mars"  [principal: 30]
(770, 10),  -- Barra de chocolate, tipo "Kit-kat"  [principal: 30]
(776, 10),  -- Chocolate con leche y almendras  [principal: 30]
(777, 10),  -- Chocolate con leche y arroz  [principal: 30]
(783, 10),  -- Crema de chocolate con avellanas  [principal: 30]
(903, 10),  -- Crema de chocolate y nata  [principal: 12]
(920, 10),  -- Mousse de yogur, con frutas  [principal: 12]
(921, 10),  -- Mousse de yogur, natural  [principal: 12]
(1043, 10),  -- Croissant de chocolate  [principal: 31]  · ESTIMADO
(1044, 10),  -- Donut, de chocolate  [principal: 31]  · ESTIMADO
(1046, 10),  -- Galleta ,tipo "digestiva", con chocolate  [principal: 31]  · galletas comerciales: suero o leche en polvo  · ESTIMADO
(1050, 10),  -- Galleta, cubierta de chocolate  [principal: 31]  · galletas comerciales: suero o leche en polvo  · ESTIMADO
(1051, 10),  -- Galletas, con chocolate, tipo "cookies"  [principal: 31]  · ESTIMADO
(1052, 10),  -- Galletas, de mantequilla  [principal: 31]  · ESTIMADO
(1060, 10),  -- Masa de hojaldre, cruda  [principal: 23]  · mantequilla del hojaldre clásico (algunas marcas usan grasa vegetal)  · ESTIMADO
(1062, 10),  -- Napolitana, rellena con crema de cacao  [principal: 31]  · ESTIMADO
(1078, 10),  -- Pastel de manzana  [principal: 31]  · ESTIMADO
(1086, 10),  -- Sobao  [principal: 31]  · ESTIMADO
(1102, 10),  -- Galleta, tipo "Digestiva"  [principal: 31]  · galletas comerciales: suero o leche en polvo  · ESTIMADO
(1115, 10),  -- Pastel con fruta confitada  [principal: 31]  · ESTIMADO
(1116, 10),  -- Pastel de chocolate  [principal: 31]  · ESTIMADO
(2123, 10),  -- Kebab  [principal: 32]  · salsa de yogur  · ESTIMADO
(2159, 10),  -- Palmera  [principal: 31]  · hojaldre con mantequilla  · ESTIMADO
(2168, 10),  -- Pan de leche  [principal: 23]  · ESTIMADO
(2174, 10),  -- Pan, tipo hamburguesa  [principal: 23]  · leche en polvo/suero habitual en panes de hamburguesa  · ESTIMADO
(2175, 10),  -- Pastas de te  [principal: 31]  · ESTIMADO
(2176, 10),  -- Rosquilla  [principal: 31]  · ESTIMADO
(2268, 10),  -- Croquetas de pollo  [principal: 32]  · ESTIMADO
(2428, 10),  -- Licor de crema 15-17% vol.  [principal: 34]
(2478, 10),  -- Canelones  [principal: 32]  · ESTIMADO
(2489, 10),  -- Helado de nata  [principal: 12]
(2550, 10),  -- Mantequilla, baja en calorías  [principal: 26]
(2563, 10),  -- Suplemento proteico  [principal: 35]  · suero lácteo, lo más habitual  · ESTIMADO
(2577, 10),  -- Salsa de queso  [principal: 11]
(2588, 10),  -- Pudding de pasas  [principal: 31]  · ESTIMADO
(2604, 10),  -- Lasaña  [principal: 32]  · ESTIMADO
(2607, 10),  -- Hojaldre  [principal: 23]  · mantequilla del hojaldre clásico (algunas marcas usan grasa vegetal)  · ESTIMADO
(2647, 10),  -- Bombón  [principal: 30]  · ESTIMADO
(2650, 10),  -- Chocolate blanco  [principal: 30]
(2651, 10),  -- Chocolate con leche  [principal: 30]
(2658, 10),  -- Pastel  [principal: 31]  · ESTIMADO
(2664, 10),  -- Bizcocho  [principal: 31]  · ESTIMADO
(2665, 10),  -- Bollería, genérico  [principal: 31]  · ESTIMADO
(2669, 10),  -- Croissant  [principal: 31]  · ESTIMADO
(2670, 10),  -- Donut  [principal: 31]  · ESTIMADO
(2671, 10),  -- Ensaimada  [principal: 31]  · ESTIMADO
(2673, 10),  -- Galleta, genérico  [principal: 31]  · galletas comerciales: suero o leche en polvo  · ESTIMADO
(2674, 10),  -- Galletas integrales  [principal: 31]  · galletas comerciales: suero o leche en polvo  · ESTIMADO
(2675, 10),  -- Galletas tipo maria  [principal: 31]  · galletas María comerciales: suero de leche en polvo  · ESTIMADO
(2678, 10),  -- Magdalena  [principal: 31]  · ESTIMADO
-- Secundaria: Quesos (11)
(858, 11),  -- Salsa carbonara  [principal: 10]
(875, 11),  -- Galletas saladas, con queso  [principal: 24]
(917, 11),  -- Mousse de queso fresco, con frutas  [principal: 12]
(918, 11),  -- Mousse de queso fresco, desnatado, azucarado  [principal: 12]
(919, 11),  -- Mousse de queso fresco, desnatado, con frutas  [principal: 12]
(924, 11),  -- Petit suïsse, cereales y fruta  [principal: 12]
(926, 11),  -- Petit suisse, chocolate  [principal: 12]
(927, 11),  -- Petit suisse, fresa  [principal: 12]
(928, 11),  -- Petit líquido, sabor fresa  [principal: 12]
(1007, 11),  -- Petit Suisse, natural azucarado  [principal: 12]
(2478, 11),  -- Canelones  [principal: 32]  · gratinado de queso  · ESTIMADO
(2569, 11),  -- San jacobo, congelado  [principal: 32]
(2589, 11),  -- Pizza, precocinada  [principal: 32]
(2604, 11),  -- Lasaña  [principal: 32]  · ESTIMADO
(2615, 11),  -- Flamenquín  [principal: 32]
-- Secundaria: Legumbres (18)
(747, 18),  -- Aceite de cacahuete  [principal: 25]  · reactividad cruzada legumbre
(801, 18),  -- Bonito del norte, enlatado en aceite de soja  [principal: 6]
(873, 18),  -- Mayonesa, aceite de soja  [principal: 9]
(925, 18),  -- Cacahuete, frito, salado  [principal: 19]
(979, 18),  -- Crema de cacahuete  [principal: 19]
(1121, 18),  -- Tofu  [principal: 13]
(2157, 18),  -- Miso  [principal: 28]
(2185, 18),  -- Cacahuete, crudo, con cáscara  [principal: 19]
(2186, 18),  -- Cacahuete, tostado, salado  [principal: 19]
(2482, 18),  -- Batido de soja  [principal: 13]
(2491, 18),  -- Bebida de soja  [principal: 13]
(2519, 18),  -- Batido fermentado de soja  [principal: 13]
(2546, 18),  -- Aceite de soja  [principal: 25]
(2548, 18),  -- Lecitina de soja  [principal: 35]
(2575, 18),  -- Salsa de soja  [principal: 28]
(2616, 18),  -- Fabada  [principal: 32]  · alubia blanca
(2617, 18),  -- Ensaladilla rusa  [principal: 32]  · guisantes  · ESTIMADO
-- Secundaria: Frutos secos (19)
(747, 19),  -- Aceite de cacahuete  [principal: 25]
(748, 19),  -- Aceite de coco  [principal: 25]
(750, 19),  -- Aceite de nuez  [principal: 25]
(766, 19),  -- Barra chocolate, tipo "bounty"  [principal: 30]
(776, 19),  -- Chocolate con leche y almendras  [principal: 30]
(778, 19),  -- Chocolate con nueces de macadamia  [principal: 30]
(781, 19),  -- Chocolate negro, con almendras  [principal: 30]
(783, 19),  -- Crema de chocolate con avellanas  [principal: 30]
(785, 19),  -- Turrón, tipo Alicante  [principal: 30]
(911, 19),  -- Leche de coco  [principal: 13]
(1040, 19),  -- Cereales desayuno base de trigo, avena, maíz, miel y nueces  [principal: 22]
(1062, 19),  -- Napolitana, rellena con crema de cacao  [principal: 31]  · avellanas  · ESTIMADO
(2155, 19),  -- Cereales desayuno base muesli  [principal: 22]
(2158, 19),  -- Muesli  [principal: 22]
(2490, 19),  -- Leche de almendra  [principal: 13]
(2647, 19),  -- Bombón  [principal: 30]  · praliné/avellana/almendra  · ESTIMADO
-- Secundaria: Semillas (20)
(752, 20),  -- Aceite de sésamo  [principal: 25]
(2174, 20),  -- Pan, tipo hamburguesa  [principal: 23]  · semillas de sésamo habituales  · ESTIMADO
(2180, 20),  -- Torta de aceite  [principal: 31]  · ajonjolí/sésamo
(2542, 20),  -- Aceite de lino  [principal: 25]
(2612, 20),  -- Gomasio  [principal: 27]  · sésamo molido con sal
-- Secundaria: Cereales, granos, harinas y almidones (21)
(749, 21),  -- Aceite de germen de trigo  [principal: 25]
(769, 21),  -- Barra de chocolate, tipo "Mars"  [principal: 30]  · cebada malteada
(770, 21),  -- Barra de chocolate, tipo "Kit-kat"  [principal: 30]
(777, 21),  -- Chocolate con leche y arroz  [principal: 30]
(787, 21),  -- Crema pastelera  [principal: 12]  · harina o maicena según receta  · ESTIMADO
(834, 21),  -- Pescadilla, rebozada en harina, frita  [principal: 5]
(924, 21),  -- Petit suïsse, cereales y fruta  [principal: 12]
(952, 21),  -- Yogur líquido, entero, con cereales  [principal: 10]
(955, 21),  -- Yogur, desnatado, con cereales  [principal: 10]
(1043, 21),  -- Croissant de chocolate  [principal: 31]
(1044, 21),  -- Donut, de chocolate  [principal: 31]
(1046, 21),  -- Galleta ,tipo "digestiva", con chocolate  [principal: 31]
(1048, 21),  -- Galleta, barquillo, con jalea de frutas  [principal: 31]
(1050, 21),  -- Galleta, cubierta de chocolate  [principal: 31]
(1051, 21),  -- Galletas, con chocolate, tipo "cookies"  [principal: 31]
(1052, 21),  -- Galletas, de mantequilla  [principal: 31]
(1062, 21),  -- Napolitana, rellena con crema de cacao  [principal: 31]
(1078, 21),  -- Pastel de manzana  [principal: 31]
(1086, 21),  -- Sobao  [principal: 31]
(1102, 21),  -- Galleta, tipo "Digestiva"  [principal: 31]
(1108, 21),  -- Cerveza, oscura, 8°- 9°  [principal: 34]
(1115, 21),  -- Pastel con fruta confitada  [principal: 31]
(1116, 21),  -- Pastel de chocolate  [principal: 31]
(2157, 21),  -- Miso  [principal: 28]  · koji de arroz o cebada  · ESTIMADO
(2159, 21),  -- Palmera  [principal: 31]
(2175, 21),  -- Pastas de te  [principal: 31]
(2176, 21),  -- Rosquilla  [principal: 31]
(2180, 21),  -- Torta de aceite  [principal: 31]
(2348, 21),  -- Merluza, rebozada, frita  [principal: 5]
(2435, 21),  -- Café, sucedáneo, soluble  [principal: 33]  · cebada/malta  · ESTIMADO
(2437, 21),  -- Cerveza con alcohol  [principal: 34]
(2438, 21),  -- Cerveza sin alcohol  [principal: 33]
(2439, 21),  -- Cerveza, baja en alcohol  [principal: 34]
(2479, 21),  -- Arroz con leche  [principal: 12]
(2524, 21),  -- Yogur, desnatado, con cereales, manzana y ciruela  [principal: 10]
(2533, 21),  -- Yogur, entero, con cereales y fresas  [principal: 10]
(2551, 21),  -- Margarina de maíz  [principal: 25]
(2562, 21),  -- Surimi  [principal: 6]  · almidón de trigo  · ESTIMADO
(2568, 21),  -- Seitán  [principal: 13]  · gluten de trigo puro
(2575, 21),  -- Salsa de soja  [principal: 28]  · trigo fermentado
(2577, 21),  -- Salsa de queso  [principal: 11]  · harina (base tipo bechamel)  · ESTIMADO
(2580, 21),  -- Salsa bechamel  [principal: 10]
(2588, 21),  -- Pudding de pasas  [principal: 31]
(2596, 21),  -- Paella marinera  [principal: 32]
(2597, 21),  -- Paella  [principal: 32]
(2658, 21),  -- Pastel  [principal: 31]
(2659, 21),  -- Regaliz  [principal: 30]  · harina de trigo  · ESTIMADO
(2664, 21),  -- Bizcocho  [principal: 31]
(2665, 21),  -- Bollería, genérico  [principal: 31]
(2668, 21),  -- Churro  [principal: 31]
(2669, 21),  -- Croissant  [principal: 31]
(2670, 21),  -- Donut  [principal: 31]
(2671, 21),  -- Ensaimada  [principal: 31]
(2673, 21),  -- Galleta, genérico  [principal: 31]
(2674, 21),  -- Galletas integrales  [principal: 31]
(2675, 21),  -- Galletas tipo maria  [principal: 31]
(2678, 21),  -- Magdalena  [principal: 31]
-- Secundaria: Cereales de desayuno y barritas (22)
(924, 22),  -- Petit suïsse, cereales y fruta  [principal: 12]
(952, 22),  -- Yogur líquido, entero, con cereales  [principal: 10]
(955, 22),  -- Yogur, desnatado, con cereales  [principal: 10]
(2524, 22),  -- Yogur, desnatado, con cereales, manzana y ciruela  [principal: 10]
(2533, 22),  -- Yogur, entero, con cereales y fresas  [principal: 10]
-- Secundaria: Panes, pastas y masas (23)
(2123, 23),  -- Kebab  [principal: 32]  · ESTIMADO
(2268, 23),  -- Croquetas de pollo  [principal: 32]
(2290, 23),  -- Pollo empanado, frito  [principal: 2]  · pan rallado
(2474, 23),  -- Albondigas en conserva  [principal: 32]  · ESTIMADO
(2476, 23),  -- Bocadillo  [principal: 32]
(2478, 23),  -- Canelones  [principal: 32]
(2564, 23),  -- Sopa de sobre, sin reconstituir  [principal: 32]  · fideos
(2565, 23),  -- Sopa de sobre maravilla  [principal: 32]
(2569, 23),  -- San jacobo, congelado  [principal: 32]
(2587, 23),  -- Rollito de primavera  [principal: 32]
(2589, 23),  -- Pizza, precocinada  [principal: 32]
(2604, 23),  -- Lasaña  [principal: 32]
(2615, 23),  -- Flamenquín  [principal: 32]
(2619, 23),  -- Empanadilla  [principal: 32]
(2620, 23),  -- Empanada de carne  [principal: 32]
-- Secundaria: Grasas animales y mantequilla (26)
(761, 26),  -- Huevo de gallina, revuelto, con mantequilla  [principal: 9]
(1043, 26),  -- Croissant de chocolate  [principal: 31]  · mantequilla  · ESTIMADO
(1052, 26),  -- Galletas, de mantequilla  [principal: 31]  · ESTIMADO
(1060, 26),  -- Masa de hojaldre, cruda  [principal: 23]  · mantequilla del hojaldre clásico (algunas marcas usan grasa vegetal)  · ESTIMADO
(1086, 26),  -- Sobao  [principal: 31]  · ESTIMADO
(2159, 26),  -- Palmera  [principal: 31]  · hojaldre con mantequilla  · ESTIMADO
(2175, 26),  -- Pastas de te  [principal: 31]  · ESTIMADO
(2580, 26),  -- Salsa bechamel  [principal: 10]
(2607, 26),  -- Hojaldre  [principal: 23]  · mantequilla del hojaldre clásico (algunas marcas usan grasa vegetal)  · ESTIMADO
(2669, 26),  -- Croissant  [principal: 31]  · mantequilla  · ESTIMADO
(2671, 26),  -- Ensaimada  [principal: 31]  · manteca de cerdo  · ESTIMADO
-- Secundaria: Azúcares, miel y mermeladas (29)
(785, 29),  -- Turrón, tipo Alicante  [principal: 30]
(1026, 29),  -- Cereales desayuno base de arroz y miel  [principal: 22]
(1031, 29),  -- Cereales desayuno base de maíz y miel  [principal: 22]
(1038, 29),  -- Cereales desayuno base de trigo y miel  [principal: 22]
(1039, 29),  -- Cereales desayuno base de trigo, avena, maiz y miel  [principal: 22]
(1040, 29),  -- Cereales desayuno base de trigo, avena, maíz, miel y nueces  [principal: 22]
(2653, 29),  -- Jalea real  [principal: 35]  · origen apícola, no vegano  · ESTIMADO
-- Secundaria: Bebidas alcohólicas (34)
(695, 34),  -- Queso de murcia, al vino  [principal: 11]
(2438, 34),  -- Cerveza sin alcohol  [principal: 33]  · puede contener trazas <0.9% vol.  · ESTIMADO

-- BLOQUE B · Complementarias: componente definitorio no alergénico (fruta, verdura, aceite, cacao...) y subcategoría culinaria natural (28, 32, 33)
-- Secundaria: Alternativas y derivados vegetales (13)
(901, 13),  -- Crema de coco  [principal: 19]  · sustituto vegetal de nata
-- Secundaria: Frutas (14)
(685, 14),  -- Batido lácteo, de fresa, bajo en calorías  [principal: 12]
(748, 14),  -- Aceite de coco  [principal: 25]  · coco: fruta (drupa)
(766, 14),  -- Barra chocolate, tipo "bounty"  [principal: 30]
(771, 14),  -- Mermelada de albaricoque  [principal: 29]
(772, 14),  -- Mermelada de ciruela  [principal: 29]
(773, 14),  -- Mermelada de grosella roja  [principal: 29]
(774, 14),  -- Mermelada de mora  [principal: 29]
(775, 14),  -- Mermelada de naranja  [principal: 29]
(791, 14),  -- Zumo de uva y melocotón  [principal: 33]
(901, 14),  -- Crema de coco  [principal: 19]
(908, 14),  -- Coco, desecado  [principal: 19]
(909, 14),  -- Coco, fresco  [principal: 19]
(911, 14),  -- Leche de coco  [principal: 13]  · coco: fruta (drupa)
(917, 14),  -- Mousse de queso fresco, con frutas  [principal: 12]
(919, 14),  -- Mousse de queso fresco, desnatado, con frutas  [principal: 12]
(920, 14),  -- Mousse de yogur, con frutas  [principal: 12]
(924, 14),  -- Petit suïsse, cereales y fruta  [principal: 12]
(927, 14),  -- Petit suisse, fresa  [principal: 12]
(937, 14),  -- Zumo de limón, fresco  [principal: 33]
(939, 14),  -- Queso fresco, desnatado, con frutas  [principal: 11]
(1027, 14),  -- Néctar de ciruela  [principal: 33]
(1028, 14),  -- Cereales desayuno base de arroz, trigo y fruta  [principal: 22]
(1036, 14),  -- Cereales desayuno base de trigo y frutas  [principal: 22]
(1048, 14),  -- Galleta, barquillo, con jalea de frutas  [principal: 31]
(1057, 14),  -- Néctar de frutas exóticas, envasado  [principal: 33]
(1061, 14),  -- Néctar de mango, envasado  [principal: 33]
(1068, 14),  -- Zumo de piña y uva  [principal: 33]
(1078, 14),  -- Pastel de manzana  [principal: 31]
(1079, 14),  -- Zumo de pomelo, envasado  [principal: 33]
(1081, 14),  -- Zumo de mango  [principal: 33]
(1089, 14),  -- Zumo de lima, envasado  [principal: 33]
(1090, 14),  -- Zumo de grosella roja  [principal: 33]
(1091, 14),  -- Zumo de grosella negra  [principal: 33]
(1099, 14),  -- Néctar de pomelo  [principal: 33]
(1100, 14),  -- Néctar de piña  [principal: 33]
(1101, 14),  -- Néctar de pera, envasado  [principal: 33]
(1103, 14),  -- Néctar de naranja, envasado  [principal: 33]
(1104, 14),  -- Néctar de melocotón  [principal: 33]
(1105, 14),  -- Néctar de maracuyá, envasado  [principal: 33]
(1106, 14),  -- Néctar de albaricoque, envasado  [principal: 33]
(1115, 14),  -- Pastel con fruta confitada  [principal: 31]
(1131, 14),  -- Yogur, enriquecido, con frutas  [principal: 10]
(1135, 14),  -- Yogur, desnatado, con cereza y frambuesa  [principal: 10]
(1137, 14),  -- Yogur, desnatado, con frutas del bosque  [principal: 10]
(1140, 14),  -- Yogur, desnatado, con frutas tropicales  [principal: 10]
(1141, 14),  -- Yogur, desnatado, con manzana  [principal: 10]
(1144, 14),  -- Yogur, desnatado, con melocotón y maracuyá  [principal: 10]
(1149, 14),  -- Yogur, desnatado, con piña y pomelo  [principal: 10]
(1159, 14),  -- Yogur, entero, con fresas  [principal: 10]
(1160, 14),  -- Yogur líquido, con frutas s/e  [principal: 10]
(1165, 14),  -- Confitura, frutas s/e, baja en calorías  [principal: 29]
(2155, 14),  -- Cereales desayuno base muesli  [principal: 22]
(2158, 14),  -- Muesli  [principal: 22]
(2240, 14),  -- Pasta de fruta  [principal: 29]
(2365, 14),  -- Zumo de uva  [principal: 33]
(2444, 14),  -- Licor apricot  [principal: 34]
(2446, 14),  -- Licor curaçao  [principal: 34]
(2448, 14),  -- Licores de frutas  [principal: 34]
(2449, 14),  -- Limonada  [principal: 33]
(2459, 14),  -- Sangría  [principal: 34]
(2467, 14),  -- Zumo de manzana  [principal: 33]
(2468, 14),  -- Zumo de naranja  [principal: 33]
(2469, 14),  -- Zumo de piña  [principal: 33]
(2481, 14),  -- Batido de fresa  [principal: 12]
(2488, 14),  -- Helado de fresa  [principal: 12]
(2524, 14),  -- Yogur, desnatado, con cereales, manzana y ciruela  [principal: 10]
(2525, 14),  -- Yogur, desnatado, con ciruela, albaricoque y fibra  [principal: 10]
(2526, 14),  -- Yogur, desnatado, con fresa, grosella y fibra  [principal: 10]
(2527, 14),  -- Yogur, desnatado, con frutas  [principal: 10]
(2528, 14),  -- Yogur, desnatado, con melocotón, frambuesa y fibra  [principal: 10]
(2533, 14),  -- Yogur, entero, con cereales y fresas  [principal: 10]
(2534, 14),  -- Yogur, entero, con frutas del bosque  [principal: 10]
(2535, 14),  -- Yogur, líquido, entero, con fresas  [principal: 10]
(2536, 14),  -- Yogur, líquido, entero, con frutas  [principal: 10]
(2588, 14),  -- Pudding de pasas  [principal: 31]
(2654, 14),  -- Mermelada de albaricoque y melocotón, baja en calorías  [principal: 29]
(2655, 14),  -- Mermelada de frambuesa  [principal: 29]
(2656, 14),  -- Mermelada de fresa  [principal: 29]
(2657, 14),  -- Mermelada de fresa, baja en calorías  [principal: 29]
(2663, 14),  -- Barrita cereales con frutas  [principal: 22]
-- Secundaria: Verduras, hortalizas y algas (15)
(790, 15),  -- Alioli  [principal: 9]  · ajo
(792, 15),  -- Caldo vegetal  [principal: 32]
(856, 15),  -- Salsa siciliana, picante  [principal: 28]
(857, 15),  -- Salsa napolitana  [principal: 28]
(879, 15),  -- Maíz, en mazorca, congelado, crudo  [principal: 21]
(888, 15),  -- Puré de patata, con verduras, en copos  [principal: 17]
(1073, 15),  -- Pasta alimenticia, con vegetales, cruda  [principal: 23]
(1182, 15),  -- Sofrito  [principal: 28]
(2248, 15),  -- Zumo de tomate, fresco  [principal: 33]
(2252, 15),  -- Zumo de zanahoria, fresco  [principal: 33]
(2474, 15),  -- Albondigas en conserva  [principal: 32]  · salsa de tomate  · ESTIMADO
(2560, 15),  -- Tomate frito  [principal: 28]
(2564, 15),  -- Sopa de sobre, sin reconstituir  [principal: 32]  · apio  · ESTIMADO
(2565, 15),  -- Sopa de sobre maravilla  [principal: 32]  · apio  · ESTIMADO
(2579, 15),  -- Salsa boloñesa  [principal: 1]
(2581, 15),  -- Salsa barbacoa  [principal: 28]  · base de tomate  · ESTIMADO
(2587, 15),  -- Rollito de primavera  [principal: 32]  · ESTIMADO
(2589, 15),  -- Pizza, precocinada  [principal: 32]
(2605, 15),  -- Ketchup  [principal: 28]
(2614, 15),  -- Gazpacho  [principal: 32]
(2617, 15),  -- Ensaladilla rusa  [principal: 32]  · ESTIMADO
(2619, 15),  -- Empanadilla  [principal: 32]  · relleno habitual de tomate  · ESTIMADO
(2622, 15),  -- Cubito de caldo  [principal: 32]  · verduras/apio  · ESTIMADO
-- Secundaria: Setas y hongos (16)
(2414, 16),  -- Puré de patatas y champiñones, en copos  [principal: 17]
-- Secundaria: Tubérculos y raíces amiláceas (17)
(870, 17),  -- Patatas chips, "lights"  [principal: 24]
(886, 17),  -- Puré de patata y queso, en copos  [principal: 11]
(887, 17),  -- Puré, de patata, con leche  [principal: 10]
(2442, 17),  -- Horchata  [principal: 33]  · chufa
(2594, 17),  -- Patatas, fritas, chips  [principal: 24]
(2617, 17),  -- Ensaladilla rusa  [principal: 32]
-- Secundaria: Grasas y aceites vegetales (25)
(730, 25),  -- Berenjena, frita, en aceite de girasol  [principal: 15]
(790, 25),  -- Alioli  [principal: 9]
(801, 25),  -- Bonito del norte, enlatado en aceite de soja  [principal: 6]
(802, 25),  -- Bonito, enlatado en aceite, escurrido  [principal: 6]
(805, 25),  -- Caballa, enlatada en aceite, escurrida  [principal: 6]
(855, 25),  -- Salsa vinagreta, con aceite de oliva  [principal: 28]
(865, 25),  -- Salsa al roquefort  [principal: 11]  · base tipo mayonesa  · ESTIMADO
(870, 25),  -- Patatas chips, "lights"  [principal: 24]
(873, 25),  -- Mayonesa, aceite de soja  [principal: 9]
(874, 25),  -- Mayonesa, aceite de oliva  [principal: 9]
(883, 25),  -- Patata, frita con aceite s/e, sin sal  [principal: 17]
(884, 25),  -- Patata, salteada con aceite girasol  [principal: 17]
(942, 25),  -- Queso manchego, en aceite  [principal: 11]
(1182, 25),  -- Sofrito  [principal: 28]
(2129, 25),  -- Anchoas en aceite vegetal  [principal: 6]
(2130, 25),  -- Atún en aceite de oliva isabel  [principal: 6]
(2131, 25),  -- Atun en aceite vegetal  [principal: 6]
(2180, 25),  -- Torta de aceite  [principal: 31]  · aceite de oliva
(2314, 25),  -- Bonito en aceite vegetal  [principal: 6]
(2323, 25),  -- Calamares en aceite vegetal  [principal: 8]
(2405, 25),  -- Patata, prefrita, congelada  [principal: 17]
(2553, 25),  -- Mayonesa con aceite de girasol  [principal: 9]
(2554, 25),  -- Mayonesa, baja en calorías  [principal: 9]
(2560, 25),  -- Tomate frito  [principal: 28]
(2594, 25),  -- Patatas, fritas, chips  [principal: 24]
(2601, 25),  -- Mojo picon  [principal: 28]
(2614, 25),  -- Gazpacho  [principal: 32]
(2632, 25),  -- Sardina, enlatada, en aceite, escurrida  [principal: 6]
(2668, 25),  -- Churro  [principal: 31]
-- Secundaria: Especias, hierbas y sal (27)
(945, 27),  -- Queso para untar, con finas hierbas  [principal: 11]
(968, 27),  -- Paté de pimienta  [principal: 4]  · pimienta
(2583, 27),  -- Salsa al curry  [principal: 28]
-- Secundaria: Salsas, condimentos y vinagres (28)
(790, 28),  -- Alioli  [principal: 9]
(858, 28),  -- Salsa carbonara  [principal: 10]
(865, 28),  -- Salsa al roquefort  [principal: 11]
(873, 28),  -- Mayonesa, aceite de soja  [principal: 9]
(874, 28),  -- Mayonesa, aceite de oliva  [principal: 9]
(2406, 28),  -- Pepinillos en vinagre  [principal: 15]  · vinagre
(2553, 28),  -- Mayonesa con aceite de girasol  [principal: 9]
(2554, 28),  -- Mayonesa, baja en calorías  [principal: 9]
(2577, 28),  -- Salsa de queso  [principal: 11]
(2579, 28),  -- Salsa boloñesa  [principal: 1]
(2580, 28),  -- Salsa bechamel  [principal: 10]
-- Secundaria: Azúcares, miel y mermeladas (29)
(1048, 29),  -- Galleta, barquillo, con jalea de frutas  [principal: 31]  · jalea de frutas (azúcar)
-- Secundaria: Chocolates, cacao y confitería (30)
(683, 30),  -- Batido lácteo de cacao, bajo en calorías  [principal: 12]
(768, 30),  -- Barrita cereales trigo y chocolate  [principal: 22]
(877, 30),  -- Crema de vainilla y mousse de chocolate  [principal: 12]
(902, 30),  -- Crema de chocolate, baja en calorías  [principal: 12]
(903, 30),  -- Crema de chocolate y nata  [principal: 12]
(926, 30),  -- Petit suisse, chocolate  [principal: 12]
(1018, 30),  -- Cereales desayuno base de arroz chocolateado  [principal: 22]
(1043, 30),  -- Croissant de chocolate  [principal: 31]
(1044, 30),  -- Donut, de chocolate  [principal: 31]
(1046, 30),  -- Galleta ,tipo "digestiva", con chocolate  [principal: 31]
(1050, 30),  -- Galleta, cubierta de chocolate  [principal: 31]
(1051, 30),  -- Galletas, con chocolate, tipo "cookies"  [principal: 31]
(1062, 30),  -- Napolitana, rellena con crema de cacao  [principal: 31]
(1116, 30),  -- Pastel de chocolate  [principal: 31]
(2480, 30),  -- Batido de chocolate  [principal: 12]
(2487, 30),  -- Helado de chocolate  [principal: 12]
(2496, 30),  -- Mousse de chocolate  [principal: 12]
(2662, 30),  -- Barrita cereales con chocolate  [principal: 22]
(2666, 30),  -- Cereales base trigo y chocolate  [principal: 22]
-- Secundaria: Galletas, bollería y pastelería (31)
(770, 31),  -- Barra de chocolate, tipo "Kit-kat"  [principal: 30]  · oblea
-- Secundaria: Platos preparados, sopas y caldos (32)
(834, 32),  -- Pescadilla, rebozada en harina, frita  [principal: 5]
(2290, 32),  -- Pollo empanado, frito  [principal: 2]
(2348, 32),  -- Merluza, rebozada, frita  [principal: 5]
-- Secundaria: Bebidas no alcohólicas (33)
(681, 33),  -- Café, con leche  [principal: 10]
(1094, 33),  -- Té, infusión, con leche  [principal: 10]
(2440, 33),  -- Cubata  [principal: 34]  · refresco
(2447, 33);  -- Licor de café  [principal: 34]
