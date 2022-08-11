import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/pages/movie_details_page.dart';

class SearchMovieList extends StatelessWidget {
  const SearchMovieList({Key? key, required this.searchModel})
      : super(key: key);

  final MovieModel searchModel;
  static const IMAGE_BORDER_RADIUS = 15.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: searchModel.results.length,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return cardGesture(context, index);
            },
          ),
        ),
      ],
    );
  }

  Widget cardGesture(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        navigateToDetailPage(context, index);
      },
      child: searchMovieCard(context, index),
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

  Widget searchMovieCard(BuildContext context, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(IMAGE_BORDER_RADIUS),
      ),
      // elevation: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(IMAGE_BORDER_RADIUS),
            child: Image.network(
              searchModel.results.elementAt(index).image,
              fit: BoxFit.fill,
              height: 100,
              width: 80,
            ),
          ),
          const SizedBox(width: 50),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${searchModel.results.elementAt(index).title} ',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 25.0,
                    ),
                    Text(
                        searchModel.results.elementAt(index).imDbRating == ''
                            ? "N/A"
                            : "${searchModel.results.elementAt(index).imDbRating}/10",
                        style: const TextStyle(color: Colors.black)),
                  ],
                ),
                const SizedBox(height: 5),
                Text(searchModel.results.elementAt(index).genres),
              ],
            ),
          )
        ],
      ),
    );
  }
}
