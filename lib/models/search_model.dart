// To parse this JSON data, do
//
//     final imdbModel = imdbModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class SearchModel {
  SearchModel({
    required this.queryString,
    required this.results,
    required this.errorMessage,
  });

  final String queryString;
  final List<Result> results;
  final dynamic errorMessage;

  factory SearchModel.fromJson(String str) => SearchModel.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory SearchModel.fromMap(Map<String, dynamic> json) => SearchModel(
    queryString: json["queryString"],
    results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
    errorMessage: json["errorMessage"],
  );

  // Map<String, dynamic> toMap() => {
  //   "queryString": queryString,
  //   "results": List<dynamic>.from(results.map((x) => x.toMap())),
  //   "errorMessage": errorMessage,
  // };
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

  // String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    id: json["id"],
    image: json["image"],
    title: json["title"],
    description: json["description"],
    runtimeStr: json["runtimeStr"] == null ? '' : json["runtimeStr"],
    genres: json["genres"] == null ? '' : json["genres"],
    genreList: json["genreList"] == null ? [] : List<GenreList>.from(json["genreList"].map((x) => GenreList.fromMap(x))),
    contentRating: json["metacriticRating"] == null ? '' : json["contentRating"],
    imDbRating: json["imDbRating"] == null ? '' : json["imDbRating"],
    imDbRatingVotes: json["imDbRatingVotes"] == null ? '' : json["imDbRatingVotes"],
    metacriticRating: json["metacriticRating"] == null ? '' : json["metacriticRating"],
    plot: json["plot"] == null ? '' : json["plot"],
    stars: json["stars"] == null ? '' : json["stars"],
    starList: json["starList"] == null ? [] : List<StarList>.from(json["starList"].map((x) => StarList.fromMap(x))),
  );

  // Map<String, dynamic> toMap() => {
  //   "id": id,
  //   "image": image,
  //   "title": title,
  //   "description": description,
  //   "runtimeStr": runtimeStr == null ? null : runtimeStr,
  //   "genres": genres == null ? null : genres,
  //   "genreList": genreList == null ? null : List<dynamic>.from(genreList.map((x) => x.toMap())),
  //   "contentRating": contentRating == null ? null : contentRating,
  //   "imDbRating": imDbRating == null ? null : imDbRating,
  //   "imDbRatingVotes": imDbRatingVotes == null ? null : imDbRatingVotes,
  //   "metacriticRating": metacriticRating == null ? null : metacriticRating,
  //   "plot": plot == null ? null : plot,
  //   "stars": stars == null ? null : stars,
  //   "starList": starList == null ? null : List<dynamic>.from(starList.map((x) => x.toMap())),
  // };
}

class GenreList {
  GenreList({
    required this.key,
    required this.value,
  });

  final String key;
  final String value;

  factory GenreList.fromJson(String str) => GenreList.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory GenreList.fromMap(Map<String, dynamic> json) => GenreList(
    key: json["key"],
    value: json["value"],
  );

  // Map<String, dynamic> toMap() => {
  //   "key": key,
  //   "value": value,
  // };
}

class StarList {
  StarList({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory StarList.fromJson(String str) => StarList.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  factory StarList.fromMap(Map<String, dynamic> json) => StarList(
    id: json["id"],
    name: json["name"],
  );

  // Map<String, dynamic> toMap() => {
  //   "id": id,
  //   "name": name,
  // };
}
