import 'package:flutter/material.dart';
import 'package:power_up_blog/home.dart';

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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        child: SizedBox(
          width: 120,
          height: 50,
          child: Image.asset(
            'assets/imgs/R.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
