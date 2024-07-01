import 'package:flutter/material.dart';

class BannerModel {
  String text;
  List<Color> cardBackground;
  String image;

  BannerModel(this.text, this.cardBackground, this.image);
}

List<BannerModel> bannerCards = [
  BannerModel(
      "Check Disease",
      [
        const Color(0xffa1d4ed),
        const Color(0xffc0eaff),
      ],
      "assets/414-bg.png"),
  BannerModel(
      "Medical Drugs",
      [
        const Color(0xffb6d4fa),
        const Color(0xffcfe3fc),
      ],
      "assets/covid-bg.png"),
  // BannerModel(
  //   "Medical Drugs",
  //   [
  //     Color.fromARGB(255, 40, 241, 40),
  //     Color.fromARGB(255, 9, 116, 36),
  //   ],
  //   "assets/images-removebg-preview.png",
  // ),
];
