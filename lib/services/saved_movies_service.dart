import 'package:flutter/foundation.dart';
import '../models/movie.dart';

class SavedMoviesService extends ChangeNotifier {
  static final SavedMoviesService _instance = SavedMoviesService._internal();
  factory SavedMoviesService() => _instance;
  SavedMoviesService._internal();

  final Set<int> _savedMovieIds = {};
  final Map<int, Movie> _savedMovies = {};

  Set<int> get savedMovieIds => _savedMovieIds;
  List<Movie> get savedMovies => _savedMovies.values.toList();
  bool get hasSavedMovies => _savedMovies.isNotEmpty;

  bool isSaved(int movieId) {
    return _savedMovieIds.contains(movieId);
  }

  void toggleSave(Movie movie) {
    if (_savedMovieIds.contains(movie.id)) {
      _savedMovieIds.remove(movie.id);
      _savedMovies.remove(movie.id);
    } else {
      _savedMovieIds.add(movie.id);
      _savedMovies[movie.id] = movie;
    }
    notifyListeners();
  }

  void saveMovie(Movie movie) {
    if (!_savedMovieIds.contains(movie.id)) {
      _savedMovieIds.add(movie.id);
      _savedMovies[movie.id] = movie;
      notifyListeners();
    }
  }

  void removeMovie(int movieId) {
    _savedMovieIds.remove(movieId);
    _savedMovies.remove(movieId);
    notifyListeners();
  }

  void clearAll() {
    _savedMovieIds.clear();
    _savedMovies.clear();
    notifyListeners();
  }
}