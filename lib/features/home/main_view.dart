import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradly/features/browse/presentation/screens/browse_page.dart';
import 'package:tradly/features/products/presentation/screen/home_screen.dart';
import 'package:tradly/core/resourcses/routes_manager.dart';
import '../../core/resourcses/colors_manager.dart';
import '../../core/resourcses/strings_manager.dart';
import '../../core/resourcses/values_manager.dart';
import 'pages/order_history/order_history.dart';
import 'pages/profile/profile_page.dart';
import 'pages/store/store_page.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomeScreen(),
    const BrowsePage(),
    const StorePage(),
    const OrderHistoryPage(),
    const ProfilePage(),
  ];
  List<String> titles = [
    AppStrings.tradly.tr(),
    AppStrings.browse.tr(),
    AppStrings.store.tr(),
    AppStrings.orderHistory.tr(),
    AppStrings.profile.tr(),
  ];
  var _title = AppStrings.tradly.tr();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(_title, style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.wishListScreen);
            },
            icon: const Icon(Icons.favorite),
            color: ColorManager.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.checkOutScreen);
            },
            icon: const Icon(Icons.shopping_cart),
            color: ColorManager.white,
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: ColorManager.grey, spreadRadius: AppSize.s0),
          ],
        ),
        child: BottomNavigationBar(
          iconSize: AppSize.s30,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppStrings.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: AppStrings.browse.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: AppStrings.store.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: AppStrings.orderHistory.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: AppStrings.profile.tr(),
            ),
          ],
          backgroundColor: ColorManager.white,
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
