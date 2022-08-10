import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class HomepageSkeletonLoading extends StatelessWidget {
  HomepageSkeletonLoading({required this.height, required this.width});

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SkeletonAnimation(
        child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
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

//https://www.youtube.com/watch?v=SQnmuulYWPU