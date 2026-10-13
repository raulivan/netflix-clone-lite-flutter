import 'package:hive/hive.dart';
import 'package:netflixclone/src/data/services/local_storage_service.dart';
import 'package:netflixclone/src/models/conta_acesso.dart';
import 'package:netflixclone/src/models/perfil_conta.dart';

class ContaAcessoRepository {
  final LocalStorageService db = LocalStorageService.instance;


  Future<void> createUser(ContaAcesso conta) async {
    final box = Hive.box(LocalStorageService.tabelaContaAcesso);
    await box.put(conta.email, conta.password);
  }

  Future<ContaAcesso?> getUser(String email, String password) async {
    final box = Hive.box(LocalStorageService.tabelaContaAcesso);
    final storedPassword = box.get(email);
    
    if (storedPassword != null && storedPassword == password) {
      return ContaAcesso(email: email, password: password);
    }
    return null;
  }

  Future<bool> checkEmailExists(String email) async {
    final box = Hive.box(LocalStorageService.tabelaContaAcesso);
    return box.containsKey(email);
  }

  Future<List<PerfilConta>> getProfiles(String email) async {
    final box = Hive.box(LocalStorageService.tabelaPerfil);
    final profiles = box.get(email);
    if (profiles != null) {
      return (profiles as List).map((e) => PerfilConta.fromMap(e)).toList();
    }
    return [];
  }

  Future<void> saveProfiles(String email, List<PerfilConta> profiles) async {
    final box = Hive.box(LocalStorageService.tabelaPerfil);
    final map = profiles.map((e) => e.toMap()).toList();
    await box.put(email, map);
  }
}