import 'package:floor/floor.dart';
import 'package:project_odc/entity/user_entity.dart';



@dao
abstract class UtilisateurDao {

  @Query('SELECT * FROM utilisateurs')
  Future<List<Utilisateur>> findAllUser();

  @Query("SELECT * FROM utilisateurs WHERE id = :id")
  Future<Utilisateur?> findUser(int id);

  @insert
  Future<void> insertUtilisateur(Utilisateur user);

  @Update(onConflict: OnConflictStrategy.replace)

  Future<int> updateUtilisateur(Utilisateur user);

  @delete
  Future<void> deleteUtilisateur(Utilisateur user);

}