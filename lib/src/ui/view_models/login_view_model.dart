import 'package:flutter/material.dart';
import 'package:netflixclone/src/data/repositories/conta_acesso_repository.dart';
import 'package:netflixclone/src/models/conta_acesso.dart';
import 'package:netflixclone/src/models/perfil_conta.dart';

class LoginViewModel extends ChangeNotifier{
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  bool _estaAutenticado = false;
  bool _ehPerfilSelecionao = false;
  bool _isLoading = false;
  String? _mensagemErro;

  List<PerfilConta> _profiles = [];

  bool get estaAutenticado => _estaAutenticado;
  bool get ehPerfilSelecionado => _ehPerfilSelecionao;
  bool get isLoading => _isLoading;
  String? get mensagemErro => _mensagemErro;
  
  List<PerfilConta> get profiles => _profiles;

  final ContaAcessoRepository _db = ContaAcessoRepository();

  Future<void> _loadProfiles(String email) async {
    _profiles = await _db.getProfiles(email);
  }

  Future<void> updateProfile(String id, String novoPerfil) async {
    if (emailController.text.trim().isEmpty) return;
    final index = _profiles.indexWhere((p) => p.id == id);
    if (index != -1) {
      _profiles[index].name = novoPerfil;
      await _db.saveProfiles(emailController.text.trim(), _profiles);
      notifyListeners();
    }
  }

   Future<void> addProfile(String name) async {
    if (emailController.text.trim().isEmpty) return;
    final colors = [0xFF2196F3, 0xFFFFEB3B, 0xFF4CAF50, 0xFF9C27B0, 0xFFF44336];
    _profiles.add(PerfilConta(
      id: DateTime.now().millisecondsSinceEpoch.toString(), 
      name: name, 
      colorValue: colors[_profiles.length % colors.length].toString()));

    await _db.saveProfiles(emailController.text.trim(), _profiles);
    notifyListeners();
  }

  Future<void> deleteProfile(String id) async {
    if (emailController.text.trim().isEmpty) return;
    _profiles.removeWhere((p) => p.id == id);
    await _db.saveProfiles(emailController.text.trim(), _profiles);
    notifyListeners();
  }

  Future<void> login() async {
    _isLoading = true;
    _mensagemErro = null;
    notifyListeners();

    try {
      final user = await _db.getUser(emailController.text.trim(), senhaController.text.trim());
      if (user != null) {
        await _loadProfiles(emailController.text.trim());
        _estaAutenticado = true;
        _ehPerfilSelecionao = false;
      } else {
        _mensagemErro = 'Email ou senha inválidos';
      }
    } catch (e) {
      _mensagemErro = 'Falha ao realizar o loginLogin';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createAccount(List<String> profileNames) async {
    _isLoading = true;
    _mensagemErro = null;
    notifyListeners();

    print('Chegou');
    try {
      final exists = await _db.checkEmailExists(emailController.text.trim());
      if (exists) {
        _mensagemErro = 'Email já cadastrado';
      } else {
        final novaConta = ContaAcesso(email: emailController.text.trim(), 
          password: senhaController.text.trim());
        await _db.createUser(novaConta);
        
        final List<PerfilConta> newProfiles = [];
        final colors = [0xFF2196F3, 0xFFFFEB3B, 0xFF4CAF50, 0xFF9C27B0, 0xFFF44336];
        
        for (int i = 0; i < profileNames.length; i++) {
          newProfiles.add(PerfilConta(
            id: DateTime.now().millisecondsSinceEpoch.toString() + i.toString(),
            name: profileNames[i], 
            colorValue:  (colors[i % colors.length]).toString()));
        }
        await _db.saveProfiles(emailController.text.trim(), newProfiles);

        await _loadProfiles(emailController.text.trim());
        _estaAutenticado = true;
        _ehPerfilSelecionao = false;
      }
    } catch (e) {
      print(e);
      _mensagemErro = 'Falha ao criar a conta';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectProfile() {
    _ehPerfilSelecionao = true;
    notifyListeners();
  }

  void unselectProfile() {
    _ehPerfilSelecionao = false;
    notifyListeners();
  }

  void logout() {
    _estaAutenticado = false;
    _ehPerfilSelecionao = false;
    notifyListeners();
  }
}