import 'package:flutter/material.dart';
import 'package:mis_recetas/pages/create_page.dart';
import 'package:mis_recetas/pages/receta_page.dart';
import 'package:mis_recetas/pages/home_page.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mis recetas',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        HomePage.routeName : (BuildContext context) => HomePage(),
        RecetaPage.routeName : (BuildContext context) => RecetaPage(),
        CreatePage.routeName : (BuildContext context) => CreatePage(),
      }, 
    );
  }
}