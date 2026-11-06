import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradly/core/utils/responsive.dart';
import 'package:tradly/core/utils/app_prefs.dart';
import 'package:tradly/core/di/di.dart';
// import 'package:tradly/core/utils/local_data_source.dart';
import 'package:tradly/core/resourcses/assets_manager.dart';
import 'package:tradly/core/resourcses/routes_manager.dart';
import '../../../../core/resourcses/colors_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  // final LocalDataSource _localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Column(children: [Container(height: 260, color: ColorManager.primary)]),
        Positioned(
          left: Responsive.horizontalPadding(context),
          right: Responsive.horizontalPadding(context),
          top: 50,
          child: Row(
            children: [
              SvgPicture.asset(ImageAssets.tAvatar, width: 70, height: 70),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(
                      'Tradly Team',
                      style: Theme.of(context).textTheme.displayLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '+1 9998887776',
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'info@tradly.co',
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 288,
          width: Responsive.width(context) - 32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Edit Profile',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(
                onPressed: () {
                  _changelanguage();
                },
                child: Text(
                  'Language & Currency',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Feedback',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Refer a Friend',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Terms & Conditions',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(
                onPressed: () {
                  _logout();
                },
                child: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _changelanguage() {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  void _logout() {
    _appPreferences.logOut();
    // _localDataSource.clearCache();
    Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
  }
}
