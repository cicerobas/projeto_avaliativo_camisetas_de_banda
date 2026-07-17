import 'package:flutter/material.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';

class ProductPurchasePage extends StatefulWidget {
  static const routeName = "/purchase";
  final ProductModel product;
  const ProductPurchasePage({super.key, required this.product});

  @override
  State<ProductPurchasePage> createState() => _ProductPurchasePageState();
}

class _ProductPurchasePageState extends State<ProductPurchasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comprar", style: TextStyle(fontWeight: .bold)),
      ),
      body: const Placeholder(),
    );
  }
}
