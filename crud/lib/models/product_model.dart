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

  // Fixed copyWith method
  Product copyWith({
    String? id,
    String? title,
    String? imageUrl,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, title: $title, imageUrl: $imageUrl, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product &&
        other.id == id &&
        other.title == title &&
        other.imageUrl == imageUrl &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ imageUrl.hashCode ^ price.hashCode;
  }
}