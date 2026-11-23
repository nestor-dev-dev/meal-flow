-- CreateEnum
CREATE TYPE "Sexo" AS ENUM ('HOMBRE', 'MUJER', 'OTRO');

-- CreateEnum
CREATE TYPE "NivelActividad" AS ENUM ('SEDENTARIO', 'LIGERO', 'MODERADO', 'ACTIVO', 'MUY_ACTIVO');

-- CreateEnum
CREATE TYPE "FrecuenciaCompra" AS ENUM ('SEMANAL', 'QUINCENAL', 'MENSUAL');

-- CreateEnum
CREATE TYPE "ObjetivoCalorico" AS ENUM ('PERDER_PESO', 'MANTENER', 'GANAR_MASA');

-- CreateEnum
CREATE TYPE "Dieta" AS ENUM ('OMNIVORA', 'VEGETARIANA', 'VEGANA', 'KETO', 'ALTA_PROTEINA');

-- CreateEnum
CREATE TYPE "UtensilioCocina" AS ENUM ('SARTEN', 'OLLA', 'OLLA_EXPRES', 'HORNO', 'MICROONDAS', 'AIRFRYER', 'BATIDORA', 'ROBOT_COCINA', 'TOSTADORA');

-- CreateEnum
CREATE TYPE "TipoComida" AS ENUM ('DESAYUNO', 'COMIDA', 'CENA');

-- CreateEnum
CREATE TYPE "Dificultad" AS ENUM ('FACIL', 'MEDIA', 'DIFICIL');

-- CreateEnum
CREATE TYPE "TipoPlato" AS ENUM ('PLATO_PRINCIPAL', 'PLATO_LIGERO', 'POSTRE');

