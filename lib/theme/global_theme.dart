import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/theme/ThemeModal.dart';

class GlobalTheme {
  ThemeData globalTheme({required ThemeModal themeModal}) {
    return ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor:
            themeModal.isDark ? Colors.black : Colors.white,
        primaryColor: themeModal.isDark ? Colors.black : Colors.white,
        backgroundColor: themeModal.isDark ? Colors.black : Color(0xffF1F5FB),
        appBarTheme: themeModal.isDark
            ? AppBarTheme(
                elevation: 1,
                backgroundColor: Colors.black,
                iconTheme: IconThemeData(
                  color: Color(0xFFE53935),
                ))
            : AppBarTheme(
                elevation: 1,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(
                  color: Color(0xFFE53935),
                )),
        cardColor:
            themeModal.isDark ? Color.fromARGB(255, 43, 41, 41) : Colors.white,
        dividerColor: themeModal.isDark ? Colors.white : Colors.black,
        elevatedButtonTheme: themeModal.isDark
            ? ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.red.shade700),
                    shadowColor: Colors.red[700],
                    shape: StadiumBorder(),
                    primary: Colors.red[700],
                    fixedSize: Size(81, 25)))
            : ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.white,
                    shape: StadiumBorder(),
                    primary: Colors.white,
                    fixedSize: Size(81, 25))),
        textTheme: themeModal.isDark
            ? TextTheme(
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
            : TextTheme(
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
