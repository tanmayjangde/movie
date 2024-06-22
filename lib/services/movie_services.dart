import 'package:movie_web/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieServices {
  final BASE_URL = 'https://api.themoviedb.org/3/movie/';
  final headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZjA0OGUzZTAyNWZmZTllMTU1MjUwN2U4ZjNjMThlNCIsInN1YiI6IjY2MjIwNzQyMGQxMWYyMDE2NDAxZmU3ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.T1gac2LPIJCklcwpYRZUVjfaRId6WJqQBeXG5Rf3asI',
    'accept': 'application/json'
  };

  Future<List<Movie>> fetchTopRatedMovies() async {
    final response = await http.get(
        Uri.parse('${BASE_URL}top_rated?language=en-US&page=1'),
        headers: headers);

    if (response.statusCode == 200) {
      return ((json.decode(response.body)['results']) as List)
          .map((e) => Movie.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<Movie>> fetchUpcomingMovies() async {
    final response = await http.get(
        Uri.parse('${BASE_URL}upcoming?language=en-US&page=1'),
        headers: headers);

    if (response.statusCode == 200) {
      return ((json.decode(response.body)['results']) as List)
          .map((e) => Movie.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<Movie>> fetchNowPlayingMovies() async {
    final response = await http.get(
        Uri.parse('${BASE_URL}now_playing?language=en-US&page=1'),
        headers: headers);

    if (response.statusCode == 200) {
      return ((json.decode(response.body)['results']) as List)
          .map((e) => Movie.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.get(
        Uri.parse('${BASE_URL}popular?language=en-US&page=1'),
        headers: headers);

    if (response.statusCode == 200) {
      return ((json.decode(response.body)['results']) as List)
          .map((e) => Movie.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<Movie> fetchMovieById(String id) async {
    final response = await http.get(
        Uri.parse('${BASE_URL}${id}?language=en-US&page=1'),
        headers: headers);

    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<Movie>> fetchSimilarMovies(String id) async {
    final response = await http.get(
        Uri.parse('${BASE_URL}$id/similar?language=en-US&page=1'),
        headers: headers);

    if (response.statusCode == 200) {
      return ((json.decode(response.body)['results']) as List)
          .map((e) => Movie.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/search/movie?query=${query}'),
        headers: headers);

    if (response.statusCode == 200) {
      return ((json.decode(response.body)['results']) as List)
          .map((e) => Movie.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
