// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class HomepageSkeletonLoading extends StatelessWidget {
  HomepageSkeletonLoading({Key? key, required this.height, required this.width})
      : super(key: key);

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SkeletonAnimation(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
      )),
    );
  }
}
