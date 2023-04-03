import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:power_up_blog/components/header.dart';
import 'package:shimmer/shimmer.dart';

class PostPage extends StatelessWidget {
  final String rendered;
  final String date;
  final String img;
  final String title;
  final String author;
  final String authorPhoto;

  const PostPage(
      {Key? key,
      required this.rendered,
      required this.author,
      required this.authorPhoto,
      required this.title,
      required this.date,
      required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(1.0),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: img.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: img,
                          placeholder: (context, url) => Center(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
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
              const SizedBox(
                height: 20,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                rendered,
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 95, 95, 95)),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(authorPhoto),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
