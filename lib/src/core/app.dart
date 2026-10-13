import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflixclone/src/core/theme.dart';
import 'package:netflixclone/src/data/repositories/filmes_repository.dart';
import 'package:netflixclone/src/data/services/omdb_api_client.dart';
import 'package:netflixclone/src/ui/view_models/home_view_model.dart';
import 'package:netflixclone/src/ui/view_models/login_view_model.dart';
import 'package:netflixclone/src/ui/view_models/pesquisar_view_model.dart';
import 'package:netflixclone/src/ui/views/login/login_page.dart';
import 'package:netflixclone/src/ui/views/main_layout.dart';
import 'package:netflixclone/src/ui/views/selecionar_perfil/selecionar_perfil_Page.dart';


class NetFLixCloneApp extends StatefulWidget {
  const NetFLixCloneApp({super.key});

  @override
  State<NetFLixCloneApp> createState() => _NetFLixCloneAppState();
}

class _NetFLixCloneAppState extends State<NetFLixCloneApp> {
  late final LoginViewModel _loginViewModel;
  late final HomeViewModel _homeViewModel;
  late final PerquisarViewModel _pesquisarViewModel;

  @override
  void initState() {
    super.initState();
    
    final apiClient = OmdbApiClient(client: http.Client());
    final repository = FilmeRepository(apiClient: apiClient);

    _loginViewModel = LoginViewModel();
    _homeViewModel = HomeViewModel(repository: repository);
    _pesquisarViewModel = PerquisarViewModel(repository: repository);
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    _homeViewModel.dispose();
    _pesquisarViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetFlixClone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: ListenableBuilder(
        listenable: _loginViewModel,
        builder: (context, _) {
          if (_loginViewModel.estaAutenticado) {
            if (_loginViewModel.ehPerfilSelecionado) {
              return MainLayout(
                homeViewModel: _homeViewModel,
                pesquisarViewModel: _pesquisarViewModel,
                loginViewModel: _loginViewModel,
              );
            } else {
              return SelecionarPerfilPage(loginViewModel: _loginViewModel);
            }
          } else {
            return LoginPage(viewModel: _loginViewModel);
          }
        },
      ),
    );
  }
}
