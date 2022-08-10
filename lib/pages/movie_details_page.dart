import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:imdb_api_hackathon/models/movie_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.movieDetails}) : super(key: key);
  final Map movieDetails;
  
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
              Image.network(
                movieDetails['image'],
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height,
              ),
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
                    Image.network(movieDetails['image'],height: 420, width: 380,),
                    Text(movieDetails['genres'] == ''? "" : "${movieDetails['genres']}",
                    style: Theme.of(context).textTheme.headline6),
                    Container(
                     decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
                     padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                    movieDetails['title'] == ''
                                        ? "Unknown"
                                        : "${movieDetails['title']}",
                                    style:
                                        Theme.of(context).textTheme.headline1),
                              ),
                              Icon( Icons.star,color: Colors.yellow,size: 25.0,),
                              Text(
                                  movieDetails['imDbRating'] == ''
                                      ? "Stars: No info"
                                      : "${movieDetails['imDbRating']}/10",
                                  style: Theme.of(context).textTheme.headline6),
                            ],
                          ),
                         //Text('${movieDetails['description'].toString().substring(1,5)} • ${movieDetails['contentRating']} • ${movieDetails['runtimeStr']}',
                         Text('${movieDetails['description']} • ${movieDetails['contentRating']} • ${movieDetails['runtimeStr']}',
                         style: Theme.of(context).textTheme.headline6),
                              
                          SizedBox(height: 10),
                          Text(
                              movieDetails['plot'] == ''
                                  ? "No info"
                                  : "${movieDetails['plot']}",
                              style: Theme.of(context).textTheme.headline6),
                          const Divider(height: 20,thickness: 1,indent: 0,endIndent: 0,color: Colors.white,),
                          Text('Cast',style: Theme.of(context).textTheme.headline4),
                          SizedBox(height: 10),
                          Text(
                              movieDetails['stars'] == ''
                                  ? "Unknown"
                                  : "${movieDetails['stars']}",
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

//  Image.network("${movieDetails['image']}", height: 20),
//           Text(movieDetails['title'] == '' ? "Stars: No info" : "Title: ${movieDetails['title']}"),
//           Text(movieDetails['plot'] == '' ? "Stars: No info" : "Plot: ${movieDetails['plot']}"),
//           Text(movieDetails['description'] == '' ? "Stars: No info" : "Description: ${movieDetails['description']}"),
//           Text(movieDetails['contentRating'] == '' ? "Stars: No info" : "Content Rating: ${movieDetails['contentRating']}"),
//           Text(movieDetails['runtimeStr'] == '' ? "Stars: No info" : "Run Time: ${movieDetails['runtimeStr']}"),
//           Text(movieDetails['imDbRating'] == '' ? "Stars: No info" : "IMDB Rating: ${movieDetails['imDbRating']}"),
//           Text(movieDetails['imDbRatingVotes'] == '' ? "Stars: No info" : "IMDB Rating Votes: ${movieDetails['imDbRatingVotes']}"),
//           Text(movieDetails['stars'] == '' ? "Stars: No info" : "Stars: ${movieDetails['stars']}"),
//           Text(movieDetails['genres'] == '' ? "Stars: No info" : "Genres: ${movieDetails['genres']}"),