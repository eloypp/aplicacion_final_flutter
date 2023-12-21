import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'pantalla_inicio.dart';
import 'authService.dart';
import 'pantalla_registro.dart';

class PantallaLogin extends StatelessWidget {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  final AuthService _authService = AuthService();  // Instancia de tu servicio de autenticación

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usuarioController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            TextField(
              controller: contrasenaController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  User? user = await _authService.signInWithEmailAndPassword(
                    usuarioController.text,
                    contrasenaController.text,
                  );

                  // Si llegamos aquí, la autenticación fue exitosa
                  if (user != null) {
                    // Navegar a la pantalla inicial
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaInicio(user: user),
                      ),
                    );
                  }
                } catch (e) {
                  print('Error en el inicio de sesión: $e');

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Error en el inicio de sesión'),
                        content: Text('$e'),
                        actions: [
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
              },
              child: Text('Iniciar Sesión'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de registro
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaRegistro(),
                  ),
                );
              },
              child: Text('Crear Cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
