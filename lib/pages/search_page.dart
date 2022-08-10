import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';
import 'package:imdb_api_hackathon/states/search_cubit.dart';
import 'package:imdb_api_hackathon/widgets/search_movie_list.dart';
import 'package:imdb_api_hackathon/widgets/skeleton_search_loading.dart';

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
    "Horror",
  ];
  String? movieGenres = '';

  @override
  Widget build(BuildContext context) {
    SearchCubit cubit = BlocProvider.of<SearchCubit>(context);

    void searchButton({String? title, String? genres}) {
      cubit.fetchSearch(title: title, genres: genres);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Search", style: Theme.of(context).textTheme.headline1),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(
          color: Color(0xFFE53935),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
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
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: Colors.white,
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
