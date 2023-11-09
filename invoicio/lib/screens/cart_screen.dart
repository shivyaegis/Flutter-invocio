import 'package:flutter/material.dart';
import 'package:invoicio/screens/payment_screen.dart';

import 'order_placing_screen.dart';

class CartScreen extends StatefulWidget {
  final List<ShoppingCartItem> shoppingCart;

  const CartScreen({Key? key, required this.shoppingCart}) : super(key: key);

  @override
  createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double getTotalPrice() {
    double total = 0;
    for (var item in widget.shoppingCart) {
      total += (item.price * item.quantity);
    }
    return total;
  }

  double calculateGST(double total) {
    // You can replace this with your own GST calculation logic
    return total * 0.18;
  }

  double calculateVAT(double total) {
    // You can replace this with your own VAT calculation logic
    return total * 0.12;
  }

  double calculateApplicableCharges(double total) {
    // You can replace this with your own applicable charges calculation logic
    return total * 0.05;
  }

  @override
  Widget build(BuildContext context) {
    double total = getTotalPrice();
    double gst = calculateGST(total);
    double vat = calculateVAT(total);
    double applicableCharges = calculateApplicableCharges(total);
    double grandTotal = total + gst + vat + applicableCharges;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Your Cart'),
        centerTitle: true,
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
            if (widget.shoppingCart.isEmpty)
              const Center(
                child: Text(
                  'Your cart is empty.',
                  style: TextStyle(fontSize: 30),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: widget.shoppingCart.length,
                  itemBuilder: (context, index) {
                    final item = widget.shoppingCart[index];
                    return _buildCartItemCard(item);
                  },
                ),
              ),
            if (widget.shoppingCart.isNotEmpty) const SizedBox(height: 20),
            if (widget.shoppingCart.isNotEmpty)
              _buildOrderSummary(
                  total, gst, vat, applicableCharges, grandTotal),
            if (widget.shoppingCart.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return PaymentScreen(
                          amount: grandTotal,
                        );
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        var tween = Tween(begin: begin, end: end);
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: const Text('Proceed to Order'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemCard(ShoppingCartItem item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(item.name),
        subtitle: Text('Quantity: ${item.quantity}'),
        trailing: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
      ),
    );
  }

  Widget _buildOrderSummary(
    double total,
    double gst,
    double vat,
    double applicableCharges,
    double grandTotal,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        _buildOrderSummaryItem('Total Order Value', total),
        _buildOrderSummaryItem('GST (18%)', gst),
        _buildOrderSummaryItem('VAT (12%)', vat),
        _buildOrderSummaryItem('Applicable Charges (5%)', applicableCharges),
        const Divider(height: 20, color: Colors.white),
        _buildOrderSummaryItem('Grand Total', grandTotal, isTotal: true),
      ],
    );
  }

  Widget _buildOrderSummaryItem(String title, double value,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 18,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
