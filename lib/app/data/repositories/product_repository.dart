import 'dart:convert';

import 'package:projeto_avaliativo_camisetas_de_banda/app/data/datasource/product_remote_datasource.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';

class ProductRepository {
  final ProductRemoteDatasource datasource;
  ProductRepository(this.datasource);

  List<ProductModel> getProducts() {
    final list = (jsonDecode(datasource.getProducts()) as List)
        .cast<Map<String, dynamic>>();
    return list.map((item) => ProductModel.fromMap(item)).toList();
  }
}
