import 'dart:convert';

class MovieModel {
  MovieModel({
    required this.queryString,
    required this.results,
    required this.errorMessage,
  });

  final String queryString;
  final List<Result> results;
  final dynamic errorMessage;

  factory MovieModel.fromJson(String str) =>
      MovieModel.fromMap(json.decode(str));

  factory MovieModel.fromMap(Map<String, dynamic> json) => MovieModel(
        queryString: json["queryString"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
        errorMessage: json["errorMessage"],
      );
}

class Result {
  Result({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.runtimeStr,
    required this.genres,
    required this.genreList,
    required this.contentRating,
    required this.imDbRating,
    required this.imDbRatingVotes,
    required this.metacriticRating,
    required this.plot,
    required this.stars,
    required this.starList,
  });

  final String id;
  final String image;
  final String title;
  final String description;
  final String runtimeStr;
  final String genres;
  final List<GenreList>? genreList;
  final String contentRating;
  final String imDbRating;
  final String imDbRatingVotes;
  final String metacriticRating;
  final String plot;
  final String stars;
  final List<StarList> starList;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        image: json["image"],
        title: json["title"] ?? 'Unknown',
        description: json["description"],
        runtimeStr: json["runtimeStr"] ?? 'N/A',
        genres: json["genres"] ?? 'N/A',
        genreList: json["genreList"] == null
            ? []
            : List<GenreList>.from(
                json["genreList"].map((x) => GenreList.fromMap(x))),
        contentRating: json["contentRating"] ?? 'N/A',
        imDbRating: json["imDbRating"] ?? 'N/A',
        imDbRatingVotes: json["imDbRatingVotes"] ?? 'N/A',
        metacriticRating: json["metacriticRating"] ?? 'N/A',
        plot: json["plot"] ?? 'No Information',
        stars: json["stars"] ?? 'Unknown',
        starList: json["starList"] == null
            ? []
            : List<StarList>.from(
                json["starList"].map((x) => StarList.fromMap(x))),
      );
}

class GenreList {
  GenreList({
    required this.key,
    required this.value,
  });

  final String key;
  final String value;

  factory GenreList.fromJson(String str) => GenreList.fromMap(json.decode(str));

  factory GenreList.fromMap(Map<String, dynamic> json) => GenreList(
        key: json["key"],
        value: json["value"],
      );
}

class StarList {
  StarList({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory StarList.fromJson(String str) => StarList.fromMap(json.decode(str));

  factory StarList.fromMap(Map<String, dynamic> json) => StarList(
        id: json["id"],
        name: json["name"],
      );
}
