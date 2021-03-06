import 'ingrediente_model.dart';

class Receta {

  Receta({
    this.name,
    this.description,
    this.photo,
    this.time,
    this.people,
    this.calories,
    this.web,
    this.ingredientes,
    this.pasos,
    this.favourite,
    this.filter
  });

  String name;
  String description;
  String photo;
  int time;
  int people;
  int calories;
  String web;
  List<Ingrediente> ingredientes;
  List<String> pasos;
  bool favourite;
  List<String> filter;

  static Receta fromJson(Map<String, dynamic> json){
    return Receta(name: json["name"], 
                  description: json["description"], 
                  photo: json["photo"], 
                  time: json["time"], 
                  people: json["people"], 
                  calories: json["calories"], 
                  web: json["web"], 
                  ingredientes: [], 
                  pasos: [], 
                  favourite: json["favourite"], 
                  filter: []);
  }
}