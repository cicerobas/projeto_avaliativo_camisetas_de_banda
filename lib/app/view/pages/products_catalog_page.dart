import 'package:flutter/material.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/core/extensions.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/datasource/product_remote_datasource.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/repositories/product_repository.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/widgets/product_card.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/widgets/product_tile.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/viewmodel/products_catalog_viewmodel.dart';

class ProductsCatalogPage extends StatefulWidget {
  const ProductsCatalogPage({super.key});

  @override
  State<ProductsCatalogPage> createState() => _ProductsCatalogPageState();
}

class _ProductsCatalogPageState extends State<ProductsCatalogPage> {
  final ProductsCatalogViewmodel _viewModel = ProductsCatalogViewmodel(
    ProductRepository(ProductRemoteDatasource()),
  );

  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];
  late RangeValues _priceRange, _currentRange;
  String _searchQuery = '';
  bool _isGridView = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Catálogo", style: TextStyle(fontWeight: .bold)),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isGridView = !_isGridView;
                });
              },
              icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view_sharp),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const .symmetric(vertical: 8, horizontal: 12),
              child: TextField(
                decoration: const InputDecoration(
                  border: ShapedInputBorder(shape: StadiumBorder()),
                  suffixIcon: Icon(Icons.search),
                  visualDensity: .compact,
                  hintText: "Buscar...",
                ),
                onChanged: (value) {
                  _searchQuery = value;
                  _filterProducts();
                },
              ),
            ),
            Padding(
              padding: const .symmetric(vertical: 8, horizontal: 12),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  const Text("Preço:", style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: RangeSlider(
                      values: _currentRange,
                      min: _priceRange.start,
                      max: _priceRange.end,
                      divisions: 20,
                      labels: RangeLabels(
                        _currentRange.start.toStringBRL,
                        _currentRange.end.toStringBRL,
                      ),
                      onChanged: (range) {
                        _currentRange = range;
                        _filterProducts();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isGridView
                  ? GridView.builder(
                      padding: const .all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 250,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) =>
                          ProductCard(_filteredProducts[index]),
                    )
                  : ListView.builder(
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) =>
                          ProductTile(_filteredProducts[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadProducts() {
    final products = _viewModel.loadProducts();
    setState(() {
      _allProducts = products;
      _filteredProducts = _allProducts;
      _priceRange = _viewModel.getProductsPriceRange(_allProducts);
      _currentRange = _priceRange;
    });
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = _viewModel.filter(
        products: _allProducts,
        query: _searchQuery,
        priceRange: _currentRange,
      );
    });
  }
}
