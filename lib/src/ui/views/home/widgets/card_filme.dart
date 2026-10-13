import 'package:flutter/material.dart';
import 'package:netflixclone/src/models/filme.dart';
import 'package:netflixclone/src/ui/views/filme_detalhes/filme_detalhes_page.dart';

class CardFilmeWidget extends StatefulWidget {
  final Filme filme;

  const CardFilmeWidget({super.key, required this.filme});

  @override
  State<CardFilmeWidget> createState() => _CardFilmeWidgetState();
}

class _CardFilmeWidgetState extends State<CardFilmeWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FilmeDetalhesPage(imdbId: widget.filme.imdbId),
            ),
          );
        },
        child: AnimatedScale(
          scale: _isHovered ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: 120,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(4.0),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: Colors.black.withAlpha(150),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ]
                  : null,
              image: widget.filme.poster != 'N/A'
                  ? DecorationImage(
                      image: NetworkImage(widget.filme.poster),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: widget.filme.poster == 'N/A'
                ? const Center(child: Icon(Icons.movie, size: 50, color: Colors.white54))
                : null,
          ),
        ),
      ),
    );
  }
}