import 'package:sqflite/sqflite.dart' as sql;
import 'package:appmedico/app-core/persistence/db_helper.dart';

class MedicoDb{

  static Future<int> createMedico(String nome, String cpf, String registro,String telefone,String email) async{
    final db = await SQLHelper.db();

    final medico = {'nome' : nome, 'cpf' :cpf, 'registro' : registro, 'telefone' : telefone, 'email' : email};
    final idmed = await db.insert('medico', medico,conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return idmed;
  }

  static Future<List<Map<String, dynamic>>> getAllMedico() async{
    final db = await SQLHelper.db();
    return db.query('medico', orderBy: 'idmed');
  }

  static Future<List<Map<String, dynamic>>> getSingleMedico(int idmed) async{
    final db = await SQLHelper.db();
    return db.query('medico', where: "idmed = ?", whereArgs: [idmed], limit: 1);

  }
  static Future<int> updateMedico(int idmed, String nome, String cpf, String registro,String telefone,String email) async{
    final db = await SQLHelper.db();
    final medico = {
      'nome': nome,
      'cpf': cpf,
      'registro': registro,
      'telefone': telefone,
      'email': email,
      'createdAt': DateTime.now().toString()
    };
    final result =
    await db.update('medico', medico, where: "idmed = ?", whereArgs: [idmed]);
    return result;
  }

  static Future<int> updateMedicofoto(int idmed, String foto) async{
    final db = await SQLHelper.db();
    final medico = {
      'foto': foto,
      'createdAt': DateTime.now().toString()
    };
    final result =
    await db.update('medico', medico, where: "idmed = ?", whereArgs: [idmed]);
    return result;
  }
}