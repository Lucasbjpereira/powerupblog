import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:html_unescape/html_unescape.dart';
import 'config.dart';

class Blog {
  final String title;
  final String excerpt;
  final String author;
  final String date;

  Blog({
    required this.title,
    required this.excerpt,
    required this.author,
    required this.date,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      title: json['title']['rendered'],
      excerpt: json['excerpt']['rendered'],
      author: '', // o nome do autor será adicionado depois
      date: json['date'], // a data será adicionada no formato dd/mm/yyyy depois
    );
  }

  Blog copyWith({
    String? title,
    String? excerpt,
    String? author,
    String? date,
  }) {
    return Blog(
      title: title ?? this.title,
      excerpt: excerpt ?? this.excerpt,
      author: author ?? this.author,
      date: date ?? this.date,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Blog> blogs = [];
  late String token;

  Future<List<Blog>> fetchBlogs() async {
    final response = await http.get(
      Uri.parse(
          'https://public-api.wordpress.com/wp/v2/sites/powerupblog3.wordpress.com/posts'),
      headers: {
        'Authorization': 'Bearer ${Config.wordpressToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      // para cada postagem, faz uma solicitação para buscar as informações do autor correspondente
      List<Future<Blog>> futuresBlogs = body.map((dynamic item) async {
        final authorId = item['author'].toString();
        final authorResponse = await http.get(
          Uri.parse(
              'https://public-api.wordpress.com/wp/v2/sites/powerupblog3.wordpress.com/users/$authorId'),
          headers: {
            'Authorization': 'Bearer ${Config.wordpressToken}',
          },
        );
        final authorData = json.decode(authorResponse.body);

        // formata a data para o formato dd/mm/yyyy
        final DateTime date = DateTime.parse(item['date']);
        final formattedDate = "${date.day}/${date.month}/${date.year}";

        return Blog.fromJson(item).copyWith(
          author: authorData['name'] ?? '',
          date: formattedDate,
        ); // retorna um objeto Blog atualizado com o nome do autor e a data formatada
      }).toList();

      List<Blog> blogs = await Future.wait(futuresBlogs);

      return blogs;
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  @override
  void initState() {
    fetchBlogs().then((value) {
      setState(() {
        blogs.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HtmlUnescape htmlUnescape = HtmlUnescape();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem de Posts'),
      ),
      body: ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (BuildContext context, int index) {
          final pubDate = DateFormat('dd/MM/yyyy').parse(blogs[index].date);
          final formattedDate = DateFormat('dd/MM/yyyy').format(pubDate);
          return ListTile(
            title: Text(blogs[index].title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(htmlUnescape
                    .convert(blogs[index].excerpt)
                    .replaceAll(RegExp(r'<[^>]*>'), '')),
                const SizedBox(height: 8),
                Text(blogs[index].author),
                Text(formattedDate),
              ],
            ),
          );
        },
      ),
    );
  }
}
