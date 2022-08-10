import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';
import 'package:imdb_api_hackathon/states/search_cubit.dart';
import 'package:imdb_api_hackathon/widgets/movie_lists.dart';
import 'package:imdb_api_hackathon/widgets/search_movie_list.dart';

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

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  late TextEditingController _controller;
  List<bool> _isTagSelected = [false, false, false, false, false, false];

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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Search", style: Theme.of(context).textTheme.headline2),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
            padding: EdgeInsets.only(bottom: 10),
            margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
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
                    fillColor: Colors.white,
                    constraints: BoxConstraints(maxWidth: 380),
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search Movies/Series",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text('Select Genres:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: genresList.length,
                  padding: EdgeInsets.all(2),
                  itemBuilder: (context, index) {
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
                          child: Text(genresList[index]),
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: Colors.indigo[600]),
                        ),
                        SizedBox(width: 5),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 5),
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
                      Text("Apply Selection"),
                      Icon(Icons.done),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigoAccent[700])),
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
                    Text("Reset Selection"),
                    Icon(Icons.refresh),
                  ],
                ),
                style:
                    ElevatedButton.styleFrom(primary: Colors.indigoAccent[700]),
              ),
            ],
          ),
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
                  return CircularProgressIndicator();
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
