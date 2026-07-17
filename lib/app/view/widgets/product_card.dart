import 'package:flutter/material.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/core/extensions.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/pages/product_purchase_page.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/widgets/image_placeholder.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  const ProductCard(this.product, {super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: .stretch,
          mainAxisSize: .min,
          spacing: 2,
          children: [
            ClipRRect(
              borderRadius: .circular(10),
              child: Image.asset(
                widget.product.imagePath,
                fit: .cover,
                height: 140,
                errorBuilder: (_, _, _) =>
                    const SizedBox(height: 140, child: ImagePlaceholder()),
              ),
            ),
            Text(
              widget.product.title,
              overflow: .ellipsis,
              style: const TextStyle(fontSize: 18, fontWeight: .bold),
            ),
            Text(
              widget.product.price.toStringBRL,
              style: const TextStyle(fontSize: 16, fontWeight: .w500),
            ),
            const Spacer(),
            SizedBox(
              height: 36,
              child: widget.product.available
                  ? FilledButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        ProductPurchasePage.routeName,
                        arguments: widget.product,
                      ),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        visualDensity: .compact,
                      ),
                      child: const Text('COMPRAR'),
                    )
                  : const Center(
                      child: Text(
                        "Indisponível",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                          fontWeight: .w500,
                        ),
                        textAlign: .center,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
