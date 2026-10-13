import 'package:flutter/material.dart';
import 'package:netflixclone/src/data/repositories/filmes_repository.dart';
import 'package:netflixclone/src/models/filme.dart';

class HomeViewModel extends ChangeNotifier {
  final FilmeRepository repository;

  HomeViewModel({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String? _error;
  String? get error => _error;

  Map<String, List<Filme>> categoriasPadrao = {
    'Marvel Universe': [],
    'Star Wars': [],
    'Batman': [],
    'Harry Potter': [],
  };

  Future<void> loadHomeData() async {
    if (categoriasPadrao['Batman']!.isNotEmpty) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final marvel = await repository.searchMovies('marvel');
      final starWars = await repository.searchMovies('star wars');
      final batman = await repository.searchMovies('batman');
      final harryPotter = await repository.searchMovies('harry potter');

      categoriasPadrao['Marvel Universe'] = marvel;
      categoriasPadrao['Star Wars'] = starWars;
      categoriasPadrao['Batman'] = batman;
      categoriasPadrao['Harry Potter'] = harryPotter;
    } catch (e) {
      _error = 'Falha ao carregar as categorias: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
