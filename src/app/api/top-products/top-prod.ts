import { pool } from "@/lib/db";
import { ProductSearchSchema } from "@/lib/validations";

export const dynamic = "force-dynamic";

export async function TopProductsReport({searchParams}: { searchParams: any }) {
    const params = searchParams || {};
    const { search, page, limit } = ProductSearchSchema.parse(params);
    const offset = (page - 1) * limit;

    const query = `
        SELECT ranking_revenue, product_name, category_name, total_units, total_revenue
        FROM vw_top_products_ranked
        WHERE product_name ILIKE $1
        ORDER BY ranking_revenue ASC
        LIMIT $2 OFFSET $3
    `;

    const result = await pool.query(query, [`%${search}%`, limit, offset]);
    const products = result.rows;

    const bestSeller =
        products.find((p) => p.ranking_revenue == 1)?.product_name || "Sin datos";

    return {
        bestSeller,
        products,
        search,
        page,
        limit
    }
}