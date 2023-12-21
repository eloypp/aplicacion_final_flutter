import 'package:flutter/material.dart';
import 'authService.dart';


class PantallaRegistro extends StatelessWidget {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Cuenta'),
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
                  // Llama al método de tu servicio para crear la cuenta
                  await _authService.signUpWithEmailAndPassword(
                    usuarioController.text,
                    contrasenaController.text,
                  );


                  Navigator.pop(context);
                } catch (e) {
                  print('Error en la creación de cuenta: $e');

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
              child: Text('Crear Cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}