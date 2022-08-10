import 'package:http/http.dart' as http;
import 'package:imdb_api_hackathon/models/movie_model.dart';

class SearchService {
  Future<MovieModel> fetchSearchInformation(
      {String? titleName,
      String? genre,
      String? moviemeter,
      String? count}) async {
    const String apiKey = "k_8dgpz1mi";
    // k_2b0tzkax
    // k_mvigl067
    // k_8dgpz1mi
    // k_w8s2x30q
    // k_l6oi3cob
    // k_s4hmxd4c

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
      print("service: ${url}");
      return MovieModel.fromJson(response.body);
    } else {
      throw Exception("Failed to load weather information.");
    }
  }
}
