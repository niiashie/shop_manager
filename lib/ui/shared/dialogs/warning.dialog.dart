import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_manager/constants/assets.dart';
import 'package:shop_manager/constants/fonts.dart';
import 'package:shop_manager/ui/shared/custom_button.dart';

class WarningDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final bool? hasCancel;
  final String? okayText;
  final String? cancelText;
  final VoidCallback onCancelTapped;
  final VoidCallback onOkayTapped;
  const WarningDialog({
    super.key,
    this.title = 'Warning',
    this.message = '',
    this.hasCancel = true,
    this.okayText,
    this.cancelText,
    required this.onCancelTapped,
    required this.onOkayTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
          width: 400,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              LottieBuilder.asset(
                AppImages.warningAnim,
                width: 70,
                height: 70,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: AppFonts.poppinsMedium,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                message!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: hasCancel!,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                        width: 100,
                        height: 40,
                        elevation: 2,
                        color: Colors.amber.shade500,
                        title: Text(
                          okayText!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        ontap: () {
                          onOkayTapped();
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(cancelText!),
                              ),
                            ),
                            onTap: () {
                              onCancelTapped();
                            },
                          ))
                    ],
                  ))
            ],
          )),
    );
  }
}
