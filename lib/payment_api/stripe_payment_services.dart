import 'package:stripe_payment/stripe_payment.dart';

class StripeServices {
  //Stripe payment API variables
  final String _currentSecret =
      'sk_test_51JIOKcBvtwxGXPVddTdgl0rRcXidwOK9bcu8SmZBDwiObo23VNrFU9xo3X1WKUsBaqssDzVN7Etq644cQimEx40Z00LjaeZHkW';
  final String _publishableKey =
      'pk_test_51JIOKcBvtwxGXPVdOlojQ9Mfq1ysKOjP9MRdhqKWv3NEMPabSyh3cwv3y2GSzqSN307RXDvJbGtwYzM35oH3iTQk00Z0OEro90';

  void initializeStripePayment() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: _publishableKey,
        merchantId: "Your_Merchant_id",
        androidPayMode: 'test'));
  }
}