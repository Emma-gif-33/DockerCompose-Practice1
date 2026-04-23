import { TopProductsReport } from "@/app/api/top-products/top-prod";
import Link from "next/link";

export const dynamic = "force-dynamic";

export default async function Page({ searchParams }: { searchParams: Promise<any> }) {
  const sParams = await searchParams;
  const report = await TopProductsReport({ searchParams: sParams });

  return (
    <div className="p-10">
      <Link href="/" className="text-sm underline mb-4 inline-block">
        Volver atrás
      </Link>
      <h1 className="text-3xl font-bold">Productos favoritos</h1>
      <p className="text-gray-500 mb-6">
        Ranking basado en el volumen de ingresos y unidades.
      </p>

      <form method="GET" action="/reports/top-products">
        <input
          name="search"
          defaultValue={report.search}
          placeholder="Buscar..."
          className="border-white p-2 text-white"
        />
        <button type="submit" className="bg-black text-white px-4 py-2">
          Buscar
        </button>
      </form>

      <div className="bg-yellow-50 border-l-4 border-yellow-400 p-4 mb-6 w-72">
        <span className="text-sm font-semibold uppercase text-yellow-700">
          Producto más vendido
        </span>
        <p className="text-xl font-bold text-yellow-900">{report.bestSeller}</p>
      </div>

      <table className="w-full text-left border-collapse">
        <thead className="bg-gray-100 text-amber-500">
          <tr>
            <th className="p-3">Rank</th>
            <th className="p-3">Producto</th>
            <th className="p-3">Categoría</th>
            <th className="p-3">Ingresos</th>
          </tr>
        </thead>
        <tbody>
          {report.products.map((p: any) => (
            <tr key={p.ranking_revenue} className="border-b hover:bg-gray-50 hover:text-black">
              <td className="p-3 font-bold">#{p.ranking_revenue}</td>
              <td className="p-3">{p.product_name}</td>
              <td className="p-3">{p.category_name}</td>
              <td className="p-3">${p.total_revenue}</td>
            </tr>
          ))}
        </tbody>
      </table>

      <div className="mt-8 flex items-center gap-4">
        <a
          href={`?search=${report.search}&page=${report.page - 1}`}
          className={`px-4 py-2 bg-gray-200 text-black rounded ${report.page <= 1 ? "opacity-50 pointer-events-none" : ""}`}
        >
          Anterior
        </a>
        <span className="font-medium">Página {report.page}</span>
        <a
          href={`?search=${report.search}&page=${report.page + 1}`}
          className="px-4 py-2 bg-gray-200 rounded text-black"
        >
          Siguiente
        </a>
      </div>
    </div>
  );
}
