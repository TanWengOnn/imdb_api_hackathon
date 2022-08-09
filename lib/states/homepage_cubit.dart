import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';

import '../services/search_service.dart';
import 'package:imdb_api_hackathon/states/movie_state.dart';

class HomepageCubit extends Cubit<MoviesState> {
  HomepageCubit() : super(MoviesLoading());

  Future<void> fetchHomepage({String? moviemeter, String? genres, String? count}) async {
    SearchService homepageService = SearchService();
    emit(MoviesLoading());

    try {
      MovieModel homepageModel =
          await homepageService.fetchSearchInformation(genre: genres, moviemeter: moviemeter, count: count);
      emit(MoviesLoaded(movieModel: homepageModel));
    } catch (e) {
      emit(MoviesError(errorMessage: e.toString()));
    }
  }
}
