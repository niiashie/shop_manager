import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/constants/fonts.dart';

class HomeItem extends StatelessWidget {
  final String? title;
  final String? value;
  const HomeItem({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      elevation: 2,
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 7, bottom: 7),
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Text(
                    title!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15, bottom: 15),
                child: Text(
                  value!,
                  style: const TextStyle(
                      fontFamily: AppFonts.poppinsBold, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
