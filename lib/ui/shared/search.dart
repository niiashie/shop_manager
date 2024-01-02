import 'package:flutter/material.dart';
import 'package:shop_manager/constants/colors.dart';
import 'package:shop_manager/ui/shared/custom_form_field.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String) onChanged;
  final double? width;
  final VoidCallback onTextCleared;
  final String? hintText;
  const SearchWidget(
      {Key? key,
      required this.searchController,
      required this.onChanged,
      this.width = 240,
      this.hintText = "Search",
      required this.onTextCleared})
      : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 50,
      child: CustomFormField(
          contentPadding: 2,
          controller: widget.searchController,
          suffixIcon: widget.searchController.text.isEmpty
              ? const Icon(
                  Icons.search,
                  color: AppColors.crudTextColor,
                  size: 18,
                )
              : IconButton(
                  onPressed: () {
                    widget.searchController.text = "";
                    setState(() {});
                    widget.onTextCleared();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: AppColors.crudTextColor,
                    size: 16,
                  )),
          hintText: widget.hintText,
          filled: true,
          fillColor: Colors.white,
          onChanged: (v) {
            widget.onChanged(v);
            setState(() {});
          }),
    );
  }
}

// class SearchWidget extends StatelessWidget {
//   final TextEditingController searchController;
//   final ValueChanged<String> onChanged;
//   final double? width;
//   final String? hintText;
//   const SearchWidget(
//       {Key? key,
//       required this.searchController,
//       required this.onChanged,
//       this.width = 240,
//       this.hintText = "Search"})
//       : super(key: key);

 
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: 52,
//       margin: const EdgeInsets.only(top: 4),
//       child: CustomFormField(
//           contentPadding: 10,
//           controller: searchController,
//           suffixIcon:  const Icon(
//             Icons.search,
//             color: AppColors.crudTextColor,
//             size: 16,
//           ),
//           hintText: hintText,
//           filled: true,
//           fillColor: Colors.white,
//           onChanged: onChanged),
//     );
//   }
// }
