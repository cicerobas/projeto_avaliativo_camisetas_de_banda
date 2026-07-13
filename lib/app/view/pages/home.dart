import 'package:flutter/material.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/datasource/product_remote_datasource.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/repositories/product_repository.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/widgets/product_card.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/widgets/product_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final remoteData = ProductRemoteDatasource();
  late final ProductRepository prodRepo;
  List<ProductModel> tempList = [];
  bool _isGridView = true;

  @override
  void initState() {
    prodRepo = ProductRepository(remoteData);
    tempList.addAll(prodRepo.getProducts());
    super.initState();
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
            Expanded(
              child: _isGridView
                  ? GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.5,
                          ),
                      itemCount: tempList.length,
                      itemBuilder: (context, index) =>
                          ProductCard(tempList[index]),
                    )
                  : ListView.builder(
                      itemCount: tempList.length,
                      itemBuilder: (context, index) =>
                          ProductTile(tempList[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
