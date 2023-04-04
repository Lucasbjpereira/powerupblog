import 'package:flutter/material.dart';
import 'package:power_up_blog/splash_screen.dart';

class AppWidget extends StatelessWidget {
  // Cria uma classe que retorna o app
  const AppWidget({super.key}); // Construtor

  @override
  Widget build(BuildContext context) {
    // Função que retorna o app
    return const MaterialApp(
      // Cria o app
      title: "PowerUp", // Seta o titulo do app
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: SplashScreen(), // Seta qual a homepage
    );
  }
}
