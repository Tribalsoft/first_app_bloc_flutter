import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final ValueChanged<String> onChanged;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.onChanged,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      obscureText: isPassword,
      onChanged: onChanged,
    );
  }
}
