import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/core/constants/image_constants.dart';
import 'package:flutter_expense_tracker/view/home_screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      ),
    );
    return Scaffold(
      body: Center(
        child: Image.asset(
          ImageConstants.splashLogo,
          height: 150,
        ),
      ),
    );
  }
}
