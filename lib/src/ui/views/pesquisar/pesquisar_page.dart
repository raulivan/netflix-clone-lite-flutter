import 'package:flutter/material.dart';
import 'package:netflixclone/src/core/app_colors.dart';
import 'package:netflixclone/src/ui/view_models/pesquisar_view_model.dart';
import 'package:netflixclone/src/ui/views/filme_detalhes/filme_detalhes_page.dart';

class PesquisarPage extends StatefulWidget {
  final PerquisarViewModel pesquisarViewModel;

  const PesquisarPage({super.key, required this.pesquisarViewModel});

  @override
  State<PesquisarPage> createState() => _PesquisarPageState();
}

class _PesquisarPageState extends State<PesquisarPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Pesquisar Filmes...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: AppColors.textGray),
          ),
          style: const TextStyle(color: Colors.white),
          onSubmitted: (value) {
            widget.pesquisarViewModel.search(value);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              widget.pesquisarViewModel.search(_searchController.text);
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.pesquisarViewModel,
        builder: (context, _) {
          if (widget.pesquisarViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.netflixRed));
          }

          if (widget.pesquisarViewModel.msgErro != null) {
            return Center(child: Text(widget.pesquisarViewModel.msgErro!));
          }

          final results = widget.pesquisarViewModel.resultados;
          if (results.isEmpty) {
            return const Center(
              child: Text('Pesquiser por filmnes, series ...', style: TextStyle(color: AppColors.textGray)),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final movie = results[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FilmeDetalhesPage(imdbId: movie.imdbId),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(4.0),
                    image: movie.poster != 'N/A'
                        ? DecorationImage(
                            image: NetworkImage(movie.poster),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: movie.poster == 'N/A'
                      ? const Center(child: Icon(Icons.movie, color: Colors.white54))
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
