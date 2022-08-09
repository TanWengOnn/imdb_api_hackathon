import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/pages/movie_details_page.dart';
import 'package:imdb_api_hackathon/pages/search_page.dart';
import 'package:imdb_api_hackathon/states/action_cubit.dart';
import 'package:imdb_api_hackathon/states/comedy_cubit.dart';
import 'package:imdb_api_hackathon/states/crime_cubit.dart';
import 'package:imdb_api_hackathon/states/fantasy_cubit.dart';
import 'package:imdb_api_hackathon/states/homepage_cubit.dart';
import 'package:imdb_api_hackathon/states/horror_cubit.dart';
import 'package:imdb_api_hackathon/states/search_cubit.dart';

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
          primarySwatch: Colors.blue,
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
              return MaterialPageRoute(builder: (_) => DetailsPage(movieDetails: data.movieDetails));
          }
        });
  }
}
