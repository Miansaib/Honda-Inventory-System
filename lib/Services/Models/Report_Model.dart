class Product {
  final String name;
  final double price;
  final double wholesalePrice;
  final String imageUrl;
  final String productId;
  final double discount;
  final String datetime;

  const Product({
    required this.name,
    required this.price,
    required this.wholesalePrice,
    required this.imageUrl,
    required this.productId,
    required this.discount,
  required this.datetime,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      wholesalePrice: json['wholesale_price'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      productId: json['product_id'] ?? '',
      discount: json['discount'] ?? 0,
      datetime: json['data_time']
    );
  }
}
