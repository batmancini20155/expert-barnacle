import 'package:flutter/material.dart';

class MoreInfoCard extends StatelessWidget {
  final String genres;
  final String runtime;
  final String releaseDate;
  final String studios;
  final String ageRating;
  final String language;

  const MoreInfoCard({
    super.key,
    required this.genres,
    required this.runtime,
    required this.releaseDate,
    required this.studios,
    required this.ageRating,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'More Info',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.category, 'Genre', genres),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.access_time, 'Runtime', runtime),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.calendar_today, 'Release Date', releaseDate),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.business, 'Studio', studios),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.verified_user, 'Age Rating', ageRating),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.language, 'Language', language),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}