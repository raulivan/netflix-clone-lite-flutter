import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflixclone/src/core/app_colors.dart';
import 'package:netflixclone/src/data/repositories/filmes_repository.dart';
import 'package:netflixclone/src/data/services/omdb_api_client.dart';
import 'package:netflixclone/src/ui/view_models/filme_detalhes_view_model.dart';

class FilmeDetalhesPage extends StatefulWidget {
  final String imdbId;

  const FilmeDetalhesPage({super.key, required this.imdbId});

  @override
  State<FilmeDetalhesPage> createState() => _FilmeDetalhesPageState();
}

class _FilmeDetalhesPageState extends State<FilmeDetalhesPage> {
  late FilmeDetalhesViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    final repository = FilmeRepository(apiClient: OmdbApiClient(client: http.Client()));
    _viewModel = FilmeDetalhesViewModel(repository: repository);
    _viewModel.buscarfilmeDetalhes(widget.imdbId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.netflixRed));
          }

          if (_viewModel.msgErro != null) {
            return Center(child: Text(_viewModel.msgErro!));
          }

          final movie = _viewModel.filmeDetalhes;
          if (movie == null) return const SizedBox.shrink();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    if (movie.poster != 'N/A')
                      Image.network(
                        movie.poster,
                        width: double.infinity,
                        height: 400,
                        fit: BoxFit.cover,
                      )
                    else
                      Container(
                        width: double.infinity,
                        height: 400,
                        color: Colors.grey[900],
                        child: const Icon(Icons.movie, size: 100, color: Colors.white54),
                      ),
                    Container(
                      height: 400,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black54,
                            Colors.transparent,
                            AppColors.backgroundBlack,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(movie.year, style: const TextStyle(color: AppColors.textGray)),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            color: Colors.grey[800],
                            child: const Text('HD', style: TextStyle(fontSize: 10)),
                          ),
                          const SizedBox(width: 16),
                          Text(movie.runtime, style: const TextStyle(color: AppColors.textGray)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Play'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(movie.plot, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 16),
                      Text('Elenco: ${movie.actors}', style: const TextStyle(color: AppColors.textGray)),
                      const SizedBox(height: 4),
                      Text('Diretor: ${movie.director}', style: const TextStyle(color: AppColors.textGray)),
                      const SizedBox(height: 4),
                      Text('Gênero: ${movie.genre}', style: const TextStyle(color: AppColors.textGray)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
