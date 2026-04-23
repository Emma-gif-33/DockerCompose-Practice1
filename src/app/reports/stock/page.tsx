import { SalesReport } from "@/app/api/sales/sales";
import { InventoryReport } from "@/app/api/stock/Stock";
import Link from "next/link";

export const dynamic = "force-dynamic";

export default async function StockPage({ searchParams }: { searchParams: any }) {
  const report = await InventoryReport(searchParams);

  return (
    <div className="p-10">
      <Link href="/" className="text-sm underline mb-4 inline-block">
        Volver atrás
      </Link>
      <h1 className="text-3xl font-bold">Riesgo de Inventario</h1>
      <p className="text-gray-500 mb-6">
        Productos con stock bajo (Límite máximo: 50 unidades).
      </p>

      <div className="bg-red-50 border-l-4 border-red-500 p-4 mb-8 w-80">
        <span className="text-sm font-semibold text-red-700 uppercase">
          Alerta Crítica
        </span>
        <p className="text-xl font-bold text-red-900">
          {report.criticalCount} Productos en riesgo:
        </p>
      </div>

      <div className="overflow-hidden border rounded-lg">
        <table className="w-full text-left">
          <thead className="bg-gray-100 border-b text-red-950">
            <tr>
              <th className="p-4">Producto</th>
              <th className="p-4">Stock</th>
              <th className="p-4">Porcentaje</th>
              <th className="p-4">Nivel de Riesgo</th>
            </tr>
          </thead>
          <tbody>
            {report.products.map((p: any, i: number) => (
              <tr key={i} className="border-b hover:bg-gray-50 hover:text-black">
                <td className="p-4 font-medium">{p.product_name}</td>
                <td className="p-4">{p.current_stock}</td>
                <td className="p-4">
                  <div className="flex items-center gap-2">
                    <div className="w-16 bg-gray-200 h-2 rounded">
                      <div
                        className="bg-orange-500 h-2 rounded"
                        style={{ width: `${p.stock_percentage}%` }}
                      ></div>
                    </div>
                    <span className="text-xs">{p.stock_percentage}%</span>
                  </div>
                </td>
                <td className="p-4">
                  <span
                    className={`px-2 py-1 rounded text-xs font-bold ${p.risk_level === "AGOTADO"
                        ? "bg-black text-white"
                        : p.risk_level.includes("CRÍTICO")
                          ? "bg-red-200 text-red-800"
                          : "bg-orange-200 text-orange-800"
                      }`}
                  >
                    {p.risk_level}
                  </span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
