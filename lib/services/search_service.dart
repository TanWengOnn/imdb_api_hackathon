// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:imdb_api_hackathon/models/movie_model.dart';
import 'package:imdb_api_hackathon/services/api_keys.dart';

class SearchService {
  Future<MovieModel> fetchSearchInformation(
      {String? titleName,
      String? genre,
      String? moviemeter,
      String? count}) async {
    const String apiKey = API_KEY;

    final Uri url = Uri(
      scheme: 'https',
      host: 'imdb-api.com',
      path: 'API/AdvancedSearch/$apiKey',
      queryParameters: {
        'title': titleName,
        'genres': genre,
        'moviemeter': moviemeter,
        'count': count,
      },
    );

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print("service: $url");
      return MovieModel.fromJson(response.body);
    } else {
      throw Exception("Failed to load movies information.");
    }
  }
}
