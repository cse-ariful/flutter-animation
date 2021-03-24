import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class KImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  const KImage({Key key, this.url, this.fit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (url == null || url.isEmpty)
      return Image.asset(
        "assets/icons/default_placeholder_image.png",
        fit: fit,
      );
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      progressIndicatorBuilder: (context, url, progress) => Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class KAssetImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  const KAssetImage({Key key, this.url, this.fit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "$url",
      fit: fit,
    );
  }
}
