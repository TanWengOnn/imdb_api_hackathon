// ignore_for_file: constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/pages/movie_details_page.dart';

class MovieCategoryList extends StatelessWidget {
  final MovieModel searchModel;
  static const double CATEGORY_POSTER_HEIGHT = 160;
  static const double CATEGORY_POSTER_WIDTH = CATEGORY_POSTER_HEIGHT / 4.0 * 3;

  const MovieCategoryList({Key? key, required this.searchModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            scrollPhysics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            viewportFraction: 0.35,
          ),
          itemCount: searchModel.results.length,
          itemBuilder: (context, index, realIndex) {
            return cardGesture(context, index);
          },
        ),
      ],
    );
  }

  Widget cardGesture(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        navigateToDetailPage(context, index);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: categoryMovieCard(context, index),
      ),
    );
  }

  void navigateToDetailPage(BuildContext context, int index) {
    Navigator.pushNamed(context, "/details-page",
        arguments: DetailsPage(movieDetails: {
          'id': searchModel.results.elementAt(index).id,
          'title': searchModel.results.elementAt(index).title,
          'image': searchModel.results.elementAt(index).image,
          'plot': searchModel.results.elementAt(index).plot,
          'description': searchModel.results.elementAt(index).description,
          'contentRating': searchModel.results.elementAt(index).contentRating,
          'runtimeStr': searchModel.results.elementAt(index).runtimeStr,
          'imDbRating': searchModel.results.elementAt(index).imDbRating,
          'imDbRatingVotes':
              searchModel.results.elementAt(index).imDbRatingVotes,
          'stars': searchModel.results.elementAt(index).stars,
          'genres': searchModel.results.elementAt(index).genres,
          // 'genreList': searchModel.results.elementAt(index).genreList,
          // 'starList': searchModel.results.elementAt(index).starList,
        }));
  }

  Widget categoryMovieCard(BuildContext context, int index) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              searchModel.results.elementAt(index).image,
              fit: BoxFit.fill,
              height: CATEGORY_POSTER_HEIGHT,
              width: CATEGORY_POSTER_WIDTH,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 25.0,
              ),
              Text(searchModel.results.elementAt(index).imDbRating,
                  style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ],
      ),
    );
  }
}
