import 'package:flutter/material.dart';
import 'package:netflixclone/src/core/app_colors.dart';
import 'package:netflixclone/src/ui/view_models/home_view_model.dart';
import 'package:netflixclone/src/ui/view_models/login_view_model.dart';
import 'package:netflixclone/src/ui/views/home/widgets/movie_row.dart';

class HomePage extends StatefulWidget {
  final HomeViewModel homeViewModel;
  final LoginViewModel loginViewModel;

  const HomePage({super.key, required this.homeViewModel, required this.loginViewModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.homeViewModel.loadHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withAlpha(178),
        elevation: 0,
        title: const Text('NETFLIX Lite', style: TextStyle(color: AppColors.netflixRed, fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton<String>(
            icon: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
            color: Colors.grey[900],
            onSelected: (value) {
              if (value == 'switch') {
                widget.loginViewModel.unselectProfile();
              } else if (value == 'logout') {
                widget.loginViewModel.logout();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'switch',
                child: Text('Trocar de Perfil', style: TextStyle(color: Colors.white)),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Sair', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.homeViewModel,
        builder: (context, _) {
          if (widget.homeViewModel.isLoading && widget.homeViewModel.categoriasPadrao['Batman']!.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: AppColors.netflixRed));
          }

          if (widget.homeViewModel.error != null && widget.homeViewModel.categoriasPadrao['Batman']!.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: AppColors.textGray, size: 48),
                    SizedBox(height: 16),
                    Text(
                      'Nenhum filme disponível no momento.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Adicione a chave da API OMDb ou verifique sua conexão.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textGray, fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.only(top: 100, bottom: 20),
            children: widget.homeViewModel.categoriasPadrao.entries.map((entry) {
              return MovieRow(
                title: entry.key,
                filmes: entry.value,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
