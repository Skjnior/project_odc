import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project_odc/entity/user_entity.dart';
import 'package:project_odc/screens/home.dart';
import 'package:project_odc/screens/login.dart';
import 'database.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase.databaseBuilder('app.db').build();

/*
  await database.utilisateurDao.insertUtilisateur(
     Utilisateur( nom: "Kaba", prenom: "Mohamed", telephone: "610111627"),
  );
*/

  List<Utilisateur> users = await database.utilisateurDao.findAllUser();

 /* for(var user in users){
    print(user.nom);
  }*/

  runApp( MyApp(
    database: database,
  ));
}


class MyApp extends StatelessWidget {
   MyApp({super.key, required this.database});

  AppDatabase database;


  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      title: "ODC",
      home:  MyHomePage(database: database,),
    );
  }
}
