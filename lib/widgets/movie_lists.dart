import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';

class MovieList extends StatelessWidget {
  const MovieList({Key? key, required this.searchModel}) : super(key: key);

  final MovieModel searchModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: searchModel.results.length,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            child: Row(
              children: [
                Image.network(searchModel.results.elementAt(index).image,
                    height: 150),
                Column(
                  children: [
                    Text(searchModel.results.elementAt(index).title),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
