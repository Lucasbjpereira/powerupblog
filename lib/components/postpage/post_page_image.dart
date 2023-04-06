import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/*
* @description Constrói a imagem da página do post.
* @param String img: imagem do post em formato de URL.
* @return: Widget da imagem da página do post.
*/
Widget postPageImage(String img) {
  return Container(
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
              placeholder: (context, url) => _postImagePlaceholder(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            )
          : const SizedBox.shrink(),
    ),
  );
}

/*
* @description Constrói o placeholder da imagem do post.
* @return: Widget do placeholder da imagem do post.
*/
Widget _postImagePlaceholder() {
  return Center(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: const SizedBox(
        height: 150,
        width: double.infinity,
      ),
    ),
  );
}
