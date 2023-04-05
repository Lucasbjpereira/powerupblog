import 'dart:convert';
import 'package:power_up_blog/models/post_model.dart';
import '../config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:power_up_blog/components/header.dart';
import 'package:power_up_blog/components/homepage/image_posts.dart';
import 'package:power_up_blog/components/homepage/skeleton_post.dart';
import 'package:power_up_blog/views/post_page.dart';
import 'package:power_up_blog/utils/utils.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late List<Post> _posts;
  int _page = 1;
  bool _isLoading = false;
  bool _isLastPage = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _posts = [];
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://public-api.wordpress.com/wp/v2/sites/powerupblog3.wordpress.com/posts?page=$_page'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

      // para cada postagem, faz uma solicitação para buscar as informações do autor correspondente
      final futuresPosts = body.map<Future<Post>>((item) async {
        final authorId = item['author'].toString();
        final authorResponse = await http.get(
          Uri.parse(
              'https://public-api.wordpress.com/wp/v2/sites/powerupblog3.wordpress.com/users/$authorId'),
          headers: {
            'Authorization': 'Bearer ${Config.wordpressToken}',
          },
        );
        final authorData = json.decode(authorResponse.body);

        // formata a data para o formato dd/MM/yyyy
        DateTime date = DateTime.parse(item['date']);
        String formattedDate = DateFormat('dd/MM/yyyy - HH:mm').format(date);

        return Post.fromJson(item).copyWith(
          author: authorData['name'] ?? '',
          authorPhoto: authorData['avatar_urls']['96'] ?? '',
          date: formattedDate,
        ); // retorna um objeto Post com o nome do autor, foto e a data da publicação formatada
      }).toList();

      List<Post> fetchedPosts = await Future.wait(futuresPosts);

      _isLastPage = fetchedPosts.length < 10;

      setState(() {
        _posts.addAll(fetchedPosts);
        _isLoading = false;
      });
    } else {
      throw Exception('Erro ao carregar os posts');
    }
  }

  Future<void> _onRefresh() async {
    // Limpa a lista de posts antes de carregar novos dados
    setState(() {
      _posts = [];
      _page = 1;
      _isLastPage = false;
    });

    await _fetchPosts();
  }

// Função para atualizar a lista de posts quando o usuário chegar ao final da página. (Páginação)
  void _updatePosts() {
    if (!_isLoading && !_isLastPage) {
      setState(() {
        _isLoading = true;
      });
      _page++;
      _fetchPosts().then((_) {
        setState(() {
          _isLoading = false;
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
            if (_isLoading || _isLastPage || _posts.isEmpty) {
              return false;
            }

            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              _updatePosts();
              return true;
            }

            return false;
          },
          child: ListView.builder(
            itemCount: _isLastPage ? _posts.length : _posts.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == _posts.length) {
                if (_isLoading) {
                  return buildLoadingIndicator();
                }
                return const SizedBox(height: 80);
              } else {
                final post = _posts[index];
                final rendered =
                    removeHtmlTagsAndConvertSpecialCharacters(post.rendered);
                final excerpt =
                    removeHtmlTagsAndConvertSpecialCharacters(post.excerpt);
                final title =
                    removeHtmlTagsAndConvertSpecialCharacters(post.title);

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostPage(
                          content: rendered,
                          date: post.date,
                          author: post.author,
                          title: title,
                          img: post.img,
                          authorPhoto: post.authorPhoto,
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
                        imagePost(post.img),
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
                              getPostAuthorAndDate(post),
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 12.0,
                                color: Colors.red,
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
