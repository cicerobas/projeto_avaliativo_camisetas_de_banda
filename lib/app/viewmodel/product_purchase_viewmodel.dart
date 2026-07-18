import 'package:projeto_avaliativo_camisetas_de_banda/app/core/extensions.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';

class ProductPurchaseViewmodel {
  final ProductModel _product;

  ProductPurchaseViewmodel(this._product) {
    selectedSize = _product.sizes.isNotEmpty ? _product.sizes.first : null;
  }

  final double _baseInterest = 0.5;

  String get productName => _product.title;
  double get productPrice => _product.price;
  List<String> get productAvailableSizes => _product.sizes;
  String get productImagePath => _product.imagePath;

  String? selectedSize;
  int selectedQuantity = 1;
  int selectedInstallments = 1;

  void setSelectedSize(String size) {
    selectedSize = size;
  }

  void incrementQuantity() {
    selectedQuantity++;
  }

  void decrementQuantity() {
    selectedQuantity--;
  }

  void setSelectedInstallments(int installments) {
    selectedInstallments = installments;
  }

  Map<int, String> getInstallmentOptions() {
    Map<int, String> installmentOptions = {
      1: "1x de ${productPrice.toStringBRL} sem juros",
    };
    for (var i = 2; i < 7; i++) {
      final value = _applyInterest(i) / i;
      installmentOptions[i] = "${i}x de ${value.toStringBRL} com juros";
    }
    return installmentOptions;
  }

  double _applyInterest(int installments) {
    if (installments == 1) return productPrice;
    final interest = (_baseInterest / 100) * (installments - 1);
    final priceWithInterest = (productPrice * interest) + productPrice;
    final priceInCents = (priceWithInterest * 100).round();
    return priceInCents / 100;
  }
}
