import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradly/core/resourcses/colors_manager.dart';
import 'package:tradly/core/resourcses/strings_manager.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.store.tr(),
        style: TextStyle(color: ColorManager.black),
      ),
    );
  }
}
