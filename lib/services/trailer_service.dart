// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:imdb_api_hackathon/models/trailer_model.dart';
import 'package:imdb_api_hackathon/services/api_keys.dart';

class TrailerService {
  Future<TrailerModel> fetchTrailerInformation({String? movieId}) async {
    const String apiKey = API_KEY;

    final Uri url = Uri(
      scheme: 'https',
      host: 'imdb-api.com',
      path: 'API/YouTubeTrailer/$apiKey/$movieId',
    );

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print("service: $url");
      return TrailerModel.fromJson(response.body);
    } else {
      throw Exception("Failed to load trailer information.");
    }
  }
}
