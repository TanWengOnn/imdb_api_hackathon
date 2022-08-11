import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/pages/movie_details_page.dart';

class SearchMovieList extends StatelessWidget {
  const SearchMovieList({Key? key, required this.searchModel})
      : super(key: key);

  final MovieModel searchModel;

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
        arguments:
            DetailsPage(movieDetails: searchModel.results.elementAt(index)));
  }

  Widget searchMovieCard(BuildContext context, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      // elevation: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
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
