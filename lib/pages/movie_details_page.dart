// ignore_for_file: constant_identifier_names

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/states/cubits/cubit_trailer.dart';
import 'package:imdb_api_hackathon/states/trailer_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsPage extends StatefulWidget {
  static const String route = '/details-page';

  const DetailsPage({Key? key, required this.movieDetails}) : super(key: key);
  final Result movieDetails;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final TrailerCubit trailerCubit;
  late YoutubePlayerController _controller;

  static const double TRAILER_HEIGHT = 300;
  static const double TRAILER_WIDTH = TRAILER_HEIGHT / 3.0 * 4;
  static const double BOTTOM_EXTRA_HEIGHT = 200;
  static const double POSTER_HEIGHT = 360;
  static const double POSTER_WIDTH = POSTER_HEIGHT / 4.0 * 3;

  static const double NORMAL_SPACE = 10;
  static const double BELOW_TITLE_SPACE = 15;

  @override
  void initState() {
    super.initState();

    trailerCubit = BlocProvider.of<TrailerCubit>(context)
      ..fetchTrailer(movieID: widget.movieDetails.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Movie Details", style: Theme.of(context).textTheme.headline1),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Image.network(widget.movieDetails.image,
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
                        stops: const [0.15, 0.75],
                        colors: [Colors.black.withOpacity(0.5), Colors.black]),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: BELOW_TITLE_SPACE),
                    Image.network(
                      widget.movieDetails.image,
                      height: POSTER_HEIGHT,
                      width: POSTER_WIDTH,
                    ),
                    const SizedBox(height: NORMAL_SPACE),
                    BlocBuilder<TrailerCubit, TrailerState>(
                      bloc: trailerCubit,
                      builder: (context, state) {
                        return getTrailerInfo(state);
                      },
                    ),
                    const SizedBox(height: NORMAL_SPACE),
                    Text(widget.movieDetails.genres,
                        style: Theme.of(context).textTheme.subtitle2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: NORMAL_SPACE),
                        Row(
                          children: [
                            Expanded(
                              child: Text(widget.movieDetails.title,
                                  style: Theme.of(context).textTheme.headline1),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 25.0,
                            ),
                            Text("${widget.movieDetails.imDbRating}/10",
                                style: Theme.of(context).textTheme.headline5),
                          ],
                        ),
                        Text(
                            '${widget.movieDetails.description} • '
                            '${widget.movieDetails.contentRating} • '
                            '${widget.movieDetails.runtimeStr}',
                            style: Theme.of(context).textTheme.subtitle2),
                        const SizedBox(height: NORMAL_SPACE),
                        const Text(
                          "Plot Summary",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: BELOW_TITLE_SPACE),
                        Text(
                          widget.movieDetails.plot,
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: NORMAL_SPACE),
                        const Divider(
                          height: 20,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          color: Colors.white,
                        ),
                        const Text('Cast',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: BELOW_TITLE_SPACE),
                        Text(widget.movieDetails.stars,
                            style: Theme.of(context).textTheme.headline5),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getTrailerInfo(TrailerState state) {
    if (state is TrailerLoading) {
      return const CircularProgressIndicator();
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
        label: const Text("Trailer"),
        icon: const Icon(Icons.play_arrow),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          primary: const ui.Color(0xFFE53935),
          fixedSize: const Size(100, 40),
        ),
      );
    }

    return Text(state is TrailerError ? state.errorMessage : "");
  }

  Widget youtube(String trailerId) {
    _controller = YoutubePlayerController(
      initialVideoId: trailerId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: TRAILER_WIDTH,
        height: TRAILER_HEIGHT,
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }
}
