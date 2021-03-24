import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation/components/animated_full_image.dart';
import 'package:flutter_animation/components/product_grid_item.dart';
import 'package:flutter_animation/models/product_variant_model.dart';
import 'package:flutter_animation/ui/productDetails/product_details.dart';
import 'package:sizer/sizer.dart';
import '../navigator.dart';
import 'app_theme.dart';

class Utils {
  static Future<int> showAddCartBottomSheet(
      BuildContext context, ProductVariantsModel item) async {
    return await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.DefCornerlg),
            topRight: Radius.circular(Dimensions.DefCornerlg),
          ),
        ),
        builder: (context) {
          return Wrap(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.card_giftcard, color: Colors.black45),
                          SizedBox(width: Dimensions.DefMarginHalf),
                          Text("Add items to cart")
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(Dimensions.DefMargin),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.2, color: Colors.black45),
                                borderRadius: BorderRadius.circular(
                                    Dimensions.DefCorner)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                  "assets/sample/product_image1.png"),
                            ),
                          ),
                          SizedBox(width: Dimensions.DefMargin),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "new vim liquid facewash and this name can be large",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12.0.sp),
                                ),
                                Dimensions.defVSpacingHalf(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      children: [
                                        Text("৳ 1,400 x 2"),
                                        Dimensions.defVSpacingHalf(),
                                        Text(
                                          "৳ 1,400",
                                          style: TextStyle(
                                            fontSize: 14.0.sp,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Ink(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: const Color(0xFFf1f3f4),
                                          ),
                                          child: InkWell(
                                            onTap: () {},
                                            splashColor: Colors.red,
                                            customBorder: CircleBorder(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.remove),
                                            ),
                                          ),
                                        ),
                                        Dimensions.defHSpacing(),
                                        Text("5"),
                                        Dimensions.defHSpacing(),
                                        Ink(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: const Color(0xFFf1f3f4),
                                          ),
                                          child: InkWell(
                                            onTap: () {},
                                            splashColor: Colors.green,
                                            customBorder: CircleBorder(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RaisedButton(
                            color: const Color(0xFFEEEEEE),
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Text("ADD TO CART"),
                          ),
                          RaisedButton(
                            color: Colors.black,
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              "CHECKOUT",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          );
        });
  }

  static Future delay(int milis) async {
    await Future.delayed(Duration(milliseconds: milis));
  }

  static Future<Map<String, dynamic>> parseJsonFromAssets(
      String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  static LinearProgressbar() {
    return LinearProgressIndicator(
      backgroundColor: Colors.red,
      valueColor: AlwaysStoppedAnimation<Color>(
        Colors.amber,
      ),
    );
  }

  static Future onProductItemClicked(context, ProductItemEvent event,
      ProductVariantsModel item, String heroPrefix,
      {bool updateHero: true}) async {
    if (event == ProductItemEvent.EVENT_ADD_CART) {
      final amount = await Utils.showAddCartBottomSheet(context, item);
    } else if (event == ProductItemEvent.EVENT_ITEM_OPEN ||
        event == ProductItemEvent.EVENT_IMAGE_CLICK) {
      Navigation.push(
          context,
          ProductDetails(
            imageUrl: item.defaultImage,
            variantId: item.id,
            productID: item.productId,
            variant: item,
            heroTag: "$heroPrefix${updateHero ? item.id : ""}",
          ));
    } else if (event == ProductItemEvent.EVENT_IMAGE_CLICK &&
        item.defaultImage != null) {
      Navigation.pushTransparent(
          context,
          AnimatedImagePreview(
            url: item.defaultImage,
            animationKey: "$heroPrefix${item.id}",
            variantItem: item,
          ));
    }
  }
}
