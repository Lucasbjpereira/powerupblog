import 'package:flutter/material.dart';

/*
* @description Retorna o widget que exibe o autor, foto do autor e a data da postagem na página do post.
* @param String author: Nome do autor do post.
* @param String authorPhoto: URL da foto do autor.
* @param String date: Data do post.
* @return: Widget que exibe o autor, foto do autor e a data da postagem na página do post.
*/
Widget authorDatePostPage(String author, String authorPhoto, String date) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(authorPhoto),
          ),
          const SizedBox(width: 10),
          Text(
            author,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Text(
        date,
        style: const TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  );
}
