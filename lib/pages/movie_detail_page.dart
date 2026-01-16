import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/movie_detail.dart';
import '../services/movie_service.dart';
import '../config/api_config.dart';
import '../widgets/synopsis_card.dart';
import '../widgets/more_info_card.dart';
import '../services/saved_movies_service.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieDetail? _movieDetail;
  bool _isLoading = true;
  String? _errorMessage;
  late SavedMoviesService _savedMoviesService;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _savedMoviesService = SavedMoviesService();
    _isSaved = _savedMoviesService.isSaved(widget.movie.id);
    _savedMoviesService.addListener(_updateSavedStatus);
    _loadMovieDetails();
  }

  @override
  void dispose() {
    _savedMoviesService.removeListener(_updateSavedStatus);
    super.dispose();
  }

  void _updateSavedStatus() {
    setState(() {
      _isSaved = _savedMoviesService.isSaved(widget.movie.id);
    });
  }

  Future<void> _loadMovieDetails() async {
    try {
      final movieDetail = await MovieService.getMovieDetails(widget.movie.id);
      setState(() {
        _movieDetail = movieDetail;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _toggleSave() {
    _savedMoviesService.toggleSave(widget.movie);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final heroHeight = screenHeight * 0.3;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero banner with movie name
          SliverAppBar(
            expandedHeight: heroHeight,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.movie.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  _buildHeroBanner(),
                  // Gradient overlay for better text readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _isSaved ? Icons.favorite : Icons.favorite_border,
                  color: _isSaved ? Colors.red : Colors.white,
                ),
                onPressed: _toggleSave,
              ),
            ],
          ),
          // Content section
          SliverToBoxAdapter(
            child: _isLoading
                ? SizedBox(
                    height: screenHeight * 0.7,
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : _errorMessage != null
                    ? SizedBox(
                        height: screenHeight * 0.7,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline,
                                  size: 64, color: Colors.red),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  _errorMessage!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: _loadMovieDetails,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    final backdropUrl = widget.movie.backdropPath != null
        ? ApiConfig.getBackdropImageUrl(widget.movie.backdropPath)
        : null;

    if (backdropUrl != null && backdropUrl.isNotEmpty) {
      return Image.network(
        backdropUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholderBanner();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[900],
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      );
    }
    return _buildPlaceholderBanner();
  }

  Widget _buildPlaceholderBanner() {
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Icon(
          Icons.movie,
          size: 64,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_movieDetail == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        // Synopsis Card
        SynopsisCard(synopsis: _movieDetail!.overview),
        // More Info Card
        MoreInfoCard(
          genres: _movieDetail!.genresString,
          runtime: _movieDetail!.formattedRuntime,
          releaseDate: _movieDetail!.formattedReleaseDate,
          studios: _movieDetail!.studiosString,
          ageRating: _movieDetail!.ageRating,
          language: _movieDetail!.originalLanguage?.toUpperCase() ?? 'N/A',
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}