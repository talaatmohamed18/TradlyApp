import 'dart:async';

import 'package:tradly/core/base_viewmodel/baseviewmodel.dart';
import 'package:tradly/core/resourcses/assets_manager.dart';
import 'package:tradly/core/resourcses/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  List<SliderObject> _getSliderData() => [
    SliderObject(ImageAssets.onboardingLogo1, AppStrings.onBoardingTitle1),
    SliderObject(ImageAssets.onboardingLogo2, AppStrings.onBoardingTitle2),
    SliderObject(ImageAssets.onboardingLogo3, AppStrings.onBoardingTitle3),
  ];

  void _postDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(_list[_currentIndex], _list.length, _currentIndex),
    );
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);
}

abstract mixin class OnBoardingViewModelInputs {
  int goNext();
  int goPrevious();
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract mixin class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}

class SliderObject {
  String image;
  String title;

  SliderObject(this.image, this.title);
}
