import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/screens/home/chat/chat_screen.dart';

// NOTE Rename the class into Navigation
class NavigationHome extends StatelessWidget {
  const NavigationHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller =
        PersistentTabController(initialIndex: 0);
    return Container(
      color: CColors.scaffoldLightBackgroundColor,
      child: SafeArea(
        bottom: false,
        child: PersistentTabView(
          context,
          controller: controller,
          navBarStyle: NavBarStyle.style8,
          screens: const [
            // SECTION: Bottom Navigation Screen List
            ChatScreen(),
            ChatScreen(),
            ChatScreen(),
            // !SECTION
          ],
          items: [
            // SECTION: Bottom Navigation Screen Style
            PersistentBottomNavBarItem(
              icon: const Icon(CustomIcons.chat),
              iconSize: 28,
              title: "Chat",
              activeColorPrimary: CColors.buttonLightColor,
              inactiveColorPrimary: CColors.secondaryTextLightColor,
              textStyle: customSubtitle2TextStyle(),
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(CustomIcons.profile),
              iconSize: 28,
              title: "Profile",
              activeColorPrimary: CColors.buttonLightColor,
              inactiveColorPrimary: CColors.secondaryTextLightColor,
              textStyle: customSubtitle2TextStyle(),
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(CustomIcons.settings),
              iconSize: 28,
              title: "Settings",
              activeColorPrimary: CColors.buttonLightColor,
              inactiveColorPrimary: CColors.secondaryTextLightColor,
              textStyle: customSubtitle2TextStyle(),
            ),
            // !SECTION
          ],
        ),
      ),
    );
  }

  TextStyle customSubtitle2TextStyle() {
    return const TextStyle(
        color: CColors.primaryTextLightColor,
        fontSize: 10.0,
        fontWeight: FontWeight.w500);
  }
}
