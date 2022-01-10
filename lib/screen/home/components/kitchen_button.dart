import 'package:flutter/material.dart';

class KitchenButton extends StatelessWidget {
  const KitchenButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(.3), width: 1),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.1),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(4, 4),
              ),
            ],
          ),
        ),
        Image.asset(
          'assets/images/kitchen.png',
          fit: BoxFit.cover,
          scale: 2,
        ),
        const Positioned(
          right: 15,
          top: 15,
          child: Text(
            'KITCHEN',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: 'Baemin',
            ),
          ),
        ),
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Material(
              borderRadius: BorderRadius.circular(50),
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
