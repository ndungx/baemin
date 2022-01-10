import 'package:baemin/components/default_button.dart';
import 'package:baemin/constants.dart';
import 'package:baemin/models/order_details.dart';
import 'package:baemin/screen/order_details/components/fee_modal_bottom_sheet.dart';
import 'package:baemin/screen/order_details/components/points_clip_path.dart';
import 'package:baemin/screen/shop_details/shop_details_screen.dart';
import 'package:baemin/services/firebase/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_currency_format/simple_currency_format.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.orderID}) : super(key: key);

  final String orderID;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late FireStoreDB db;
  late OrderDetailsModel orderDetails;
  bool isLoading = true;

  initialize() {
    db = FireStoreDB();
    db.initialize();
    db.getOrderDetails(orderID: widget.orderID).then((value) {
      setState(() => orderDetails = value);
      setState(() => isLoading = false);
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: const Color(0xFFebf0f5),
                child: ClipPath(
                  clipper: PointsClipPath(),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pushNamed(
                            ShopDetailsScreen.routeName,
                            arguments: ShopDetailsArguments(
                              shopID: orderDetails.shopID,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(padding: EdgeInsets.only(left: 20)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: Text(
                                  orderDetails.shopName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          formatDate(timestamp: orderDetails.timestamp),
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ...orderDetails.dishes.map((dish) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${dish['quantity']}x',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      dish['dishName'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  currencyFormat(
                                    dish['dishPrice'],
                                    locale: 'vi_VN',
                                    symbol: 'đ',
                                  ),
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Divider(
                                color: Colors.grey.withOpacity(.2),
                                thickness: 1,
                                height: 4,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tạm tính (${orderDetails.dishes.length} món)',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                  Text(
                                    currencyFormat(
                                      orderDetails.dishes.fold(0,
                                          (value, dish) {
                                        return value +
                                            dish['dishPrice'] *
                                                dish['quantity'];
                                      }),
                                      locale: 'vi_VN',
                                      symbol: 'đ',
                                    ),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Material(
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10),
                                            ),
                                          ),
                                          backgroundColor: Colors.white,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return FeeModalBottomSheet(
                                              shippingFee:
                                                  orderDetails.shippingFee,
                                              serviceFee:
                                                  orderDetails.serviceFee,
                                              minimumOrderFee:
                                                  orderDetails.minimumOrderFee,
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Phí áp dụng: ',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          Text(
                                            '${orderDetails.shippingDistance}km',
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 2),
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                size: 12,
                                                color:
                                                    Colors.grey.withOpacity(.4),
                                              ),
                                              const Text(
                                                '?',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  height: 1.2,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    currencyFormat(
                                      orderDetails.serviceFee +
                                          orderDetails.shippingFee +
                                          orderDetails.minimumOrderFee,
                                      locale: 'vi_VN',
                                      symbol: 'đ',
                                    ),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              orderDetails.haveVoucher
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Phiếu mua hàng',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        Text(
                                          '-${currencyFormat(
                                            orderDetails.discountPrice,
                                            locale: 'vi_VN',
                                            symbol: 'đ',
                                          )}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(height: 8),
                              Divider(
                                color: Colors.grey.withOpacity(.2),
                                thickness: 1,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Tổng cộng',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          currencyFormat(
                                            orderDetails.serviceFee +
                                                orderDetails.shippingFee +
                                                orderDetails.minimumOrderFee +
                                                orderDetails.dishes.fold(0,
                                                    (value, dish) {
                                                  return value +
                                                      dish['dishPrice'] *
                                                          dish['quantity'];
                                                }),
                                            locale: 'vi_VN',
                                            symbol: 'đ',
                                          ),
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          currencyFormat(
                                            orderDetails.serviceFee +
                                                orderDetails.shippingFee +
                                                orderDetails.minimumOrderFee -
                                                orderDetails.discountPrice +
                                                orderDetails.dishes.fold(0,
                                                    (value, dish) {
                                                  return value +
                                                      dish['dishPrice'] *
                                                          dish['quantity'];
                                                }),
                                            locale: 'vi_VN',
                                            symbol: 'đ',
                                          ),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey.withOpacity(.2),
                                thickness: 1,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Thanh Toán bằng',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.money,
                                          size: 25,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          orderDetails.paymentType,
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey.withOpacity(.2),
                                thickness: 1,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 8),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Text(
                                            'Mã đơn hàng',
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            orderDetails.orderID,
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Text(
                                            'Tên',
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            orderDetails.ordererName,
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Text(
                                            'Số điện thoại',
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            orderDetails.ordererPhoneNumber
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Text(
                                            'Địa chỉ',
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            orderDetails.ordererAddress,
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.2),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.all(12),
                  color: Colors.white,
                  height: 40,
                  child: DefaultButton(
                    text: 'Đặt lại',
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: baeminColor,
                    borderRadius: 8,
                    height: 20,
                    enabled: true,
                    press: () {},
                  ),
                ),
              )
            ],
          );
  }

  String formatDate({required Timestamp timestamp}) {
    String formattedDate =
        DateFormat('dd, MMM, yyyy HH:MM').format(timestamp.toDate());
    return formattedDate;
  }
}
