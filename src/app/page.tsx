import Link from 'next/link';

export default function Dashboard() {
  const reports = [
    { name: 'Ventas Diarias', href: '/reports/sales'},
    { name: 'Productos Estrella', href: '/reports/top-products'},
    { name: 'Info. de Inventario', href: '/reports/stock'},
    { name: 'Datos de cliente', href: '/reports/clients'},
    { name: 'Mezcla de Pagos', href: '/reports/payments'},
  ];

  return (
      <main className="p-10">
        <h1 className="text-4xl font-bold mb-8">Cafetería</h1>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {reports.map((report) => (
              <Link key={report.href} href={report.href}
                    className="p-6 border rounded-xl hover:shadow-lg transition-shadow bg-white text-center">
                <h2 className="text-xl font-semibold text-amber-400">{report.name}</h2>
              </Link>
          ))}
        </div>
      </main>
  );
}