// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:netflix_tmdb_api/common/utils.dart';
import 'package:netflix_tmdb_api/model/movie_detail.dart';
import 'package:netflix_tmdb_api/model/movie_model.dart';
import 'package:netflix_tmdb_api/model/movier_recommedetion.dart';
import 'package:netflix_tmdb_api/model/poppular_tv_series.dart';
import 'package:netflix_tmdb_api/model/search_movie_model.dart';
import 'package:netflix_tmdb_api/model/top_rated_movies.dart';
import 'package:netflix_tmdb_api/model/trending_model.dart';
import 'package:netflix_tmdb_api/model/upcoming_movie.dart';

var key = "?api_key=$apiKey";

class ApiServices {
  Future<Movie?> fetchMovies() async {
    try {
      const endPoint = "movie/now_playing";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return movieFromJson(response.body);
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      print("Error fetching movies: $e");
      return null;
    }
  }

  Future<UpcomingMovies?> upcomingMovies() async {
    try {
      const endPoint = "movie/upcoming";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return upcomingMoviesFromJson(response.body);
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      print("Error fetching movies: $e");
      return null;
    }
  }

  Future<TrendingMovies?> trendingMovies() async {
    try {
      const endPoint = "trending/movie/day";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return trendingMoviesFromJson(response.body);
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      print("Error fetching movies: $e");
      return null;
    }
  }

  Future<TopRatedMovies?> topRateMovies() async {
    try {
      const endPoint = "movie/top_rated";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return topRatedMoviesFromJson(response.body);
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      print("Error fetching movies: $e");
      return null;
    }
  }

  Future<PoppularTVseries?> popularTvSeries() async {
    try {
      const endPoint = "tv/popular";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return poppularTVseriesFromJson(response.body);
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      print("Error fetching movies: $e");
      return null;
    }
  }

  Future<MovieDetail?> movieDetail(int movieId) async {
    try {
      final endPoint = "movie/$movieId";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return movieDetailFromJson(response.body);
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      print("Error fetching movies: $e");
      return null;
    }
  }

  Future<MovieRecommedations?> movieRecommedetion(int movieId) async {
    try {
      final endPoint = "movie/$movieId/recommendations";
      final apiUrl = "$baseUrl$endPoint$key";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return movieRecommedationsFromJson(response.body);
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      print("Error fetching movies: $e");
      return null;
    }
  }

  Future<SearchMovie?> searchMovie(String query) async {
    try {
      final endPoint =
          "search/movie?query=${Uri.encodeQueryComponent(query)}";

      final apiUrl = "$baseUrl$endPoint";
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MTVmMTM2OGU0Mjk0YzgwMzc4MjY5NDAxZmMzZDk5YSIsIm5iZiI6MTczODAzNTg3Ny40Mywic3ViIjoiNjc5ODUyYTU5YTMwYTg1YjI3MjQyYjYxIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.Ys9Uuyf-WnCR-_FQHltu1OOi3lHECeBi06Fa-B5V2gg",
        },
      );
      if (response.statusCode == 200) {
        return searchMovieFromJson(response.body);
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      print("Error fetching movies: $e");
      return null;
    }
  }
}
