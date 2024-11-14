import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/app_assets.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key, required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppAssets.failureImage, width: 100, height: 200),
        const SizedBox(height: 10),
        Text(
          message,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
