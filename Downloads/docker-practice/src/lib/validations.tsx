import { z } from 'zod';

//(Clientes y Productos frecuentes)
export const PaginationSchema = z.object({
    page: z.string().optional().transform((val) => Math.max(Number(val) || 1, 1)),
    limit: z.string().optional().transform((val) => {
        const n = Number(val) || 5;
        return n > 0 && n <= 50 ? n : 5;
    }),
});

//(Ventas Diarias)
export const DateRangeSchema = z.object({
    date_from: z.string().optional().default('2026-01-01'),
    date_to: z.string().optional().default('2026-12-31'),
});

//(Productos frecuentes)
export const ProductSearchSchema = z.object({
    search: z.string().optional().default(''),
    page: z.string().optional().transform((val) => Math.max(Number(val) || 1, 1)),
    limit: z.string().optional().transform((val) => {
        const n = Number(val) || 5;
        return n > 0 && n <= 50 ? n : 5;
    }),
});

//(Muestra de los productos en el stock) FALTA LA PAGINACIÓN QnQ
export const InventoryFilterSchema = z.object({
    category: z.string().optional().default('all').transform((val) => {
        return (val === 'all' || !isNaN(Number(val))) ? val : 'all';
    }),
});