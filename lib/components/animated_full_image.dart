import 'package:flutter/material.dart';
import 'package:flutter_animation/components/image_widget.dart';
import 'package:flutter_animation/components/product_grid_item.dart';
import 'package:flutter_animation/models/product_variant_model.dart';
import 'package:flutter_animation/navigator.dart';
import 'package:flutter_animation/utils/utils.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:sizer/sizer.dart';

class AnimatedImagePreview extends StatelessWidget {
  final String url;
  final String animationKey;
  final ProductVariantsModel variantItem;

  const AnimatedImagePreview(
      {Key key, this.url, this.animationKey, this.variantItem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.6),
      child: InkWell(
        onTap: () {
          Navigation.pop(context);
        },
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.2),
              child: Center(
                child: Container(
                  child: Hero(
                      tag: animationKey,
                      child: PinchZoom(
                        image: KImage(
                          url: url,
                        ),
                      )),
                ),
              ),
            ),
            SafeArea(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                      child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(24),
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: RaisedButton(
                          color: Colors.red, //const Color(0xFFF4C459),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onPressed: () async {
                            // Navigation.pop(context);
                            Utils.onProductItemClicked(
                                context,
                                ProductItemEvent.EVENT_ITEM_OPEN,
                                variantItem,
                                animationKey,
                                updateHero: false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "View details",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



class AnimatedImagePreviewFullScreen extends StatelessWidget {
  final String url;
  final String animationKey;

  const AnimatedImagePreviewFullScreen(
      {Key key, this.url, this.animationKey })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          Container(
            child: Center(
              child: Container(
                child: Hero(
                    tag: animationKey,
                    child: PinchZoom(
                      image: KImage(
                        url: url,
                      ),
                    )),
              ),
            ),
          ),
          SafeArea(
            child: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                    ))),
          ),
        ],
      ),
    );
  }
}
