import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final bool big;

  Button({
    @required this.text,
    this.big = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: RaisedButton(
        child: Text(text),
        onPressed: () {},
      ),
    );
  }
}
