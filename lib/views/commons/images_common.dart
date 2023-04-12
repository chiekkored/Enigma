import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:tara/utilities/constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:tara/utilities/constants/themes_constant.dart';

/// SECTION CustomCachedNetworkImage
/// A Circular Cached Network Image
///
/// @param data The image network url
/// @param radius Radius of the image
///
/// @author Thomas Rey B Barcenas
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
      fit: BoxFit.cover,
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

/// !SECTION

/// SECTION CustomCachedNetworkImageSquare
/// A Square Cached Network Image
///
/// @param data The image network url
///
/// @author Thomas Rey B Barcenas
class CustomCachedNetworkImageSquare extends StatelessWidget {
  const CustomCachedNetworkImageSquare({
    Key? key,
    required this.data,
  }) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: data,
      imageBuilder: ((context, imageProvider) {
        return Image(
          image: imageProvider,
        );
      }),
      placeholder: (context, url) {
        return Container();
      },
    );
  }
}

/// !SECTION

/// SECTION CustomDisplayPhotoURL
/// A check if Photo URL is svg or image
///
/// Returns a widget
///
/// @param photoURL The image network url
/// @param radius The image radius
///
/// @author Chiekko Red
class CustomDisplayPhotoURL extends StatelessWidget {
  const CustomDisplayPhotoURL({
    super.key,
    required this.photoURL,
    required this.radius,
  });

  final String photoURL;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return isSVG(photoURL)
        ? Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CColors.secondaryColor,
              // color:
              //     Colors.primaries[Random().nextInt(Colors.primaries.length)],
            ),
            child: SvgPicture.network(
              photoURL,
              height: radius * 2,
            ),
          )
        : CustomCachedNetworkImage(data: photoURL, radius: radius);
  }
}

/// !SECTION

/// SECTION kTransparentImage
/// A Uint8List of transparent pixel
///
/// @author Chiekko Red
final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);
// !SECTION
