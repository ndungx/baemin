import 'package:baemin/models/dish.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_currency_format/simple_currency_format.dart';

class DishBox extends StatefulWidget {
  const DishBox({Key? key, required this.listDish}) : super(key: key);

  final List listDish;

  @override
  State<DishBox> createState() => _DishBoxState();
}

class _DishBoxState extends State<DishBox> {
  List<DishModel> dishList = [];

  late FireStoreDB db;

  initialize() {
    db = FireStoreDB();
    db.initialize();
    db.getDish(listDish: widget.listDish).then((value) {
      setState(() => dishList = value);
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
      children: [
        ...dishList.map(
          (dish) {
            return Material(
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  height: MediaQuery.of(context).size.height * 0.14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dish.dishName,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                dish.size ?? '',
                                style: const TextStyle(fontSize: 10),
                              ),
                              Text(
                                currencyFormat(
                                  dish.dishPrice,
                                  locale: 'vi_VN',
                                  symbol: 'đ',
                                ),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.1),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: dish.dishImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
