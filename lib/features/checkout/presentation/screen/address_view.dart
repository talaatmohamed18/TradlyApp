import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tradly/features/checkout/domain/entity/address.dart';
import 'package:tradly/features/checkout/presentation/provider/address_provider.dart';
import 'package:tradly/features/checkout/presentation/provider/location_provider.dart';
import 'package:tradly/core/resourcses/colors_manager.dart';
import 'package:tradly/core/resourcses/strings_manager.dart';
import 'package:tradly/core/resourcses/values_manager.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  const AddAddressScreen({super.key});

  @override
  ConsumerState<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final streetAddressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    streetAddressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();

    super.dispose();
  }

  Future<void> getCurrentLocation() async {
    final position = await ref.read(locationProvider.future);

    if (position == null) {
      return;
    }

    final placemarks = await Geocoding().placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      return;
    }

    final place = placemarks.first;

    nameController.text = place.locality ?? '';
    phoneController.text = place.name ?? '';
    streetAddressController.text = place.street ?? '';
    cityController.text = place.administrativeArea ?? '';
    stateController.text = place.isoCountryCode ?? '';
    zipCodeController.text = place.postalCode ?? '';
  }

  void saveAddress() {
    final address = Address(
      name: nameController.text,
      phone: phoneController.text,
      streetAddress: stateController.text,
      city: cityController.text,
      state: stateController.text,
      zipCode: zipCodeController.text,
    );

    ref.read(addressProvider.notifier).addAddress(address);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addNewAddress.tr()),
        iconTheme: IconThemeData(color: ColorManager.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: getCurrentLocation,
                icon: const Icon(Icons.my_location),
                label: Text(AppStrings.useCurrentLocation.tr()),
              ),

              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: ColorManager.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSize.s24),
                    ),
                    borderSide: BorderSide(
                      color: ColorManager.primary,
                      width: AppSize.s1_5,
                    ),
                  ),
                ),
              ),

              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  labelStyle: TextStyle(color: ColorManager.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSize.s24),
                    ),
                    borderSide: BorderSide(
                      color: ColorManager.primary,
                      width: AppSize.s1_5,
                    ),
                  ),
                ),
              ),

              TextField(
                controller: streetAddressController,
                decoration: InputDecoration(
                  labelText: 'Street Address',
                  labelStyle: TextStyle(color: ColorManager.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSize.s24),
                    ),
                    borderSide: BorderSide(
                      color: ColorManager.primary,
                      width: AppSize.s1_5,
                    ),
                  ),
                ),
              ),

              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: TextStyle(color: ColorManager.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSize.s24),
                    ),
                    borderSide: BorderSide(
                      color: ColorManager.primary,
                      width: AppSize.s1_5,
                    ),
                  ),
                ),
              ),

              TextField(
                controller: stateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'State',
                  labelStyle: TextStyle(color: ColorManager.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSize.s24),
                    ),
                    borderSide: BorderSide(
                      color: ColorManager.primary,
                      width: AppSize.s1_5,
                    ),
                  ),
                ),
              ),

              TextField(
                controller: zipCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Zipcode',
                  labelStyle: TextStyle(color: ColorManager.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSize.s24),
                    ),
                    borderSide: BorderSide(
                      color: ColorManager.primary,
                      width: AppSize.s1_5,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveAddress,
                  child: Text(
                    AppStrings.saveAddress.tr(),
                    style: Theme.of(context).textTheme.displayLarge,
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
