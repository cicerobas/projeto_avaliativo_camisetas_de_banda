import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/pages/product_purchase_page.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/pages/products_catalog_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blueGrey)),
      home: const ProductsCatalogPage(),
      onGenerateRoute: (settings) {
        if (settings.name == ProductPurchasePage.routeName) {
          final product = settings.arguments as ProductModel;
          return MaterialPageRoute(
            builder: (context) => ProductPurchasePage(product: product),
          );
        }
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text("Erro")),
            body: const Center(
              child: Text(
                "Página não encontrada...",
                style: TextStyle(fontWeight: .bold, fontSize: 24),
              ),
            ),
          ),
        );
      },
    );
  }
}
