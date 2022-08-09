import 'package:imdb_api_hackathon/models/trailer_model.dart';

abstract class TrailerState {}

// initialise
class TrailerInitial extends TrailerState {}

// loading
class TrailerLoading extends TrailerState {}

// loaded
class TrailerLoaded extends TrailerState {
  final TrailerModel trailerModel;
  TrailerLoaded({required this.trailerModel});
}

// error
class TrailerError extends TrailerState {
  final String errorMessage;

  TrailerError({required this.errorMessage});
}
