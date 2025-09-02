class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'thumbnail': thumbnail,
    };
  }
}
