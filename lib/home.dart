import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';
import 'package:power_up_blog/components/header.dart';
import 'package:power_up_blog/post_page.dart';
import 'config.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Blog {
  final String title;
  final String excerpt;
  final String rendered;
  final String author;
  final String authorPhoto;
  final String date;
  final String img;

  Blog({
    required this.title,
    required this.excerpt,
    required this.rendered,
    required this.img,
    required this.author,
    required this.authorPhoto,
    required this.date,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      title: json['title']['rendered'],
      excerpt: json['excerpt']['rendered'],
      rendered: json['content']['rendered'],
      img: json['jetpack_featured_media_url'] ?? '',
      author: '',
      authorPhoto: '',
      date: json['date'],
    );
  }

  Blog copyWith({
    String? title,
    String? excerpt,
    String? rendered,
    String? img,
    String? author,
    String? authorPhoto,
    String? date,
  }) {
    return Blog(
      title: title ?? this.title,
      excerpt: excerpt ?? this.excerpt,
      rendered: rendered ?? this.rendered,
      img: img ?? this.img,
      author: author ?? this.author,
      authorPhoto: authorPhoto ?? this.authorPhoto,
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
        DateTime date = DateTime.parse(item['date']);
        String formattedDate = DateFormat('dd/MM/yyyy - HH:mm').format(date);

        return Blog.fromJson(item).copyWith(
          author: authorData['name'] ?? '',
          authorPhoto: authorData['avatar_urls']['96'] ?? '',
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
      appBar: const Header(),
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
            itemCount: isLastPage ? blogs.length : blogs.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == blogs.length) {
                if (isLoading) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(
                      child: Column(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 20.0,
                                    width: double.infinity,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 30),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Container(
                                      height: 150,
                                      width: double.infinity,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Container(
                                    height: 20.0,
                                    width: double.infinity,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Container(
                                    height: 20.0,
                                    width: double.infinity,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Container(
                                    height: 20.0,
                                    width: 200.0,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                // índice extra para o indicador de carregamento
                return const SizedBox(height: 80);
              } else {
                final blog = blogs[index];
                final rendered = HtmlUnescape()
                    .convert(blog.rendered)
                    .replaceAll(
                      RegExp(
                          r'(\n{2,})'), // encontra duas ou mais quebras de linha consecutivas
                      '\n\n', // substitui por duas quebras de linha
                    )
                    .replaceAll(RegExp(r'<[^>]*>'), '');
                final excerpt = HtmlUnescape()
                    .convert(blog.excerpt)
                    .replaceAll(RegExp(r'<[^>]*>'), '');
                final title = HtmlUnescape()
                    .convert(blog.title)
                    .replaceAll(RegExp(r'<[^>]*>'), '');
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostPage(
                          rendered: rendered,
                          date: blog.date,
                          author: blog.author,
                          title: title,
                          img: blog.img,
                          authorPhoto: blog.authorPhoto,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(1.0),
                                spreadRadius: 2,
                                blurRadius: 9,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: blog.img.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: blog.img,
                                    placeholder: (context, url) => Center(
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: const SizedBox(
                                            height: 150,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Text(
                          excerpt,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text(
                              'Por ${blog.author} em ${blog.date}',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 12.0,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
