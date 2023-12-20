import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';

class SideMenuItem extends StatelessWidget {
  final String title;
  final bool? selected;
  final VoidCallback onTap;
  final bool? isExpanded;
  final IconData icon;
  final Function(bool) onHover;
  const SideMenuItem(
      {super.key,
      required this.title,
      this.selected = false,
      required this.icon,
      required this.onTap,
      required this.onHover,
      this.isExpanded = true});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: selected == true
                    ? AppColors.primaryColor
                    : Colors.grey[400]),
            child: isExpanded == true
                ? Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: selected == true
                                    ? AppColors.primaryColor
                                    : Colors.grey[200]),
                            child: Center(
                              child: Icon(
                                icon,
                                size: 15,
                                color: selected == true
                                    ? Colors.white
                                    : AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: selected == true
                                  ? "PoppinsMedium"
                                  : "PoppinsLight",
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                : Center(
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selected == true
                              ? AppColors.primaryColor
                              : Colors.grey[200]),
                      child: Center(
                        child: Icon(
                          icon,
                          size: 15,
                          color: selected == true
                              ? Colors.white
                              : AppColors.primaryColor,
                        ),
                      ),
                    ),
                  )),
        onHover: (value) {
          onHover(value);
        },
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
