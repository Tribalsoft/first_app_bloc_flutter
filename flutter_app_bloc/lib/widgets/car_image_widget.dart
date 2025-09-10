import 'package:flutter/material.dart';

class CarImageWidget extends StatelessWidget {
  const CarImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://images.unsplash.com/photo-1617788138017-80ad40651399', // Sample Tesla image
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red,
          ),
        );
      },
    );
  }
}
