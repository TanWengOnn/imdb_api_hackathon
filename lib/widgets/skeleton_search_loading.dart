// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SearchSkeletonLoading extends StatelessWidget {
  SearchSkeletonLoading({Key? key, required this.height, required this.width})
      : super(key: key);

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                height: height,
                width: MediaQuery.of(context).size.width - 10,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                ),
              );
            },
          )),
    );
  }
}
