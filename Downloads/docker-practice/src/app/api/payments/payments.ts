import { pool } from "@/lib/db";

export const dynamic = "force-dynamic";

export async function PaymentsReport() {
    const query = `
        SELECT payment_method, total_amount, percentage
        FROM vw_payment_mix
        ORDER BY percentage DESC
    `;

    const result = await pool.query(query);
    const payments = result.rows;

    const favoriteMethod = payments[0]?.payment_method || "N/A";

    return {
        result,
        payments,
    favoriteMethod
    }
}