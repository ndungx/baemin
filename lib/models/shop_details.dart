import 'package:baemin/models/shop.dart';

class ShopDetailsModel extends ShopModel {
  final List shopMenu;
  final Map businessHours;
  final String shopLocation;
  final num latitude, longitude;
  final List shopVouchersID;

  ShopDetailsModel({
    required this.shopMenu,
    required this.businessHours,
    required this.shopLocation,
    required this.latitude,
    required this.longitude,
    required this.shopVouchersID,
    required String shopID,
    required String shopName,
    required String shopCoverImage,
    required num shopRating,
    required int ratingCount,
    required bool isPromo,
    required bool isParner,
  }) : super(
          shopID: shopID,
          isParner: isParner,
          isPromo: isPromo,
          ratingCount: ratingCount,
          shopCoverImage: shopCoverImage,
          shopName: shopName,
          shopRating: shopRating,
        );
}
