-- ==============================================================================
-- 5. TABLA DE MEDICIONES ALTERNATIVAS (Relacion Ingredientes 1:N Medicion Alternativa)
--    Cada fila = UNA unidad domestica de un ingrediente y los gramos que pesa UNA de esas
--    unidades. La cantidad canonica de las recetas (Tiene.Cantidad) sigue siendo en GRAMOS:
--    la interfaz convierte  cantidad_en_unidad = gramos_totales / gramos  (y al reves).
--
--    * Los GRAMOS (g) son siempre posibles y NO se guardan (unidad base implicita).
--    * 'Mililitro (ml)': gramos = densidad del liquido (g/ml); asi 250 ml = 250 x gramos.
--    * Medida por defecto en la vista = la de MENOR id de cada ingrediente (orden de carga
--      pensado a proposito); el usuario puede cambiar a cualquier otra o a gramos.
--
--    CONVENCIONES: cucharada sopera 15 ml | cucharadita 5 ml | pizca 0,3 ml | chorrito 10 ml
--    | chorro 30 ml | vaso 200 ml | taza 250 ml | lata 330 ml. Caña/copa/chupito = UBE.
--    Gramos por volumen = ml x densidad (USDA). Piezas = peso COMESTIBLE (BEDCA va por
--    100 g de porcion comestible): sin piel, hueso, cascara ni escurrido. Precision de piezas
--    y formatos comerciales: +-15-20 %. Se omite lo que varia mas (carnes, salchichas, pasta).
--    Sin la palabra 'racion' (choca con Receta.Raciones).
--    Orden de carga: food_categories -> food_subcategories -> ingredients -> esta tabla.
-- ==============================================================================
CREATE TABLE medicion_alternativa (
    id SERIAL PRIMARY KEY,
    ingredient_id INT NOT NULL REFERENCES ingredients(id) ON DELETE CASCADE,
    nombre VARCHAR(50) NOT NULL,
    gramos NUMERIC(8, 3) NOT NULL CHECK (gramos > 0),
    UNIQUE (ingredient_id, nombre)   -- su indice (empieza por ingredient_id) ya cubre la busqueda por ingrediente
);

