import 'package:flutter/material.dart';

class CommonButtom extends StatefulWidget {
  const CommonButtom(
      {Key? key, this.height, this.onpress, this.width, this.color, this.child})
      : super(key: key);
  final height;
  final onpress;
  final width;
  final color;
  final child;

  @override
  State<CommonButtom> createState() => _CommonButtomState();
}

class _CommonButtomState extends State<CommonButtom> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: widget.child,
      onPressed: widget.onpress,
      height: widget.height,
      minWidth: widget.width,
      color: widget.color,
    );
  }
}
