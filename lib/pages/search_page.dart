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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Search", style: Theme.of(context).textTheme.headline1),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(
          color: Color(0xFFE53935),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        children: [
          searchBox(searchButton),
          const SizedBox(height: 10),
          const Text('Select Genres:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          scrollableGenreButtons(),
          Row(
            children: [
              applySelectionButton(searchButton),
              const SizedBox(width: 10),
              resetSelectionButton(),
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
              return getMovieListInfo(state);
            },
          ),
        ],
      ),
    );
  }

  Widget searchBox(Function searchButton) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 10),
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
    );
  }

  Widget scrollableGenreButtons() {
    return Row(
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
                                if (!movieGenres!.contains(genresList[index])) {
                                  movieGenres =
                                      // ignore: prefer_interpolation_to_compose_strings
                                      "${movieGenres!}," + genresList[index];
                                }
                                if (movieGenres
                                        ?.contains("${genresList[index]}") ==
                                    true) {
                                  _isTagSelected[index] = true;
                                }
                              });
                            },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: Colors.white,
                          fixedSize: const Size(81, 25)),
                      child: Text(
                        genresList[index],
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget applySelectionButton(Function searchButton) {
    return ElevatedButton(
        onPressed: () {
          if (titleController.text.isNotEmpty || movieGenres != '') {
            setState(() {
              searchButton(title: titleController.text, genres: movieGenres);
            });
          }
        },
        style: ElevatedButton.styleFrom(primary: Colors.white),
        child: Row(
          children: const [
            Text("Apply Selection ", style: TextStyle(color: Colors.black)),
            Icon(
              Icons.done,
              color: Colors.green,
            ),
          ],
        ));
  }

  Widget resetSelectionButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          movieGenres = '';
          _isTagSelected = _isTagSelected.map<bool>((v) => false).toList();
        });
      },
      child: Row(
        children: [
          Text("Reset Selection ", style: TextStyle(color: Colors.black)),
          Icon(Icons.refresh, color: Colors.blue),
        ],
      ),
      style: ElevatedButton.styleFrom(primary: Colors.white),
    );
  }

  Widget getMovieListInfo(MoviesState state) {
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
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
}
