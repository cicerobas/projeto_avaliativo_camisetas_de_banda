import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';

class ProductPurchaseViewmodel {
  final ProductModel _product;

  ProductPurchaseViewmodel(this._product) {
    selectedSize = _product.sizes.isNotEmpty ? _product.sizes.first : null;
  }

  String? selectedSize;
  String get productName => _product.title;
  double get productPrice => _product.price;
  List<String> get productAvailableSizes => _product.sizes;
  String get productImagePath => _product.imagePath;

  void selectSize(String size) {
    selectedSize = size;
  }
}
