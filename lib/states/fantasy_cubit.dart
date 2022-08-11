import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/services/search_service.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';

class FantasyCubit extends Cubit<MoviesState> {
  FantasyCubit() : super(MoviesLoading());

  Future<void> fetchFantasy(
      {String? moviemeter, String? genres, String? count}) async {
    SearchService fantasyService = SearchService();
    emit(MoviesLoading());

    try {
      MovieModel fantasyModel = await fantasyService.fetchSearchInformation(
          genre: genres, moviemeter: moviemeter, count: count);
      emit(MoviesLoaded(movieModel: fantasyModel));
    } catch (e) {
      emit(MoviesError(errorMessage: e.toString()));
    }
  }
}
