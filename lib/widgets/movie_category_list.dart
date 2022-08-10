import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/pages/movie_details_page.dart';

class MovieCategoryList extends StatelessWidget {
  const MovieCategoryList({Key? key, required this.searchModel})
      : super(key: key);

  final MovieModel searchModel;
  static const double CATEGORY_POSTER_HEIGHT = 180;
  static const double CATEGORY_POSTER_WIDTH = CATEGORY_POSTER_HEIGHT / 4.0 * 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
            CarouselSlider.builder(
            options: CarouselOptions(
              scrollPhysics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              viewportFraction: 0.33,
            ),
            itemCount: searchModel.results.length,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/details-page",
                      arguments: DetailsPage(movieDetails: {
                        'id': searchModel.results.elementAt(index).id,
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
                              Icon(Icons.star,color: Colors.yellow,size: 25.0,),
                          Text(searchModel.results.elementAt(index).imDbRating,
                            style: Theme.of(context).textTheme.subtitle1),
                            ],
                          ),
                      ],
                    ),
                ),
              );
            },
          ),
        
      ],
    );
  }
}
