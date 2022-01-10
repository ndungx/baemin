import 'package:baemin/screen/shop_details/components/dish_box.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:flutter/material.dart';

class ShopMenu extends StatefulWidget {
  const ShopMenu({Key? key, required this.shopMenu}) : super(key: key);

  final List shopMenu;

  @override
  _ShopMenuState createState() => _ShopMenuState();
}

class _ShopMenuState extends State<ShopMenu> {
  List listMenu = [];

  late FireStoreDB db;

  initialize() {
    db = FireStoreDB();
    db.initialize();
    db.getMenu(listMenu: widget.shopMenu).then((value) {
      setState(() => listMenu = value);
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...listMenu.map((menu) {
          return Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(top: 8),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    menu['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DishBox(listDish: menu['listDish'])
              ],
            ),
          );
        }),
      ],
    );
  }
}
