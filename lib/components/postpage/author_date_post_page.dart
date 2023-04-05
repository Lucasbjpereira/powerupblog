import 'package:flutter/material.dart';

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
