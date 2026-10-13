import 'package:flutter/material.dart';
import 'package:netflixclone/src/data/repositories/filmes_repository.dart';
import 'package:netflixclone/src/models/filme_detalhes.dart';

class FilmeDetalhesViewModel extends ChangeNotifier {
  final FilmeRepository repository;

  FilmeDetalhesViewModel({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _msgErro;
  String? get msgErro => _msgErro;

  FilmeDetalhes? _filmeDetalhes;
  FilmeDetalhes? get filmeDetalhes => _filmeDetalhes;

  Future<void> buscarfilmeDetalhes(String imdbId) async {
    _isLoading = true;
    _msgErro = null;
    notifyListeners();

    try {
      _filmeDetalhes = await repository.getMovieDetails(imdbId);
    } catch (e) {
      _msgErro = 'Falha ao carregar os detalhes do filme: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
