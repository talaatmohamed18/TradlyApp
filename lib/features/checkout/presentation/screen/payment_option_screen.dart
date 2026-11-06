import 'package:flutter/material.dart';

import '../widgets/payment_methods.dart';
import '../widgets/delivery_address.dart';
import '../widgets/price_details.dart';
import '../widgets/checkout_button.dart';

class PaymentOptionScreen extends StatelessWidget {
  const PaymentOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        backgroundColor: const Color(0xff359884),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Payment Option',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  PaymentMethods(),

                  DeliveryAddress(),

                  PriceDetails(),
                ],
              ),
            ),
          ),

          CheckoutButton(),
        ],
      ),
    );
  }
}
