import 'package:flutter/material.dart';
import 'package:tradly/core/resourcses/values_manager.dart';

class TitleWithSeeAllBtn extends StatelessWidget {
  final String title;
  final String btnTitle;
  final Function() btnPress;

  const TitleWithSeeAllBtn({
    super.key,
    required this.title,
    required this.btnTitle,
    required this.btnPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p16,
        left: AppPadding.p16,
        right: AppPadding.p12,
        bottom: AppPadding.p12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          SizedBox(
            width: 95,
            height: 25,
            child: ElevatedButton(
              onPressed: btnPress,
              child: Text(
                btnTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
