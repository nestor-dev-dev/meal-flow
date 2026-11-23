-- =============================================================================
--  mealFlow — Restricciones CHECK de integridad a nivel de PostgreSQL
-- =============================================================================
-- ---------- 1. Catálogo de alimentos (BEDCA) ---------------------------------
ALTER TABLE ingredients ADD CONSTRAINT ingredients_nutriscore_valid CHECK (nutriscore_aprox IN ('A', 'B', 'C', 'D', 'E')),
ADD CONSTRAINT ingredients_nutrients_not_negative CHECK (
    energy_kcal >= 0
    AND protein_g >= 0
    AND fat_g >= 0
    AND carbs_g >= 0
    AND fiber_g >= 0
    AND saturated_fat_g >= 0
    AND sugar_g >= 0
    AND sodium_mg >= 0
    AND vitamin_c_mg >= 0
    AND calcium_mg >= 0
    AND iron_mg >= 0
    AND potassium_mg >= 0
);

ALTER TABLE medicion_alternativa ADD CONSTRAINT medicion_alternativa_gramos_positive CHECK (gramos > 0);

-- ---------- 2. Usuario y Red Social ------------------------------------------
ALTER TABLE usuario ADD CONSTRAINT usuario_peso_positive CHECK (
    peso IS NULL
    OR peso > 0
),
ADD CONSTRAINT usuario_altura_sane CHECK (
    altura IS NULL
    OR altura BETWEEN 50 AND 260
),
ADD CONSTRAINT usuario_tiempo_max_cocina_sane CHECK (
    tiempo_max_cocina IS NULL
    OR tiempo_max_cocina BETWEEN 0 AND 1440
),
ADD CONSTRAINT usuario_contadores_not_negative CHECK (
    num_seguidores >= 0
    AND num_seguidos >= 0
);

ALTER TABLE sigue ADD CONSTRAINT sigue_no_self_follow CHECK (seguidor_id <> seguido_id);

-- ---------- 3. Recetas, Ingredientes y Reseñas -------------------------------
ALTER TABLE receta ADD CONSTRAINT receta_puntuacion_salud_range CHECK (puntuacion_salud BETWEEN 0 AND 100),
ADD CONSTRAINT receta_valores_not_negative CHECK (
    calorias >= 0
    AND proteinas >= 0
    AND carbohidratos >= 0
    AND grasas >= 0
),
ADD CONSTRAINT receta_raciones_positive CHECK (raciones > 0),
-- >= 0 para permitir fruta, yogures o precocinados sin tiempo de cocinado
ADD CONSTRAINT receta_tiempos_not_negative CHECK (
    tiempo_medio >= 0
    AND tiempo_doble_medio >= 0
),
ADD CONSTRAINT receta_max_nevera_not_negative CHECK (max_nevera >= 0),
ADD CONSTRAINT receta_tipo_comida_not_empty CHECK (cardinality(tipo_comida) >= 1),
ADD CONSTRAINT receta_nota_media_range CHECK (
    nota_media IS NULL
    OR nota_media BETWEEN 1 AND 5
);

ALTER TABLE receta_ingrediente ADD CONSTRAINT receta_ingrediente_cantidad_positive CHECK (cantidad > 0);

ALTER TABLE resena ADD CONSTRAINT resena_nota_range CHECK (nota BETWEEN 1 AND 5);

-- ---------- 4. Algoritmo de Recomendación ------------------------------------
ALTER TABLE algoritmo_receta ADD CONSTRAINT algoritmo_receta_puntuacion_range CHECK (puntuacion BETWEEN 0 AND 100);

ALTER TABLE algoritmo_ingrediente ADD CONSTRAINT algoritmo_ingrediente_puntuacion_range CHECK (puntuacion BETWEEN 5 AND 100);

-- ---------- 5. Menú y Casilla Menú -------------------------------------------
ALTER TABLE menu ADD CONSTRAINT menu_fechas_ordenadas CHECK (fecha_fin >= fecha_ini);

ALTER TABLE casilla_menu ADD CONSTRAINT casilla_menu_num_pers_not_negative CHECK (num_pers >= 0),
-- 0 comensales => sin receta asignada
ADD CONSTRAINT casilla_menu_sin_comensales_sin_receta CHECK (
    num_pers > 0
    OR receta_id IS NULL
),
-- Un tupper siempre debe apuntar a una receta
ADD CONSTRAINT casilla_menu_tupper_requiere_receta CHECK (
    NOT es_tupper
    OR receta_id IS NOT NULL
);