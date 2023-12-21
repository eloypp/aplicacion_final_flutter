import 'package:flutter/material.dart';
import 'package:projecto_final/provider3.dart';
import 'package:provider/provider.dart';
import 'pantalla_login.dart';
import 'provider1.dart';
import 'provider2.dart';
import 'provider3.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(
    MultiProvider(
      providers: [
        // Agrega tus providers aquí
        ChangeNotifierProvider(create: (context) => MiProvider1()),
        ChangeNotifierProvider(create: (context) => MiProvider2()),
        ChangeNotifierProvider(create: (context) => MiProviderLocal()),
        // Agrega más providers según sea necesario
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => PantallaLogin(),
      },
    );
  }
}

