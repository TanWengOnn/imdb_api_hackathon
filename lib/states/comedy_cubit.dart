import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/services/search_service.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';

class ComedyCubit extends Cubit<MoviesState> {
  ComedyCubit() : super(MoviesLoading());

  Future<void> fetchComedy(
      {String? moviemeter, String? genres, String? count}) async {
    SearchService comedyService = SearchService();
    emit(MoviesLoading());

    try {
      MovieModel comedyModel = await comedyService.fetchSearchInformation(
          genre: genres, moviemeter: moviemeter, count: count);
      emit(MoviesLoaded(movieModel: comedyModel));
    } catch (e) {
      emit(MoviesError(errorMessage: e.toString()));
    }
  }
}
