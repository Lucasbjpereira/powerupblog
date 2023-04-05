import 'package:power_up_blog/models/post_model.dart';
import 'package:power_up_blog/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:power_up_blog/components/header.dart';
import 'package:power_up_blog/components/homepage/image_posts.dart';
import 'package:power_up_blog/components/homepage/skeleton_post.dart';
import 'package:power_up_blog/views/post_page.dart';
import 'package:power_up_blog/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _postService = PostService();
  late List<Post> _posts;
  int _page = 1;
  bool _isLoading = true;
  bool _isLastPage = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _posts = [];
    _isLoading = true;
    _postService.fetchPosts(_page).then((fetchedPosts) => {
          setState(() {
            _updateState(fetchedPosts);
          })
        });
  }

  void _updateState(List<Post> fetchedPosts) {
    setState(() {
      _isLastPage = fetchedPosts.length < 10;
      _posts.addAll(fetchedPosts);
      _isLoading = false;
    });
  }

  Future<void> _onRefresh() async {
    // Limpa a lista de posts antes de carregar novos dados
    setState(() {
      _posts = [];
      _page = 1;
      _isLastPage = false;
    });
    _isLoading = true;
    await _postService.fetchPosts(_page).then((fetchedPosts) {
      setState(() {
        _updateState(fetchedPosts);
      });
    });
  }

// Função para atualizar a lista de posts quando o usuário chegar ao final da página. (Páginação)
  void _updatePosts() {
    if (!_isLoading && !_isLastPage) {
      setState(() {
        _isLoading = true;
      });
      _page++;
      _isLoading = true;
      _postService.fetchPosts(_page).then((fetchedPosts) {
        setState(() {
          _updateState(fetchedPosts);
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
            if (!_isLoading &&
                !_isLastPage &&
                _posts.isNotEmpty &&
                scrollInfo.metrics.pixels ==
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
                  return skeleton();
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 26.0),
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
                                color: Color.fromARGB(255, 134, 134, 134),
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
