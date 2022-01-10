import 'package:baemin/constants.dart';
import 'package:baemin/screen/home/components/advertisement_carousel.dart';
import 'package:baemin/screen/home/components/baemin_mart.dart';
import 'package:baemin/screen/home/components/best_bae_button.dart';
import 'package:baemin/screen/home/components/bubble_tea.dart';
import 'package:baemin/screen/home/components/category.dart';
import 'package:baemin/screen/home/components/deal_one_thousand.dart';
import 'package:baemin/screen/home/components/kitchen_button.dart';
import 'package:baemin/screen/home/components/mart_buttom.dart';
import 'package:baemin/screen/home/components/top_brand.dart';
import 'package:baemin/screen/home/components/voucher.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const AdvertisementCarousel(),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        MartButton(),
                        SizedBox(width: 15),
                        KitchenButton(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Category(),
                  const SizedBox(height: 20),
                  const DealOneThousand(),
                ],
              ),
            ),
            Container(
              color: baeminColor.withOpacity(.06),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Voucher(),
                  SizedBox(height: 10),
                  BestBaeButton(),
                  SizedBox(height: 10),
                  TopBrand(),
                  SizedBox(height: 10),
                  BaeminMart(),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: BubbleTea(),
            ),
            const SizedBox(height: 200),
          ],
        ),
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 30,
            floating: true,
            snap: true,
            actions: [
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                    enabled: false,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(.1),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.search, size: 16, color: kSecondaryColor),
                        SizedBox(width: 10),
                        Text(
                          'Tìm nhà hàng, món ăn',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ];
      },
    );
  }
}
