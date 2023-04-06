import 'package:flutter/material.dart';

/*
* @description Widget que exibe o conteúdo do post.
* @param String rendered: Conteúdo do post renderizado.
* @return: Widget do conteúdo do post.
*/
Widget contentPostPage(String rendered) {
  return Text(
    rendered,
    style: const TextStyle(
      fontSize: 16,
      color: Color.fromARGB(255, 95, 95, 95),
    ),
    textAlign: TextAlign.justify,
  );
}
