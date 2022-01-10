import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final int dishQuantity;
  final bool isDelivered;
  final String orderID;
  final String paymentType;
  final String shopName;
  final Timestamp timestamp;
  final int totalPrice;

  OrderModel({
    required this.dishQuantity,
    required this.isDelivered,
    required this.orderID,
    required this.paymentType,
    required this.shopName,
    required this.timestamp,
    required this.totalPrice,
  });
}
