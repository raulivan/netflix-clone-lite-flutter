import 'package:flutter/material.dart';
import 'package:netflixclone/src/core/app.dart';
import 'package:netflixclone/src/data/services/local_storage_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.instance.initDB();
  runApp(const NetFLixCloneApp());
}


//duda-isaOlimp-cordeiro-luca-nando-heitor
//seus alunos queridos :)
//<3