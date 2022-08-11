import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';
import 'package:imdb_api_hackathon/states/search_cubit.dart';
import 'package:imdb_api_hackathon/widgets/movie_search_list.dart';
import 'package:imdb_api_hackathon/widgets/skeleton_search_loading.dart';

class SearchPage extends StatefulWidget {
  static const String route = '/search';

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
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                TextField(
                  style: const TextStyle(color: Colors.black),
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
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 20, thickness: 1, indent: 0, endIndent: 0),
          const SizedBox(height: 10),
          Text('Select Genres:', style: Theme.of(context).textTheme.subtitle1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      scrollDirection: Axis.horizontal,
                      viewportFraction: 0.25,
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
                                        movieGenres =
                                            "${movieGenres!},${genresList[index]}";
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
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
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
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    fixedSize: const Size(170, 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      Text("Apply Selection ",
                          style: Theme.of(context).textTheme.headline6),
                      const Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                    ],
                  )),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    movieGenres = '';
                    _isTagSelected =
                        _isTagSelected.map<bool>((v) => false).toList();
                  });
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    fixedSize: const Size(170, 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: Row(
                  children: [
                    Text("Reset Selection ",
                        style: Theme.of(context).textTheme.headline6),
                    const Icon(Icons.refresh, color: Colors.blue),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            movieGenres == '' ? '' : "Genre(s) Selected: $movieGenres",
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          BlocBuilder<SearchCubit, MoviesState>(
            bloc: cubit,
            builder: (context, state) {
              if ((titleController.text.isNotEmpty || movieGenres != '') &&
                  state is! MoviesInitial) {
                if (state is MoviesLoading) {
                  return SearchSkeletonLoading(height: 100, width: 80);
                }
                if (state is MoviesLoaded) {
                  if (state.movieModel.results.toString() == "[]") {
                    return Center(
                        child: Text(
                      "Invalid Search",
                      style: Theme.of(context).textTheme.headline3,
                    ));
                  }
                  return SearchMovieList(searchModel: state.movieModel);
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
