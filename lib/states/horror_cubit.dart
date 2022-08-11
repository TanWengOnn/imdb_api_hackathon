import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/services/search_service.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';

class HorrorCubit extends Cubit<MoviesState> {
  HorrorCubit() : super(MoviesLoading());

  Future<void> fetchHorror(
      {String? moviemeter, String? genres, String? count}) async {
    SearchService horrorService = SearchService();
    emit(MoviesLoading());

    try {
      MovieModel horrorModel = await horrorService.fetchSearchInformation(
          genre: genres, moviemeter: moviemeter, count: count);
      emit(MoviesLoaded(movieModel: horrorModel));
    } catch (e) {
      emit(MoviesError(errorMessage: e.toString()));
    }
  }
}
