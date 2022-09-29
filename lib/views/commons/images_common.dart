import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    Key? key,
    required this.data,
    required this.radius,
  }) : super(key: key);

  final String data;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: data,
      imageBuilder: ((context, imageProvider) {
        return CircleAvatar(
          radius: radius,
          foregroundImage: imageProvider,
        );
      }),
      placeholder: (context, url) {
        return SizedBox(
          height: radius * 2,
        );
      },
    );
  }
}
