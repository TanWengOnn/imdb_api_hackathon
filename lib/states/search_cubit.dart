import 'package:imdb_api_hackathon/models/search_model.dart';
import 'package:imdb_api_hackathon/services/search_service.dart';
import 'package:imdb_api_hackathon/states/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchLoading());

  Future<void> fetchSearch(String title) async {
    SearchService searchService = SearchService();
    emit(SearchLoading());

    try {
      SearchModel searchModel = await searchService.fetchSearchInformation(titleName: title);
      emit(SearchLoaded(searchModel: searchModel));
    } catch (e) {
      emit(SearchError(errorMessage: e.toString()));
    }
  }
}