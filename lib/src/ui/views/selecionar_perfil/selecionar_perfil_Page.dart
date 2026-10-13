import 'package:flutter/material.dart';
import 'package:netflixclone/src/core/app_colors.dart';
import 'package:netflixclone/src/ui/view_models/login_view_model.dart';
import 'package:netflixclone/src/ui/views/selecionar_perfil/widgets/card_perfil_widget.dart';

class SelecionarPerfilPage extends StatefulWidget {
  final LoginViewModel loginViewModel;

  const SelecionarPerfilPage({super.key, required this.loginViewModel});

  @override
  State<SelecionarPerfilPage> createState() => _SelecionarPerfilPageState();
}

class _SelecionarPerfilPageState extends State<SelecionarPerfilPage> {
  bool _isEditing = false;

  void _showTelaEdicaoDialog(Map<String, dynamic> profile) {
    final controller = TextEditingController(text: profile['name']);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Editar Perfil', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Nome',
              labelStyle: TextStyle(color: AppColors.textGray),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textGray)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          actions: [
            if (widget.loginViewModel.profiles.length > 1)
              TextButton(
                onPressed: () {
                  widget.loginViewModel.deleteProfile(profile['id']);
                  Navigator.pop(context);
                },
                child: const Text('Excluir', style: TextStyle(color: Colors.red)),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: AppColors.textGray)),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  widget.loginViewModel.updateProfile(profile['id'], controller.text.trim());
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.netflixRed),
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _showTelaIncluirPerfilDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Adicionar Perfil', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Nome',
              labelStyle: TextStyle(color: AppColors.textGray),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textGray)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: AppColors.textGray)),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  widget.loginViewModel.addProfile(controller.text.trim());
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.netflixRed),
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NETFLIX CLONE', style: TextStyle(color: AppColors.netflixRed, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isEditing ? 'Gerenciar Perfis' : 'Quem está assistindo?',
              style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 40),
            ListenableBuilder(
              listenable: widget.loginViewModel,
              builder: (context, _) {
                final profiles = widget.loginViewModel.profiles;
                return Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: [
                    ...profiles.map((profile) {
                      return CardPerfilWidget(
                        perfil: profile.toMap(),
                        estaEditando: _isEditing,
                        onTap: () {
                          if (_isEditing) {
                            _showTelaEdicaoDialog(profile.toMap());
                          } else {
                            widget.loginViewModel.selectProfile();
                          }
                        },
                      );
                    }),
                    if (_isEditing && profiles.length < 5)
                      GestureDetector(
                        onTap: _showTelaIncluirPerfilDialog,
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: AppColors.textGray, width: 2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(Icons.add, size: 60, color: AppColors.textGray),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Adicionar',
                              style: TextStyle(color: AppColors.textGray, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}


