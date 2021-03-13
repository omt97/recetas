import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mis_recetas/model/ingrediente_model.dart';
import 'package:mis_recetas/model/receta_model.dart';

class RecetaBloc{

  static Size size;

  static final RecetaBloc _singleton = new RecetaBloc._internal();

  factory RecetaBloc(){
    return _singleton;
  }

  RecetaBloc._internal(){
    obtenerRecetas();
  }

  final _recetasController = StreamController<List<Receta>>.broadcast();

  Stream<List<Receta>> get recetasStream => _recetasController.stream;

  dispose(){
    _recetasController?.close();
  }

  obtenerRecetas() async{

    List<Receta> recetas = [];

    recetas.add(new Receta(name: 'Ensalada de Pasta', description: 'caca con nutella', photo: 'assets/pasta.png', time: 20, people: 3, calories: 4, web: 'a', 
    ingredientes: [
      Ingrediente(name: 'caca', cantidad: 3, medida:'kg'),
      Ingrediente(name: 'fluor', cantidad: 25, medida:'g'),
      Ingrediente(name: 'spicy', cantidad: 12, medida:'pounds'),
      Ingrediente(name: 'love', cantidad: 0, medida:'tones'),
      Ingrediente(name: 'more caca', cantidad: 6, medida:'mg')
    ],
    pasos: null, favourite: true, filter: ['italiana']));
    recetas.add(new Receta(name: 'Poke Bowl Lacitos', description: 'pedo al vapor rustico', photo: 'assets/otro.png', time: 20, people: 3, calories: 4, web: null, ingredientes: [], pasos: null, favourite: true, filter: []));
    print(recetas.length);
    _recetasController.sink.add(recetas);

  }

}