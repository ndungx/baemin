import 'package:baemin/constants.dart';
import 'package:flutter/material.dart';

class Voucher extends StatelessWidget {
  const Voucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          color: Colors.white,
          child: Row(
            children: [
              Image.asset('assets/images/voucher.png', scale: 1.3),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text(
                      'Bạn ơi, 40 mã giảm giá vẫy gọi nè',
                      style: TextStyle(
                        color: baeminColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: baeminColor, size: 12),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
            ),
          ),
        )
      ],
    );
  }
}
