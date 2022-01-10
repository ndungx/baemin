import 'package:baemin/components/default_button.dart';
import 'package:baemin/constants.dart';
import 'package:baemin/models/order.dart';
import 'package:baemin/screen/order_details/order_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_currency_format/simple_currency_format.dart';

class OrderBox extends StatelessWidget {
  const OrderBox({Key? key, required this.listOrder}) : super(key: key);

  final List<OrderModel> listOrder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...listOrder.map(
          (order) => Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OrderDetailsScreen.routeName,
                    arguments: OrderDetailsArguments(order.orderID),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              order.isDelivered
                                  ? Row(
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 12,
                                              color: Colors.grey.shade700,
                                            ),
                                            const Icon(
                                              Icons.check_rounded,
                                              size: 8,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          'Đã giao • ',
                                          style: TextStyle(
                                            fontSize: 10,
                                            height: 1,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'Đang giao • ',
                                      style: TextStyle(
                                        fontSize: 10,
                                        height: 1,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              Text(
                                formatDate(timestamp: order.timestamp),
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            order.shopName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '${currencyFormat(order.totalPrice, locale: 'vi_VN', symbol: 'đ')} (${order.paymentType}) • ${order.dishQuantity} Món',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                height: 1,
                color: Colors.grey.withOpacity(.1),
              ),
              DefaultButton(
                text: 'Đặt lại',
                textStyle: const TextStyle(
                  fontSize: 11,
                  color: baeminColor,
                  fontWeight: FontWeight.w600,
                ),
                height: 24,
                press: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  String formatDate({required Timestamp timestamp}) {
    String formattedDate = DateFormat('dd, MMM').format(timestamp.toDate());
    return formattedDate;
  }
}
