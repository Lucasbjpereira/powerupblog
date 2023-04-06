import 'package:flutter/material.dart';
import 'package:power_up_blog/views/home_page.dart';

/*
* @description Classe que representa o cabeçalho do aplicativo.
* @param Size preferredSize: tamanho preferred, utilizado pelo framework Flutter para calcular a altura do AppBar.
* @param width: largura do widget.
* @param borderRadius: raio de borda do widget.
* @return widget do skeleton.
*/
class Header extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const Header({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 4,
      centerTitle: true,
      title: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        child: SizedBox(
          width: 120,
          height: 50,
          child: Image.asset(
            'assets/imgs/logotipo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
