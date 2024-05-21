import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.boxFit,
  });
  final String url;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: boxFit ?? BoxFit.scaleDown, // .cover .scaleDown
              colorFilter:
              const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
            color: Colors.white, //at 6:20
          ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
