import 'package:flutter/material.dart';

class ChipButton extends StatelessWidget {
  const ChipButton({
    Key? key,
    required this.avatar,
    required this.label,
    required this.ratingCount,
  }) : super(key: key);

  final String avatar;
  final String label;
  final int ratingCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.blue.withOpacity(0.04),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(avatar, width: 20, height: 20),
              const SizedBox(width: 5),
              Text(
                label + ' (${roundRatingCount(rating: ratingCount)})',
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
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
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close),
                              splashRadius: 20,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/yummy.png',
                                  scale: 0.5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 4,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        label,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          letterSpacing: -0.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${roundRatingCount(rating: ratingCount)} khách hàng đã đánh giá như vậy',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Hãy cùng BAEMIN nâng cao chất lượng quán bằng cách đánh giá sau khi đơn hàng kết thúc bạn nhé!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(.7),
                                          fontSize: 10,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  roundRatingCount({required rating}) {
    if (rating >= 0 && rating < 15) {
      return rating.toString();
    } else if (rating >= 15 && rating < 50) {
      return '15+';
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
