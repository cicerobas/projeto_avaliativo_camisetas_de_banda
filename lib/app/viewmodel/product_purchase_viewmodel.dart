import 'package:projeto_avaliativo_camisetas_de_banda/app/core/extensions.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/purchase_model.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/repositories/purchase_repository.dart';

class ProductPurchaseViewmodel {
  final ProductModel _product;
  final PurchaseRepository _repository;

  ProductPurchaseViewmodel(this._product, this._repository) {
    selectedSize = _product.sizes.isNotEmpty ? _product.sizes.first : null;
    _updateTotalPurchaseValue();
  }

  final double _baseInterest = 0.5;

  String get productName => _product.title;
  double get productPrice => _product.price;
  List<String> get productAvailableSizes => _product.sizes;
  String get productImagePath => _product.imagePath;

  String? selectedSize;
  int selectedQuantity = 1;
  int selectedInstallments = 1;

  double totalPurchaseValue = 0.0;

  String customerName = "";
  String customerAddress = "";

  void setSelectedSize(String size) {
    selectedSize = size;
  }

  void incrementQuantity() {
    selectedQuantity++;
    _updateTotalPurchaseValue();
  }

  void decrementQuantity() {
    selectedQuantity--;
    _updateTotalPurchaseValue();
  }

  void setSelectedInstallments(int installments) {
    selectedInstallments = installments;
    _updateTotalPurchaseValue();
  }

  void _updateTotalPurchaseValue() {
    totalPurchaseValue =
        _applyInterest(selectedInstallments) * selectedQuantity;
  }

  Map<int, String> getInstallmentOptions() {
    final Map<int, String> installmentOptions = {
      1: "1x de ${(productPrice * selectedQuantity).toStringBRL} sem juros",
    };
    for (var i = 2; i < 7; i++) {
      final totalWithInterest = _applyInterest(i) * selectedQuantity;
      final installmentValue = totalWithInterest / i;
      installmentOptions[i] =
          "${i}x de ${installmentValue.toStringBRL} com juros";
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

  void setFormData({required String name, required String address}) {
    customerName = name.trim();
    customerAddress = address.trim();
  }

  void processPurchase() {
    final purchaseData = PurchaseModel(
      productName: productName,
      size: selectedSize!,
      quantity: selectedQuantity,
      installments: selectedInstallments,
      totalValue: totalPurchaseValue,
      customerName: customerName,
      customerAddress: customerAddress,
    );

    _repository.processPurchase(purchaseData);
  }
}
