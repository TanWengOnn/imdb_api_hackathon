import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_api_hackathon/models/trailer_model.dart';
import 'package:imdb_api_hackathon/services/trailer_service.dart';

import 'package:imdb_api_hackathon/states/trailer_state.dart';

class TrailerCubit extends Cubit<TrailerState> {
  TrailerCubit() : super(TrailerLoading());

  Future<void> fetchTrailer({String? movieID}) async {
    TrailerService trailerService = TrailerService();
    emit(TrailerLoading());

    try {
      TrailerModel trailerModel = await trailerService.fetchTrailerInformation(movieId: movieID);
      emit(TrailerLoaded(trailerModel: trailerModel));
    } catch (e) {
      emit(TrailerError(errorMessage: e.toString()));
    }
  }
}
