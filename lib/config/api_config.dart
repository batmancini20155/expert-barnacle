class ApiConfig {
  // TODO: Replace with your TMDB API key
  // Get your API key from: https://www.themoviedb.org/settings/api
  static const String tmdbApiKey = '36571a1bf572c980dcd2fdee0bb1dfda';
  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  
  static String getPopularMoviesUrl(int page) {
    return '$tmdbBaseUrl/movie/popular?api_key=$tmdbApiKey&page=$page';
  }
  
  static String getMovieImageUrl(String? posterPath) {
    if (posterPath == null || posterPath.isEmpty) {
      return '';
    }
    return '$tmdbImageBaseUrl$posterPath';
  }

  static String getBackdropImageUrl(String? backdropPath) {
    if (backdropPath == null || backdropPath.isEmpty) {
      return '';
    }
    return 'https://image.tmdb.org/t/p/w1280$backdropPath';
  }

  static String getMovieDetailsUrl(int movieId) {
    return '$tmdbBaseUrl/movie/$movieId?api_key=$tmdbApiKey';
  }
}