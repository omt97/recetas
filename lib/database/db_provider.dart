import 'dart:io';

import 'package:mis_recetas/model/receta_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider{

  static Database _database;

  static final DBProvider db = DBProvider._private(); //contructor privado, para hacer un singleton, i asi evitar muchas instancias de la db

  DBProvider._private();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async{

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Recipes ('
          ' name TEXT PRIMARY KEY,'
          ' description TEXT,'
          ' photo TEXT,'
          ' time TEXT,'
          ' people TEXT,'
          ' calories TEXT,'
          ' web TEXT,'
          ' favourite TEXT'
          ')'
        );
        await db.execute(
          'CREATE TABLE Ingredients ('
          ' name TEXT PRIMARY KEY,'
          ' medida TEXT,'
          ' cantidad INTEGER,'
          ' receta TEXT,'
          ' PRIMARY KEY(name, receta),'
          ' FOREIGN KEY(receta) REFERENCES Recipes(name)'
          ')'
        );
        await db.execute(
          'CREATE TABLE Steps ('
          ' numero INTEGER,'
          ' descripcion TEXT,'
          ' receta TEXT,'
          ' PRIMARY KEY(numero, receta),'
          ' FOREIGN KEY(receta) REFERENCES Recipes(name)'
          ')'
        );
        await db.execute(
          'CREATE TABLE FilterReceta ('
          ' name TEXT,'
          ' filter TEXT,'
          ' PRIMARY KEY(name, filter)'
          ')'
        );
        await db.execute(
          'CREATE TABLE Filter ('
          ' filter TEXT PRIMARY KEY,'
          ')'
        );
      }
    );

  /**/

}


  Future<int> nuevaReceta(Receta nuevoScan) async {

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO Recipes (name, description, photo, time, people, calories, web, favourite) "
      "VALUES (${nuevoScan.name}, '${nuevoScan.description}', '${nuevoScan.photo}', '${nuevoScan.time}', '${nuevoScan.people}', '${nuevoScan.calories}', '${nuevoScan.web}', '${nuevoScan.favourite}', '${nuevoScan.photo}')"
    );

    for (int i = 0; i < nuevoScan.ingredientes.length; ++i){
      final res2 = await db.rawInsert(
        "INSERT INTO Ingredientes (name, medida, cantidad, receta) "
        "VALUES (${nuevoScan.ingredientes[i].name}, '${nuevoScan.ingredientes[i].medida}', '${nuevoScan.ingredientes[i].cantidad}', '${nuevoScan.name}')"
      );
    }

    for (int i = 0; i < nuevoScan.pasos.length; ++i){
      final res3 = await db.rawInsert(
        "INSERT INTO Steps (numero, descripcion, receta) "
        "VALUES ($i, '${nuevoScan.pasos[i]}', '${nuevoScan.name}')"
      );
    }

    for (int i = 0; i < nuevoScan.filter.length; ++i){
      final res3 = await db.rawInsert(
        "INSERT INTO FilterReceta (name, filter) "
        "VALUES (${nuevoScan.name}, '${nuevoScan.filter[i]}')"
      );
    }

    return res;

  }

  Future<List<Receta>> getReceta(List<String> filtros) async{

    final db = await database;

    final res1 = await db.rawQuery("SELECT r.name,  r.description, r.photo, r.time, r.people, r.calories, r.web, r.favourite"
                                  "FROM Recipes r ");

    List<Receta> recetas = res1.isNotEmpty 
                                          ? res1.map((s) => Receta.fromJson(s)).toList()
                                          : [];

    for (int i = 0; i < filtros.length; ++i){
      final res = await db.rawQuery("SELECT r.name,  r.description, r.photo, r.time, r.people, r.calories, r.web, r.favourite"
                                    "FROM FilterReceta f, Recipes r "
                                    "WHERE r.name = f.name AND f.filter = ${filtros[i]}");
    }



  }


}