import 'package:flutter/material.dart';

class HomeGenresButton extends StatefulWidget {
  
  String label;
  Function searchButton;

  HomeGenresButton({required this.searchButton, required this.label});

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
                  widget.searchButton();
                });
              },
              child: Text("${widget.label}"),
            ),
          );
  }
}