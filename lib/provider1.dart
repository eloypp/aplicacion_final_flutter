import 'package:flutter/foundation.dart';

class MiProvider1 with ChangeNotifier {
  int _preguntasHechas = 0;

  int get preguntasHechas => _preguntasHechas;

  void incrementarPreguntasHechas() {
    _preguntasHechas++;
    notifyListeners();
  }

  void resetPreguntasHechas() {
    _preguntasHechas = 0;
    notifyListeners();
  }
}