import 'package:sqflite/sqflite.dart' as sql;
import 'package:appmedico/app-core/persistence/db_helper.dart';

class PacienteDb{

  static Future<int> createPaciente(String nome,String email) async{
    final db = await SQLHelper.db();

    final paciente = {'nome' : nome, 'email' : email};
    final idpac = await db.insert('paciente', paciente,conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return idpac;
  }

  static Future<List<Map<String, dynamic>>> getAllPaciente() async{
    final db = await SQLHelper.db();
    return db.query('paciente', orderBy: 'idpac');
  }

  static Future<List<Map<String, dynamic>>> getSinglePaciente(int idpac) async{
    final db = await SQLHelper.db();
    return db.query('paciente', where: "idpac = ?", whereArgs: [idpac], limit: 1);

  }
  static Future<int> updatePaciente(int idpac, String nome,String email) async{
    final db = await SQLHelper.db();
    final paciente = {
      'nome': nome,
      'email': email,
      'createdAt': DateTime.now().toString()
    };
    final result =
    await db.update('paciente', paciente, where: "idpac = ?", whereArgs: [idpac]);
    return result;
  }

}