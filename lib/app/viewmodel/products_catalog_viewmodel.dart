import 'package:flutter/material.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/repositories/product_repository.dart';

class ProductsCatalogViewmodel {
  final ProductRepository _repository;

  ProductsCatalogViewmodel(this._repository);

  List<ProductModel> loadProducts() => _repository.getProducts();

  List<ProductModel> filter({
    required List<ProductModel> products,
    required String query,
    required RangeValues priceRange,
  }) {
    return products.where((product) {
      final byQuery = product.title.toLowerCase().contains(query.toLowerCase());
      final byPrice =
          product.price >= priceRange.start && product.price <= priceRange.end;

      return byQuery && byPrice;
    }).toList();
  }

  RangeValues getProductsPriceRange(List<ProductModel> products) {
    final lowerPrice = products
        .map((product) => product.price)
        .reduce((priceA, priceB) => priceA < priceB ? priceA : priceB);

    final higherPrice = products
        .map((product) => product.price)
        .reduce((priceA, priceB) => priceA > priceB ? priceA : priceB);

    return RangeValues(lowerPrice, higherPrice);
  }
}
