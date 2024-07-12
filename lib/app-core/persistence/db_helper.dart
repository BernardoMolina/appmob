import 'package:sqflite/sqflite.dart' as sql;


class SQLHelper{
  static Future<void> createTables(sql.Database database) async{
    await database.execute("""CREATE TABLE medico(
    idmed INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    nome TEXT,
    cpf TEXT,
    email TEXT,
    telefone TEXT,
    registro TEXT,
    foto TEXT,
    createdAt TEXT NOT NULL DEFAULT (datetime('now', 'localtime'))
    )""");
    await database.execute("""CREATE TABLE paciente(
    idpac INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    nome TEXT,
    email TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
    await database.execute("""CREATE TABLE consulta(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    sintoma TEXT,
    obs TEXT,
    presc TEXT,
    idpaciente INTEGER,
    createdAt TEXT NOT NULL DEFAULT (datetime('now', 'localtime')),
    FOREIGN KEY (idpaciente) REFERENCES paciente(idpac)
    )""");
  }

  static Future<sql.Database> db() async{
    return sql.openDatabase("database_name.db",version: 1,
        onCreate: (sql.Database database, int version) async{
          await createTables(database);
        });
  }



}