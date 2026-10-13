import 'package:flutter/material.dart';
import 'package:netflixclone/src/data/repositories/filmes_repository.dart';
import 'package:netflixclone/src/models/filme.dart';

class PerquisarViewModel extends ChangeNotifier {
  final FilmeRepository repository;

  PerquisarViewModel({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _msgErro;
  String? get msgErro => _msgErro;

  List<Filme> _resultados = [];
  List<Filme> get resultados => _resultados;

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      _resultados = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _msgErro = null;
    notifyListeners();

    try {
      _resultados = await repository.searchMovies(query);
      if (_resultados.isEmpty) {
        _msgErro = 'Ixi, não achei nada com "$query"';
      }
    } catch (e) {
      _msgErro = 'Erro ao pesquisar filmes';
      _resultados = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
