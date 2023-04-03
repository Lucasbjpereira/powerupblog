import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';
import 'package:power_up_blog/post_page.dart';
import 'config.dart';

class Blog {
  final String title;
  final String excerpt;
  final String rendered;
  final String author;
  final String date;
  final String img;

  Blog({
    required this.title,
    required this.excerpt,
    required this.rendered,
    required this.img,
    required this.author,
    required this.date,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      title: json['title']['rendered'],
      excerpt: json['excerpt']['rendered'],
      rendered: json['content']['rendered'],
      img: json['jetpack_featured_media_url'] ?? '',
      author: '',
      date: json['date'],
    );
  }

  Blog copyWith({
    String? title,
    String? excerpt,
    String? rendered,
    String? img,
    String? author,
    String? date,
  }) {
    return Blog(
      title: title ?? this.title,
      excerpt: excerpt ?? this.excerpt,
      rendered: rendered ?? this.rendered,
      img: img ?? this.img,
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
  int page = 1;
  bool isLoading = false;
  bool isLastPage = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<List<Blog>> fetchBlogs() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://public-api.wordpress.com/wp/v2/sites/powerupblog3.wordpress.com/posts?page=$page'));

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

      List<Blog> fetchedBlogs = await Future.wait(futuresBlogs);

      if (fetchedBlogs.length < 10) {
        // verifica se a quantidade de blogs retornados é menor que 10, o que indica que é a última página
        isLastPage = true;
      }

      setState(() {
        blogs.addAll(fetchedBlogs);
        isLoading = false;
      });

      return fetchedBlogs;
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  Future<void> _onRefresh() async {
    // Limpa a lista de posts antes de carregar novos dados
    blogs = [];
    page = 1;
    isLastPage = false;
    await fetchBlogs();
  }

  @override
  void initState() {
    super.initState();
    token = Config.wordpressToken;
    fetchBlogs();
  }

// função para atualizar a lista de blogs quando o usuário chegar ao final da página
  void _updateBlogs() {
    if (!isLoading && !isLastPage) {
      setState(() {
        isLoading = true;
      });
      page++;
      fetchBlogs().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Power Up Blog'),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!isLoading &&
                !isLastPage &&
                blogs.isNotEmpty &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              _updateBlogs();
              return true;
            }
            return false;
          },
          child: ListView.builder(
            itemCount: blogs.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == blogs.length) {
                if (isLoading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                // índice extra para o indicador de carregamento
              } else {
                final blog = blogs[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PostPage(rendered: blogs[index].rendered),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(blog.img),
                        const SizedBox(height: 8.0),
                        Text(
                          HtmlUnescape().convert(blog.title),
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          HtmlUnescape().convert(blog.excerpt),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Por ${blog.author} em ${blog.date}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(),
                      ],
                    ),
                  ),
                );
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
