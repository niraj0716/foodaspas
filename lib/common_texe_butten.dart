import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonTexeButten extends StatefulWidget {
  const CommonTexeButten({
    Key? key,
    this.color,
    this.text,
    this.size,
    this.width,
    this.height,
    this.shape,
    this.elevation,
    this.splashColor,
    this.texeColor,
    this.focusColor,
    this.texe,
    required this.onPressed,
    this.style,
    this.child,
  }) : super(key: key);
  final text;
  final color;
  final onPressed;
  final size;
  final style;
  final width;
  final height;
  final shape;
  final elevation;
  final splashColor;
  final texeColor;
  final focusColor;
  final texe;
  final child;

  @override
  State<CommonTexeButten> createState() => _CommonTexeButtenState();
}

class _CommonTexeButtenState extends State<CommonTexeButten> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: widget.height,
      minWidth: widget.width,
      color: widget.color,
      elevation: widget.elevation,
      splashColor: widget.splashColor,
      textColor: widget.texeColor,
      focusColor: widget.focusColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text(
        widget.texe,
        style: widget.style,
      ),
      onPressed: widget.onPressed,
    );
  }
}