INSERT INTO medicion_alternativa (id, ingredient_id, nombre, gramos) VALUES
-- ------------------------------------------------------------------------------
-- 1. ACEITES Y GRASAS (Subcat 25 y 26)
--   Fisico: gramos = ml x densidad (aceites 0,915-0,93 g/ml; mantequilla 0,95).
-- ------------------------------------------------------------------------------
-- Aceite de oliva (2543)
(1, 2543, 'Cucharada sopera', 13.73),
(2, 2543, 'Cucharadita', 4.58),
(3, 2543, 'Chorrito (10 ml)', 9.15),
(4, 2543, 'Chorro (30 ml)', 27.45),
(5, 2543, 'Mililitro (ml)', 0.915),
-- Aceite de oliva virgen extra (2544)
(6, 2544, 'Cucharada sopera', 13.73),
(7, 2544, 'Cucharadita', 4.58),
(8, 2544, 'Chorrito (10 ml)', 9.15),
(9, 2544, 'Chorro (30 ml)', 27.45),
(10, 2544, 'Mililitro (ml)', 0.915),
-- Aceite de oliva virgen extra, producción ecologica (2545)
(11, 2545, 'Cucharada sopera', 13.73),
(12, 2545, 'Cucharadita', 4.58),
(13, 2545, 'Chorrito (10 ml)', 9.15),
(14, 2545, 'Chorro (30 ml)', 27.45),
(15, 2545, 'Mililitro (ml)', 0.915),
-- Aceite de girasol (2541)
(16, 2541, 'Cucharada sopera', 13.8),
(17, 2541, 'Cucharadita', 4.6),
(18, 2541, 'Chorrito (10 ml)', 9.2),
(19, 2541, 'Chorro (30 ml)', 27.6),
(20, 2541, 'Mililitro (ml)', 0.92),
-- Aceite de soja (2546)
(21, 2546, 'Cucharada sopera', 13.8),
(22, 2546, 'Cucharadita', 4.6),
(23, 2546, 'Chorrito (10 ml)', 9.2),
(24, 2546, 'Chorro (30 ml)', 27.6),
(25, 2546, 'Mililitro (ml)', 0.92),
-- Aceite de colza (753)
(26, 753, 'Cucharada sopera', 13.73),
(27, 753, 'Cucharadita', 4.58),
(28, 753, 'Chorrito (10 ml)', 9.15),
(29, 753, 'Chorro (30 ml)', 27.45),
(30, 753, 'Mililitro (ml)', 0.915),
-- Aceite de cacahuete (747)
(31, 747, 'Cucharada sopera', 13.73),
(32, 747, 'Cucharadita', 4.58),
(33, 747, 'Mililitro (ml)', 0.915),
-- Aceite de coco (748)
(34, 748, 'Cucharada sopera', 13.8),
(35, 748, 'Cucharadita', 4.6),
(36, 748, 'Mililitro (ml)', 0.92),
-- Aceite de germen de trigo (749)
(37, 749, 'Cucharada sopera', 13.8),
(38, 749, 'Cucharadita', 4.6),
(39, 749, 'Mililitro (ml)', 0.92),
-- Aceite de nuez (750)
(40, 750, 'Cucharada sopera', 13.8),
(41, 750, 'Cucharadita', 4.6),
(42, 750, 'Mililitro (ml)', 0.92),
-- Aceite de palma (751)
(43, 751, 'Cucharada sopera', 13.8),
(44, 751, 'Cucharadita', 4.6),
(45, 751, 'Mililitro (ml)', 0.92),
-- Aceite de sésamo (752)
(46, 752, 'Cucharada sopera', 13.8),
(47, 752, 'Cucharadita', 4.6),
(48, 752, 'Mililitro (ml)', 0.92),
-- Aceite de grano de uva (754)
(49, 754, 'Cucharada sopera', 13.8),
(50, 754, 'Cucharadita', 4.6),
(51, 754, 'Mililitro (ml)', 0.92),
-- Aceite de lino (2542)
(52, 2542, 'Cucharada sopera', 13.95),
(53, 2542, 'Cucharadita', 4.65),
(54, 2542, 'Mililitro (ml)', 0.93),
-- Aceite de algodón (746)
(55, 746, 'Cucharada sopera', 13.8),
(56, 746, 'Cucharadita', 4.6),
(57, 746, 'Mililitro (ml)', 0.92),
-- Mantequilla salada (756)
(58, 756, 'Cucharada sopera', 14.25),
(59, 756, 'Cucharadita', 4.75),
(60, 756, 'Nuez de mantequilla', 10),
-- Mantequilla, baja en calorías (2550)
(61, 2550, 'Cucharada sopera', 14.25),
(62, 2550, 'Cucharadita', 4.75),
-- Margarina de maíz (2551)
(63, 2551, 'Cucharada sopera', 14.25),
(64, 2551, 'Cucharadita', 4.75),
-- Margarina, baja en calorías (2552)
(65, 2552, 'Cucharada sopera', 14.25),
(66, 2552, 'Cucharadita', 4.75),
-- Manteca (2549)
(67, 2549, 'Cucharada sopera', 13.8),
(68, 2549, 'Cucharadita', 4.6),
-- Grasa de pollo (2547)
(69, 2547, 'Cucharada sopera', 13.8),
(70, 2547, 'Cucharadita', 4.6),
-- ------------------------------------------------------------------------------
-- 2. CONDIMENTOS, ESPECIAS, SALSAS Y VINAGRES (Subcat 27 y 28)
--   Fisico: gramos = ml x densidad (USDA: sal 1,2; pimenton 0,46; mayonesa 0,92; ketchup 1,13).
-- ------------------------------------------------------------------------------
-- Sal de mar (866)
(71, 866, 'Cucharadita', 6),
(72, 866, 'Cucharada sopera', 18),
(73, 866, 'Pizca', 0.36),
-- Sal yodada (2585)
(74, 2585, 'Cucharadita', 6),
(75, 2585, 'Cucharada sopera', 18),
(76, 2585, 'Pizca', 0.36),
-- Pimienta, negra (2590)
(77, 2590, 'Cucharadita', 2.3),
(78, 2590, 'Cucharada sopera', 6.9),
(79, 2590, 'Pizca', 0.14),
-- Pimienta, blanca (2591)
(80, 2591, 'Cucharadita', 2.4),
(81, 2591, 'Cucharada sopera', 7.2),
(82, 2591, 'Pizca', 0.14),
-- Pimentón, en polvo (2592)
(83, 2592, 'Cucharadita', 2.3),
(84, 2592, 'Cucharada sopera', 6.9),
(85, 2592, 'Pizca', 0.14),
-- Canela, en polvo (2477)
(86, 2477, 'Cucharadita', 2.65),
(87, 2477, 'Cucharada sopera', 7.95),
(88, 2477, 'Pizca', 0.16),
-- Comino (2571)
(89, 2571, 'Cucharadita', 2.15),
(90, 2571, 'Cucharada sopera', 6.45),
(91, 2571, 'Pizca', 0.13),
-- Curry (2621)
(92, 2621, 'Cucharadita', 2.05),
(93, 2621, 'Cucharada sopera', 6.15),
(94, 2621, 'Pizca', 0.12),
-- Ajo, en polvo (2573)
(95, 2573, 'Cucharadita', 3.15),
(96, 2573, 'Cucharada sopera', 9.45),
(97, 2573, 'Pizca', 0.19),
-- Nuez moscada (2599)
(98, 2599, 'Cucharadita', 2.25),
(99, 2599, 'Cucharada sopera', 6.75),
(100, 2599, 'Pizca', 0.14),
-- Orégano, seco (2598)
(101, 2598, 'Cucharadita', 1.5),
(102, 2598, 'Cucharada sopera', 4.5),
(103, 2598, 'Pizca', 0.09),
-- Tomillo, seco (2559)
(104, 2559, 'Cucharadita', 1),
(105, 2559, 'Cucharada sopera', 3),
(106, 2559, 'Pizca', 0.06),
-- Romero (2586)
(107, 2586, 'Cucharadita', 1.2),
(108, 2586, 'Cucharada sopera', 3.6),
(109, 2586, 'Pizca', 0.07),
-- Guindilla, en polvo (2611)
(110, 2611, 'Cucharadita', 1.8),
(111, 2611, 'Cucharada sopera', 5.4),
(112, 2611, 'Pizca', 0.11),
-- Eneldo, seco (2618)
(113, 2618, 'Cucharadita', 1),
(114, 2618, 'Cucharada sopera', 3),
(115, 2618, 'Pizca', 0.06),
-- Azafrán (2475)
(116, 2475, 'Pizca', 0.1),
-- Laurel, hoja (2603)
(117, 2603, 'Hoja', 0.3),
-- Cebollino, crudo (850)
(118, 850, 'Cucharada picada', 3),
-- Perejil, fresco (2593)
(119, 2593, 'Cucharada picada', 4),
-- Jengibre (2606)
(120, 2606, 'Cucharadita (rallado)', 2),
(121, 2606, 'Cucharada sopera (rallado)', 6),
-- Alcaparra (2364)
(122, 2364, 'Cucharada sopera', 9),
(123, 2364, 'Cucharadita', 3),
-- Miso (2157)
(124, 2157, 'Cucharada sopera', 17),
(125, 2157, 'Cucharadita', 5.7),
-- Vinagre de vino (2124)
(126, 2124, 'Cucharada sopera', 15.15),
(127, 2124, 'Cucharadita', 5.05),
(128, 2124, 'Chorrito (10 ml)', 10.1),
(129, 2124, 'Mililitro (ml)', 1.01),
-- Vinagre de manzana (2556)
(130, 2556, 'Cucharada sopera', 15.15),
(131, 2556, 'Cucharadita', 5.05),
(132, 2556, 'Chorrito (10 ml)', 10.1),
(133, 2556, 'Mililitro (ml)', 1.01),
-- Vinagre balsámico (2557)
(134, 2557, 'Cucharada sopera', 15.9),
(135, 2557, 'Cucharadita', 5.3),
(136, 2557, 'Chorrito (10 ml)', 10.6),
(137, 2557, 'Mililitro (ml)', 1.06),
-- Salsa de soja (2575)
(138, 2575, 'Cucharada sopera', 16.2),
(139, 2575, 'Cucharadita', 5.4),
(140, 2575, 'Chorrito (10 ml)', 10.8),
(141, 2575, 'Mililitro (ml)', 1.08),
-- Tabasco (2561)
(142, 2561, 'Cucharadita', 5),
(143, 2561, 'Golpe (0,6 ml)', 0.6),
-- Salsa siciliana, picante (856)
(144, 856, 'Cucharada sopera', 15.6),
(145, 856, 'Cucharadita', 5.2),
-- Salsa napolitana (857)
(146, 857, 'Cucharada sopera', 15.6),
(147, 857, 'Cucharadita', 5.2),
-- Sofrito (1182)
(148, 1182, 'Cucharada sopera', 15.6),
(149, 1182, 'Cucharadita', 5.2),
-- Salsa al curry (2583)
(150, 2583, 'Cucharada sopera', 15.6),
(151, 2583, 'Cucharadita', 5.2),
-- Salsa agridulce (2584)
(152, 2584, 'Cucharada sopera', 15.6),
(153, 2584, 'Cucharadita', 5.2),
-- Salsa boloñesa (2579)
(154, 2579, 'Cucharada sopera', 15.6),
(155, 2579, 'Cucharadita', 5.2),
-- Salsa carbonara (858)
(156, 858, 'Cucharada sopera', 15.6),
(157, 858, 'Cucharadita', 5.2),
-- Salsa al roquefort (865)
(158, 865, 'Cucharada sopera', 15.6),
(159, 865, 'Cucharadita', 5.2),
-- Salsa de queso (2577)
(160, 2577, 'Cucharada sopera', 15.6),
(161, 2577, 'Cucharadita', 5.2),
-- Salsa bechamel (2580)
(162, 2580, 'Cucharada sopera', 15.6),
(163, 2580, 'Cucharadita', 5.2),
-- Tomate frito (2560)
(164, 2560, 'Cucharada sopera', 15.6),
(165, 2560, 'Cucharadita', 5.2),
-- Salsa barbacoa (2581)
(166, 2581, 'Cucharada sopera', 16.95),
(167, 2581, 'Cucharadita', 5.65),
-- Ketchup (2605)
(168, 2605, 'Cucharada sopera', 16.95),
(169, 2605, 'Cucharadita', 5.65),
-- Mostaza (2600)
(170, 2600, 'Cucharada sopera', 15),
(171, 2600, 'Cucharadita', 5),
-- Mayonesa, baja en calorías (2554)
(172, 2554, 'Cucharada sopera', 15),
(173, 2554, 'Cucharadita', 5),
-- Mayonesa, aceite de soja (873)
(174, 873, 'Cucharada sopera', 13.8),
(175, 873, 'Cucharadita', 4.6),
-- Mayonesa, aceite de oliva (874)
(176, 874, 'Cucharada sopera', 13.8),
(177, 874, 'Cucharadita', 4.6),
-- Mayonesa con aceite de girasol (2553)
(178, 2553, 'Cucharada sopera', 13.8),
(179, 2553, 'Cucharadita', 4.6),
-- Alioli (790)
(180, 790, 'Cucharada sopera', 13.8),
(181, 790, 'Cucharadita', 4.6),
-- Salsa vinagreta, con aceite de oliva (855)
(182, 855, 'Cucharada sopera', 14.25),
(183, 855, 'Cucharadita', 4.75),
-- Mojo picon (2601)
(184, 2601, 'Cucharada sopera', 14.55),
(185, 2601, 'Cucharadita', 4.85),
-- Tomate, maduro, puré (892)
(186, 892, 'Cucharada sopera', 16.05),
(187, 892, 'Cucharadita', 5.35),
-- Tomate, maduro, pelado y triturado, enlatado (2423)
(188, 2423, 'Cucharada sopera', 15.6),
(189, 2423, 'Cucharadita', 5.2),
(190, 2423, 'Lata (400 g)', 400),
-- Cubito de caldo (2622)
(191, 2622, 'Cubito', 10),
-- Gelatina (2613)
(192, 2613, 'Hoja', 2),
-- ------------------------------------------------------------------------------
-- 3. AZUCARES, DULCES Y REPOSTERIA (Subcat 29, 30 y 31)
--   Fisico: azucar 0,845; miel 1,42; mermelada 1,35; cremas y cacao segun USDA/etiquetado.
-- ------------------------------------------------------------------------------
-- Azúcar blanca (2642)
(193, 2642, 'Cucharada sopera', 12.67),
(194, 2642, 'Cucharadita', 4.22),
-- Azúcar, moreno (780)
(195, 780, 'Cucharada sopera', 12.67),
(196, 780, 'Cucharadita', 4.22),
-- Miel (2643)
(197, 2643, 'Cucharada sopera', 21.3),
(198, 2643, 'Cucharadita', 7.1),
-- Mermelada de albaricoque (771)
(199, 771, 'Cucharada sopera', 20.25),
(200, 771, 'Cucharadita', 6.75),
-- Mermelada de ciruela (772)
(201, 772, 'Cucharada sopera', 20.25),
(202, 772, 'Cucharadita', 6.75),
-- Mermelada de grosella roja (773)
(203, 773, 'Cucharada sopera', 20.25),
(204, 773, 'Cucharadita', 6.75),
-- Mermelada de mora (774)
(205, 774, 'Cucharada sopera', 20.25),
(206, 774, 'Cucharadita', 6.75),
-- Mermelada de naranja (775)
(207, 775, 'Cucharada sopera', 20.25),
(208, 775, 'Cucharadita', 6.75),
-- Confitura, frutas s/e, baja en calorías (1165)
(209, 1165, 'Cucharada sopera', 20.25),
(210, 1165, 'Cucharadita', 6.75),
-- Mermelada de albaricoque y melocotón, baja en calorías (2654)
(211, 2654, 'Cucharada sopera', 20.25),
(212, 2654, 'Cucharadita', 6.75),
-- Mermelada de frambuesa (2655)
(213, 2655, 'Cucharada sopera', 20.25),
(214, 2655, 'Cucharadita', 6.75),
-- Mermelada de fresa (2656)
(215, 2656, 'Cucharada sopera', 20.25),
(216, 2656, 'Cucharadita', 6.75),
-- Mermelada de fresa, baja en calorías (2657)
(217, 2657, 'Cucharada sopera', 20.25),
(218, 2657, 'Cucharadita', 6.75),
-- Cacao en polvo, azucarado (2648)
(219, 2648, 'Cucharada sopera', 12),
(220, 2648, 'Cucharadita', 4),
-- Cacao, en polvo, azucarado, bajo en calorías (2431)
(221, 2431, 'Cucharada sopera', 12),
(222, 2431, 'Cucharadita', 4),
-- Crema de chocolate con avellanas (783)
(223, 783, 'Cucharada sopera', 18),
(224, 783, 'Cucharadita', 6),
-- Chocolate con leche y almendras (776)
(225, 776, 'Tableta (100 g)', 100),
-- Chocolate con leche y arroz (777)
(226, 777, 'Tableta (100 g)', 100),
-- Chocolate con nueces de macadamia (778)
(227, 778, 'Tableta (100 g)', 100),
-- Chocolate negro, con almendras (781)
(228, 781, 'Tableta (100 g)', 100),
-- Chocolate negro, con azúcar (782)
(229, 782, 'Tableta (100 g)', 100),
-- Chocolate, negro (788)
(230, 788, 'Tableta (100 g)', 100),
-- Chocolate blanco (2650)
(231, 2650, 'Tableta (100 g)', 100),
-- Chocolate con leche (2651)
(232, 2651, 'Tableta (100 g)', 100),
-- Galletas tipo maria (2675)
(233, 2675, 'Unidad (galleta)', 6),
-- Galleta, tipo "Digestiva" (1102)
(234, 1102, 'Unidad (galleta)', 15),
-- Barrita cereales maíz y trigo (767)
(235, 767, 'Unidad (barrita)', 25),
-- Barrita cereales trigo y chocolate (768)
(236, 768, 'Unidad (barrita)', 25),
-- Barrita cereales con chocolate (2662)
(237, 2662, 'Unidad (barrita)', 25),
-- Barrita cereales con frutas (2663)
(238, 2663, 'Unidad (barrita)', 25),
-- Croissant (2669)
(239, 2669, 'Unidad', 60),
-- Donut (2670)
(240, 2670, 'Unidad', 50),
-- Magdalena (2678)
(241, 2678, 'Unidad', 35),
-- Churro (2668)
(242, 2668, 'Unidad', 30),
-- ------------------------------------------------------------------------------
-- 4. CEREALES, HARINAS, PANES Y LEGUMBRES SECAS (Subcat 18, 21 y 23)
--   Fisico: harina 0,53 g/ml; arroz 0,79; lenteja 0,81; garbanzo 0,845. Cucharada colmada = 2 x rasa.
-- ------------------------------------------------------------------------------
-- Harina de trigo (2677)
(243, 2677, 'Cucharada sopera', 7.95),
(244, 2677, 'Cucharada sopera colmada', 15.9),
(245, 2677, 'Cucharadita', 2.65),
(246, 2677, 'Vaso (200 ml)', 106),
(247, 2677, 'Taza (250 ml)', 132.5),
-- Harina de trigo, integral (1113)
(248, 1113, 'Cucharada sopera', 7.5),
(249, 1113, 'Cucharada sopera colmada', 15),
(250, 1113, 'Cucharadita', 2.5),
(251, 1113, 'Vaso (200 ml)', 100),
(252, 1113, 'Taza (250 ml)', 125),
-- Harina de maíz (2644)
(253, 2644, 'Cucharada sopera', 7.95),
(254, 2644, 'Cucharada sopera colmada', 15.9),
(255, 2644, 'Cucharadita', 2.65),
(256, 2644, 'Vaso (200 ml)', 106),
(257, 2644, 'Taza (250 ml)', 132.5),
-- Almidón de maíz (1012)
(258, 1012, 'Cucharada sopera', 8.1),
(259, 1012, 'Cucharada sopera colmada', 16.2),
(260, 1012, 'Cucharadita', 2.7),
(261, 1012, 'Vaso (200 ml)', 108),
(262, 1012, 'Taza (250 ml)', 135),
-- Pan rallado (2171)
(263, 2171, 'Cucharada sopera', 6.75),
(264, 2171, 'Vaso (200 ml)', 90),
-- Arroz (2660)
(265, 2660, 'Vaso (200 ml)', 158),
(266, 2660, 'Taza (250 ml)', 197.5),
-- Arroz integral, crudo (904)
(267, 904, 'Vaso (200 ml)', 160),
(268, 904, 'Taza (250 ml)', 200),
-- Quinoa, cruda (1083)
(269, 1083, 'Vaso (200 ml)', 144),
(270, 1083, 'Taza (250 ml)', 180),
-- Lenteja, seca, cruda (1065)
(271, 1065, 'Vaso (200 ml)', 162),
(272, 1065, 'Taza (250 ml)', 202.5),
-- Garbanzo, seco, crudo (1020)
(273, 1020, 'Vaso (200 ml)', 169),
(274, 1020, 'Taza (250 ml)', 211.25),
-- Alubia blanca, seca, cruda (899)
(275, 899, 'Vaso (200 ml)', 170),
(276, 899, 'Taza (250 ml)', 212.5),
-- Avena, cruda (1010)
(277, 1010, 'Cucharada sopera', 5.1),
(278, 1010, 'Vaso (200 ml)', 68),
-- Garbanzo, en conserva (2191)
(279, 2191, 'Bote (240 g escurrido)', 240),
-- Lenteja, en conserva (1126)
(280, 1126, 'Bote (240 g escurrido)', 240),
-- Alubia blanca, en conserva (898)
(281, 898, 'Bote (240 g escurrido)', 240),
-- Pan blanco, de barra (2160)
(282, 2160, 'Rebanada', 25),
(283, 2160, 'Barra (250 g)', 250),
-- Pan blanco, de barra, sin sal (1064)
(284, 1064, 'Rebanada', 25),
(285, 1064, 'Barra (250 g)', 250),
-- Pan blanco, tipo "baguette" (1066)
(286, 1066, 'Rebanada', 25),
(287, 1066, 'Barra (250 g)', 250),
-- Pan blanco, de molde, tostado (2161)
(288, 2161, 'Rebanada', 25),
-- Pan integral, de molde, tostado (2164)
(289, 2164, 'Rebanada', 25),
-- Pan blanco, tostado (2165)
(290, 2165, 'Rebanada', 25),
-- Pan blanco, tostado sin sal (2166)
(291, 2166, 'Rebanada', 25),
-- Pan integral (2163)
(292, 2163, 'Rebanada', 28),
-- Pan integral, sin sal (2169)
(293, 2169, 'Rebanada', 28),
-- Pan integral, tostado (2170)
(294, 2170, 'Rebanada', 28),
-- Pan tostado integral (2173)
(295, 2173, 'Rebanada', 28),
-- Pan de centeno (2167)
(296, 2167, 'Rebanada', 28),
-- Pan, tipo hamburguesa (2174)
(297, 2174, 'Unidad', 65),
-- ------------------------------------------------------------------------------
-- 5. HUEVOS, LACTEOS Y BEBIDAS VEGETALES (Subcat 9, 10, 11, 12 y 13)
--   Huevos: clases UE M (53-63 g) y L (63-73 g) con cascara, x 0,88 = peso comestible.
-- ------------------------------------------------------------------------------
-- Huevo de gallina fresco (2127)
(298, 2127, 'Unidad talla M', 52),
(299, 2127, 'Unidad talla L', 60),
-- Huevo de gallina, hervido, duro (2126)
(300, 2126, 'Unidad talla M', 52),
(301, 2126, 'Unidad talla L', 60),
-- Huevo de gallina, escalfado (758)
(302, 758, 'Unidad talla M', 52),
(303, 758, 'Unidad talla L', 60),
-- Huevo de gallina, pasado por agua (760)
(304, 760, 'Unidad talla M', 52),
(305, 760, 'Unidad talla L', 60),
-- Huevo de gallina, frito (759)
(306, 759, 'Unidad talla M', 48),
(307, 759, 'Unidad talla L', 55),
-- Huevo de gallina, clara, cruda (1173)
(308, 1173, 'Clara de 1 huevo', 33),
-- Huevo de gallina, yema, cruda (2125)
(309, 2125, 'Yema de 1 huevo', 17),
-- Huevo de codorniz, entero, crudo (757)
(310, 757, 'Unidad', 10),
-- Leche de vaca, entera (2493)
(311, 2493, 'Vaso (200 ml)', 206),
(312, 2493, 'Taza (250 ml)', 257.5),
(313, 2493, 'Cucharada sopera', 15.45),
(314, 2493, 'Mililitro (ml)', 1.03),
-- Leche, semidesnatada, pasteurizada (916)
(315, 916, 'Vaso (200 ml)', 206.6),
(316, 916, 'Taza (250 ml)', 258.25),
(317, 916, 'Cucharada sopera', 15.49),
(318, 916, 'Mililitro (ml)', 1.033),
-- Leche, desnatada, pasteurizada (915)
(319, 915, 'Vaso (200 ml)', 207),
(320, 915, 'Taza (250 ml)', 258.75),
(321, 915, 'Cucharada sopera', 15.52),
(322, 915, 'Mililitro (ml)', 1.035),
-- Leche de cabra (1000)
(323, 1000, 'Vaso (200 ml)', 206),
(324, 1000, 'Taza (250 ml)', 257.5),
(325, 1000, 'Cucharada sopera', 15.45),
(326, 1000, 'Mililitro (ml)', 1.03),
-- Leche de oveja (1002)
(327, 1002, 'Vaso (200 ml)', 207.4),
(328, 1002, 'Taza (250 ml)', 259.25),
(329, 1002, 'Cucharada sopera', 15.55),
(330, 1002, 'Mililitro (ml)', 1.037),
-- Bebida de soja (2491)
(331, 2491, 'Vaso (200 ml)', 206),
(332, 2491, 'Taza (250 ml)', 257.5),
(333, 2491, 'Cucharada sopera', 15.45),
(334, 2491, 'Mililitro (ml)', 1.03),
-- Leche de almendra (2490)
(335, 2490, 'Vaso (200 ml)', 202),
(336, 2490, 'Taza (250 ml)', 252.5),
(337, 2490, 'Cucharada sopera', 15.15),
(338, 2490, 'Mililitro (ml)', 1.01),
-- Leche de coco (911)
(339, 911, 'Vaso (200 ml)', 192),
(340, 911, 'Taza (250 ml)', 240),
(341, 911, 'Cucharada sopera', 14.4),
(342, 911, 'Mililitro (ml)', 0.96),
-- Kefir (1168)
(343, 1168, 'Vaso (200 ml)', 206),
(344, 1168, 'Taza (250 ml)', 257.5),
(345, 1168, 'Cucharada sopera', 15.45),
(346, 1168, 'Mililitro (ml)', 1.03),
-- Café, con leche (681)
(347, 681, 'Taza (250 ml)', 255),
(348, 681, 'Vaso (200 ml)', 204),
(349, 681, 'Mililitro (ml)', 1.02),
-- Té, infusión, con leche (1094)
(350, 1094, 'Taza (250 ml)', 255),
(351, 1094, 'Vaso (200 ml)', 204),
(352, 1094, 'Mililitro (ml)', 1.02),
-- Nata, líquida, para cocinar, 18% de grasa (923)
(353, 923, 'Cucharada sopera', 15.15),
(354, 923, 'Chorrito (10 ml)', 10.1),
(355, 923, 'Mililitro (ml)', 1.01),
(356, 923, 'Brik pequeño (200 ml)', 202),
-- Leche condensada, entera, con azúcar (907)
(357, 907, 'Cucharada sopera', 19.35),
(358, 907, 'Cucharadita', 6.45),
(359, 907, 'Lata (397 g)', 397),
-- Leche de vaca, desnatada, condensada, con azúcar (2492)
(360, 2492, 'Cucharada sopera', 19.35),
(361, 2492, 'Cucharadita', 6.45),
(362, 2492, 'Lata (397 g)', 397),
-- Leche en polvo, semidesnatada (912)
(363, 912, 'Cucharada sopera', 7.5),
(364, 912, 'Cucharadita', 2.5),
-- Yogur, búlgaro (953)
(365, 953, 'Unidad (125 g)', 125),
(366, 953, 'Cucharada sopera', 16),
-- Yogur, desnatado, con cereales (955)
(367, 955, 'Unidad (125 g)', 125),
-- Yogur, enriquecido, natural, con nata (1130)
(368, 1130, 'Unidad (125 g)', 125),
(369, 1130, 'Cucharada sopera', 16),
-- Yogur, enriquecido, con frutas (1131)
(370, 1131, 'Unidad (125 g)', 125),
-- Yogur, desnatado, con cereza y frambuesa (1135)
(371, 1135, 'Unidad (125 g)', 125),
-- Yogur, desnatado, con frutas del bosque (1137)
(372, 1137, 'Unidad (125 g)', 125),
-- Yogur, desnatado, con frutas tropicales (1140)
(373, 1140, 'Unidad (125 g)', 125),
-- Yogur, desnatado, con manzana (1141)
(374, 1141, 'Unidad (125 g)', 125),
-- Yogur, enriquecido, natural (1143)
(375, 1143, 'Unidad (125 g)', 125),
(376, 1143, 'Cucharada sopera', 16),
-- Yogur, desnatado, con melocotón y maracuyá (1144)
(377, 1144, 'Unidad (125 g)', 125),
-- Yogur, enriquecido, natural, azucarado (1145)
(378, 1145, 'Unidad (125 g)', 125),
(379, 1145, 'Cucharada sopera', 16),
-- Yogur, desnatado, con piña y pomelo (1149)
(380, 1149, 'Unidad (125 g)', 125),
-- Yogur, enriquecido, sabor, s/e (1150)
(381, 1150, 'Unidad (125 g)', 125),
-- Yogur, desnatado, sabor vainilla (1158)
(382, 1158, 'Unidad (125 g)', 125),
-- Yogur, entero, con fresas (1159)
(383, 1159, 'Unidad (125 g)', 125),
-- Yogur griego (2520)
(384, 2520, 'Unidad (125 g)', 125),
(385, 2520, 'Cucharada sopera', 16),
-- Yogur, desnatado, con cereales, manzana y ciruela (2524)
(386, 2524, 'Unidad (125 g)', 125),
-- Yogur, desnatado, con ciruela, albaricoque y fibra (2525)
(387, 2525, 'Unidad (125 g)', 125),
-- Yogur, desnatado, con fresa, grosella y fibra (2526)
(388, 2526, 'Unidad (125 g)', 125),
-- Yogur, desnatado, con frutas (2527)
(389, 2527, 'Unidad (125 g)', 125),
-- Yogur, desnatado, con melocotón, frambuesa y fibra (2528)
(390, 2528, 'Unidad (125 g)', 125),
-- Yogur, desnatado, sabor natural (2530)
(391, 2530, 'Unidad (125 g)', 125),
(392, 2530, 'Cucharada sopera', 16),
-- Yogur, desnatado, sabor natural, azucarado (2531)
(393, 2531, 'Unidad (125 g)', 125),
(394, 2531, 'Cucharada sopera', 16),
-- Yogur, desnatado, aromatizado sabor s/e (2532)
(395, 2532, 'Unidad (125 g)', 125),
-- Yogur, entero, con cereales y fresas (2533)
(396, 2533, 'Unidad (125 g)', 125),
-- Yogur, entero, con frutas del bosque (2534)
(397, 2534, 'Unidad (125 g)', 125),
-- Yogur líquido, aromatizado sabor s/e (950)
(398, 950, 'Vaso (200 ml)', 206),
(399, 950, 'Mililitro (ml)', 1.03),
-- Yogur líquido, entero, con cereales (952)
(400, 952, 'Vaso (200 ml)', 206),
(401, 952, 'Mililitro (ml)', 1.03),
-- Yogur líquido, natural, azucarado (1133)
(402, 1133, 'Vaso (200 ml)', 206),
(403, 1133, 'Mililitro (ml)', 1.03),
-- Yogur, líquido, desnatado, natural (1155)
(404, 1155, 'Vaso (200 ml)', 206),
(405, 1155, 'Mililitro (ml)', 1.03),
-- Yogur líquido, con frutas s/e (1160)
(406, 1160, 'Vaso (200 ml)', 206),
(407, 1160, 'Mililitro (ml)', 1.03),
-- Yogur líquido, "tipo actimel" (2521)
(408, 2521, 'Vaso (200 ml)', 206),
(409, 2521, 'Mililitro (ml)', 1.03),
-- Yogur, líquido, entero, con fresas (2535)
(410, 2535, 'Vaso (200 ml)', 206),
(411, 2535, 'Mililitro (ml)', 1.03),
-- Yogur, líquido, entero, con frutas (2536)
(412, 2536, 'Vaso (200 ml)', 206),
(413, 2536, 'Mililitro (ml)', 1.03),
-- Yogur, líquido, entero, sabor fresa (2537)
(414, 2537, 'Vaso (200 ml)', 206),
(415, 2537, 'Mililitro (ml)', 1.03),
-- Yogur, líquido, entero, sabor fresa y plátano (2538)
(416, 2538, 'Vaso (200 ml)', 206),
(417, 2538, 'Mililitro (ml)', 1.03),
-- Yogur, líquido, entero, sabor frutas del bosque (2539)
(418, 2539, 'Vaso (200 ml)', 206),
(419, 2539, 'Mililitro (ml)', 1.03),
-- Yogur, líquido, entero, sabor piña y coco (2540)
(420, 2540, 'Vaso (200 ml)', 206),
(421, 2540, 'Mililitro (ml)', 1.03),
-- Batido de soja (2482)
(422, 2482, 'Vaso (200 ml)', 206),
(423, 2482, 'Taza (250 ml)', 257.5),
(424, 2482, 'Mililitro (ml)', 1.03),
-- Batido fermentado de soja (2519)
(425, 2519, 'Vaso (200 ml)', 206),
(426, 2519, 'Taza (250 ml)', 257.5),
(427, 2519, 'Mililitro (ml)', 1.03),
-- Preparado lácteo con omega 3 (2495)
(428, 2495, 'Vaso (200 ml)', 206),
(429, 2495, 'Taza (250 ml)', 257.5),
(430, 2495, 'Mililitro (ml)', 1.03),
-- Leche fermentada, bifidobacterium, entera, natural (2518)
(431, 2518, 'Unidad (125 g)', 125),
-- Queso para untar (2511)
(432, 2511, 'Cucharada sopera', 15),
(433, 2511, 'Cucharadita', 5),
-- Queso para untar, con finas hierbas (945)
(434, 945, 'Cucharada sopera', 15),
(435, 945, 'Cucharadita', 5),
-- Queso para untar, con salmón (947)
(436, 947, 'Cucharada sopera', 15),
(437, 947, 'Cucharadita', 5),
-- Queso para untar, natural, bajo en calorías (948)
(438, 948, 'Cucharada sopera', 15),
(439, 948, 'Cucharadita', 5),
-- Queso en porciones (2506)
(440, 2506, 'Porción (quesito)', 17),
-- Queso parmesano (2512)
(441, 2512, 'Cucharada sopera', 5),
-- Queso rallado, genérico (2513)
(442, 2513, 'Cucharada sopera', 5),
-- Queso mozzarella (2510)
(443, 2510, 'Bola (125 g)', 125),
-- Queso Cheddar (1005)
(444, 1005, 'Loncha', 20),
-- Queso Gouda (941)
(445, 941, 'Loncha', 20),
-- Queso edam (2504)
(446, 2504, 'Loncha', 20),
-- Queso emmental (2505)
(447, 2505, 'Loncha', 20),
-- Queso semicurado, genérico (2515)
(448, 2515, 'Loncha', 20),
-- Queso tierno, genérico (2516)
(449, 2516, 'Loncha', 20),
-- Petit suisse, chocolate (926)
(450, 926, 'Unidad (55 g)', 55),
-- Petit suisse, fresa (927)
(451, 927, 'Unidad (55 g)', 55),
-- Petit Suisse, natural azucarado (1007)
(452, 1007, 'Unidad (55 g)', 55),
-- Flan de huevo (2486)
(453, 2486, 'Unidad (100 g)', 100),
-- Flan de huevo, bajo en calorías (876)
(454, 876, 'Unidad (100 g)', 100),
-- Natillas sabor vainilla (2497)
(455, 2497, 'Unidad (125 g)', 125),
-- Cuajada (2485)
(456, 2485, 'Unidad (125 g)', 125),
-- Arroz con leche (2479)
(457, 2479, 'Unidad (125 g)', 125),
-- ------------------------------------------------------------------------------
-- 6. FRUTAS, VERDURAS Y TUBERCULOS (Subcat 14, 15, 16 y 17)
--   Pieza media COMESTIBLE (pelada/sin hueso). Tablas UBA (peso bruto) x factor de porcion comestible y USDA (peso comestible); precision +-15-20 %.
-- ------------------------------------------------------------------------------
-- Ajo (2361)
(458, 2361, 'Diente', 4),
(459, 2361, 'Cabeza', 50),
-- Cebolla (2381)
(460, 2381, 'Unidad mediana', 110),
(461, 2381, 'Unidad pequeña', 60),
(462, 2381, 'Unidad grande', 160),
-- Tomate (2421)
(463, 2421, 'Unidad mediana', 140),
(464, 2421, 'Unidad pequeña', 95),
(465, 2421, 'Unidad grande', 235),
-- Zanahoria, cruda (2424)
(466, 2424, 'Unidad mediana', 85),
(467, 2424, 'Unidad pequeña', 60),
(468, 2424, 'Unidad grande', 145),
-- Patata, cruda (2403)
(469, 2403, 'Unidad mediana', 160),
(470, 2403, 'Unidad pequeña', 100),
(471, 2403, 'Unidad grande', 240),
-- Manzana (2231)
(472, 2231, 'Unidad mediana', 180),
(473, 2231, 'Unidad pequeña', 110),
(474, 2231, 'Unidad grande', 240),
-- Calabacín (2376)
(475, 2376, 'Unidad mediana', 200),
-- Berenjena (2370)
(476, 2370, 'Unidad mediana', 250),
-- Pimiento rojo, crudo (2409)
(477, 2409, 'Unidad mediana', 150),
-- Pepino (2407)
(478, 2407, 'Unidad mediana', 200),
-- Apio, crudo (2366)
(479, 2366, 'Rama', 40),
-- Champiñon (2384)
(480, 2384, 'Unidad', 20),
-- Espárrago, verde (1179)
(481, 1179, 'Unidad', 16),
-- Aguacate (2216)
(482, 2216, 'Unidad mediana', 140),
(483, 2216, 'Medio aguacate', 70),
-- Plátano (2245)
(484, 2245, 'Unidad mediana (pelado)', 110),
-- Naranja (2235)
(485, 2235, 'Unidad mediana', 140),
-- Mandarina (2229)
(486, 2229, 'Unidad', 80),
-- Pera (2241)
(487, 2241, 'Unidad mediana', 160),
-- Melocotón (2232)
(488, 2232, 'Unidad mediana', 150),
-- Nectarina (2236)
(489, 2236, 'Unidad mediana', 140),
-- Kiwi (2228)
(490, 2228, 'Unidad', 70),
-- Fresa (2225)
(491, 2225, 'Unidad (fresa)', 15),
-- Cereza (2220)
(492, 2220, 'Unidad (cereza)', 8),
-- Albaricoque (2218)
(493, 2218, 'Unidad', 35),
-- Ciruela, sin piel (2223)
(494, 2223, 'Unidad', 60),
-- Ciruela, con piel, cruda (1172)
(495, 1172, 'Unidad', 65),
-- Higos y brevas (2227)
(496, 2227, 'Unidad (higo)', 50),
-- Piña (2242)
(497, 2242, 'Rodaja', 60),
-- Aceituna (2214)
(498, 2214, 'Unidad (aceituna)', 4),
-- Aceituna negra, con hueso (2215)
(499, 2215, 'Unidad (aceituna)', 4),
-- ------------------------------------------------------------------------------
-- 7. FRUTOS SECOS Y SEMILLAS (Subcat 19 y 20)
--   Puñado de fruto seco pelado = 30 g (1 oz). Cucharadas de cremas y semillas segun USDA.
-- ------------------------------------------------------------------------------
-- Almendra, cruda (896)
(500, 896, 'Puñado', 30),
-- Almendra, frita, salada (897)
(501, 897, 'Puñado', 30),
-- Almendra, tostada (2182)
(502, 2182, 'Puñado', 30),
-- Anacardo, crudo (922)
(503, 922, 'Puñado', 30),
-- Cacahuete, frito, salado (925)
(504, 925, 'Puñado', 30),
-- Cacahuete, tostado, salado (2186)
(505, 2186, 'Puñado', 30),
-- Nuez (2201)
(506, 2201, 'Puñado', 30),
-- Avellana (2219)
(507, 2219, 'Puñado', 30),
-- Pistacho (2207)
(508, 2207, 'Puñado', 30),
-- Frutos secos (2189)
(509, 2189, 'Puñado', 30),
-- Crema de cacahuete (979)
(510, 979, 'Cucharada sopera', 16),
(511, 979, 'Cucharadita', 5.3),
-- Crema de almendras (2188)
(512, 2188, 'Cucharada sopera', 16),
(513, 2188, 'Cucharadita', 5.3),
-- Pasta de sésamo (2567)
(514, 2567, 'Cucharada sopera', 15),
(515, 2567, 'Cucharadita', 5),
-- Sésamo, semilla (1127)
(516, 1127, 'Cucharada sopera', 9),
(517, 1127, 'Cucharadita', 3),
-- Semilla de lino (2178)
(518, 2178, 'Cucharada sopera', 10),
(519, 2178, 'Cucharadita', 3.4),
-- Pipa de calabaza (2204)
(520, 2204, 'Cucharada sopera', 9),
(521, 2204, 'Cucharadita', 3),
-- Pipa de girasol (2205)
(522, 2205, 'Cucharada sopera', 9),
(523, 2205, 'Cucharadita', 3),
-- Pipas de girasol, peladas, con sal (2206)
(524, 2206, 'Cucharada sopera', 9),
(525, 2206, 'Cucharadita', 3),
-- ------------------------------------------------------------------------------
-- 8. CARNES, EMBUTIDOS Y CONSERVAS DE PESCADO (Subcat 1, 2, 4, 6 y 8)
--   Embutidos: loncha comercial. Conservas: peso ESCURRIDO de la lata estandar espanola.
-- ------------------------------------------------------------------------------
-- Pollo, pechuga, plancha (2297)
(526, 2297, 'Filete', 125),
-- Pavo, pechuga, sin piel, a la plancha (990)
(527, 990, 'Filete', 125),
-- Jamón cocido, categoría s/e (965)
(528, 965, 'Loncha', 20),
-- Jamón asado (2271)
(529, 2271, 'Loncha', 20),
-- Jamón cocido, enlatado (2272)
(530, 2272, 'Loncha', 20),
-- Jamón serrano (2273)
(531, 2273, 'Loncha', 15),
-- Jamón ibérico de cebo (1777)
(532, 1777, 'Loncha', 15),
-- Jamón ibérico de bellota (1781)
(533, 1781, 'Loncha', 15),
-- Pavo, fiambre (2286)
(534, 2286, 'Loncha', 15),
-- Pavo, fiambre, bajo en grasa (2287)
(535, 2287, 'Loncha', 15),
-- Pollo, fiambre (2293)
(536, 2293, 'Loncha', 15),
-- Pollo, fiambre, bajo en grasa (2294)
(537, 2294, 'Loncha', 15),
-- Mortadela (2282)
(538, 2282, 'Loncha', 20),
-- Lomo embuchado (2277)
(539, 2277, 'Loncha', 8),
-- Chorizo (2264)
(540, 2264, 'Loncha', 6),
-- Salchichón (2310)
(541, 2310, 'Loncha', 6),
-- Salami (2303)
(542, 2303, 'Loncha', 6),
-- Bacón, ahumado, a la parrilla (680)
(543, 680, 'Loncha', 12),
-- Bacon, crudo, con grasa separable (682)
(544, 682, 'Loncha', 12),
-- Atún en aceite de oliva isabel (2130)
(545, 2130, 'Lata pequeña (escurrida)', 56),
-- Atun en aceite vegetal (2131)
(546, 2131, 'Lata pequeña (escurrida)', 56),
-- Atún en escabeche (2132)
(547, 2132, 'Lata pequeña (escurrida)', 56),
-- Atún, al natural (2133)
(548, 2133, 'Lata pequeña (escurrida)', 56),
-- Bonito del norte, enlatado en aceite de soja (801)
(549, 801, 'Lata pequeña (escurrida)', 56),
-- Bonito, enlatado en aceite, escurrido (802)
(550, 802, 'Lata pequeña (escurrida)', 56),
-- Bonito en aceite vegetal (2314)
(551, 2314, 'Lata pequeña (escurrida)', 56),
-- Sardina, enlatada, en aceite, escurrida (2632)
(552, 2632, 'Lata pequeña (escurrida)', 85),
-- Sardina, enlatada, en escabeche (2633)
(553, 2633, 'Lata pequeña (escurrida)', 85),
-- Caballa, enlatada en aceite, escurrida (805)
(554, 805, 'Lata pequeña (escurrida)', 85),
-- Anchoas en aceite vegetal (2129)
(555, 2129, 'Filete de anchoa', 4),
-- Surimi (2562)
(556, 2562, 'Palito', 15),
-- Croquetas de pollo (2268)
(557, 2268, 'Unidad (croqueta)', 30),
-- ------------------------------------------------------------------------------
-- 9. AGUA, ZUMOS, REFRESCOS, CAFE Y CALDOS (Subcat 32 y 33)
--   Mililitro = densidad (g/ml). Vaso 200 ml y taza 250 ml (tablas UBA); lata 330 ml; cafe 50 ml.
-- ------------------------------------------------------------------------------
-- Agua de la red (2425)
(558, 2425, 'Vaso (200 ml)', 200),
(559, 2425, 'Taza (250 ml)', 250),
(560, 2425, 'Cucharada sopera', 15),
(561, 2425, 'Mililitro (ml)', 1),
-- Agua mineral, mineralización debil (2426)
(562, 2426, 'Vaso (200 ml)', 200),
(563, 2426, 'Taza (250 ml)', 250),
(564, 2426, 'Cucharada sopera', 15),
(565, 2426, 'Mililitro (ml)', 1),
-- Agua, con gas, embotellada (1015)
(566, 1015, 'Vaso (200 ml)', 200),
(567, 1015, 'Taza (250 ml)', 250),
(568, 1015, 'Cucharada sopera', 15),
(569, 1015, 'Mililitro (ml)', 1),
-- Soda (1110)
(570, 1110, 'Vaso (200 ml)', 200),
(571, 1110, 'Taza (250 ml)', 250),
(572, 1110, 'Cucharada sopera', 15),
(573, 1110, 'Mililitro (ml)', 1),
-- Refresco "tipo gaseosa" (2450)
(574, 2450, 'Vaso (200 ml)', 200),
(575, 2450, 'Taza (250 ml)', 250),
(576, 2450, 'Cucharada sopera', 15),
(577, 2450, 'Mililitro (ml)', 1),
-- Zumo de limón, fresco (937)
(578, 937, 'Cucharada sopera', 15.45),
(579, 937, 'Cucharadita', 5.15),
(580, 937, 'Vaso (200 ml)', 206),
(581, 937, 'Mililitro (ml)', 1.03),
(582, 937, 'Zumo de 1 limón', 40),
-- Zumo de lima, envasado (1089)
(583, 1089, 'Cucharada sopera', 15.45),
(584, 1089, 'Cucharadita', 5.15),
(585, 1089, 'Vaso (200 ml)', 206),
(586, 1089, 'Mililitro (ml)', 1.03),
-- Zumo de naranja (2468)
(587, 2468, 'Vaso (200 ml)', 209),
(588, 2468, 'Taza (250 ml)', 261.25),
(589, 2468, 'Mililitro (ml)', 1.045),
-- Zumo de manzana (2467)
(590, 2467, 'Vaso (200 ml)', 210),
(591, 2467, 'Taza (250 ml)', 262.5),
(592, 2467, 'Mililitro (ml)', 1.05),
-- Zumo de piña (2469)
(593, 2469, 'Vaso (200 ml)', 210),
(594, 2469, 'Taza (250 ml)', 262.5),
(595, 2469, 'Mililitro (ml)', 1.05),
-- Zumo de piña y uva (1068)
(596, 1068, 'Vaso (200 ml)', 210),
(597, 1068, 'Taza (250 ml)', 262.5),
(598, 1068, 'Mililitro (ml)', 1.05),
-- Zumo de uva (2365)
(599, 2365, 'Vaso (200 ml)', 212),
(600, 2365, 'Taza (250 ml)', 265),
(601, 2365, 'Mililitro (ml)', 1.06),
-- Zumo de uva y melocotón (791)
(602, 791, 'Vaso (200 ml)', 210),
(603, 791, 'Taza (250 ml)', 262.5),
(604, 791, 'Mililitro (ml)', 1.05),
-- Zumo de tomate, fresco (2248)
(605, 2248, 'Vaso (200 ml)', 206),
(606, 2248, 'Taza (250 ml)', 257.5),
(607, 2248, 'Mililitro (ml)', 1.03),
-- Zumo de zanahoria, fresco (2252)
(608, 2252, 'Vaso (200 ml)', 208),
(609, 2252, 'Taza (250 ml)', 260),
(610, 2252, 'Mililitro (ml)', 1.04),
-- Zumo de pomelo, envasado (1079)
(611, 1079, 'Vaso (200 ml)', 208),
(612, 1079, 'Taza (250 ml)', 260),
(613, 1079, 'Mililitro (ml)', 1.04),
-- Zumo de mango (1081)
(614, 1081, 'Vaso (200 ml)', 210),
(615, 1081, 'Taza (250 ml)', 262.5),
(616, 1081, 'Mililitro (ml)', 1.05),
-- Zumo de grosella roja (1090)
(617, 1090, 'Vaso (200 ml)', 210),
(618, 1090, 'Taza (250 ml)', 262.5),
(619, 1090, 'Mililitro (ml)', 1.05),
-- Zumo de grosella negra (1091)
(620, 1091, 'Vaso (200 ml)', 210),
(621, 1091, 'Taza (250 ml)', 262.5),
(622, 1091, 'Mililitro (ml)', 1.05),
-- Néctar de ciruela (1027)
(623, 1027, 'Vaso (200 ml)', 210),
(624, 1027, 'Taza (250 ml)', 262.5),
(625, 1027, 'Mililitro (ml)', 1.05),
-- Néctar de frutas exóticas, envasado (1057)
(626, 1057, 'Vaso (200 ml)', 210),
(627, 1057, 'Taza (250 ml)', 262.5),
(628, 1057, 'Mililitro (ml)', 1.05),
-- Néctar de mango, envasado (1061)
(629, 1061, 'Vaso (200 ml)', 210),
(630, 1061, 'Taza (250 ml)', 262.5),
(631, 1061, 'Mililitro (ml)', 1.05),
-- Néctar de pomelo (1099)
(632, 1099, 'Vaso (200 ml)', 210),
(633, 1099, 'Taza (250 ml)', 262.5),
(634, 1099, 'Mililitro (ml)', 1.05),
-- Néctar de piña (1100)
(635, 1100, 'Vaso (200 ml)', 210),
(636, 1100, 'Taza (250 ml)', 262.5),
(637, 1100, 'Mililitro (ml)', 1.05),
-- Néctar de pera, envasado (1101)
(638, 1101, 'Vaso (200 ml)', 210),
(639, 1101, 'Taza (250 ml)', 262.5),
(640, 1101, 'Mililitro (ml)', 1.05),
-- Néctar de naranja, envasado (1103)
(641, 1103, 'Vaso (200 ml)', 210),
(642, 1103, 'Taza (250 ml)', 262.5),
(643, 1103, 'Mililitro (ml)', 1.05),
-- Néctar de melocotón (1104)
(644, 1104, 'Vaso (200 ml)', 210),
(645, 1104, 'Taza (250 ml)', 262.5),
(646, 1104, 'Mililitro (ml)', 1.05),
-- Néctar de maracuyá, envasado (1105)
(647, 1105, 'Vaso (200 ml)', 210),
(648, 1105, 'Taza (250 ml)', 262.5),
(649, 1105, 'Mililitro (ml)', 1.05),
-- Néctar de albaricoque, envasado (1106)
(650, 1106, 'Vaso (200 ml)', 210),
(651, 1106, 'Taza (250 ml)', 262.5),
(652, 1106, 'Mililitro (ml)', 1.05),
-- Limonada (2449)
(653, 2449, 'Vaso (200 ml)', 208),
(654, 2449, 'Taza (250 ml)', 260),
(655, 2449, 'Mililitro (ml)', 1.04),
-- Horchata (2442)
(656, 2442, 'Vaso (200 ml)', 206),
(657, 2442, 'Taza (250 ml)', 257.5),
(658, 2442, 'Mililitro (ml)', 1.03),
-- Refresco, sabor naranja, sin gas (1097)
(659, 1097, 'Vaso (200 ml)', 208),
(660, 1097, 'Lata (330 ml)', 343.2),
(661, 1097, 'Mililitro (ml)', 1.04),
-- Refresco, sabor limón, con gas (1098)
(662, 1098, 'Vaso (200 ml)', 208),
(663, 1098, 'Lata (330 ml)', 343.2),
(664, 1098, 'Mililitro (ml)', 1.04),
-- Refresco con gas, sabor cola, sin cafeina (2451)
(665, 2451, 'Vaso (200 ml)', 208),
(666, 2451, 'Lata (330 ml)', 343.2),
(667, 2451, 'Mililitro (ml)', 1.04),
-- Refresco con gas, sabor cola, sin cafeina, bajo en calorías (2452)
(668, 2452, 'Vaso (200 ml)', 208),
(669, 2452, 'Lata (330 ml)', 343.2),
(670, 2452, 'Mililitro (ml)', 1.04),
-- Refresco de té (2453)
(671, 2453, 'Vaso (200 ml)', 206),
(672, 2453, 'Lata (330 ml)', 339.9),
(673, 2453, 'Mililitro (ml)', 1.03),
-- Refresco de té, bajo en calorías (2454)
(674, 2454, 'Vaso (200 ml)', 206),
(675, 2454, 'Lata (330 ml)', 339.9),
(676, 2454, 'Mililitro (ml)', 1.03),
-- Refresco tipo "tónica" (2455)
(677, 2455, 'Vaso (200 ml)', 206),
(678, 2455, 'Lata (330 ml)', 339.9),
(679, 2455, 'Mililitro (ml)', 1.03),
-- Refresco, con gas, sabor naranja (2456)
(680, 2456, 'Vaso (200 ml)', 208),
(681, 2456, 'Lata (330 ml)', 343.2),
(682, 2456, 'Mililitro (ml)', 1.04),
-- Refresco, sabor cola (2457)
(683, 2457, 'Vaso (200 ml)', 208),
(684, 2457, 'Lata (330 ml)', 343.2),
(685, 2457, 'Mililitro (ml)', 1.04),
-- Refresco, sabor cola, bajo en calorías (2458)
(686, 2458, 'Vaso (200 ml)', 208),
(687, 2458, 'Lata (330 ml)', 343.2),
(688, 2458, 'Mililitro (ml)', 1.04),
-- Bebida energética (2429)
(689, 2429, 'Vaso (200 ml)', 210),
(690, 2429, 'Mililitro (ml)', 1.05),
(691, 2429, 'Lata (250 ml)', 262.5),
-- Bebida isotónica (2430)
(692, 2430, 'Vaso (200 ml)', 204),
(693, 2430, 'Mililitro (ml)', 1.02),
-- Café, infusión (2433)
(694, 2433, 'Taza de café (50 ml)', 50),
(695, 2433, 'Taza (250 ml)', 250),
(696, 2433, 'Mililitro (ml)', 1),
-- Café, infusión, descafeinado (2434)
(697, 2434, 'Taza de café (50 ml)', 50),
(698, 2434, 'Taza (250 ml)', 250),
(699, 2434, 'Mililitro (ml)', 1),
-- Infusión (2443)
(700, 2443, 'Taza (250 ml)', 250),
(701, 2443, 'Vaso (200 ml)', 200),
(702, 2443, 'Mililitro (ml)', 1),
-- Caldo vegetal (792)
(703, 792, 'Vaso (200 ml)', 200),
(704, 792, 'Taza (250 ml)', 250),
(705, 792, 'Mililitro (ml)', 1),
-- Gazpacho (2614)
(706, 2614, 'Vaso (200 ml)', 206),
(707, 2614, 'Taza (250 ml)', 257.5),
(708, 2614, 'Mililitro (ml)', 1.03),
-- Café, en polvo, soluble (2432)
(709, 2432, 'Cucharadita', 2),
-- Café, sucedáneo, soluble (2435)
(710, 2435, 'Cucharadita', 2),
-- Café, en polvo, sin reconstituir (1109)
(711, 1109, 'Cucharadita', 2),
-- Suplemento proteico (2563)
(712, 2563, 'Cacito (scoop)', 30),
-- ------------------------------------------------------------------------------
-- 10. BEBIDAS ALCOHOLICAS (Subcat 34)
--   Caña 200 ml, copa de vino 100 ml y chupito 25 ml = unidades de bebida estandar (UBE) sanitarias.
-- ------------------------------------------------------------------------------
-- Cerveza con alcohol (2437)
(713, 2437, 'Caña (200 ml)', 200),
(714, 2437, 'Tercio (330 ml)', 330),
(715, 2437, 'Mililitro (ml)', 1),
-- Cerveza, baja en alcohol (2439)
(716, 2439, 'Caña (200 ml)', 200),
(717, 2439, 'Tercio (330 ml)', 330),
(718, 2439, 'Mililitro (ml)', 1),
-- Cerveza sin alcohol (2438)
(719, 2438, 'Caña (200 ml)', 200),
(720, 2438, 'Tercio (330 ml)', 330),
(721, 2438, 'Mililitro (ml)', 1),
-- Cerveza, oscura, 8°- 9° (1108)
(722, 1108, 'Caña (200 ml)', 200),
(723, 1108, 'Tercio (330 ml)', 330),
(724, 1108, 'Mililitro (ml)', 1),
-- Vino blanco (2462)
(725, 2462, 'Copa (100 ml)', 99),
(726, 2462, 'Vaso (200 ml)', 198),
(727, 2462, 'Chorro (30 ml)', 29.7),
(728, 2462, 'Mililitro (ml)', 0.99),
-- Vino rosado (2464)
(729, 2464, 'Copa (100 ml)', 99),
(730, 2464, 'Vaso (200 ml)', 198),
(731, 2464, 'Chorro (30 ml)', 29.7),
(732, 2464, 'Mililitro (ml)', 0.99),
-- Vino tinto (2465)
(733, 2465, 'Copa (100 ml)', 99),
(734, 2465, 'Vaso (200 ml)', 198),
(735, 2465, 'Chorro (30 ml)', 29.7),
(736, 2465, 'Mililitro (ml)', 0.99),
-- Vino dulce, tipo oporto (2463)
(737, 2463, 'Copa (100 ml)', 99),
(738, 2463, 'Vaso (200 ml)', 198),
(739, 2463, 'Chorro (30 ml)', 29.7),
(740, 2463, 'Mililitro (ml)', 0.99),
-- Cava (2436)
(741, 2436, 'Copa (100 ml)', 99),
(742, 2436, 'Vaso (200 ml)', 198),
(743, 2436, 'Chorro (30 ml)', 29.7),
(744, 2436, 'Mililitro (ml)', 0.99),
-- Vermut, s/e (1095)
(745, 1095, 'Copa (100 ml)', 99),
(746, 1095, 'Vaso (200 ml)', 198),
(747, 1095, 'Chorro (30 ml)', 29.7),
(748, 1095, 'Mililitro (ml)', 0.99),
-- Sidra (2460)
(749, 2460, 'Vaso (200 ml)', 200),
(750, 2460, 'Mililitro (ml)', 1),
-- Sangría (2459)
(751, 2459, 'Vaso (200 ml)', 200),
(752, 2459, 'Mililitro (ml)', 1),
-- Cubata (2440)
(753, 2440, 'Vaso (200 ml)', 200),
(754, 2440, 'Mililitro (ml)', 1),
-- Vodka (1092)
(755, 1092, 'Chupito (25 ml)', 23.75),
(756, 1092, 'Chorrito (10 ml)', 9.5),
(757, 1092, 'Mililitro (ml)', 0.95),
-- Ron (1096)
(758, 1096, 'Chupito (25 ml)', 23.75),
(759, 1096, 'Chorrito (10 ml)', 9.5),
(760, 1096, 'Mililitro (ml)', 0.95),
-- Coñac (1107)
(761, 1107, 'Chupito (25 ml)', 23.75),
(762, 1107, 'Chorrito (10 ml)', 9.5),
(763, 1107, 'Mililitro (ml)', 0.95),
-- Ginebra (2441)
(764, 2441, 'Chupito (25 ml)', 23.75),
(765, 2441, 'Chorrito (10 ml)', 9.5),
(766, 2441, 'Mililitro (ml)', 0.95),
-- Whisky (2466)
(767, 2466, 'Chupito (25 ml)', 23.75),
(768, 2466, 'Chorrito (10 ml)', 9.5),
(769, 2466, 'Mililitro (ml)', 0.95),
-- Tequila (2461)
(770, 2461, 'Chupito (25 ml)', 23.75),
(771, 2461, 'Chorrito (10 ml)', 9.5),
(772, 2461, 'Mililitro (ml)', 0.95),
-- Anís, seco (1022)
(773, 1022, 'Chupito (25 ml)', 23.75),
(774, 1022, 'Chorrito (10 ml)', 9.5),
(775, 1022, 'Mililitro (ml)', 0.95),
-- Aguardiente (2427)
(776, 2427, 'Chupito (25 ml)', 23.75),
(777, 2427, 'Chorrito (10 ml)', 9.5),
(778, 2427, 'Mililitro (ml)', 0.95),
-- Licor de crema 15-17% vol. (2428)
(779, 2428, 'Chupito (25 ml)', 27.5),
(780, 2428, 'Mililitro (ml)', 1.1),
-- Licor apricot (2444)
(781, 2444, 'Chupito (25 ml)', 27.5),
(782, 2444, 'Mililitro (ml)', 1.1),
-- Licor benedictine (2445)
(783, 2445, 'Chupito (25 ml)', 27.5),
(784, 2445, 'Mililitro (ml)', 1.1),
-- Licor curaçao (2446)
(785, 2446, 'Chupito (25 ml)', 27.5),
(786, 2446, 'Mililitro (ml)', 1.1),
-- Licor de café (2447)
(787, 2447, 'Chupito (25 ml)', 27.5),
(788, 2447, 'Mililitro (ml)', 1.1),
-- Licores de frutas (2448)
(789, 2448, 'Chupito (25 ml)', 27.5),
(790, 2448, 'Mililitro (ml)', 1.1);

SELECT setval(pg_get_serial_sequence('medicion_alternativa', 'id'), (SELECT MAX(id) FROM medicion_alternativa));
