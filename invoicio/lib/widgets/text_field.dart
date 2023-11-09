import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController cont;
  final String label;
  final String hint;
  final Icon icon;
  const CustomTextField(
      {super.key,
      required this.cont,
      required this.hint,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          fillColor: Colors.black,
          labelText: label,
          prefixIcon: icon,
          hintText: hint,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}
