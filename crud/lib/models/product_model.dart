class Product {
  final String id;
  final String title;
  final String imageUrl;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'imageUrl': imageUrl,
    'price': price,
  };

  factory Product.fromMap(Map<String, dynamic> map) => Product(
    id: map['id'] ?? '',
    title: map['title'] ?? '',
    imageUrl: map['imageUrl'] ?? '',
    price: (map['price'] ?? 0).toDouble(),
  );

  copyWith({required String imageUrl}) {}

  
}
