import 'package:flutter/material.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/pages/catalog_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CatalogPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
