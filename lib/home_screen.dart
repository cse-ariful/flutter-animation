import 'package:flutter/material.dart';
import 'package:flutter_animation/models/category_model.dart';
import 'package:flutter_animation/models/product_variant_model.dart';
import 'package:flutter_animation/models/product_variants_response.dart';
import 'package:flutter_animation/navigator.dart';
import 'package:flutter_animation/ui/category/category_screen.dart';
import 'package:flutter_animation/ui/productList/product_list.dart';
import 'package:flutter_animation/ui/search/custom_search.dart';
import 'package:flutter_animation/utils/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'components/category_item_widget.dart';
import 'package:sizer/sizer.dart';
import 'components/product_grid_item.dart';
import 'models/category_response.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<ProductVariantsModel> products = [];
  List<ProductVariantsModel> topProducts = [];
  List<CategoryModel> categories = [];
  @override
  void initState() {
    loadProductListJson();
    super.initState();
  }

  bool loading = true;
  loadProductListJson() async {
    var response =
        await Utils.parseJsonFromAssets("assets/json/product_list.json");
    var parsed = ProductVariantResponse.fromJson(response);
    setState(() {
      products = parsed.results;
    });
    var response2 =
        await Utils.parseJsonFromAssets("assets/json/top_products.json");
    var parsed2 = ProductVariantResponse.fromJson(response2);
    setState(() {
      topProducts = parsed2.results.reversed.toList();
    });
    response = await Utils.parseJsonFromAssets("assets/json/categories.json");
    final categoryRes = CategoryResponse.fromJson(response);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      categories = categoryRes.results;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {},
          customBorder: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          "Shatkora",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigation.pushWithFadeInEffect(context, CustomSearch());
            },
            customBorder: CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.search_outlined,
                color: Colors.black,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            customBorder: CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildTopCarousel(),
                _buildCategoriesSection(),
                _buildPopularProducts(),
                _buildShatkoraSpecial()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShatkoraSpecial() {
    return Container(
      margin: EdgeInsets.only(left: 12, top: 12),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shatkora Special",
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(fontSize: 12.0.sp),
              ),
              InkWell(
                onTap: () async {
                  await Navigation.push(context, ProductList());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    "See more",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.only(bottom: 6),
            child: SingleChildScrollView(
              physics: loading
                  ? NeverScrollableScrollPhysics()
                  : AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (loading)
                    for (int i = 0; i < 5; i++) ProductGridShimmerItem(),
                  if (!loading)
                    for (int i = 0; i < topProducts.length; i++)
                      ProductGridItem(
                        item: topProducts[i],
                        onTapEvent: (event, item) async {
                          if (event == ProductItemEvent.EVENT_ADD_CART) {
                            final amount = await Utils.showAddCartBottomSheet(
                                context, item);
                          }
                        },
                      ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPopularProducts() {
    return Container(
      margin: EdgeInsets.only(left: 12, top: 12),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular products",
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(fontSize: 12.0.sp),
              ),
              InkWell(
                onTap: () async {
                  await Navigation.push(context, ProductList());
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 12.0, top: 8, bottom: 8, left: 8),
                  child: Text(
                    "See more",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.only(bottom: 6),
            child: StaggeredGridView.countBuilder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: loading ? 10 : products.length,
                shrinkWrap: true,
                crossAxisCount: 2,
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
                staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
            /*   child: SingleChildScrollView(
              physics: loading
                  ? NeverScrollableScrollPhysics()
                  : AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (loading)
                    for (int i = 0; i < 5; i++) ProductGridShimmerItem(),
                  if (!loading)
                    for (int i = 0; i < products.length; i++)
                      ProductGridItem(
                        item: products[i],
                        heroPrefix: "top_",
                        onTapEvent: (event, item) async {
                          print("event recieved $event");
                          Utils.onProductItemClicked(
                              context, event, item, "top_");
                        },
                      ),
                ],
              ),
            ),
           */
          )
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(fontSize: 12.0.sp),
              ),
              InkWell(
                onTap: () async {
                  Navigation.push(context, CategoryScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12.0, top: 8, bottom: 8),
                  child: Text(
                    "See more",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 12),
            child: loading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (int i = 0; i < 4; i++) HomeCategoryShimmerItem()
                    ],
                  )
                : StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: categories.length,
                    mainAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      return HomeCategoryItem(
                        item: categories[index],
                      );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildTopCarousel() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(4),
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 24 / 9,
                  child: !loading
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            "assets/sample/sample_banner.jpg",
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 0.5,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
