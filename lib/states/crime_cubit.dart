import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/services/search_service.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';

class CrimeCubit extends Cubit<MoviesState> {
  CrimeCubit() : super(MoviesLoading());

  Future<void> fetchCrime(
      {String? moviemeter, String? genres, String? count}) async {
    SearchService crimeService = SearchService();
    emit(MoviesLoading());

    try {
      MovieModel crimeModel = await crimeService.fetchSearchInformation(
          genre: genres, moviemeter: moviemeter, count: count);
      emit(MoviesLoaded(movieModel: crimeModel));
    } catch (e) {
      emit(MoviesError(errorMessage: e.toString()));
    }
  }
}
