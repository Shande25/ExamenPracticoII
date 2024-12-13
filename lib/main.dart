import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taller_practico_2/Screens/loginScreen.dart';
import 'package:taller_practico_2/Screens/registerScreen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guía Turística de Ecuador',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),  
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        title: Text(
          'Bienvenido a la Guía Turística de Ecuador',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black, 
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
       
            ElevatedButton(
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, 
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), 
                ),
                elevation: 5,  // Sombra
                shadowColor: Colors.black.withOpacity(0.5),  
              ),
              child: Text(
                'Iniciar sesión',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
           
            ElevatedButton(
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,  
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),  
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), 
                ),
                elevation: 5,  // Sombra
                shadowColor: Colors.black.withOpacity(0.5), 
              ),
              child: Text(
                'Registrarse',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 40),
           
            Text(
              'Desarrollado por: Jahir Paredes\nGitHub: Shande25',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,  
                color: Colors.white,  
                fontWeight: FontWeight.bold,  
              ),
            ),
          ],
        ),
      ),
    );
  }
}
