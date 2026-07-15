import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/repositories/product_repository.dart';

class CatalogViewmodel {
  final ProductRepository _repository;

  CatalogViewmodel(this._repository);

  List<ProductModel> loadProducts() => _repository.getProducts();

  List<ProductModel> searchFilter(List<ProductModel> products, String query) {
    if (query.isEmpty) return products;

    return products.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
