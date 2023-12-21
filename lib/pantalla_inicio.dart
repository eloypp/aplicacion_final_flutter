import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'pantalla_perfil.dart';
import 'pantalla_preguntas.dart';
import 'pantalla_sesion.dart';
import 'provider3.dart';
import 'pantalla_login.dart';
import 'provider2.dart';
import 'provider1.dart';

class PantallaInicio extends StatelessWidget {
  final User user;

  PantallaInicio({required this.user});

  @override
  Widget build(BuildContext context) {
    var miProviderLocal = Provider.of<MiProviderLocal>(context);
    miProviderLocal.cargarDatosLocales();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Inicial'),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú Lateral',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaPerfil()),
                );
              },
            ),
            ListTile(
              title: Text('Sesión Actual'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaSesion(user: user)),
                );
              },
            ),
            ListTile(
              title: Text('Cerrar Sesión'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                Provider.of<MiProvider1>(context, listen: false).resetPreguntasHechas();
                Provider.of<MiProvider2>(context, listen: false).resetRespuestasCorrectas();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaLogin()),
                      (Route<dynamic> route) => false,
                );
              },
            ),

          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¡Bienvenido, ${_obtenerNombreUsuarioActual()}!'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaPreguntas()),
                );
              },
              child: Text('¡Empezar a Jugar!'),
            ),
          ],
        ),
      ),
    );
  }
  String _obtenerNombreUsuarioActual() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? 'Usuario';
  }
}