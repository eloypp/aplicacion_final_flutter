import 'package:flutter/foundation.dart';

class MiProvider2 with ChangeNotifier {
  int _respuestasCorrectas = 0;

  int get respuestasCorrectas => _respuestasCorrectas;

  void incrementarRespuestasCorrectas() {
    _respuestasCorrectas++;
    notifyListeners();
  }

  void resetRespuestasCorrectas() {
    _respuestasCorrectas = 0;
    notifyListeners();
  }
}