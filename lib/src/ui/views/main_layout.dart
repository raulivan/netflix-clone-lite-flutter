import 'package:flutter/material.dart';
import 'package:netflixclone/src/ui/view_models/home_view_model.dart';
import 'package:netflixclone/src/ui/view_models/login_view_model.dart';
import 'package:netflixclone/src/ui/view_models/pesquisar_view_model.dart';
import 'package:netflixclone/src/ui/views/home/home_page.dart';
import 'package:netflixclone/src/ui/views/pesquisar/pesquisar_page.dart';
class MainLayout extends StatefulWidget {
  final HomeViewModel homeViewModel;
  final PerquisarViewModel pesquisarViewModel;
  final LoginViewModel loginViewModel;

  const MainLayout({
    super.key,
    required this.homeViewModel,
    required this.pesquisarViewModel,
    required this.loginViewModel,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomePage(
        homeViewModel: widget.homeViewModel,
        loginViewModel: widget.loginViewModel,
      ),
      PesquisarPage(pesquisarViewModel: widget.pesquisarViewModel),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
