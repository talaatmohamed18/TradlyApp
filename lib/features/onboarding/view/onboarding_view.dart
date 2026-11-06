import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradly/core/utils/app_prefs.dart';
import 'package:tradly/core/di/di.dart';
import 'package:tradly/features/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:tradly/core/resourcses/assets_manager.dart';
import 'package:tradly/core/resourcses/colors_manager.dart';
import 'package:tradly/core/resourcses/routes_manager.dart';
import 'package:tradly/core/resourcses/strings_manager.dart';
import 'package:tradly/core/resourcses/values_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final PageController _pageController = PageController();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  void _bind() {
    _appPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.primary,
        appBar: AppBar(
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.primary,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: sliderViewObject.numOfSlides,
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
          itemBuilder: (context, index) {
            return OnboardingPage(sliderObject: sliderViewObject.sliderObject);
          },
        ),
        bottomSheet: _getBottomSheetWiget(sliderViewObject),
      );
    }
  }

  Widget _getBottomSheetWiget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p6),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                ),
            ],
          ),
          const SizedBox(height: AppSize.s35),
          SizedBox(
            width: 320,
            height: 50,
            child: _getProperButton(
              sliderViewObject.currentIndex,
              sliderViewObject,
            ),
          ),
          const SizedBox(height: AppSize.s12),
        ],
      ),
    );
  }

  SvgPicture _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.solidCircleIcon);
    } else {
      return SvgPicture.asset(ImageAssets.hollowCircleIcon);
    }
  }

  Widget _getProperButton(int index, SliderViewObject sliderViewObject) {
    if (index == sliderViewObject.numOfSlides - 1) {
      return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
        },
        child: Text(
          AppStrings.finish.tr(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          _pageController.animateToPage(
            _viewModel.goNext(),
            curve: Curves.linearToEaseOut,
            duration: const Duration(milliseconds: 250),
          );
        },
        child: Text(
          AppStrings.next.tr(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
  }
}

class OnboardingPage extends StatelessWidget {
  final SliderObject sliderObject;

  const OnboardingPage({super.key, required this.sliderObject});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: ColorManager.primary,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: ColorManager.white,
              ),
            ),
          ],
        ),
        Positioned(
          left: AppSize.s42,
          right: AppSize.s42,
          top: 50,
          bottom: 250,
          child: Container(
            padding: const EdgeInsets.only(
              top: AppPadding.p40,
              bottom: AppPadding.p18,
            ),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(AppSize.s14),
              ),
            ),
            child: SvgPicture.asset(sliderObject.image),
          ),
        ),
        Positioned(
          top: 470,
          bottom: 0,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
            child: Text(
              sliderObject.title.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
      ],
    );
  }
}
