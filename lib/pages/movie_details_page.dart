import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/states/trailer_cubit.dart';
import 'package:imdb_api_hackathon/states/trailer_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.movieDetails}) : super(key: key);

  final Map movieDetails;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final TrailerCubit trailerCubit;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    trailerCubit = BlocProvider.of<TrailerCubit>(context)
      ..fetchTrailer(movieID: widget.movieDetails['id']);
  }

// reference: https://github.com/Bytx-youtube/ytplayer/blob/main/lib/mainscreen.dart
// https://www.youtube.com/watch?v=feQhHStBVLE
  Widget youtube(String trailerId) {
    _controller = YoutubePlayerController(
      initialVideoId: "$trailerId",
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
    return AlertDialog(
      content: Container(
        width: 300,
        height: 200,
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Details"),
      ),
      body: Column(
        children: [
          BlocBuilder<TrailerCubit, TrailerState>(
            bloc: trailerCubit,
            builder: (context, state) {
              if (state is TrailerLoading) {
                return CircularProgressIndicator();
              }

              if (state is TrailerLoaded) {
                return ElevatedButton(
                  onPressed: () {
                    youtube(state.trailerModel.videoId);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return youtube(state.trailerModel.videoId);
                      },
                    );
                  },
                  child: Text("Trailer"),
                );
              }

              return Text(state is TrailerError ? state.errorMessage : "");
            },
          ),
          Image.network("${widget.movieDetails['image']}", height: 20),
          Text(widget.movieDetails['title'] == ''
              ? "Stars: No info"
              : "Title: ${widget.movieDetails['title']}"),
          Text(widget.movieDetails['plot'] == ''
              ? "Stars: No info"
              : "Plot: ${widget.movieDetails['plot']}"),
          Text(widget.movieDetails['description'] == ''
              ? "Stars: No info"
              : "Description: ${widget.movieDetails['description']}"),
          Text(widget.movieDetails['contentRating'] == ''
              ? "Stars: No info"
              : "Content Rating: ${widget.movieDetails['contentRating']}"),
          Text(widget.movieDetails['runtimeStr'] == ''
              ? "Stars: No info"
              : "Run Time: ${widget.movieDetails['runtimeStr']}"),
          Text(widget.movieDetails['imDbRating'] == ''
              ? "Stars: No info"
              : "IMDB Rating: ${widget.movieDetails['imDbRating']}"),
          Text(widget.movieDetails['imDbRatingVotes'] == ''
              ? "Stars: No info"
              : "IMDB Rating Votes: ${widget.movieDetails['imDbRatingVotes']}"),
          Text(widget.movieDetails['stars'] == ''
              ? "Stars: No info"
              : "Stars: ${widget.movieDetails['stars']}"),
          Text(widget.movieDetails['genres'] == ''
              ? "Stars: No info"
              : "Genres: ${widget.movieDetails['genres']}"),
        ],
      ),
    );
  }
}
