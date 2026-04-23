import Link from "next/link";
import {PaymentsReport} from "../../api/payments/payments";

export const dynamic = "force-dynamic"; //QUE SI NO, NO CARGA EL COSO

export default async function ClientsPage() {
    const report = await PaymentsReport();

    return (
        <div className="p-10">
            <Link href="/" className="text-sm underline mb-4 inline-block">
                Volver atrás
            </Link>
            <h1 className="text-3xl font-bold">Tipos de pagos</h1>
            <p className="text-gray-500 mb-8">
                Análisis de los métodos preferidos para entender la distribución del
                flujo de efectivo.
            </p>

            <div className="bg-green-50 border-l-4 border-green-500 p-4 mb-10 w-80">
        <span className="text-sm font-semibold text-green-700 uppercase">
          Método Preferido
        </span>
                <p className="text-xl font-bold text-green-900">{report.favoriteMethod}</p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {report.payments.map((p: any, i: number) => (
                    <div
                        key={i}
                        className="bg-white border p-6 rounded-xl shadow-sm hover:shadow-md transition-shadow"
                    >
                        <div className="flex justify-between items-start mb-4">
                            <h2 className="text-lg font-bold text-gray-700">
                                {p.payment_method}
                            </h2>
                            <span className="bg-blue-100 text-green-950 text-xs font-bold px-2.5 py-0.5 rounded">
                {p.percentage}%
              </span>
                        </div>
                        <div className="flex items-end justify-between">
                            <div>
                                <p className="text-sm text-gray-400 font-medium">
                                    Total Recaudado
                                </p>
                                <p className="text-2xl font-mono font-bold text-green-800">
                                    ${p.total_amount}
                                </p>
                            </div>
                        </div>
                        <div className="w-full bg-gray-200 rounded-full h-2 mt-4">
                            <div
                                className="bg-green-500 h-2 rounded-full"
                                style={{width: `${p.porcentaje}%`}}
                            ></div>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}
