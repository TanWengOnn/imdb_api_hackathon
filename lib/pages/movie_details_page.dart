import 'dart:ui' as ui;

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
      print(widget.movieDetails['id']);
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
        title:
            Text("Movie Details", style: Theme.of(context).textTheme.headline2),
        backgroundColor: Colors.white,
        elevation: 5,
        iconTheme: IconThemeData(
          color: Colors.orangeAccent,
        ),
      ),
      body: ListView(
        children: [
          Stack(
            //fit: StackFit.expand,
            children: [
              Image.network(widget.movieDetails['image'],
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height + 50),
              BackdropFilter(
                filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: new Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Image.network(
                      widget.movieDetails['image'],
                      height: 420,
                      width: 380,
                    ),
                    Text(
                        widget.movieDetails['genres'] == ''
                            ? ""
                            : "${widget.movieDetails['genres']}",
                        style: Theme.of(context).textTheme.headline6),
                    Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.5)),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                    widget.movieDetails['title'] == ''
                                        ? "Unknown"
                                        : "${widget.movieDetails['title']}",
                                    style:
                                        Theme.of(context).textTheme.headline1),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 25.0,
                              ),
                              Text(
                                  widget.movieDetails['imDbRating'] == ''
                                      ? "N/A"
                                      : "${widget.movieDetails['imDbRating']}/10",
                                  style: Theme.of(context).textTheme.headline6),
                            ],
                          ),
                          //Text('${movieDetails['description'].toString().substring(1,5)} • ${movieDetails['contentRating']} • ${movieDetails['runtimeStr']}',
                          Text(
                              '${widget.movieDetails['description'] == '' ? 'N/A' : widget.movieDetails['description']} • '
                              '${widget.movieDetails['contentRating'] == '' ? 'N/A' : widget.movieDetails['contentRating']} • '
                              '${widget.movieDetails['runtimeStr'] == '' ? 'N/A' : widget.movieDetails['runtimeStr']} • ',
                              style: Theme.of(context).textTheme.headline6),

                          SizedBox(height: 10),
                          Text(
                              widget.movieDetails['plot'] == ''
                                  ? "No info"
                                  : "${widget.movieDetails['plot']}",
                              style: Theme.of(context).textTheme.headline6),
                          const Divider(
                            height: 20,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            color: Colors.white,
                          ),
                          Text('Cast',
                              style: Theme.of(context).textTheme.headline4),
                          SizedBox(height: 10),
                          Text(
                              widget.movieDetails['stars'] == ''
                                  ? "Unknown"
                                  : "${widget.movieDetails['stars']}",
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}