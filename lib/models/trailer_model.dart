import 'dart:convert';

class TrailerModel {
  TrailerModel({
    required this.imDbId,
    required this.title,
    required this.fullTitle,
    required this.type,
    required this.year,
    required this.videoId,
    required this.videoUrl,
    required this.errorMessage,
  });

  final String imDbId;
  final String title;
  final String fullTitle;
  final String type;
  final String year;
  final String videoId;
  final String videoUrl;
  final String errorMessage;

  factory TrailerModel.fromJson(String str) =>
      TrailerModel.fromMap(json.decode(str));

  factory TrailerModel.fromMap(Map<String, dynamic> json) => TrailerModel(
        imDbId: json["imDbId"] ?? '',
        title: json["title"] ?? '',
        fullTitle: json["fullTitle"] ?? '',
        type: json["type"] ?? '',
        year: json["year"] ?? '',
        videoId: json["videoId"] ?? '',
        videoUrl: json["videoUrl"] ?? '',
        errorMessage: json["errorMessage"] ?? '',
      );
}
