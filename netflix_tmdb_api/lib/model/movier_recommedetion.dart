// To parse this JSON data, do
//
//     final movieRecommedations = movieRecommedationsFromJson(jsonString);

import 'dart:convert';

MovieRecommedations movieRecommedationsFromJson(String str) =>
    MovieRecommedations.fromJson(json.decode(str));

String movieRecommedationsToJson(MovieRecommedations data) =>
    json.encode(data.toJson());

class MovieRecommedations {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  MovieRecommedations({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieRecommedations.fromJson(Map<String, dynamic> json) =>
      MovieRecommedations(
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
  String backdropPath;
  int id;
  String title;
  String originalTitle;
  String overview;
  String posterPath;
  MediaType mediaType;
  bool adult;
  OriginalLanguage originalLanguage;
  List<int> genreIds;
  double popularity;
  DateTime releaseDate;
  bool video;
  double voteAverage;
  int voteCount;

  Result({
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    backdropPath: json["backdrop_path"] ?? '',
    id: json["id"],
    title: json["title"] ?? '',
    originalTitle: json["original_title"] ?? '',
    overview: json["overview"] ?? '',
    posterPath: json["poster_path"] ?? '',
    mediaType: mediaTypeValues.map[json["media_type"]] ?? MediaType.MOVIE,
    adult: json["adult"] ?? false,
    originalLanguage:
        originalLanguageValues.map[json["original_language"]] ??
        OriginalLanguage.EN,
    genreIds: List<int>.from(json["genre_ids"] ?? []),
    popularity: (json["popularity"] ?? 0).toDouble(),
    releaseDate:
        json["release_date"] != null && json["release_date"] != ""
            ? DateTime.parse(json["release_date"])
            : DateTime(2000),
    video: json["video"] ?? false,
    voteAverage: (json["vote_average"] ?? 0).toDouble(),
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "id": id,
    "title": title,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaTypeValues.reverse[mediaType],
    "adult": adult,
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "popularity": popularity,
    "release_date":
        "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

enum MediaType { MOVIE }

final mediaTypeValues = EnumValues({"movie": MediaType.MOVIE});

enum OriginalLanguage { EN, IT, JA, KO }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "it": OriginalLanguage.IT,
  "ja": OriginalLanguage.JA,
  "ko": OriginalLanguage.KO,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
