import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/apptheme.dart';
import 'package:flutter_animation/drawer_index.dart';
import 'package:flutter_animation/drawer_item_model.dart';
import 'package:flutter_animation/drawer_view.dart';

class CustomDrawerController extends StatefulWidget {
  final double drawerWidth;
  final Widget content;
  final Widget menuIconView;
  final DrawerIndex currentIndex;
  final int drawerAnimationDuration;
  final Function(bool isOpen) drawerToggleCallback;
  final Function(DrawerItemModel item) onItemTapped;

  const CustomDrawerController(
      {Key key,
      this.drawerWidth,
      this.content,
      this.menuIconView,
      this.currentIndex,
      this.onItemTapped,
      this.drawerAnimationDuration: 600,
      this.drawerToggleCallback})
      : super(key: key);
  @override
  _CustomDrawerControllerState createState() => _CustomDrawerControllerState();
}

class _CustomDrawerControllerState extends State<CustomDrawerController>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  AnimationController iconAnimationController;
  double scrollOffset = 0.0;
  @override
  void initState() {
    iconAnimationController =
        AnimationController(duration: Duration(seconds: 0), vsync: this);
    _scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);
    _configureScrollListener();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {_getinitState()});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppTheme.white,
        body: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
          child: SizedBox(
            width: screenSize.width + widget.drawerWidth,
            height: screenSize.height,
            child: Row(
              children: [
                SizedBox(
                  width: widget.drawerWidth,
                  height: screenSize.height,
                  child: AnimatedBuilder(
                    animation: iconAnimationController,
                    builder: (context, child) {
                      return Transform(
                          transform: Matrix4.translationValues(
                              _scrollController.offset, 0.0, 0.0),
                          child: DrawerView(
                            iconAnimationController: iconAnimationController,
                            drawerItem: DrawerData.drawerItems,
                            currentIndex: widget.currentIndex,
                            onMenuClick: (item) {
                              toggleDrawer();
                              if (widget.onItemTapped != null) {
                                widget.onItemTapped(item);
                              }
                              print("drawer controller 69");
                            },
                          ));
                    },
                  ),
                ),
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: AppTheme.grey.withOpacity(0.6),
                            blurRadius: 24,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          IgnorePointer(
                            ignoring:
                                true, // scrollOffset == 0.0 ? true : false,
                            child: widget.content,
                          ),
                          if (scrollOffset == 1.0)
                            InkWell(
                              onTap: () {
                                toggleDrawer();
                              },
                            ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top + 8,
                                left: 8),
                            child: SizedBox(
                              width: AppBar().preferredSize.height - 8,
                              height: AppBar().preferredSize.height - 8,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                      AppBar().preferredSize.height),
                                  child: Center(
                                    // if you use your own menu view UI you add form initialization
                                    child: widget.menuIconView != null
                                        ? widget.menuIconView
                                        : AnimatedIcon(
                                            icon: AnimatedIcons.arrow_menu,
                                            progress: iconAnimationController),
                                  ),
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    toggleDrawer();
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }

  Future<bool> toggleDrawer() async {
    if (_scrollController.offset == 0.0) {
      _scrollController.animateTo(widget.drawerWidth,
          duration: Duration(milliseconds: widget.drawerAnimationDuration),
          curve: Curves.fastOutSlowIn);
    } else {
      _scrollController.animateTo(00,
          duration: Duration(milliseconds: widget.drawerAnimationDuration),
          curve: Curves.fastOutSlowIn);
    }
    return true;
  }

  void _configureScrollListener() {
    _scrollController.addListener(() {
      // print("Scrolling ");
      if (_scrollController.offset <= 0) {
        if (scrollOffset != 1.0) {
          setState(() {
            scrollOffset = 1.0;
            widget.drawerToggleCallback(true);
          });
        }
      } else if (_scrollController.offset > 0 &&
          _scrollController.offset < widget.drawerWidth.floor()) {
        //animating the menu icon code goes here
        iconAnimationController.animateTo(
            (_scrollController.offset * 100 / (widget.drawerWidth)) / 100,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      } else {
        //drawer closed
        if (scrollOffset != 0) {
          setState(() {
            scrollOffset = 0.0;
            widget.drawerToggleCallback(false);
          });
        }
      }
    });
  }
}

double calculatePercent(double finished, double total) {
  return ((total - finished) / total) * 100;
}

class DrawerData {
  static final drawerItems = [
    DrawerItemModel(
      title: "Home",
      drawerIndex: DrawerIndex.HOME,
      iconData: Icons.home,
    ),
    DrawerItemModel(
        title: "Cart",
        drawerIndex: DrawerIndex.CART,
        iconData: Icons.shopping_cart_outlined),
    DrawerItemModel(
      title: "My Orders",
      drawerIndex: DrawerIndex.MY_ORDERS,
      iconData: Icons.shopping_bag_outlined,
    ),
    DrawerItemModel(
      title: "To Review",
      drawerIndex: DrawerIndex.TO_REVIEW,
      iconData: Icons.rate_review_outlined,
    ),
    DrawerItemModel(
      title: "Whatsaapp",
      drawerIndex: DrawerIndex.CONTACT_WHATSAPP,
      iconData: Icons.whatshot_outlined,
    )
  ];
}
