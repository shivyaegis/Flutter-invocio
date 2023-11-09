import 'dart:math';

import 'package:flutter/material.dart';
import 'package:invoicio/screens/cart_screen.dart';

class ShoppingCartItem {
  final String name;
  final double price;
  int quantity;

  ShoppingCartItem({
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}

class OrderPlacingScreen extends StatefulWidget {
  const OrderPlacingScreen({Key? key}) : super(key: key);

  @override
  createState() => _OrderPlacingScreenState();
}

class _OrderPlacingScreenState extends State<OrderPlacingScreen> {
  String selectedCategory = 'Appetizers';
  String selectedList = 'appetizers';
  List<Map<String, dynamic>> appetizers = [
    {'name': 'Salad', 'icon': Icons.local_dining, 'price': getRandomPrice()},
    {'name': 'Coffee', 'icon': Icons.local_cafe, 'price': getRandomPrice()},
  ];
  List<Map<String, dynamic>> maincourse = [
    {'name': 'Burger', 'icon': Icons.fastfood, 'price': getRandomPrice()},
    {'name': 'Pizza', 'icon': Icons.local_pizza, 'price': getRandomPrice()},
    {'name': 'Sushi', 'icon': Icons.water, 'price': getRandomPrice()},
  ];
  List<Map<String, dynamic>> desserts = [
    {
      'name': 'Vanilla Ice Cream',
      'icon': Icons.icecream,
      'price': getRandomPrice()
    },
    {
      'name': 'Chocolate Ice Cream',
      'icon': Icons.icecream,
      'price': getRandomPrice()
    },
    {
      'name': 'Butterscotch Ice Cream',
      'icon': Icons.icecream,
      'price': getRandomPrice()
    },
    {'name': 'Choco Lava Cake', 'icon': Icons.cake, 'price': getRandomPrice()},
    {'name': 'Custome Cake', 'icon': Icons.cake, 'price': getRandomPrice()},
  ];

  static double getRandomPrice() {
    return (Random().nextDouble() * 2.0) + 1.0;
  }

  List<ShoppingCartItem> shoppingCart = [];

  void addToCart(String name, double price) {
    setState(() {
      bool itemExists = false;
      for (var item in shoppingCart) {
        if (item.name == name) {
          item.quantity++;
          itemExists = true;
          break;
        }
      }
      if (!itemExists) {
        shoppingCart.add(ShoppingCartItem(name: name, price: price));
      }

      // Show Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 500),
          backgroundColor: Colors.black,
          content: Text('$name added to cart'),
        ),
      );
    });
  }

  void clearCart() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Cart'),
          content: const Text('Are you sure you want to clear the cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  shoppingCart.clear();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  int getCartItemCount() {
    int itemCount = 0;
    for (var item in shoppingCart) {
      itemCount += item.quantity;
    }
    return itemCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Menu'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onLongPress: () {
              clearCart();
            },
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return CartScreen(shoppingCart: shoppingCart);
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
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return CartScreen(shoppingCart: shoppingCart);
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
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      getCartItemCount().toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildCategoryList(),
            const SizedBox(height: 20),
            const Text(
              'Menu Items',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildItemsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryCard('Appetizers'),
          _buildCategoryCard('Main Course'),
          _buildCategoryCard('Desserts'),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String categoryName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = categoryName;
          selectedList = categoryName.replaceAll(' ', '').toLowerCase();
        });
      },
      child: Container(
        color: selectedCategory == categoryName ? Colors.green : Colors.white,
        width: 100.0,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(categoryName),
          ),
        ),
      ),
    );
  }

  Widget _buildItemsList() {
    List<Map<String, dynamic>> selectedCategoryList = [];

    switch (selectedList) {
      case "appetizers":
        selectedCategoryList = appetizers;
        break;
      case "maincourse":
        selectedCategoryList = maincourse;
        break;
      case "desserts":
        selectedCategoryList = desserts;
        break;
      default:
        selectedCategoryList = [];
    }

    return Expanded(
      child: ListView.builder(
        itemCount: selectedCategoryList.length,
        itemBuilder: (context, index) {
          return _buildMenuItemCard(
            name: selectedCategoryList[index]['name'],
            icon: selectedCategoryList[index]['icon'],
            price: selectedCategoryList[index]['price'],
          );
        },
      ),
    );
  }

  Widget _buildMenuItemCard(
      {required String name, required IconData icon, required double price}) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('\$${price.toStringAsFixed(2)}'),
            IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                addToCart(name, price);
              },
            ),
          ],
        ),
        leading: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}
