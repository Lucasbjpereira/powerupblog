import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/*
* @description Retorna um widget que exibe uma imagem de post.
* @param String imageUrl: URL da imagem do post.
* @return Widget da imagem do post.
*/
Widget imagePost(String imageUrl) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(1.0),
          spreadRadius: 2,
          blurRadius: 9,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: imageUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => _imagePostPlaceholder(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            )
          : const SizedBox.shrink(),
    ),
  );
}

/*
* @description Retorna um widget de imagem em cache para exibição enquanto a imagem do post está sendo carregada.
* @return Widget de imagem em cache.
*/
Widget _imagePostPlaceholder() {
  return Center(
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
  );
}
