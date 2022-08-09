import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/states/search_cubit.dart';
import 'package:imdb_api_hackathon/states/search_state.dart';
import 'package:imdb_api_hackathon/widgets/movie_lists.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController titleController = TextEditingController();
  List genresList = [
    "Action",
    "Comedy",
    "Family",
    "Crime",
    "Fantasy",
    "Horror"
  ];
  String? movieGenres = '';

  @override
  Widget build(BuildContext context) {
    SearchCubit cubit = BlocProvider.of<SearchCubit>(context);

    void searchButton({String? title, String? genres}) {
      cubit.fetchSearch(title: title, genres: genres);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          TextField(
            controller: titleController,
          ),
          Text(
            movieGenres == '' ? '' : "Genres: $movieGenres",
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty || movieGenres != '') {
                  setState(() {
                    searchButton(
                        title: titleController.text, genres: movieGenres);
                  });
                }
              },
              child: Text("Search"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: genresList.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (!movieGenres!.contains(genresList[index])) {
                            movieGenres =
                                movieGenres! + ',' + genresList[index];
                          }
                        });
                      },
                      child: Text(genresList[index]),
                    );
                  },
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                movieGenres = '';
              });
            },
            child: Text("Clear"),
          ),
          BlocBuilder<SearchCubit, SearchState>(
            bloc: cubit,
            builder: (context, state) {
              if (titleController.text.isNotEmpty || movieGenres != '') {
                if (state is SearchLoading) {
                  return CircularProgressIndicator();
                }
                if (state is SearchLoaded) {
                  return MovieList(searchModel: state.searchModel);
                } else {
                  return Text("invalid search");
                }
              }
              return Text(state is SearchError ? state.errorMessage : "");
            },
          ),
        ],
      ),
    );
  }
}
