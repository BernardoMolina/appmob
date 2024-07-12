import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class SQLHelper{
  static Future<void> createTables(sql.Database database) async{
    await database.execute("""CREATE TABLE consulta(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    sintoma TEXT,
    obs TEXT,
    presc TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
    await database.execute("""CREATE TABLE medico(
    idmed INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    nome TEXT,
    cpf TEXT,
    email TEXT,
    telefone TEXT,
    registro TEXT,
    foto TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async{
    return sql.openDatabase("database_name.db",version: 1,
        onCreate: (sql.Database database, int version) async{
          await createTables(database);
        });
  }



}