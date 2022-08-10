import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/pages/movie_details_page.dart';
import 'package:imdb_api_hackathon/pages/search_page.dart';
import 'package:imdb_api_hackathon/states/action_cubit.dart';
import 'package:imdb_api_hackathon/states/comedy_cubit.dart';
import 'package:imdb_api_hackathon/states/crime_cubit.dart';
import 'package:imdb_api_hackathon/states/fantasy_cubit.dart';
import 'package:imdb_api_hackathon/states/homepage_cubit.dart';
import 'package:imdb_api_hackathon/states/horror_cubit.dart';
import 'package:imdb_api_hackathon/states/search_cubit.dart';
import 'package:imdb_api_hackathon/states/trailer_cubit.dart';

import 'pages/homepage.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => HomepageCubit(),
        ),
        BlocProvider(
          create: (context) => ComedyCubit(),
        ),
        BlocProvider(
          create: (context) => ActionCubit(),
        ),
        BlocProvider(
          create: (context) => FantasyCubit(),
        ),
        BlocProvider(
          create: (context) => HorrorCubit(),
        ),
        BlocProvider(
          create: (context) => CrimeCubit(),
        ),
        BlocProvider(
          create: (context) => TrailerCubit(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          //brightness: Brightness.dark,
          primaryColor: Colors.white,
          fontFamily: 'Open Sans',
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 25,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
            headline2: TextStyle(
                fontSize: 25,
                color: Colors.deepOrange,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
            headline3: TextStyle(
                fontSize: 20,
                color: Colors.red,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
            headline4: TextStyle(
                fontSize: 20,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
            headline5: TextStyle(
                fontSize: 15,
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
            headline6: TextStyle(
                fontSize: 15,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
            subtitle1: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => HomePage());
            case '/search':
              return MaterialPageRoute(builder: (_) => SearchPage());
            case '/details-page':
              DetailsPage data = settings.arguments as DetailsPage;
              return MaterialPageRoute(
                  builder: (_) => DetailsPage(movieDetails: data.movieDetails));
          }
        });
  }
}
