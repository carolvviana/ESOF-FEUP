class Movie {
  final String imagePath;
  final String category;
  final int year;
  final Duration duration;
  final String id;
  final String plot;
  final String imdbRating;
  final String ranking;
  final String title;

  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.imagePath,
    required this.category,
    required this.duration,
    required this.plot,
    required this.imdbRating,
    required this.ranking,
  });

  String get movieCategory => category;
}
