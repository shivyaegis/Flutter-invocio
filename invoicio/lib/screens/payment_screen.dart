import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final double amount;

  const PaymentScreen({Key? key, required this.amount}) : super(key: key);

  @override
  createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    _showAlertDialog('Payment Successful', 'Payment ID: ${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _showAlertDialog(
        'Payment Failed', 'Error: ${response.code} - ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    _showAlertDialog('External Wallet', 'Wallet Name: ${response.walletName}');
  }

  void _startPayment() {
    debugPrint('${widget.amount}');
    final double amt = widget.amount * 83.29;
    String formattedString = amt.toStringAsFixed(2);
    double convertedDouble = double.parse(formattedString) * 100;
    int intValue = convertedDouble.toInt();

    var options = {
      'key': 'rzp_test_DJmF6voEJJ8l8L', // Replace with your Razorpay key
      'amount': intValue, // Amount should be in paise
      'name': 'Invoicio',
      'description': 'Payment for your awesome product',
      'prefill': {'contact': '1234567890', 'email': 'test@email.com'},
      'external': {
        'wallets': ['paytm'], // Optional, enable wallets like Paytm
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error during payment: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear(); // Clears the event listeners
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: const BoxDecoration(
          color: Colors.black26,
          image: DecorationImage(
            image: NetworkImage(
                'https://cdn.dribbble.com/users/1770290/screenshots/6183149/bg_79.gif'),
            opacity: 0.5,
            colorFilter: ColorFilter.srgbToLinearGamma(),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total Amount: \$${widget.amount.toStringAsFixed(2)}\n(in INR): ${double.parse((widget.amount * 83.29).toStringAsFixed(2))}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startPayment,
              child: const Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
