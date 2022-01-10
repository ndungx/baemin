import 'package:baemin/constants.dart';
import 'package:baemin/screen/loved_shop/loved_shop_screen.dart';
import 'package:baemin/screen/order/order_screen.dart';
import 'package:baemin/screen/user/components/auth_email.dart';
import 'package:baemin/screen/user/components/user_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: baeminColor.withOpacity(.03),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          FirebaseAuth.instance.currentUser?.uid != null
              ? false //isAuthEmail
                  ? const SizedBox.shrink()
                  : const AuthEmail()
              : const SizedBox(height: 145),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    FirebaseAuth.instance.currentUser?.uid != null
                        ? UserMenu(
                            text: 'Đơn hàng của tôi',
                            press: () {
                              Navigator.of(context).pushNamed(
                                OrderScreen.routeName,
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                    FirebaseAuth.instance.currentUser?.uid != null
                        ? UserMenu(
                            text: 'Nhà hàng yêu thích',
                            press: () {
                              Navigator.of(context).pushNamed(
                                LovedShopScreen.routeName,
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                    FirebaseAuth.instance.currentUser?.uid != null
                        ? UserMenu(
                            text: 'Quản lí thanh toán',
                            press: () {},
                          )
                        : const SizedBox.shrink(),
                    UserMenu(
                      text: 'Ví Coupon',
                      press: () {},
                    ),
                    FirebaseAuth.instance.currentUser?.uid != null
                        ? UserMenu(
                            text: 'Địa chỉ đã lưu',
                            press: () {},
                          )
                        : const SizedBox.shrink(),
                    UserMenu(
                      text: 'Hỗ trợ',
                      press: () {},
                    ),
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      'v0.95.4',
                      style: TextStyle(
                        fontSize: 12,
                        color: kSecondaryColor,
                      ),
                    ),
                    Text(
                      'BAEMIN',
                      style: TextStyle(
                          fontSize: 20,
                          color: kPrimaryColor,
                          fontFamily: 'Baemin'),
                    ),
                    SizedBox(height: 10),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
