import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animation/apptheme.dart';
import 'package:flutter_animation/drawer_index.dart';
import 'package:flutter_animation/drawer_item_model.dart';

class DrawerView extends StatefulWidget {
  final AnimationController iconAnimationController;
  final Function(DrawerItemModel item) onMenuClick;
  final List<DrawerItemModel> drawerItem;
  final DrawerIndex currentIndex;

  const DrawerView(
      {Key key,
      this.iconAnimationController,
      this.onMenuClick,
      this.currentIndex: DrawerIndex.HOME,
      this.drawerItem})
      : super(key: key);
  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedCircularAvatar(
                    animationController: widget.iconAnimationController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      'Chris Hemsworth',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            color: Colors.black45,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.drawerItem.length,
                itemBuilder: (context, index) {
                  return buildMenuItem(widget.drawerItem[index]);
                }),
          ),
          Divider(),
          ListTile(
            title: Text(
              'Sign Out',
              style: TextStyle(
                fontFamily: AppTheme.fontName,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppTheme.darkText,
              ),
              textAlign: TextAlign.left,
            ),
            trailing: Icon(
              Icons.power_settings_new,
              color: Colors.red,
            ),
            onTap: () {},
          ),
          SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }

  Widget buildMenuItem(DrawerItemModel item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        onTap: () {
          widget.onMenuClick(item);
        },
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    width: 6.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color: widget.currentIndex == item.drawerIndex
                          ? Colors.blue
                          : Colors.transparent,
                      borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  item.isAsset
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(item.assetName,
                              color: widget.currentIndex == item.drawerIndex
                                  ? Colors.blue
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(
                          item.iconData,
                          color: widget.currentIndex == item.drawerIndex
                              ? Colors.blue
                              : AppTheme.nearlyBlack,
                        ),
                  Padding(padding: EdgeInsets.all(8)),
                  Text(
                    "${item.title}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.currentIndex == item.drawerIndex
                          ? Colors.blue
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.currentIndex == item.drawerIndex
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class AnimatedCircularAvatar extends StatelessWidget {
  const AnimatedCircularAvatar({
    Key key,
    @required this.animationController,
  }) : super(key: key);

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return ScaleTransition(
          scale: AlwaysStoppedAnimation<double>(
              1.0 - (animationController.value) * 0.4),
          child: RotationTransition(
            turns: AlwaysStoppedAnimation<double>(
                Tween<double>(begin: 0.0, end: 24.0)
                        .animate(CurvedAnimation(
                            parent: animationController,
                            curve: Curves.fastOutSlowIn))
                        .value /
                    180),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: AppTheme.grey.withOpacity(0.6),
                      offset: const Offset(2.0, 4.0),
                      blurRadius: 8),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                child: Image.asset('assets/images/userImage.png'),
              ),
            ),
          ),
        );
      },
    );
  }
}
