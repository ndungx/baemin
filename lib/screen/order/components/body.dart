import 'package:baemin/constants.dart';
import 'package:baemin/models/order.dart';
import 'package:baemin/screen/order/order_box.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late FireStoreDB db;
  List listOrderID = [];
  List<OrderModel> listOrder = [];
  bool isLoading = true;

  initialize() {
    db = FireStoreDB();
    db.initialize();
    getListOrder();
  }

  Future<void> getListOrder() async {
    db.listOrderID.then(
      (value) {
        setState(() => listOrderID = value);
        db.getOrder(listOrderID).then((value) {
          setState(() => listOrder = value);
        });
        setState(() => isLoading = false);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () async {
              listOrderID.clear();
              listOrder.clear();
              getListOrder();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: baeminColor.withOpacity(0.04),
                  padding: const EdgeInsets.fromLTRB(12, 18, 12, 6),
                  child: const Text(
                    'Đơn hàng trước',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(children: [OrderBox(listOrder: listOrder)]),
                )
              ],
            ),
          );
  }
}
