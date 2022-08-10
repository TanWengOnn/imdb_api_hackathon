import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class HomepageSkeletonLoading extends StatelessWidget {
  HomepageSkeletonLoading({required this.height, required this.width});

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
            child: Container(
              height: height+20,
              width:  MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return  Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                      );
                },
              ),
            ),
          );
  }
}

//https://www.youtube.com/watch?v=SQnmuulYWPU