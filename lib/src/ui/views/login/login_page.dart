import 'package:flutter/material.dart';
import 'package:netflixclone/src/core/app_colors.dart';
import 'package:netflixclone/src/ui/view_models/login_view_model.dart';
import 'package:netflixclone/src/ui/views/login/criar_conta.dart';

class LoginPage extends StatefulWidget {
  final LoginViewModel viewModel;
  const LoginPage({super.key,required this.viewModel});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'NETFLIX',
                  style: TextStyle(
                    color: AppColors.netflixRed,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 48),
                // EMAIL
                TextFormField(
                  controller: widget.viewModel.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: AppColors.darkGray,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                ),
                SizedBox(height: 16),
                // SENHA
                TextFormField(
                  controller: widget.viewModel.senhaController,
                  decoration: const InputDecoration(
                    labelText: "Senha",
                    filled: true,
                    fillColor: AppColors.darkGray,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none)
                  ),
                  obscureText: true
                ),
                const SizedBox(height: 24),
                //BOTÃO DE ENTRAR
                ListenableBuilder(
                listenable: widget.viewModel,
                builder: (context, _) {
                  if (widget.viewModel.isLoading) {
                    return const CircularProgressIndicator(color: AppColors.netflixRed);
                  }
                  
                  return Column(
                    children: [
                      if (widget.viewModel.mensagemErro != null) ...[
                        Text(
                          widget.viewModel.mensagemErro!,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 8),
                      ],
                      ElevatedButton(
                        onPressed: () {
                          widget.viewModel.login();
                        },
                        child: const Text('Entrar'),
                      ),
                    ],
                  );
                },
              ),
              // Criar conta de usuário
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CriarConta(viewModel: widget.viewModel,),
                    ),
                  );
                },
                child: const Text(
                  'É novo por aqui? Crie sua conta agora!',
                  style: TextStyle(color: AppColors.textGray),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
