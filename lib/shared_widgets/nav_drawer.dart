import 'package:flutter/material.dart';
import 'package:technical_take_home/helper/constant.dart';
import 'package:technical_take_home/helper/locator.dart';
import 'package:technical_take_home/helper/navigator_service.dart';
import 'package:technical_take_home/helper/app_scale.dart';
import 'package:technical_take_home/theme/colors.dart';

class NavDrawer extends StatefulWidget {
  final String selectedMenu;
  const NavDrawer({Key? key, required this.selectedMenu}) : super(key: key);
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        margin: const EdgeInsets.only(
          top: 25,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: kToolbarHeight + 10,
                padding: const EdgeInsets.all(12),
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: context.scaleFont(28),
                    color: sampleAppMenuBg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                selected: widget.selectedMenu == Constant.menuHome,
                selectedTileColor: sampleAppMenuBg,
                onTap: () {
                  if (widget.selectedMenu != Constant.menuHome) {
                    locator<NavigatorService>().navigateTo(Constant.menuHome);
                  } else {
                    locator<NavigatorService>().goBack();
                  }
                },
                title: Text(
                  "Home",
                  style: TextStyle(
                    fontSize: context.scaleFont(16),
                    color: widget.selectedMenu == Constant.menuHome ? sampleAppWhite : sampleAppMenuBg,
                  ),
                ),
              ),
              ListTile(
                selected: widget.selectedMenu == Constant.menuFilm,
                selectedTileColor: sampleAppMenuBg,
                onTap: () {
                  if (widget.selectedMenu != Constant.menuFilm) {
                    locator<NavigatorService>().navigateTo(Constant.menuFilm);
                  } else {
                    locator<NavigatorService>().goBack();
                  }
                },
                title: Text(
                  "Movies",
                  style: TextStyle(
                    fontSize: context.scaleFont(16),
                    color: widget.selectedMenu == Constant.menuFilm ? sampleAppWhite : sampleAppMenuBg,
                  ),
                ),
              ),
              ListTile(
                selected: widget.selectedMenu == Constant.menuSeries,
                selectedTileColor: sampleAppMenuBg,
                onTap: () {
                  if (widget.selectedMenu != Constant.menuSeries) {
                    locator<NavigatorService>().navigateTo(Constant.menuSeries);
                  } else {
                    locator<NavigatorService>().goBack();
                  }
                },
                title: Text(
                  "TV Series",
                  style: TextStyle(
                    fontSize: context.scaleFont(16),
                    color: widget.selectedMenu == Constant.menuSeries ? sampleAppWhite : sampleAppMenuBg,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
