import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';

// import 'package:enigma/utilities/constants/themes_constant.dart';

// NOTE Not USED Temporarily
class ConversationScreenLocalImagesList extends StatelessWidget {
  const ConversationScreenLocalImagesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final ImagePicker picker = ImagePicker();
    return Container(
      height: 130.0,
      // SECTION Photo_gallery library
      // child: allMedia.isEmpty
      //     ? FutureBuilder<List<Album>>(
      //         future: PhotoGallery.listAlbums(mediumType: MediumType.image),
      //         builder: (context, albums) {
      //           if (albums.hasData) {
      //             print(albums);
      //             return FutureBuilder<MediaPage>(
      //                 future: albums.data!.first.listMedia(),
      //                 builder: (context, snapshot) {
      //                   if (snapshot.hasData) {
      //                     allMedia = snapshot.data!.items;
      //                     print("-----------------------------");
      //                     print(allMedia);
      //                     return imageList();
      //                   } else {
      //                     return const Text("Loading...");
      //                   }
      //                 });
      //           } else {
      //             return const CupertinoActivityIndicator();
      //           }
      //         })
      //     : imageList(),
      // !SECTION

      // SECTION Image_picker library
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 24.0),
      //     child: Column(
      //       children: [
      //         SizedBox(
      //           height: 80.0,
      //           child: Row(
      //             children: [
      //               Expanded(
      //                   child: GestureDetector(
      //                 onTap: () => picker.pickVideo(source: ImageSource.camera),
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                       color: CColors.white,
      //                       borderRadius: BorderRadius.circular(12.0)),
      //                   child: Center(
      //                     child: SvgPicture.asset("assets/icons/video.svg"),
      //                   ),
      //                 ),
      //               )),
      //               const SizedBox(
      //                 width: 10.0,
      //               ),
      //               Expanded(
      //                   child: GestureDetector(
      //                 onTap: () => picker.pickImage(source: ImageSource.camera),
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                       color: CColors.white,
      //                       borderRadius: BorderRadius.circular(12.0)),
      //                   child: Center(
      //                     child: SvgPicture.asset("assets/icons/camera.svg"),
      //                   ),
      //                 ),
      //               )),
      //             ],
      //           ),
      //         ),
      //         const SizedBox(
      //           height: 10.0,
      //         ),
      //         SizedBox(
      //           height: 40.0,
      //           child: Row(
      //             children: [
      //               Expanded(
      //                   child: GestureDetector(
      //                 onTap: () => picker.pickVideo(source: ImageSource.gallery),
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                       color: CColors.white,
      //                       borderRadius: BorderRadius.circular(12.0)),
      //                   child: Center(
      //                     child: SvgPicture.asset("assets/icons/video_add.svg"),
      //                   ),
      //                 ),
      //               )),
      //               const SizedBox(
      //                 width: 10.0,
      //               ),
      //               Expanded(
      //                   child: GestureDetector(
      //                 onTap: () => picker.pickMultiImage(),
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                       color: CColors.white,
      //                       borderRadius: BorderRadius.circular(12.0)),
      //                   child: const Center(
      //                     child: Icon(CustomIcons.image_add),
      //                   ),
      //                 ),
      //               )),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // );
      // !SECTION

      // child: FutureBuilder<List<AssetEntity>?>(
      //     future: AssetPicker.pickAssets(context,
      //         pickerConfig: const AssetPickerConfig(
      //           themeColor: CColors.secondaryColor,
      //         )),
      //     builder: (context, snapshot) {
      //       return AssetEntityImage(snapshot.data!.first, isOriginal: false);
      //     }),
    );
  }

  // ListView imageList() {
  //   return ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: allMedia.length,
  //       itemBuilder: ((context, index) {
  //         return FadeInImage(
  //           fit: BoxFit.cover,
  //           width: 128,
  //           height: 128,
  //           placeholder: MemoryImage(kTransparentImage),
  //           image: ThumbnailProvider(
  //             mediumId: allMedia[index].id,
  //             mediumType: MediumType.image,
  //             width: 128,
  //             height: 128,
  //           ),
  //         );
  //       }));
  // }
}
