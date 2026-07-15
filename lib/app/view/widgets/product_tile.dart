import 'package:flutter/material.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/core/extensions.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/widgets/image_placeholder.dart';

class ProductTile extends StatefulWidget {
  final ProductModel product;
  const ProductTile(this.product, {super.key});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: .circular(8),
          child: Image.asset(
            widget.product.imagePath,
            fit: .cover,
            width: 48,
            height: 48,
            errorBuilder: (_, _, _) => const SizedBox(
              width: 48,
              height: 48,
              child: ImagePlaceholder(),
            ),
          ),
        ),
        title: Text(
          widget.product.title,
          overflow: .ellipsis,
          style: const TextStyle(fontWeight: .bold, fontSize: 18),
        ),
        subtitle: Text(
          widget.product.price.toStringBRL,
          style: const TextStyle(fontSize: 16, fontWeight: .w500),
        ),
        trailing: widget.product.available
            ? FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  visualDensity: .compact,
                ),
                child: const Text('COMPRAR'),
              )
            : const Text(
                "Indisponível",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                  fontWeight: .w500,
                ),
                textAlign: .center,
              ),
      ),
    );
  }
}
