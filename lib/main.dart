import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/pages/movie_details_page.dart';
import 'package:imdb_api_hackathon/pages/search_page.dart';
import 'package:imdb_api_hackathon/states/cubits/cubit_action.dart';
import 'package:imdb_api_hackathon/states/cubits/cubit_comedy.dart';
import 'package:imdb_api_hackathon/states/cubits/cubit_crime.dart';
import 'package:imdb_api_hackathon/states/cubits/cubit_fantasy.dart';
import 'package:imdb_api_hackathon/states/cubits/cubit_homepage.dart';
import 'package:imdb_api_hackathon/states/cubits/cubit_horror.dart';
import 'package:imdb_api_hackathon/states/cubits/cubit_search.dart';
import 'package:imdb_api_hackathon/states/cubits/cubit_trailer.dart';
import 'package:imdb_api_hackathon/states/theme_state.dart';
import 'package:imdb_api_hackathon/states/cubits/cubit_theme.dart';
import 'package:imdb_api_hackathon/theme/global_theme.dart';

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
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  GlobalTheme globalTheme = GlobalTheme();

  @override
  Widget build(BuildContext context) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);

    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: themeCubit,
      builder: (context, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Roboto',
            theme: globalTheme.globalTheme(state: state),
            initialRoute: HomePage.route,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case HomePage.route:
                  return MaterialPageRoute(builder: (_) => const HomePage());
                case SearchPage.route:
                  return MaterialPageRoute(builder: (_) => const SearchPage());
                case DetailsPage.route:
                  DetailsPage data = settings.arguments as DetailsPage;
                  return MaterialPageRoute(
                      builder: (_) =>
                          DetailsPage(movieDetails: data.movieDetails));
              }
            });
      },
    );
  }
}
