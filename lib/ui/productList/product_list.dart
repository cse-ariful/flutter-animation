import 'package:flutter/material.dart';
import 'package:flutter_animation/components/extensions.dart';
import 'package:flutter_animation/components/product_grid_item.dart';
import 'package:flutter_animation/models/product_variant_model.dart';
import 'package:flutter_animation/models/product_variants_response.dart';
import 'package:flutter_animation/utils/app_theme.dart';
import 'package:flutter_animation/utils/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ProductVariantsModel> products = [];
  bool loading = true;
  @override
  void initState() {
    _getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backBtn(context),
        backgroundColor: Colors.white,
        title: Text(
          "Top Products",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: loading
            ? StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                padding: EdgeInsets.only(top: 6),
                itemCount: 8,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                itemBuilder: (context, index) {
                  return ProductGridShimmerItem();
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              )
            : StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                padding: EdgeInsets.only(
                    top: Dimensions.DefMarginHalf,
                    left: Dimensions.DefMarginHalf,
                    right: Dimensions.DefMarginHalf),
                physics: const BouncingScrollPhysics(),
                itemCount: products.length,
                mainAxisSpacing: 8,
                itemBuilder: (context, index) {
                  return ProductGridItem(
                    item: products[index],
                    heroPrefix: "prod_",
                    onTapEvent: (event, item) {
                      Utils.onProductItemClicked(context, event, item, "prod_");
                    },
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
      ),
    );
  }

  void _getProducts() async {
    var response =
        await Utils.parseJsonFromAssets("assets/json/product_list.json");
    var parsed = ProductVariantResponse.fromJson(response);
    await Utils.delay(3000);
    setState(() {
      products = parsed.results;
      loading = false;
    });
  }
}
