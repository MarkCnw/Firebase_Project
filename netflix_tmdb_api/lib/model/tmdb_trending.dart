// To parse this JSON data, do
//
//     final tmdbTrending = tmdbTrendingFromJson(jsonString);

import 'dart:convert';

TmdbTrending tmdbTrendingFromJson(String str) =>
    TmdbTrending.fromJson(json.decode(str));

String tmdbTrendingToJson(TmdbTrending data) => json.encode(data.toJson());

class TmdbTrending {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  TmdbTrending({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TmdbTrending.fromJson(Map<String, dynamic> json) => TmdbTrending(
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
  String? backdropPath;
  int id;
  String? title;
  String? originalTitle;
  String? overview;
  String? posterPath;
  MediaType mediaType;
  bool adult;
  OriginalLanguage? originalLanguage;
  List<int>? genreIds;
  double popularity;
  DateTime? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? name;
  String? originalName;
  DateTime? firstAirDate;
  List<String>? originCountry;
  int? gender;
  String? knownForDepartment;
  String? profilePath;

  Result({
    this.backdropPath,
    required this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    required this.mediaType,
    required this.adult,
    this.originalLanguage,
    this.genreIds,
    required this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
    this.gender,
    this.knownForDepartment,
    this.profilePath,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    backdropPath: json["backdrop_path"],
    id: json["id"],
    title: json["title"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    mediaType: mediaTypeValues.map[json["media_type"]] ?? MediaType.MOVIE,
    adult: json["adult"],

    originalLanguage:
        originalLanguageValues.map[json["original_language"]],
    genreIds:
        json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
    popularity: json["popularity"]?.toDouble(),
    releaseDate:
        json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    name: json["name"],
    originalName: json["original_name"],
    firstAirDate:
        json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
    originCountry:
        json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
    gender: json["gender"],
    knownForDepartment: json["known_for_department"],
    profilePath: json["profile_path"],
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
    "genre_ids":
        genreIds == null
            ? []
            : List<dynamic>.from(genreIds!.map((x) => x)),
    "popularity": popularity,
    "release_date": releaseDate?.toIso8601String(),
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "name": name,
    "original_name": originalName,
    "first_air_date": firstAirDate?.toIso8601String(),
    "origin_country":
        originCountry == null
            ? []
            : List<dynamic>.from(originCountry!.map((x) => x)),
    "gender": gender,
    "known_for_department": knownForDepartment,
    "profile_path": profilePath,
  };
}

enum MediaType { MOVIE, PERSON, TV }

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE,
  "person": MediaType.PERSON,
  "tv": MediaType.TV,
});

enum OriginalLanguage { EN, ES, FR, NO }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "fr": OriginalLanguage.FR,
  "no": OriginalLanguage.NO,
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
