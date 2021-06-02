import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/error_message.dart';

class CustomCachedImage extends StatelessWidget {
  final String url;

  const CustomCachedImage({
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        width: double.infinity,
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, _) => Shimmer.fromColors(
          baseColor: Theme.of(context).primaryColor,
          highlightColor: Theme.of(context).accentColor,
          child: Container(color: Colors.white, height: 250),
        ),
        errorWidget: (context, _, dynamic e) => ErrorMessage(message: e),
      ),
    );
  }
}
