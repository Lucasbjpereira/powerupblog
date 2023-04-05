import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildLoadingIndicator() {
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
                  _buildPlaceholder(height: 20.0, width: double.infinity),
                  _buildPlaceholder(
                      height: 150.0,
                      width: double.infinity,
                      borderRadius: 10.0),
                  _buildPlaceholder(height: 20.0, width: double.infinity),
                  const SizedBox(height: 10.0),
                  _buildPlaceholder(height: 20.0, width: double.infinity),
                  const SizedBox(height: 10.0),
                  _buildPlaceholder(height: 20.0, width: 200.0),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPlaceholder(
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
