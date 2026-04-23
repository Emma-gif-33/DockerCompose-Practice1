import {ClientsReport} from "../../api/clients/client";
import Link from "next/link";

export const dynamic = "force-dynamic";

export default async function ClientsPage({searchParams}: { searchParams: Promise<any> }) {
    const sParams = await searchParams;
    const report = await ClientsReport({ searchParams: sParams });

    return (

        <div className="p-10">
            <Link href="/" className="text-sm underline mb-4 inline-block">
                Volver atrás
            </Link>

            <h1 className="text-3xl font-bold">Valor del Cliente</h1>
            <p className="text-gray-500 mb-6">
                Identifica a los clientes más leales y su total promedio.
            </p>

            <div className="bg-blue-50 border-l-4 border-blue-500 p-4 mb-8 w-80">
        <span className="text-sm font-semibold text-blue-700 uppercase">
          Cliente de Mayor Valor
        </span>
                <p className="text-xl font-bold text-blue-900">{report.topClient}</p>
                <p className="text-sm text-blue-600">Total gastado: ${report.topAmount}</p>
            </div>

            <div className="overflow-x-auto border rounded-lg">
                <table className="w-full text-left">
                    <thead className="bg-gray-100 border-b text-blue-700">
                    <tr>
                        <th className="p-4">Cliente</th>
                        <th className="p-4">Email</th>
                        <th className="p-4 text-center">Órdenes</th>
                        <th className="p-4 text-right">Total Gastado</th>
                    </tr>
                    </thead>
                    <tbody>
                    {report.clients.map((client: any, i: number) => (
                        <tr key={i} className="border-b hover:bg-gray-50 hover:text-gray-600">
                            <td className="p-4 font-medium">{client.customer_name}</td>
                            <td className="p-4 text-gray-600">{client.customer_email}</td>
                            <td className="p-4 text-center">{client.num_ordenes}</td>
                            <td className="p-4 text-right font-mono">
                                ${client.total_gastado}
                            </td>
                        </tr>
                    ))}
                    </tbody>
                </table>
            </div>

            <div className="mt-8 flex items-center justify-between">
                <p className="text-sm text-gray-500">Página {report.page}</p>
                <div className="flex gap-2">
                    <a
                        href={`?page=${report.page - 1}&limit=${report.limit}`}
                        className={`px-4 py-2 border bg-white text-black rounded ${report.page <= 1 ? "opacity-10 pointer-events-none" : ""}`}
                    >
                        Anterior
                    </a>
                    <a
                        href={`?page=${report.page + 1}&limit=${report.limit}`}
                        className="px-4 py-2 bg-black text-white rounded hover:bg-gray-800"
                    >
                        Siguiente
                    </a>
                </div>
            </div>
        </div>
    );
};
