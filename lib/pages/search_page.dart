import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/services/search_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/states/search_cubit.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';
import 'package:imdb_api_hackathon/widgets/movie_lists.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // late SearchModel data;

  // Future<void> getSearch() async {
  //   SearchService searchInstance = SearchService();
  //   data = await searchInstance.fetchSearchInformation("inception");
  // }

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

              // Use this in HomePage
              // GenresButton(label: "Comedy", searchButton: () {
              //   searchButton(title: titleController.text, genres: "comedy");
              // }),
              // GenresButton(label: "Action", searchButton: () {
              //   searchButton(title: titleController.text, genres: "action");
              // }),
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
          BlocBuilder<SearchCubit, MoviesState>(
            bloc: cubit,
            builder: (context, state) {
              if ((titleController.text.isNotEmpty || movieGenres != '') &&
                  state is! MoviesInitial) {
                if (state is MoviesLoading) {
                  return CircularProgressIndicator();
                }
                if (state is MoviesLoaded) {
                  return MovieList(searchModel: state.movieModel);
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

// ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemCount: state.searchModel.results.length,
//                     physics: ScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return Card(
//                         child: Container(
//                           child: Column(
//                             children: [
//                               Image.network("${state.searchModel.results.elementAt(index).image}", height: 20),
//                               Text("${state.searchModel.results.elementAt(index).title}"),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
