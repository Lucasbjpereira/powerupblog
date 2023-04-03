import 'package:flutter/material.dart';
import 'package:power_up_blog/home.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: HomePage(),
      ),
    );
  }
}
