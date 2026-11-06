import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradly/core/utils/responsive.dart';
import 'package:tradly/core/resourcses/assets_manager.dart';
import 'package:tradly/core/resourcses/values_manager.dart';

class CardView extends StatelessWidget {
  const CardView({
    super.key,
    required this.image,
    required this.name,
    required this.onTap,
  });
  final String image;
  final String name;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.isCompact(context) ? 144 : 160,
      height: 210,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: AppSize.s1,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(image, fit: BoxFit.contain),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppPadding.p12,
                  AppPadding.p4,
                  AppPadding.p12,
                  0,
                ),
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p8,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ImageAssets.tAvatar,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "Tradly",
                          style: Theme.of(context).textTheme.bodyLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "26\$",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
