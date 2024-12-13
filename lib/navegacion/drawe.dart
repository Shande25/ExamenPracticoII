

import 'package:flutter/material.dart';
import 'package:taller_practico_2/Screens/gastronomiaScreen.dart';
import 'package:taller_practico_2/Screens/listaCiudadesScreen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text("Gastronomia"),
             onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>GastronomyScreen())),
            ),
          ListTile(
            title: Text("ListaCiudad"),
             onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ListaCiudadesScreen ())),),
    
        ],
      ),
    );
  }
}