-- CreateTable
CREATE TABLE "food_categories" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "examples" TEXT,

    CONSTRAINT "food_categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "food_subcategories" (
    "id" SERIAL NOT NULL,
    "category_id" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "examples" TEXT,

    CONSTRAINT "food_subcategories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ingredients" (
    "id" INTEGER NOT NULL,
    "name" VARCHAR(200) NOT NULL,
    "nutriscore_aprox" CHAR(1) NOT NULL,
    "energy_kcal" DECIMAL(7,2),
    "protein_g" DECIMAL(7,4),
    "fat_g" DECIMAL(7,4),
    "carbs_g" DECIMAL(7,4),
    "fiber_g" DECIMAL(7,4),
    "saturated_fat_g" DECIMAL(7,4),
    "sugar_g" DECIMAL(7,4),
    "sodium_mg" DECIMAL(9,4),
    "vitamin_c_mg" DECIMAL(8,4),
    "calcium_mg" DECIMAL(8,4),
    "iron_mg" DECIMAL(7,4),
    "potassium_mg" DECIMAL(8,4),
    "subcategory_id" INTEGER NOT NULL,

    CONSTRAINT "ingredients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ingrediente_subcategoria_secundaria" (
    "ingredient_id" INTEGER NOT NULL,
    "subcategory_id" INTEGER NOT NULL,

    CONSTRAINT "ingrediente_subcategoria_secundaria_pkey" PRIMARY KEY ("subcategory_id","ingredient_id")
);

-- CreateTable
CREATE TABLE "medicion_alternativa" (
    "id" SERIAL NOT NULL,
    "ingredient_id" INTEGER NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "gramos" DECIMAL(8,3) NOT NULL,

    CONSTRAINT "medicion_alternativa_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "usuario" (
    "id" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "usuario" VARCHAR(50) NOT NULL,
    "correo" VARCHAR(150) NOT NULL,
    "contrasena_hash" TEXT,
    "google_id" TEXT,
    "es_admin" BOOLEAN NOT NULL DEFAULT false,
    "foto_perfil" TEXT,
    "foto_apaisada" TEXT,
    "peso" DECIMAL(5,2),
    "fecha_nacimiento" DATE,
    "sexo" "Sexo",
    "altura" INTEGER,
    "nivel_actividad" "NivelActividad",
    "tiempo_max_cocina" INTEGER,
    "interes_en_aprender" BOOLEAN NOT NULL DEFAULT false,
    "frec_compra" "FrecuenciaCompra",
    "objetivo_calorico" "ObjetivoCalorico",
    "ritmo_varianza_peso" DECIMAL(4,2),
    "dieta" "Dieta"[] DEFAULT ARRAY[]::"Dieta"[],
    "utensilios_cocina" "UtensilioCocina"[] DEFAULT ARRAY[]::"UtensilioCocina"[],
    "horario_semanal" JSONB,
    "num_seguidores" INTEGER NOT NULL DEFAULT 0,
    "num_seguidos" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "usuario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sigue" (
    "seguidor_id" INTEGER NOT NULL,
    "seguido_id" INTEGER NOT NULL,

    CONSTRAINT "sigue_pkey" PRIMARY KEY ("seguidor_id","seguido_id")
);

-- CreateTable
CREATE TABLE "receta" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER,
    "puntuacion_salud" INTEGER NOT NULL,
    "calorias" DECIMAL(7,2) NOT NULL,
    "foto" TEXT,
    "nombre" VARCHAR(150) NOT NULL,
    "video_url" TEXT,
    "pasos" JSONB NOT NULL DEFAULT '[]',
    "descripcion" TEXT,
    "tiempos" INTEGER[] DEFAULT ARRAY[]::INTEGER[],
    "tiempos_dobles" INTEGER[] DEFAULT ARRAY[]::INTEGER[],
    "tiempo_medio" INTEGER NOT NULL,
    "tiempo_doble_medio" INTEGER NOT NULL,
    "dificultad" "Dificultad" NOT NULL,
    "raciones" INTEGER NOT NULL,
    "max_nevera" INTEGER NOT NULL,
    "es_congelable" BOOLEAN NOT NULL DEFAULT false,
    "tipo_comida" "TipoComida"[] DEFAULT ARRAY[]::"TipoComida"[],
    "utensilios_cocina" "UtensilioCocina"[] DEFAULT ARRAY[]::"UtensilioCocina"[],
    "proteinas" DECIMAL(7,2) NOT NULL,
    "carbohidratos" DECIMAL(7,2) NOT NULL,
    "grasas" DECIMAL(7,2) NOT NULL,
    "nota_media" DECIMAL(3,2),
    "fecha_baja" TIMESTAMPTZ(3),
    "tipo_plato" "TipoPlato" NOT NULL,

    CONSTRAINT "receta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta_ingrediente" (
    "receta_id" INTEGER NOT NULL,
    "ingrediente_id" INTEGER NOT NULL,
    "cantidad" DECIMAL(8,2) NOT NULL,

    CONSTRAINT "receta_ingrediente_pkey" PRIMARY KEY ("receta_id","ingrediente_id")
);

-- CreateTable
CREATE TABLE "resena" (
    "receta_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "nota" SMALLINT NOT NULL,
    "descripcion" TEXT,
    "fecha" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "resena_pkey" PRIMARY KEY ("receta_id","user_id")
);

-- CreateTable
CREATE TABLE "le_gusta" (
    "user_id" INTEGER NOT NULL,
    "receta_id" INTEGER NOT NULL,

    CONSTRAINT "le_gusta_pkey" PRIMARY KEY ("user_id","receta_id")
);

-- CreateTable
CREATE TABLE "algoritmo_receta" (
    "user_id" INTEGER NOT NULL,
    "receta_id" INTEGER NOT NULL,
    "puntuacion" SMALLINT NOT NULL DEFAULT 60,
    "es_votado_tiempo" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "algoritmo_receta_pkey" PRIMARY KEY ("user_id","receta_id")
);

-- CreateTable
CREATE TABLE "algoritmo_ingrediente" (
    "user_id" INTEGER NOT NULL,
    "ingrediente_id" INTEGER NOT NULL,
    "puntuacion" SMALLINT NOT NULL DEFAULT 60,

    CONSTRAINT "algoritmo_ingrediente_pkey" PRIMARY KEY ("user_id","ingrediente_id")
);

-- CreateTable
CREATE TABLE "no_puede_tomar" (
    "user_id" INTEGER NOT NULL,
    "ingrediente_id" INTEGER NOT NULL,

    CONSTRAINT "no_puede_tomar_pkey" PRIMARY KEY ("user_id","ingrediente_id")
);

-- CreateTable
CREATE TABLE "menu" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "fecha_ini" DATE NOT NULL,
    "fecha_fin" DATE NOT NULL,
    "lista_compra" JSONB,

    CONSTRAINT "menu_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "casilla_menu" (
    "menu_id" INTEGER NOT NULL,
    "fecha" DATE NOT NULL,
    "tipo_comida" "TipoComida" NOT NULL,
    "tipo_plato" "TipoPlato" NOT NULL,
    "num_pers" INTEGER NOT NULL,
    "puede_cocinar" BOOLEAN NOT NULL,
    "es_tupper" BOOLEAN NOT NULL DEFAULT false,
    "receta_id" INTEGER,

    CONSTRAINT "casilla_menu_pkey" PRIMARY KEY ("menu_id","fecha","tipo_comida","tipo_plato")
);

-- CreateIndex
CREATE UNIQUE INDEX "food_categories_name_key" ON "food_categories"("name");

-- CreateIndex
CREATE UNIQUE INDEX "ingredients_name_key" ON "ingredients"("name");

-- CreateIndex
CREATE UNIQUE INDEX "medicion_alternativa_ingredient_id_nombre_key" ON "medicion_alternativa"("ingredient_id", "nombre");

-- CreateIndex
CREATE UNIQUE INDEX "usuario_usuario_key" ON "usuario"("usuario");

-- CreateIndex
CREATE UNIQUE INDEX "usuario_correo_key" ON "usuario"("correo");

-- CreateIndex
CREATE UNIQUE INDEX "usuario_google_id_key" ON "usuario"("google_id");

-- CreateIndex
CREATE INDEX "sigue_seguido_id_idx" ON "sigue"("seguido_id");

-- CreateIndex
CREATE INDEX "receta_user_id_idx" ON "receta"("user_id");

-- CreateIndex
CREATE INDEX "receta_puntuacion_salud_idx" ON "receta"("puntuacion_salud");

-- CreateIndex
CREATE INDEX "receta_calorias_idx" ON "receta"("calorias");

-- CreateIndex
CREATE INDEX "receta_tiempo_medio_idx" ON "receta"("tiempo_medio");

-- CreateIndex
CREATE INDEX "receta_tiempo_doble_medio_idx" ON "receta"("tiempo_doble_medio");

-- CreateIndex
CREATE INDEX "receta_nota_media_idx" ON "receta"("nota_media");

-- CreateIndex
CREATE INDEX "receta_tipo_plato_idx" ON "receta"("tipo_plato");

-- CreateIndex
CREATE UNIQUE INDEX "menu_user_id_fecha_ini_key" ON "menu"("user_id", "fecha_ini");

-- AddForeignKey
ALTER TABLE "food_subcategories" ADD CONSTRAINT "food_subcategories_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "food_categories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ingredients" ADD CONSTRAINT "ingredients_subcategory_id_fkey" FOREIGN KEY ("subcategory_id") REFERENCES "food_subcategories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ingrediente_subcategoria_secundaria" ADD CONSTRAINT "ingrediente_subcategoria_secundaria_ingredient_id_fkey" FOREIGN KEY ("ingredient_id") REFERENCES "ingredients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ingrediente_subcategoria_secundaria" ADD CONSTRAINT "ingrediente_subcategoria_secundaria_subcategory_id_fkey" FOREIGN KEY ("subcategory_id") REFERENCES "food_subcategories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medicion_alternativa" ADD CONSTRAINT "medicion_alternativa_ingredient_id_fkey" FOREIGN KEY ("ingredient_id") REFERENCES "ingredients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sigue" ADD CONSTRAINT "sigue_seguidor_id_fkey" FOREIGN KEY ("seguidor_id") REFERENCES "usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sigue" ADD CONSTRAINT "sigue_seguido_id_fkey" FOREIGN KEY ("seguido_id") REFERENCES "usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta" ADD CONSTRAINT "receta_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "usuario"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta_ingrediente" ADD CONSTRAINT "receta_ingrediente_receta_id_fkey" FOREIGN KEY ("receta_id") REFERENCES "receta"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta_ingrediente" ADD CONSTRAINT "receta_ingrediente_ingrediente_id_fkey" FOREIGN KEY ("ingrediente_id") REFERENCES "ingredients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "resena" ADD CONSTRAINT "resena_receta_id_fkey" FOREIGN KEY ("receta_id") REFERENCES "receta"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "resena" ADD CONSTRAINT "resena_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "le_gusta" ADD CONSTRAINT "le_gusta_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "le_gusta" ADD CONSTRAINT "le_gusta_receta_id_fkey" FOREIGN KEY ("receta_id") REFERENCES "receta"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "algoritmo_receta" ADD CONSTRAINT "algoritmo_receta_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "algoritmo_receta" ADD CONSTRAINT "algoritmo_receta_receta_id_fkey" FOREIGN KEY ("receta_id") REFERENCES "receta"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "algoritmo_ingrediente" ADD CONSTRAINT "algoritmo_ingrediente_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "algoritmo_ingrediente" ADD CONSTRAINT "algoritmo_ingrediente_ingrediente_id_fkey" FOREIGN KEY ("ingrediente_id") REFERENCES "ingredients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "no_puede_tomar" ADD CONSTRAINT "no_puede_tomar_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "no_puede_tomar" ADD CONSTRAINT "no_puede_tomar_ingrediente_id_fkey" FOREIGN KEY ("ingrediente_id") REFERENCES "ingredients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "menu" ADD CONSTRAINT "menu_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "usuario"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "casilla_menu" ADD CONSTRAINT "casilla_menu_menu_id_fkey" FOREIGN KEY ("menu_id") REFERENCES "menu"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "casilla_menu" ADD CONSTRAINT "casilla_menu_receta_id_fkey" FOREIGN KEY ("receta_id") REFERENCES "receta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
