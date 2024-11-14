import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/routes/extensions.dart';
import '../../core/routes/routes.dart';
import '../../core/utils/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  void navigateToHome() {
    Timer(const Duration(seconds: 3), () {
      context.pushReplacementNamed(Routes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppStrings.appName,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
