import 'package:flutter/material.dart';

class SortFilterBottomSheet extends StatefulWidget {
  SortFilterBottomSheet(
      {Key key, @required this.defaultSelectedIndex, @required this.onApply})
      : super(key: key);

  final int defaultSelectedIndex;
  final Function(String sortType, int index) onApply;

  @override
  _SortFilterBottomSheetState createState() => _SortFilterBottomSheetState();
}

class _SortFilterBottomSheetState extends State<SortFilterBottomSheet> {
  int groupValue;
  String sortFilter;

  @override
  void initState() {
    groupValue = widget.defaultSelectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    "Filter Products",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.blueAccent),
                  ),
                ),
                /* FlatButton(
                  onPressed: () {
                    widget.onApply(sortFilter);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Apply",
                    style: themeTextStyle(context)
                        .button
                        .copyWith(color: Colors.blueAccent),
                  ),
                )*/
              ],
            ),
          ),
          RadioListTile(
              value: 0,
              groupValue: groupValue,
              onChanged: (value) => applyFilter(null, value),
              title: Text("default")),
          RadioListTile(
              value: 1,
              groupValue: groupValue,
              onChanged: (value) => applyFilter("original_price", value),
              title: Text("Price - Low to High")),
          RadioListTile(
              value: 2,
              groupValue: groupValue,
              onChanged: (value) => applyFilter("-original_price", value),
              title: Text("Price - High to Low")),
          RadioListTile(
              value: 3,
              groupValue: groupValue,
              onChanged: (value) => applyFilter("-rating", value),
              title: Text("Rating - High to Low")),
        ],
      ),
    );
  }

  void applyFilter(String query, int index) {
    widget.onApply(query, index);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void groupValueChanged(value, filter) {
    this.setState(() {
      groupValue = value;
      sortFilter = filter;
    });
  }
}
