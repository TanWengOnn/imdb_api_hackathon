import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/states/action_cubit.dart';
import 'package:imdb_api_hackathon/states/comedy_cubit.dart';
import 'package:imdb_api_hackathon/states/crime_cubit.dart';
import 'package:imdb_api_hackathon/states/fantasy_cubit.dart';
import 'package:imdb_api_hackathon/states/horror_cubit.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';
import 'package:imdb_api_hackathon/widgets/home_genre_button.dart';
import 'package:imdb_api_hackathon/states/homepage_cubit.dart';
import 'package:imdb_api_hackathon/widgets/movie_category_list.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';
import 'package:imdb_api_hackathon/widgets/movie_lists.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomepageCubit homepageCubit;
  late final ComedyCubit comedyCubit;
  late final ActionCubit actionCubit;
  late final FantasyCubit fantasyCubit;
  late final HorrorCubit horrorCubit;
  late final CrimeCubit crimeCubit;

  @override
  void initState() {
    super.initState();
    homepageCubit = BlocProvider.of<HomepageCubit>(context)..fetchHomepage(moviemeter: '1,10');
    comedyCubit = BlocProvider.of<ComedyCubit>(context)..fetchComedy(genres: 'Comedy', count: '10');
    actionCubit = BlocProvider.of<ActionCubit>(context)..fetchAction(genres: 'Action', count: '10');
    fantasyCubit = BlocProvider.of<FantasyCubit>(context)..fetchFantasy(genres: 'Fantasy', count: '10');
    horrorCubit = BlocProvider.of<HorrorCubit>(context)..fetchHorror(genres: 'Horror', count: '10');
    crimeCubit = BlocProvider.of<CrimeCubit>(context)..fetchCrime(genres: 'Crime', count: '10');
  }

  @override
  Widget build(BuildContext context) {
  
    // void genresButton({String? genres, String? moviemeter}) {
    //   cubit.fetchHomepage(genres: genres, moviemeter: moviemeter, count: "10");
    // }
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies", style: Theme.of(context).textTheme.headline2),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
            color: Colors.black,
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        children: [
          
          Text('Top 10 Movies/Series',
              style: Theme.of(context).textTheme.headline3),
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
          SizedBox(
            height: 8,
          ),
          Text("Comedy", style: Theme.of(context).textTheme.headline3),
          BlocBuilder<ComedyCubit, MoviesState>(
            bloc: comedyCubit,
            builder: (context, state) {
              if (state is MoviesLoading) {
                return CircularProgressIndicator();
              }
              if (state is MoviesLoaded &&
                  state.movieModel.results.isNotEmpty) {
                return MovieCategoryList(searchModel: state.movieModel);
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
          Text("Action"),
          BlocBuilder<ActionCubit, MoviesState>(
            bloc: actionCubit,
            builder: (context, state) {
              if (state is MoviesLoading) {
                return CircularProgressIndicator();
              }
              if (state is MoviesLoaded &&
                  state.movieModel.results.isNotEmpty) {
                return MovieCategoryList(searchModel: state.movieModel);
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
          Text("Fantasy"),
          BlocBuilder<FantasyCubit, MoviesState>(
            bloc: fantasyCubit,
            builder: (context, state) {
              if (state is MoviesLoading) {
                return CircularProgressIndicator();
              }
              if (state is MoviesLoaded &&
                  state.movieModel.results.isNotEmpty) {
                return MovieCategoryList(searchModel: state.movieModel);
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
          Text("Horror"),
          BlocBuilder<HorrorCubit, MoviesState>(
            bloc: horrorCubit,
            builder: (context, state) {
              if (state is MoviesLoading) {
                return CircularProgressIndicator();
              }
              if (state is MoviesLoaded &&
                  state.movieModel.results.isNotEmpty) {
                return MovieCategoryList(searchModel: state.movieModel);
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
          Text("Crime"),
          BlocBuilder<CrimeCubit, MoviesState>(
            bloc: crimeCubit,
            builder: (context, state) {
              if (state is MoviesLoading) {
                return CircularProgressIndicator();
              }
              if (state is MoviesLoaded &&
                  state.movieModel.results.isNotEmpty) {
                return MovieCategoryList(searchModel: state.movieModel);
              }
              return Text(state is MoviesError ? state.errorMessage : "");
            },
          ),
        ],
      ),
    );
  }
}
