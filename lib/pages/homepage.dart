import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/states/comedy_cubit.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';
import 'package:imdb_api_hackathon/widgets/home_genre_button.dart';
import 'package:imdb_api_hackathon/states/homepage_cubit.dart';
import 'package:imdb_api_hackathon/widgets/movie_lists.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomepageCubit homepageCubit;
  late final ComedyCubit comedyCubit;

  @override
  void initState() {
    super.initState();
    homepageCubit = BlocProvider.of<HomepageCubit>(context)..fetchHomepage(moviemeter: '1,10');
    comedyCubit = BlocProvider.of<ComedyCubit>(context)..fetchComedy(genres: 'Comedy', count: '10');
  }


  @override
  Widget build(BuildContext context) {
  
    // void genresButton({String? genres, String? moviemeter}) {
    //   cubit.fetchHomepage(genres: genres, moviemeter: moviemeter, count: "10");
    // }
    
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
          Text('Top 10 Movies/Series'),
          BlocBuilder<HomepageCubit, MoviesState>(
            bloc: homepageCubit,
            builder: (context, state) {
              if (state is MoviesLoading) {
                return CircularProgressIndicator();
              }
              if (state is MoviesLoaded &&
                  state.movieModel.results.isNotEmpty) {
                return MovieList(searchModel: state.movieModel);
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
          Text("Comedy"),
          BlocBuilder<ComedyCubit, MoviesState>(
            bloc: comedyCubit,
            builder: (context, state) {
              if (state is MoviesLoading) {
                return CircularProgressIndicator();
              }
              if (state is MoviesLoaded &&
                  state.movieModel.results.isNotEmpty) {
                return MovieList(searchModel: state.movieModel);
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
        ],
      ),
    );
  }
}
