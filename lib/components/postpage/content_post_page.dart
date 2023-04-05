import 'package:flutter/material.dart';

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
