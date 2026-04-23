import Link from "next/link";
import {SalesReport} from "../../api/sales/sales"

export const dynamic = "force-dynamic";

export default async function SalesPage({searchParams}: { searchParams: any }) {
    const report = await SalesReport(searchParams);

  return (
    <div className="p-8 max-w-5xl mx-auto text-black bg-white">
      <Link href="/" className="text-sm underline mb-4 inline-block">
         Volver atrás
      </Link>

      <h1 className="text-2xl font-bold mb-2">Reporte de Ventas Diarias</h1>
      <p className="text-sm mb-6">
        Muestra el ingreso total y flujo de caja por día.
      </p>

      <div className="border p-4 mb-6">
        <p className="text-xs uppercase font-bold">
          Ventas Totales del Periodo
        </p>
        <p className="text-2xl font-mono">${report.totalVentas.toFixed(2)}</p>
      </div>

      <form className="mb-6 flex gap-4">
        <input
          type="date"
          name="date_from"
          defaultValue={report.date_from}
          className="border p-1"
        />
        <input
          type="date"
          name="date_to"
          defaultValue={report.date_to}
          className="border p-1"
        />
        <button type="submit" className="border px-4 py-1 bg-black text-white">
          Filtrado
        </button>
      </form>

      <table className="w-full border-collapse border border-black">
        <thead>
          <tr className="border-b border-black">
            <th className="p-2 text-left">Fecha</th>
            <th className="p-2 text-center">Tickets</th>
            <th className="p-2 text-right">Total</th>
          </tr>
        </thead>
        <tbody>
          {report.data.map((row: any, i: number) => (
            <tr key={i} className="border-b">
              <td className="p-2">
                {new Date(row.fecha).toLocaleDateString()}
              </td>
              <td className="p-2 text-center">{row.tickets}</td>
              <td className="p-2 text-right">${row.total_ventas}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
