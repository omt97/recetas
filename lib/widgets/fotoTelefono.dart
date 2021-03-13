  import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget _foto(double width, String photo) {

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
           /* _imagenComida(width),
            _botonEliminarFoto()*/
          ],
        ),
    );

  }

_fotoButton(ImageSource imageSource){

  /*  return IconButton(
      icon : Icon(Icons.image, color: Colors.blue[500], size: 40),
      //color: getAppColor(userBloc.color, 500),
     // onPressed: ()async{ await _takePhoto(ImageSource.gallery);},
    );*/

  }

  _botonEliminarFoto(String photo) {

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
          /*setState(() {
            photo = null;
          });*/
        },
      ),
    );

  }

  _imagenComida(double width, String photo) {
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