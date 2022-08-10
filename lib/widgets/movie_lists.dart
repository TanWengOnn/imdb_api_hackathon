import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/pages/movie_details_page.dart';
import 'package:imdb_api_hackathon/pages/homepage.dart';

class MovieList extends StatelessWidget {
  MovieList({Key? key, required this.searchModel}) : super(key: key);

  final MovieModel searchModel;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: searchModel.results.length,
        physics: ScrollPhysics(),
      
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/details-page",
                  arguments: DetailsPage(movieDetails: {
                    'title': searchModel.results.elementAt(index).title,
                    'image': searchModel.results.elementAt(index).image,
                    'plot': searchModel.results.elementAt(index).plot,
                    'description':
                        searchModel.results.elementAt(index).description,
                    'contentRating':
                        searchModel.results.elementAt(index).contentRating,
                    'runtimeStr':
                        searchModel.results.elementAt(index).runtimeStr,
                    'imDbRating':
                        searchModel.results.elementAt(index).imDbRating,
                    'imDbRatingVotes': searchModel.results
                        .elementAt(index)
                        .imDbRatingVotes,
                    'stars': searchModel.results.elementAt(index).stars,
                    'genres': searchModel.results.elementAt(index).genres,
                    // 'genreList': searchModel.results.elementAt(index).genreList,
                    // 'starList': searchModel.results.elementAt(index).starList,
                  }));
            },
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              elevation: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      searchModel.results.elementAt(index).image,
                      fit: BoxFit.fill,
                      height: 290,
                      width: 220,
                    ),
                    Text(
                        '${searchModel.results.elementAt(index).title} ${searchModel.results.elementAt(index).description}'),
                    Text(
                        '${searchModel.results.elementAt(index).genres} • ${searchModel.results.elementAt(index).runtimeStr}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
