import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taller_practico_2/navegacion/drawe.dart';

Future<List> obtenerCiudades(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['ciudades']; 
  } else {
    throw Exception("No se pudo conectar");
  }
}

class ListaCiudadesScreen extends StatelessWidget {
  const ListaCiudadesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Ciudades", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.red, 
        elevation: 0,
      ),
      body: listViewCiudades("https://jritsqmet.github.io/web-api/ciudades2.json"),
    );
  }


  Widget listViewCiudades(String url) {
    return FutureBuilder(
      future: obtenerCiudades(url), 
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final ciudad = data[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5, 
                color: Colors.black, 
                child: ListTile(
                  contentPadding: EdgeInsets.all(16), 
                  title: Text(ciudad['nombre'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                  subtitle: Text(ciudad['provincia'], style: TextStyle(color: Colors.white)),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(ciudad['informacion']['imagen'], width: 50, height: 50, fit: BoxFit.cover),
                  ),
                  onTap: () {
                    
                    _showCityDetails(ciudad, context);
                  },
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _showCityDetails(Map ciudad, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(ciudad['nombre'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(ciudad['informacion']['imagen'], fit: BoxFit.cover),
              SizedBox(height: 10),
              Text("Provincia: ${ciudad['provincia']}", style: TextStyle(color: Colors.black)),
              SizedBox(height: 10),
              Text("Descripción: ${ciudad['descripcion']}", style: TextStyle(color: Colors.black)),
              SizedBox(height: 10),
              Text("Población: ${ciudad['detalles']['poblacion']}", style: TextStyle(color: Colors.black)),
              Text("Altitud: ${ciudad['detalles']['altitud']}", style: TextStyle(color: Colors.black)),
              SizedBox(height: 10),
              Text("Sitio Web: ${ciudad['informacion']['sitio_web']}", style: TextStyle(color: Colors.black)),
              Text("Mapa: ${ciudad['informacion']['mapa']}", style: TextStyle(color: Colors.black)),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
