import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/services/search_service.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<MoviesState> {
  SearchCubit() : super(MoviesInitial());

  Future<void> fetchSearch({
    String? title,
    String? genres,
  }) async {
    SearchService searchService = SearchService();
    emit(MoviesLoading());

    try {
      MovieModel searchModel = await searchService.fetchSearchInformation(
          titleName: title, genre: genres);
      emit(MoviesLoaded(movieModel: searchModel));
    } catch (e) {
      emit(MoviesError(errorMessage: e.toString()));
    }
  }
}
