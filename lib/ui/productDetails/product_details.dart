import 'package:flutter/material.dart';
import 'package:flutter_animation/components/animated_full_image.dart';
import 'package:flutter_animation/components/image_widget.dart';
import 'package:flutter_animation/components/product_grid_item.dart';
import 'package:flutter_animation/models/product_variant_model.dart';
import 'package:flutter_animation/models/product_variants_response.dart';
import 'package:flutter_animation/navigator.dart';
import 'package:flutter_animation/utils/app_theme.dart';
import 'package:flutter_animation/utils/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  String heroTag;
  final int productID;
  final int variantId;
  final ProductVariantsModel variant;
  final String imageUrl;

  ProductDetails(
      {Key key,
      this.variant,
      this.heroTag,
      this.imageUrl,
      this.productID,
      this.variantId})
      : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<ProductVariantsModel> products = [];
  bool loading = true;
  @override
  void initState() {
    widget.heroTag = widget.heroTag ?? "hero_${widget.variantId}";
    _getTopProducts();
    super.initState();
  }

  void _getTopProducts() async {
    var response2 =
        await Utils.parseJsonFromAssets("assets/json/top_products.json");
    var parsed2 = ProductVariantResponse.fromJson(response2);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      products = parsed2.results.reversed.toList();
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap:(){
                      Navigation.push(context, AnimatedImagePreviewFullScreen(url:widget.imageUrl,animationKey:widget.heroTag,));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.36,
                      child: Hero(
                        tag: widget.heroTag,
                        child: KImage(
                          url: widget.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.DefMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.variant?.title}",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${widget.variant?.measurements}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Text("(৳ ${widget?.variant?.originalPrice})",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                    )),
                            Dimensions.defHSpacingHalf(),
                            Text("৳ ${widget?.variant?.salePrice}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                          ],
                        ),
                        SizedBox(  height: Dimensions.DefMargin ),
                        Text("Description",
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                        SizedBox(
                          height: Dimensions.DefMarginHalf,
                        ),
                        Text(
                          "This is the description about the products",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6, right: 6, top: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Realated Products",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(height: 12),
                              StaggeredGridView.countBuilder(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: loading ? 6 : products.length,
                                  itemBuilder: (context, index) {
                                    return loading
                                        ? ProductGridShimmerItem()
                                        : ProductGridItem(
                                            item: products[index],
                                            heroPrefix: "top_",
                                            onTapEvent: (event, item) async {
                                              print("event recieved $event");
                                              Utils.onProductItemClicked(
                                                  context, event, item, "top_");
                                            });
                                  },
                                  staggeredTileBuilder: (index) =>
                                      StaggeredTile.fit(1))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          _buildCartButton()
        ],
      ),
    );
  }

  Padding _buildCartButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: IconButton(
                onPressed: () => null,
                icon: Icon(
                  Icons.favorite_outline,
                  color: Colors.black,
                )),
          ),
          Expanded(
              flex: 4,
              child: RaisedButton(
                color: Colors.red, //const Color(0xFFF4C459),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () async {
                  await Utils.showAddCartBottomSheet(context, widget.variant);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Add to cart",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      brightness: Brightness.dark,
      title: Text(
        "Banana",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    );
  }
}
