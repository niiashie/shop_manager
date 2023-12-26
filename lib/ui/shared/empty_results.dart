import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_manager/constants/assets.dart';

class CustomEmptyResults extends StatelessWidget {
  final String message;
  const CustomEmptyResults({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            AppImages.empty,
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            message,
            style: const TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
