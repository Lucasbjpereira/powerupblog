import 'package:flutter/material.dart';

/*
* @description Widget para exibir o título de um post na página do post.
* @param String title: Título do post.
* @return: Widget para exibir o título do post.
*/
Widget postPageTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  );
}
