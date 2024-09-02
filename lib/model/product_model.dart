class ProductDataModel {
  int id;
  String name;
  double price;
  int quantity;
  String category;
  bool isAvailable;
  String image;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.category,
    required this.isAvailable,
    required this.image,
  });
}
