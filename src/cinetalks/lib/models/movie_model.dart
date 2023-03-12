class Movie {
  final String name;
  final String imagePath;
  final String videoPath;
  final String category;
  final int year;
  final Duration duration;

  const Movie(
      {required this.name,
        required this.imagePath,
        required this.videoPath,
        required this.category,
        required this.year,
        required this.duration});

  static const List<Movie> movies = [
    Movie(
      name: "Leave No Trace",
      imagePath:
      "https://www.themoviedb.org/t/p/original/dDHioFaBBC1X76dlJ1GaoHZ4q9M.jpg",
      videoPath: "assets/videos/example.mp4",
      category: "Drama",
      year: 2022,
      duration: Duration(hours: 1, minutes: 48),
    ),
    Movie(
      name: "Hustle",
      imagePath:
      "https://m.media-amazon.com/images/M/MV5BYjdhYTE3NjMtZjI3OC00NzVlLWFiNTUtNzQ3NDNiNTI3NDg4XkEyXkFqcGdeQXVyMTEyMjM2NDc2._V1_.jpg",
      videoPath: "assets/videos/example.mp4",
      category: "Drama",
      year: 2022,
      duration: Duration(hours: 1, minutes: 58),
    ),
    Movie(
      name: "Thirteen Lives",
      imagePath:
      "https://m.media-amazon.com/images/M/MV5BMjgzNjQxMzQtMTYxMy00YWQ2LThlMjAtZTgwMDIxZWE5ZjIzXkEyXkFqcGdeQXVyMTA3MDk2NDg2._V1_.jpg",
      videoPath: "assets/videos/example.mp4",
      category: "Drama",
      year: 2022,
      duration: Duration(hours: 2, minutes: 22),
    ),
    Movie(
      name: "The Innocents",
      imagePath:
      "https://medias.unifrance.org/medias/212/207/249812/format_page/media.jpg",
      videoPath: "assets/videos/example.mp4",
      category: "Thriller",
      year: 2022,
      duration: Duration(hours: 1, minutes: 58),
    ),
    Movie(
      name: "The Gray Man",
      imagePath:
      "https://dnm.nflximg.net/api/v6/2DuQlx0fM4wd1nzqm5BFBi6ILa8/AAAAQaWyWoQoWnMsNO7s1DMhW5x6_f1a_SsQhpaRUeiAdGPQskUIShLqb9e0732BEJ95A1NUCN8q1QvMgwtUxL0SGuOuY8samTksoa8WBYb4g__nwbupB-tjqvmRAGe6hW1b9q4UKpOqoKPrx0tgK3VFyflL.jpg?r=f74",
      videoPath: "assets/videos/example.mp4",
      category: "Thriller",
      year: 2022,
      duration: Duration(hours: 2, minutes: 9),
    ),
    Movie(
      name: "Purple Hearts",
      imagePath:
      "https://m.media-amazon.com/images/M/MV5BNzI4ZTAwNzEtNTk5YS00ZWJmLWI1ODMtOTU4MTM5MzQ4OWM0XkEyXkFqcGdeQXVyMTEzMTI1Mjk3._V1_.jpg",
      videoPath: "assets/videos/example.mp4",
      category: "Romance",
      year: 2022,
      duration: Duration(hours: 2, minutes: 3),
    ),
  ];
}