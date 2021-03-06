import 'package:flutter/material.dart';
import 'package:mis_recetas/widgets/barra_buscadora.dart';
import 'package:mis_recetas/widgets/card_recetas.dart';

class RecetasPage extends StatefulWidget {

  @override
  _RecetasPageState createState() => _RecetasPageState();
}

class _RecetasPageState extends State<RecetasPage> {

  List<String> filtros = ['chino', 'sano', 'culo', 'pato', 'pincheuevon', 'fit', 'ketomina'];

  @override
  Widget build(BuildContext context) {

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

  _getFilters() {
    
  }
}