import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';

class DetailsPage extends StatelessWidget {

  const DetailsPage({Key? key, required this.movieDetails}) : super(key: key);

  final Map movieDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Details"),
      ),
      body: Column(
        children: [
          Image.network("${movieDetails['image']}", height: 20),
          Text(movieDetails['title'] == '' ? "Stars: No info" : "Title: ${movieDetails['title']}"),
          Text(movieDetails['plot'] == '' ? "Stars: No info" : "Plot: ${movieDetails['plot']}"),
          Text(movieDetails['description'] == '' ? "Stars: No info" : "Description: ${movieDetails['description']}"),
          Text(movieDetails['contentRating'] == '' ? "Stars: No info" : "Content Rating: ${movieDetails['contentRating']}"),
          Text(movieDetails['runtimeStr'] == '' ? "Stars: No info" : "Run Time: ${movieDetails['runtimeStr']}"),
          Text(movieDetails['imDbRating'] == '' ? "Stars: No info" : "IMDB Rating: ${movieDetails['imDbRating']}"),
          Text(movieDetails['imDbRatingVotes'] == '' ? "Stars: No info" : "IMDB Rating Votes: ${movieDetails['imDbRatingVotes']}"),
          Text(movieDetails['stars'] == '' ? "Stars: No info" : "Stars: ${movieDetails['stars']}"),
          Text(movieDetails['genres'] == '' ? "Stars: No info" : "Genres: ${movieDetails['genres']}"),
        ],
      ),
    );
  }
}