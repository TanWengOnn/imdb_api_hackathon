// ignore_for_file: constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/pages/movie_details_page.dart';

class MovieList extends StatelessWidget {
  const MovieList({Key? key, required this.searchModel}) : super(key: key);

  final MovieModel searchModel;
  static const double MAIN_POSTER_HEIGHT = 280;
  static const double MAIN_POSTER_WIDTH = MAIN_POSTER_HEIGHT / 4.0 * 3;
  static const double HEIGHT = 340;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HEIGHT,
      // child: ListView.builder(
      child: CarouselSlider.builder(
        options: CarouselOptions(
            height: HEIGHT,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 1500),
            autoPlayInterval: const Duration(milliseconds: 3200)),
        itemCount: searchModel.results.length,
        itemBuilder: (context, index, realIndex) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () {
                navigateToDetailPage(context, index);
              },
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                elevation: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        searchModel.results.elementAt(index).image,
                        fit: BoxFit.fill,
                        height: MAIN_POSTER_HEIGHT,
                        width: MAIN_POSTER_WIDTH,
                      ),
                    ),
                    Text(
                        '${searchModel.results.elementAt(index).title} '
                        '${searchModel.results.elementAt(index).description}',
                        style: Theme.of(context).textTheme.headline3),
                    Text(
                        '${searchModel.results.elementAt(index).genres} '
                        '• ${searchModel.results.elementAt(index).runtimeStr}',
                        style: Theme.of(context).textTheme.subtitle1),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget cardGesture(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        navigateToDetailPage(context, index);
      },
      child: mainMovieCard(context, index),
    );
  }

  void navigateToDetailPage(BuildContext context, int index) {
    Navigator.pushNamed(context, DetailsPage.route,
        arguments:
            DetailsPage(movieDetails: searchModel.results.elementAt(index)));
  }

  Widget mainMovieCard(BuildContext context, int index) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              searchModel.results.elementAt(index).image,
              fit: BoxFit.fill,
              height: MAIN_POSTER_HEIGHT,
              width: MAIN_POSTER_WIDTH,
            ),
          ),
          Text(
              '${searchModel.results.elementAt(index).title} '
              '${searchModel.results.elementAt(index).description}',
              style: Theme.of(context).textTheme.subtitle1),
          Text(
            '${searchModel.results.elementAt(index).genres} '
            '• ${searchModel.results.elementAt(index).runtimeStr}',
          ),
        ],
      ),
    );
  }
}
