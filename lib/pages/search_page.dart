import 'package:flutter/material.dart';
import 'package:imdb_api_hackathon/models/search_model.dart';
import 'package:imdb_api_hackathon/services/search_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/states/search_cubit.dart';
import 'package:imdb_api_hackathon/states/search_state.dart';
import 'package:imdb_api_hackathon/widgets/movie_lists.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // late SearchModel data;

  // Future<void> getSearch() async {
  //   SearchService searchInstance = SearchService();
  //   data = await searchInstance.fetchSearchInformation("inception");
  // }

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SearchCubit cubit = BlocProvider.of<SearchCubit>(context);
    void searchButton(String title) {
      cubit.fetchSearch(title);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          TextField(
            controller: titleController,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                searchButton(titleController.text);
              });
            },
            child: Text("Search"),
          ),
          BlocBuilder<SearchCubit, SearchState>(
            bloc: cubit,
            builder: (context, state) {
              if (titleController.text.isNotEmpty) {
                if (state is SearchLoading) {
                  return CircularProgressIndicator();
                }
                if (state is SearchLoaded &&
                    state.searchModel.results.isNotEmpty) {
                  return MovieList(searchModel: state.searchModel);
                } else {
                  return Text("invalid search");
                }
              }
              return Text(state is SearchError ? state.errorMessage : "");
            },
          ),
        ],
      ),
    );
  }
}


// ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemCount: state.searchModel.results.length,
//                     physics: ScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return Card(
//                         child: Container(
//                           child: Column(
//                             children: [
//                               Image.network("${state.searchModel.results.elementAt(index).image}", height: 20),
//                               Text("${state.searchModel.results.elementAt(index).title}"),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );




