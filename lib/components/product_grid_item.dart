import 'package:flutter/material.dart';
import 'package:flutter_animation/components/image_widget.dart';
import 'package:flutter_animation/models/product_variant_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

enum ProductItemEvent { EVENT_ADD_CART, EVENT_IMAGE_CLICK, EVENT_ITEM_OPEN }

class ProductGridItem extends StatelessWidget {
  const ProductGridItem(
      {Key key, @required this.item, this.heroPrefix: "home_", this.onTapEvent})
      : super(key: key);
  final ProductVariantsModel item;
  final String heroPrefix;
  final Function(ProductItemEvent event, ProductVariantsModel item) onTapEvent;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Container(
        width: 160,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    onTapEvent?.call(ProductItemEvent.EVENT_IMAGE_CLICK, item);
                  },
                  child: Container(
                    width: double.infinity,
                    child: Hero(
                      tag: "$heroPrefix${item.id}",
                      child: AspectRatio(
                          aspectRatio: 1.3,
                          child: item.thumb == null
                              ? Image.asset(
                                  "assets/icons/shatkora_placeholder.png")
                              : KImage(url: item.thumb)),
                    ), //Image.asset("assets/sample/product_image1.png"),
                  ),
                ),
                item.discount > 0
                    ? Positioned(
                        right: 0,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(6),
                              ),
                              color: Colors.redAccent),
                          child: Text(
                            (item.originalPrice - item.salePrice >=
                                    item.discount)
                                ? "${item.discount.toInt()}% off"
                                : "৳ ${(item.originalPrice - item.salePrice).toInt()} off",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
            InkWell(
              onTap: () {
                onTapEvent?.call(ProductItemEvent.EVENT_ITEM_OPEN, item);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item.title}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 12.0.sp),
                    ),
                    SizedBox(height: 4),
                    Text("${item.measurements}",
                        style: TextStyle(color: Colors.blue.shade700)),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "৳ ${item.salePrice}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.red),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "৳ ${item.originalPrice}",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.black45),
                        ),
                        Spacer(flex: 1),
                        Container(
                          margin: EdgeInsets.only(left: 4, right: 4),
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.lightGreen,
                            ),
                            child: InkWell(
                              onTap: () {
                                onTapEvent?.call(
                                    ProductItemEvent.EVENT_ADD_CART, item);
                              },
                              splashColor: Colors.red,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 6)
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

class ProductGridShimmerItem extends StatelessWidget {
  const ProductGridShimmerItem({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade600,
        highlightColor: Colors.grey.shade700,
        enabled: true,
        child: Container(
          width: 160,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1.3,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade50.withOpacity(0.1))),
                    ), //Image.asset("assets/sample/product_image1.png"),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey.shade50.withOpacity(0.10)),
                      child: Container(
                        width: 50,
                        height: 16,
                      ),
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade50.withOpacity(0.2)),
                          child: SizedBox(width: 120, height: 12)),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.shade50.withOpacity(0.2)),
                              child: SizedBox(width: 80, height: 12)),
                          SizedBox(width: 12),
                          Spacer(flex: 1),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.shade50.withOpacity(0.2)),
                              child: SizedBox(width: 20, height: 20)),
                        ],
                      ),
                      SizedBox(height: 6)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
