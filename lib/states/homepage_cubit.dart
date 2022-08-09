import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/models/movie_model.dart';

import '../services/search_service.dart';
import 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(HomepageLoading());

  Future<void> fetchHomepage({String? moviemeter, String? genres, String? count}) async {
    SearchService homepageService = SearchService();
    emit(HomepageLoading());

    try {
      MovieModel homepageModel =
          await homepageService.fetchSearchInformation(genre: genres, moviemeter: moviemeter, count: count);
      emit(HomepageLoaded(searchModel: homepageModel));
    } catch (e) {
      emit(HomepageError(errorMessage: e.toString()));
    }
  }
}
