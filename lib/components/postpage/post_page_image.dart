import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
