import 'package:baemin/constants.dart';
import 'package:baemin/models/shop.dart';
import 'package:baemin/screen/shop_details/shop_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShopBox extends StatelessWidget {
  const ShopBox({Key? key, required this.shops, required this.eventName})
      : super(key: key);

  final List<ShopModel> shops;
  final String eventName;

  roundRatingCount({required rating}) {
    if (rating >= 0 && rating < 15) {
      return rating.toString();
    } else if (rating >= 15 && rating < 50) {
      return '15+';
    } else if (rating >= 50 && rating < 100) {
      return '50+';
    } else if (rating >= 100 && rating < 999) {
      return '100+';
    } else if (rating >= 999 && rating < 999999) {
      return '999+';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...shops.map(
            (shop) => Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.28,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: SizedBox(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.width * 0.26,
                                child: CachedNetworkImage(
                                  imageUrl: shop.shopCoverImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 12,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  shop.shopRating.toDouble().toString(),
                                  style: const TextStyle(fontSize: 10),
                                ),
                                const SizedBox(width: 2),
                                shop.ratingCount == 0
                                    ? const SizedBox(height: 5)
                                    : Text(
                                        '(${roundRatingCount(rating: shop.ratingCount)})',
                                        style: const TextStyle(
                                          fontSize: 9,
                                          color: kSecondaryColor,
                                        ),
                                      ),
                              ],
                            )
                          ],
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
                ),
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ShopDetailsScreen.routeName,
                            arguments: ShopDetailsArguments(
                              shopID: shop.shopID,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.24,
                  height: MediaQuery.of(context).size.width * 0.26,
                  color: baeminColor.withOpacity(0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.arrow_forward, color: baeminColor, size: 20),
                      SizedBox(height: 10),
                      Text(
                        'Xem tất\nluôn ha?',
                        style: TextStyle(color: baeminColor, fontSize: 12),
                      )
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.white24,
                      splashColor: Colors.white30,
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
