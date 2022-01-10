import 'package:baemin/constants.dart';
import 'package:baemin/models/shop.dart';
import 'package:baemin/screen/home/home.dart';
import 'package:baemin/screen/loved_shop/components/loved_shop_box.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late FireStoreDB db;
  bool _isLoading = true;
  List<ShopModel> listShops = [];

  inilialize() {
    db = FireStoreDB();
    db.initialize();
    db.getLovedShopID().then((value) {
      db.getLovedShops(listLovedShopID: value).then((value) {
        setState(() {
          listShops = value;
          _isLoading = false;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    inilialize();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : listShops.isEmpty
            ? Column(
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    'assets/images/loved_shop.png',
                    scale: 2.6,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Nhà hàng yêu thích',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      'Chỉ cần nhấn vào biểu tượng trái tim ở trên cùng mỗi trang nhà hàng, quán bạn lưu sẽ xuất hiện tại đây.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) {
                        return route.isFirst;
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 46,
                        vertical: 14,
                      ),
                      side: const BorderSide(
                        color: baeminColor,
                        width: 1,
                      ),
                    ),
                    child: const Text(
                      'ĐẶT MÓN',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            : StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .snapshots(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot,
                ) {
                  return !snapshot.hasData
                      ? const SizedBox.shrink()
                      : snapshot.data!.get('lovedShopID').isEmpty
                          ? Column(
                              children: [
                                const SizedBox(height: 50),
                                Image.asset(
                                  'assets/images/loved_shop.png',
                                  scale: 2.6,
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Nhà hàng yêu thích',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    'Chỉ cần nhấn vào biểu tượng trái tim ở trên cùng mỗi trang nhà hàng, quán bạn lưu sẽ xuất hiện tại đây.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.4,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).popUntil((route) {
                                      return route.isFirst;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 46,
                                      vertical: 14,
                                    ),
                                    side: const BorderSide(
                                      color: baeminColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: const Text(
                                    'ĐẶT MÓN',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                ...listShops.map((shop) {
                                  return !snapshot.hasData
                                      ? const SizedBox.shrink()
                                      : snapshot.data!
                                              .get('lovedShopID')
                                              .contains(shop.shopID)
                                          ? LovedShopBox(shop: shop)
                                          : const SizedBox.shrink();
                                })
                              ],
                            );
                },
              );
  }
}
