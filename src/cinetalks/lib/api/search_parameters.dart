class SearchParameters {
  String title;
  List<String> titleTypes;
  List<String> genres;
  List<String> groups;
  int userRating;
  int releaseDate;
  String sort;

  SearchParameters({
    this.title = '',
    this.titleTypes = const [],
    this.genres = const [],
    this.groups = const [],
    this.userRating = 0,
    this.releaseDate = 0,
    this.sort = '',
  });
}
