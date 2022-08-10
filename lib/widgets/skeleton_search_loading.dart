import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SearchSkeletonLoading extends StatelessWidget {
  SearchSkeletonLoading({required this.height, required this.width});

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width:  MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                        margin: EdgeInsets.symmetric(vertical: 2),
                        height: height,
                        width: MediaQuery.of(context).size.width-10,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                        ),
                      );
                },
              )
            ),
          );
  }
}


                      