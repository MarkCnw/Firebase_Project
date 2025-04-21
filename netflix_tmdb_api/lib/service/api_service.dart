// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:netflix_tmdb_api/common/utils.dart';
import 'package:netflix_tmdb_api/model/movie_model.dart';
import 'package:netflix_tmdb_api/model/upcoming_movie.dart';

var key = "?api_key=$apiKey";

class ApiServices {
  Future<Movie?>fetchMovies()async{
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

   Future<UpcomingMovies?>upcomingMovies()async{
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
}