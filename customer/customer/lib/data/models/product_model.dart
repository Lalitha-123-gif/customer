class ProductsList {
  Product? product;

  ProductsList({this.product});
}

class Product {
  String? productId;
  String? name;
  double? price;
  String? categoryId;

  Product({this.productId, this.name, this.categoryId, this.price});

  // convert map to object//

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      productId: data['id'],
      name: data['name'],
      price: data['price'] != null ? (data['price'] as num).toDouble() : null,
      categoryId: data['category_id'],
    );
  }

  // convert object to map//

  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "name": name,
      "price": price,
      "categoryId": categoryId,
    };
  }
}
