import 'package:flutter/material.dart';
import 'package:mis_recetas/model/ingrediente_model.dart';
import 'package:mis_recetas/model/receta_model.dart';

class RecetaPage extends StatefulWidget {

  static final routeName = 'receta';

  @override
  _RecetaPageState createState() => _RecetaPageState();
}

class _RecetaPageState extends State<RecetaPage> {
  PageController _controller;


    @override
  void initState() {
    super.initState();
    _controller = PageController( initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Receta receta = ModalRoute.of(context).settings.arguments;

    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
          child: Container(
            //height: _screenSize.height,
            color: Colors.grey[200],
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: _screenSize.height/2.55,
                          child: Hero(
                            tag: receta.name,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0), 
                              child: FadeInImage(
                                placeholder: AssetImage(receta.photo), 
                                image:AssetImage(receta.photo),
                                fadeInDuration: Duration(milliseconds: 150),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: _screenSize.height/2.55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.grey.withOpacity(0.0),
                                Colors.grey[200],
                              ],
                              stops: [
                                0.50,
                                1.0
                              ])),
                        ),
                      ]
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      color: Colors.transparent, 
                      width: 330,
                      //height: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 100, horizontal: 25),
                      child: Column(
                        children: <Widget>[
                         Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Ingredientes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              SizedBox(height: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _ingredientes(receta.ingredientes),
                              ),
                              //Text('Ingredientes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                              Text('Pasos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              Center(
                                child: Container(
                                  height: 300,
                                  width: 330,
                                  child: PageView.builder(
                                    controller: _controller,
                                    itemCount: 5,
                                    itemBuilder: (BuildContext context, int pos){
                                      return Container(
                                        margin: EdgeInsets.all(20),
                                        width: 200, 
                                        height: 200,
                                        padding: EdgeInsets.all(20), 
                                        child: Column(
                                          children: [
                                            Text (pos.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),),
                                            SizedBox(height: 10,),
                                            Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lf type ang essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20.0),
                                          boxShadow: [
                                            new BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                  offset: new Offset(0.0, 0.0),
                                                  blurRadius: 10.0,
                                              ),
                                            ],
                                        ),
                                      );
                                    }
                                  ),
                                ),
                              )
                            ]
                         )
                        ],
                      ),  
                    )
                  ],
                ),
                Positioned(
                  top: 225,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                              offset: new Offset(0.0, 0.0),
                              blurRadius: 10.0,
                          ),
                        ],
                      ),
                    alignment: Alignment.center,
                    height: 150,
                    width: 300,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(receta.name , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                      ]
                    ),
                    
                  ),
                )
              ],

            ),
          ),
        ),
      )
    );
  }

  _introducirInformacion(int people, String type, int time) {
    return Text(people.toString());
  }

  _introducirIngredientes(List<Ingrediente> ingredientes) {
    return Container();
  }

  _introducirPasos(List<String> pasos) {
    return Container();
  }

  List<Widget> _ingredientes(List<Ingrediente> ingredientes) {

    List<Widget> textIngr = [];

    for(int i = 0; i < ingredientes.length; ++i){
      textIngr.add(Text('     ' + ingredientes[i].cantidad.toString() + ' ' + ingredientes[i].medida + ' ' + ingredientes[i].name));
      textIngr.add(Divider(thickness: 2,),);
    }

    return textIngr;

  }
}