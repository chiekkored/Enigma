import 'package:enigma/core/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'package:enigma/utilities/configs/custom_icons.dart';
import 'package:enigma/utilities/constants/themes_constant.dart';
import 'package:enigma/views/screens/home/chat/chat_screen.dart';
import 'package:enigma/views/screens/home/profile/profile_screen.dart';
import 'package:enigma/views/screens/home/search/search_loading_screen.dart';
import 'package:enigma/views/screens/home/settings/settings_screen.dart';
import 'package:provider/provider.dart';

// NOTE Rename the class into Navigation
class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();
    PersistentTabController controller =
        PersistentTabController(initialIndex: 0);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Container(
        color: CColors.scaffoldLightBackgroundColor,
        child: SafeArea(
          bottom: false,
          child: PersistentTabView(
            context,
            controller: controller,
            navBarStyle: NavBarStyle.style8,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: FloatingActionButton(
                backgroundColor: CColors.buttonLightColor,
                onPressed: () =>
                    pushNewScreen(context, screen: const SearchLoadingScreen()),
                child: const Icon(
                  CustomIcons.plus,
                  size: 36.0,
                  color: CColors.white,
                ),
              ),
            ),
            screens: const [
              // SECTION: Bottom Navigation Screen List
              ChatScreen(),
              ProfileScreen(),
              SettingsScreen(),
              // !SECTION
            ],
            items: [
              // SECTION: Bottom Navigation Screen Style
              PersistentBottomNavBarItem(
                icon: const Icon(CustomIcons.chat_fill),
                inactiveIcon: const Icon(CustomIcons.chat),
                iconSize: 28,
                title: "Chat",
                activeColorPrimary: CColors.buttonLightColor,
                inactiveColorPrimary: CColors.secondaryTextLightColor,
                textStyle: customSubtitle2TextStyle(),
              ),
              PersistentBottomNavBarItem(
                icon: const Icon(CustomIcons.profile_fill),
                inactiveIcon: const Icon(CustomIcons.profile),
                iconSize: 28,
                title: "Profile",
                activeColorPrimary: CColors.buttonLightColor,
                inactiveColorPrimary: CColors.secondaryTextLightColor,
                textStyle: customSubtitle2TextStyle(),
              ),
              PersistentBottomNavBarItem(
                icon: const Icon(CustomIcons.settings_fill),
                inactiveIcon: const Icon(CustomIcons.settings),
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
