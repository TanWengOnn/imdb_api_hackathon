import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/services/search_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("IMDB", style: Theme.of(context).textTheme.headline1),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.1),
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/search");
              },
            ),
          ]),
    );
  }
}
