import 'package:flutter/material.dart';

class Star extends StatefulWidget {
  final double val;
  late bool isRated;

  Star({
    this.val = 0,
    this.isRated = false,
  });

  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> {
  @override
  Widget build(BuildContext context) {
    widget.isRated = widget.val == 1 || widget.val == 0.5;
    IconData icon = widget.val == 1
        ? Icons.star
        : widget.val == 0.5
            ? Icons.star_half
            : Icons.star_border;
    return Icon(
      icon,
      color: widget.isRated ? Colors.amber : Colors.grey,
      size: 20,
    );
  }
}
