// cSpell:disable
import 'dotenv/config';
import * as fs from 'node:fs';
import * as path from 'node:path';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient, Prisma } from '../src/generated/prisma/client.js';

const databaseUrl = process.env.DATABASE_URL;
if (!databaseUrl) {
    throw new Error('Falta DATABASE_URL en el archivo .env');
}

const prisma = new PrismaClient({
    adapter: new PrismaPg({ connectionString: databaseUrl }),
});

const SEEDS_DIR = path.resolve(process.cwd(), 'prisma', 'seeds');

const CATALOG_FILES = [
    'food_categories.sql',
    'food_subcategories.sql',
    'seed_ingredientes.sql',
    'ingrediente_subcategoria_secundaria.sql',
    'medicion_alternativa.sql',
] as const;

const EXPECTED_ROWS: Record<string, number> = {
    food_categories: 10,
    food_subcategories: 35,
    ingredients: 957,
    ingrediente_subcategoria_secundaria: 500,
    medicion_alternativa: 790,
};

const DEPENDENT_USER_TABLES = [
    'receta_ingrediente',
    'algoritmo_ingrediente',
    'no_puede_tomar',
];

const TRUNCATE_SQL =
    'TRUNCATE TABLE ' +
    [...DEPENDENT_USER_TABLES, ...Object.keys(EXPECTED_ROWS)].join(', ') +
    ' RESTART IDENTITY';

function splitSqlStatements(sql: string): string[] {
    const statements: string[] = [];
    let current = '';
    let i = 0;
    const n = sql.length;

    const flush = () => {
        const stmt = current.trim();
        if (stmt.length > 0) statements.push(stmt);
        current = '';
    };

    while (i < n) {
        const ch = sql[i];
        const next = sql[i + 1];

        if (ch === '-' && next === '-') {
            while (i < n && sql[i] !== '\n') i++;
            continue;
        }
        if (ch === '/' && next === '*') {
            i += 2;
            while (i < n && !(sql[i] === '*' && sql[i + 1] === '/')) i++;
            i += 2;
            continue;
        }
        if (ch === "'" || ch === '"') {
            const quote = ch;
            current += ch;
            i++;
            while (i < n) {
                current += sql[i];
                if (sql[i] === quote) {
                    if (sql[i + 1] === quote) {
                        current += sql[i + 1];
                        i += 2;
                        continue;
                    }
                    i++;
                    break;
                }
                i++;
            }
            continue;
        }
        if (ch === ';') {
            flush();
            i++;
            continue;
        }
        current += ch;
        i++;
    }
    flush();
    return statements;
}

async function main() {
    console.log('🌱 Iniciando el volcado de semillas (BEDCA) en PostgreSQL...');

    const unionQuery = DEPENDENT_USER_TABLES.map(
        (t) => "SELECT '" + t + "' AS tabla, COUNT(*)::int AS n FROM " + t
    ).join(' UNION ALL ');

    const counts = await prisma.$queryRawUnsafe<{ tabla: string; n: number }[]>(
        unionQuery
    );

    const withData = counts.filter((c: { tabla: string; n: number }) => c.n > 0);
    if (withData.length > 0 && process.env.SEED_RESET !== '1') {
        const detalle = withData
            .map((c: { tabla: string; n: number }) => c.tabla + ' (' + c.n + ' filas)')
            .join(', ');
        throw new Error(
            'Hay datos que dependen del catálogo: ' +
            detalle +
            '. Ejecuta con SEED_RESET=1 si deseas borrarlos.'
        );
    }

    await prisma.$transaction(
        async (tx: Prisma.TransactionClient) => {
            await tx.$executeRawUnsafe(TRUNCATE_SQL);

            for (const file of CATALOG_FILES) {
                const filePath = path.join(SEEDS_DIR, file);
                const rawSql = fs.readFileSync(filePath, 'utf-8').replace(/^\uFEFF/, '');

                for (const statement of splitSqlStatements(rawSql)) {
                    if (/^CREATE\s+TABLE\b/i.test(statement)) continue;

                    if (/^SELECT\b/i.test(statement)) {
                        await tx.$queryRawUnsafe(statement);
                    } else {
                        await tx.$executeRawUnsafe(statement);
                    }
                }
                console.log('✅ Archivo ejecutado con éxito: ' + file);
            }

            for (const [table, expected] of Object.entries(EXPECTED_ROWS)) {
                const rows = await tx.$queryRawUnsafe<{ n: number }[]>(
                    'SELECT COUNT(*)::int AS n FROM ' + table
                );
                const actual = rows[0]?.n ?? 0;
                if (actual !== expected) {
                    throw new Error(
                        table + ': se esperaban ' + expected + ' filas y hay ' + actual + '.'
                    );
                }
            }
        },
        { timeout: 120_000, maxWait: 10_000 }
    );

    console.log('🚀 ¡Catálogo de alimentos cargado al 100%!');
}

main()
    .catch((e: unknown) => {
        console.error('❌ Error ejecutando el seed:', e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });