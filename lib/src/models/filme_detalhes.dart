class FilmeDetalhes {
  final String imdbId;
  final String title;
  final String year;
  final String poster;
  final String plot;
  final String genre;
  final String actors;
  final String director;
  final String runtime;
  final String imdbRating;

  FilmeDetalhes({
    required this.imdbId,
    required this.title,
    required this.year,
    required this.poster,
    required this.plot,
    required this.genre,
    required this.actors,
    required this.director,
    required this.runtime,
    required this.imdbRating,
  });

  factory FilmeDetalhes.fromJson(Map<String, dynamic> json) {
    return FilmeDetalhes(
      imdbId: json['imdbID'] ?? '',
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      poster: json['Poster'] ?? '',
      plot: json['Plot'] ?? '',
      genre: json['Genre'] ?? '',
      actors: json['Actors'] ?? '',
      director: json['Director'] ?? '',
      runtime: json['Runtime'] ?? '',
      imdbRating: json['imdbRating'] ?? '',
    );
  }
}
