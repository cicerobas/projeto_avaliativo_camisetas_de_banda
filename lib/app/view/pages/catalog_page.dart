import 'package:flutter/material.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/datasource/product_remote_datasource.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/repositories/product_repository.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/widgets/product_card.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/widgets/product_tile.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/viewmodel/catalog_viewmodel.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final CatalogViewmodel _viewModel = CatalogViewmodel(
    ProductRepository(ProductRemoteDatasource()),
  );
  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];
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
              padding: const .symmetric(vertical: 6, horizontal: 12),
              child: TextField(
                decoration: const InputDecoration(
                  border: ShapedInputBorder(shape: StadiumBorder()),
                  suffixIcon: Icon(Icons.search),
                  visualDensity: .compact,
                  hintText: "Buscar...",
                ),
                onChanged: _onSearch,
              ),
            ),
            Expanded(
              child: _isGridView
                  ? GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.5,
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
      _filteredProducts = products;
    });
  }

  void _onSearch(String query) {
    setState(() {
      _filteredProducts = _viewModel.searchFilter(_allProducts, query);
    });
  }
}
