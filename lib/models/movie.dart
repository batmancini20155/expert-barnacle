class Movie {
  final int id;
  final String title;
  final String? overview;
  final String? releaseDate;
  final double? voteAverage;
  final String? posterPath;
  final String? backdropPath;
  final List<int>? genreIds;
  final double? popularity;
  final int? voteCount;
  final String? originalLanguage;
  final bool? adult;

  Movie({
    required this.id,
    required this.title,
    this.overview,
    this.releaseDate,
    this.voteAverage,
    this.posterPath,
    this.backdropPath,
    this.genreIds,
    this.popularity,
    this.voteCount,
    this.originalLanguage,
    this.adult,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String?,
      releaseDate: json['release_date'] as String?,
      voteAverage: json['vote_average'] != null
          ? (json['vote_average'] as num).toDouble()
          : null,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: json['genre_ids'] != null
          ? List<int>.from(json['genre_ids'] as List)
          : null,
      popularity: json['popularity'] != null
          ? (json['popularity'] as num).toDouble()
          : null,
      voteCount: json['vote_count'] as int?,
      originalLanguage: json['original_language'] as String?,
      adult: json['adult'] as bool?,
    );
  }

  // Helper methods
  int? get releaseYear {
    if (releaseDate == null || releaseDate!.isEmpty) return null;
    try {
      return int.parse(releaseDate!.substring(0, 4));
    } catch (e) {
      return null;
    }
  }

  String get displayRating {
    if (voteAverage == null) return 'N/A';
    return voteAverage!.toStringAsFixed(1);
  }
}