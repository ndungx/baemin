import 'package:baemin/screen/shop_info/components/shop_map.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.shopAddress,
    required this.latitude,
    required this.longitude,
    required this.businessHours,
    required this.shopName,
  }) : super(key: key);

  final String shopName;
  final String shopAddress;
  final double latitude, longitude;
  final Map businessHours;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String weekday = DateFormat('EEEE').format(date);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Địa chỉ',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          Text(shopAddress, style: const TextStyle(fontSize: 11)),
          const SizedBox(height: 12),
          ShopMap(
            longitude: longitude,
            latitude: latitude,
            shopName: shopName,
          ),
          const SizedBox(height: 26),
          const Text(
            'Thời gian mở cửa',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                child: Text(
                  'Chủ nhật',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: weekday == 'Sunday'
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              Text(
                businessHours['Sunday'],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      weekday == 'Sunday' ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                child: const Text('Thứ 2', style: TextStyle(fontSize: 10)),
              ),
              Text(
                businessHours['Monday'],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      weekday == 'Monday' ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                child: Text(
                  'Thứ 3',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: weekday == 'Tuesday'
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              Text(
                businessHours['Tuesday'],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: weekday == 'Tuesday'
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                child: Text(
                  'Thứ 4',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: weekday == 'Wednesday'
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              Text(
                businessHours['Wednesday'],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: weekday == 'Wednesday'
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                child: Text(
                  'Thứ 5',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: weekday == 'Thursday'
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              Text(
                businessHours['Thursday'],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: weekday == 'Thursday'
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                child: Text(
                  'Thứ 6',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: weekday == 'Friday'
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              Text(
                businessHours['Friday'],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      weekday == 'Friday' ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                child: Text(
                  'Thứ 7',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: weekday == 'Saturday'
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              Text(
                businessHours['Saturday'],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: weekday == 'Saturday'
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
