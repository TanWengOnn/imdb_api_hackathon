import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/services/search_service.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';

class ActionCubit extends Cubit<MoviesState> {
  ActionCubit() : super(MoviesLoading());

  Future<void> fetchAction(
      {String? moviemeter, String? genres, String? count}) async {
    SearchService actionService = SearchService();
    emit(MoviesLoading());

    try {
      MovieModel actionModel = await actionService.fetchSearchInformation(
          genre: genres, moviemeter: moviemeter, count: count);
      emit(MoviesLoaded(movieModel: actionModel));
    } catch (e) {
      emit(MoviesError(errorMessage: e.toString()));
    }
  }
}
