import 'package:flutter/material.dart';
import 'package:invoicio/screens/customer_details.dart';
import 'package:invoicio/screens/sign_in_screen.dart';
import 'package:invoicio/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  const Image(
                      fit: BoxFit.cover,
                      height: 400.0,
                      width: double.infinity,
                      image: NetworkImage(
                          "https://img.freepik.com/free-photo/people-taking-photos-food_23-2149303520.jpg?size=626&ext=jpg")),
                  Positioned(
                    bottom: 150.0,
                    left: 100,
                    // right: 100,
                    child: Text(
                      "Welcome To\nInvoicio",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        overflow: TextOverflow.clip,
                        shadows: const [
                          BoxShadow(
                              color: Colors.black,
                              spreadRadius: 20.0,
                              blurRadius: 20.0)
                        ],
                        backgroundColor: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://img.freepik.com/free-vector/dreamy-floral-background_53876-92903.jpg?size=626&ext=jpg&ga=GA1.1.1779294316.1699536074&semt=sph',
                    ),
                    opacity: 0.6,
                    colorFilter: ColorFilter.srgbToLinearGamma(),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50.0),
                    const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextField(
                      cont: _usernameController,
                      hint: "Enter Your Username",
                      label: "Username",
                      icon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 10.0),
                      child: TextField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            child: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          hintText: "Enter Your Password",
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
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
                        String username = _usernameController.text;
                        String password = _passwordController.text;
                        if (username == 'Test' && password == 'Test') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.black,
                              content: Text(
                                'Logged in successfully.',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          );
                          Future.delayed(const Duration(milliseconds: 900), () {
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const CustomerDetailsScreen();
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
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.black,
                              content: Text(
                                'Invalid credentials. Please try again.',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                    const Divider(
                      height: 40.0,
                      color: Colors.black,
                      indent: 80.0,
                      endIndent: 80.0,
                      thickness: 1.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return const SignInScreen();
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
                      },
                      child: const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'New here?',
                              style: TextStyle(
                                  fontSize: 17.0, color: Colors.black),
                            ),
                            TextSpan(
                                text: ' Sign Up',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    textBaseline: TextBaseline.alphabetic)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 200.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
