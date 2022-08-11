import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/theme/cubit_state_theme.dart';

class GlobalTheme {
  ThemeData globalTheme({required ThemeState state}) {
    return ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor:
            state.theme.isDark ? Colors.black : Colors.white,
        primaryColor: state.theme.isDark ? Colors.black : Colors.white,
        backgroundColor:
            state.theme.isDark ? Colors.black : const Color(0xffF1F5FB),
        appBarTheme: state.theme.isDark
            ? const AppBarTheme(
                elevation: 1,
                backgroundColor: Colors.black,
                iconTheme: IconThemeData(
                  color: Color(0xFFE53935),
                ))
            : const AppBarTheme(
                elevation: 1,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(
                  color: Color(0xFFE53935),
                )),
        cardColor: state.theme.isDark
            ? const Color.fromARGB(255, 43, 41, 41)
            : Colors.white,
        dividerColor: state.theme.isDark ? Colors.white : Colors.black,
        elevatedButtonTheme: state.theme.isDark
            ? ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.red.shade700),
                    shadowColor: Colors.red[700],
                    shape: const StadiumBorder(),
                    primary: Colors.red[700],
                    fixedSize: const Size(81, 25)))
            : ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.white,
                    shape: const StadiumBorder(),
                    primary: Colors.white,
                    fixedSize: const Size(81, 25))),
        textTheme: state.theme.isDark
            ? const TextTheme(
                //App title, used for all appbar title and details page movie title
                headline1: TextStyle(
                    fontSize: 25,
                    color: Color(0xFFE53935),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
                //sub title, used in homepage subtitle
                headline2: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFE53935),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600),
                //card title used in homepage movie list & search movie list
                headline3: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
                //search movie list genre
                headline4: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
                //only for movie details
                headline5: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
                //paragraph used in search page button text
                headline6: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
                //used in homepage genre & duration & category card rating
                subtitle1: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.none),
                //only for movie details genre
                subtitle2: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
              )
            : const TextTheme(
                //App title, used for all appbar title and details page movie title
                headline1: TextStyle(
                    fontSize: 25,
                    color: Color(0xFFE53935),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
                //sub title, used in homepage subtitle
                headline2: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFE53935),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600),
                //card title used in homepage movie list & search movie list
                headline3: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
                //search movie list genre
                headline4: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
                //only for movie details
                headline5: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
                //paragraph used in search page button text
                headline6: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
                //used in homepage genre & duration & category card rating
                subtitle1: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    decoration: TextDecoration.none),
                //only for movie details genre
                subtitle2: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal),
              ));
  }
}
