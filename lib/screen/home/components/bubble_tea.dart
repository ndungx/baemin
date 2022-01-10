import 'package:baemin/models/shop.dart';
import 'package:baemin/screen/home/shop_box.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:flutter/material.dart';

class BubbleTea extends StatefulWidget {
  const BubbleTea({Key? key}) : super(key: key);

  @override
  _BubbleTeaState createState() => _BubbleTeaState();
}

class _BubbleTeaState extends State<BubbleTea> {
  Map bubbleTea = {};
  List<ShopModel> listShops = [];

  late FireStoreDB db;

  initialize() {
    db = FireStoreDB();
    db.initialize();
    db.getEvent(eventName: 'bubble_tea').then((value) {
      setState(() {
        bubbleTea = value;
      });
      db.getShops(listDocID: bubbleTea['list_shop'], isLimit: true).then(
            (value) => setState(() => listShops = value),
          );
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return bubbleTea.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bubbleTea['title'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            bubbleTea['subtitle'],
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ShopBox(shops: listShops, eventName: 'bubble_tea'),
            ],
          )
        : const SizedBox.shrink();
  }
}
