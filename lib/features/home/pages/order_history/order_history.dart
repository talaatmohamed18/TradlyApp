import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/resourcses/colors_manager.dart';
import '../../../../core/resourcses/strings_manager.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.orderHistory.tr(),
        style: TextStyle(color: ColorManager.black),
      ),
    );
  }
}
