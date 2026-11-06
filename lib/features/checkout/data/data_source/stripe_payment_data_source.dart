import 'package:dio/dio.dart';
import 'package:tradly/core/env/env.dart';

class StripePaymentDataSource {
  final Dio dio;

  StripePaymentDataSource(this.dio);
  Future<String> createPaymentIntent({
    required int amount,
    required String currency,
  }) async {
    final response = await dio.post(
      "https://api.stripe.com/v1/payment_intents",
      options: Options(
        headers: {
          "Authorization": "Bearer ${Env.secretKey}",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      ),
      data: {"amount": amount, "currency": currency},
    );

    final clientSecret = response.data["client_secret"];

    if (clientSecret is! String || clientSecret.isEmpty) {
      throw Exception('Invalid client secret response');
    }

    return clientSecret;
  }
}
