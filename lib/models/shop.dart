class ShopModel {
  final String shopID;
  final String shopName;
  final String shopCoverImage;
  final num shopRating;
  final int ratingCount;
  final bool isPromo;
  final bool isParner;

  ShopModel({
    required this.shopID,
    required this.shopName,
    required this.shopCoverImage,
    required this.shopRating,
    required this.ratingCount,
    required this.isPromo,
    required this.isParner,
  });
}
