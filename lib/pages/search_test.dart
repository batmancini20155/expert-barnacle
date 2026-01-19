import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';

void main() {
  runApp(const MovieSearchApp());
}

class MovieSearchApp extends StatelessWidget {
  const MovieSearchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Finder',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
      ),
      home: const MovieSearchPage(),
    );
  }
}

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({Key? key}) : super(key: key);

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _movies = [];
  bool _loading = false;
  String _error = '';
  
  // Replace with your TMDB API key
  static const String apiKey = ApiConfig.tmdbApiKey; // this is a referene to the api key in the api_config.dart file

  Future<void> searchMovies() async {
    if (_searchController.text.trim().isEmpty) return;

    setState(() {
      _loading = true;
      _error = '';
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=${Uri.encodeComponent(_searchController.text)}&language=en-US&page=1',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _movies = (data['results'] as List)
              .map((movie) => Movie.fromJson(movie))
              .toList();
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to fetch movies. Please check your API key.';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'An error occurred: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0f172a),
              Color(0xFF581c87),
              Color(0xFF0f172a),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'Movie Finder',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Search millions of movies from TMDB',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFe9d5ff),
                      ),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Search for movies...',
                      hintStyle: TextStyle(color: Color(0xFFe9d5ff)),
                      prefixIcon: Icon(Icons.search, color: Color(0xFFd8b4fe)),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          onPressed: searchMovies,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF9333ea),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text('Search'),
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                    onSubmitted: (_) => searchMovies(),
                  ),
                ),
              ),

              // API Key Notice
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.yellow.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    'Note: Replace YOUR_API_KEY with your TMDB API key. Get one free at themoviedb.org',
                    style: TextStyle(color: Color(0xFFfef08a), fontSize: 12),
                  ),
                ),
              ),

              // Loading State
              if (_loading)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Color(0xFFc084fc)),
                        SizedBox(height: 16),
                        Text(
                          'Searching movies...',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),

              // Error State
              if (_error.isNotEmpty && !_loading)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Text(
                      _error,
                      style: TextStyle(color: Colors.red[200]),
                    ),
                  ),
                ),

              // Results
              if (!_loading && _movies.isNotEmpty)
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(24),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _movies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(movie: _movies[index]);
                    },
                  ),
                ),

              // No Results
              if (!_loading &&
                  _searchController.text.isNotEmpty &&
                  _movies.isEmpty &&
                  _error.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'No movies found. Try a different search!',
                      style: TextStyle(color: Color(0xFFe9d5ff), fontSize: 16),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: movie.posterPath != null
                ? Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF9333ea), Color(0xFFec4899)],
                      ),
                    ),
                    child: Center(
                      child: Text('🎬', style: TextStyle(fontSize: 48)),
                    ),
                  ),
          ),

          // Info
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    if (movie.voteAverage > 0) ...[
                      Icon(Icons.star, color: Colors.yellow, size: 16),
                      SizedBox(width: 4),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: TextStyle(color: Color(0xFFe9d5ff), fontSize: 12),
                      ),
                      SizedBox(width: 12),
                    ],
                    if (movie.releaseDate != null) ...[
                      Icon(Icons.calendar_today, color: Color(0xFFe9d5ff), size: 16),
                      SizedBox(width: 4),
                      Text(
                        movie.releaseDate!.year.toString(),
                        style: TextStyle(color: Color(0xFFe9d5ff), fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Movie {
  final int id;
  final String title;
  final String? posterPath;
  final String? overview;
  final double voteAverage;
  final DateTime? releaseDate;

  Movie({
    required this.id,
    required this.title,
    this.posterPath,
    this.overview,
    required this.voteAverage,
    this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? 'Unknown',
      posterPath: json['poster_path'],
      overview: json['overview'],
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      releaseDate: json['release_date'] != null && json['release_date'] != ''
          ? DateTime.tryParse(json['release_date'])
          : null,
    );
  }
}