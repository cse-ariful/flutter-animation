import 'package:flutter/material.dart';
import 'package:flutter_animation/components/image_widget.dart';
import 'package:flutter_animation/components/shimmer_container.dart';
import 'package:flutter_animation/models/category_model.dart';
import 'package:sizer/sizer.dart';

class HomeCategoryItem extends StatelessWidget {
  const HomeCategoryItem({Key key, @required this.item}) : super(key: key);
  final CategoryModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey.shade200,
            ),
            child: InkWell(
              onTap: () {},
              splashColor: Colors.green,
              customBorder: CircleBorder(),
              child: Container(
                height: 48,
                width: 48,
                padding: EdgeInsets.all(4),
                child: KImage(
                  url: item.image,
                ),
              ),
            ),
          ),
          Text(
            "${item.title}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 8.0.sp),
          )
        ],
      ),
    );
  }
}

class HomeCategoryShimmerItem extends StatelessWidget {
  const HomeCategoryShimmerItem({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ShimmerContainer(
      baseColor: Colors.white,
      highlightColor: Colors.black,
      child: Column(
        children: [
          Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey.shade300,
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: SizedBox(
                height: 16,
                width: 16,
              ),
            ),
          ),
          SizedBox(height: 6),
          Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.grey.shade300,
            ),
            height: 12,
            width: 32,
          )
        ],
      ),
    );
  }
}
