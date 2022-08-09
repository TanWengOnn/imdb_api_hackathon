import 'package:imdb_api_hackathon/models/movie_model.dart';

abstract class MoviesState {}

// initialise
class MoviesInitial extends MoviesState {}

// loading
class MoviesLoading extends MoviesState {}

// loaded
class MoviesLoaded extends MoviesState {
  final MovieModel movieModel;
  MoviesLoaded({required this.movieModel});
}

// error
class MoviesError extends MoviesState {
  final String errorMessage;

  MoviesError({required this.errorMessage});
}
