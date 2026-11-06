abstract class BaseViewModel with BaseViewModelInputs, BaseViewModelOutputs {
  // shared variables and functions that will be used across all view models
}

abstract mixin class BaseViewModelInputs {
  void start();

  void dispose();
}

abstract mixin class BaseViewModelOutputs {}
