class ProductModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final List<String> secondaryImages;
  final double discountedPrice;
  final double originalPrice;
  final Map<String, String> specification;
  final bool featured;
  final bool banner;
  final String category;
  final int quantityLeft;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.secondaryImages,
    required this.discountedPrice,
    required this.originalPrice,
    required this.specification,
    this.featured = false,
    this.banner = false,
    required this.category,
    required this.quantityLeft,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      secondaryImages: json['secondaryImages'],
      discountedPrice: json['discountedPrice'],
      originalPrice: json['originalPrice'],
      specification: json['specification'],
      featured: json['featured'],
      banner: json['banner'],
      category: json['category'],
      quantityLeft: json['quantityLeft'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'secondaryImages': secondaryImages,
      'discountedPrice': discountedPrice,
      'originalPrice': originalPrice,
      'specification': specification,
      'featured': featured,
      'banner': banner,
      'category': category,
      'quantityLeft': quantityLeft,
    };
  }
}
