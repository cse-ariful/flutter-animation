import 'package:flutter/material.dart';
import 'package:flutter_animation/components/image_widget.dart';
import 'package:flutter_animation/models/category_model.dart';
import 'package:flutter_animation/navigator.dart';
import 'package:flutter_animation/ui/productList/product_list.dart';
import 'package:flutter_animation/viewmodels/category_viewmodel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryViewModel>(
      create: (ctx) => CategoryViewModel(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text("Categories", style: TextStyle(color: Colors.black)),
        ),
        body: Consumer<CategoryViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.loading) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      final items = viewModel.breadCrumbs ?? [];
                      if (items.isEmpty || items.length < 2) return SizedBox();
                      return Card(
                        child: Container(
                            height: 40,
                            child: Center(
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  itemCount: items.length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 18,
                                          color: Colors.orange,
                                        ),
                                      ),
                                  itemBuilder: (context, index) {
                                    final item = items[index];
                                    return InkWell(
                                      onTap: () {
                                        viewModel.onBreadcrumbClicked(
                                            item, index);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${item.title}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              .copyWith(color: Colors.green),
                                        ),
                                      ),
                                    );
                                  }),
                            )),
                      );
                    }),
                    Builder(
                      builder: (context) {
                        final items = viewModel.currentCategories ?? [];
                        return StaggeredGridView.countBuilder(
                            crossAxisCount: 3,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return AnimatedListItem(
                                index: index,
                                item: item,
                                onTap: (item, index) {
                                  if (item.isLeaf) {
                                    Navigation.push(context, ProductList());
                                  } else {
                                    viewModel.onCategoryItemClicked(item);
                                  }
                                },
                              );
                            },
                            staggeredTileBuilder: (index) =>
                                StaggeredTile.fit(1));
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AnimatedListItem extends StatefulWidget {
  final int index;
  final CategoryModel item;
  final Function(CategoryModel item, int index) onTap;

  AnimatedListItem({Key key, this.item, this.index, this.onTap})
      : super(key: key);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: (widget.index + 1 * 10) * 50), () {
      setState(() {
        _animate = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 700),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutCirc,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 700),
        padding: _animate
            ? const EdgeInsets.all(4.0)
            : const EdgeInsets.only(top: 10),
        child: Container(
          constraints: BoxConstraints.expand(height: 100),
          child: Card(
            elevation: 0.5,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: InkWell(
              onTap: () {
                widget.onTap?.call(widget.item, widget.index);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      child: KImage(
                        url: widget.item.image,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "${widget.item.title}\n",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
