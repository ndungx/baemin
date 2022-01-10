class DishModel {
  final String dishImage;
  final String dishName;
  final int dishPrice;
  final String? size;

  DishModel({
    required this.dishImage,
    required this.dishName,
    required this.dishPrice,
    this.size,
  });
}
