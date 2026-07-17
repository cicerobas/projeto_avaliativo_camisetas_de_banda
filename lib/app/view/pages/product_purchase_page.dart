import 'package:flutter/material.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/core/extensions.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/widgets/image_placeholder.dart';

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
    final smallGreyLabelStyle = TextStyle(
      fontSize: 16,
      color: Colors.grey.shade800,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comprar", style: TextStyle(fontWeight: .bold)),
      ),
      body: Padding(
        padding: const .all(8),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Card(
              elevation: 5,
              color: Colors.white,
              child: SizedBox(
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const .only(left: 6, top: 6, bottom: 6),
                        child: Image.asset(
                          widget.product.imagePath,
                          errorBuilder: (_, _, _) => const ImagePlaceholder(),
                        ),
                      ),
                    ),
                    const VerticalDivider(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisAlignment: .spaceEvenly,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Camisa selecionada:\n",
                              style: smallGreyLabelStyle,
                              children: [
                                TextSpan(
                                  text: widget.product.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: .w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "Preço:\n",
                              style: smallGreyLabelStyle,
                              children: [
                                TextSpan(
                                  text: widget.product.price.toStringBRL,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: .bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
