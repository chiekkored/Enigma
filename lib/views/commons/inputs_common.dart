import 'package:flutter/material.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/string_constant.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';

/// SECTION CustomAuthInput
/// Custom Inputs with Icons
/// Commonly used for authentication pages
///
/// @param obscureText Whether to hide the text being edited
/// @param icon icon that appears before the [prefix] or [prefixText] and before the editable part of the text field
/// @param hintText Text that suggests what sort of input the field accepts
/// @param controller Controls the text being edited
/// @param textInputAction The type of action button to use for the keyboard.
/// @param keyboardType Creates a Material Design text field.
///
/// @author Thomas Rey B Barcenas
class CustomAuthInput extends StatelessWidget {
  final bool? textCapitalization;
  final bool obscureText;
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  const CustomAuthInput({
    Key? key,
    this.textCapitalization,
    required this.obscureText,
    required this.icon,
    required this.hintText,
    required this.controller,
    required this.textInputAction,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        textCapitalization: textCapitalization == true
            ? TextCapitalization.words
            : TextCapitalization.none,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textInputAction: textInputAction,
        style: const TextStyle(fontSize: 16.0),
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
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.w500, fontFamily: "Inter"),
        ));
  }
}

/// !SECTION

/// SECTION CustomAuthPasswordInput
/// Custom Inputs with Icons
/// Commonly used for password authentication pages
///
/// @param icon An icon that appears before the [prefix] or [prefixText] and before the editable part of the text field
/// @param hintText Text that suggests what sort of input the field accepts.
/// @param controller Controls the text being edited.
/// @param textInputAction The type of action button to use for the keyboard.
/// @param keyboardType Creates a Material Design text field.
///
/// @author Thomas Rey B Barcenas
class CustomAuthPasswordInput extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  const CustomAuthPasswordInput({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
    required this.textInputAction,
    required this.keyboardType,
  }) : super(key: key);

  @override
  State<CustomAuthPasswordInput> createState() =>
      _CustomAuthPasswordInputState();
}

class _CustomAuthPasswordInputState extends State<CustomAuthPasswordInput> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: obscureText,
        textInputAction: widget.textInputAction,
        style: const TextStyle(fontSize: 16.0),
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
              widget.icon,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 26.0),
            child: IconButton(
                icon: Icon(
                  obscureText ? CustomIcons.eye : CustomIcons.eye_fill,
                ),
                onPressed: () => setState(() {
                      obscureText = !obscureText;
                    })),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.w500, fontFamily: "Inter"),
        ));
  }
}

/// !SECTION

/// SECTION CustomTextFieldTags
/// Custom reusable TextFieldTags
///
/// @param hintText Text for the Field Tag hint
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
          onPressed: (item) => debugPrint(item.toString()),
          onLongPressed: (item) => debugPrint(item.toString()),
        );
      },
    );
  }
}

/// !SECTION

/// SECTION CustomTextFieldTagsForInterests
/// Custom reusable TextFieldTags
///
/// @param hintText Text for the Field Tag hint
///
/// @author Thomas Rey B Barcenas
class CustomTextFieldTagsForInterests extends StatefulWidget {
  final bool? textCapitalization;
  final String hintText;
  final String tagEmoji;
  final List<String> interests;
  final List<String>? suggestions;
  const CustomTextFieldTagsForInterests({
    Key? key,
    this.textCapitalization,
    required this.hintText,
    required this.tagEmoji,
    required this.interests,
    this.suggestions,
  }) : super(key: key);

  @override
  State<CustomTextFieldTagsForInterests> createState() =>
      _CustomTextFieldTagsForInterestsState();
}

