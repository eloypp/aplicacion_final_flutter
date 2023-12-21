import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider1.dart';
import 'provider2.dart';
import 'provider3.dart';


class PantallaPreguntas extends StatefulWidget {
  @override
  _PantallaPreguntasState createState() => _PantallaPreguntasState();
}

class _PantallaPreguntasState extends State<PantallaPreguntas> {
  int _indicePregunta = 0;
  int _respuestasCorrectas = 0;
  List<Map<String, dynamic>> _preguntas = [
    {
      'enunciado': '¿Cuál es la capital de Francia?',
      'opciones': ['Londres', 'Roma', 'París', 'Madrid'],
      'respuestaCorrecta': 'París',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿En qué año comenzó la Primera Guerra Mundial?',
      'opciones': ['1914', '1918', '1922', '1939'],
      'respuestaCorrecta': '1914',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿Cuál es la capital de Japón?',
      'opciones': ['Pekín', 'Seúl', 'Bangkok', 'Tokio'],
      'respuestaCorrecta': 'Tokio',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿En qué año se fundó la ciudad de Roma?',
      'opciones': ['753 a.C.', '300 d.C.', '500 a.C.', '100 a.C.'],
      'respuestaCorrecta': '753 a.C.',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿Cuántos continentes hay en el mundo?',
      'opciones': ['5', '6', '7', '8'],
      'respuestaCorrecta': '7',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿Quién pintó la Mona Lisa?',
      'opciones': ['Vincent van Gogh', 'Pablo Picasso', 'Leonardo da Vinci', 'Claude Monet'],
      'respuestaCorrecta': 'Leonardo da Vinci',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿Cuál es el río más largo del mundo?',
      'opciones': ['Amazonas', 'Nilo', 'Yangtsé', 'Misisipi'],
      'respuestaCorrecta': 'Amazonas',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿En qué lenguaje de programación se desarrolló Minecraft?',
      'opciones': ['Java', 'C++', 'Python', 'Inglés'],
      'respuestaCorrecta': 'Java',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿Quién es el protagonista de "Breaking Bad"?',
      'opciones': ['Walter White', 'Jesse Pinkman', 'Saul Goodman', 'Hank Schrader'],
      'respuestaCorrecta': 'Walter White',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿Cuál es la casa a la que pertenece Jon Snow en "Game of Thrones"?',
      'opciones': ['Lannister', 'Stark', 'Targaryen', 'Baratheon'],
      'respuestaCorrecta': 'Stark',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': 'En "El asombroso mundo de Gumball", ¿quién es el hermano adoptivo de Gumball Watterson?',
      'opciones': ['Darwin', 'Richard', 'Anais', 'Nicole'],
      'respuestaCorrecta': 'Darwin',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿Cuál es el título original de la serie de comedia animada japonesa "Shin-chan"?',
      'opciones': ['Crayon Shin-chan', 'Shin-chan no Baka', 'Shin-chan no Sekai', 'Shin-chan no Adventure'],
      'respuestaCorrecta': 'Crayon Shin-chan',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿En qué año fue lanzado el juego "The Legend of Zelda: Breath of the Wild"?',
      'opciones': ['2015', '2017', '2019', '2021'],
      'respuestaCorrecta': '2017',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿Cuál es el título del juego que presenta a Kratos, el dios de la guerra, como protagonista?',
      'opciones': ['Assassin\'s Creed', 'God of War', 'Devil May Cry', 'Dark Souls'],
      'respuestaCorrecta': 'God of War',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿Quién escribió la obra "Romeo y Julieta"?',
      'opciones': ['Charles Dickens', 'William Shakespeare', 'Jane Austen', 'Fyodor Dostoevsky'],
      'respuestaCorrecta': 'William Shakespeare',
      'respuestaSeleccionada': null,
    },
    {
      'enunciado': '¿Cuál es la moneda oficial de Japón?',
      'opciones': ['Dólar japonés', 'Won', 'Yuan', 'Yen'],
      'respuestaCorrecta': 'Yen',
      'respuestaSeleccionada': null,
    },
    // Puedes agregar más preguntas aquí según sea necesario
  ];

  @override
  void initState() {
    super.initState();
    _preguntas = _preguntas.toList()..shuffle(); // Baraja las preguntas al iniciar
  }

  @override
  Widget build(BuildContext context) {
    // Obtén instancias de los providers
    var miProvider1 = Provider.of<MiProvider1>(context);
    var miProvider2 = Provider.of<MiProvider2>(context);
    var miProviderLocal = Provider.of<MiProviderLocal>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Preguntas'),
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
      body: (_indicePregunta < _preguntas.length)
          ? _buildPregunta(_preguntas[_indicePregunta], miProvider1, miProvider2, miProviderLocal)
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Fin del juego'),
            Text('Preguntas acertadas: $_respuestasCorrectas de ${_preguntas.length}'),
            _buildPuntuacion(),
          ],
        ),
      ),
    );
  }

  Widget _buildPregunta(Map<String, dynamic> pregunta, MiProvider1 miProvider1, MiProvider2 miProvider2, MiProviderLocal miProviderLocal) {
    return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            pregunta['enunciado'],
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),
        Column(
          children: (pregunta['opciones'] as List<String>).map((opcion) {
            bool esRespuestaCorrecta = (opcion == pregunta['respuestaCorrecta']);
            return Container(
              width: MediaQuery.of(context).size.width * 0.6,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  if (pregunta['respuestaSeleccionada'] == null) {
                    setState(() {
                      pregunta['respuestaSeleccionada'] = opcion;
                      if (esRespuestaCorrecta) {
                        miProvider2.incrementarRespuestasCorrectas();
                        miProviderLocal.incrementarRespuestasCorrectas();
                        _respuestasCorrectas++;
                      }
                    });

                    miProvider1.incrementarPreguntasHechas();
                    miProviderLocal.incrementarPreguntasHechas();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: pregunta['respuestaSeleccionada'] == opcion
                      ? esRespuestaCorrecta
                      ? Colors.green
                      : Colors.red
                      : null,
                ),
                child: Text(
                  opcion,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _indicePregunta++;
            });
          },
          child: Text('Siguiente Pregunta'),
        ),
      ],
    )
    );
  }
  Widget _buildPuntuacion() {
    double porcentajeAcertado = (_respuestasCorrectas / _preguntas.length) * 100;
    double puntuacion = double.parse((porcentajeAcertado / 10).toStringAsFixed(2));

    return Text('Puntuación: $puntuacion sobre 10');
  }
}
