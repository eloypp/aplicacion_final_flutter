import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MiProviderLocal with ChangeNotifier {
  int _preguntasHechas = 0;
  int _respuestasCorrectas = 0;

  int get preguntasHechas => _preguntasHechas;
  int get respuestasCorrectas => _respuestasCorrectas;

  // Método para incrementar preguntas hechas y guardar localmente
  void incrementarPreguntasHechas() {
    _preguntasHechas++;
    _guardarDatosLocales();
    notifyListeners();
  }

  // Método para incrementar respuestas correctas y guardar localmente
  void incrementarRespuestasCorrectas() {
    _respuestasCorrectas++;
    _guardarDatosLocales();
    notifyListeners();
  }

  // Método para cargar datos locales
  Future<void> cargarDatosLocales() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _preguntasHechas = prefs.getInt('preguntasHechas') ?? 0;
    _respuestasCorrectas = prefs.getInt('respuestasCorrectas') ?? 0;
    notifyListeners();
  }

  // Método para guardar datos locales
  Future<void> _guardarDatosLocales() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('preguntasHechas', _preguntasHechas);
    prefs.setInt('respuestasCorrectas', _respuestasCorrectas);
  }
}