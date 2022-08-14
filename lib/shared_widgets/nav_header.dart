// import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:technical_take_home/helper/locator.dart';
import 'package:technical_take_home/helper/navigator_service.dart';
import 'package:technical_take_home/shared_widgets/expandable_widget.dart';
import 'package:technical_take_home/theme/colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_take_home/helper/app_scale.dart';

AppBar navHeader(String titleAppBar, {List<Widget>? actions}) {
  return AppBar(
    title: Text(
      titleAppBar,
      style: const TextStyle(fontWeight: FontWeight.bold, color: sampleAppWhite),
    ),
    leading: Builder(
      builder: (context) {
        return IconButton(
          icon: Icon(
            Icons.menu,
            color: sampleAppWhite,
            size: context.scaleFont(28),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
    actions: actions,
  );
}

AppBar simpleHeader(String titleAppBar, {Function()? onBackPressed}) {
  return AppBar(
    title: Text(
      titleAppBar,
      style: const TextStyle(fontWeight: FontWeight.bold, color: sampleAppWhite),
    ),
    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: sampleAppWhite,
          size: context.scaleFont(28),
        ),
        onPressed: onBackPressed ?? () => locator<NavigatorService>().goBack(),
      ),
    ),
  );
}

AppBar plainHeader(String titleAppBar) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Center(
      child: Text(
        titleAppBar,
        style: const TextStyle(color: sampleAppWhite),
      ),
    ),
  );
}

class SearchfieldAppbar extends StatefulWidget {
  // final Widget? leading;
  final String title;
  final Function(String?) onSearch;
  const SearchfieldAppbar({
    Key? key,
    // this.leading,
    required this.title,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<SearchfieldAppbar> createState() => _SearchfieldAppbarState();
}

class _SearchfieldAppbarState extends State<SearchfieldAppbar> {
  final textcon = TextEditingController();
  bool onSearching = false;
  String searchVal = '';
  String title = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: context.statusBar,
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ExpandableWidget(
                      direction: Axis.horizontal,
                      expand: !onSearching,
                      child: IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: sampleAppWhite,
                          size: context.scaleFont(24),
                        ),
                      ),
                    ),
                    ExpandableWidget(
                      direction: Axis.horizontal,
                      expand: !onSearching,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title.isNotEmpty ? title : widget.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: context.scaleFont(22),
                            color: sampleAppWhite,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: ExpandableWidget(
                    direction: Axis.horizontal,
                    expand: onSearching,
                    child: TextField(
                      controller: textcon,
                      onSubmitted: (val) {
                        widget.onSearch(val);
                        setState(() {
                          onSearching = false;
                          searchVal = val;
                          title = searchVal;
                        });
                      },
                      style: TextStyle(
                        fontSize: context.scaleFont(15),
                        color: sampleAppWhite,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: context.scaleFont(15),
                          color: sampleAppLightGray,
                        ),
                        prefixIcon: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: sampleAppWhite,
                          ),
                          onPressed: () {
                            setState(() {
                              onSearching = false;
                            });
                            if (searchVal.isEmpty) {
                              textcon.clear();
                            } else {
                              textcon.value = textcon.value.copyWith(text: searchVal);
                            }
                          },
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close, color: sampleAppWhite),
                          onPressed: () {
                            if (textcon.text.isNotEmpty) {
                              textcon.clear();
                              searchVal = "";
                            } else {
                              widget.onSearch(searchVal);
                              setState(() {
                                title = '';
                                onSearching = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                ExpandableWidget(
                  direction: Axis.horizontal,
                  expand: !onSearching,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        onSearching = true;
                      });
                    },
                    icon: Icon(
                      Icons.search,
                      color: sampleAppWhite,
                      size: context.scaleFont(28),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TransparentAppbar extends StatefulWidget {
  const TransparentAppbar({
    Key? key,
  }) : super(key: key);

  @override
  State<TransparentAppbar> createState() => _TransparentAppbarState();
}

class _TransparentAppbarState extends State<TransparentAppbar> {
  final textcon = TextEditingController();
  bool onSearching = false;
  String searchVal = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.5),
            Theme.of(context).primaryColor.withOpacity(0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.statusBar,
          ),
          IconButton(
            onPressed: () {
              locator<NavigatorService>().goBack();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              size: context.scaleFont(24),
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
