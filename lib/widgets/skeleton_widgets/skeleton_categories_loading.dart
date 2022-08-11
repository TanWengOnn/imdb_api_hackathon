// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class CategoriesSkeletonLoading extends StatelessWidget {
  CategoriesSkeletonLoading(
      {Key? key, required this.height, required this.width})
      : super(key: key);

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: SizedBox(
        height: height + 20,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
            );
          },
        ),
      ),
    );
  }
}
