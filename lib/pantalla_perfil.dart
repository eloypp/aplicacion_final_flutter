import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider3.dart';


class PantallaPerfil extends StatefulWidget {
  @override
  _PantallaPerfilState createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {
  late MiProviderLocal miProviderLocal;

  @override
  void initState() {
    super.initState();
    // Obtén instancias de los providers
    miProviderLocal = Provider.of<MiProviderLocal>(context, listen: false);

    // Carga datos locales al iniciar la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _mostrarDialogoCambioNombre();
            },
            child: Text('Cambiar Nombre de Usuario'),
          ),
          SizedBox(height: 80),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nombre de Usuario Actual: ${_obtenerNombreUsuarioActual()}', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Preguntas Realizadas: ${miProviderLocal.preguntasHechas}', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Respuestas Correctas: ${miProviderLocal.respuestasCorrectas}', style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 10),
                    Text('Porcentaje de Aciertos: ${_calcularPorcentajeAciertos()}%', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              // Puedes agregar más elementos en el lateral derecho según sea necesario
            ],
          ),
        ],
      ),
    );
  }

  String _obtenerNombreUsuarioActual() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? 'Usuario';
  }
  _mostrarDialogoCambioNombre() async {
    TextEditingController nuevoNombreController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cambiar Nombre de Usuario'),
          content: TextField(
            controller: nuevoNombreController,
            decoration: InputDecoration(labelText: 'Nuevo Nombre de Usuario'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Obtener el nuevo nombre de usuario
                String nuevoNombre = nuevoNombreController.text.trim();

                // Validar que el nuevo nombre no esté vacío
                if (nuevoNombre.isNotEmpty) {
                  // Actualizar el nombre de usuario en Firebase
                  await _actualizarNombreUsuarioFirebase(nuevoNombre);

                  // Cerrar el diálogo
                  Navigator.pop(context);
                } else {
                  // Muestra un mensaje de error si el nuevo nombre está vacío
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Por favor, ingresa un nuevo nombre de usuario.'),
                  ));
                }
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _actualizarNombreUsuarioFirebase(String nuevoNombre) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updateDisplayName(nuevoNombre);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Nombre de usuario actualizado exitosamente.'),
        ));
      }
    } catch (e) {
      print('Error al actualizar el nombre de usuario en Firebase: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al actualizar el nombre de usuario.'),
      ));
    }
  }
  double _calcularPorcentajeAciertos() {
    if (miProviderLocal.preguntasHechas == 0) {
      return 0.0; // Evitar división por cero
    }

    double porcentaje = (miProviderLocal.respuestasCorrectas / miProviderLocal.preguntasHechas) * 100;
    return double.parse(porcentaje.toStringAsFixed(2)); // Redondear a dos decimales
  }
}
