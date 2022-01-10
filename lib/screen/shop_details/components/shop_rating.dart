import 'package:baemin/constants.dart';
import 'package:flutter/material.dart';

class ShopRating extends StatelessWidget {
  const ShopRating({
    Key? key,
    required this.shopRating,
    required this.ratingCount,
  }) : super(key: key);

  final num shopRating;
  final int ratingCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              backgroundColor: Colors.white,
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            splashRadius: 20,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          const Flexible(
                            child: Text(
                              "Đánh giá cửa hàng",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Opacity(
                            opacity: 0.0,
                            child: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Image.asset(
                        'assets/images/rating.png',
                        scale: 1.3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: const [
                            SizedBox(height: 12),
                            Text(
                              'Đánh giá được thu thập từ khách hàng đã từng đặt món tại cửa hàng. Bạn có thế tham khảo để chọn quá ăn phù hợp.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Bạn cũng đừng quên để lại đánh giá sau mỗi đơn hàng để cửa hàng cải thiện dịch vụ, cũng như soi đường dẫn lối cho rất nhiều miệng ăn khác nhé!',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: const [
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.black,
                  ),
                  Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.yellow,
                  )
                ],
              ),
              const SizedBox(width: 4),
              Text(
                shopRating.toDouble().toString(),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                ' (${roundRatingCount(rating: ratingCount)})  •  ',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.shopping_basket_outlined,
                size: 12,
                color: Colors.grey.shade600,
              ),
              const Text(
                '  100+ đã bán',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {},
          child: const Text(
            'Xem đánh giá',
            style: TextStyle(
              fontSize: 10,
              color: baeminColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  roundRatingCount({required rating}) {
    if (rating >= 0 && rating < 15) {
      return '';
    } else if (rating >= 15 && rating < 50) {
      return rating.toString();
    } else if (rating >= 50 && rating < 100) {
      return '50+';
    } else if (rating >= 100 && rating < 999) {
      return '100+';
    } else if (rating >= 999 && rating < 999999) {
      return '999+';
    } else {
      return '';
    }
  }
}
