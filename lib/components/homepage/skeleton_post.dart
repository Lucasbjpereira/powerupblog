import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/*
* @description Retorna um widget do skeleton para ser exibido enquanto o conteúdo da tela está sendo carregado.
* @return Widget do skeleton.
*/
Widget skeleton() {
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
                  _skeletonPlaceholder(
                      height: 20.0, width: double.infinity, borderRadius: 10.0),
                  const SizedBox(height: 10.0),
                  _skeletonPlaceholder(
                      height: 150.0,
                      width: double.infinity,
                      borderRadius: 10.0),
                  const SizedBox(height: 10.0),
                  _skeletonPlaceholder(
                      height: 20.0, width: double.infinity, borderRadius: 10.0),
                  const SizedBox(height: 10.0),
                  _skeletonPlaceholder(
                      height: 20.0, width: 200.0, borderRadius: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/*
* @description Retorna um widget do skeleton para ser exibido enquanto o conteúdo da tela está sendo carregado.
* @param double height: Altura do widget.
* @param double width: Largura do widget.
* @param double borderRadius: Raio de borda do widget.
* @return Widget do placeholder do skeleton.
*/
Widget _skeletonPlaceholder(
    {required double height,
    required double width,
    double borderRadius = 0.0}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
  );
}
