import 'package:flutter/material.dart';
import 'package:netflixclone/src/models/filme.dart';
import 'package:netflixclone/src/ui/views/home/widgets/card_filme.dart';

class MovieRow extends StatelessWidget {
  final String title;
  final List<Filme> filmes;

  const MovieRow({
    super.key,
    required this.title,
    required this.filmes,
  });

  @override
  Widget build(BuildContext context) {
    if (filmes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: filmes.length,
            itemBuilder: (context, index) {
              return CardFilmeWidget(filme: filmes[index]);
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}


