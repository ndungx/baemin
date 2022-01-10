import 'package:baemin/constants.dart';
import 'package:baemin/models/shop_details.dart';
import 'package:baemin/screen/shop_details/components/shop_menu.dart';
import 'package:baemin/screen/shop_details/components/shop_rating.dart';
import 'package:baemin/screen/shop_details/components/shop_rating_details.dart';
import 'package:baemin/screen/shop_details/components/shop_voucher.dart';
import 'package:baemin/screen/shop_details/custom_sliver_delegate.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.shopID}) : super(key: key);

  final String shopID;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late ShopDetailsModel shopDetails;
  late FireStoreDB db;
  bool _isLoading = true;

  initialize() {
    db = FireStoreDB();
    db.initialize();
    db.getShopDetails(shopID: widget.shopID).then((value) {
      setState(() {
        shopDetails = value;
        _isLoading = false;
      });
    });
  }

  love() => db.addToLovedShop(widget.shopID);

  unlove() => db.removeFromLovedShop(widget.shopID);

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: CustomSliverAppBarDelegate(
                  expandedHeight: 250,
                  shop: shopDetails,
                  love: love,
                  unLove: unlove,
                ),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 75),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            ShopVoucher(
                                shopVouchersID: shopDetails.shopVouchersID),
                            const SizedBox(height: 10),
                            const Divider(height: 2),
                            const SizedBox(height: 4),
                            ShopRating(
                              shopRating: shopDetails.shopRating,
                              ratingCount: shopDetails.ratingCount,
                            ),
                            const SizedBox(height: 8),
                            const ShopRaingDetails(),
                          ],
                        ),
                      ),
                      Container(
                        color: baeminColor.withOpacity(0.03),
                        padding: const EdgeInsets.only(bottom: 80),
                        child: ShopMenu(shopMenu: shopDetails.shopMenu),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
