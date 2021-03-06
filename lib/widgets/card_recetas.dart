import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mis_recetas/bloc/receta_bloc.dart';
import 'package:mis_recetas/model/receta_model.dart';
import 'package:mis_recetas/pages/receta_page.dart';

class CardRecetas extends StatefulWidget {

  @override
  _CardRecetasState createState() => _CardRecetasState();
}

class _CardRecetasState extends State<CardRecetas> {

  RecetaBloc recetaBloc = new RecetaBloc();

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    final widthScreen = _screenSize.width;

    return StreamBuilder<List<Receta>>(
      stream: recetaBloc.recetasStream,
      builder: (context, snapshot){

        print(snapshot.data);
        
        if(snapshot.hasData){

          List<Receta> recetas = snapshot.data;

          return ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: recetas.length,
            itemBuilder: (context, i){

              Receta receta = recetas[i];
              print(receta.name);
              return InkWell(
                      onTap: () {
                        //recetaBloc.obtenerReceta(receta.name);
                        Navigator.pushNamed(context, RecetaPage.routeName, arguments: receta);
                      },
                      child: _tarjeta(receta, widthScreen));

            }
          );
        }
        else {
          recetaBloc.obtenerRecetas();
          return Container();
        }

      }
    );
  }

  _imagenReceta(String name, String photo) {

    return Container(
      decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                    offset: new Offset(0.0, 5.0),
                    blurRadius: 10.0,
                ),
              ]
            ),
      height: 150.0,
      width: 150.0,
      //padding: EdgeInsets.all(20.0),
      
      child: Hero(
        tag: name,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(75.0), 
          child: _getImagen(photo),
          ),
        ),
    );

  }

    Image _getImagen(String photo) {
    try{
      //return Image.file(File(photo), fit: BoxFit.cover,);
      return Image.asset(photo, fit: BoxFit.cover);
    } catch (e) {
      return Image.asset('assets/logo.png', fit: BoxFit.cover);
    }

  }

  Widget _infoColeccion(double width, Receta receta){

    int textMax = ((width - 235)/10).truncate();// .round();

    print(textMax);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      width: width - 228.0,
      height: 150,
      padding: EdgeInsets.only(bottom: 30.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: width*4.8/8, height:  width*1.65/8, color: Colors.transparent, 
                alignment: Alignment.topRight,
                child: IconButton(
                  alignment: Alignment.topRight,
                  iconSize: 15,
                  padding: EdgeInsets.all(5),
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  //splashColor: Colors.transparent,
                  splashRadius: 15,
                  icon: Icon(Icons.favorite, color: receta.favourite ? Colors.red : Colors.grey,), 
                  onPressed: (){
                    //receta.favourite 
                      /*? collectionBloc.coleccionFavorita(collectionModel.uid, false)
                      : collectionBloc.coleccionFavorita(collectionModel.uid, true);*/
                  }
                ),
              ),
            ],
          ), 
          Text(
            receta.name.length > (textMax + 2) ? receta.name.substring(0, textMax + 2) + '...' :  receta.name,
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
              //Expanded(child: SizedBox(width: double.infinity,)),
          //Expanded(child: SizedBox(width: double.infinity,)),
          /*Text(
            receta.description.length > (textMax + 15) ? receta.description.substring(0, textMax + 15) + '...' :  receta.description,
            style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal)),*/
          Expanded(child: SizedBox(height: double.infinity,)),
          Row(
            children: [
              Expanded(child: SizedBox(width: double.infinity,)),
              Text('Tiempo: ${receta.time}', style: TextStyle(color: Colors.grey[700], fontSize: 12)),
              Expanded(child: SizedBox(width: double.infinity,)),
              Text('Gente : ${receta.people}' , style: TextStyle(color: Colors.grey[700], fontSize: 12)),
              Expanded(child: SizedBox(width: double.infinity,)),
            ],
          ),
          Expanded(child: SizedBox(height: double.infinity,)),
        ]
      ),
    );

  }

  Widget _tarjeta(Receta receta, double widthScreen) {

    return Container(
      alignment: Alignment.center,
      height: widthScreen*5/8,
      width: widthScreen*6/8,
      margin: EdgeInsets.symmetric(vertical: 20),

      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            width: widthScreen*6/8 - 10,
            height: widthScreen*4/8 - 10,
            //margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                    offset: new Offset(0.0, 0.0),
                    blurRadius: 20.0,
                ),
              ],
            ),
            child: _infoColeccion(widthScreen, receta)
            
          ),
          Column(
            children: <Widget>[
              _imagenReceta(receta.name, receta.photo),
              SizedBox(height: 50,)
            ]
          )
          
        ],
      ),

    );

  }

}