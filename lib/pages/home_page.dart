import 'package:flutter/material.dart';
import 'package:mis_recetas/bloc/receta_bloc.dart';
import 'package:mis_recetas/pages/recetas_page.dart';
import 'package:mis_recetas/pages/settings_page.dart';

class HomePage extends StatefulWidget {

  static final routeName = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _callPage(),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'create');
        },
      ),
    );
  }

  Widget _callPage() {

    switch(currentIndex){

      case 0:
        return RecetasPage();
      case 1:
        return SettingsPage();
      default: 
        return null;

    }

  }

  BottomNavigationBar _createBottomNavigationBar() {

    return BottomNavigationBar(

      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings')
      ]
    );

  }
}

