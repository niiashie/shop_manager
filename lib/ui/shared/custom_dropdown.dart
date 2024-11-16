import 'package:flutter/material.dart';
import 'package:shop_manager/ui/shared/important_label_text.dart';

import '../../../constants/colors.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final Widget? prefixIcon;
  final String hintText;
  final String? defaultValue;
  final String labelText;
  final bool? hasIcon;
  final Function(String?) onChanged;

  const CustomDropdown(
      {Key? key,
      required this.items,
      this.prefixIcon,
      required this.hintText,
      this.defaultValue,
      this.labelText = "",
      this.hasIcon = true,
      required this.onChanged})
      : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(widget.labelText,
        //     style: const TextStyle(
        //       color: Colors.grey,
        //       fontSize: 14,
        //     )),
        Visibility(
          visible: widget.labelText.isNotEmpty,
          child: ImportantLabelText(
            label: widget.labelText,
          ),
        ),
        Visibility(
          visible: widget.labelText.isNotEmpty,
          child: const SizedBox(
            height: 5,
          ),
        ),

        Container(
          width: double.infinity,
          height: 47,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(width: 1, color: Colors.grey[300]!)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                  visible: widget.hasIcon!,
                  replacement: const SizedBox(
                    width: 10,
                  ),
                  child: SizedBox(
                    width: 50,
                    height: 55,
                    child: Center(
                      child: widget.prefixIcon,
                    ),
                  )),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        hint: Text(widget.hintText,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black38)),
                        value: widget.defaultValue,
                        items: widget.items.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  color: AppColors.crudTextColor, fontSize: 12),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? val) {
                          widget.onChanged(val);
                          // viewModel.setSelectedNewRole(val!);
                        }),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
