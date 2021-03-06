import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mis_recetas/model/ingrediente_model.dart';
import 'package:mis_recetas/model/receta_model.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as p;

class CreatePage extends StatefulWidget {

  static final routeName = 'create';

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final formKey = GlobalKey<FormState>();

  String title;
  String description;
  int tiempo;
  int personas;
  String photo;
  List<Ingrediente> ingredientes = [];
  List<String> pasos = [];

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Receta'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _foto(_screenSize.width),
                _nombre(),
                _descripcion(),
                _info(_screenSize.width),
                _ingredientes(_screenSize.width),
                _pasos(_screenSize.width),
                _button()
              ],
            )
          ),
        ),
      )
    );
  }

  Widget _foto(double width) {

    return Container(
      height: width - 40,
      width: width - 40,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          //color: getAppColor(userBloc.color, 100),
          width: 2
        ),
        borderRadius: BorderRadius.circular(20)
      
      ),
      child: (photo == null) ? Row(
        children: [
          Expanded(child: SizedBox(width: double.infinity,)),
          IconButton(
            icon : Icon(Icons.image),
            //color: getAppColor(userBloc.color, 500),
            onPressed: ()async{ await _takePhoto(ImageSource.gallery);},
          ),
          Expanded(child: SizedBox(width: double.infinity,)),
          VerticalDivider(thickness: 2,),
          Expanded(child: SizedBox(width: double.infinity,)),
          IconButton(
            icon : Icon(Icons.camera),
            //color: getAppColor(userBloc.color, 500),
            onPressed: () async{ await _takePhoto(ImageSource.camera);},
          ),
          Expanded(child: SizedBox(width: double.infinity,)),
        ]
      ):
      Stack(
        children: [
          
          ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: Image.file(
              File(photo),
              fit: BoxFit.cover,
              width: width - 40,
              height: width - 40,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: IconButton(
              splashColor: Colors.transparent,
              disabledColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: Colors.red[800],
              icon: Icon(Icons.close),
              onPressed: (){
                setState(() {
                  photo = null;
                });
              },
            ),
          ),
        ],
      ),
    );

  }

  _nombre() {
    return Container(
      margin: EdgeInsets.all(20),
        child: TextFormField(
          //expands: true,
          initialValue: (title == null) ? '': title,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Nombre Receta',
            border: OutlineInputBorder(),
          ),
          onSaved: (title) => this.title = title ,
          validator: (title){
            if(title.length > 0){
              return null;
            } else {
              return 'Introducir título';
            }
          }
        ),
    );
  }

  _descripcion() {
    return Container(
      margin: EdgeInsets.all(20),
        child: TextFormField(
          //expands: true,
          initialValue: (description == null) ? '': description,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Descripción Receta',
            border: OutlineInputBorder(),
          ),
          onSaved: (description) => this.description = description ,
          validator: (description){
            if(description.length > 0){
              return null;
            } else {
              return 'Introducir título';
            }
          }
        ),
    );
  }

  _info(double width) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width/5,
            margin: EdgeInsets.all(20),
              child: TextFormField(
                //expands: true,
                initialValue: (personas == null) ? '': personas,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Personas',
                  border: OutlineInputBorder(),
                ),
                onSaved: (personas) => this.personas = int.parse(personas) ,
                validator: (personas){
                  if(int.parse(personas) > 0){
                    return null;
                  } else {
                    return 'Introducir título';
                  }
                }
              ),
          ),
          Container(
            width: width/5,
            margin: EdgeInsets.all(20),
              child: TextFormField(
                //expands: true,
                initialValue: (tiempo == null) ? '': tiempo.toString(),
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Min',
                  border: OutlineInputBorder(),
                ),
                onSaved: (tiempo) => this.tiempo = int.parse(tiempo) ,
                validator: (tiempo){
                  if(int.parse(tiempo) > 0){
                    return null;
                  } else {
                    return 'Introducir título';
                  }
                }
              ),
          ),
          Container(
            width: width/5,
            margin: EdgeInsets.all(20),
              child: TextFormField(
                //expands: true,
                initialValue: (title == null) ? '': title,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Descripción Receta',
                  border: OutlineInputBorder(),
                ),
                onSaved: (title) => this.title = title ,
                validator: (title){
                  if(title.length > 0){
                    return null;
                  } else {
                    return 'Introducir título';
                  }
                }
              ),
          ),
        ],
      ),
    );
  }

  _ingredientes(double width) {
    return Column(
      children: [
        Text('Ingredientes'),
        Column(
          children: _textIngredientes(width)
        ),
        RaisedButton.icon(
          onPressed: (){
            setState(() {
              ingredientes.add(new Ingrediente(name: null, cantidad: null, medida: null));
            });
          }, icon: Icon(Icons.add), label: Text('Add')
        )
      ],
    );
  }

    _pasos(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Pasos'),
        Column(
          children: _textPasos(width)
        ),
        RaisedButton.icon(
          onPressed: (){
            setState(() {
              pasos.add(null);
            });
          }, icon: Icon(Icons.add), label: Text('Add')
        )
      ],
    );
  }


  Future _takePhoto(ImageSource origen) async{
    final _picker = ImagePicker();

    final imageFile = await _picker.getImage(source: origen);

    if (imageFile == null) return null;

    final appDir = await syspaths.getExternalStorageDirectory();
    final fileName = p.basename(imageFile.path);
    final savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');


    setState(() {
      photo = savedImage.path;
    });
    
  }

  List<Widget> _textIngredientes(double width) {

    List<Widget> ingred = [];

    for (int i = 0; i < ingredientes.length; ++i){
      ingred.add(Row(
        children: [
          Container(
            width: width/4,
            margin: EdgeInsets.all(10),
              child: TextFormField(
                //expands: true,
                initialValue: (ingredientes[i].name == null) ? '': ingredientes[i].name,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Ingr ' + (i + 1).toString(),
                  border: OutlineInputBorder(),
                ),
                onSaved: (title) => ingredientes[i].name = title ,
                validator: (title){
                  if(title.length > 0){
                    return null;
                  } else {
                    return 'Introducir título';
                  }
                }
              ),
          ),
          Container(
            width: width/7,
            margin: EdgeInsets.all(10),
              child: TextFormField(
                //expands: true,
                initialValue: (ingredientes[i].cantidad == null) ? '': ingredientes[i].cantidad,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Descripción Receta',
                  border: OutlineInputBorder(),
                ),
                onSaved: (title) => ingredientes[i].cantidad = int.parse(title) ,
                validator: (title){
                  if(title.length > 0){
                    return null;
                  } else {
                    return 'Introducir título';
                  }
                }
              ),
          ),
          Container(
            width: width/7,
            margin: EdgeInsets.all(10),
              child: TextFormField(
                //expands: true,
                initialValue: (ingredientes[i].medida == null) ? '': ingredientes[i].medida,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Descripción Receta',
                  border: OutlineInputBorder(),
                ),
                onSaved: (title) => ingredientes[i].medida = title ,
                validator: (title){
                  if(title.length > 0){
                    return null;
                  } else {
                    return 'Introducir título';
                  }
                }
              ),
          ),
          RaisedButton.icon(onPressed: (){ 
            setState(() {
            ingredientes.removeAt(i);
            }); }, 
            icon: Icon(Icons.delete), label: Text(''))
        ],)
      );
      
    }
    return ingred;
  }

  _textPasos(double width) {

    List<Widget> pasosd = [];

    for (int i = 0; i < pasos.length; ++i){
      pasosd.add(
        Row(
          children: [
            Container(
              width: width*2.5/4,
              margin: EdgeInsets.all(20),
                child: TextFormField(
                  //expands: true,
                  initialValue: (pasos[i] == null) ? '': pasos[i],
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: 'Paso ' + (i + 1).toString(),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (title) => pasos[i] = title ,
                  validator: (title){
                    if(title.length > 0){
                      return null;
                    } else {
                      return 'Introducir título';
                    }
                  }
                ),
            ),
            RaisedButton.icon(onPressed: (){ 
            setState(() {
            pasos.removeAt(i);
            }); }, 
            icon: Icon(Icons.delete), label: Text(''))
          ],
        )
      );
    }
    return pasosd;
  }

  _button() {

    return RaisedButton.icon(
      elevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      onPressed: () async{

        if (!formKey.currentState.validate()) return;
        formKey.currentState.save();

        Receta recetaFinal = new Receta(
          name: this.title,
          description: this.description,
          photo: this.photo,
          ingredientes: this.ingredientes,
          pasos: this.pasos
        );


        /*CollectionModel collectionModelfinal = new CollectionModel(
          uid: widget.editar ? widget.collectionModel.uid : '',
          photo: photo, 
          title: this.title, 
          total: this.total, 
          porcentage: 0.0, 
          repes: 0, 
          faltas: this.total, 
          noFaltas: widget.collectionModel.noFaltas,
          favourite: false
        );
        (widget.editar)
        ?await coleccionesBloc.editarColeccion(collectionModelfinal, widget.collectionModel.title, widget.collectionModel.total, widget.collectionModel.photo)
        :await coleccionesBloc.agregarColeccion(collectionModelfinal);*/

        Navigator.of(context).pop();
        
      },
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.black,
      textColor: Colors.white,
    );

  }
}