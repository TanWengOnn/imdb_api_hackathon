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
import 'package:imdb_api_hackathon/theme/cubit_state_theme.dart';
import 'package:imdb_api_hackathon/theme/cubit_theme.dart';
import 'package:imdb_api_hackathon/theme/global_theme.dart';
import 'package:provider/provider.dart';
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
            //theme: themeModal.isDark ? ThemeData.dark() : ThemeData.light(),
            theme: globalTheme.globalTheme(themeModal: state),
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
              // return null;
            });
      },
      // create: (_) => ThemeModal(),
      // child: Consumer(builder: (context, ThemeModal themeModal, child) {
      //   return MaterialApp(
      //       debugShowCheckedModeBanner: false,
      //       title: 'Roboto',
      //       //theme: themeModal.isDark ? ThemeData.dark() : ThemeData.light(),
      //       theme: globalTheme.globalTheme(themeModal: themeModal),
      //       initialRoute: HomePage.route,
      //       onGenerateRoute: (settings) {
      //         switch (settings.name) {
      //           case HomePage.route:
      //             return MaterialPageRoute(builder: (_) => const HomePage());
      //           case SearchPage.route:
      //             return MaterialPageRoute(
      //                 builder: (_) => const SearchPage());
      //           case DetailsPage.route:
      //             DetailsPage data = settings.arguments as DetailsPage;
      //             return MaterialPageRoute(
      //                 builder: (_) =>
      //                     DetailsPage(movieDetails: data.movieDetails));
      //         }
      //         // return null;
      //       });
      // })
    );
  }
}
