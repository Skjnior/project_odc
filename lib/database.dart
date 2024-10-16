// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:project_odc/dao/user_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'entity/user_entity.dart';



part 'database.g.dart'; // the generated code will be there



@Database(version: 1, entities: [Utilisateur])
abstract class AppDatabase extends FloorDatabase {
  UtilisateurDao get utilisateurDao;
}