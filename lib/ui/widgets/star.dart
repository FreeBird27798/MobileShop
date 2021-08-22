import 'package:flutter/material.dart';

class Star extends StatefulWidget {
  late bool isRated;

  Star({
    this.isRated = false,
  });

  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> {
  @override
  Widget build(BuildContext context) {

    return Icon(
      widget.isRated ? Icons.star : Icons.star_border,
      color: widget.isRated ? Colors.amber : Colors.grey,
      size: 20,
    );
  }
}
