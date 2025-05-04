class CategoryList {
  Category? category;
  CategoryList({this.category});
}

class Category {
  String? categoryId;
  String? categoryName;
 

  Category({this.categoryId, this.categoryName});

 // Convert map to Category object
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryId: map['id'],
      categoryName: map['name'],
      
    );
  }

  // Convert Category object to map
  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
     
    };
  }
}
