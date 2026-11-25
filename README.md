# mealFlow

![Estado](https://img.shields.io/badge/Estado-En%20desarrollo%20activo-orange?style=for-the-badge)
![NestJS](https://img.shields.io/badge/NestJS-12-E0234E?style=for-the-badge&logo=nestjs&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-ESM-3178C6?style=for-the-badge&logo=typescript&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Prisma](https://img.shields.io/badge/Prisma-7.10-2D3748?style=for-the-badge&logo=prisma&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)

> **Proyecto en desarrollo activo:** La capa de datos, el pipeline ETL nutricional y el despliegue local en Docker están completados y validados. La API REST modular en NestJS se encuentra actualmente en fase de diseño e implementación.

**mealFlow** es una plataforma de planificación nutricional, gestión de menús y descubrimiento de recetas. Genera planes semanales, quincenales o mensuales adaptados a los objetivos calóricos, tiempo disponible, utensilios de cocina y restricciones alimentarias de cada usuario, integrando control estricto de alérgenos y lista de la compra automatizada.

---

## Características principales

* **Control granular de alérgenos:** Taxonomía en dos niveles (categorías y subcategorías) combinada con una matriz secundaria de alérgenos ocultos y trazas en alimentos compuestos. Permite bloquear desde grupos completos hasta ingredientes individuales.
* **Base nutricional auditada (BEDCA):** Catálogo propio de **957 ingredientes** depurados, con cálculo algorítmico de Nutri-Score y **790 equivalencias de medidas domésticas** (cucharadas, vasos, unidades, ml) calculadas por densidad y porción neta comestible.
* **Planificador flexible y gestión de tuppers:** Soporte para horizontes semanales, quincenales y mensuales, múltiples platos por comida (`PLATO_PRINCIPAL`, `PLATO_LIGERO`, `POSTRE`), control de conservación en nevera (`max_nevera`) para reutilizar raciones y lista de la compra integrada en `JSONB`.
* **Motor de recomendación e interpolación de tiempos:** Sistema de afinidad continua por receta e ingrediente mediante filas perezosas (*sparse rows*), con interpolación lineal del tiempo de cocinado según el número de comensales y media recortada para filtrar votos atípicos.
* **Capa social y modo invitado:** Soporte dual para usuarios invitados (persistencia local con migración al registrarse) y cuentas registradas con autenticación tradicional y OAuth2, reseñas, favoritos y sistema de seguidores.

---

## Stack tecnológico

| Capa | Tecnologías |
| :--- | :--- |
| **Backend** | NestJS 12, TypeScript (ESM), Node.js |
| **Base de datos y ORM** | PostgreSQL 16, Prisma 7.10 (`@prisma/adapter-pg`, `pg`) |
| **Procesamiento de datos (ETL)** | Python, Pandas (limpieza y normalización de BEDCA) |
| **Infraestructura** | Docker, Docker Compose |
| **Arquitectura de API** | REST modular, JWT / OAuth2 *(en progreso)* |

---

## Decisiones técnicas destacadas

* **Optimización de claves primarias compuestas (B-Tree):** El orden de cada tupla `@@id` en las tablas `N:M` y entidades débiles sigue la regla del prefijo izquierdo (*leftmost prefix rule*) para resolver las consultas frecuentes directamente desde el índice de la clave primaria sin índices secundarios redundantes.
* **Integridad a nivel de motor:** Migraciones versionadas que combinan el DDL generado por Prisma con una migración dedicada de restricciones `CHECK` en PostgreSQL (rangos nutricionales, coherencia de fechas, control de tuppers y suelo mínimo algorítmico).
* **Tipos nativos de PostgreSQL:** Uso de `ENUM` nativos, arrays tipados (`UtensilioCocina[]`, `Dieta[]`) para filtros de conjuntos en una sola operación y `JSONB` para estructuras autocontenidas (`horario_semanal`, `lista_compra`, `pasos`).
* **Seeding transaccional seguro:** Script de volcado inicial (`prisma/seed.ts`) con parser SQL propio, ejecución atómica en una única transacción, protección contra borrado accidental de datos de usuario y validación de recuentos tras la carga.

---

## Roadmap

- [x] **Pipeline ETL y auditoría de datos:** Transformación del dataset BEDCA, cálculo de Nutri-Score, taxonomía principal/secundaria y tabla de mediciones alternativas.
- [x] **Modelado y codificación de BBDD:** Esquema relacional de 16 entidades en Prisma 7, optimización de índices B-Tree, migraciones y restricciones `CHECK`.
- [x] **Infraestructura local y seeding:** Entorno PostgreSQL 16 con Docker Compose y script de carga transaccional.
- [ ] **Arquitectura Backend (NestJS):** Módulos `Prisma`, `Auth`, `Ingredients`, `Users`, `Recipes`, `Social`, `Algorithm` y `Menus`. *(En curso)*
- [ ] **Motor de generación de menús:** Algoritmo de planificación, cálculo TDEE (Mifflin-St Jeor) y optimización de tuppers.
- [ ] **Frontend y modo invitado:** Interfaz web interactiva con capa de sincronización entre `localStorage` y la API REST.
- [ ] **Testing y despliegue:** Pruebas unitarias/E2E y puesta en producción.

---

## Puesta en marcha en local (Backend y BBDD)

### Prerrequisitos
* [Node.js](https://nodejs.org/) (v20+)
* [Docker](https://www.docker.com/) y Docker Compose

### Instalación y arranque

1. **Clonar el repositorio y entrar en el directorio del backend:**
   ```bash
   git clone [https://github.com/nestor-dev-dev/meal-flow.git](https://github.com/nestor-dev-dev/meal-flow.git)
   cd meal-flow/backend
   npm install
