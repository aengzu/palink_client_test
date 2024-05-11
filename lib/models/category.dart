class Category {
  final int categoryId;
  final String categoryName;

  Category({required this.categoryId, required this.categoryName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
    );
  }
}
