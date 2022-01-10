import 'package:flutter/material.dart';

class DealOneThousand extends StatelessWidget {
  const DealOneThousand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/images/deal_one_thousand.png',
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              top: 30,
              right: 10,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
