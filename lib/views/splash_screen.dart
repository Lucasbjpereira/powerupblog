import 'dart:async';
import 'package:flutter/material.dart';
import 'package:power_up_blog/views/home_page.dart';

/*
* @description Constrói a interface da tela de SplashScreen.
* @param key: chave para identificação do widget.
* @return: Widget da interface da tela SplashScreen.
*/
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  /*
  * @description Navega para a HomePage após 3 segundos.
  * @return void
  */
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imgs/logotipo.png"),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
