class ProductModel {
  int? id;
  String? name;
  String? category;
  String? createdAt;
  String? updatedAt;

  ProductModel({
    this.id,
    this.name,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
