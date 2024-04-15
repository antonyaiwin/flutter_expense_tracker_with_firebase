import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/controller/database_controller.dart';
import 'package:flutter_expense_tracker/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'core/constants/color_constants.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DatabaseController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: ColorConstants.black26,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorConstants.black26.withOpacity(0.4),
              ),
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
