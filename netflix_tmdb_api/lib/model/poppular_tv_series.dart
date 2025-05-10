// To parse this JSON data, do
//
//     final poppularTVseries = poppularTVseriesFromJson(jsonString);

import 'dart:convert';

PoppularTVseries poppularTVseriesFromJson(String str) =>
    PoppularTVseries.fromJson(json.decode(str));

String poppularTVseriesToJson(PoppularTVseries data) =>
    json.encode(data.toJson());

class PoppularTVseries {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  PoppularTVseries({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PoppularTVseries.fromJson(Map<String, dynamic> json) =>
      PoppularTVseries(
        page: json["page"],
        results: List<Result>.from(
          json["results"].map((x) => Result.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String? posterPath;
  DateTime? firstAirDate;
  String name;
  double voteAverage;
  int voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble() ?? 0.0,
    posterPath: json["poster_path"],
    firstAirDate: json["first_air_date"] != null
        ? DateTime.tryParse(json["first_air_date"])
        : null,
    name: json["name"],
    voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": genreIds,
    "id": id,
    "origin_country": originCountry,
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "first_air_date": firstAirDate?.toIso8601String(),
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}


