// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:imdb_api_hackathon/models/trailer_model.dart';

class TrailerService {
  Future<TrailerModel> fetchTrailerInformation({String? movieId}) async {
    const String apiKey = "k_w8s2x30q";
    // k_2b0tzkax
    // k_mvigl067
    // k_8dgpz1mi
    // k_w8s2x30q
    // k_l6oi3cob
    // k_s4hmxd4c
    // k_vaew91xr
    // k_fawnvhz5
    // k_rkos0u75

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
