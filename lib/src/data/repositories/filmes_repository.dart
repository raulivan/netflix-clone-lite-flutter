
import 'package:netflixclone/src/data/services/omdb_api_client.dart';
import 'package:netflixclone/src/models/filme.dart';
import 'package:netflixclone/src/models/filme_detalhes.dart';

class FilmeRepository {
  final OmdbApiClient apiClient;

  FilmeRepository({required this.apiClient});

  Future<List<Filme>> searchMovies(String query) async {
    try {
      final data = await apiClient.searchMovies(query);
      if (data['Response'] == 'True') {
        final List results = data['Search'];
        return results.map((json) => Filme.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Falha ao mapear o filme: $e');
    }
  }

  Future<FilmeDetalhes> getMovieDetails(String imdbId) async {
    try {
      final data = await apiClient.getMovieDetails(imdbId);
      if (data['Response'] == 'True') {
        return FilmeDetalhes.fromJson(data);
      } else {
        throw Exception(data['Error'] ?? 'Erro desconhecido');
      }
    } catch (e) {
      throw Exception('Falha ao carregar os detalghes do filme: $e');
    }
  }
}
