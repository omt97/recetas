import 'package:flutter/material.dart';
import 'package:mis_recetas/bloc/receta_bloc.dart';
import 'package:mis_recetas/widgets/barra_buscadora.dart';
import 'package:mis_recetas/widgets/card_recetas.dart';

class RecetasPage extends StatefulWidget {

  @override
  _RecetasPageState createState() => _RecetasPageState();
}

class _RecetasPageState extends State<RecetasPage> {

  List<String> filtros = [];

  @override
  Widget build(BuildContext context) {

    RecetaBloc.size = MediaQuery.of(context).size;

    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0),
            BarraBuscadora(),
            SizedBox(height: 5.0),
            _filtros(_screenSize),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: _screenSize.width,
              height: _screenSize.height - 176.0,
              child: CardRecetas()
            )
          ],
        ),
      ),
    );
  }

  _filtros(Size screenSize) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: screenSize.width,
      height: 25,
      child: Row(
          children: [
            /*InputChip(
              label: Text('filter')),*/
            RaisedButton.icon(
              elevation: 0,
              disabledElevation: 0,
              highlightElevation: 0,
              shape: StadiumBorder(),
              color: Colors.blue[300],
              onPressed: (){
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {return _getFilters();}
                );
              }, 
              icon: Icon(Icons.filter, size: 20,color: Colors.grey[900],),
              label: Text('')
            ),
            SizedBox(width: 5.0),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _rowFilter(),
                )
              ),
            )
 
          ],
        ),
    );

  }

  List<Widget> _rowFilter() {

    List<Widget> butons = [];

    for (int i = 0; i < filtros.length; ++i){
      butons.add(new RaisedButton(
              elevation: 0,
              disabledElevation: 0,
              highlightElevation: 0,
              shape: StadiumBorder(),
              color: Colors.blue[200],
              onPressed: (){},
              child: Row(
                children: [
                  Text(filtros[i]),
                  IconButton(
                    icon: Icon(Icons.highlight_remove), 
                    iconSize: 20, 
                    padding: EdgeInsets.all(0), 
                    alignment: Alignment.centerRight,
                    splashRadius: 0.1,
                    onPressed: (){
                      setState(() {
                        filtros.removeAt(i);
                      });
                    })
                ],
              ),
            ),);
      butons.add(SizedBox(width: 5.0));
    }  

    return butons;

  }

  Widget _getFilters() {
    return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setStat) {
          return AlertDialog(
            content: Container(
            width: 300,
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(value: filtros.contains('patata'), onChanged: (val){
                        if (val){
                          setStat(() {
                            setState(() {
                              filtros.add('patata');
                            });
                            
                          });
                        }
                        else{
                          setStat(() {
                            setState(() {
                              filtros.remove('patata');
                            });
                          });
                        }
                      }),
                      Text('patata')
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(value: filtros.contains('pedo'), onChanged: (val){
                        if (val){
                          setStat(() {
                            setState(() {
                              filtros.add('pedo');
                            });
                            
                          });
                        }
                        else{
                          setStat(() {
                            setState(() {
                              filtros.remove('pedo');
                            });
                          });
                        }
                      }),
                      Text('pedo')
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(value: filtros.contains('culo'), onChanged: (val){
                        if (val){
                          setStat(() {
                            setState(() {
                              filtros.add('culo');
                            });
                            
                          });
                        }
                        else{
                          setStat(() {
                            setState(() {
                              filtros.remove('culo');
                            });
                          });
                        }
                      }),
                      Text('culo')
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(value: filtros.contains('zapato'), onChanged: (val){
                        if (val){
                          setStat(() {
                            setState(() {
                              filtros.add('zapato');
                            });
                            
                          });
                        }
                        else{
                          setStat(() {
                            setState(() {
                              filtros.remove('zapato');
                            });
                          });
                        }
                      }),
                      Text('zapato')
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(value: filtros.contains('ojete'), onChanged: (val){
                        if (val){
                          setStat(() {
                            setState(() {
                              filtros.add('ojete');
                            });
                            
                          });
                        }
                        else{
                          setStat(() {
                            setState(() {
                              filtros.remove('ojete');
                            });
                          });
                        }
                      }),
                      Text('ojete')
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(value: filtros.contains('chuletis'), onChanged: (val){
                        if (val){
                          setStat(() {
                            setState(() {
                              filtros.add('chuletis');
                            });
                            
                          });
                        }
                        else{
                          setStat(() {
                            setState(() {
                              filtros.remove('chuletis');
                            });
                          });
                        }
                      }),
                      Text('chuletis')
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(value: filtros.contains('jujuju'), onChanged: (val){
                        if (val){
                          setStat(() {
                            setState(() {
                              filtros.add('jujuju');
                            });
                            
                          });
                        }
                        else{
                          setStat(() {
                            setState(() {
                              filtros.remove('jujuju');
                            });
                          });
                        }
                      }),
                      Text('jujuju')
                    ],
                  )
                ],
              ),),
          ),
        );
      }
    );
  }
}