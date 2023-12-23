import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';

class CustomCloseButton extends StatelessWidget {
  final double? size;
  final VoidCallback onTap;
  const CustomCloseButton({super.key, this.size = 20, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(size! / 2)),
      color: Colors.transparent,
      elevation: 2,
      child: InkWell(
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
              color: AppColors.primaryColor, shape: BoxShape.circle),
          child: Center(
            child: Icon(
              Icons.clear,
              size: size! / 2,
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
