class ProductCategory {
  final int id;
  final String category;

  ProductCategory({
    required this.id,
    required this.category,
  });

  ProductCategory.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          category: json["category"],
        );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
      };
}
