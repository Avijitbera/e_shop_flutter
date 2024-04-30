

class ProductModel {
  int id;
  String title;
  String description;
  int price;
  double discount;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;
  ProductModel({
    required this.id,
    required this.brand,
    required this.category,
    required this.description,
    this.discount = 0,
    this.price = 0,
    required this.images,
    this.rating = 0.0,
    required this.thumbnail,
    required this.title,
    this.stock = 0
  });
}