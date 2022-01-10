import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetailsModel {
  final int discountPrice;
  final List dishes;
  final int dishQuantity;
  final bool haveVoucher;
  final bool isDelivered;
  final String orderID;
  final String ordererAddress;
  final String ordererName;
  final int ordererPhoneNumber;
  final String paymentType;
  final int shippingFee;
  final int minimumOrderFee;
  final int serviceFee;
  final num shippingDistance;
  final String shopID;
  final String shopName;
  final Timestamp timestamp;
  final int totalPrice;

  OrderDetailsModel({
    required this.discountPrice,
    required this.dishes,
    required this.dishQuantity,
    required this.haveVoucher,
    required this.isDelivered,
    required this.orderID,
    required this.ordererAddress,
    required this.ordererName,
    required this.ordererPhoneNumber,
    required this.paymentType,
    required this.shippingFee,
    required this.minimumOrderFee,
    required this.serviceFee,
    required this.shippingDistance,
    required this.shopID,
    required this.shopName,
    required this.timestamp,
    required this.totalPrice,
  });
}
