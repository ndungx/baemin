import 'package:baemin/screen/home/home.dart';
import 'package:baemin/screen/location_permission/location_permission_screen.dart';
import 'package:baemin/screen/login/login_screen.dart';
import 'package:baemin/screen/loved_shop/loved_shop_screen.dart';
import 'package:baemin/screen/mail_details/mail_details_screen.dart';
import 'package:baemin/screen/mailbox/mailbox_screen.dart';
import 'package:baemin/screen/name_form/name_form_screen.dart';
import 'package:baemin/screen/order/order_screen.dart';
import 'package:baemin/screen/order_details/order_details.dart';
import 'package:baemin/screen/otp/otp_screen.dart';
import 'package:baemin/screen/password/password_screen.dart';
import 'package:baemin/screen/password_form/password_form_screen.dart';
import 'package:baemin/screen/phone_form/phone_form_screen.dart';
import 'package:baemin/screen/profile/profile_screen.dart';
import 'package:baemin/screen/shop_details/shop_details_screen.dart';
import 'package:baemin/screen/shop_info/shop_info_screen.dart';
import 'package:baemin/screen/sign_up_success/sign_up_success_screen.dart';
import 'package:baemin/screen/user/user_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  PasswordScreen.routeName: (context) => const PasswordScreen(),
  PhoneFormScreen.routeName: (context) => const PhoneFormScreen(),
  OTPScreen.routeName: (context) => const OTPScreen(),
  NameFormScreen.routeName: (context) => const NameFormScreen(),
  PasswordFormScreen.routeName: (context) => const PasswordFormScreen(),
  LocationPermissionScreen.routeName: (context) =>
      const LocationPermissionScreen(),
  SignUpSuccessScreen.routeName: (context) => const SignUpSuccessScreen(),
  Home.routeName: (context) => const Home(),
  UserScreen.routeName: (context) => const UserScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  MailboxScreen.routeName: (context) => const MailboxScreen(),
  MailDetailsScreen.routeName: (context) => const MailDetailsScreen(),
  ShopDetailsScreen.routeName: (context) => const ShopDetailsScreen(),
  ShopInfoScreen.routeName: (context) => const ShopInfoScreen(),
  OrderScreen.routeName: (context) => const OrderScreen(),
  OrderDetailsScreen.routeName: (context) => const OrderDetailsScreen(),
  LovedShopScreen.routeName: (context) => const LovedShopScreen(),
};
