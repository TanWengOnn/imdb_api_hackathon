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
        title: Text("Movies"),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            label: Text("Search"),
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
