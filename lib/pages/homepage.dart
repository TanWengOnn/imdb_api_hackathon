import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/homepage_cubit.dart';
import '../states/homepage_state.dart';
import '../widgets/movie_lists.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      appBar: AppBar(
          title: Text("IMDB", style: Theme.of(context).textTheme.headline1),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.1),
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/search");
              },
            ),
          ]),
=======
    HomepageCubit cubit = BlocProvider.of<HomepageCubit>(context)
      ..fetchHomepage('1,10');
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
          BlocBuilder<HomepageCubit, HomepageState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is HomepageLoading) {
                return CircularProgressIndicator();
              }
              if (state is HomepageLoaded &&
                  state.searchModel.results.isNotEmpty) {
                return MovieList(searchModel: state.searchModel);
              }
              return Text(state is HomepageError ? state.errorMessage : "");
            },
          ),
        ],
      ),
>>>>>>> 4e68139c05b2ebee5224f0468f2e00f744706feb
    );
  }
}
