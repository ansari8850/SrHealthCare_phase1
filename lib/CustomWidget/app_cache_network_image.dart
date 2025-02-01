import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCacheNetworkImage extends StatelessWidget {
  const AppCacheNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.borderRadius,
  });
  final String? imageUrl;
  final BoxFit fit;
  final double? height;
  final double? width;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return imageUrl?.isNotEmpty == true && imageUrl!.startsWith("http")
        ? ClipRRect(
            borderRadius: borderRadius != null
                ? BorderRadius.circular(borderRadius!)
                : BorderRadius.zero,
            child: SizedBox(
              height: height,
              width: width,
              child: CachedNetworkImage(
                fit: fit,
                imageUrl: imageUrl!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/homepage/dr1.jpg',
                  fit: fit,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
