// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_null_in_if_null_operators

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_manager/constants/assets.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/ui/shared/important_label_text.dart';

class CustomFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? label;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final TextEditingController? controller;
  final bool enabled;
  final double? contentPadding;
  final int maxLines;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool isOutlineBorder;
  final bool isImportant;
  final bool isInfinityField;
  final bool isInfinityValue;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final double bottomPadding;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final int? maxLength;
  final bool filled;
  final double? borderRadius;
  final Widget? suffixIcon;
  final Color? fillColor;

  const CustomFormField({
    Key? key,
    this.labelText,
    this.hintText,
    this.label,
    this.isImportant = false,
    this.isInfinityField = false,
    this.isInfinityValue = false,
    this.borderRadius = 15,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.isPasswordField = false,
    this.controller,
    this.enabled = true,
    this.contentPadding = 20,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
    this.isOutlineBorder = false,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.bottomPadding = 2.0,
    this.prefixIcon,
    this.focusNode,
    this.maxLength,
    this.filled = false,
    this.suffixIcon,
    this.fillColor,
  }) : super(key: key);
  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = true, showInfinity = false;

  @override
  void initState() {
    showInfinity = widget.isInfinityValue;
    if (showInfinity == true) {
      widget.controller!.text = "Upwards";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final underlineBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.4),
      ),
    );

    final enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: Colors.black12,
      ),
      borderRadius:
          BorderRadius.circular(double.parse(widget.borderRadius.toString())),
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: widget.bottomPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.label != null,
            child: widget.isImportant == false
                ? Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "${widget.label}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: ImportantLabelText(label: widget.label!),
                  ),
          ),
          TextFormField(
            validator: widget.validator,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  top: widget.hintText == null ? 14 : widget.contentPadding!,
                  bottom: widget.hintText == null ? 14 : widget.contentPadding!,
                  left: 10),
              labelText: widget.labelText ?? null,
              hintText: widget.hintText ?? null,
              hintStyle: TextStyle(
                color: Colors.black38,
                fontSize: 14,
              ),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black38,
                fontSize: 14,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Container(
                      width: 10,
                      padding: EdgeInsets.all(7),
                      child: Center(
                        child: widget.prefixIcon,
                      ),
                    )
                  : widget.icon != null
                      ? Icon(
                          widget.icon,
                        )
                      : null,
              enabledBorder: widget.filled ? enabledBorder : underlineBorder,
              suffixIcon: widget.isInfinityField
                  ? buildInfinityFieldToggle()
                  : widget.isPasswordField
                      ? _buildPasswordFieldVisibilityToggle()
                      : widget.suffixIcon,
              filled: widget.filled,
              fillColor: widget.fillColor ?? Color(0xFFF9FAFB),
            ),
            style: TextStyle(
              fontSize: 14,
            ),
            keyboardType: widget.keyboardType,
            cursorColor: Theme.of(context).primaryColor,
            obscureText: widget.isPasswordField ? _obscureText : false,
            controller: widget.controller,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            onTap: widget.onTap ?? () {},
            readOnly: showInfinity == false ? widget.readOnly : true,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            focusNode: widget.focusNode,
          ),
        ],
      ),
    );
  }

  Widget buildInfinityFieldToggle() {
    return InkWell(
      child: Container(
        width: 10,
        padding: EdgeInsets.all(7),
        child: Center(
            child: showInfinity == false
                ? Icon(
                    Icons.all_inclusive,
                    color: Colors.black38,
                    size: 16,
                  )
                : Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Icon(
                        Icons.all_inclusive,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  )),
      ),
      onTap: () {
        setState(() {
          showInfinity = !showInfinity;
          if (showInfinity == true) {
            widget.controller!.text = "Upwards";
          } else {
            widget.controller!.text = "";
          }
        });
      },
    );
  }

  Widget _buildPasswordFieldVisibilityToggle() {
    return InkWell(
      child: Container(
        width: 10,
        padding: EdgeInsets.all(7),
        child: Center(
            child: _obscureText
                ? SvgPicture.asset(
                    AppImages.eye,
                    height: 16,
                    width: 16,
                    color: Colors.grey[400],
                  )
                : SvgPicture.asset(
                    AppImages.eyeSlash,
                    height: 16,
                    width: 16,
                    color: Colors.grey[400],
                  )),
      ),
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }
}
