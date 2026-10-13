import 'package:flutter/material.dart';
import 'package:netflixclone/src/core/app_colors.dart';
import 'package:netflixclone/src/ui/view_models/login_view_model.dart';

class CriarConta extends StatefulWidget {
  final LoginViewModel viewModel;
  const CriarConta({super.key, required this.viewModel});

  @override
  State<CriarConta> createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _profilesControllers = [TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NETFLIXCLONE', style: TextStyle(color: AppColors.netflixRed, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Criar conta',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: widget.viewModel.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: AppColors.darkGray,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: widget.viewModel.senhaController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    filled: true,
                    fillColor: AppColors.darkGray,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Perfis (Mínimo de 1)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ..._profilesControllers.asMap().entries.map((entry) {
                  int idx = entry.key;
                  var controller = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: 'Nome do Perfil ${idx + 1}',
                              filled: true,
                              fillColor: AppColors.darkGray,
                              border: const OutlineInputBorder(borderSide: BorderSide.none),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        if (idx > 0)
                          IconButton(
                            icon: const Icon(Icons.remove_circle, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _profilesControllers.removeAt(idx);
                              });
                            },
                          )
                      ],
                    ),
                  );
                }),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _profilesControllers.add(TextEditingController());
                    });
                  },
                  icon: const Icon(Icons.add, color: AppColors.textGray),
                  label: const Text('Adicionar outro perfil', style: TextStyle(color: AppColors.textGray)),
                ),
                const SizedBox(height: 24),
                ListenableBuilder(
                  listenable: widget.viewModel,
                  builder: (context, _) {
                    if (widget.viewModel.isLoading) {
                       return const Center(child: CircularProgressIndicator(color: AppColors.netflixRed));
                    }
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget.viewModel.mensagemErro != null) ...[
                          Text(
                            widget.viewModel.mensagemErro!,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                        ],
                        ElevatedButton(
                          onPressed: () async {
                            List<String> names = _profilesControllers
                                .map((c) => c.text.trim())
                                .where((name) => name.isNotEmpty)
                                .toList();
            
                            if (names.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Adicione pelo menos um perfil válido.')),
                              );
                              return;
                            }
                            print('chegou');
                            await widget.viewModel.createAccount(names);
                            if (widget.viewModel.estaAutenticado && context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Cadastrar'),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
