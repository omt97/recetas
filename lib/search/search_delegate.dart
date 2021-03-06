import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mis_recetas/bloc/receta_bloc.dart';
import 'package:mis_recetas/model/receta_model.dart';

class DataSearch extends SearchDelegate{

  String seleccion = '';
  final recetaModel = new Receta();

  final recetaBloc = new RecetaBloc();


  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      //primaryColor: getAppColor(userBloc.color, 400),
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      primaryColorBrightness: Brightness.light,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.clear), 
          onPressed: (){
            query = '';

          }
        ),

      ];
    }
  
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ), 
      onPressed: (){
        close(context, null);
      }
    );
  }
  
  @override
  Widget buildResults(BuildContext context) {
     return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        //color: getAppColor(userBloc.color, 500),
        child: Text(seleccion)
      ),
    );
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {

    recetaBloc.obtenerRecetas();


    return StreamBuilder(
      stream: recetaBloc.recetasStream,
      builder: (BuildContext context, AsyncSnapshot<List<Receta>> snapshot){
        if (snapshot.hasData){
          
          List<Receta> colecciones = snapshot.data;


          return ListView.builder(
            
            itemCount: colecciones.length,
            itemBuilder: (BuildContext context, int i) {
              return InkWell(
                /*onTap: (){
                  collectionBloc.obtenerColeccion(colecciones[i]);
                  Navigator.pushNamed(context, CollectionPage.routeName, arguments: colecciones[i].title);
                  //close(context, null);
                },*/
                child: Container(
                  margin: EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    //color: getAppColor(userBloc.color, 50)
                  ),
                  child: ListTile(
                    leading: _imagenColeccion(colecciones[i].name, colecciones[i].photo),
                    title: Text(colecciones[i].name),
                    //subtitle: ,
                  ),
                ),
              );
            },
          );

        } else {
          return Container();
        }
      },
    );
  }

  Widget _imagenColeccion(String title, String photo){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0)
      ),
      height: 50.0,
      width: 50.0,
      
      child: Hero(
        tag: title,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0), 
          child: photo != null ? Image.asset(
            photo,
            fit: BoxFit.cover,
          ): Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }




}