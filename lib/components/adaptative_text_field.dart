import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextfield extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final TextInputType keyboardType;

  const AdaptativeTextfield({
    @required this.label,
    @required this.controller,
    @required this.onSubmitted,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
              // decoration: BoxDecoration(
              //   border: Border(
              //     bottom: BorderSide(width: 1),
              //   ),
              // ),
              controller: controller,
              onSubmitted: onSubmitted,
              placeholder: label,
              keyboardType: keyboardType,
            ),
          )
        : TextField(
            decoration: InputDecoration(labelText: label),
            controller: controller,
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
          );
  }
}