class _CustomTextFieldTagsForInterestsState
    extends State<CustomTextFieldTagsForInterests> {
  final GlobalKey<TagsState> tagStateKey = GlobalKey<TagsState>();
  final List _items = [];

  @override
  Widget build(BuildContext context) {
    return Tags(
      key: tagStateKey,
      runAlignment: WrapAlignment.start,
      alignment: WrapAlignment.start,
      textField: TagsTextField(
        textCapitalization: widget.textCapitalization == true
            ? TextCapitalization.words
            : TextCapitalization.none,
        inputDecoration: const InputDecoration(
          border: InputBorder.none,
        ),
        autofocus: false,
        hintText: "Add ${widget.hintText}",
        hintTextColor: CColors.strokeColor,
        textStyle: const TextStyle(
            color: CColors.primaryTextLightColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter"),
        suggestions: widget.suggestions,
        constraintSuggestion: false,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        onSubmitted: (String str) {
          if (str != '') {
            setState(() {
              // required
              _items.add(Item(
                  title: str,
                  active: true,
                  index: 1,
                  customData: DateTime.now().toString()));
              widget.interests.add(str);
            });
          } else {
            null;
          }
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
              child: Text(
                  widget.tagEmoji)), // OR NetworkImage("https://...image.png")
          icon: ItemTagsIcon(
            icon: Icons.add,
          ),
          removeButton: ItemTagsRemoveButton(
            onRemoved: () {
              setState(() {
                _items.removeAt(index);
                widget.interests.removeAt(index);
              });
              return true;
            },
          ),
          onPressed: (item) => debugPrint(item.toString()),
          onLongPressed: (item) => debugPrint(item.toString()),
        );
      },
    );
  }
}

/// !SECTION

/// SECTION CustomTextFieldTagsForInterestsUpdate
/// Custom reusable TextFieldTags
///
/// @param hintText Text for the Field Tag hint
///
/// @author Thomas Rey B Barcenas
class CustomTextFieldTagsForInterestsUpdate extends StatefulWidget {
  final bool? textCapitalization;
  final String hintText;
  final String tagEmoji;
  final List<dynamic> interests;
  final List<String>? suggestions;
  const CustomTextFieldTagsForInterestsUpdate({
    Key? key,
    this.textCapitalization,
    required this.hintText,
    required this.tagEmoji,
    required this.interests,
    this.suggestions,
  }) : super(key: key);

  @override
  State<CustomTextFieldTagsForInterestsUpdate> createState() =>
      _CustomTextFieldTagsForInterestsUpdateState();
}

class _CustomTextFieldTagsForInterestsUpdateState
    extends State<CustomTextFieldTagsForInterestsUpdate> {
  final GlobalKey<TagsState> tagStateKey = GlobalKey<TagsState>();
  List _items = [];

  @override
  void initState() {
    super.initState();
    _items = widget.interests
        .map((item) => Item(
            title: titleCase(item),
            active: true,
            index: 1,
            customData: DateTime.now().toString()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Tags(
      key: tagStateKey,
      runAlignment: WrapAlignment.start,
      alignment: WrapAlignment.start,
      textField: TagsTextField(
        textCapitalization: widget.textCapitalization == true
            ? TextCapitalization.words
            : TextCapitalization.none,
        inputDecoration: const InputDecoration(
          border: InputBorder.none,
        ),
        autofocus: false,
        hintText: "Add ${widget.hintText}",
        hintTextColor: CColors.strokeColor,
        textStyle: const TextStyle(
            color: CColors.primaryTextLightColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter"),
        suggestions: widget.suggestions,
        constraintSuggestion: false,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        onSubmitted: (String str) {
          if (str != '') {
            setState(() {
              // required
              _items.add(Item(
                  title: str,
                  active: true,
                  index: 1,
                  customData: DateTime.now().toString()));
              widget.interests.add(str);
            });
          } else {
            null;
          }
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
              child: Text(
                  widget.tagEmoji)), // OR NetworkImage("https://...image.png")
          icon: ItemTagsIcon(
            icon: Icons.add,
          ),
          removeButton: ItemTagsRemoveButton(
            onRemoved: () {
              setState(() {
                _items.removeAt(index);
                widget.interests.removeAt(index);
              });
              return true;
            },
          ),
          onPressed: (item) => debugPrint(item.toString()),
          onLongPressed: (item) => debugPrint(item.toString()),
        );
      },
    );
  }
}

/// !SECTION

/// SECTION customSmallInputDecoration
/// Custom Input Decoration for Small Inputs
///
/// @param hintText Text for the Field Tag hint
/// @param hintTextColor Color for the Field Tag hint
/// @param fillColor Fill color for the Field Tag hint
///
/// @author Chiekko Red
InputDecoration customSmallInputDecoration({
  required String hintText,
  required Color hintTextColor,
  required Color fillColor,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: hintTextColor),
    contentPadding: const EdgeInsets.all(10.0),
    filled: true,
    fillColor: fillColor,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide.none,
    ),
  );
}

/// !SECTION
