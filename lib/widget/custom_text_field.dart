import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final bool isEnable;
  final Widget? icon;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final bool readOnly;
  final bool filled;

  const CustomTextFormField(
      {Key? key,
        this.controller,
        this.hintText,
        this.maxLines,
        this.isEnable = true,
        this.readOnly = false,
        this.filled = false,
        this.icon,
        this.textInputType,
        this.validator,
        this.focusNode,
        this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      cursorColor: Colors.black,
      enabled: isEnable,
      readOnly: readOnly,
      maxLines: maxLines ?? 1,
      controller: controller,
      focusNode: focusNode,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: Colors.grey.shade500),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, top: 0, bottom: 20),
        suffixIcon: icon,filled:filled ,fillColor:Colors.grey.shade100 ,
        alignLabelWithHint: true,
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: Colors.grey.shade500),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 0,
                style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 0,
                style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey, width: 0, style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 0,
                style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
      ),
      validator: validator,
      onTap: onTap,
    );
  }
}