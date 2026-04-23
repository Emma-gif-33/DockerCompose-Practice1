import { pool } from "@/lib/db";
import { PaginationSchema } from "@/lib/validations";

export const dynamic = "force-dynamic";

export async function ClientsReport({searchParams}: { searchParams: any }) {
    const params = searchParams || {};
    const { page, limit } = PaginationSchema.parse(params);
    const offset = (page - 1) * limit;

    const query = `
        SELECT customer_name, customer_email, num_ordenes, total_gastado, gasto_promedio
        FROM vw_customer_value
        ORDER BY total_gastado DESC
        LIMIT $1 OFFSET $2
    `;

    const result = await pool.query(query, [limit, offset]);
    const clients = result.rows;

    const topClient = clients[0]?.customer_name || "N/A";
    const topAmount = clients[0]?.total_gastado || 0;

    return {
        clients,
        topClient,
        topAmount,
        page,
        limit
    };
}