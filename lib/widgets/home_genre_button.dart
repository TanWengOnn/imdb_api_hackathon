import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeGenresButton extends StatefulWidget {
  String label;
  Function genresButton;

  HomeGenresButton({Key? key, required this.genresButton, required this.label})
      : super(key: key);

  @override
  State<HomeGenresButton> createState() => _HomeGenresButtonState();
}

class _HomeGenresButtonState extends State<HomeGenresButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            widget.genresButton();
          });
        },
        child: Text(widget.label),
      ),
    );
  }
}
