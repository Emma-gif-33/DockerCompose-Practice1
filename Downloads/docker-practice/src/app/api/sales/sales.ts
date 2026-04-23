import {DateRangeSchema} from "@/lib/validations";
import {pool} from "@/lib/db";

export const dynamic = "force-dynamic";

export async function SalesReport({searchParams,}: { searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
}) {
    const params = searchParams || {};
    const filters = await params;
    const { date_from, date_to } = DateRangeSchema.parse(filters);

    const result = await pool.query(
        "SELECT * FROM vw_sales_daily WHERE fecha BETWEEN $1 AND $2 ORDER BY fecha DESC",
        [date_from, date_to],
    );
    const data = result.rows;

    const totalVentas = data.reduce(
        (acc: number, row: any) => acc + Number(row.total_ventas),
        0,
    )
     return{
        date_from,
         date_to,
         data,
    totalVentas
     }
}
