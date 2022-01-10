import 'package:baemin/constants.dart';
import 'package:flutter/material.dart';

class ShopVoucher extends StatelessWidget {
  const ShopVoucher({Key? key, required this.shopVouchersID}) : super(key: key);

  final List shopVouchersID;

  @override
  Widget build(BuildContext context) {
    return shopVouchersID.isNotEmpty //! isEmpty
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.card_giftcard_rounded,
                    size: 14,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Giảm 35K cho đơn 65K',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 11,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Xem thêm',
                  style: TextStyle(
                    fontSize: 10,
                    color: baeminColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        : const SizedBox.shrink();
  }
}
