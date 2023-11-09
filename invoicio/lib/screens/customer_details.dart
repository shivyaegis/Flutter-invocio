import 'package:flutter/material.dart';
import 'package:invoicio/screens/login_screen.dart';
import 'package:invoicio/screens/order_placing_screen.dart';
import 'package:invoicio/widgets/text_field.dart';

class CustomerDetailsScreen extends StatefulWidget {
  const CustomerDetailsScreen({super.key});

  @override
  createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tableNumberController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Customer Details'),
        centerTitle: true,
      ),
      drawer: buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Image(
              height: 200,
              width: double.infinity,
              image: NetworkImage(
                  'https://img.freepik.com/free-photo/handsome-vacation-people-waiting-bag_1150-1637.jpg?size=626&ext=jpg&ga=GA1.1.1779294316.1699536074&semt=ais'),
              fit: BoxFit.cover,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 300,
              decoration: const BoxDecoration(
                color: Colors.black26,
                image: DecorationImage(
                  image: NetworkImage(
                    'https://img.freepik.com/free-vector/gold-frame-with-foliage-pattern-marble-textured-background-vector_53876-109076.jpg?size=626&ext=jpg&ga=GA1.1.1779294316.1699536074&semt=ais',
                  ),
                  opacity: 0.6,
                  colorFilter: ColorFilter.srgbToLinearGamma(),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 130),
                  CustomTextField(
                    cont: _nameController,
                    hint: "Enter your name",
                    label: "Name",
                    icon: const Icon(Icons.person),
                  ),
                  CustomTextField(
                    cont: _tableNumberController,
                    hint: "Enter your table number",
                    label: "Table Number",
                    icon: const Icon(Icons.numbers),
                  ),
                  CustomTextField(
                    cont: _phoneNumberController,
                    hint: "Enter your phone number",
                    label: "Phone Number",
                    icon: const Icon(Icons.phone),
                  ),
                  CustomTextField(
                    cont: _addressController,
                    hint: "Enter your address",
                    label: "Address",
                    icon: const Icon(Icons.home),
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.resolveWith((states) {
                        // If the button is pressed, return green, otherwise blue
                        if (states.contains(MaterialState.pressed)) {
                          return const Size(150, 50);
                        }
                        return const Size(150, 50);
                      }),
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        // If the button is pressed, return green, otherwise blue
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.green;
                        }
                        return Colors.black;
                      }),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.black,
                          content: Text(
                            'Details saved successfully.',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      );
                      Future.delayed(const Duration(milliseconds: 900), () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return const OrderPlacingScreen();
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                      });
                    },
                    child: const Text(
                      'Save Details',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  // Add logic to load the user's profile photo
                  // You can replace the AssetImage with your actual photo logic
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?size=626&ext=jpg&ga=GA1.1.1779294316.1699536074&semt=sph'),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Shivam Sharma', // Replace with the actual user's name
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Customer Details'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const CustomerDetailsScreen();
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
          ListTile(
            leading: const Icon(Icons.restaurant),
            title: const Text('Menu Items'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const LoginScreen();
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
        ],
      ),
    );
  }
}
