import 'package:baemin/models/shop.dart';
import 'package:baemin/screen/shop_details/shop_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LovedShopBox extends StatelessWidget {
  const LovedShopBox({Key? key, required this.shop}) : super(key: key);

  final ShopModel shop;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ShopDetailsScreen.routeName,
          arguments: ShopDetailsArguments(shopID: shop.shopID),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: SizedBox(
              height: 72,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: CachedNetworkImage(
                              imageUrl: shop.shopCoverImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      shop.isPromo
                          ? Positioned(
                              top: 0,
                              left: 0,
                              child: SvgPicture.asset(
                                'assets/icons/promo.svg',
                                height: 14,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    shop.isParner
                                        ? WidgetSpan(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 4,
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/icons/partner.svg',
                                                height: 10,
                                              ),
                                            ),
                                          )
                                        : const WidgetSpan(
                                            child: SizedBox.shrink(),
                                          ),
                                    const WidgetSpan(child: SizedBox(width: 2)),
                                    TextSpan(
                                      text: shop.shopName,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Trà bí đao',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            '4.3km',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200, thickness: 1),
        ],
      ),
    );
  }
}
