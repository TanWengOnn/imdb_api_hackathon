import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/widgets/home_genre_button.dart';
import '../states/homepage_cubit.dart';
import '../states/homepage_state.dart';
import '../widgets/movie_lists.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List genresList = [
    "Action",
    "Comedy",
    "Family",
    "Crime",
    "Fantasy",
    "Horror"
  ];
  String movieGenres = 'Top 10 Movies/Series';
  late HomepageCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<HomepageCubit>(context)
      ..fetchHomepage(moviemeter: '1,10');
  }


  @override
  Widget build(BuildContext context) {
  
    void genresButton({String? genres, String? moviemeter}) {
      cubit.fetchHomepage(genres: genres, moviemeter: moviemeter, count: "10");
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Center(
            child: ElevatedButton.icon(
              label: Text("Search"),
              onPressed: () {
                Navigator.pushNamed(context, "/search");
              },
              icon: Icon(Icons.search),
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
                    return HomeGenresButton(
                        label: genresList[index],
                        genresButton: () {
                          genresButton(genres: genresList[index]);
                          setState(() {
                            movieGenres = genresList[index];
                          });
                        }
                      );
                  },
                ),
              ),
            ],
          ),
          HomeGenresButton(
              label: "Home",
              genresButton: () {
                genresButton(moviemeter: '1,10');
                setState(() {
                  movieGenres = 'Top 10 Movies/Series';
                });
              }
          ),
          Text(movieGenres),
          BlocBuilder<HomepageCubit, HomepageState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is HomepageLoading) {
                return CircularProgressIndicator();
              }
              if (state is HomepageLoaded &&
                  state.searchModel.results.isNotEmpty) {
                return MovieList(searchModel: state.searchModel);
              }
              return Text(state is HomepageError ? state.errorMessage : "");
            },
          ),
        ],
      ),
    );
  }
}
