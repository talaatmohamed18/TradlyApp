import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradly/features/cart/presentation/provider/cart_provider.dart';
import 'package:tradly/features/checkout/presentation/provider/stripe_payment_provider.dart';
import 'package:tradly/core/resourcses/routes_manager.dart';

class CheckoutButton extends ConsumerWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentStatus = ref.watch(stripePaymentProvider);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(36, 10, 36, 18),
      child: SizedBox(
        width: double.infinity,
        height: 38,
        child: ElevatedButton(
          onPressed: paymentStatus == PaymentStatus.loading
              ? null
              : () async {
                  await ref
                      .read(stripePaymentProvider.notifier)
                      .pay(
                        ref.read(cartProvider.notifier).totalPrice.toInt(),
                        "EGP",
                      );
                  ref.read(cartProvider.notifier).clearCart();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.homeScreen,
                    (route) => false,
                  );
                },
          style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
          child: paymentStatus == PaymentStatus.loading
              ? CircularProgressIndicator()
              : const Text(
                  'Pay now',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
