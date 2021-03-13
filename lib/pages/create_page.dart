import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mis_recetas/bloc/receta_bloc.dart';
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
  final myController = TextEditingController();

  String title;
  String description;
  Map<String, dynamic> info = {
    'Tiempo': null,
    'Personas': null,
    'Cal': null
  };
  String photo;
  List<Ingrediente> ingredientes = [];
  List<Widget> pasosWidget = [];
  List<String> pasosValor = [null];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pasosWidget.add(_addPaso(RecetaBloc.size.width, 0));
    //_textPasos(RecetaBloc.size.width, 0);
    myController.addListener(_newValue);
  }

  _newValue(){
    print(myController.text);
  }

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Crear Receta'),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.grey[600],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                _buttonSave()
              ],
            )
          ),
        ),
      )
    );
  }

  //widget para incorporar foto dispositvo o hacer foto
  Widget _foto(double width) {

    return Container(
      height: width - 40,
      width: width - 40,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.blue[200],
        border: Border.all(
          color: Colors.blue[500],
          width: 2
        ),
        borderRadius: BorderRadius.circular(20)
      ),
      child: (photo == null) ? Row(
        children: [
          Expanded(child: SizedBox(width: double.infinity,)),
          _fotoButton(ImageSource.gallery),
          Expanded(child: SizedBox(width: double.infinity,)),
          VerticalDivider(thickness: 2,),
          Expanded(child: SizedBox(width: double.infinity,)),
          _fotoButton(ImageSource.camera),
          Expanded(child: SizedBox(width: double.infinity,)),
        ]):
        Stack(
          children: [
            _imagenComida(width),
            _botonEliminarFoto()
          ],
        ),
    );

  }

  //boton foto o boton galeria
  IconButton _fotoButton(ImageSource imageSource){

    return IconButton(
      icon : Icon(Icons.image, color: Colors.blue[500], size: 40),
      //color: getAppColor(userBloc.color, 500),
      onPressed: ()async{ await _takePhoto(ImageSource.gallery);},
    );

  }

  //boton para eliminar la foto de la galeria o hecha
  Container _botonEliminarFoto() {

    return Container(
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
    );

  }

  //vista de la imagen seleccionada
  ClipRRect _imagenComida(double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Image.file(
        File(photo),
        fit: BoxFit.cover,
        width: width - 40,
        height: width - 40,
      ),
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

  Widget _nombre() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
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

  Widget _descripcion() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
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

  //informacion sobre la receta, personas, tiempo, calorias
  Widget _info(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Detalles', style: TextStyle(fontSize: 18),),
        Divider(thickness: 2, color: Colors.blue[400],),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _infoFormField(width, 'Personas'),
              _infoFormField(width, 'Tiempo'),
              _infoFormField(width, 'Cal'),
            ],
          ),
        ),
      ],
    );
  }

  //devuelve los fields a rellenar
  Container _infoFormField(double width, String infoVar){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      width: width/5,
        child: TextFormField(
          //expands: true,
          initialValue: (info[infoVar] == null) ? '': info[infoVar],
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: infoVar,
            border: OutlineInputBorder(),
          ),
          onSaved: (text) => this.info[infoVar] = int.parse(text) ,
          validator: (text){
            if(int.parse(text) > 0){
              return null;
            } else {
              return 'Introducir título';
            }
          }
        ),
    );
  }

  _ingredientes(double width) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ingredientes', style: TextStyle(fontSize: 18),),
        Divider(thickness: 2, color: Colors.blue[400],),
        Column(
          children: _textIngredientes(width)
        ),
        RaisedButton.icon(
          elevation: 0,
          disabledElevation: 0,
          highlightElevation: 0,
          shape: StadiumBorder(),
          color: Colors.blue[300],
          onPressed: (){
            setState(() {
              ingredientes.add(new Ingrediente(name: null, cantidad: null, medida: null));
            });
          }, 
          icon: Icon(Icons.add, size: 20,color: Colors.grey[900],),
          label: Text('Add')
        ),
      ],
    );
  }

  List<Widget> _textIngredientes(double width) {

    List<Widget> ingred = [];

    for (int i = 0; i < ingredientes.length; ++i){
      ingred.add(Row(
        children: [
          Container(
            width: width/4,
            margin: EdgeInsets.all(0),
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
            margin: EdgeInsets.all(20),
              child: TextFormField(
                //expands: true,
                initialValue: (ingredientes[i].cantidad == null) ? '': ingredientes[i].cantidad,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Cant',
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
            margin: EdgeInsets.only(right: 10),
              child: TextFormField(
                //expands: true,
                initialValue: (ingredientes[i].medida == null) ? '': ingredientes[i].medida,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'kg, g,...',
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
          RaisedButton.icon(
          elevation: 0,
          disabledElevation: 0,
          highlightElevation: 0,
          shape: StadiumBorder(),
          color: Colors.red[300],
          onPressed: (){ 
            setState(() {
              ingredientes.removeAt(i);
            }); 
          },
          icon: Icon(Icons.delete, size: 20, color: Colors.grey[900],),
          label: Text(''),
        ),
        ],)
      );
      
    }
    return ingred;
  }

  _pasos(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pasos', style: TextStyle(fontSize: 18),),
        Divider(thickness: 2, color: Colors.blue[400],),
        Column(
          children: pasosWidget
        ),
      ],
    );
  }

  Row _addPaso(double width, int i){
    return Row(
      children: [
        _pasoFormField(width, i),
        _bottonAdd(width, i),
      ],
    );
  }

  Container _pasoFormField(double width, int i) {

    return Container(
      width: width*2.5/4,
      margin: EdgeInsets.only(right: 10, top: 20, bottom: 20),
        child: TextFormField(
          //expands: true,
          initialValue: null,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Paso ' + (i + 1).toString(),
            border: OutlineInputBorder(),
          ),
          onChanged: (title) => setState(() {pasosValor[i] = title;}),
          onSaved: (title) => pasosValor[i] = title ,
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

  RaisedButton _bottonAdd(double width, int i) {

    return RaisedButton.icon(
      elevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      shape: StadiumBorder(),
      color: Colors.blue[300],
      onPressed: (){
        setState(() {
          if (pasosValor[i] != null){
            _textPasos(width, i);
            pasosValor.add(null);
          }
        });
      }, 
      icon: Icon(Icons.add, size: 20,color: Colors.grey[900],),
      label: Text('Add')
    );

  }

  void _textPasos(double width, int i) {

    pasosWidget.removeLast();

    pasosWidget.add(
      _pasoCreado(width, i)
    );

    pasosWidget.add(_addPaso(width, i+1));
  }

  Row _pasoCreado(double width, int i){
    return Row(
      children: [
        _labelPaso(width, i),
        _buttonEliminar(i)
      ],
    );
  }

  Container _labelPaso(double width, int i){
    return Container(
      width: width*2.5/4,
      margin: EdgeInsets.only(right: 10, top: 20, bottom: 20),
        child: Text(pasosValor[i])
    );
  }

  RaisedButton _buttonEliminar(int i){

    return RaisedButton.icon(
      elevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      shape: StadiumBorder(),
      color: Colors.red[300],
      onPressed: (){ 
        setState(() {
          pasosWidget[i] = Container();
        }); 
      },
      icon: Icon(Icons.delete, size: 20, color: Colors.grey[900],),
      label: Text(''),
    );

  }

  _buttonSave() {

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
          pasos: this.pasosValor
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
      color: Colors.blue[300],
      textColor: Colors.blue[900],
    );

  }



  
}