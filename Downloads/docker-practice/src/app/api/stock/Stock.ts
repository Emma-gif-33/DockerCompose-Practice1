import { pool } from "@/lib/db";
import { InventoryFilterSchema } from "@/lib/validations";

export const dynamic = "force-dynamic";

export async function InventoryReport({searchParams}: { searchParams: { [key: string]: string | string | undefined };
}) {
    const params = searchParams || {};
    const { category } = InventoryFilterSchema.parse(params);

    let query = "SELECT * FROM vw_inventory_risk";
    let values: any[] = [];

    if (category !== "all") {
        query += " WHERE categoria_id = $1";
        values.push(category);
    }

    const result = await pool.query(query, values);
    const products = result.rows;

    const criticalCount = products.filter((p) =>
        p.risk_level.includes("CRÍTICO"),
    ).length;

    return {
    products,
        criticalCount
    }
}