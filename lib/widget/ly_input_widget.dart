import 'package:flutter/material.dart';

/// 带图标的输入框

class LYInputWidget extends StatefulWidget {
  final bool obscureText;
  final String? hintText;
  final Widget? iconData;
  final ValueChanged<String>? onChanged;
  final TextStyle? textStyle;
  final TextEditingController? controller;

  const LYInputWidget(
      {Key? key,
        this.hintText,
        this.iconData,
        this.onChanged,
        this.textStyle,
        this.controller,
        this.obscureText = false}): super(key: key);

  @override
  _LYInputWidgetState createState() => _LYInputWidgetState();
}

class _LYInputWidgetState extends State<LYInputWidget>{
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      style: widget.textStyle,
      decoration: InputDecoration(
        hintText: widget.hintText,
        icon: widget.iconData,
      ),
    );
  }
}