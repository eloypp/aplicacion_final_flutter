import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'provider1.dart';
import 'provider2.dart';


class PantallaSesion extends StatelessWidget {
  final User user;

  PantallaSesion({required this.user});

  @override
  Widget build(BuildContext context) {
    // Obtén instancias de los providers
    var miProvider1 = Provider.of<MiProvider1>(context);
    var miProvider2 = Provider.of<MiProvider2>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sesión Actual'),
        backgroundColor: Colors.transparent,
        elevation: 0, // Sin sombra
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        shape: Border(
          bottom: BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Información de la Sesión Actual:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Nombre de usuario: ${_obtenerNombreUsuarioActual()}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 40), // Ajusta según sea necesario
            _buildInfoSession('Preguntas Realizadas:', miProvider1.preguntasHechas.toString()),
            SizedBox(height: 10),
            _buildInfoSession('Respuestas Correctas:', miProvider2.respuestasCorrectas.toString()),
            // Puedes agregar más información de la sesión según sea necesario
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSession(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Text(value),
      ],
    );
  }
  String _obtenerNombreUsuarioActual() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? 'Usuario';
  }
}
