import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:taller_practico_2/navegacion/drawe.dart'; 

class GastronomyScreen extends StatelessWidget {
  final TextEditingController _dishController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _idController = TextEditingController(); // Controlador para el ID
  final FirebaseDatabase _database = FirebaseDatabase.instance; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Gastronomía de Ecuador",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      drawer: MyDrawer(), 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Platillos Típicos",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: "ID del Platillo",
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.code, color: Colors.red),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _dishController,
                decoration: InputDecoration(
                  labelText: "Platillo Típico",
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.restaurant, color: Colors.red),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: "Ciudad",
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.location_city, color: Colors.red),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  String id = _idController.text;
                  String dish = _dishController.text;
                  String city = _cityController.text;

                  if (id.isNotEmpty && dish.isNotEmpty && city.isNotEmpty) {
                   
                    _saveDishToDatabase(id, dish, city);

                  
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Platillo agregado exitosamente!")),
                    );

                   
                  } else {
                
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Por favor llena todos los campos")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  "Agregar Platillo",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  void _saveDishToDatabase(String id, String dish, String city) {
    final dishRef = _database.ref("gastronomy/$id"); 

  
    dishRef.set({
      "dish": dish,
      "city": city,
    });
  }
}
