import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.child, this.onTap})
      : super(key: key);
  final Widget? child;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: const BoxDecoration(
            color: Color(0xff05690e),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
