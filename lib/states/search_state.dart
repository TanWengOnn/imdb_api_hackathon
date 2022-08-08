import 'package:imdb_api_hackathon/models/search_model.dart';

abstract class SearchState {}

// // initialise
// class WeatherInitial

// loading
class SearchLoading extends SearchState {}

// loaded
class SearchLoaded extends SearchState {
  final SearchModel searchModel;
  SearchLoaded({required this.searchModel});
}

// error
class SearchError extends SearchState {
  final String errorMessage;

  SearchError({required this.errorMessage});
}