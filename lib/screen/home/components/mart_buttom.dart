import 'package:flutter/material.dart';

class MartButton extends StatelessWidget {
  const MartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          width: 115,
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
          'assets/images/mart.png',
          fit: BoxFit.cover,
          scale: 1.1,
        ),
        const Positioned(
          right: 15,
          top: 15,
          child: Text(
            'MART',
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
