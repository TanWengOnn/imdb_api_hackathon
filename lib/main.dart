import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/pages/movie_details_page.dart';
import 'package:imdb_api_hackathon/pages/search_page.dart';
import 'package:imdb_api_hackathon/states/homepage_cubit.dart';
import 'package:imdb_api_hackathon/states/search_cubit.dart';

import 'pages/homepage.dart';

void main() {
<<<<<<< HEAD
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => SearchCubit()),
    ],
    child: MyApp(),
  ));
=======
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => HomepageCubit(),
        ),
      ],
      child: MyApp(),
    ),
  );
>>>>>>> 4e68139c05b2ebee5224f0468f2e00f744706feb
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
<<<<<<< HEAD
          //brightness: Brightness.dark,
          primaryColor: Colors.white,
          fontFamily: 'Open Sans',
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 30,
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400),
            headline2: TextStyle(
                fontSize: 25,
                color: Colors.black,
                decoration: TextDecoration.none),
            headline3: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
            headline4: TextStyle(
                fontSize: 15,
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
          ),
=======
          primarySwatch: Colors.blue,
>>>>>>> 4e68139c05b2ebee5224f0468f2e00f744706feb
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
