import 'package:baemin/constants.dart';
import 'package:baemin/models/shop_details.dart';
import 'package:baemin/screen/shop_info/shop_info_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final ShopDetailsModel shop;
  final Function love;
  final Function unLove;

  const CustomSliverAppBarDelegate({
    required this.expandedHeight,
    required this.shop,
    required this.love,
    required this.unLove,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    const size = 90;
    final top = expandedHeight - shrinkOffset - size / 2;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        buildBackground(shrinkOffset),
        Positioned(
          top: top,
          left: 12,
          right: 12,
          child: buildFloating(
            parentContext: context,
            shrinkOffset: shrinkOffset,
          ),
        ),
        buildAppBar(
          parentContext: context,
          shrinkOffset: shrinkOffset,
          love: love,
          unLove: unLove,
        ),
        Positioned(
          top: top,
          right: 16,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                ShopInfoScreen.routeName,
                arguments: ShopInfoArguments(
                  shopAddress: shop.shopLocation,
                  latitude: shop.latitude,
                  longitude: shop.longitude,
                  businessHours: shop.businessHours,
                  shopName: shop.shopName,
                ),
              );
            },
            child: const SizedBox(width: 30, height: 30),
          ),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar({
    required BuildContext parentContext,
    required double shrinkOffset,
    required Function love,
    required Function unLove,
  }) {
    return Stack(
      children: [
        Opacity(
          opacity: disappear(shrinkOffset),
          child: AppBar(
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(parentContext),
            ),
            backgroundColor: Colors.white.withOpacity(appear(shrinkOffset)),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [
                    Color(0xFF000000),
                    Color(0x00000000),
                  ],
                ),
              ),
            ),
            actions: [
              FirebaseAuth.instance.currentUser?.uid != null
                  ? StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        return !snapshot.hasData
                            ? const SizedBox.shrink()
                            : snapshot.data!
                                    .get('lovedShopID')
                                    .contains(shop.shopID)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.favorite,
                                        size: 16,
                                        color: Colors.red,
                                      ),
                                      onTap: () => unLove(),
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.favorite_border,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      onTap: () => love(),
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                    ),
                                  );
                      },
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: const Icon(
                    Icons.search,
                    size: 16,
                    color: Colors.white,
                  ),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
        Opacity(
          opacity: appear(shrinkOffset),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(parentContext),
            ),
            backgroundColor: Colors.white.withOpacity(appear(shrinkOffset)),
            title: Text(
              shop.shopName,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            actions: [
              FirebaseAuth.instance.currentUser?.uid != null
                  ? StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        return !snapshot.hasData
                            ? const SizedBox.shrink()
                            : snapshot.data!
                                    .get('lovedShopID')
                                    .contains(shop.shopID)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.favorite,
                                        size: 16,
                                        color: Colors.red,
                                      ),
                                      onTap: () => unLove(),
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.favorite_border,
                                        size: 16,
                                        color: Colors.black,
                                      ),
                                      onTap: () => love(),
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                    ),
                                  );
                      },
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: const Icon(
                    Icons.search,
                    size: 16,
                    color: Colors.black,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBackground(double shrinkOffset) {
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: CachedNetworkImage(
        imageUrl: shop.shopCoverImage,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }

  Widget buildFloating({
    required double shrinkOffset,
    required BuildContext parentContext,
  }) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 3,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              shop.isParner
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/partner.svg',
                            height: 12),
                        const SizedBox(width: 5),
                        const Text(
                          'ĐỐI TÁC CỦA BAEMIN',
                          style: TextStyle(
                            fontSize: 10,
                            height: 1.2,
                            color: baeminColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 10),
              Text(
                shop.shopName,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(parentContext).size.width * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '4.3km - ',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        shop.shopLocation,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Chưa mở cửa',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    ' • Mở 10:00AM',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          right: 5,
          top: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: -3,
                  offset: const Offset(1, 2),
                ),
              ],
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: const [
                Icon(Icons.circle, size: 30, color: Colors.white),
                Icon(Icons.info_outline, size: 20, color: Colors.black),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
