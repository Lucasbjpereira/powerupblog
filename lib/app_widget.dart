import 'package:flutter/material.dart';
import 'package:power_up_blog/splash_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "PowerUp",
      home: SplashPage(),
    );
  }
}
