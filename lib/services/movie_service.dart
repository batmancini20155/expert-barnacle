import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/movie.dart';
import '../models/movie_detail.dart';

class MovieService {
  static Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      // Check if API key is set
      if (ApiConfig.tmdbApiKey == 'YOUR_TMDB_API_KEY_HERE') {
        throw Exception(
            'Please set your TMDB API key in lib/config/api_config.dart');
      }

      final url = ApiConfig.getPopularMoviesUrl(page);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'] as List<dynamic>;

        return results
            .map((movieJson) => Movie.fromJson(movieJson as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
            'Failed to load movies: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  static Future<MovieDetail> getMovieDetails(int movieId) async {
    try {
      // Check if API key is set
      if (ApiConfig.tmdbApiKey == 'YOUR_TMDB_API_KEY_HERE') {
        throw Exception(
            'Please set your TMDB API key in lib/config/api_config.dart');
      }

      final url = ApiConfig.getMovieDetailsUrl(movieId);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return MovieDetail.fromJson(data);
      } else {
        throw Exception(
            'Failed to load movie details: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }
}