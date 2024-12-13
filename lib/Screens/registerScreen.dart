import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginScreen.dart';  // Importa la pantalla de inicio de sesión

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Registro",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Crear una cuenta",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Completa tus datos para continuar",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              
              
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Correo Electrónico",
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.email, color: Colors.red),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              
             
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.lock, color: Colors.red),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                obscureText: true,
              ),
              SizedBox(height: 30),
              
              ElevatedButton(
                onPressed: () async {
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  if (email.isEmpty || password.isEmpty) {
                    _showErrorDialog(context, "Por favor llena todos los campos");
                    return;
                  }

                  if (!_isValidEmail(email)) {
                    _showErrorDialog(context, "El correo electrónico no es válido");
                    return;
                  }

                  if (password.length < 6) {
                    _showErrorDialog(context, "La contraseña debe tener al menos 6 caracteres");
                    return;
                  }

                  try {
                    await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("¡Usuario registrado exitosamente!")),
                    );
                    Navigator.pop(context);  // Regresa a la pantalla anterior
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      _showErrorDialog(context, "El correo electrónico ya está registrado");
                    } else {
                      _showErrorDialog(context, e.message ?? "Error al registrar usuario");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  "Registrarse",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              
             
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  "¿Ya tienes cuenta? Inicia sesión aquí",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.redAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(email);
  }
}
