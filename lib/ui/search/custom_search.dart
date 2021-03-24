import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animation/components/product_grid_item.dart';
import 'package:flutter_animation/components/sort_bottom_sheet.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class CustomSearch extends StatefulWidget {
  @override
  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  final searchController = TextEditingController();
  Timer autoInvokeTimer;
  String lastQuery;
  String lastSearched = "";
  bool showingResult = false;
  FocusNode focusNode = FocusNode();
  int filterIndex = 0;

  String filter;

  @override
  void initState() {
    super.initState();
  }

  void processQueryChange(String query) {
    print("Query Changed called $query");
    if (autoInvokeTimer != null && autoInvokeTimer.isActive)
      autoInvokeTimer.cancel();
    if (query.isNotEmpty && query != lastQuery && query.length > 2) {
      autoInvokeTimer = Timer(Duration(milliseconds: 700), () {
        lastQuery = query;
        applySearch(query);
      });
    }
  }

  Future applySearch(String query) async {
    if (autoInvokeTimer?.isActive ?? false) autoInvokeTimer.cancel();
    lastQuery = query;
    setState(() {
      showingResult = !showingResult;
      lastQuery = query;
    });
    print("Seach apply called $query");
  }

  @override
  Widget build(BuildContext context) {
    print("building search ui $showingResult");
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 0.5,
                      offset: Offset(0.0, 0.25),
                    )
                  ]),
                  height: AppBar().preferredSize.height,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        customBorder: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 8, bottom: 8),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          autofocus: true,
                          controller: searchController,
                          onChanged: (value) {
                            processQueryChange(value);
                          },
                          onFieldSubmitted: (value) {
                            applySearch(value);
                          },
                          minLines: 1,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search for products"),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          searchController.text = "";
                        },
                        customBorder: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 8, bottom: 8),
                          child: Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("sortButton clicked");
                          _showFilterBottomSheet(context);
                        },
                        customBorder: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 8, bottom: 8),
                          child: Icon(
                            Icons.sort_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                child: Container(child: Builder(builder: (context) {
                 return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    padding: EdgeInsets.only(top: 6),
                    itemCount: 8,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8,
                    itemBuilder: (context, index) {
                      return ProductGridShimmerItem();
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  );

                })),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return SortFilterBottomSheet(
            defaultSelectedIndex: filterIndex,
            onApply: (filter, index) {
              filterIndex = index;
              setState(() {
                showingResult = !showingResult;
                this.filter = filter;
              });
            },
          );
        });
  }
}
