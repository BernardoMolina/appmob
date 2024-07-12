import 'package:sqflite/sqflite.dart' as sql;
import 'package:appmedico/app-core/persistence/db_helper.dart';

class ConsultaDb{
  static Future<int> createConsulta(String sintoma, String obs, String presc,int idpaciente) async{
    final db = await SQLHelper.db();

    final consulta = {'sintoma' : sintoma, 'obs' :obs, 'presc' : presc, 'idpaciente': idpaciente};
    final id = await db.insert('consulta', consulta,conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllConsulta() async{
    final db = await SQLHelper.db();
    return db.query('consulta', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleConsulta(int id) async{
    final db = await SQLHelper.db();
    return db.query('consulta', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getConsultaFromPaciente(int idpaciente) async{
    final db = await SQLHelper.db();
    return db.query('consulta', where: "idpaciente = ?", whereArgs: [idpaciente], orderBy: 'id');

  }

  static Future<int> updateConsulta(int id, String sintoma, String obs, String presc) async{
    final db = await SQLHelper.db();
    final consulta = {
      'sintoma': sintoma,
      'obs': obs,
      'presc': presc,
      'createdAt': DateTime.now().toString()
    };
    final result =
    await db.update('consulta', consulta, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteConsulta(int id) async {
    final db = await SQLHelper.db();
    try{
      await db.delete('consulta', where: "id = ?", whereArgs: [id]);
    }catch(e){}
  }
}