import 'package:flutter/material.dart';
import '../services/saved_movies_service.dart';
import '../widgets/movie_card.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  late SavedMoviesService _savedMoviesService;

  @override
  void initState() {
    super.initState();
    _savedMoviesService = SavedMoviesService();
    _savedMoviesService.addListener(_onSavedMoviesChanged);
  }

  @override
  void dispose() {
    _savedMoviesService.removeListener(_onSavedMoviesChanged);
    super.dispose();
  }

  void _onSavedMoviesChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final savedMovies = _savedMoviesService.savedMovies;

    return savedMovies.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your saved movies will appear here',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.6,
              ),
              itemCount: savedMovies.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: savedMovies[index]);
              },
            );
  }
}