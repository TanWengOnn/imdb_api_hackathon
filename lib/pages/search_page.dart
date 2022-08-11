import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';
import 'package:imdb_api_hackathon/states/search_cubit.dart';
import 'package:imdb_api_hackathon/widgets/movie_search_list.dart';
import 'package:imdb_api_hackathon/widgets/skeleton_search_loading.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<bool> _isTagSelected = [false, false, false, false, false, false];

  List genresList = [
    "Action",
    "Comedy",
    "Family",
    "Crime",
    "Fantasy",
    "Horror",
  ];
  String? movieGenres = '';

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SearchCubit cubit = BlocProvider.of<SearchCubit>(context);

    void searchButton({String? title, String? genres}) {
      cubit.fetchSearch(title: title, genres: genres);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: Theme.of(context).textTheme.headline1),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                TextField(
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    if (titleController.text.isNotEmpty || movieGenres != '') {
                      setState(() {
                        searchButton(
                            title: titleController.text, genres: movieGenres);
                      });
                    }
                  },
                  controller: titleController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: CupertinoColors.systemGrey6,
                    constraints: BoxConstraints(maxWidth: 371, maxHeight: 50),
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search Movies/Series",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Text('Select Genres:',
                style: Theme.of(context).textTheme.headline3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      scrollDirection: Axis.horizontal,
                      viewportFraction: 0.27,
                    ),
                    itemCount: genresList.length,
                    itemBuilder: (context, index, realIndex) {
                      return Row(
                        children: [
                          ElevatedButton(
                            onPressed: _isTagSelected[index]
                                ? null
                                : () {
                                    setState(() {
                                      if (!movieGenres!
                                          .contains(genresList[index])) {
                                        movieGenres = movieGenres! +
                                            "," +
                                            genresList[index];
                                      }
                                      if (movieGenres?.contains(
                                              "${genresList[index]}") ==
                                          true) {
                                        _isTagSelected[index] = true;
                                      }
                                    });
                                  },
                            child: Text(
                              genresList[index],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                                side: BorderSide(color: Colors.red.shade700),
                                shadowColor: Colors.red[700],
                                shape: StadiumBorder(),
                                primary: Colors.red[700],
                                fixedSize: Size(81, 25)),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty || movieGenres != '') {
                      setState(() {
                        searchButton(
                            title: titleController.text, genres: movieGenres);
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Text("Apply Selection ",
                          style: TextStyle(color: Colors.black)),
                      Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.white)),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    movieGenres = '';
                    _isTagSelected =
                        _isTagSelected.map<bool>((v) => false).toList();
                  });
                },
                child: Row(
                  children: [
                    Text("Reset Selection ",
                        style: TextStyle(color: Colors.black)),
                    Icon(Icons.refresh, color: Colors.blue),
                  ],
                ),
                style: ElevatedButton.styleFrom(primary: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            movieGenres == '' ? '' : "Genre(s) Selected: $movieGenres",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 10),
          BlocBuilder<SearchCubit, MoviesState>(
            bloc: cubit,
            builder: (context, state) {
              if ((titleController.text.isNotEmpty || movieGenres != '') &&
                  state is! MoviesInitial) {
                if (state is MoviesLoading) {
                  return SearchSkeletonLoading(height: 100, width: 80);
                }
                if (state is MoviesLoaded) {
                  return SearchMovieList(searchModel: state.movieModel);
                } else {
                  if (state is MoviesError) {
                    print(state.errorMessage);
                  }
                  return Text("invalid search");
                }
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
        ],
      ),
    );
  }
}
