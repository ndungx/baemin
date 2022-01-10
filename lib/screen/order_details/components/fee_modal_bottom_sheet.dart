import 'package:flutter/material.dart';
import 'package:simple_currency_format/simple_currency_format.dart';

class FeeModalBottomSheet extends StatelessWidget {
  const FeeModalBottomSheet({
    Key? key,
    required this.shippingFee,
    required this.serviceFee,
    required this.minimumOrderFee,
  }) : super(key: key);

  final int shippingFee;
  final int serviceFee;
  final int minimumOrderFee;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            splashRadius: 10,
            icon: const Icon(Icons.close),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Phí áp dụng',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              buildFeeMenu(
                parentContext: context,
                title: 'Phí vận chuyển',
                subtitle:
                    'Bao gồm: Phí giao cơ bản (dựa trên lộ trình của Google Maps) và Phụ phí, phí gửi xe,...\n\nPhí giao cơ bản có thể thay đổi trong điều kiện giao hàng khó khăn.',
                fee: shippingFee,
              ),
              buildFeeMenu(
                parentContext: context,
                title: 'Phí dịch vụ',
                subtitle:
                    'Phí này giúp BAEMIN duy trì, cải thiện dịch vụ giao hàng cũng như mở rộng đối tác bán hàng tốt hơn.',
                fee: serviceFee,
              ),
              buildFeeMenu(
                parentContext: context,
                title: 'Phí đơn hàng tối thiểu',
                subtitle:
                    'Chỉ áp dụng với đơn hàng nhỏ hơn 0đ. Bạn hãy đặt thêm để tăng giá trị đơn hàng và tránh bị tính thêm phụ phí.',
                fee: minimumOrderFee,
              ),
            ],
          )
        ],
      ),
    );
  }

  buildFeeMenu({
    required BuildContext parentContext,
    required String title,
    required String subtitle,
    required int fee,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(parentContext).size.width * 0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10,
                        height: 1.3,
                        color: Colors.grey.shade700,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                currencyFormat(fee, locale: 'vi_VN', symbol: 'đ'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
