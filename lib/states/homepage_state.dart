import 'package:imdb_api_hackathon/models/movie_model.dart';

abstract class HomepageState {}

// loading
class HomepageLoading extends HomepageState {}

// loaded
class HomepageLoaded extends HomepageState {
  final MovieModel searchModel;
  HomepageLoaded({required this.searchModel});
}

// error
class HomepageError extends HomepageState {
  final String errorMessage;

  HomepageError({required this.errorMessage});
}
