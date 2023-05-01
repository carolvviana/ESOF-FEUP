class Movie {
  final String imagePath;
  final String category;
  final int year;
  final Duration duration;
  final String id;
  final String plot;
  final String imdbRating;
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
  });

  String get movieCategory => category;
}
