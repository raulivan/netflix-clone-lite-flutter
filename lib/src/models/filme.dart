class Filme {
  final String imdbId;
  final String title;
  final String year;
  final String poster;

  Filme({
    required this.imdbId,
    required this.title,
    required this.year,
    required this.poster,
  });

  factory Filme.fromJson(Map<String, dynamic> json) {
    return Filme(
      imdbId: json['imdbID'] ?? '',
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      poster: json['Poster'] ?? '',
    );
  }
}
