import 'package:flutter/material.dart';
import 'package:tradly/features/home/pages/category/view/category_view.dart';
import 'package:tradly/core/resourcses/colors_manager.dart';

class CategoriesWidget extends StatelessWidget {
  final String category;
  final String image;
  const CategoriesWidget({
    super.key,
    required this.category,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.primary.withAlpha(180),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CategoryView(category: category),
            ),
          );
        },
        child: Stack(
          children: [
            Center(
              child: Image.network(
                image,
                alignment: AlignmentGeometry.center,
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: Text(
                category,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
