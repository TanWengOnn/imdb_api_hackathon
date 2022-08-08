import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/pages/search_page.dart';
import 'package:imdb_api_hackathon/states/search_cubit.dart';
import 'pages/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
      BlocProvider(
        create: (context) => SearchCubit(),
        child: MyApp(),
      )
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
          switch(settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => HomePage());
            case '/search':
              return MaterialPageRoute(builder: (_) => SearchPage());
          }
        }
    );
  }
}
