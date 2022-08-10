import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/states/trailer_cubit.dart';
import 'package:imdb_api_hackathon/states/trailer_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.movieDetails}) : super(key: key);
  final Map movieDetails;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final TrailerCubit trailerCubit;
  late YoutubePlayerController _controller;
  static const double TRAILER_HEIGHT = 300;
  static const double TRAILER_WIDTH = TRAILER_HEIGHT/3.0*4;
  static const double BOTTOM_EXTRA_HEIGHT = 200 ;
  static const double POSTER_HEIGHT = 360;
  static const double POSTER_WIDTH = POSTER_HEIGHT/4.0*3;
  
  @override
  void initState() {
    super.initState();

    trailerCubit = BlocProvider.of<TrailerCubit>(context)
      ..fetchTrailer(movieID: widget.movieDetails['id']);
    print(widget.movieDetails['id']);
  }

// reference: https://github.com/Bytx-youtube/ytplayer/blob/main/lib/mainscreen.dart
// https://www.youtube.com/watch?v=feQhHStBVLE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Movie Details", style: Theme.of(context).textTheme.headline1),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(
          color: ui.Color(0xFFE53935),
        ),
      ),
      body: movieDetailsPage()
    );
  }

  Widget normalSpace() {
    return SizedBox(height: 10);
  }

  Widget spaceBelowTitle() {
    return SizedBox(height: 15);
  }

  Widget youtube(String trailerId) {
    _controller = YoutubePlayerController(
      initialVideoId: "$trailerId",
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: TRAILER_WIDTH,
        height: TRAILER_HEIGHT,
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }

  Widget movieDetailsPage() {
    return ListView(
      children: [
        Stack(
          children: [
            Image.network(widget.movieDetails['image'],
                fit: BoxFit.cover,
                height:
                    MediaQuery.of(context).size.height + BOTTOM_EXTRA_HEIGHT),
            BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            Container(
                height:
                    MediaQuery.of(context).size.height + BOTTOM_EXTRA_HEIGHT,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.15, 0.75],
                      colors: [Colors.black.withOpacity(0.5), Colors.black]),
                )),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  spaceBelowTitle(),
                  Image.network(
                    widget.movieDetails['image'],
                    height: POSTER_HEIGHT,
                    width: POSTER_WIDTH,
                  ),
                  
                  BlocBuilder<TrailerCubit, TrailerState>(
                    bloc: trailerCubit,
                    builder: (context, state) {
                      if (state is TrailerLoading) {
                        return CircularProgressIndicator();
                      }

                      if (state is TrailerLoaded) {
                        return ElevatedButton.icon(
                          onPressed: () {
                            youtube(state.trailerModel.videoId);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return youtube(state.trailerModel.videoId);
                              },
                            );
                          },
                          label: Text("Trailer"),
                          icon: Icon(Icons.play_arrow),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(ui.Color(0xFFE53935)),
                          ),
                        );
                      }
                      return Text(
                          state is TrailerError ? state.errorMessage : "");
                    },
                  ),
                  normalSpace(),
                  Text(widget.movieDetails['genres'],
                      style: Theme.of(context).textTheme.headline6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      normalSpace(),
                      Row(
                        children: [
                          Expanded(
                            child: Text('${widget.movieDetails['title']}',
                                style: Theme.of(context).textTheme.headline1),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 25.0,
                          ),
                          Text("${widget.movieDetails['imDbRating']}/10",
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                      Text(
                          '${widget.movieDetails['description']} • '
                          '${widget.movieDetails['contentRating']} • '
                          '${widget.movieDetails['runtimeStr']}',
                          style: Theme.of(context).textTheme.subtitle2),
                      normalSpace(),
                      Text("Plot Summary",
                          style: Theme.of(context).textTheme.headline4),
                      spaceBelowTitle(),
                      Text(widget.movieDetails['plot'],
                          style: Theme.of(context).textTheme.headline6),
                      normalSpace(),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.white,
                      ),
                      Text('Cast',
                          style: Theme.of(context).textTheme.headline4),
                      spaceBelowTitle(),
                      Text(widget.movieDetails['stars'],
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}