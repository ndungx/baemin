import 'package:baemin/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetailsModel extends OrderModel {
  final int discountPrice;
  final List dishes;
  final bool haveVoucher;
  final String ordererAddress;
  final String ordererName;
  final int ordererPhoneNumber;
  final int shippingFee;
  final int minimumOrderFee;
  final int serviceFee;
  final num shippingDistance;
  final String shopID;

  OrderDetailsModel({
    required this.discountPrice,
    required this.dishes,
    required this.haveVoucher,
    required this.ordererAddress,
    required this.ordererName,
    required this.ordererPhoneNumber,
    required this.shippingFee,
    required this.minimumOrderFee,
    required this.serviceFee,
    required this.shippingDistance,
    required this.shopID,
    required int dishQuantity,
    required bool isDelivered,
    required String orderID,
    required String paymentType,
    required String shopName,
    required Timestamp timestamp,
    required int totalPrice,
  }) : super(
          dishQuantity: dishQuantity,
          isDelivered: isDelivered,
          orderID: orderID,
          paymentType: paymentType,
          shopName: shopName,
          timestamp: timestamp,
          totalPrice: totalPrice,
        );
}
