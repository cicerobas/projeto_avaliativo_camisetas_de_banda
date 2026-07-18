import 'package:flutter/material.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/core/extensions.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/data/models/product_model.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/view/widgets/image_placeholder.dart';
import 'package:projeto_avaliativo_camisetas_de_banda/app/viewmodel/product_purchase_viewmodel.dart';

class ProductPurchasePage extends StatefulWidget {
  static const routeName = "/purchase";
  final ProductModel product;
  const ProductPurchasePage({super.key, required this.product});

  @override
  State<ProductPurchasePage> createState() => _ProductPurchasePageState();
}

class _ProductPurchasePageState extends State<ProductPurchasePage> {
  late final ProductPurchaseViewmodel _viewModel;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = ProductPurchaseViewmodel(widget.product);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final smallGreyLabelStyle = TextStyle(
      fontSize: 16,
      color: Colors.grey.shade800,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comprar", style: TextStyle(fontWeight: .bold)),
      ),
      body: Padding(
        padding: const .all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Card(
                elevation: 5,
                color: Colors.white,
                child: SizedBox(
                  height: 200,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const .only(left: 6, top: 6, bottom: 6),
                          child: Image.asset(
                            _viewModel.productImagePath,
                            errorBuilder: (_, _, _) => const ImagePlaceholder(),
                          ),
                        ),
                      ),
                      const VerticalDivider(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisAlignment: .spaceEvenly,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "Camisa selecionada:\n",
                                style: smallGreyLabelStyle,
                                children: [
                                  TextSpan(
                                    text: _viewModel.productName,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: .w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                text: "Preço:\n",
                                style: smallGreyLabelStyle,
                                children: [
                                  TextSpan(
                                    text: _viewModel.productPrice.toStringBRL,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: .bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Text("Tamanho:", style: smallGreyLabelStyle),
              SingleChildScrollView(
                scrollDirection: .horizontal,
                child: Row(
                  mainAxisAlignment: .start,
                  spacing: 8,
                  children: List.generate(
                    growable: false,
                    _viewModel.productAvailableSizes.length,
                    (index) {
                      String size = _viewModel.productAvailableSizes[index];
                      return ChoiceChip(
                        label: Text(size),
                        labelStyle: const TextStyle(fontWeight: .bold),
                        selected: size == _viewModel.selectedSize,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _viewModel.setSelectedSize(size);
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text("Quantidade:", style: smallGreyLabelStyle),
              Container(
                decoration: BoxDecoration(
                  border: .all(color: Colors.grey.shade400),
                  borderRadius: .circular(8),
                ),
                child: Row(
                  mainAxisSize: .min,
                  spacing: 4,
                  children: [
                    IconButton(
                      onPressed: _viewModel.selectedQuantity > 1
                          ? () => setState(() {
                              _viewModel.decrementQuantity();
                            })
                          : null,
                      visualDensity: .compact,
                      icon: const Icon(Icons.remove),
                    ),
                    SizedBox(
                      width: 32,
                      child: Text(
                        "${_viewModel.selectedQuantity}",
                        textAlign: .center,
                        style: const TextStyle(fontSize: 20, fontWeight: .bold),
                      ),
                    ),
                    IconButton(
                      onPressed: _viewModel.selectedQuantity < 5
                          ? () => setState(() {
                              _viewModel.incrementQuantity();
                            })
                          : null,
                      visualDensity: .compact,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text("Parcelas:", style: smallGreyLabelStyle),
              DropdownMenu(
                key: ValueKey(_viewModel.totalPurchaseValue),
                selectOnly: true,
                expandedInsets: .zero,
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(borderRadius: .circular(8)),
                  visualDensity: .compact,
                ),
                textStyle: const TextStyle(fontWeight: .w500, fontSize: 18),
                initialSelection: _viewModel.selectedInstallments,
                dropdownMenuEntries: _viewModel
                    .getInstallmentOptions()
                    .entries
                    .map(
                      (entry) => DropdownMenuEntry(
                        value: entry.key,
                        label: entry.value,
                        style: MenuItemButton.styleFrom(
                          textStyle: const TextStyle(
                            fontWeight: .w500,
                            fontSize: 18,
                          ), // item da lista
                        ),
                      ),
                    )
                    .toList(),
                leadingIcon: const Icon(Icons.monetization_on_outlined),
                onSelected: (value) {
                  if (value != _viewModel.selectedInstallments) {
                    setState(() {
                      _viewModel.setSelectedInstallments(value!);
                    });
                  }
                },
              ),
              const Divider(),
              Form(
                key: _formKey,
                child: Column(
                  spacing: 10,
                  children: [
                    const Text(
                      "Dados do Comprador",
                      style: TextStyle(fontWeight: .w500, fontSize: 20),
                      textAlign: .center,
                    ),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha este campo.';
                        }
                        if (value.trim().length < 4) {
                          return 'Tamanho minimo: 4 caracteres.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        visualDensity: .compact,
                        labelText: "Nome",
                      ),
                    ),
                    TextFormField(
                      controller: _addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha este campo.';
                        }
                        if (value.trim().length < 4) {
                          return 'Tamanho minimo: 4 caracteres.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        visualDensity: .compact,
                        labelText: "Endereço",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const .symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: .min,
            spacing: 10,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: .bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  Text(
                    _viewModel.totalPurchaseValue.toStringBRL,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: .w900,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: .circular(8)),
                    backgroundColor: Colors.blueGrey,
                  ),
                  child: const Text(
                    'Finalizar Compra',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: .bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
