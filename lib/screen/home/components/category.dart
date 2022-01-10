import 'package:baemin/constants.dart';
import 'package:baemin/models/category.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<CategoryModel> categories = [];

  late FireStoreDB db;
  initialize() {
    db = FireStoreDB();
    db.initialize();
    db.getCategoryDoc().then((value) => {
          setState(() {
            categories = value as List<CategoryModel>;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: MediaQuery.of(context).size.width * 0.25,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: DottedDecoration(
            shape: Shape.box,
            color: kSecondaryColor.withOpacity(.2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * .14,
                child: Image.asset(categories[index].image),
              ),
              const SizedBox(height: 5),
              Text(
                categories[index].text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
