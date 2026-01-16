class MovieDetail {
  final int id;
  final String title;
  final String? overview;
  final String? releaseDate;
  final double? voteAverage;
  final String? posterPath;
  final String? backdropPath;
  final List<Genre> genres;
  final int? runtime;
  final List<ProductionCompany> productionCompanies;
  final String? originalLanguage;
  final String? status;
  final String? tagline;
  final int? budget;
  final int? revenue;

  MovieDetail({
    required this.id,
    required this.title,
    this.overview,
    this.releaseDate,
    this.voteAverage,
    this.posterPath,
    this.backdropPath,
    required this.genres,
    this.runtime,
    required this.productionCompanies,
    this.originalLanguage,
    this.status,
    this.tagline,
    this.budget,
    this.revenue,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String?,
      releaseDate: json['release_date'] as String?,
      voteAverage: json['vote_average'] != null
          ? (json['vote_average'] as num).toDouble()
          : null,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((g) => Genre.fromJson(g as Map<String, dynamic>))
              .toList() ??
          [],
      runtime: json['runtime'] as int?,
      productionCompanies: (json['production_companies'] as List<dynamic>?)
              ?.map((c) => ProductionCompany.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
      originalLanguage: json['original_language'] as String?,
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      budget: json['budget'] as int?,
      revenue: json['revenue'] as int?,
    );
  }

  String get displayRating {
    if (voteAverage == null) return 'N/A';
    return voteAverage!.toStringAsFixed(1);
  }

  String get formattedRuntime {
    if (runtime == null) return 'N/A';
    final hours = runtime! ~/ 60;
    final minutes = runtime! % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  String get formattedReleaseDate {
    if (releaseDate == null || releaseDate!.isEmpty) return 'N/A';
    return releaseDate!;
  }

  String get genresString {
    if (genres.isEmpty) return 'N/A';
    return genres.map((g) => g.name).join(', ');
  }

  String get studiosString {
    if (productionCompanies.isEmpty) return 'N/A';
    return productionCompanies.map((c) => c.name).join(', ');
  }

  String get ageRating {
    // TMDB doesn't provide MPAA rating, but we can use adult flag
    // For now, we'll return a placeholder
    return 'Not Rated';
  }
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

class ProductionCompany {
  final int id;
  final String name;
  final String? logoPath;
  final String? originCountry;

  ProductionCompany({
    required this.id,
    required this.name,
    this.logoPath,
    this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] as int,
      name: json['name'] as String,
      logoPath: json['logo_path'] as String?,
      originCountry: json['origin_country'] as String?,
    );
  }
}