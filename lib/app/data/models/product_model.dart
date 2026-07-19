class ProductModel {
  final String title;
  final double price;
  final List<String> sizes;
  final String imagePath;
  final bool available;

  ProductModel({
    required this.title,
    required this.price,
    required this.sizes,
    required this.imagePath,
    required this.available,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      title: map['titulo'] as String,
      price: map['preco'] as double,
      sizes: List<String>.from(map['tamanhosDisponiveis']),
      imagePath: map['imagem'] as String,
      available: map['disponivel'] as bool,
    );
  }

  @override
  String toString() {
    return 'Product(title: $title, price: $price, sizes: $sizes, imagePath: $imagePath, available: $available)';
  }
}
