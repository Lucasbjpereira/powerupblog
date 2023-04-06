import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:power_up_blog/config.dart';
import 'package:power_up_blog/models/post_model.dart';

/*
* @description Busca uma lista de posts a partir da página fornecida.
* @param int page: Número da página a ser buscada.
* @return List<Post> fetchedPosts: Uma lista de objetos Post.
*/
class PostService {
  Future<List<Post>> fetchPosts(int page) async {
    final response = await http.get(Uri.parse(
        'https://public-api.wordpress.com/wp/v2/sites/powerupblog3.wordpress.com/posts?page=$page'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);

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

        DateTime date = DateTime.parse(item['date']);
        String formattedDate = DateFormat('dd/MM/yyyy - HH:mm').format(date);

        return Post.fromJson(item).copyWith(
          author: authorData['name'] ?? '',
          authorPhoto: authorData['avatar_urls']['96'] ?? '',
          date: formattedDate,
        );
      }).toList();

      List<Post> fetchedPosts = await Future.wait(futuresPosts);

      return fetchedPosts;
    } else {
      throw Exception('Erro ao carregar os posts');
    }
  }
}
