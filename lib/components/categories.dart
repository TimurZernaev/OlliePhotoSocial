import 'package:flutter/material.dart';
import 'package:ollie_photo_social/constants.dart';

class Categories extends StatefulWidget {
  final void Function(int) setSelectedCategory;
  Categories({@required this.setSelectedCategory});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedCategoryIndex = 0;
  final categoryList = ['Yes or No', 'This or That', 'Multiple Choice'];

  Widget _buildCategory(BuildContext context, int index) {
    Function callback = widget.setSelectedCategory;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategoryIndex = index;
        });
        callback(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: appPadding / 2),
        decoration: BoxDecoration(
          color: selectedCategoryIndex == index ? orange : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            categoryList[index],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: white,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildCategoryList(BuildContext buildContext) {
    List<Widget> catList = new List<Widget>();
    for (int idx = 0; idx < categoryList.length; idx++) {
      catList.add(_buildCategory(buildContext, idx));
    }
    return catList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.04,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: buildCategoryList(context),
      ),
    );
  }
}
