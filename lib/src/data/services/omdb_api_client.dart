import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflixclone/src/core/constants.dart';

class OmdbApiClient {
  final http.Client client;

  OmdbApiClient({required this.client});

  Future<Map<String, dynamic>> searchMovies(String query) async {
    final url = Uri.parse('${AppConstants.omdbBaseUrl}?s=$query&apikey=${AppConstants.omdbApiKey}');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao acarregar a lista de filmes');
    }
  }

  Future<Map<String, dynamic>> getMovieDetails(String imdbId) async {
    final url = Uri.parse('${AppConstants.omdbBaseUrl}?i=$imdbId&apikey=${AppConstants.omdbApiKey}');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar os detalhes dos filmes');
    }
  }
}
