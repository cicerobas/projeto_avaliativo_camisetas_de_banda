import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            elevation: 5,
            expandedHeight: 200,
            backgroundColor: context.colors.primary,
            foregroundColor: context.colors.onPrimary,
            title: const Text("Catálogo", style: TextStyle(fontWeight: .bold)),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isGridView = !_isGridView;
                  });
                },
                icon: Icon(
                  _isGridView ? Icons.view_list : Icons.grid_view_sharp,
                ),
              ),
            ],
            systemOverlayStyle: const SystemUiOverlayStyle(
              systemNavigationBarIconBrightness: .dark,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const .symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: .end,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: .none,
                          borderRadius: .circular(30),
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: context.colors.primary,
                        ),
                        visualDensity: .compact,
                        hintText: "Buscar...",
                        hintStyle: TextStyle(
                          color: context.colors.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        filled: true,
                        fillColor: context.colors.surface,
                      ),
                      style: TextStyle(color: context.colors.onSurface),
                      onChanged: (value) {
                        _searchQuery = value;
                        _filterProducts();
                      },
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              "Faixa de Preço:",
                              style: TextStyle(
                                fontSize: 16,
                                color: context.colors.onPrimary,
                                fontWeight: .bold,
                              ),
                            ),
                            Text(
                              "${_currentRange.start.toStringBRL}  -  ${_currentRange.end.toStringBRL}",
                              style: TextStyle(
                                fontSize: 16,
                                color: context.colors.onPrimary,
                                fontWeight: .bold,
                              ),
                            ),
                          ],
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: context.colors.onPrimary,
                            thumbColor: context.colors.onPrimary,
                            inactiveTrackColor: context.colors.onPrimary
                                .withValues(alpha: 0.5),
                            overlayColor: context.colors.onPrimary.withValues(
                              alpha: 0.1,
                            ),
                          ),
                          child: RangeSlider(
                            values: _currentRange,
                            min: _priceRange.start,
                            max: _priceRange.end,
                            divisions: 20,
                            onChanged: (RangeValues range) {
                              setState(() {
                                _currentRange = range;
                              });
                            },
                            onChangeEnd: (RangeValues range) {
                              _filterProducts();
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const .symmetric(vertical: 8, horizontal: 12),
            sliver: _isGridView
                ? SliverGrid.builder(
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
                : SliverList.builder(
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) =>
                        ProductTile(_filteredProducts[index]),
                  ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
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
