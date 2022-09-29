import 'package:flutter/material.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

import 'package:enigma/utilities/constants/themes_constant.dart';

/// SECTION CustomAuthInput
/// Custom Inputs with Icons
/// Commonly used for authentication pages
///
/// @param obscureText boolean that obscures the text input
/// @param icon accepts IconData
/// @param hintText accepts string for hint text prop
/// @param controller is a controller for an editable text field
/// @param textInputAction action the user requested for the text input field to perform
/// @param keyboardType a text input control optimizer
///
/// @author Thomas Rey B Barcenas
class CustomAuthInput extends StatelessWidget {
  final bool obscureText;
  final IconData icon;
  final IconData? iconEnd;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  const CustomAuthInput({
    Key? key,
    required this.obscureText,
    required this.icon,
    required this.hintText,
    required this.controller,
    required this.textInputAction,
    required this.keyboardType,
    this.iconEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(
                color: CColors.secondaryTextLightColor,
                width: 1.0,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(color: CColors.buttonLightColor)),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 12.0),
            child: Icon(
              icon,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 26.0),
            child: Icon(
              iconEnd,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.w500, fontFamily: "Inter"),
        ));
  }
}

/// !SECTION

/// SECTION
/// Custom reusable TextFieldTags
///
/// @param tagsController controller for TextFieldTags widget
///
/// @author Chiekko Red
class CustomTextFieldTags extends StatefulWidget {
  final String hintText;
  const CustomTextFieldTags({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  State<CustomTextFieldTags> createState() => _CustomTextFieldTagsState();
}

class _CustomTextFieldTagsState extends State<CustomTextFieldTags> {
  final GlobalKey<TagsState> tagStateKey = GlobalKey<TagsState>();
  final List _items = [];

  @override
  Widget build(BuildContext context) {
    return Tags(
      key: tagStateKey,
      runAlignment: WrapAlignment.start,
      alignment: WrapAlignment.start,
      textField: TagsTextField(
        inputDecoration: const InputDecoration(
          border: InputBorder.none,
        ),
        autofocus: false,
        hintText: "Add ${widget.hintText}", hintTextColor: CColors.strokeColor,
        textStyle: const TextStyle(
            color: CColors.primaryTextLightColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter"),
        // constraintSuggestion: true, suggestions: ["heyyy"],
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        onSubmitted: (String str) {
          setState(() {
            // required
            _items.add(Item(
                title: str,
                active: true,
                index: 1,
                customData: DateTime.now().toString()));
          });
        },
      ),
      itemCount: _items.length,
      itemBuilder: (int index) {
        final item = _items[index];
        return ItemTags(
          key: Key(index.toString()),
          pressEnabled: false,
          index: index,
          title: item.title,
          active: item!.active,
          customData: item.customData,
          textActiveColor: CColors.black,
          textStyle: const TextStyle(
              color: CColors.primaryTextLightColor,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              fontFamily: "Inter"),
          combine: ItemTagsCombine.withTextAfter,
          activeColor: CColors.white,
          alignment: MainAxisAlignment.center,
          elevation: 0,
          image: ItemTagsImage(
              child:
                  const FlutterLogo()), // OR NetworkImage("https://...image.png")
          icon: ItemTagsIcon(
            icon: Icons.add,
          ),
          removeButton: ItemTagsRemoveButton(
            onRemoved: () {
              setState(() {
                _items.removeAt(index);
              });
              return true;
            },
          ),
          onPressed: (item) => print(item),
          onLongPressed: (item) => print(item),
        );
      },
    );
  }
}

/// !SECTION
