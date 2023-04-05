import 'package:flutter/material.dart';
import 'package:power_up_blog/components/header.dart';
import 'package:power_up_blog/components/postpage/author_date_post_page.dart';
import 'package:power_up_blog/components/postpage/content_post_page.dart';
import 'package:power_up_blog/components/postpage/post_page_image.dart';
import 'package:power_up_blog/components/postpage/title_post_page.dart';

class PostPage extends StatelessWidget {
  final String content;
  final String date;
  final String img;
  final String title;
  final String author;
  final String authorPhoto;

  const PostPage({
    Key? key,
    required this.content,
    required this.author,
    required this.authorPhoto,
    required this.title,
    required this.date,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(26),
        child: Column(
          children: [
            postPageImage(img),
            const SizedBox(height: 20),
            postPageTitle(title),
            contentPostPage(content),
            const SizedBox(height: 10),
            authorDatePostPage(author, authorPhoto, date),
          ],
        ),
      ),
    );
  }
}
