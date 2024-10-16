import 'package:floor/floor.dart';

@Entity(
 tableName: "utilisateurs",
)
class Utilisateur {

  //@primaryKey(autoGenerate: true)
 @PrimaryKey(autoGenerate: true)
  int? id;
  String nom;
  String prenom;
  String telephone;

  Utilisateur({this.id, required this.nom, required this.prenom, required this.telephone});

}