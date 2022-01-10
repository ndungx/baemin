// class ShopDetailsModel {
//   final String shopName;
//   final String shopCoverImage;
//   final List shopMenu;
//   final Map businessHours;
//   final String? shopLocation;
//   final String latitude, longitude;
//   final num? shopRating;
//   final int? ratingCount;
//   final List? shopVouchersID;
//   final bool? isPromo;
//   final bool? isParner;

//   ShopDetailsModel({
//     required this.shopName,
//     required this.shopCoverImage,
//     required this.shopMenu,
//     required this.businessHours,
//     required this.latitude,
//     required this.longitude,
//     this.shopLocation,
//     this.shopRating,
//     this.ratingCount,
//     this.shopVouchersID,
//     this.isPromo = false,
//     this.isParner = false,
//   });
// }

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
