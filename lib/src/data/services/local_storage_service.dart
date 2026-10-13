import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static final LocalStorageService instance = LocalStorageService._init();
  
  static const String tabelaContaAcesso = 'tb_conta_acesso';
  static const String tabelaPerfil = 'tb_perfil';

  LocalStorageService._init();

  Future<void> initDB() async {
    await Hive.initFlutter();
    await Hive.openBox(tabelaContaAcesso);
    await Hive.openBox(tabelaPerfil);
  }
}
