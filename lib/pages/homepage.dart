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
    HomepageCubit cubit = BlocProvider.of<HomepageCubit>(context)
      ..fetchHomepage('1,10');
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies", style: Theme.of(context).textTheme.headline2),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
            icon: const Icon(Icons.search),
            color: Colors.black,
          )
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 10,
          ),
          Text('Top 10 Movies/Series',
              style: Theme.of(context).textTheme.headline3),
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
    );
  }
}
